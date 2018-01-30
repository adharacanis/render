package geometry;

import gl.bufferContext.data.DataComponentContainer;
import haxe.io.Bytes;
import system.Utils;

class Geometry<T:DataComponentContainer>
{
	public var verticesDataSource:Bytes;
	public var indicesDataSource:Bytes;
	
	var vertices:Array<T> = new Array<T>();
	
	public function new() 
	{
		build();
		upload();
	}
	
	public function build()
	{
		
	}
	
	public function upload() 
	{
		var verticesSize = vertices.length * 4 * 2;//Utils.sizeOf(vertices);
		
		verticesDataSource = Bytes.alloc(verticesSize);
		
		var position:Int = 0;
		for (i in 0...vertices.length) 
		{
			position = vertices[i].write(verticesDataSource, position);
		}
	}
}