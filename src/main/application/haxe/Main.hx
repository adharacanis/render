package;

import events.Event;
import geometry.BaseGeometry;
import gl.Context;
import gl.Driver;
import gl.bufferContext.BufferType;
import js.Browser;
import js.html.ArrayBuffer;
import js.html.Uint32Array;
import js.html.Uint8Array;

@:access(gl)
class Main 
{
	var driver:Driver;
	var testShader:TestShader;
	var geometry:BaseGeometry;
	var vertBuffer:gl.bufferContext.VertexBuffer;
	var uniformLocation:js.html.webgl.UniformLocation;

	public static function main()
	{
		new Main();
	}
	
	public function new() 
	{
		/*var size:Int = 1024 * 20000;
		var data:ArrayBuffer = new ArrayBuffer(size);
		var testData:Uint8Array = new Uint8Array(data);
		var uint32Arr:Uint32Array = new Uint32Array(data);
		
		
		var converter:JsBytesConverter = new JsBytesConverter();
		converter.data = testData;
		
		var len = Std.int(size / 4);
		
		var a:UInt = 0;
		var i:Int;
		var c:Int;
		var t:Float;
		
		trace(len);
		
		for (i in 0...len)
		{
			a = Std.int(0x7FFFFFFF / len * i);
			uint32Arr[i] = a;
		}
		
		t = Date.now().getTime();
		c = 0;
		for (i in 0...len)
		{
			a = converter.getUInt32(i >> 1);
			
			#if debug
			if (a != uint32Arr[i])
				throw 'data is not match $i, $a, ${uint32Arr[i]}';
			#end
				
		}
		trace(Date.now().getTime() - t);

		
		var t = Date.now().getTime();
		c = 0;
		for (i in 0...len)
		{
			c = i >> 1;
			a = ((getByte(c, testData)) | (getByte(c + 1, testData) << 8) | (getByte(c + 2, testData) << 16) | getByte(c + 3, testData) << 24);
			
			#if debug
			var b = uint32Arr[i];
			trace("DEBUG");
			if (a != b)
			{
				trace(getByte(c, testData), getByte(c + 1, testData), getByte(c + 2, testData), getByte(c + 3, testData));
				trace('$a, ${b}, ${Type.typeof(b)},  ${Type.typeof(a)}');
				throw 'data is not match $i, $a, ${b}, ${b - a}, ${a < 0}';
			}
			#end
		}
		trace(Date.now().getTime() - t);*/
		
		var frameRunner:FrameRunner = new FrameRunner();
		frameRunner.addEventListener(Event.UPDATE, onEnterFrame);
		
		driver = new Driver();
		
		vertBuffer = driver.createVertexBuffer(1024, 4);
		vertBuffer.uploadFromArray([1, 2, 3, 4, 5, 6], 0, 0);
		
		geometry = new BaseGeometry();
		
		var size:Float = 0.5;
		geometry.setVertexAndUV(0, -size,  size, 0.0, 0.0);
		geometry.setVertexAndUV(1, -size, -size, 1.0, 0.0);
		geometry.setVertexAndUV(2,  size, -size, 1.0, 1.0);
		geometry.setVertexAndUV(3,  size,  size, 0.0, 1.0);
		
		geometry.updateTriangleMap(0, 3, 2, 1);
		geometry.updateTriangleMap(1, 3, 1, 0);
		
		geometry.setToContext(driver.bufferContext);
		
		testShader = new TestShader();
		testShader.create(Context.gl);
		testShader.link(Context.gl, geometry.vertexBuffer, geometry.indexBuffer);
		uniformLocation = Context.gl.getUniformLocation(testShader.shaderProgram, "padding");
		Context.gl.viewport(0, 0, 768, 768);
		
		//vertexBuffer.uploadFromArray([-0.5, 0.5, 0.5, -0.5, -0.5, 0.5, 0.5, -0.5, 0.5, 0.5, 0.5, 0.5], 0, 8);
		
		frameRunner.start();
	}
	
	inline function getByte(pos:Int, source:Uint8Array):Int
	{
		return source[pos];
	}
	
	private var i:Float = 0;
	
	function onEnterFrame() 
	{
		i += 0.05;
		Context.gl.uniform2f(uniformLocation, Math.sin(i) / 2, Math.cos(i) / 2);
		driver.update();
	}
}