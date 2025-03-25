extends Node2D

var final_button_queue: Array
var removable_button_queue: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.game_start.connect(start_game)
	GameState.nav_main_menu.connect(load_main_menu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func simon_button_pressed(button_id: String):
	var cur_button:SimonButton = removable_button_queue.pop_front()
	if (cur_button != null):
		if (cur_button.button_id != button_id):
			game_end()
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
	var simon_buttons: Array = get_node("SimonBoard/SimonButtons").get_children()
	
	var new_simon_button: SimonButton = simon_buttons[randi_range(0, simon_buttons.size()-1)]
	#new_simon_button.play_highlight()
	#return new_simon_button.button_id
	return new_simon_button

func play_button_sequence():
	reset_highlight_for_all_simon_buttons()
	SimonBottonSignals.sequence_playing.emit(true)
	
	for simon_button:SimonButton in final_button_queue:
		simon_button.highlight()
		simon_button.enabled = false
		
		await get_tree().create_timer(1).timeout
		simon_button.reset_highlight()
		
		await get_tree().create_timer(.5).timeout
		
	SimonBottonSignals.sequence_playing.emit(false)

	
func reset_highlight(simon_button: SimonButton):
	#simon_button.reset_highlight()b
	simon_button.enabled = true
	
func start_game():
	clear_children()
	clear_simon_button_queues()
	add_child(preload("res://scene/main/simon_board/simon_board.tscn").instantiate())
	
	SimonBottonSignals.simon_button_pressed.connect(simon_button_pressed)
	
	var new_simon_button = get_new_simon_button()
	
	final_button_queue.push_back(new_simon_button)
	removable_button_queue = final_button_queue.duplicate(true)
	
	play_button_sequence()
	
func clear_children():
	for child in get_children():
		child.queue_free()
		
func game_end():
	clear_children()
	add_child(preload("res://scene/main/menu/game_end/game_end.tscn").instantiate())
		
		
func reset_highlight_for_all_simon_buttons(): 
	var simon_buttons: Array = get_node("SimonBoard/SimonButtons").get_children()
	
	for simon_button in simon_buttons:
		if simon_button.has_method("reset_highlight"):
			simon_button.reset_highlight()

func load_main_menu():
	clear_children()
	add_child(preload("res://scene/main/menu/main_menu/main_menu.tscn").instantiate())
	
func clear_simon_button_queues():
	final_button_queue = []
	removable_button_queue = []
