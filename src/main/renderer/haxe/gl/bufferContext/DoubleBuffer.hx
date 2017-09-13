package gl.bufferContext;

class DoubleBuffer 
{
	public var buffer1:InternalBuffer;
	public var buffer2:InternalBuffer;
	public var buffer3:InternalBuffer;
	
	var currentBuffer:InternalBuffer;
	
	var index:Int = 0;
	var maxIndex:Int = 2;
	
	public function new(buffer1:InternalBuffer, buffer2:InternalBuffer, buffer3:InternalBuffer) 
	{
		this.buffer1 = buffer1;
		this.buffer2 = buffer2;
		this.buffer3 = buffer3;
		
		this.currentBuffer = buffer1;
	}
	
	inline public function getBuffer():InternalBuffer
	{
		return currentBuffer;
	}
	
	inline public function swapBuffer()
	{
		index += 2;
		if (index > maxIndex)
			index = 0;
			
		switch(index)
		{
			case 0: currentBuffer = buffer1;
			case 1: currentBuffer = buffer2;
			case 2: currentBuffer = buffer3;
			default: currentBuffer = buffer1;
		}
	}
	
}