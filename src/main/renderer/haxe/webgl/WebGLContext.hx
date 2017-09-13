package webgl; #if html5

import gl.IGLContext;
import gl.bufferContext.AttributeType;
import gl.bufferContext.BufferType;
import gl.bufferContext.BufferUsage;
import gl.bufferContext.InternalBuffer;
import js.Browser;
import js.html.CanvasElement;
import js.html.Float32Array;
import js.html.Uint16Array;
import js.html.webgl.ExtensionInstancedArrays;
import js.html.webgl.RenderingContext;

class WebGLContext implements IGLContext 
{
	static public var gl:RenderingContext;
	static public var instancedExtension:ExtensionInstancedArrays;
	var canvas:CanvasElement;

	public function new() 
	{
			
	}
	
	public function update(offset:Int, count:Int):Void
	{
		gl.clearColor(0, 0, 0, 1);
		//gl.colorMask(false, false, false, true);
		gl.clear(RenderingContext.COLOR_BUFFER_BIT);
		
		if(Main.instanced == false)
			gl.drawElements(RenderingContext.TRIANGLES, 6 * count, RenderingContext.UNSIGNED_SHORT, 0);
		else
			instancedExtension.drawElementsInstancedANGLE(RenderingContext.TRIANGLES, 6, RenderingContext.UNSIGNED_SHORT, 0, count);
			
			//Main.instancesCount += 10;
		//trace(Main.instancesCount);
	}
	
	public function request()
	{
		canvas = cast Browser.document.getElementById("gameview");  
		var renderingContext = canvas.getContextWebGL({alpha: false,
			antialias: false,
			depth: false,
			premultipliedAlpha: false,
			preserveDrawingBuffer: false,
			stencil: false
		});
		
		//#if debug
		//gl = untyped __js__("WebGLDebugUtils.makeDebugContext({0})", renderingContext);
		//#else
		gl = renderingContext;
		//#end
		
		instancedExtension = gl.getExtension('ANGLE_instanced_arrays');
		trace("instanced extension " + instancedExtension);
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
	
	public inline function uploadBufferData16(type:BufferType, data:Array<UInt>, usage:BufferUsage)
	{
		//trace("upload uint 16", type, usage);
		gl.bufferData(type, new Uint16Array(data), usage);
	}
	
	public inline function orphangeBuffer(type:BufferType, usage:BufferUsage)
	{
		gl.bufferData(type, 0, usage);
	}
	
	public inline function uploadBufferData(type:BufferType, data:Array<Float>, usage:BufferUsage)
	{
		gl.bufferData(type, new Float32Array(data), usage);
	}
	
	public inline function uploadBufferSubData(type:BufferType, data:Array<Float>, offset:UInt):Void 
	{
		gl.bufferSubData(type, offset, new Float32Array(data));
	}
	
	public inline function enableVertexAttribArray(locationToBind:Int)
	{
		gl.enableVertexAttribArray(locationToBind);
	}
	
	public inline function vertexAttribPointer(locationToBind:Int, size:Int, attributeType:AttributeType, normalized:Bool = false, stride:Int = 0, offset:Int = 0)
	{
		gl.vertexAttribPointer(locationToBind, size, attributeType, normalized, stride, offset);
	}
}
#end