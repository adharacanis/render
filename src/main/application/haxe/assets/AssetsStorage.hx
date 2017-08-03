package assets;

import haxe.io.Bytes;

class AssetsStorage 
{
	var binaryAssets:Map<String, BinaryAsset> = new Map();
	
	public function new() 
	{
		
	}
	
	public function addData(fileName:String, data:Bytes) 
	{
		var asset:BinaryAsset = new BinaryAsset();
		asset.setData(data);
		binaryAssets.set(fileName, asset);
	}
}