package gl.bufferContext.data;
import haxe.io.Bytes;

class DataComponent implements IDataComponent
{

	public function new() 
	{
		
	}
	
	public function write(dataSource:Bytes, position:Int):Int {
		return position;
	}
	
}