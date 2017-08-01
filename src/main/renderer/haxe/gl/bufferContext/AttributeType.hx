package gl.bufferContext;

@:enum
abstract AttributeType(Int) from Int to Int
{
#if html5
	public static var FLOAT:Int = js.html.webgl.RenderingContext.FLOAT;
	public static var UNSIGNED_INT:Int = js.html.webgl.RenderingContext.UNSIGNED_INT;
	public static var INT:Int = js.html.webgl.RenderingContext.INT;
	public static var UNSIGNED_SHORT:Int = js.html.webgl.RenderingContext.UNSIGNED_SHORT;
	public static var SHORT:Int = js.html.webgl.RenderingContext.ARRAY_BUFFER;
	public static var UNSIGNED_BYTE:Int = js.html.webgl.RenderingContext.UNSIGNED_BYTE;
	public static var BYTE:Int = js.html.webgl.RenderingContext.BYTE;
#else
	public static var FLOAT:Int = 0;
	public static var UNSIGNED_INT:Int = 1;
	public static var INT:Int = 2;
	public static var UNSIGNED_SHORT:Int = 3;
	public static var SHORT:Int = 4;
	public static var UNSIGNED_BYTE:Int = 5;
	public static var BYTE:Int = 6;
#end
}