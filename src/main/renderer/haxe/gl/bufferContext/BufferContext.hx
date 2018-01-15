package gl.bufferContext;

import gl.Context;
import gl.bufferContext.InternalBuffer;
import haxe.ds.Vector;

class BufferContext implements IBufferContext 
{
	public var context:Context;
	public var usedVertexBuffersList:Vector<IBuffer> = new Vector(20);
	
	var bufferManager:BaseBufferManager;

	public function new(context:Context) 
	{
		this.context = cast context;
		this.bufferManager = new SimpleBufferManager(context);
	}
	
	@:allow(gl) public function disposeBuffer(buffer:IBuffer):Void
	{
		
	}
	
	inline function uploadBufferFromArray2(buffer:IBuffer, value:Array<Float>, offset:UInt = 0, length:UInt = 0)
	{
		/*var type:BufferType = buffer.type;
		var usage:BufferUsage = buffer.usage;
		
		useBuffer(type, buffer.internalBuffer);
		
		var size:UInt;
		
		if (length == 0)
			size = value.length;
			
		if(offset == 0)
			context.uploadBufferSubData(type, value, offset);
		else
			context.uploadBufferSubData(type, value, offset);*/
	}
	
	@:overload( function( buffer:IBuffer, value:Array<UInt>, offset:UInt = 0, length:UInt = 0 ) : Void {} )
	inline public function uploadBufferFromArray(buffer:IBuffer, value:Array<Float>, offset:UInt = 0, length:UInt = 0)
	{
		/*var type:BufferType = buffer.type;
		var usage:BufferUsage = buffer.usage;
		
		useBuffer(type, buffer.internalBuffer);
		
		var size:UInt;
		
		if (length == 0)
			size = value.length;
			
		if(offset == 0)
			context.uploadBufferData(type, value, usage);
		else
			context.uploadBufferSubData(type, value, offset);
			*/
	}
	
	inline function uploadBufferFromArray16(buffer:IBuffer, value:Array<UInt>, offset:UInt = 0, length:UInt = 0)
	{
		/*var type:BufferType = buffer.type;
		var usage:BufferUsage = buffer.usage;
		
		useBuffer(type, buffer.internalBuffer);
		
		var size:UInt;
		
		if (length == 0)
			size = value.length;
			
		if(offset == 0)
			context.uploadBufferData16(type, value, usage);*/
	}
	
	public inline function mapAttributes(buffer:IBuffer, locationToBind:Int, size:Int, attributeType:AttributeType, normalized:Bool = false, stride:Int = 0, offset:Int = 0)
	{
		useBuffer(buffer);
		context.enableVertexAttribArray(locationToBind);
		context.vertexAttribPointer(locationToBind, size, attributeType, normalized, stride, offset);
	}
	
	public inline function useBuffer(buffer:IBuffer)
	{
		bufferManager.useBuffer(buffer);
	}
}