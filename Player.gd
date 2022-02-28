extends KinematicBody
export var speed = 14
export var fall_acceleration = 75
var velocity = Vector3.ZERO
# реализация прыжка
export var jump_impulse = 20
export var bounce_impulse = 16
signal hit

func _ready():
	pass
	
func _physics_process(delta):
	# задаем движение герою - вектор движения по трем координатам
	var direction = Vector3.ZERO
	# движение в зависимости от нажатой клавиши
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forvard"):
		direction.z -= 1
	# если движение было, то нормализуем вектор движения
	if direction != Vector3.ZERO:
		direction = direction.normalized()
#		перевод координат объекта в глобальные координаты
		$Pivot.look_at(translation + direction, Vector3.UP)
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity.y -= fall_acceleration * delta
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y += jump_impulse
#	метод для плавного движения персонажа
	velocity = move_and_slide(velocity, Vector3.UP)
	for index in range(get_slide_count()):
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("mob"):
			var mob = collision.collider
			if Vector3.UP.dot(collision.normal) > 0.1:
				mob.squash()
				velocity.y = bounce_impulse
	
func die():
	emit_signal("hit")
	queue_free()
		
# сигнал от цилиндра пересечений с врагом
func _on_MobDetector_body_entered(body):
	die()
	

