package system;

/**
 * ...
 * @author gNikro
 */
class Utils 
{

	public function new() 
	{
		
	}
	
	public static function sizeOf(value:Dynamic) 
	{
		if (Std.is(value, Array))
		{
			return sizeOfArray(value);
		}
		
		if (Reflect.hasField(value, "__size"))
			return Reflect.field(value, "__size");
		else
			return -1;
	}
	
	public static function sizeOfArray(array:Array<Dynamic>) 
	{
		var element = array[0];
		
		if (element == null)
			return 0;
			
		var elementSize = sizeOf(element);
		
		return elementSize * array.length;
	}
	
}