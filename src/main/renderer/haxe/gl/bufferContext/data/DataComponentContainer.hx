package gl.bufferContext.data;
import haxe.io.Bytes;

class DataComponentContainer implements IDataComponent 
{
	var components:Array<IDataComponent> = new Array();

	public function new() 
	{
		
	}
	
	public function addComponent(component:IDataComponent) 
	{
		components.push(component);
	}
	
	public function write(dataSource:Bytes, position:Int):Int 
	{
		for (component in components)
		{
			position = component.write(dataSource, position);
		}
		
		return position;
	}
	
}