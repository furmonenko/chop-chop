extends CanvasLayer

var log_count: int = 0
@onready var label: Label = $LogsLabel

func add_log():
	log_count += 1
	print("Logs picked up:", log_count)
	label.text = "Logs: %d" % log_count
