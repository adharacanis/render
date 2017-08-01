package;
import events.Event;
import events.Observer;
import js.Browser;

class FrameRunner extends Observer
{
	var updateEvent:Event = new Event(Event.UPDATE);
	var stats:Stats;

	public function new() 
	{
		super();
		stats = new Stats();
		stats.showPanel(0);
		
		Browser.document.body.appendChild(stats.dom);
	}
	
	public function start() 
	{
		requestAnimationFrame();
	}
	
	inline function requestAnimationFrame() 
	{
		Browser.window.requestAnimationFrame(onEnterFrame);
	}
	
	function onEnterFrame(?_) 
	{
		if (!Browser.document.hidden) 
		{
			stats.begin();
			dispatchEvent(updateEvent);
			stats.end();
			requestAnimationFrame();
		}
	}
}