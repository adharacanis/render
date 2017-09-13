package gl.bufferContext;

import haxe.io.Bytes;
import js.html.Float32Array;

class VertexBuffer implements IBuffer
{
	var size:UInt;
	var layoutSize:UInt;
	var context:BufferContext;
	
	@:allow(gl) private var doubleBuffer:DoubleBuffer;
	@:allow(gl) private var internalBuffer:InternalBuffer;
	@:allow(gl) private var type:BufferType = BufferType.VERTEX_BUFFER;
	@:allow(gl) private var usage:BufferUsage = BufferUsage.STREAM;
	
	@:allow(BufferContext)
	public function new(size:UInt, layoutSize:UInt, doubleBuffer:DoubleBuffer, context:BufferContext) 
	{
		this.doubleBuffer = doubleBuffer;
		this.internalBuffer = doubleBuffer.getBuffer();
		
		var size2 = 1000000 * 2 * 4;
		var size1 = size * 2 * 4;
		var currentSize = size2;
		
		context.useBuffer(type, doubleBuffer.buffer1);
		context.context.allocateBuffer(type, currentSize, usage);
		
		context.useBuffer(type, doubleBuffer.buffer2);
		context.context.allocateBuffer(type, currentSize, usage);
		
		context.useBuffer(type, doubleBuffer.buffer3);
		context.context.allocateBuffer(type, currentSize, usage);
		
		this.context = context;
		this.layoutSize = layoutSize;
		this.size = size;
	}
	
	public function swapBuffer()
	{
		doubleBuffer.swapBuffer();
		internalBuffer = doubleBuffer.getBuffer();
	}
	
	@:overload( function( value:js.html.Float32Array) : Void {} )
	@:overload( function( value:js.html.Float32Array, offset:UInt = 0, length:UInt = 0) : Void {} )
	public inline function uploadFromArray2(value:Array<Float>, offset:UInt = 0, length:UInt = 0)
	{
		context.uploadBufferFromArray2(this, value, offset, length);
	}
	
	@:overload( function( value:Float32Array) : Void {} )
	@:overload( function( value:Float32Array, offset:UInt, length:UInt) : Void {} )
	public inline function uploadFromArray(value:Array<Float>, offset:UInt = 0, length:UInt = 0)
	{
		context.uploadBufferFromArray(this, value, offset, length);
	}
	
	public inline function mapAttributes(locationToBind:Int, size:Int, attributeType:AttributeType, normalized:Bool = false, stride:Int = 0, offset:Int = 0)
	{
		context.mapAttributes(this, locationToBind, size, attributeType, normalized, stride, offset);
		//context.mapDoubleAttributes(this, doubleBuffer.buffer1, doubleBuffer.buffer2, locationToBind, size, attributeType, normalized, stride, offset);
	}
	
	public function uploadFromBytes(value:Bytes)
	{
		
	}
	
	public function dispose()
	{
		context.disposeBuffer(this);
	}
}