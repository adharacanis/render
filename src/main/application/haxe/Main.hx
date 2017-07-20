package;

import geometry.BaseGeometry;
import gl.Driver;
import js.Browser;

class Main 
{
	var driver:Driver;

	public static function main()
	{
		new Main();
	}
	
	public function new() 
	{
		driver = new Driver();
		var vertexBuffer = driver.createVertexBuffer(8, 4);
		
		var geometry:BaseGeometry = new BaseGeometry();
		
		geometry.setVertexAndUV(0, -1.0, -1.0, 0.0, 0.0);
		geometry.setVertexAndUV(1,  1.0, -1.0, 1.0, 0.0);
		geometry.setVertexAndUV(2,  1.0,  1.0, 1.0, 1.0);
		geometry.setVertexAndUV(3, -1.0,  1.0, 0.0, 1.0);
				
		geometry.updateTriangleMap(0, 0, 1, 2);
		geometry.updateTriangleMap(1, 2, 3, 0);
		
		geometry.setToContext(driver.bufferContext);
		
		//vertexBuffer.uploadFromArray([-0.5, 0.5, 0.5, -0.5, -0.5, 0.5, 0.5, -0.5, 0.5, 0.5, 0.5, 0.5], 0, 8);
		
		//requestAnimationFrame();
	}
	
	function onEnterFrame(?_) 
	{
		if (!Browser.document.hidden) 
		{
			requestAnimationFrame();
		}
		
		driver.update();
	}

	inline function requestAnimationFrame() 
	{
		Browser.window.requestAnimationFrame(onEnterFrame);
	}
}