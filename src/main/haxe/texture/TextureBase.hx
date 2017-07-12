package texture;

class TextureBase 
{
	public var format:TextureFormat;
	public var dataFormat:TextureDataFormat;
	
	public var width:Int;
	public var height:Int;
	
	public var memorySize(get, null):Float;
	public var gpuMemorySize(get, null):Float;
	
	public function new() 
	{
		
	}
	
	function get_memorySize():Float 
	{
		return 0;
	}
	
	function get_gpuMemorySize():Float 
	{
		return 0;
	}
}