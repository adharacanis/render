package geometry;

class QuadGeometry extends Geometry 
{
	/**
	 * геометрия - представление вертексов и вероятно мап индексов(но не факт)
	 * 
	 * нужно иметь предсавление для программы например а,б,ц,д вертексы с позициями с которыми можно работать
	 * и представление бинарное котрое можно сразу передать в буфер либо батч
	 */
	
	var a:Vertex = new Vertex();
	var b:Vertex = new Vertex();
	var c:Vertex = new Vertex();
	var d:Vertex = new Vertex();
	
	public function new() 
	{
		super();
	}
}