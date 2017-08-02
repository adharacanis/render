precision highp float;
precision highp int;

uniform mediump vec4 viewProjection;
uniform mediump vec2 padding;

attribute vec4 a_geometry;
attribute vec2 a_uv;

varying mediump vec2 uv;

void main(void) 
{
	uv = a_uv;
	
	vec4 outPosition = vec4(padding, 0, 0) + a_geometry;
	gl_Position = vec4(outPosition.xy * viewProjection.xy + viewProjection.zw, a_geometry.zw);
}