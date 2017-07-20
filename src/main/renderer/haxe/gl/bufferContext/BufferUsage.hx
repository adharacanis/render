package gl.bufferContext;

@:enum
abstract BufferUsage(Int) from Int to Int
{
#if html5
	public static var STATIC = js.html.webgl.RenderingContext.STATIC_DRAW;
	public static var DYNAMIC = js.html.webgl.RenderingContext.DYNAMIC_DRAW;
	public static var STREAM = js.html.webgl.RenderingContext.STREAM_DRAW;
#else
	public static var STATIC = 0;
	public static var DYNAMIC = 1;
	public static var STREAM = 2;
#end
}