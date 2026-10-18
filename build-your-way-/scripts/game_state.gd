extends Node
## Autoload „GameState“ – bewusst OHNE class_name (sonst Namenskonflikt).
## Hält Daten über Szenen-Neustarts hinweg. Highscore vorerst nur im Speicher.

signal highscore_changed(new_highscore: int)

const DEFAULT_CAR_PATH: String = "res://resources/default_car.tres"

var highscore: int = 0

# --- Hooks für später (Shop/Skins) – noch NICHT benutzen ---
# var coins: int = 0
# var owned_car_ids: Array[StringName] = [&"default"]
# var selected_car_id: StringName = &"default"


## Gibt true zurück, wenn ein neuer Highscore erreicht wurde.
func submit_score(score: int) -> bool:
	if score > highscore:
		highscore = score
		highscore_changed.emit(highscore)
		return true
	return false


## Hook: liefert später das im Shop gewählte Auto. Jetzt immer das Standard-Auto.
func get_selected_car_config() -> CarConfig:
	return load(DEFAULT_CAR_PATH) as CarConfig
