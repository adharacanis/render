package geometry;

import haxe.ds.Vector;

class BaseGeometry implements IGeometry 
{
	private var indices:Vector<UInt>;
	private var vertices:Vector<Float>;
	private var uvs:Vector<Float>;
	
	public function new() 
	{
		
	}
	
	/**
	 * Map vertices indices to triangle
	 * @param	v1 - vertex index #1
	 * @param	v2 - vertex index #2
	 * @param	v3 - vertex index #3
	 */
	public function mapTriangle(v1:int, v2:int, v3:int):void
	{
		indices.push(v1, v2, v3);
		trianglesCount++;
	}
	
	/**
	 * Update specified triangle vertices indices
	 * @param	i - index of triangle
	 * @param	v1 - vertex index #1
	 * @param	v2 - vertex index #2
	 * @param	v3 - vertex index #3
	 */
	public function updateTriangleMap(i:int, v1:int, v2:int, v3:int):void 
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
	public function addVertexAndUV(x:Number, y:Number, u:Number, v:Number):void
	{
		minX = Math.min(x, minX);
		maxX = Math.max(x, maxX);
		minY = Math.min(y, minY);
		maxY = Math.max(y, maxY);
		
		width = Math.abs(minX - maxX);
		height = Math.abs(minY - maxY);
		
		verticesCount += 2;
		uvsCount += 2;
		
		vertices.push(x, y, u, v);
	}
	
	/**
	 * Update specified vertex x,y and u,v values, uses to fill up geometry in static mode or update vertices values
	 * @param	i - vertex index
	 * @param	x - vertex X value
	 * @param	y - vertex Y value
	 * @param	u - vertex U value
	 * @param	v - vertex V value
	 */
	public function setVertexAndUV(i:int, x:Number, y:Number, u:Number, v:Number):void
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
	public function setVertex(i:int, x:Number, y:Number):void
	{
		minX = Math.min(x, minX);
		maxX = Math.max(x, maxX);
		minY = Math.min(y, minY);
		maxY = Math.max(y, maxY);
		
		width = Math.abs(minX - maxX);
		height = Math.abs(minY - maxY);
		
		vertices[i] = x;
		vertices[i + 1] = y;
	}
	
	/**
	 * Add offset to all u,v valuse in geometry and update buffer if neccessary
	 * @param	u - u value offset
	 * @param	v - v value offset
	 * @param	updateBuffer - if set to true then UV buffer will be reupload
	 */
	public function addUVStride(u:Number, v:Number, updateBuffer:Boolean = true):void
	{
		for (var i:int = 0; i < verticesCount; i+=4)
		{
			vertices[i + 2] += u;
			vertices[i + 3] += v;
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
	public function setUV(i:int, u:Number, v:Number):void
	{
		vertices[i + 2] = u;
		vertices[i + 3] = v;
	}
	
	/**
	 * Call on render phase it need to set render support and update buffers if it neccessarry also set buffers to context
	 * @param	geometryContext
	 */
	public function setToContext(geometryContext:GeometryContext):void
	{
		if (!_init)
			init(geometryContext);
			
		setBuffers(geometryContext);
	}
	
	/**
	 * Set buffers to context at 0(x, y values), 1(u, v values)
	 * @param	geometryContext
	 */
	private function setBuffers(geometryContext:GeometryContext):void 
	{
		geometryContext.setVertexBufferAt(0, vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_2);
		geometryContext.setVertexBufferAt(1, vertexBuffer, 2, Context3DVertexBufferFormat.FLOAT_2);
	}
	
	/**
	 * fully reupload UV buffer
	 */
	public function updateUV():void
	{
		uploadVertexBuffer(verticesCount / 2);
	}
	
	/**
	 * Upload/reupload vertex buffer or just part of buffer
	 * @param	offset - start vertex index
	 * @param	length - number of vertices to upload
	 */
	public function uploadVertexBuffer(offset:int = 0, length:int = 0):void
	{
		if (!vertexBuffer)
			return;
			
		if (length == 0)
			length = numVertices;
		
		geometryContext.uploadVertexBuffer(vertexBuffer, vertices, offset, length);
	}
	
	/**
	 * Upload/reupload index buffer or just set part of buffer
	 * @param	offset - start index of indices
	 * @param	length - number of indices to upload
	 */
	public function uploadIndexBuffer(offset:int = 0, length:int = 0):void
	{
		if (!indexBuffer)
			return;
			
		if (length == 0)
			length = numVertices;
		
		geometryContext.uploadIndexBuffer(indexBuffer, indices, offset, length);
	}
	
	/**
	 * Init operation. Create buffers and upload them first time
	 * @param	geometryContext
	 */
	private function init(geometryContext:GeometryContext):void 
	{
		_init = true;
		
		this.geometryContext = geometryContext;
		
		numVertices = vertices.length / 4;
		
		vertexBuffer = geometryContext.createVertexBuffer(numVertices, 4);
		indexBuffer = geometryContext.createIndexBuffer(indices.length);
		
		uploadVertexBuffer(0, numVertices);
		uploadIndexBuffer(0, indices.length);
	}
	
	/**
	 * Fully dispose geometry, release GPU memory and destroy buffers
	 */
	public function dispose():void 
	{
		if (geometryContext)
		{
			geometryContext.disposeIndexBuffer(indexBuffer)
			geometryContext.disposeVertexBuffer(vertexBuffer)
		}
	}
}