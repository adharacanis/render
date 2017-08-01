attribute vec4 geometry;
uniform mediump vec2 padding;

void main(void) {
	gl_Position = geometry + vec4(padding, 0, 0);
}