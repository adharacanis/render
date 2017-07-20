package external;

import events.DataEvent;
import events.Observer;
import js.Browser;
import js.html.XMLHttpRequest;
import js.html.XMLHttpRequestResponseType;

class DataLoader extends Observer
{
	static public inline var ON_LOAD:String = "onLoad";
	
	private var httpRequest:XMLHttpRequest;
	
	public function new() 
	{
		super();
		
		httpRequest = Browser.createXMLHttpRequest();
		httpRequest.onload = onLoadComplete;
	}
	
	public function load(path:String, type:XMLHttpRequestResponseType):Void
	{
		httpRequest.responseType = XMLHttpRequestResponseType.ARRAYBUFFER;
		httpRequest.open("GET", path, true);
		httpRequest.send();
	}
	
	private function onLoadComplete() 
	{
		var data:Dynamic = httpRequest.response;
		
		dispatchEvent(new DataEvent(DataEvent.ON_LOAD, data));
	}
}