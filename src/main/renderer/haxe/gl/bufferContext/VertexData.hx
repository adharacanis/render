package gl.bufferContext;

class VertexData 
{
	public var vertexType:AttributeType;
	public var attributesPerVertex:Int;
	public var normalized:Bool;
	public var stride:Int;

	public function new(vertexType:AttributeType = AttributeType.FLOAT, attributesPerVertex:Int = 0, normalized:Bool = false) 
	{
		this.normalized = normalized;
		this.attributesPerVertex = attributesPerVertex;
		this.vertexType = vertexType;
		stride = attributesPerVertex * 4; //TODO type to size in bytes
	}
	
	public function toString():String 
	{
		return "[VertexData vertexType=" + vertexType + " attributesPerVertex=" + attributesPerVertex + " normalized=" + normalized + 
					" stride=" + stride + "]";
	}
}