package geometry;

import geometry.Position;
import gl.bufferContext.data.DataComponentContainer;

class Vertex extends DataComponentContainer 
{
	public var position:Position = new Position();

	public function new() 
	{
		super();
		
		addComponent(position);
	}
	
}