package texture;

import gl.GL;
import haxe.io.ArrayBufferView;
import haxe.io.Bytes;
import haxe.io.UInt16Array;
import haxe.io.UInt8Array;

@:access(haxe.io)
class ByteArrayTexture extends TextureBase 
{
	var glTexture:js.html.webgl.Texture;
	public var data(get, null):Bytes;
	
	public function new() 
	{
		super();
	}
	
	function get_data():Bytes 
	{
		return null;
	}
	
	override public function uploadToGL(gl:GL) 
	{
		glTexture = gl.createTexture();
		gl.bindTexture(GL.TEXTURE_2D, glTexture);
		
		var arr = UInt16Array.fromBytes(data, 0);
		var view = arr.view;
		
		gl.texImage2D(GL.TEXTURE_2D, 0, textureFormat, width, height, 0, textureFormat, dataFormat, cast view);
		gl.bindTexture(GL.TEXTURE_2D, null);
	}
	
	public function setToContext(gl:GL) 
	{
		gl.bindTexture(GL.TEXTURE_2D, glTexture);
	}
	
}