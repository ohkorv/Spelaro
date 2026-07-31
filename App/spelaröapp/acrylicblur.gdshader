shader_type canvas_item;

uniform float blur_amount : hint_range(0.0, 5.0) = 2.5;
uniform vec4 tint_color : source_color = vec4(0.1, 0.1, 0.1, 0.6); // Acrylic dark/light tint
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    // Sample the screen behind the node with a blur (mipmap LOD)
    vec4 blurred_screen = textureLod(SCREEN_TEXTURE, SCREEN_UV, blur_amount);
    
    // Blend the blurred background with a translucent tint color for the acrylic look
    COLOR = mix(blurred_screen, tint_color, tint_color.a);
}