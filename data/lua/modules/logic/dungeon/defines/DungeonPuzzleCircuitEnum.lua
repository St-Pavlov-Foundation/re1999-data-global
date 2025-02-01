module("modules.logic.dungeon.defines.DungeonPuzzleCircuitEnum", package.seeall)

slot0 = _M
slot0.hintCount = 3
slot0.pipeEntryClearCount = 2
slot0.pipeEntryClearDecimal = 10
slot0.dir = {
	down = 2,
	up = 8,
	left = 4,
	right = 6
}
slot0.type = {
	t_shape = 7,
	corner = 6,
	capacitance = 3,
	wrong = 4,
	power1 = 1,
	straight = 5,
	power2 = 2
}
slot0.status = {
	correct = 2,
	error = 3,
	normal = 1
}
slot0.res = {
	[slot0.type.power1] = {
		"bg_zhogndian_1"
	},
	[slot0.type.power2] = {
		"bg_zhogndian"
	},
	[slot0.type.capacitance] = {
		"bg_dianyuan_1",
		"bg_dianyuan"
	},
	[slot0.type.wrong] = {
		"bg_yichangqu"
	},
	[slot0.type.straight] = {
		"bg_dianlu_1",
		"bg_dianlu_1_ovr",
		"bg_dianlu_1_dis"
	},
	[slot0.type.corner] = {
		"bg_dianlu",
		"bg_dianlu_ovr",
		"bg_dianlu_dis"
	},
	[slot0.type.t_shape] = {
		"bg_dianlu_2",
		"bg_dianlu_2_ovr",
		"bg_dianlu_2_dis"
	}
}
slot0.rotate = {
	[slot0.type.straight] = {
		[28] = {
			0
		},
		[46] = {
			90
		}
	},
	[slot0.type.corner] = {
		[24] = {
			0
		},
		[26] = {
			90
		},
		[68] = {
			180
		},
		[48] = {
			270
		}
	},
	[slot0.type.t_shape] = {
		[246] = {
			0
		},
		[268] = {
			90
		},
		[468] = {
			180
		},
		[248] = {
			270
		}
	}
}

return slot0
