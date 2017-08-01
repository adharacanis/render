package gl.bufferContext;

import gl.Context;
import gl.bufferContext.InternalBuffer;

class BufferContext implements IBufferContext 
{
	public var context:Context;
	
	public var currentInternalBuffer:InternalBuffer;

	public function new(context:Context) 
	{
		this.context = cast context;
	}
	
	public inline function createIndexBuffer(size:UInt, registersPerVertex:UInt):IndexBuffer
	{
		var intenralBuffer:InternalBuffer = context.createBuffer();
		var vertexBuffer:IndexBuffer = new IndexBuffer(size, registersPerVertex, intenralBuffer, this);
		
		return vertexBuffer;
	}
	
	public inline function createVertexBuffer(size:UInt, registersPerVertex:UInt):VertexBuffer
	{
		var intenralBuffer:InternalBuffer = context.createBuffer();
		var vertexBuffer:VertexBuffer = new VertexBuffer(size, registersPerVertex, intenralBuffer, this);
		
		return vertexBuffer;
	}
	
	@:allow(gl) public function disposeBuffer(buffer:IBuffer):Void
	{
		var internalBuffer:InternalBuffer = buffer.internalBuffer;
		context.disposeBuffer(internalBuffer);
	}
	
	@:overload( function( buffer:IBuffer, value:Array<UInt>, offset:UInt = 0, length:UInt = 0 ) : Void {} )
	public inline function uploadBufferFromArray(buffer:IBuffer, value:Array<Float>, offset:UInt = 0, length:UInt = 0)
	{
		var type:BufferType = buffer.type;
		var usage:BufferUsage = buffer.usage;
		
		useBuffer(type, buffer.internalBuffer);
		
		var size:UInt;
		
		if (length == 0)
			size = value.length;
			
		if(offset == 0)
			context.uploadBufferData(type, value, usage);
		else
			context.uploadBufferSubData(type, value, offset);
	}
	
	public inline function uploadBufferFromArray16(buffer:IBuffer, value:Array<UInt>, offset:UInt = 0, length:UInt = 0)
	{
		var type:BufferType = buffer.type;
		var usage:BufferUsage = buffer.usage;
		
		useBuffer(type, buffer.internalBuffer);
		
		var size:UInt;
		
		if (length == 0)
			size = value.length;
			
		if(offset == 0)
			context.uploadBufferData16(type, value, usage);
	}
	
	public inline function mapAttributes(buffer:IBuffer, locationToBind:Int, size:Int, attributeType:AttributeType, normalized:Bool = false, stride:Int = 0, offset:Int = 0)
	{
		useBuffer(buffer.type, buffer.internalBuffer);
		context.enableVertexAttribArray(locationToBind);
		context.vertexAttribPointer(locationToBind, size, attributeType, normalized, stride, offset);
	}
	
	private inline function useBuffer(type:BufferType, buffer:InternalBuffer)
	{
		if (currentInternalBuffer == buffer)
			return;
			
		currentInternalBuffer = buffer;
		
		context.useBuffer(type, buffer);
	}
}