extends Button

@onready var file_dialog = $"../FileDialog"
@onready var list_container = $"../ScrollContainer/VBoxContainer" 
@onready var metadata_helper = $"../MetadataHelper"

@onready var export_button = $"../ExportButton"
@onready var export_dialog = $"../ExportDialog"
@onready var progress_bar = $"../ProgressBar"


var loaded_songs: PackedStringArray = []
var export_thread: Thread

func _ready():
	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILES
	file_dialog.file_selected.connect(_on_file_selected)
	file_dialog.files_selected.connect(_on_files_selected)
	

	export_dialog.access = FileDialog.ACCESS_FILESYSTEM
	

	export_dialog.current_dir = "/" 
	

	export_button.pressed.connect(_on_export_button_pressed)
	export_dialog.dir_selected.connect(_on_export_dir_selected)

func _on_pressed():
	file_dialog.show()

func _on_file_selected(path: String):
	_on_files_selected([path])

func _on_files_selected(paths: PackedStringArray):
	loaded_songs = paths 
	
	for child in list_container.get_children():
		child.queue_free()
		
	var regex = RegEx.new()
	regex.compile("^\\d{2}[\\s_.-]*")
		
	for path in paths:
		var file_name = path.get_file().get_basename()
		print("DEBUG - Original Name: ", file_name)
		
		file_name = regex.sub(file_name, "")
		print("DEBUG - Cleaned Name: ", file_name)

		var metadata = metadata_helper.call("GetFlacData", path)
		
		var row = HBoxContainer.new()
		var art_rect = TextureRect.new()
		
		if metadata != null and metadata.has("art") and metadata["art"] != null:
			art_rect.texture = metadata["art"]
		
		art_rect.custom_minimum_size = Vector2(50, 50) 
		art_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		art_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
		
		var text_label = Label.new()
		
		if metadata != null:
			var artist = metadata.get("artist", "Unknown Artist")
			var album = metadata.get("album", "Unknown Album")
			
			text_label.text = str(file_name, "    ", artist, " - ", album)
		else:
			text_label.text = str(file_name, " (Metadata failed)")
			
		print("DEBUG - Final Label Text: ", text_label.text)
			
		text_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		text_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		text_label.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS 
		
		row.add_child(art_rect)
		row.add_child(text_label)
		list_container.add_child(row)

# --- NEW EXPORT LOGIC ---

func _on_export_button_pressed():
	if loaded_songs.size() > 0:
		export_dialog.show()
	else:
		print("Inga låtar valda")

func _on_export_dir_selected(sd_card_path: String):
	print("Startar", sd_card_path)
	
	export_button.disabled = true
	
	progress_bar.max_value = loaded_songs.size()
	progress_bar.value = 0
	progress_bar.show()
	
	export_thread = Thread.new()
	export_thread.start(_run_background_export.bind(sd_card_path, loaded_songs.duplicate()))

func _run_background_export(sd_card_path: String, songs_to_export: PackedStringArray):
	var regex = RegEx.new()
	regex.compile("^\\d{2}[\\s\\-_\\.]*")
	
	for path in songs_to_export:
		var original_name = path.get_file().get_basename()
		var clean_name = regex.sub(original_name, "")
		
		var metadata = metadata_helper.call("GetFlacData", path)
		
		var artist = sanitize_filename(metadata["artist"])
		var album = sanitize_filename(metadata["album"])
		
		var target_folder = sd_card_path + "/" + artist + "/" + album
		DirAccess.make_dir_recursive_absolute(target_folder)
		
		var target_flac = target_folder + "/" + clean_name + ".flac"
		DirAccess.copy_absolute(path, target_flac) 
		
		if metadata.has("art") and metadata["art"] != null:
			if not metadata["art"].resource_path.ends_with("icon.svg"):
				var target_jpg = target_folder + "/" + clean_name + ".jpg"
				var image = metadata["art"].get_image()
				image.save_jpg(target_jpg, 0.8) 
				
		call_deferred("_update_progress")
				

	call_deferred("_on_export_finished")


func _update_progress():
	progress_bar.value += 1


func _on_export_finished():
	export_thread.wait_to_finish() 
	export_button.disabled = false 
	print("Export Complete!")


func sanitize_filename(text: String) -> String:
	var bad_chars = ["/", "\\", ":", "*", "?", "\"", "<", ">", "|"]
	var clean = text
	for c in bad_chars:
		clean = clean.replace(c, "_")
	return clean.strip_edges()
