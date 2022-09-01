extends Node2D

func _ready():
	var cross := $cross

	(
		Anima.begin(self)
			.set_default_duration(1)
			.then( Anima.Node(cross).anima_relative_position_x(100).anima_easing(ANIMA.EASING.EASE_OUT_SINE) )
			.with( Anima.Node(cross).anima_rotate(TAU).anima_from(0).anima_easing(ANIMA.EASING.EASE_OUT_SINE) )

			.then( Anima.Node(cross).anima_relative_position_y(100) )
			.with( Anima.Node(cross).anima_rotate(-TAU).anima_from(0) )

			.then( Anima.Node(cross).anima_relative_position_x(-100) )
			.with( Anima.Node(cross).anima_rotate(0).anima_from(TAU) )

			.then( Anima.Node(cross).anima_relative_position_y(-100).anima_easing(ANIMA.EASING.EASE_IN_CIRC) )
			.with( Anima.Node(cross).anima_rotate(-TAU).anima_from(0).anima_easing(ANIMA.EASING.EASE_IN_CIRC) )

			.play_backwards_with_delay(0.2)
	)
