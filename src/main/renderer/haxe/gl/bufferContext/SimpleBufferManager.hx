package gl.bufferContext;
import gl.bufferContext.IBuffer;
import haxe.ds.HashMap;
import haxe.ds.Vector;
import webgl.WebGLContext;

/**
 * Simple buffer allocator
 * each buffer will have own glBuffer
 */
class SimpleBufferManager extends BaseBufferManager
{
	var allocatedBuffers:Array<InternalBuffer> = new Array<InternalBuffer>();
	var bufferToInternalBuffer:HashMap<IBuffer, InternalBuffer> = new HashMap<IBuffer, InternalBuffer>();
	
	public function new(context:WebGLContext) 
	{
		super(context);
	}
	
	override public function useBuffer(buffer:IBuffer) 
	{
		super.useBuffer(buffer);
		
		__useBuffer(buffer.type, bufferToInternalBuffer.get(buffer));
	}
	
	override function initialize(buffer:IBuffer) 
	{
		super.initialize(buffer);
		
		var internalBuffer:InternalBuffer = context.createBuffer();
		allocatedBuffers.push(internalBuffer);
		bufferToInternalBuffer.set(buffer, internalBuffer);
	}
	
}