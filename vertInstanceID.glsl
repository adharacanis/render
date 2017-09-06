precision highp float;
precision highp int;

uniform mediump vec4 viewProjection;


//uniform mediump vec2 padding;
uniform mediump vec2 animation;

attribute mediump vec2 padding;
attribute vec4 a_geometry_xy_1;

attribute vec2 a_uv;
attribute vec4 a_color;
attribute float id;

varying mediump vec2 uv;
varying mediump vec4 color;

void main(void) 
{
	uv = a_uv;
	color = a_color * id;
	
	vec4 outPosition = vec4(padding + animation, 0, 0) + a_geometry;
	gl_Position = vec4(outPosition.xy * viewProjection.xy + viewProjection.zw, a_geometry.zw);
}