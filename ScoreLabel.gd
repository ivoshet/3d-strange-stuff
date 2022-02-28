extends Label
var score:int= 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Mob_squashed():
	score += 1
	print('?????????')
	text = "Score: %s" % score
	
