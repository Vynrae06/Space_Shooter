extends Control

@onready var name_text_edit: LineEdit = $NameTextEdit
const save_path: String = "user://scores.tres"
var score_saved: bool = false

func _ready():
	var win_time_text: String
	if Global.WIN_TIME.is_empty():
		win_time_text = "00:00:00"
	else:
		win_time_text = Global.WIN_TIME
	$WinTimeLabel.text = win_time_text
	$NameTextEdit.grab_focus()

func _on_name_text_edit_text_submitted(player_name):
	if !score_saved:
		score_saved = true
		#save(Global.WIN_TIME, player_name)
		$NameTextEdit.text = ""
		# TODO: Say that the score was saved

func save(time, player_name):
	var save_data = {
		"time": time,
		"name": player_name
	}

	var scores: FileAccess
	if FileAccess.file_exists(save_path):
		scores = FileAccess.open(save_path, FileAccess.READ_WRITE)
	else:
		scores = FileAccess.open(save_path, FileAccess.WRITE_READ)
	
	scores.seek_end()
	scores.store_line(JSON.stringify(save_data))
	scores.close()

func _on_reset_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
