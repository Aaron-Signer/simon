extends Node2D

@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.update_score.connect(update_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_score(score: int):
	label.text = str(score)
