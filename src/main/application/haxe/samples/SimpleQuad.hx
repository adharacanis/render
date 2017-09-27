package samples;

import geometry.BaseGeometry;
import gl.bufferContext.BufferContext;
import gl.bufferContext.buffer.VertexBuffer;

class SimpleQuad 
{
	var geometry:BaseGeometry = new BaseGeometry();
	
	public function new() 
	{
		initialize();
	}
	
	function initialize() 
	{
		var size:Float = 1;
		
		geometry.setVertexAndUV(0, -size,  size, 0.0, 1.0);
		geometry.setVertexAndUV(1, -size, -size, 0.0, 0.0);
		geometry.setVertexAndUV(2,  size, -size, 1.0, 0.0);
		geometry.setVertexAndUV(3,  size,  size, 1.0, 1.0);
	}
	
	public function setToContext(bufferContext:BufferContext)
	{
		geometry.setToContext(bufferContext);
	}
}