class_name Road
extends Node2D
## Verwaltet die Straßen-Segmente und kennt das Straßenende (end_x).

@export var segment_scene: PackedScene = preload("res://scenes/road_segment.tscn")
@export var segment_length: float = 256.0
@export var start_segments: int = 4
@export var max_segments_ahead: int = 3 # wird ab Häppchen 2 genutzt

var _segments: Array[Node2D] = []
var _next_local_x: float = 0.0

## Globale x-Koordinate der rechten Straßenkante.
var end_x: float:
	get:
		return global_position.x + _next_local_x

## Globale y-Koordinate der Fahrbahnoberfläche.
var surface_y: float:
	get:
		return global_position.y


func _ready() -> void:
	for _i in start_segments:
		add_segment()


## Hängt ein neues Segment rechts an und verschiebt damit end_x.
func add_segment() -> Node2D:
	if segment_scene == null:
		push_error("Road: segment_scene fehlt – road_segment.tscn im Inspector zuweisen!")
		return null
	var segment := segment_scene.instantiate() as Node2D
	segment.position = Vector2(_next_local_x, 0.0)
	add_child(segment)
	var asphalt := segment.get_node_or_null("Asphalt") as ColorRect
	if asphalt != null:
		asphalt.size.x = segment_length
	_segments.append(segment)
	_next_local_x += segment_length
	return segment
