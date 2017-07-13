package texture;
import gl.GL;

class TextureBase 
{
	public var textureFormat:TextureFormat = TextureFormat.RGBA;
	public var dataFormat:TextureDataFormat = TextureDataFormat.BYTE_4444;
	
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
	
	public function uploadToGL(gl:GL):Void
	{
		
	}
}