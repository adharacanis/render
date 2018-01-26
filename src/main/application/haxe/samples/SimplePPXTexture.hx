package samples;
import assets.BinaryAsset;
import events.Event;
import external.data.PPXData;
import gl.bufferContext.data.BufferDataSource;
import haxe.io.Bytes;
import js.html.compat.ArrayBuffer;
import texture.PPXTexture;
import texture.TextureBase;
import webgl.WebGLContext;

class SimplePPXTexture extends SampleBase 
{
	public static function main()
	{
		new SimplePPXTexture();
		
		var bufferDataSource:BufferDataSource<Float> = new BufferDataSource<Float>();
	}
	
	public function new() 
	{
		super();
		
		var arr:ArrayBuffer = new ArrayBuffer();
		var b:Bytes = Bytes.alloc(123);
		b.getInt32(0);
		b.setInt32(0, 1234);
		
		return;
	}
	
	override function buildAssetsList() 
	{
		super.buildAssetsList();
		
		assetsLoader.addToQueue("leaf.ppx");
	}
	
	override public function buildScene():Void 
	{
		super.buildScene();
		
		var asset:BinaryAsset = assetsStorage.getAsset("leaf");
		var data:PPXData = new PPXData(asset.content);
		var texture:TextureBase = new PPXTexture(data);
		
		texture.uploadToGL(WebGLContext.gl);
	}
	
	override public function onUpdate(e:Event):Void 
	{
		super.onUpdate(e);
	}
}