package texture;

@:enum
abstract TextureDataFormat(Int) from Int to Int
{
	var BYTE = 5121;
	var BYTE_565 = 33635;
	var BYTE_4444 = 32819;
	var BYTE_5551 = 32820;
}