package samples;
import assets.BinaryAsset;
import events.Event;
import external.data.PPXData;
import texture.PPXTexture;
import texture.TextureBase;
import webgl.WebGLContext;

class SimplePPXTexture extends SampleBase 
{
	public static function main()
	{
		new SimplePPXTexture();
	}
	
	public function new() 
	{
		super();
		
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
		
	}
}