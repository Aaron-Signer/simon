extends Node2D

var final_button_queue: Array
var removable_button_queue: Array

@onready var timer = $Timer
@onready var simon_bottons = $SimonBottons
@onready var button_sequence_timer:Timer = $ButtonSequenceTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	SimonBottonSignals.simon_button_pressed.connect(simon_button_pressed)
	
	var new_simon_button = get_new_simon_button()
	
	final_button_queue.push_back(new_simon_button)
	removable_button_queue = final_button_queue.duplicate(true)
	
	play_button_sequence()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func simon_button_pressed(button_id: String):
	var cur_button:SimonButton = removable_button_queue.pop_front()
	if (cur_button != null):
		if (cur_button.button_id != button_id):
			print("lost")
		else:
			if (removable_button_queue.front() == null):
				var new_simon_button = get_new_simon_button()
				final_button_queue.push_back(new_simon_button)
				removable_button_queue = final_button_queue.duplicate(true)
				play_button_sequence()


func _on_timer_timeout():
	pass
	#button_queue.push_back(button_list[randi_range(0, 3)])

func get_new_simon_button() -> SimonButton:
	var simon_buttons:Array = simon_bottons.get_children()
	var new_simon_button:SimonButton = simon_buttons[randi_range(0, simon_buttons.size()-1)]
	#new_simon_button.play_highlight()
	#return new_simon_button.button_id
	return new_simon_button

func play_button_sequence():
	SimonBottonSignals.sequence_playing.emit(true)
	
	for simon_button:SimonButton in final_button_queue:
		simon_button.highlight()
		simon_button.enabled = false
		
		var sig = button_sequence_timer.timeout
		button_sequence_timer.timeout.connect(simon_button.reset_highlight)
		button_sequence_timer.start()

		await sig
		
		await get_tree().create_timer(.5).timeout
		
	SimonBottonSignals.sequence_playing.emit(false)
	
func test():
	print("here")
	
func reset_highlight(simon_button: SimonButton):
	#simon_button.reset_highlight()b
	simon_button.enabled = true
	
