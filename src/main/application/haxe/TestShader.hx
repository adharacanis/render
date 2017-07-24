package;
import gl.bufferContext.IBuffer;
import js.html.webgl.RenderingContext;

class TestShader
{
	private var vertex:String = haxe.Resource.getString("vert");
	private var pixel:String = haxe.Resource.getString("frag");
	var shaderProgram:js.html.webgl.Program;
	
	public function new() 
	{
		
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
		gl.attachShader(shaderProgram, vertShader); 
		gl.attachShader(shaderProgram, fragShader);
		gl.linkProgram(shaderProgram);
	}
	
	@:access(gl.bufferContext)
	public function link(gl:RenderingContext, buffer:IBuffer, indexBuffer:IBuffer)
	{
		gl.clearColor(0.5, 0.5, 0.5, 0.9);
		gl.viewport(0, 0, 800, 600);
		
		gl.bindBuffer(RenderingContext.ELEMENT_ARRAY_BUFFER, indexBuffer.internalBuffer);
		
		gl.bindBuffer(RenderingContext.ARRAY_BUFFER, buffer.internalBuffer);
		var geometryLocation = gl.getAttribLocation(shaderProgram, "geometry");
		
		gl.enableVertexAttribArray(geometryLocation);
		gl.vertexAttribPointer(geometryLocation, 3, RenderingContext.FLOAT, false, 0, 0);
		
		//gl.vertexAttribPointer(1, 2, RenderingContext.FLOAT, true, 16, 8);
		//gl.enableVertexAttribArray(1);
		
		//gl.bindAttribLocation(shaderProgram, geometryLocation, "geometry");
		//gl.bindAttribLocation(shaderProgram, 1, "uv");
		
		
		gl.useProgram(shaderProgram);
	}
	
}