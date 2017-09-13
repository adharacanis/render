precision highp float;
precision highp int;

varying mediump vec2 uv;
varying mediump vec4 color;

uniform lowp sampler2D texture;

void main(void) 
{
	//gl_FragColor = vec4(1.0 * uv.x, 1.0 * uv.y, 0, 1.0);
	vec4 sampleColor = texture2D(texture, uv);
	
	//if(sampleColor.rgb == vec3(0.0, 0.0, 0.0))
		discard; 
		
	gl_FragColor = sampleColor * color;
}