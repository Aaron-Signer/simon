extends TextureButton

var hovered: bool = false
@onready var button_polygon_2d = $ButtonPolygon2D

@export var button_id: String

func _ready():
	pass # Replace with rfunction body.

func _process(delta):
	if (hovered):
		button_polygon_2d.modulate = Color(button_polygon_2d.modulate, .5)
		
	if (!hovered):
		button_polygon_2d.modulate = Color(button_polygon_2d.modulate, 1)

func _on_mouse_entered():
	hovered = true


func _on_mouse_exited():
	hovered = false

func _on_pressed():
	SimonBottonSignals.simon_button_pressed.emit(button_id)
