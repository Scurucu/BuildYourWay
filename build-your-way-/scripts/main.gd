extends Node2D
## Main: Start-Szene und Signal-Verteiler. Häppchen 1: Auto + Straße.

const CAR_START_OFFSET_X: float = 100.0

var _is_game_over: bool = false

@onready var road: Road = $World/Road
@onready var car: Car = $World/Car


func _ready() -> void:
	Input.use_accumulated_input = false
	car.reached_road_end.connect(_on_car_reached_road_end)
	car.global_position = Vector2(road.global_position.x + CAR_START_OFFSET_X, road.surface_y)
	car.start_driving(road)
	print("Start: Straßenende bei x = ", road.end_x, " | Tempo = ", car.current_speed, " px/s")


func _input(event: InputEvent) -> void:
	var touch := event as InputEventScreenTouch
	if touch != null and touch.pressed:
		print("Tap erkannt bei ", touch.position) # Häppchen 2: Block fallen lassen


func _on_car_reached_road_end() -> void:
	print("Auto hat das Straßenende erreicht (x = ", road.end_x, ")")
	game_over()


func game_over() -> void:
	if _is_game_over:
		return
	_is_game_over = true
	car.stop_driving()
	var distance: int = int(car.global_position.x)
	var is_new_record: bool = GameState.submit_score(distance)
	print("GAME OVER – Distanz: ", distance, " px | neuer Highscore: ", is_new_record)
