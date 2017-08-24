package assets;
import assets.AssetsStorage;
import events.DataEvent;
import events.Event;
import events.Observer;
import external.DataLoader;
import haxe.io.Bytes;
import js.html.XMLHttpRequestResponseType;

class AssetLoader extends Observer
{
	var loadQue:Array<String> = [];
	
	var binaryTypes:Array<String> = ["ppx", "jpg", "jpeg", "png"];
	
	var currentLoading:String;
	
	var dataLoader:DataLoader = new DataLoader();
	var assetsStorage:AssetsStorage;
	
	var filesLoaded:Int;
	var filesTotal:Int;
	var isLoadInProgress:Bool;
	
	public function new(assetsStorage:AssetsStorage) 
	{
		super();
		this.assetsStorage = assetsStorage;
		initalize();
	}
	
	private function initalize() 
	{
		dataLoader.addEventListener(DataEvent.ON_LOAD, loadComplete);
	}
	
	public function addToQueue(path:String)
	{
		loadQue.push(path);
		filesTotal++;
		//var fileExtension:String = path.substr(path.lastIndexOf("."), path.length);
	}
	
	public function load()
	{
		loadNext();
	}
	
	function isBinary(extension:String):Bool
	{
		return binaryTypes.indexOf(extension) != -1;
	}
	
	function loadNext()
	{
		if (isLoadInProgress)
			return;
		
		currentLoading = loadQue.shift();
		var extension:String = currentLoading.substr(currentLoading.length - 3, 3);
		var isBinary:Bool = isBinary(extension);
		
		if (isBinary)
		{
			loadBinary(currentLoading);
		}
		else
		{
			throw "unknown type";
		}
	}
	
	private function loadComplete(e:DataEvent):Void 
	{
		filesLoaded++;
		
		var slashIndex:Int = currentLoading.indexOf("/") + 1;
		var fileName:String = currentLoading.substring(slashIndex, currentLoading.length - 4);
		var extension:String = currentLoading.substr(currentLoading.length - 3, 3);
		
		var data:Bytes = e.data;
		
		assetsStorage.addAsset(fileName, extension, data);
		
		if (loadQue.length == 0)
		{
			finishLoading();
			return;
		}
		else
		{
			loadNext();
		}
	}
	
	function finishLoading() 
	{
		trace('finish loading');
		dispatchEvent(new Event(Event.COMPLETE));
	}
	
	function loadBinary(path:String) 
	{
		dataLoader.load(path, XMLHttpRequestResponseType.ARRAYBUFFER);
	}
}