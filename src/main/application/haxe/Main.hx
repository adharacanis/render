package;

import assets.AssetsStorage;
import events.DataEvent;
import events.Event;
import external.DataLoader;
import external.data.PPXData;
import geometry.BaseGeometry;
import gl.Context;
import gl.Driver;
import gl.bufferContext.BufferType;
import haxe.io.Bytes;
import js.Browser;
import js.html.ArrayBuffer;
import js.html.Uint32Array;
import js.html.Uint8Array;
import js.html.XMLHttpRequestResponseType;
import js.html.webgl.RenderingContext;
import texture.PPXTexture;

@:access(gl)
@:access(haxe.io.Bytes)
class Main 
{
	var driver:Driver;
	var testShader:TestShader;
	var geometry:BaseGeometry;
	var ppxTexture:PPXTexture;
	
	var vertBuffer:gl.bufferContext.VertexBuffer;
	var uniformLocation:js.html.webgl.UniformLocation;

	public static function main()
	{
		new Main();
		
		var assetStorage:AssetsStorage;
	}
	
	public function new() 
	{
		var loader:DataLoader = new DataLoader();
		loader.addEventListener(DataEvent.ON_LOAD, onDataLoded);
		loader.load("leaf.ppx", XMLHttpRequestResponseType.ARRAYBUFFER);
	}
	
	private function onDataLoded(e:DataEvent):Void 
	{
		var bytes:Bytes = new Bytes(e.data);
		
		var data:PPXData = new PPXData(bytes);
		ppxTexture = new PPXTexture(data);
		
		var frameRunner:FrameRunner = new FrameRunner();
		frameRunner.addEventListener(Event.UPDATE, onEnterFrame);
		
		driver = new Driver();
		
		vertBuffer = driver.createVertexBuffer(1024, 4);
		vertBuffer.uploadFromArray([1, 2, 3, 4, 5, 6], 0, 0);
		
		geometry = new BaseGeometry();
		
		var size:Float = 256/2;
		geometry.setVertexAndUV(0, -size,  size, 0.0, 1.0);
		geometry.setVertexAndUV(1, -size, -size, 0.0, 0.0);
		geometry.setVertexAndUV(2,  size, -size, 1.0, 0.0);
		geometry.setVertexAndUV(3,  size,  size, 1.0, 1.0);
		
		geometry.updateTriangleMap(0, 0, 1, 3);
		geometry.updateTriangleMap(1, 1, 2, 3);
		
		geometry.setToContext(driver.bufferContext);
		
		testShader = new TestShader();
		testShader.create(Context.gl);
		
		testShader.link(Context.gl, geometry.vertexBuffer, geometry.indexBuffer);
		uniformLocation = Context.gl.getUniformLocation(testShader.shaderProgram, "padding");
		
		ppxTexture.uploadToGL(Context.gl);
		Context.gl.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_WRAP_S, RenderingContext.CLAMP_TO_EDGE);
		Context.gl.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_WRAP_T, RenderingContext.CLAMP_TO_EDGE);
		Context.gl.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_MIN_FILTER, RenderingContext.NEAREST);
		
		trace(uniformLocation);
		
		Context.gl.viewport(0, 0, 768, 768);
		
		//vertexBuffer.uploadFromArray([-0.5, 0.5, 0.5, -0.5, -0.5, 0.5, 0.5, -0.5, 0.5, 0.5, 0.5, 0.5], 0, 8);
		
		frameRunner.start();
	}
	
	private var i:Float = 0;
	
	function onEnterFrame() 
	{
		i += 0.05;
		//Context.gl.uniform2f(uniformLocation, Math.sin(i) / 2, Math.cos(i) / 2);
		
		Context.gl.uniform2f(uniformLocation, 768 / 2, 768 / 2);
		driver.update();
	}
}