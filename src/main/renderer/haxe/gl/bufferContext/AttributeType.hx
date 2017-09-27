package gl.bufferContext;

@:enum
abstract AttributeType(Int) from Int to Int
{
#if html5
	var FLOAT:Int = js.html.webgl.RenderingContext.FLOAT;
	var UNSIGNED_INT:Int = js.html.webgl.RenderingContext.UNSIGNED_INT;
	var INT:Int = js.html.webgl.RenderingContext.INT;
	var UNSIGNED_SHORT:Int = js.html.webgl.RenderingContext.UNSIGNED_SHORT;
	var SHORT:Int = js.html.webgl.RenderingContext.ARRAY_BUFFER;
	var UNSIGNED_BYTE:Int = js.html.webgl.RenderingContext.UNSIGNED_BYTE;
	var BYTE:Int = js.html.webgl.RenderingContext.BYTE;
#else
	var FLOAT:Int = 0;
	var UNSIGNED_INT:Int = 1;
	var INT:Int = 2;
	var UNSIGNED_SHORT:Int = 3;
	var SHORT:Int = 4;
	var UNSIGNED_BYTE:Int = 5;
	var BYTE:Int = 6;
#end
}