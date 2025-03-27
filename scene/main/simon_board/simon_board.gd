extends Node2D

@onready var score_label: Label = $ScoreLabel

func _ready():
	GameState.update_score.connect(update_score)

func _process(delta):
	pass

func update_score(score: int):
	score_label.text = str(score)

	if score < 10:
		score_label.text = "0" + score_label.text
