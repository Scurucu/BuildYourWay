class_name CarConfig
extends Resource
## Daten eines Autos (Skin-Hook). Pro Auto später eine eigene .tres-Datei.

@export var id: StringName = &"default"
@export var display_name: String = "Standard-Auto"
@export var body_color: Color = Color(0.85, 0.2, 0.2)
@export var size: Vector2 = Vector2(64, 32)
@export var speed_multiplier: float = 1.0
