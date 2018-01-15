package gl.bufferContext;

import gl.bufferContext.BufferUsage;
import gl.bufferContext.BufferType;

class BaseBuffer implements IBuffer
{
	var UID:Int = 0;
	var id:Int;
	
	var size:UInt;
	
	@:allow(gl) private var isInitialize:Bool = false;
	@:allow(gl) private var isDirty:Bool = true;
	@:allow(gl) private var isBufferInUse:Bool = false;
	
	@:allow(gl) private var type:BufferType = BufferType.VERTEX_BUFFER;
	@:allow(gl) private var usage:BufferUsage = BufferUsage.STREAM;
	
	var data:Array<Float> = new Array();
	
	public function new(type:BufferType, usage:BufferUsage) 
	{
		this.type = type;
		this.usage = usage;
		id = UID++;
	}
	
	inline public function initialize():Void 
	{
		isInitialize = true;
	}
	
	inline public function hashCode():Int 
	{
		return id;
	}
	
}