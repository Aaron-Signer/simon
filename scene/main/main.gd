extends Node2D

var button_queue: Array
@onready var timer = $Timer

var button_list: Array = ["top_left", "top_right", "bottom_left", "bottom_right"]

# Called when the node enters the scene tree for the first time.
func _ready():
	SimonBottonSignals.simon_button_pressed.connect(simon_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func simon_button_pressed(button_id: String):
	button_queue.push_back(button_id)


func _on_timer_timeout():
	button_queue.push_back(button_list[randi_range(0, 3)])
