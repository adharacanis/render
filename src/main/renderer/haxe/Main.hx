package ;
import events.DataEvent;
import external.DataLoader;
import external.data.PPXData;
import haxe.Timer;
import haxe.io.ArrayBufferView;
import haxe.io.Bytes;
import haxe.io.UInt32Array;
import texture.PPXTexture;

import js.html.ArrayBuffer;
import js.html.XMLHttpRequestResponseType;
import js.html.webgl.GL;
import js.html.webgl.RenderingContext;
import js.html.webgl.Texture;
import js.html.webgl.Buffer;
import js.html.webgl.Program;
import js.Browser;
import js.html.CanvasElement;
import js.html.Uint8Array;
import js.html.Uint16Array;
import js.html.Float32Array;

@:access(haxe.io.Bytes)
class Main 
{
	var shaderProgram:Program;
	var texcoordBuffer:Buffer;
	var Index_Buffer:Buffer;
	var positionBuffer:Buffer;
	var texture:Texture;
	var gl:RenderingContext;
	var canvas:CanvasElement;
	var ppxTexture:PPXTexture;

	public static function main()
	{
		new Main();
	}
	
	public function new() 
	{
		var loader:DataLoader = new DataLoader();
		loader.addEventListener(DataEvent.ON_LOAD, onDataLoded2);
		loader.load("leaf.ppx", XMLHttpRequestResponseType.ARRAYBUFFER);
	}
	
	private function onDataLoded2(e:DataEvent):Void {
		trace(e.data);
		var bytes:Bytes = new Bytes(e.data);
		
		var data:PPXData = new PPXData(bytes);
		ppxTexture = new PPXTexture(data);
		
		canvas = cast Browser.document.getElementById("gameview");
		gl = canvas.getContextWebGL({
			alpha: false,
			antialias: false,
			depth: false,
			premultipliedAlpha: false,
			preserveDrawingBuffer: false,
			stencil: false
		});
		
		ppxTexture.uploadToGL(gl);
		prepareToRender();
	}
	
	private function prepareToRender() {
		var vertices = [
			-0.5, 0.5, 0.0,
			-0.5, -0.5, 0.0, 
			0.5, -0.5, 0.0, 
			0.5, 0.5, 0.0 
		];
          
		var indices = [3, 2, 1, 3, 1, 0];
		
		var uvs = [
					0.0, 0.0,
					1.0, 0.0,
					1.0, 1.0,
					0.0, 1.0
				];
					
					

		positionBuffer = gl.createBuffer();
		gl.bindBuffer(GL.ARRAY_BUFFER, positionBuffer);
		gl.bufferData(GL.ARRAY_BUFFER, new Float32Array(vertices), GL.STATIC_DRAW);
		gl.bindBuffer(GL.ARRAY_BUFFER, null);
		
		Index_Buffer = gl.createBuffer();
		gl.bindBuffer(GL.ELEMENT_ARRAY_BUFFER, Index_Buffer);
		gl.bufferData(GL.ELEMENT_ARRAY_BUFFER, new Uint16Array(indices), GL.STATIC_DRAW);
		gl.bindBuffer(GL.ELEMENT_ARRAY_BUFFER, null);
		
		texcoordBuffer = gl.createBuffer();
		gl.bindBuffer(GL.ARRAY_BUFFER, texcoordBuffer);
		gl.bufferData(GL.ARRAY_BUFFER, new Float32Array(uvs), GL.STATIC_DRAW);
		gl.bindBuffer(GL.ARRAY_BUFFER, null);

		var vertCode =
				'attribute vec2 a_texcoord;'  + 
				'attribute vec3 coordinates;' + 
				'varying vec2 v_texcoord;'    +
				'void main(void) {' + 
									' gl_Position = vec4(coordinates, 1.0);' + 
									' v_texcoord = a_texcoord;'
									+ '}';

		var vertShader = gl.createShader(GL.VERTEX_SHADER);

		gl.shaderSource(vertShader, vertCode);
		gl.compileShader(vertShader);

		
		
		var fragCode = 
						'precision mediump float;' + 
						'varying vec2 v_texcoord;' + 
						'uniform sampler2D u_texture;' + 	
						'void main(void) {' + 
											'gl_FragColor = texture2D(u_texture, v_texcoord);'
											+ '}';

		var fragShader = gl.createShader(GL.FRAGMENT_SHADER);
		gl.shaderSource(fragShader, fragCode);
		gl.compileShader(fragShader);

		shaderProgram = gl.createProgram();
		gl.attachShader(shaderProgram, vertShader); 
		gl.attachShader(shaderProgram, fragShader);
		gl.linkProgram(shaderProgram);
		
		var timer:Timer = new Timer(60);
		timer.run = draw;
	}
	
	private function onDataLoded(e:DataEvent):Void 
	{
		var data:ArrayBufferView = cast e.data;
		var data2:ArrayBuffer = cast e.data;
		var buffer:UInt32Array = cast data2;
		
		canvas = cast Browser.document.getElementById("gameview");
		gl = canvas.getContextWebGL({
			alpha: false,
			antialias: false,
			depth: false,
			premultipliedAlpha: false,
			preserveDrawingBuffer: false,
			stencil: false
		});
		
		var colorSpace = 15;
		var rSize = 4;
		var gSize = 4;
		var bSize = 4;
		
		var textureSize:Int = 32;
		var data3:Array<Int> = new Array<Int>();
		var c:Int = 0;
		for (i in 0...textureSize)
		{
			for (j in 0...textureSize)
			{
				var r = Math.ceil(colorSpace / textureSize * i);
				var g = Math.ceil(colorSpace / textureSize * (textureSize - i));
				var b = Math.ceil(colorSpace / textureSize * j);
				
				data3[c++]  = (r << (16 - rSize)) | (g << (16 - rSize - gSize)) | (b << (16 - rSize - gSize - bSize)) | 1;
			}
		}
		//3075
		//4096 - 4096 - 2048 - 2048
		//2048
		texture = gl.createTexture();
		gl.bindTexture(GL.TEXTURE_2D, texture);
		gl.texImage2D(GL.TEXTURE_2D, 0, GL.RGBA, textureSize, textureSize, 0, GL.RGBA, GL.UNSIGNED_SHORT_4_4_4_4, new Uint16Array(data3));
		gl.bindTexture(GL.TEXTURE_2D, null);
		gl.flush();
		
		untyped __js__('webglInfo({0});', gl);
	}
	
	private function draw():Void
	{
		gl.clearColor(0.5, 0.5, 0.5, 0.9);
		gl.enable(GL.DEPTH_TEST); 
		gl.clear(GL.COLOR_BUFFER_BIT);
		gl.viewport(0, 0, canvas.height, canvas.height);
		
		gl.useProgram(shaderProgram);
		
		var positionLocation = gl.getAttribLocation(shaderProgram, "coordinates");
		var texcoordLocation = gl.getAttribLocation(shaderProgram, "a_texcoord");
		var textureLocation = gl.getUniformLocation(shaderProgram, "u_texture");
		
		gl.bindBuffer(GL.ARRAY_BUFFER, positionBuffer);
		gl.enableVertexAttribArray(positionLocation);
		gl.bindBuffer(GL.ELEMENT_ARRAY_BUFFER, Index_Buffer);
		gl.bindBuffer(GL.ARRAY_BUFFER, texcoordBuffer);
		
		gl.bindBuffer(GL.ARRAY_BUFFER, positionBuffer);
		gl.enableVertexAttribArray(positionLocation);
		gl.vertexAttribPointer(positionLocation, 3, GL.FLOAT, false, 0, 0);
		gl.bindBuffer(GL.ARRAY_BUFFER, texcoordBuffer);
		gl.enableVertexAttribArray(texcoordLocation);
		gl.vertexAttribPointer(texcoordLocation, 2, GL.FLOAT, false, 0, 0);
		
		ppxTexture.setToContext(gl);
		
		gl.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.CLAMP_TO_EDGE);
		gl.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.CLAMP_TO_EDGE);
		gl.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.NEAREST);
		
		gl.drawElements(GL.TRIANGLES, 6, GL.UNSIGNED_SHORT, 0);
		
		if(Math.random() > 0.8)
			untyped __js__('webglInfo({0});', gl);
	}
	
}