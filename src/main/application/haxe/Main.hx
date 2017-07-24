package;

import geometry.BaseGeometry;
import gl.Context;
import gl.Driver;
import js.Browser;

class Main 
{
	var driver:Driver;
	var testShader:TestShader;
	var geometry:BaseGeometry;

	public static function main()
	{
		new Main();
	}
	
	public function new() 
	{
		driver = new Driver();
		//var vertexBuffer = driver.createVertexBuffer(8, 4);
		
		geometry = new BaseGeometry();
		
		//geometry.setVertexAndUV(0, -1.0, -1.0, 0.0, 0.0);
		//geometry.setVertexAndUV(1,  1.0, -1.0, 1.0, 0.0);
		//geometry.setVertexAndUV(2,  1.0,  1.0, 1.0, 1.0);
		//geometry.setVertexAndUV(3, -1.0,  1.0, 0.0, 1.0);
		
		geometry.setVertex(0, -0.5001,  0.5);
		geometry.setVertex(1, -0.5, -0.5);
		geometry.setVertex(2,  0.5, -0.5);
		geometry.setVertex(3,  0.5,  0.5);
				
		geometry.updateTriangleMap(0, 3, 2, 1);
		geometry.updateTriangleMap(1, 3, 1, 0);
		
		geometry.setToContext(driver.bufferContext);
		
		testShader = new TestShader();
		testShader.create(Context.gl);
		
		//vertexBuffer.uploadFromArray([-0.5, 0.5, 0.5, -0.5, -0.5, 0.5, 0.5, -0.5, 0.5, 0.5, 0.5, 0.5], 0, 8);
		
		requestAnimationFrame();
	}
	
	function onEnterFrame(?_) 
	{
		if (!Browser.document.hidden) 
		{
			requestAnimationFrame();
		}
		
		testShader.link(Context.gl, geometry.vertexBuffer, geometry.indexBuffer);
		driver.update();
	}

	inline function requestAnimationFrame() 
	{
		Browser.window.requestAnimationFrame(onEnterFrame);
	}
}