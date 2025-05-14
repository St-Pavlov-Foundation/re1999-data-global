module("modules.logic.dungeon.defines.DungeonPuzzleCircuitEnum", package.seeall)

local var_0_0 = _M

var_0_0.hintCount = 3
var_0_0.pipeEntryClearCount = 2
var_0_0.pipeEntryClearDecimal = 10
var_0_0.dir = {
	down = 2,
	up = 8,
	left = 4,
	right = 6
}
var_0_0.type = {
	t_shape = 7,
	corner = 6,
	capacitance = 3,
	wrong = 4,
	power1 = 1,
	straight = 5,
	power2 = 2
}
var_0_0.status = {
	correct = 2,
	error = 3,
	normal = 1
}
var_0_0.res = {
	[var_0_0.type.power1] = {
		"bg_zhogndian_1"
	},
	[var_0_0.type.power2] = {
		"bg_zhogndian"
	},
	[var_0_0.type.capacitance] = {
		"bg_dianyuan_1",
		"bg_dianyuan"
	},
	[var_0_0.type.wrong] = {
		"bg_yichangqu"
	},
	[var_0_0.type.straight] = {
		"bg_dianlu_1",
		"bg_dianlu_1_ovr",
		"bg_dianlu_1_dis"
	},
	[var_0_0.type.corner] = {
		"bg_dianlu",
		"bg_dianlu_ovr",
		"bg_dianlu_dis"
	},
	[var_0_0.type.t_shape] = {
		"bg_dianlu_2",
		"bg_dianlu_2_ovr",
		"bg_dianlu_2_dis"
	}
}
var_0_0.rotate = {
	[var_0_0.type.straight] = {
		[28] = {
			0
		},
		[46] = {
			90
		}
	},
	[var_0_0.type.corner] = {
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
	[var_0_0.type.t_shape] = {
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

return var_0_0
