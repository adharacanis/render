package geometry;

class QuadGeometry extends Geometry<Vertex>
{	
	public function new() 
	{
		super();
	}
	
	override public function build() 
	{
		var a:Vertex = new Vertex(-1, -1);
		var b:Vertex = new Vertex(1, -1);
		var c:Vertex = new Vertex(1, 1);
		var d:Vertex = new Vertex(-1, 1);
		
		vertices.push(a); vertices.push(b);
		vertices.push(c); vertices.push(d);
	}
}