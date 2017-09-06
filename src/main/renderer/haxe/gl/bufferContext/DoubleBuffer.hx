package gl.bufferContext;

class DoubleBuffer 
{
	var buffer1:InternalBuffer;
	var buffer2:InternalBuffer;
	
	var currentBuffer:InternalBuffer;
	
	public function new(buffer1:InternalBuffer, buffer2:InternalBuffer) 
	{
		this.buffer1 = buffer1;
		this.buffer2 = buffer2;
		
		this.currentBuffer = buffer1;
	}
	
	inline public function getBuffer():InternalBuffer
	{
		return currentBuffer;
	}
	
	inline public function swapBuffer()
	{
		if (currentBuffer == buffer1)
			currentBuffer = buffer2;
		else
			currentBuffer = buffer1;
	}
	
}