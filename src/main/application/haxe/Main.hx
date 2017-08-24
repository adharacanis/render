package;

import assets.AssetsStorage;
import events.DataEvent;
import events.Event;
import external.DataLoader;
import external.data.PPXData;
import geometry.BaseGeometry;
import gl.Context;
import gl.Driver;
import gl.bufferContext.AttributeType;
import gl.bufferContext.BufferType;
import gl.bufferContext.IndexBuffer;
import gl.bufferContext.VertexBuffer;
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
	var positionLocation:Int;

	public static function main()
	{
		new Main();
	}
	
	public function new() 
	{
		var loader:DataLoader = new DataLoader();
		loader.addEventListener(DataEvent.ON_LOAD, onDataLoded);
		loader.load("leaf.ppx", XMLHttpRequestResponseType.ARRAYBUFFER);
	}
	
	var uvBuffer:VertexBuffer;
	var geometryBuffer:VertexBuffer;
	var positionBuffer:VertexBuffer;
	var colorBuffer:VertexBuffer;
	
	private function buildGeometry()
	{
		var size:Float = 256/2;
		var data:Array<Float> = 
								[
									-size,  size,
									-size, -size,
									 size, -size,
									 size,  size
								];
		var buffer = driver.createVertexBuffer(Std.int(data.length / 2), 2);
		buffer.uploadFromArray(data);
		buffer.mapAttributes(0, 2, AttributeType.FLOAT, false, 8, 0);
		
		return buffer;
	}
	
	private function buildUVs()
	{
		var data:Array<Float> = 
								[
									0.0, 1.0,
									0.0, 0.0,
									1.0, 0.0,
									1.0, 1.0
								];
		var buffer = driver.createVertexBuffer(Std.int(data.length / 2), 2);
		buffer.uploadFromArray(data);
		buffer.mapAttributes(1, 2, AttributeType.FLOAT, true, 8, 0);
		
		return buffer;
	}
	
	private function buildPositions()
	{
		var halfW:Float = 768 / 2;
		var halfH:Float = 768 / 2;
		
		var data:Array<Float> = 
								[
									halfW, halfH,
									halfW, halfH,
									halfW, halfH,
									halfW, halfH
								];
		var buffer = driver.createVertexBuffer(Std.int(data.length / 2), 2);
		buffer.uploadFromArray(data);
		buffer.mapAttributes(3, 2, AttributeType.FLOAT, false, 8, 0);
		
		return buffer;
	}
	
	private function buildColors()
	{
		var data:Array<Float> = 
								[
									1.0, 0.0, 0.0, 1.0,
									0.0, 1.0, 1.0, 1.0,
									0.0, 0.0, 1.0, 1.0,
									1.0, 0.0, 1.0, 1.0
								];
		var buffer = driver.createVertexBuffer(Std.int(data.length / 2), 2);
		buffer.uploadFromArray(data);
		buffer.mapAttributes(2, 4, AttributeType.FLOAT, false, 16, 0);
		
		return buffer;
	}
	
	private function buildIndexBuffer()
	{
		var data = [0, 1, 3, 1, 2, 3];
		var buffer = driver.bufferContext.createIndexBuffer(data.length, 1);
		buffer.uploadFromArray(data);
		
	}
	
	private function onDataLoded(e:DataEvent):Void 
	{
		var bytes:Bytes = new Bytes(e.data);
		
		var data:PPXData = new PPXData(bytes);
		ppxTexture = new PPXTexture(data);
		
		var frameRunner:FrameRunner = new FrameRunner();
		frameRunner.addEventListener(Event.UPDATE, onEnterFrame);
		
		driver = new Driver();
		driver.requestContext();
		
		
		testShader = new TestShader();
		testShader.create(Context.gl);
		testShader.link(Context.gl);
		
		
		
		
		trace('a_geometry ${Context.gl.getAttribLocation(testShader.shaderProgram, "a_geometry")}');
		trace('a_uv ${Context.gl.getAttribLocation(testShader.shaderProgram, "a_uv")}');
		trace('a_color ${Context.gl.getAttribLocation(testShader.shaderProgram, "a_color")}');
		
		
		geometryBuffer = buildGeometry();
		uvBuffer = buildUVs();
		positionBuffer = buildPositions();
		colorBuffer = buildColors();
		buildIndexBuffer();
		
		
		ppxTexture.uploadToGL(Context.gl);
		Context.gl.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_WRAP_S, RenderingContext.CLAMP_TO_EDGE);
		Context.gl.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_WRAP_T, RenderingContext.CLAMP_TO_EDGE);
		Context.gl.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_MIN_FILTER, RenderingContext.NEAREST);
		
		
		Context.gl.viewport(0, 0, 768, 768);
		
		
		frameRunner.start();
	}
	
	function onEnterFrame() 
	{
		
		uvBuffer.mapAttributes(1, 2, AttributeType.FLOAT, false, 8, 0);
		geometryBuffer.mapAttributes(0, 2, AttributeType.FLOAT, false, 8, 0);
		positionBuffer.mapAttributes(3, 2, AttributeType.FLOAT, false, 8, 0);
		colorBuffer.mapAttributes(2, 4, AttributeType.FLOAT, true, 16, 0);
		
		driver.update();
		
		
		
		//Context.instancedExtension.vertexAttribDivisorANGLE(1, 0);
		//Context.instancedExtension.vertexAttribDivisorANGLE(0, 0);
	}
}