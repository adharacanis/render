package geometry_old;

interface IGeometry 
{
	function mapTriangle(v1:Int, v2:Int, v3:Int);
	function addVertexAndUV(x:Float, y:Float, u:Float, v:Float);
	function setVertexAndUV(i:Int, x:Float, y:Float, u:Float, v:Float);
	function setVertex(i:Int, x:Float, y:Float);
	function setUV(i:Int, u:Float, v:Float);
}