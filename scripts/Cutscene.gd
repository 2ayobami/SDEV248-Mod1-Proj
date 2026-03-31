extends Node

@onready var bg_rect      : ColorRect  = $BgRect
@onready var panel_label  : Label      = $PanelLabel
@onready var prompt_label : Label      = $PromptLabel
@onready var title_label  : Label      = $TitleLabel
@onready var anim         : AnimationPlayer = $AnimationPlayer

const PANELS := [
	{
		"bg"  : Color(0.02, 0.02, 0.10),
		"text": "Year 2026.\n\nDeep beneath a Kingdom,\nA scientist uncovers a dimensional rift\nleaking energy from a parallel world.",
	},
	{
		"bg"  : Color(0.05, 0.10, 0.05),
		"text": "The Kpumbas are not invaders.\nThey are REFUGEES\nfleeing their own dying dimension.",
	},
	{
		"bg"  : Color(0.15, 0.05, 0.02),
		"text": "But the rift is destabilising both Worlds.\nIf it isn't sealed from the inside,\neverything collapses.",
	},
	{
		"bg"  : Color(0.08, 0.04, 0.12),
		"text": "The scientis must cross the Kpumbas territory,\nreach the rift portal at World's End,\nand shut it down,\n\nbefore time runs out for everyone.",
	},
	{
		"bg"  : Color(0.0, 0.0, 0.0),
		"text": "\n\nAyobami reimagining...lol",
	},
]

var _current := 0

func _ready() -> void:
	prompt_label.text = "Press SPACE or ENTER to continue"
	_show_panel(_current)

func _show_panel(idx: int) -> void:
	var p: Dictionary = PANELS[idx]
	bg_rect.color = p["bg"]
	panel_label.text = p["text"]

	# Last panel shows the game title big
	if idx == PANELS.size() - 1:
		title_label.visible = true
		prompt_label.text   = "Press SPACE or ENTER to begin"
	else:
		title_label.visible = false
		prompt_label.text   = "Press SPACE or ENTER to continue"

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		_current += 1
		if _current >= PANELS.size():
			get_tree().change_scene_to_file("res://scenes/Level1.tscn")
		else:
			_show_panel(_current)
