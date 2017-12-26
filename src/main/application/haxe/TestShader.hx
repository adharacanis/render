package;
import gl.bufferContext.AttributeType;
import gl.bufferContext.IBuffer;
import gl.bufferContext.VertexBuffer;
import js.html.webgl.ExtensionDebugShaders;
import js.html.webgl.RenderingContext;

class TestShader
{
	private var vertex:String = haxe.Resource.getString("vert");
	private var pixel:String = haxe.Resource.getString("frag");
	public var shaderProgram:js.html.webgl.Program;
	
	public function new() 
	{
		
	}
	
	static function createParallelProj(left:Float, right:Float, bottom:Float, top:Float) {
		var projection:Array<Float> = new Array<Float>();
		var tb:Float = top - bottom;
		var rl:Float = right - left;
		projection[0] = 2 / rl;
		projection[1] = 2 / tb;
		projection[2] = -(right + left) / rl;
		projection[3] = -(top + bottom) / tb;
		return projection;
	}
	
	public function create(gl:RenderingContext)
	{
		var vertShader = gl.createShader(RenderingContext.VERTEX_SHADER);

		gl.shaderSource(vertShader, vertex);
		gl.compileShader(vertShader);
		
		var fragShader = gl.createShader(RenderingContext.FRAGMENT_SHADER);

		gl.shaderSource(fragShader, pixel);
		gl.compileShader(fragShader);
		
		shaderProgram = gl.createProgram();
		
		gl.bindAttribLocation(shaderProgram, 0, "a_geometry");
		gl.bindAttribLocation(shaderProgram, 1, "a_uv");
		gl.bindAttribLocation(shaderProgram, 2, "a_color");
		gl.bindAttribLocation(shaderProgram, 3, "padding");
		gl.bindAttribLocation(shaderProgram, 4, "id");
		
		gl.attachShader(shaderProgram, vertShader); 
		var infoLog = gl.getShaderInfoLog(vertShader);
		if (infoLog != null && infoLog.length != 0)
			trace(infoLog);
			
		//var ext:ExtensionDebugShaders = gl.getExtension('WEBGL_debug_shaders');
		//trace(ext.getTranslatedShaderSource(vertShader));
		
		gl.attachShader(shaderProgram, fragShader);
		var infoLog = gl.getShaderInfoLog(fragShader);
		if (infoLog != null && infoLog.length != 0)
			trace(infoLog);
			
		gl.linkProgram(shaderProgram);
		
		gl.validateProgram(shaderProgram);
		
		if(!gl.getProgramParameter(shaderProgram, RenderingContext.LINK_STATUS)) {
			var infoLog = gl.getProgramInfoLog(shaderProgram);
			trace(infoLog);
		}
	}
	
	@:access(gl.bufferContext)
	public function link(gl:RenderingContext, posBuffer:Array<Float>)
	{
		//gl.clearColor(0.5, 0.5, 0.5, 0.9);
		//gl.viewport(0, 0, 800, 600);
		
		//gl.bindBuffer(RenderingContext.ELEMENT_ARRAY_BUFFER, indexBuffer.internalBuffer);
		
		//gl.bindBuffer(RenderingContext.ARRAY_BUFFER, buffer.internalBuffer);
		//var geometryLocation = gl.getAttribLocation(shaderProgram, "geometry");
		
		
		
		
		//gl.bindAttribLocation(shaderProgram, geometryLocation, "geometry");
		//gl.bindAttribLocation(shaderProgram, 1, "uv");
		
		trace("MAX VECTORS " + posBuffer.length);
		trace(gl.getParameter(RenderingContext.MAX_VARYING_VECTORS));
		trace(gl.getParameter(RenderingContext.MAX_VERTEX_UNIFORM_VECTORS));
		
		
		gl.useProgram(shaderProgram);
		gl.uniform4fv(gl.getUniformLocation(shaderProgram, "viewProjection"), createParallelProj(0, 768, 768, 0));
		gl.uniform4fv(gl.getUniformLocation(shaderProgram, "padding"), posBuffer.slice(0, 4096));
	}
	
}