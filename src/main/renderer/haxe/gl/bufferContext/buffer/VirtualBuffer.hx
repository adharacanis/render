package gl.bufferContext.buffer;

import gl.bufferContext.BufferUsage;

import gl.bufferContext.BufferType;
import gl.bufferContext.IBuffer;
import gl.bufferContext.InternalBuffer;

class VirtualBuffer implements IBuffer 
{
	public var internalBuffer:InternalBuffer;
	public var type:BufferType;
	public var usage:BufferUsage;
	
	public function new() 
	{
		
	}
}