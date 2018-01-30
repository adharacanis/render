package geometry;

import gl.bufferContext.data.DataComponent;
import haxe.io.Bytes;

class Position extends DataComponent 
{
	public static var __size:Int = 4 + 4;
	
	public var x:Float = 0;
	public var y:Float = 0;
	
	public function new(x:Int = 0, y:Int = 0) 
	{
		super();
		
		this.x = x;
		this.y = y;
	}
	
	override public function write(dataSource:Bytes, position:Int):Int 
	{
		dataSource.setFloat(position, x);
		position += 4;
		dataSource.setFloat(position, y);
		position += 4;
		
		trace('write position');
		
		return position;
	}
	
}