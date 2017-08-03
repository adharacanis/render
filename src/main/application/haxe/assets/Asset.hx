package assets;

class Asset<T>
{
	var content(get, null):T;
	
	public function new() 
	{
		
	}
	
	function get_content():T 
	{
		return content;
	}
	
	public function setData(data:T)
	{
		this.content = data;
	}
}