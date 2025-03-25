extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_main_menu_button_pressed():
	GameState.nav_main_menu.emit()


func _on_play_again_button_pressed():
	GameState.game_start.emit()
