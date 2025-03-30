extends Control

@onready var text_edit:TextEdit = $TextEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	GameState.game_start.emit()


func _on_text_edit_text_changed():
	GameState.player_name = text_edit.text
