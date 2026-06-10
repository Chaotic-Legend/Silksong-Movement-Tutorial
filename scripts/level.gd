extends Node2D

@onready var pause_label: Label = $UI/CenterContainer/PauseLabel

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	pause_label.visible = false
	get_tree().paused = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()
	if event.is_action_pressed("reset"):
		get_tree().paused = false
		get_tree().reload_current_scene()
	if event.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused
		pause_label.visible = get_tree().paused
