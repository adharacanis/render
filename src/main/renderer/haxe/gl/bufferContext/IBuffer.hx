package gl.bufferContext;

import gl.bufferContext.InternalBuffer;

interface IBuffer 
{
	@:allow(gl) private var isBufferInUse:Bool;
	@:allow(gl) private var isInitialize:Bool;
	@:allow(gl) private var type:BufferType;
	@:allow(gl) private var usage:BufferUsage;
	
	function initialize():Void;
	function hashCode():Int;
}