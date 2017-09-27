package gl.bufferContext;

import gl.bufferContext.InternalBuffer;
import gl.bufferContext.buffer.BufferData;

interface IBuffer 
{
	@:allow(gl) private var type:BufferType;
	@:allow(gl) private var usage:BufferUsage;
	
	@:allow(gl) private var vertexData:VertexData;
	@:allow(gl) private var stride:Int;
	
	@:allow(gl) private var data:BufferData;
	
	@:allow(gl) private var internalBuffer:InternalBuffer;
	@:allow(gl) private var isReadyForGL:Bool;
}