package samples;

class SimplePPXTexture extends SampleBase 
{
	public static function main()
	{
		new SimplePPXTexture();
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
}