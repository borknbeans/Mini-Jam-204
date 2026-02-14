shader_type canvas_item;

const int STATE_NOTHING = 0;
const int STATE_CORRECT = 1;
const int STATE_PARTIAL = 2;
const int STATE_NOT_USED = 3;

uniform int current_state;

uniform vec4 grey_color : source_color = vec4(0.188, 0.202, 0.212, 1.0);
uniform vec4 yellow_color : source_color = vec4(0.578, 0.468, 0.087, 1.0);
uniform vec4 green_color : source_color = vec4(0.13, 0.397, 0.15, 1.0);

void fragment() {
	if (current_state == STATE_NOTHING) {
		// Do nothing
	} else if (current_state == STATE_CORRECT) {
		COLOR.rgb = green_color.rgb;
		COLOR.a = green_color.a;
	} else if (current_state == STATE_PARTIAL) {
		COLOR.rgb = yellow_color.rgb;
		COLOR.a = yellow_color.a;
	} else if (current_state == STATE_NOT_USED) {
		COLOR.rgb = grey_color.rgb;
		COLOR.a = grey_color.a;
	}
}
