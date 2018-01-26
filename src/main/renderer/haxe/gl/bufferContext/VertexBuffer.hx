package gl.bufferContext;

import haxe.io.Bytes;

class VertexBuffer extends BaseBuffer
{
	var layoutSize:UInt;
	
	public function new(size:UInt = 0, layoutSize:UInt = 0) 
	{
		super(BufferType.VERTEX_BUFFER, BufferUsage.STREAM);
		
		this.layoutSize = layoutSize;
		this.size = size;
	}
	
	
	inline function uploadFromArray2(value:Array<Float>, offset:UInt = 0, length:UInt = 0)
	{
		//context.uploadBufferFromArray2(this, value, offset, length);
	}
	
	inline function uploadFromArray(value:Array<Float>, offset:UInt = 0, length:UInt = 0)
	{
		//context.uploadBufferFromArray(this, value, offset, length);
	}
	
	public inline function mapAttributes(locationToBind:Int, size:Int, attributeType:AttributeType, normalized:Bool = false, stride:Int = 0, offset:Int = 0)
	{
		//context.mapAttributes(this, locationToBind, size, attributeType, normalized, stride, offset);
	}
	
	public function uploadFromBytes(value:Bytes)
	{
		
	}
	
	public function dispose()
	{
		
	}
}