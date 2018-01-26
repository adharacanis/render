package gl.bufferContext.data;
import haxe.io.Bytes;

interface IDataComponent 
{
	function write(dataSource:Bytes, position:Int):Int;
}