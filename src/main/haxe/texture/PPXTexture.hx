package texture;
import external.data.PPXData;
import haxe.io.Bytes;

class PPXTexture extends ByteArrayTexture 
{
	var ppxData:PPXData;
	
	public function new(data:PPXData) 
	{
		super();
		
		this.ppxData = data;
		this.width = data.header.width;
		this.height = data.header.height;
	}
	
	override function get_data():Bytes 
	{
		return format.tools.Inflate.run(ppxData.data);
	}
	
	override function get_memorySize():Float 
	{
		return ppxData.data.length;
	}
	
	override function get_gpuMemorySize():Float 
	{
		return width * height * 2;
	}
}