extends TextureButton
class_name SimonButton

var hovered: bool = false
var color: Color

var enabled: bool = true

@onready var button_polygon_2d = $ButtonPolygon2D
@onready var timer = $Timer

@export var button_id: String

func _ready():
	SimonBottonSignals.sequence_playing.connect(update_in_progress)
	color = modulate
	pass

func _process(delta):
	pass
	#if (hovered):
		#button_polygon_2d.modulate = Color(button_polygon_2d.modulate, 1)
		#
	#if (!hovered):
		#button_polygon_2d.modulate = Color(button_polygon_2d.modulate, .5)

func _on_mouse_entered():
	if enabled:
		button_polygon_2d.modulate = Color(button_polygon_2d.modulate, 1)


func _on_mouse_exited():
	if enabled:
		button_polygon_2d.modulate = Color(button_polygon_2d.modulate, .5)

func _on_pressed():
	if enabled:
		SimonBottonSignals.simon_button_pressed.emit(button_id)

func play_highlight():
	button_polygon_2d.modulate = Color(0,0,0)
	timer.connect("timeout", reset_highlight)
	timer.start()

func reset_highlight():
	enabled = true
	button_polygon_2d.modulate = color
	
func highlight():
	button_polygon_2d.modulate = Color(button_polygon_2d.modulate, 1)

	
func play_button():
	pass
	
func update_in_progress(in_progress: bool):
	enabled = !in_progress
