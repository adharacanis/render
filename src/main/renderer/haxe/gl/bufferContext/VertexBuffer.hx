package gl.bufferContext;

import haxe.io.Bytes;

class VertexBuffer implements IBuffer
{
	var size:UInt;
	var layoutSize:UInt;
	var context:BufferContext;
	
	@:allow(gl) private var internalBuffer:InternalBuffer;
	@:allow(gl) private var type:BufferType = BufferType.VERTEX_BUFFER;
	@:allow(gl) private var usage:BufferUsage = BufferUsage.STATIC;
	
	@:allow(BufferContext)
	public function new(size:UInt, layoutSize:UInt, internalBuffer:InternalBuffer, context:BufferContext) 
	{
		this.internalBuffer = internalBuffer;
		this.context = context;
		this.layoutSize = layoutSize;
		this.size = size;
	}
	
	public inline function uploadFromArray(value:Array<Float>, offset:UInt = 0, length:UInt = 0)
	{
		context.uploadBufferFromArray(this, value, offset, length);
	}
	
	public inline function mapAttributes(locationToBind:Int, size:Int, attributeType:AttributeType, normalized:Bool = false, stride:Int = 0, offset:Int = 0)
	{
		context.mapAttributes(this, locationToBind, size, attributeType, normalized, stride, offset);
	}
	
	public function uploadFromBytes(value:Bytes)
	{
		
	}
	
	public function dispose()
	{
		context.disposeBuffer(this);
	}
}