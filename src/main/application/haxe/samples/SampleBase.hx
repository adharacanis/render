package samples;

import assets.AssetLoader;
import events.Event;
import gl.Driver;

class SampleBase 
{
	var driver:Driver;
	var frameRunner:FrameRunner;
	var assetsLoader:AssetLoader;

	public function new() 
	{
		initialize();
	}
	
	public function initialize():Void
	{
		assetsLoader = new AssetLoader();
		assetsLoader.addEventListener(Event.COMPLETE, onAssetsLoaded);
		
		buildAssetsList();
		loadResources();
		setupRendernigContext();
	}
	
	function buildAssetsList() 
	{
		
	}
	
	function loadResources() 
	{
		assetsLoader.load();
	}
	
	function onAssetsLoaded(e:Event)
	{
		buildScene();
		initApplicationFrameLoop();
	}
	
	public function setupRendernigContext():Void
	{
		driver = new Driver();
		driver.requestContext();
	}
	
	public function buildScene():Void
	{
		
	}
	
	public function initApplicationFrameLoop():Void
	{
		frameRunner = new FrameRunner();
		frameRunner.addEventListener(Event.UPDATE, onUpdate);
		frameRunner.start();
	}
	
	public function onUpdate(e:Event):Void 
	{
		driver.update();
	}
}