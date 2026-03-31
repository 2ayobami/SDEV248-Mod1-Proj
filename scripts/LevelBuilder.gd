extends Node2D

const TILE_SIZE := 16
const GROUND_SRC  := 0
const BRICK_SRC   := 1
const QUESTION_SRC:= 2

func _place(tm: TileMap, src: int, col: int, row: int) -> void:
	tm.set_cell(0, Vector2i(col, row), src, Vector2i(0, 0))

func _row(tm: TileMap, src: int, c0: int, c1: int, row: int) -> void:
	for c in range(c0, c1 + 1):
		_place(tm, src, c, row)

func _col(tm: TileMap, src: int, col: int, r0: int, r1: int) -> void:
	for r in range(r0, r1 + 1):
		_place(tm, src, col, r)

@onready var tile_map : TileMap = $TileMap
@onready var hud_label: Label   = $HUDLayer/HUDLabel

var _score     := 0
var _time_left := 400.0

func _ready() -> void:
	_build_level()

func _build_level() -> void:
	_row(tile_map, GROUND_SRC, 0, 209, 13)
	_row(tile_map, GROUND_SRC, 0, 209, 14) 

	_place(tile_map, QUESTION_SRC, 16, 8) 
	_place(tile_map, QUESTION_SRC, 20, 8)   
	_place(tile_map, QUESTION_SRC, 21, 8)
	_place(tile_map, QUESTION_SRC, 22, 8)

	_row(tile_map, BRICK_SRC, 19, 23, 8)
	_place(tile_map, BRICK_SRC, 19, 8)
	_place(tile_map, BRICK_SRC, 23, 8)

	_row(tile_map, BRICK_SRC, 77, 83, 4)
	_place(tile_map, QUESTION_SRC, 78, 4)
	_place(tile_map, QUESTION_SRC, 80, 4)
	_place(tile_map, QUESTION_SRC, 81, 4)

	_place(tile_map, QUESTION_SRC, 77, 8)

	# Pipe 1 (x=28, height 2)
	_place(tile_map, GROUND_SRC, 28, 11)
	_place(tile_map, GROUND_SRC, 29, 11)
	_place(tile_map, GROUND_SRC, 28, 12)
	_place(tile_map, GROUND_SRC, 29, 12)

	# Pipe 2 (x=38, height 3)
	_place(tile_map, GROUND_SRC, 38, 10)
	_place(tile_map, GROUND_SRC, 39, 10)
	_place(tile_map, GROUND_SRC, 38, 11)
	_place(tile_map, GROUND_SRC, 39, 11)
	_place(tile_map, GROUND_SRC, 38, 12)
	_place(tile_map, GROUND_SRC, 39, 12)

	# Pipe 3 (x=46, height 4)
	_place(tile_map, GROUND_SRC, 46, 9)
	_place(tile_map, GROUND_SRC, 47, 9)
	for r in range(9, 13):
		_place(tile_map, GROUND_SRC, 46, r)
		_place(tile_map, GROUND_SRC, 47, r)

	# Pipe 4 (x=57, height 4)
	for r in range(9, 13):
		_place(tile_map, GROUND_SRC, 57, r)
		_place(tile_map, GROUND_SRC, 58, r)

	for step in range(4):
		var cx = 97 + step
		for r in range(13 - step, 13):
			_place(tile_map, GROUND_SRC, cx, r)

	for step in range(4):
		var cx = 100 + step
		for r in range(10 + step, 13):
			_place(tile_map, GROUND_SRC, cx, r)

	_row(tile_map, BRICK_SRC, 108, 111, 9)

	

	for step in range(8):
		var cx = 155 + step
		for r in range(13 - step, 13):
			_place(tile_map, GROUND_SRC, cx, r)


	for r in range(4, 13):
		_place(tile_map, GROUND_SRC, 163, r)

func _process(delta: float) -> void:
	_time_left = max(_time_left - delta, 0.0)
	hud_label.text = "MARIO  %06d        TIME  %03d" % [_score, int(_time_left)]
	if _time_left <= 0.0:
		get_tree().reload_current_scene()

func add_score(pts: int) -> void:
	_score += pts
