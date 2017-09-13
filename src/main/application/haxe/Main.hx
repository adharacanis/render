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
import haxe.Timer;
import haxe.ds.Vector;
import haxe.io.Bytes;
import js.Browser;
import js.html.ArrayBuffer;
import js.html.Float32Array;
import js.html.Uint32Array;
import js.html.Uint8Array;
import js.html.XMLHttpRequestResponseType;
import js.html.webgl.RenderingContext;
import js.html.webgl.UniformLocation;
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
	
	public static var instanced:Bool = false;
	public static var instancesCount:Int = 1500;
	var size:Float = 256 / 2 / 16;

	public static function main()
	{
		new Main();
	}
	
	//var urlVariableReg:String = "(\?|\&)([^=]+)\=([^&]+)";
	static var urlVariableReg:String = "(\\?|\\&)({0})\\=([^&]+)";
	static function getUrlVariableValie(variableName:String)
	{
		var reg:EReg = new EReg(StringTools.replace(urlVariableReg, "{0}", variableName), "g");
		var location:String = Browser.document.location.href;
		
		if (!reg.match(location))
			return null;
		
		return reg.matched(3);
	}
	
	static function getUrlVariableAsBool(variableName:String)
	{
		var value = getUrlVariableValie(variableName);
		
		if (value == null || value == "false" || value == "0")
			return false;
		else
			return true;
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
		driver.requestContext();
		
		instanced = getUrlVariableAsBool("instanced");
		
		if (Context.instancedExtension == null)
			instanced = false;
			
		trace('instance drawing ${instanced}');
		
		testShader = new TestShader();
		testShader.create(Context.gl);
		testShader.link(Context.gl);
		
		
		trace('a_geometry ${Context.gl.getAttribLocation(testShader.shaderProgram, "a_geometry")}');
		trace('a_uv ${Context.gl.getAttribLocation(testShader.shaderProgram, "a_uv")}');
		trace('a_color ${Context.gl.getAttribLocation(testShader.shaderProgram, "a_color")}');
		trace('instanceID ${Context.gl.getAttribLocation(testShader.shaderProgram, "id")}');
		
		
		geometryBuffer = buildGeometry();
		uvBuffer = buildUVs();
		positionBuffer = buildPositions();
		colorBuffer = buildColors();
		instanceId = buildInstanceId();
		buildIndexBuffer();
		
		
		ppxTexture.uploadToGL(Context.gl);
		
		Context.gl.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_WRAP_S, RenderingContext.CLAMP_TO_EDGE);
		Context.gl.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_WRAP_T, RenderingContext.CLAMP_TO_EDGE);
		Context.gl.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_MIN_FILTER, RenderingContext.NEAREST);
		Context.gl.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_MAG_FILTER, RenderingContext.NEAREST);
		//Context.gl.pixelStorei(RenderingContext.UNPACK_PREMULTIPLY_ALPHA_WEBGL, 1);
		//Context.gl.blendFunc(RenderingContext.SRC_ALPHA, RenderingContext.ONE_MINUS_SRC_ALPHA);
		
		Context.gl.viewport(0, 0, 768, 768);
		
		if (instanced)
		{
			Context.instancedExtension.vertexAttribDivisorANGLE(0, 0);
			Context.instancedExtension.vertexAttribDivisorANGLE(1, 0);
			Context.instancedExtension.vertexAttribDivisorANGLE(2, 1);
			Context.instancedExtension.vertexAttribDivisorANGLE(3, 1);
			Context.instancedExtension.vertexAttribDivisorANGLE(4, 0);
		}
		
		uniformAnim = Context.gl.getUniformLocation(testShader.shaderProgram, "animation");
		
		frameRunner.start();
	}
	
	var uniformAnim:UniformLocation;
	var xx:Float = 0;
	function onEnterFrame() 
	{
		xx += 0.1;
		//Context.gl.uniform2f(uniformAnim, Math.sin(xx) * 76, Math.cos(xx) * 76);
		for (i in 0...100)
		{
			uvBuffer.swapBuffer();
			uvBuffer.mapAttributes(1, 2, AttributeType.FLOAT, false, 8, 0);
			uvBuffer.uploadFromArray2(uvsData, 0, 0);
			
			
			geometryBuffer.swapBuffer();
			geometryBuffer.mapAttributes(0, 2, AttributeType.FLOAT, false, 8, 0);
			geometryBuffer.uploadFromArray2(geometryData, 0, 0);
			
			
			positionBuffer.swapBuffer();
			positionBuffer.mapAttributes(3, 2, AttributeType.FLOAT, false, 8, 0);
			positionBuffer.uploadFromArray2(positionsData, 0, 0);
			
			
			colorBuffer.swapBuffer();
			colorBuffer.mapAttributes(2, 4, AttributeType.FLOAT, true, 16, 0);
			colorBuffer.uploadFromArray2(colorsData, 0, 0);
			
			
			instanceId.swapBuffer();
			instanceId.mapAttributes(2, 4, AttributeType.FLOAT, true, 16, 0);
			instanceId.uploadFromArray2(instanceIdData, 0, 0);
			
			
			//driver.update();
		}
		
		driver.update();
		
		//Context.instancedExtension.vertexAttribDivisorANGLE(1, 0);
		//Context.instancedExtension.vertexAttribDivisorANGLE(0, 0);
	}
	
	var uvBuffer:VertexBuffer;
	var geometryBuffer:VertexBuffer;
	var positionBuffer:VertexBuffer;
	var colorBuffer:VertexBuffer;
	var instanceId:VertexBuffer;
	
	var geometryData:Float32Array;
	private function buildGeometry()
	{
		geometryData = new Float32Array(instanced? 4 * 2:4 * 2 * instancesCount);
		
		var registerIndex:Int = 0;
		
		if (instanced)
		{
			geometryData[registerIndex++] = -size; geometryData[registerIndex++] =  size;
			geometryData[registerIndex++] = -size; geometryData[registerIndex++] = -size;
			geometryData[registerIndex++] =  size; geometryData[registerIndex++] = -size;
			geometryData[registerIndex++] =  size; geometryData[registerIndex++] =  size;
		}
		else
		{
			for (i in 0...instancesCount)
			{
				geometryData[registerIndex++] = -size; geometryData[registerIndex++] =  size;
				geometryData[registerIndex++] = -size; geometryData[registerIndex++] = -size;
				geometryData[registerIndex++] =  size; geometryData[registerIndex++] = -size;
				geometryData[registerIndex++] =  size; geometryData[registerIndex++] =  size;
			}
		}
		
		var buffer = driver.createVertexBuffer(Std.int(geometryData.length / 2), 2);
		buffer.uploadFromArray2(geometryData, 0, 0);
		buffer.mapAttributes(0, 2, AttributeType.FLOAT, false, 8, 0);
		
		return buffer;
	}
	
	var uvsData:Float32Array;
	private function buildUVs()
	{
		uvsData = new Float32Array(instanced? 4 * 2:4 * 2 * instancesCount);
		
		var registerIndex:Int = 0;
		
		if (instanced)
		{
			uvsData[registerIndex++] = 0.0; uvsData[registerIndex++] = 1.0;
			uvsData[registerIndex++] = 0.0; uvsData[registerIndex++] = 0.0;
			uvsData[registerIndex++] = 1.0; uvsData[registerIndex++] = 0.0;
			uvsData[registerIndex++] = 1.0; uvsData[registerIndex++] = 1.0;
		}
		else
		{
			for (i in 0...instancesCount)
			{
				uvsData[registerIndex++] = 0.0; uvsData[registerIndex++] = 1.0;
				uvsData[registerIndex++] = 0.0; uvsData[registerIndex++] = 0.0;
				uvsData[registerIndex++] = 1.0; uvsData[registerIndex++] = 0.0;
				uvsData[registerIndex++] = 1.0; uvsData[registerIndex++] = 1.0;
			}
		}
		
		var buffer = driver.createVertexBuffer(Std.int(uvsData.length / 2), 2);
		buffer.uploadFromArray2(uvsData);
		buffer.mapAttributes(1, 2, AttributeType.FLOAT, true, 8, 0);
		
		return buffer;
	}
	
	var instanceIdData:Float32Array;
	private function buildInstanceId()
	{
		instanceIdData = new Float32Array(instanced? 4 * 4:4 * 4 * instancesCount);
		
		var registerIndex:Int = 0;
		
		if (instanced)
		{
			instanceIdData[registerIndex++] = 3;
			instanceIdData[registerIndex++] = 2;
			instanceIdData[registerIndex++] = 1;
			instanceIdData[registerIndex++] = 0;
			
			instanceIdData[registerIndex++] = 3;
			instanceIdData[registerIndex++] = 2;
			instanceIdData[registerIndex++] = 1;
			instanceIdData[registerIndex++] = 0;
			
			instanceIdData[registerIndex++] = 3;
			instanceIdData[registerIndex++] = 2;
			instanceIdData[registerIndex++] = 1;
			instanceIdData[registerIndex++] = 0;
			
			instanceIdData[registerIndex++] = 3;
			instanceIdData[registerIndex++] = 2;
			instanceIdData[registerIndex++] = 1;
			instanceIdData[registerIndex++] = 0;
		}
		else
		{
			for (i in 0...instancesCount)
			{
				instanceIdData[registerIndex++] = 3;
				instanceIdData[registerIndex++] = 2;
				instanceIdData[registerIndex++] = 1;
				instanceIdData[registerIndex++] = 0;
				
				instanceIdData[registerIndex++] = 3;
				instanceIdData[registerIndex++] = 2;
				instanceIdData[registerIndex++] = 1;
				instanceIdData[registerIndex++] = 0;
				
				instanceIdData[registerIndex++] = 3;
				instanceIdData[registerIndex++] = 2;
				instanceIdData[registerIndex++] = 1;
				instanceIdData[registerIndex++] = 0;
				
				instanceIdData[registerIndex++] = 3;
				instanceIdData[registerIndex++] = 2;
				instanceIdData[registerIndex++] = 1;
				instanceIdData[registerIndex++] = 0;
			}
		}
		
		var buffer = driver.createVertexBuffer(instanceIdData.length, 1);
		buffer.uploadFromArray2(instanceIdData);
		buffer.mapAttributes(4, 4, AttributeType.FLOAT, false, 16, 0);
		
		return buffer;
	}
	
	var positionsData:Float32Array;
	private function buildPositions()
	{
		positionsData = new Float32Array(instanced? 1 * 2 * instancesCount:4 * 2 * instancesCount);
		
		var halfW:Float = size;// 768 / 2;
		var halfH:Float = size;// 768 / 2;
		var registerIndex:Int = 0;
		
		if (instanced)
		{
			for (i in 0...instancesCount)
			{
				positionsData[registerIndex++] = halfW; positionsData[registerIndex++] = halfH;
				halfW += size * 2;
				
				if (halfW > 768)
				{
					halfW = size;
					halfH += size * 2;
				}
			}
		}
		else
		{
			for (i in 0...instancesCount)
			{
				positionsData[registerIndex++] = halfW; positionsData[registerIndex++] = halfH;
				positionsData[registerIndex++] = halfW; positionsData[registerIndex++] = halfH;
				positionsData[registerIndex++] = halfW; positionsData[registerIndex++] = halfH;
				positionsData[registerIndex++] = halfW; positionsData[registerIndex++] = halfH;
				halfW += size * 2;
				
				if (halfW > 768)
				{
					halfW = size;
					halfH += size * 2;
				}
			}
		}
		
		var buffer = driver.createVertexBuffer(Std.int(positionsData.length / 2), 2);
		buffer.uploadFromArray2(positionsData);
		buffer.mapAttributes(3, 2, AttributeType.FLOAT, false, 8, 0);
		
		return buffer;
	}
	
	var colorsData:Float32Array;
	private function buildColors()
	{
		colorsData = new Float32Array(instanced? 1 * 4 * instancesCount:4 * 4 * instancesCount);
		
		var registerIndex:Int = 0;
		
		if (instanced)
		{
			for (i in 0...instancesCount)
			{
				colorsData[registerIndex++] = Math.random(); colorsData[registerIndex++] = Math.random(); colorsData[registerIndex++] = Math.random(); colorsData[registerIndex++] = 1.0;
			}
		}
		else
		{
			for (i in 0...instancesCount)
			{
				var r:Float = Math.random();
				var g:Float = Math.random();
				var b:Float = Math.random();
				colorsData[registerIndex++] = r; colorsData[registerIndex++] = g; colorsData[registerIndex++] = b; colorsData[registerIndex++] = 1.0;
				colorsData[registerIndex++] = r; colorsData[registerIndex++] = g; colorsData[registerIndex++] = b; colorsData[registerIndex++] = 1.0;
				colorsData[registerIndex++] = r; colorsData[registerIndex++] = g; colorsData[registerIndex++] = b; colorsData[registerIndex++] = 1.0;
				colorsData[registerIndex++] = r; colorsData[registerIndex++] = g; colorsData[registerIndex++] = b; colorsData[registerIndex++] = 1.0;
				//colorsData[registerIndex++] = 1.0; colorsData[registerIndex++] = 0.0; colorsData[registerIndex++] = 0.0; colorsData[registerIndex++] = 1.0;
				//colorsData[registerIndex++] = 0.0; colorsData[registerIndex++] = 1.0; colorsData[registerIndex++] = 0.0; colorsData[registerIndex++] = 1.0;
				//colorsData[registerIndex++] = 0.0; colorsData[registerIndex++] = 0.0; colorsData[registerIndex++] = 1.0; colorsData[registerIndex++] = 1.0;
				//colorsData[registerIndex++] = 1.0; colorsData[registerIndex++] = 0.0; colorsData[registerIndex++] = 1.0; colorsData[registerIndex++] = 1.0;
			}
		}
		
		var buffer = driver.createVertexBuffer(Std.int(colorsData.length / 2), 2);
		buffer.uploadFromArray2(colorsData);
		buffer.mapAttributes(2, 4, AttributeType.FLOAT, false, 16, 0);
		
		return buffer;
	}
	
	private function buildIndexBuffer()
	{
		var data = [];
		
		if (instanced)
		{
			data[0] = 0;
			data[1] = 1;
			data[2] = 3;
			data[3] = 1;
			data[4] = 2;
			data[5] = 3;
		}
		else
		{
			for (i in 0...instancesCount)
			{
				var index:Int = i * 6;
				var vertexIndex:Int = i * 4;
				data[index + 0] = vertexIndex + 0;
				data[index + 1] = vertexIndex + 1;
				data[index + 2] = vertexIndex + 3;
				data[index + 3] = vertexIndex + 1;
				data[index + 4] = vertexIndex + 2;
				data[index + 5] = vertexIndex + 3;
			}
		}
		
		var buffer = driver.bufferContext.createIndexBuffer(data.length, 1);
		buffer.uploadFromArray(data);
		
	}
}