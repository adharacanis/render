package gl.bufferContext;

import haxe.io.Bytes;

class IndexBuffer implements IBuffer
{
	var size:UInt;
	var layoutSize:UInt;
	var context:BufferContext;
	
	@:allow(gl) private var internalBuffer:InternalBuffer;
	@:allow(gl) private var type:BufferType = BufferType.INDEX_BUFFER;
	@:allow(gl) private var usage:BufferUsage = BufferUsage.STATIC;
	
	@:allow(BufferContext)
	public function new(size:UInt, layoutSize:UInt, internalBuffer:InternalBuffer, context:BufferContext) 
	{
		this.internalBuffer = internalBuffer;
		this.context = context;
		this.layoutSize = layoutSize;
		this.size = size;
	}
	
	public inline function uploadFromArray(value:Array<UInt>, offset:UInt = 0, length:UInt = 0)
	{
		context.uploadBufferFromArray16(this, value, offset, length);
	}
	
	public function uploadFromBytes(value:Bytes)
	{
		
	}
	
	public function dispose()
	{
		context.disposeBuffer(this);
	}
}