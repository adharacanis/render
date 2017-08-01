void main(void) {
	//gl_FragColor = vec4(1, 0, 0, 1);
	gl_FragColor = vec4(gl_FragCoord.x / 768.0, gl_FragCoord.y / 768.0, 0, 1);
}