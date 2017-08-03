package;

import events.Event;
import events.Observer;

import js.Browser;

class FrameRunner extends Observer
{
	var updateEvent:Event = new Event(Event.UPDATE);
	var stats:Stats;
	
	var window:js.html.Window;
	var document:js.html.HTMLDocument;

	public function new() 
	{
		super();
		stats = new Stats();
		stats.showPanel(0);
		
		window = Browser.window;
		document = Browser.document;
		
		document.body.appendChild(stats.dom);
	}
	
	public function start() 
	{
		requestAnimationFrame();
	}
	
	inline function requestAnimationFrame() 
	{
		window.requestAnimationFrame(onEnterFrame);
	}
	
	inline function onEnterFrame(timestamp:Float) 
	{
		if (!document.hidden) 
		{
			stats.begin();
			dispatchEvent(updateEvent);
			stats.end();
			requestAnimationFrame();
		}
	}
}