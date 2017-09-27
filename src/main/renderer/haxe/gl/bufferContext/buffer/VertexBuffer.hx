package gl.bufferContext.buffer;

import gl.bufferContext.VertexData;

class VertexBuffer implements IBuffer
{
	var verticesCount:Int;
	var vertexData:VertexData;
	var stride:Int;	
	var context:BufferContext;
	var data:BufferData;
	
	@:allow(gl) private var internalBuffer:InternalBuffer;
	@:allow(gl) private var type:BufferType = BufferType.VERTEX_BUFFER;
	@:allow(gl) private var usage:BufferUsage = BufferUsage.STREAM;
	
	@:allow(gl) private var isReadyForGL:Bool = false;
	
	public function new(verticesCount:Int = 0, vertexData:VertexData) 
	{
		this.verticesCount = verticesCount;
		this.vertexData = vertexData;
	}
	
	public function toString():String 
	{
		return '[VertexBuffer(verticesCount=${verticesCount}, vertexData=${vertexData})]';
	}
}