package gl.bufferContext;

import haxe.io.Bytes;

class UniformBuffer extends BaseBuffer
{
	
	public function new(size:UInt, layoutSize:UInt, doubleBuffer:DoubleBuffer, context:BufferContext) 
	{
		super(BufferType.UNIFORM_BUFFER, BufferUsage.STREAM);
	}
	
	public inline function uploadFromArray2(value:Array<Float>, offset:UInt = 0, length:UInt = 0)
	{
		
	}
	
	public inline function uploadFromArray(value:Array<Float>, offset:UInt = 0, length:UInt = 0)
	{
		
	}
	
	public inline function mapAttributes(locationToBind:Int, size:Int, attributeType:AttributeType, normalized:Bool = false, stride:Int = 0, offset:Int = 0)
	{
		
	}
	
	public function uploadFromBytes(value:Bytes)
	{
		
	}
	
	public function dispose()
	{
		
	}
}