package gl.bufferContext;

import gl.bufferContext.InternalBuffer;
import gl.bufferContext.VertexBuffer;

interface IBufferContext 
{
	//@:allow(gl) private function createBuffer():InternalBuffer;
	@:allow(gl) public function disposeBuffer(buffer:IBuffer):Void;
	
	//public function uploadBufferFromArray(buffer:IBuffer, value:Array<Float>, offset:UInt = 0, length:UInt = 0):Void;
}