using Godot;
using System;

public partial class MetadataHelper : Node
{
	public Godot.Collections.Dictionary GetFlacData(string path)
	{
		var dict = new Godot.Collections.Dictionary();
		
		dict["artist"] = "Unknown Artist";
		dict["album"] = "Unknown Album";
		dict["art"] = GD.Load<Texture2D>("res://icon.svg"); // Default Godot icon
		
		try 
		{
			// Read the audio file using TagLib
			var file = TagLib.File.Create(path);
			
			// Overwrite defaults if the FLAC file has tags
			if (file.Tag.FirstPerformer != null) dict["artist"] = file.Tag.FirstPerformer;
			if (file.Tag.Album != null) dict["album"] = file.Tag.Album;
			
			if (file.Tag.Pictures.Length > 0)
			{
				var pic = file.Tag.Pictures[0];
				byte[] imgData = pic.Data.Data;
				var image = new Godot.Image();
				
				if (pic.MimeType == "image/jpeg" || pic.MimeType == "image/jpg")
					image.LoadJpgFromBuffer(imgData);
				else if (pic.MimeType == "image/png")
					image.LoadPngFromBuffer(imgData);
					
				dict["art"] = ImageTexture.CreateFromImage(image);
			}
		}
		catch (Exception e)
		{
			GD.PrintErr("Metadata read error: " + e.Message);
		}
		
		return dict;
	}
}
