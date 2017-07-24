attribute vec3 geometry;

void main(void) {
	gl_Position = vec4(geometry, 1.0);
}