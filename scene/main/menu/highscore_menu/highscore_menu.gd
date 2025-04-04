extends Control

@onready var rich_text_label: RichTextLabel = $RichTextLabel

func _ready():
	load_highscore_from_save_data()

func load_highscore_from_save_data():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		# Creates the helper class to interact with JSON.
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object.
		var node_data:Dictionary = json.data
		var name = node_data.get("player_name")
		var score = node_data.get("player_score")
		print("")
		rich_text_label.text = rich_text_label.text + name + " : " + str(score) + "\n"


func _on_main_menu_button_pressed():
	GameState.nav_main_menu.emit()
