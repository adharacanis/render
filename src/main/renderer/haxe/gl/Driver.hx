package gl;

import assets.BinaryAsset;
import events.Event;
import events.Observer;
import gl.bufferContext.BufferContext;
import gl.bufferContext.IBuffer;
import gl.bufferContext.IBufferContext;
import gl.bufferContext.buffer.VertexBuffer;

class Driver extends Observer implements IBufferContext
{
	var context:Context;
	public var bufferContext:BufferContext;
	
	public function new() 
	{
		super();
		
		context = new Context();
		
		bufferContext = new BufferContext(context);
	}
	
	public function requestContext()
	{
		context.request();
		dispatchEvent(new Event(Event.COMPLETE));
	}
	
	public function update(offset:Int, count:Int):Void
	{
		context.update(offset, count);
	}
	
	
	/* INTERFACE gl.bufferContext.IBufferContext */
	
	public function disposeBuffer(buffer:IBuffer):Void 
	{
		
	}
	
	public function uploadBufferFromArray(buffer:IBuffer, value:Array<Float>, offset:UInt = 0, length:UInt = 0):Void 
	{
		
	}
	
	public function createVertexBuffer(size:UInt, registersPerVertex:UInt):VertexBuffer 
	{
		return null;
	}
}