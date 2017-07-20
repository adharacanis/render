package gl.bufferContext;

@:allow(gl)
#if html5
	typedef InternalBuffer = js.html.webgl.Buffer;
#else
	typedef InternalBuffer = Int;
#end