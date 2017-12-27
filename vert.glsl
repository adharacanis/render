precision highp float;
precision highp int;

uniform mediump vec4 viewProjection;


uniform mediump vec4 padding[251];
uniform mediump vec2 animation;

//attribute mediump vec2 padding;
attribute vec4 a_geometry;
attribute vec2 a_uv;
attribute vec4 a_color;
attribute vec4 id;

varying mediump vec2 uv;
varying mediump vec4 color;

vec2 getPaddingValue(vec4 vertex, int index);

void main(void) 
{
	uv = a_uv;
	color = a_color + (id / 502.0);
	int column = int(id.x);
	int row = int(id.y);
	vec4 paddingVector = padding[column];
	
	vec2 currentPadding = getPaddingValue(paddingVector, row);
	//vec2 currentPadding = vec2(padding[u_id].xy);
	
	vec4 outPosition = vec4(currentPadding, 0, 0) + a_geometry;
	gl_Position = vec4(outPosition.xy * viewProjection.xy + viewProjection.zw, a_geometry.zw);
}

vec2 getPaddingValue(vec4 vertex, int index) {
	if(index == 0)
		return vertex.xy;
	if(index == 1)
		return vertex.zw;
}