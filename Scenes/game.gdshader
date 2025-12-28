shader_type canvas_item;

uniform float darken_strength : hint_range(0.0, 1.0) = 0.7;

void fragment() {
    vec4 original_color = texture(TEXTURE, UV);
    vec3 dark_color = vec3(0.0, 0.0, 0.0);

    vec3 mixed_color = mix(original_color.rgb, dark_color, darken_strength);
    
    COLOR = vec4(mixed_color, original_color.a);
}
