extends Label

func update_score(points_scored: int):
	var score = int(text)
	score += points_scored
	text = str(score)

func reset():
	text = str(0)
