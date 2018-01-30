package geometry;

import geometry.Position;
import gl.bufferContext.data.DataComponentContainer;

class Vertex extends DataComponentContainer 
{
	public var __size:Int = 4 * 2;
	
	public var position:Position;

	public function new(x:Int = 0, y:Int = 0) 
	{
		super();
		
		position = new Position(x, y);
		addComponent(position);
	}
	
}