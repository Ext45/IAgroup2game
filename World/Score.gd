extends Label

func update_score(points_scored: int):
	print("hi can you hear me")
	var score = int(text)
	score += points_scored
	text = str(score)

