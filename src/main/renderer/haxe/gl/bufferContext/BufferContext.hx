package gl.bufferContext;

import gl.Context;
import gl.bufferContext.IBuffer;
import gl.bufferContext.InternalBuffer;
import gl.bufferContext.buffer.VertexBuffer;

class BufferContext implements IBufferContext 
{
	public var context:Context;
	
	public var currentInternalBuffer:InternalBuffer;
	public var currentBuffer:IBuffer;
	
	private var bufferMapper:BuferMapper;

	public function new(context:Context) 
	{
		this.context = cast context;
		bufferMapper = new BuferMapper(context);
	}
	
	public inline function bindBuffer(buffer:IBuffer)
	{
		if (currentBuffer == buffer)
			return;
			
		if (buffer.isReadyForGL == false)
			prepareBuffer(buffer);
		
		useBuffer(buffer.type, buffer.internalBuffer);
		bufferMapper.mapBuffer(buffer);
		currentBuffer = buffer;
		//context.uploadBufferData(buffer.type, buffer.vertexData.content, buffer.usage);
	}
	
	inline function prepareBuffer(buffer:IBuffer) 
	{
		var internalBuffer = context.createBuffer();
		buffer.isReadyForGL = true;
		buffer.internalBuffer = internalBuffer;
	}
	
	public inline function useBuffer(type:BufferType, buffer:InternalBuffer)
	{
		if (currentInternalBuffer == buffer)
			return;
			
		currentInternalBuffer = buffer;
		
		context.useBuffer(type, buffer);
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