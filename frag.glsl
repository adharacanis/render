precision highp float;
precision highp int;

varying mediump vec2 uv;

uniform lowp sampler2D texture;

void main(void) 
{
	//gl_FragColor = vec4(1.0 * uv.x, 1.0 * uv.y, 0, 1.0);
	gl_FragColor = texture2D(texture, uv);
}