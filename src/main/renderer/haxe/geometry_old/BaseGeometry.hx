package geometry_old;

import gl.Context;
import gl.bufferContext.AttributeType;
import gl.bufferContext.BufferContext;
import gl.bufferContext.IndexBuffer;
import gl.bufferContext.VertexBuffer;

class BaseGeometry
{
	private var indices:Array<UInt>;
	private var vertices:Array<Float>;
	private var uvs:Array<Float>;
	
	public var numVertices:Int;
	public var uvsCount:Int;
	
	public var _init:Bool;
		
	public var minX:Float = 0;
	public var maxX:Float = 0;
	public var minY:Float = 0;
	public var maxY:Float = 0;

	public var width:Float;
	public var height:Float;

	public var verticesCount:Int = 0;
	public var trianglesCount:Int = 0;
	
	private var geometryContext:BufferContext;
	
	public var indexBuffer:IndexBuffer;
	public var vertexBuffer:VertexBuffer;
	
	function new(trianglesCount:Int = 0, verticesCount:Int = 0, isStatic:Bool = false) 
	{
		this.verticesCount = verticesCount;
		this.trianglesCount = trianglesCount;
		
		vertices = new Vector.<Float>(verticesCount * 4, isStatic);
		indecis = new Vector.<UInt>(trianglesCount * 3, isStatic);
	}
	
	/**
	 * Map vertices indices to triangle
	 * @param	v1 - vertex index #1
	 * @param	v2 - vertex index #2
	 * @param	v3 - vertex index #3
	 */
	public function mapTriangle(v1:Int, v2:Int, v3:Int)
	{
		indices.push(v1);
		indices.push(v2);
		indices.push(v3);
		
		trianglesCount++;
	}
	
	/**
	 * Update specified triangle vertices indices
	 * @param	i - index of triangle
	 * @param	v1 - vertex index #1
	 * @param	v2 - vertex index #2
	 * @param	v3 - vertex index #3
	 */
	public function updateTriangleMap(i:Int, v1:Int, v2:Int, v3:Int) 
	{
		i *= 3;
		indices[i] = v1;
		indices[i + 1] = v2;
		indices[i + 2] = v3;
	}
	
	/**
	 * Push new vertex and uv to buffers, uses only with non static geometry
	 * @param	x - vertex X value
	 * @param	y - vertex Y value
	 * @param	u - vertex U value
	 * @param	v - vertex V value
	 */
	public function addVertexAndUV(x:Float, y:Float, u:Float, v:Float)
	{
		minX = Math.min(x, minX);
		maxX = Math.max(x, maxX);
		minY = Math.min(y, minY);
		maxY = Math.max(y, maxY);
		
		width = Math.abs(minX - maxX);
		height = Math.abs(minY - maxY);
		
		verticesCount += 2;
		uvsCount += 2;
		
		vertices.push(x);
		vertices.push(y);
		vertices.push(u);
		vertices.push(v);
	}
	
	/**
	 * Update specified vertex x,y and u,v values, uses to fill up geometry in static mode or update vertices values
	 * @param	i - vertex index
	 * @param	x - vertex X value
	 * @param	y - vertex Y value
	 * @param	u - vertex U value
	 * @param	v - vertex V value
	 */
	public function setVertexAndUV(i:Int, x:Float, y:Float, u:Float, v:Float):Void
	{
		minX = Math.min(x, minX);
		maxX = Math.max(x, maxX);
		minY = Math.min(y, minY);
		maxY = Math.max(y, maxY);
		
		width = Math.abs(minX - maxX);
		height = Math.abs(minY - maxY);
		
		i *= 4;
		
		vertices[i] = x;
		vertices[i + 1] = y;
		vertices[i + 2] = u;
		vertices[i + 3] = v;
	}
	
	/**
	 * Set specified vertex x, y values
	 * @param	i - vertex index
	 * @param	x - vertex X value
	 * @param	y - vertex Y value
	 */
	public function setVertex(i:Int, x:Float, y:Float)
	{
		minX = Math.min(x, minX);
		maxX = Math.max(x, maxX);
		minY = Math.min(y, minY);
		maxY = Math.max(y, maxY);
		
		width = Math.abs(minX - maxX);
		height = Math.abs(minY - maxY);
		
		i *= 2;
		
		vertices[i] = x * 1;
		vertices[i + 1] = y * 1;
	}
	
	/**
	 * Add offset to all u,v valuse in geometry and update buffer if neccessary
	 * @param	u - u value offset
	 * @param	v - v value offset
	 * @param	updateBuffer - if set to true then UV buffer will be reupload
	 */
	public function addUVStride(u:Float, v:Float, updateBuffer:Bool = true)
	{
		var i:Int = 0;
		while(i < verticesCount)
		{
			vertices[i + 2] += u;
			vertices[i + 3] += v;
			i += 4;
		}
		
		if(updateBuffer)
			updateUV();
	}
	
	/**
	 * Set or update specified vertex UV values
	 * @param	i - vertex index
	 * @param	u - vertex U value
	 * @param	v - vertex V value
	 */
	public function setUV(i:Int, u:Float, v:Float)
	{
		vertices[i + 2] = u;
		vertices[i + 3] = v;
	}
	
	/**
	 * Call on render phase it need to set render support and update buffers if it neccessarry also set buffers to context
	 * @param	geometryContext
	 */
	public function setToContext(geometryContext:BufferContext)
	{
		if (!_init)
			init(geometryContext);
			
		setBuffers(geometryContext);
	}
	
	/**
	 * Set buffers to context at 0(x, y values), 1(u, v values)
	 * @param	geometryContext
	 */
	private function setBuffers(geometryContext:BufferContext) 
	{
		vertexBuffer.mapAttributes(0, 2, AttributeType.FLOAT, true, 16, 8);
		
		if(Context.instancedExtension != null)
			Context.instancedExtension.vertexAttribDivisorANGLE(0, 0);
		
		vertexBuffer.mapAttributes(2, 2, AttributeType.FLOAT, false, 16, 0);
		
		if(Context.instancedExtension != null)
			Context.instancedExtension.vertexAttribDivisorANGLE(1, 0);
		
		//geometryContext.setVertexBufferAt(0, vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_2);
		//geometryContext.setVertexBufferAt(1, vertexBuffer, 2, Context3DVertexBufferFormat.FLOAT_2);
	}
	
	/**
	 * fully reupload UV buffer
	 */
	public function updateUV()
	{
		uploadVertexBuffer(Std.int(verticesCount / 2));
	}
	
	/**
	 * Upload/reupload vertex buffer or just part of buffer
	 * @param	offset - start vertex index
	 * @param	length - Float of vertices to upload
	 */
	public function uploadVertexBuffer(offset:Int = 0, length:Int = 0)
	{
		if (vertexBuffer == null)
			return;
			
		if (length == 0)
			length = numVertices;
		
		geometryContext.uploadBufferFromArray(vertexBuffer, vertices, offset, length);
	}
	
	/**
	 * Upload/reupload index buffer or just set part of buffer
	 * @param	offset - start index of indices
	 * @param	length - Float of indices to upload
	 */
	public function uploadIndexBuffer(offset:Int = 0, length:Int = 0)
	{
		if (indexBuffer == null)
			return;
			
		if (length == 0)
			length = numVertices;
		
		//geometryContext.uploadBufferFromArray(indexBuffer, indices, offset, length);
		geometryContext.uploadBufferFromArray16(indexBuffer, indices, offset, length);
	}
	
	/**
	 * Init operation. Create buffers and upload them first time
	 * @param	geometryContext
	 */
	private function init(geometryContext:BufferContext) 
	{
		_init = true;
		
		this.geometryContext = geometryContext;
		
		numVertices = Std.int(vertices.length / 4);
		
		vertexBuffer = geometryContext.createVertexBuffer(numVertices, 4);
		indexBuffer = geometryContext.createIndexBuffer(indices.length, 1);
		
		upload();
		
		uploadIndexBuffer(0, indices.length);
	}
	
	public function upload()
	{
		uploadVertexBuffer(0, numVertices);
	}
	
	/**
	 * Fully dispose geometry, release GPU memory and destroy buffers
	 */
	public function dispose() 
	{
		if (geometryContext != null)
		{
			geometryContext.disposeBuffer(indexBuffer);
			geometryContext.disposeBuffer(vertexBuffer);
		}
	}
}