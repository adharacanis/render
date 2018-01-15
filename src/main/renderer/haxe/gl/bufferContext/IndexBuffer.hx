package gl.bufferContext;

import haxe.io.Bytes;

class IndexBuffer extends BaseBuffer
{
	public function new(size:UInt) 
	{
		super(BufferType.INDEX_BUFFER, BufferUsage.STATIC);
		
		this.size = size;
	}
	
	public inline function uploadFromArray(value:Array<UInt>, offset:UInt = 0, length:UInt = 0)
	{
		//context.uploadBufferFromArray16(this, value, offset, length);
	}
	
	public function uploadFromBytes(value:Bytes)
	{
		
	}
	
	public function dispose()
	{
		
	}
}