package webgl; #if html5

import gl.IGLContext;
import gl.bufferContext.BufferType;
import gl.bufferContext.BufferUsage;
import gl.bufferContext.InternalBuffer;
import js.Browser;
import js.html.CanvasElement;
import js.html.webgl.RenderingContext;

class WebGLContext implements IGLContext 
{
	static var gl:RenderingContext;
	var canvas:CanvasElement;

	public function new() 
	{
		
	}
	
	public function update():Void
	{
		gl.drawElements(RenderingContext.TRIANGLES, 2, RenderingContext.UNSIGNED_SHORT, 0);
	}
	
	public function request()
	{
		canvas = cast Browser.document.getElementById("gameview");  
		gl = canvas.getContextWebGL();
	}
	
	public inline function createBuffer():InternalBuffer
	{
		return gl.createBuffer();
	}
	
	public inline function disposeBuffer(buffer:InternalBuffer)
	{
		gl.deleteBuffer(buffer);
	}
	
	public inline function useBuffer(type:BufferType, buffer:InternalBuffer)
	{
		gl.bindBuffer(type, buffer);
	}
	
	public inline function uploadBufferData(type:BufferType, data:Array<Float>, usage:BufferUsage)
	{
		gl.bufferData(type, data, usage);
	}
	
	public inline function uploadBufferSubData(type:BufferType, value:Array<Float>, offset:UInt):Void 
	{
		gl.bufferSubData(type, offset, value);
	}
}
#end