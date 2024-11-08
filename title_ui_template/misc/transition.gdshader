shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0) = 0.0;
uniform float edge : hint_range(0.0, 1.0) = 0.05;
uniform bool inverse = false;
uniform sampler2D rule : source_color;

void fragment() {
	vec2 uv = SCREEN_UV;
	float alpha = texture(rule, uv).r;

	if (inverse) {
		alpha = 1.0 - alpha;
	}

	float t = progress * (1.0 + edge);
	alpha = smoothstep(t - edge, t, alpha);

	COLOR.a *= alpha;
}
