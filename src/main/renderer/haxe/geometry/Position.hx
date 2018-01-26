package geometry;

import gl.bufferContext.data.DataComponent;
import haxe.io.Bytes;

class Position extends DataComponent 
{

	public var x:Float = 0;
	public var y:Float = 0;
	
	public function new() 
	{
		super();
	}
	
	override public function write(dataSource:Bytes, position:Int):Int 
	{
		dataSource.setFloat(position, x);
		position += 4;
		dataSource.setFloat(position, y);
		position += 4;
		
		return position;
	}
	
}