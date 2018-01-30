package samples;
import assets.BinaryAsset;
import events.Event;
import external.data.PPXData;
import geometry.QuadGeometry;
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
		
		
		
		var quad:QuadGeometry = new QuadGeometry();
	}
	
	override public function onUpdate(e:Event):Void 
	{
		super.onUpdate(e);
	}
}