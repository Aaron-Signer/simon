extends Node2D

var final_button_queue: Array
var removable_button_queue: Array


func _ready():
	GameState.nav_main_menu.connect(load_main_menu)
	GameState.game_start.connect(game_start)
	GameState.game_end.connect(game_end)

func _process(delta):
	pass
	
	
func game_start():
	clear_children()
	add_child(preload("res://scene/main/simon_board/simon_board.tscn").instantiate())	
	
func game_end():
	clear_children()
	add_child(preload("res://scene/main/menu/game_end/game_end.tscn").instantiate())

func load_main_menu():
	clear_children()
	add_child(preload("res://scene/main/menu/main_menu/main_menu.tscn").instantiate())

func clear_children():
	for child in get_children():
		child.queue_free()
