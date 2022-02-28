extends KinematicBody
signal squashed

export var min_speed = 10
export var max_speed = 18

var velocity = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	move_and_slide(velocity)
	
#будет вызываться из главной сцены для появления мобов
func initialize(start_position, player_position):
	translation = start_position
#	смотрит в сторону позиции персонажа игрока
	look_at(player_position, Vector3.UP)
#	рандомно поворачиваем моба на угол чтоб он не смотрел точно на игрока
	rotate_y(rand_range(-PI/4, PI/4))
#	задаем скорость
	var random_speed = rand_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	$AnimationPlayer.playback_speed = random_speed / min_speed
	
#сигнал от объекта, что он покидает приделы экрана
func _on_VisibilityNotifier_screen_exited():
	queue_free()
	
# сигнал, который испускает моб при столкновении с игроком
func squash():
	emit_signal("squashed")
	queue_free()
