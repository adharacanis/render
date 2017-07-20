package gl.bufferContext;

import gl.bufferContext.InternalBuffer;

interface IBuffer 
{
	@:allow(gl) private var internalBuffer:InternalBuffer;
	@:allow(gl) private var type:BufferType;
	@:allow(gl) private var usage:BufferUsage;
}