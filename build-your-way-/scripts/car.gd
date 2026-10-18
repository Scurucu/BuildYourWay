class_name Car
extends Node2D
## Fährt automatisch nach rechts und meldet das Erreichen des Straßenendes.

signal reached_road_end

@export var config: CarConfig

@export_group("Geschwindigkeit")
@export var base_speed: float = 220.0
@export var min_speed: float = 150.0
@export var max_speed: float = 480.0
@export var speed_gain_on_perfect: float = 20.0 # ab Häppchen 2
@export var speed_loss_on_bad: float = 35.0 # ab Häppchen 2

var current_speed: float = 0.0
var is_driving: bool = false
var road: Road = null

@onready var body: ColorRect = $Body


func _ready() -> void:
	_apply_config()
	current_speed = clampf(base_speed * _get_speed_multiplier(), min_speed, max_speed)


func start_driving(target_road: Road) -> void:
	road = target_road
	is_driving = true


func stop_driving() -> void:
	is_driving = false


## x-Position der vorderen (rechten) Stoßstange in Weltkoordinaten.
func get_front_x() -> float:
	return global_position.x + body.size.x * 0.5


func _physics_process(delta: float) -> void:
	if not is_driving or road == null:
		return
	position.x += current_speed * delta
	if get_front_x() >= road.end_x:
		# Exakt an die Kante setzen, damit das Auto nicht „überfährt“.
		global_position.x = road.end_x - body.size.x * 0.5
		stop_driving()
		reached_road_end.emit()


func _apply_config() -> void:
	if config == null:
		push_warning("Car: Keine CarConfig gesetzt – nutze Werte aus der Szene.")
		return
	body.size = config.size
	body.position = Vector2(-config.size.x * 0.5, -config.size.y)
	body.color = config.body_color


func _get_speed_multiplier() -> float:
	if config == null:
		return 1.0
	return config.speed_multiplier
