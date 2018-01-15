package gl;

import assets.BinaryAsset;
import events.Event;
import events.Observer;
import gl.bufferContext.BufferContext;
import gl.bufferContext.IBuffer;
import gl.bufferContext.IBufferContext;
import gl.bufferContext.VertexBuffer;

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
	
	public function disposeBuffer(buffer:IBuffer):Void 
	{
		bufferContext.disposeBuffer(buffer);
	}
	
	public function useBuffer(buffer:IBuffer) {
		bufferContext.useBuffer(buffer);
	}
	
}