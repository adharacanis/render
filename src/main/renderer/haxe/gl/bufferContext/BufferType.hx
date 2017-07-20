package gl.bufferContext;

@:enum
abstract BufferType(Int) from Int to Int
{
#if html5
	public static var INDEX_BUFFER:Int = js.html.webgl.RenderingContext.ELEMENT_ARRAY_BUFFER;
	public static var VERTEX_BUFFER:Int = js.html.webgl.RenderingContext.ARRAY_BUFFER;
#else
	public static var INDEX_BUFFER:Int = 0;
	public static var VERTEX_BUFFER:Int = 1;
#end
}