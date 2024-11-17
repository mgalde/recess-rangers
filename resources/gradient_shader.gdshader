shader_type canvas_item;

void fragment() {
	vec3 top_color = vec3(0.8, 0.4, 0.2);
	vec3 middle_color = vec3(0.95, 0.7, 0.4);
	vec3 bottom_color = vec3(0.7, 0.5, 0.3);
	
	float t = UV.y;
	vec3 color;
	
	if (t < 0.5) {
		color = mix(top_color, middle_color, t * 2.0);
	} else {
		color = mix(middle_color, bottom_color, (t - 0.5) * 2.0);
	}
	
	COLOR = vec4(color, 1.0);
}
