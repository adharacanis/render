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
	
	public function update():Void
	{
		context.update();
	}
	
	public function disposeBuffer(buffer:IBuffer):Void 
	{
		bufferContext.disposeBuffer(buffer);
	}
	
	public function uploadBufferFromArray16(buffer:IBuffer, value:Array<UInt>, offset:UInt = 0, length:UInt = 0):Void 
	{
		bufferContext.uploadBufferFromArray16(buffer, value, offset, length);
	}
	
	public function uploadBufferFromArray(buffer:IBuffer, value:Array<Float>, offset:UInt = 0, length:UInt = 0):Void 
	{
		bufferContext.uploadBufferFromArray(buffer, value, offset, length);
	}
	
	public inline function createVertexBuffer(size:UInt, registersPerVertex:UInt):VertexBuffer 
	{
		return bufferContext.createVertexBuffer(size, registersPerVertex);
	}
	
}