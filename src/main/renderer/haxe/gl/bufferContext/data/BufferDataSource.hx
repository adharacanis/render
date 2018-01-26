package gl.bufferContext.data;

class BufferDataSource<T> implements IBufferDataSource<T>
{
	var data:Array<T> = new Array();

	public function new() 
	{
		
	}
	
	public function setValue(index:Int, value:T) {
		data[index] = value;
	}
	
}