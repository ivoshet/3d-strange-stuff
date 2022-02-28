extends Node
# экспортируем скриптового моба в главную сцену
export (PackedScene) var mob_scene

func _ready():
	randomize()
	get_node("UserInterface/Retry").hide()
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		get_tree().reload_current_scene()

# таймер появления мобов
func _on_MobTimer_timeout():
	var mob = mob_scene.instance()
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	mob_spawn_location.unit_offset = randf()
	var player_position = get_node ("Player").transform.origin
	add_child(mob)
#	вызов функции on_Mob_squashed если есть сигнал от моба по столкновению
	mob.connect("squashed", $UserInterface/ScoreLabel, "_on_Mob_squashed")
	mob.initialize(mob_spawn_location.translation, player_position)

# действия если есть сигнал столкновения от игрока
func _on_Player_hit():
	get_node("MobTimer").stop()
	$UserInterface/Retry.show()	
	



