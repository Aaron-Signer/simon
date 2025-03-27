extends Node2D

@onready var score_label: Label = $ScoreLabel
@onready var simon_buttons = $SimonButtons

var final_button_queue: Array
var removable_button_queue: Array


func _ready():
	GameState.update_score.connect(update_score)
	start_game()

func _process(delta):
	pass


func update_score(score: int):
	score_label.text = str(score)

	if score < 10:
		score_label.text = "0" + score_label.text

func simon_button_pressed(button_id: String):
	var cur_button:SimonButton = removable_button_queue.pop_front()
	if (cur_button != null):
		if (cur_button.button_id != button_id):
			GameState.game_end.emit()
		else:
			if (removable_button_queue.front() == null):
				GameState.update_score.emit(final_button_queue.size())
				var new_simon_button = get_new_simon_button()
				final_button_queue.push_back(new_simon_button)
				removable_button_queue = final_button_queue.duplicate(true)
				play_button_sequence()


func get_new_simon_button() -> SimonButton:
	var simon_buttons: Array = simon_buttons.get_children()
	
	var new_simon_button: SimonButton = simon_buttons[randi_range(0, simon_buttons.size()-1)]
#	TODO: Figure out reset function
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

	
# TODO: May need to be removed
func reset_highlight(simon_button: SimonButton):
	#simon_button.reset_highlight()b
	simon_button.enabled = true
	
func start_game():
	clear_simon_button_queues()
	
	SimonBottonSignals.simon_button_pressed.connect(simon_button_pressed)
	
	var new_simon_button = get_new_simon_button()
	
	final_button_queue.push_back(new_simon_button)
	removable_button_queue = final_button_queue.duplicate(true)
	
	play_button_sequence()
		
func reset_highlight_for_all_simon_buttons(): 
	var simon_buttons: Array = simon_buttons.get_children()
	
	for simon_button in simon_buttons:
		if simon_button.has_method("reset_highlight"):
			simon_button.reset_highlight()
	
func clear_simon_button_queues():
	final_button_queue = []
	removable_button_queue = []
