package;
import js.Browser;
import js.html.HtmlElement;

@:native("Stats")
extern class Stats 
{
	@:selfCall
	public function new():Void;
	
	public function begin():Void;
	public function end():Void;
	
	public function showPanel(index:Int):Void;
	
	public var dom:HtmlElement; 
}