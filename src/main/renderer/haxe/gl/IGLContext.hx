package gl;

import gl.bufferContext.BufferType;
import gl.bufferContext.BufferUsage;
import gl.bufferContext.InternalBuffer;

interface IGLContext 
{
	public function request():Void;
	
	function createBuffer():InternalBuffer;
	function disposeBuffer(buffer:InternalBuffer):Void;
	function useBuffer(type:BufferType, buffer:InternalBuffer):Void;
	function uploadBufferData(type:BufferType, data:Array<Float>, usage:BufferUsage):Void;
	function uploadBufferSubData(type:BufferType, value:Array<Float>, offset:UInt):Void;
	
	function update():Void;
}