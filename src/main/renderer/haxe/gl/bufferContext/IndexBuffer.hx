package gl.bufferContext;

import gl.bufferContext.VertexData;
import gl.bufferContext.buffer.BufferData;
import haxe.io.Bytes;

class IndexBuffer implements IBuffer
{
	var size:Int;
	var context:BufferContext;
	
	@:allow(gl) private var internalBuffer:InternalBuffer;
	@:allow(gl) private var type:BufferType = BufferType.INDEX_BUFFER;
	@:allow(gl) private var usage:BufferUsage = BufferUsage.STATIC;
	
	public function new(size:Int) 
	{
		this.size = size;
	}
	
	
	/* INTERFACE gl.bufferContext.IBuffer */
	
	public var data:BufferData;
	
	/* INTERFACE gl.bufferContext.IBuffer */
	
	public var isReadyForGL:Bool;
	
	public var vertexData:VertexData;
	
	public var stride:Int;
}