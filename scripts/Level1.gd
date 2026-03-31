extends Node2D

@onready var hud_label : Label = $HUDLayer/HUDLabel

var _score    := 0
var _time_left: float = 400.0

func _ready() -> void:
	_update_hud()

func _process(delta: float) -> void:
	_time_left = max(_time_left - delta, 0.0)
	_update_hud()
	if _time_left <= 0.0:
		get_tree().reload_current_scene()

func add_score(points: int) -> void:
	_score += points
	_update_hud()

func _update_hud() -> void:
	hud_label.text = "MARIO  %06d        TIME  %03d" % [_score, int(_time_left)]
