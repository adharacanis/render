package gl.bufferContext;

import gl.bufferContext.IBuffer;
import webgl.WebGLContext;

class BaseBufferManager 
{
	public var currentInternalBuffer:InternalBuffer = null;
	
	var context:WebGLContext = null;

	public function new(context:WebGLContext) 
	{
		this.context = context;
	}
	
	public function useBuffer(buffer:IBuffer) {
		
		if(buffer.isBufferInUse)
			return;
			
		if (!buffer.isInitialize)
			initialize(buffer);
	}
	
	public function __useBuffer(type:BufferType, buffer:InternalBuffer) { 
		if (currentInternalBuffer == buffer)
			return;
			
		currentInternalBuffer = buffer;
		context.useBuffer(type, currentInternalBuffer);
	}
	
	function initialize(buffer:IBuffer) 
	{
		buffer.initialize();
	}
	
	public function useVertexBuffer(buffer:VertexBuffer) {
		
	}
	
	public function useIndexBuffer(buffer:IndexBuffer) {
		
	}
	
	public function useUniformBuffer(buffer:UniformBuffer) {
		
	}
}