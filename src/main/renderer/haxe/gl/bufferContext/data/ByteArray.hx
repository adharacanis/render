package gl.bufferContext.data;
import haxe.io.UInt8Array.UInt8ArrayData;
import js.html.compat.ArrayBuffer;

class ByteArray 
{
	var data:UInt8ArrayData
	
	public function new() 
	{
		var arr:ArrayBuffer = new ArrayBuffer();
		arr[0] = 123;
	}
	
}