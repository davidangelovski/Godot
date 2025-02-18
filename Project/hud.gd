extends CanvasLayer

@onready var timer_label: Label = $TimerLabel
@onready var counter_label: Label = $CounterLabel
@onready var win_label: Label = $WinLabel
@onready var loss_label: Label = $LossLabel
@onready var timer: Timer = $Timer

var total_treasures = 0
var collected_treasures = 0
var game_running = true

func _ready():
	# Find the total number of treasures at the start
	total_treasures = get_tree().get_nodes_in_group("Treasures").size()
	update_labels()
	
	# Hide win/loss labels initially
	win_label.visible = false
	loss_label.visible = false

	# Offset labels so they don’t overlap
	timer_label.position = Vector2(20, 20)  # Top-left corner
	counter_label.position = Vector2(20, 60)  # Below the timer


	# Connect timer timeout signal
	timer.timeout.connect(_on_timer_timeout)
	
	# Start the timer
	timer.start()

func _process(_delta):
	# Update the timer display every frame
	if game_running:
		update_timer_label()

func update_timer_label():
	var time_left = max(timer.time_left, 0)  # Ensure it never goes negative
	var minutes = int(time_left) / 60
	var seconds = int(time_left) % 60
	timer_label.text = "Time: %02d:%02d" % [minutes, seconds]

func update_labels():
	update_timer_label()
	counter_label.text = "Treasures: %d/%d" % [collected_treasures, total_treasures]

func _on_timer_timeout():
	game_over(false)  # Time ran out, player loses

func _on_treasure_collected():
	if game_running:
		collected_treasures += 1
		update_labels()
		
		# Check if the player won
		if collected_treasures >= total_treasures:
			game_over(true)

func game_over(player_won: bool):
	game_running = false
	get_tree().paused = true  # Pause game logic

	if player_won:
		win_label.visible = true
	else:
		loss_label.visible = true
