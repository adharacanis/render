package gl.bufferContext;

import gl.Context;

class BuferMapper 
{
	var context:Context;

	public function new(context:Context) 
	{
		this.context = context;
	}
	
	public function mapBuffer(buffer:IBuffer)
	{
		context.enableVertexAttribArray(0);
		context.vertexAttribPointer(0, buffer.vertexData.attributesPerVertex, buffer.vertexData.vertexType, buffer.vertexData.normalized, buffer.stride, 0);
	}
}