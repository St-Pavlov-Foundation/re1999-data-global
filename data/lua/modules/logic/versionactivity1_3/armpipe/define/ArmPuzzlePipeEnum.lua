module("modules.logic.versionactivity1_3.armpipe.define.ArmPuzzlePipeEnum", package.seeall)

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
	first = 1,
	last = 2,
	corner = 6,
	wrong = 4,
	t_shape = 7,
	signsingle = 3,
	straight = 5,
	zhanwei = 8
}
var_0_0.status = {
	correct = 2,
	normal = 1
}
var_0_0.pathColor = {
	[0] = "#FFFFFF",
	"#BE8757",
	"#BB5F4C"
}
var_0_0.entryColor = {
	[0] = "#FFFFFF",
	"#9A4B05",
	"#AA0F09"
}
var_0_0.entryTypeColor = {
	[var_0_0.type.first] = {
		[1] = "#9D4D01",
		[2] = "#A93737"
	},
	[var_0_0.type.last] = {
		[1] = "#9D4D01",
		[2] = "#A93737"
	}
}
var_0_0.ruleConnect = {
	[var_0_0.type.first] = 2468,
	[var_0_0.type.last] = 2468,
	[var_0_0.type.signsingle] = 2468,
	[var_0_0.type.wrong] = 2468,
	[var_0_0.type.straight] = 28,
	[var_0_0.type.corner] = 26,
	[var_0_0.type.t_shape] = 468,
	[var_0_0.type.zhanwei] = 0
}
var_0_0.entry = {
	[var_0_0.type.first] = true,
	[var_0_0.type.last] = true,
	[var_0_0.type.signsingle] = true,
	[var_0_0.type.wrong] = true
}
var_0_0.pathConn = {
	[var_0_0.type.straight] = true,
	[var_0_0.type.corner] = true,
	[var_0_0.type.t_shape] = true
}
var_0_0.UIDragRes = {
	[var_0_0.type.straight] = "v1a3_arm_puzzlepipegrid3",
	[var_0_0.type.corner] = "v1a3_arm_puzzlepipegrid2",
	[var_0_0.type.t_shape] = "v1a3_arm_puzzlepipegrid1"
}
var_0_0.UIDragEmptyRes = {
	[var_0_0.type.straight] = "v1a3_arm_puzzlepipegrid3disable",
	[var_0_0.type.corner] = "v1a3_arm_puzzlepipegrid2disable",
	[var_0_0.type.t_shape] = "v1a3_arm_puzzlepipegrid1disable"
}
var_0_0.res = {
	[var_0_0.type.first] = {
		"v1a3_arm_puzzlesignstart",
		"v1a3_arm_puzzlesignstart"
	},
	[var_0_0.type.last] = {
		"v1a3_arm_puzzlesignend",
		"v1a3_arm_puzzlesignend"
	},
	[var_0_0.type.signsingle] = {
		"v1a3_arm_puzzlesignsingle",
		"v1a3_arm_puzzlesignright"
	},
	[var_0_0.type.wrong] = {
		"v1a3_arm_puzzlesignwrong",
		"v1a3_arm_puzzlesignright"
	},
	[var_0_0.type.straight] = {
		"v1a3_arm_puzzlepipe3",
		"v1a3_arm_puzzlepipepath3"
	},
	[var_0_0.type.corner] = {
		"v1a3_arm_puzzlepipe2",
		"v1a3_arm_puzzlepipepath2"
	},
	[var_0_0.type.t_shape] = {
		"v1a3_arm_puzzlepipe1",
		"v1a3_arm_puzzlepipepath1"
	},
	[var_0_0.type.zhanwei] = {
		"v1a3_arm_puzzleputgrid3",
		"v1a3_arm_puzzleputgrid3"
	}
}
var_0_0.resNumIcons = {
	"v1a3_arm_puzzlesignnum1",
	"v1a3_arm_puzzlesignnum2",
	"v1a3_arm_puzzlesignnum3",
	"v1a3_arm_puzzlesignnum4"
}
var_0_0.resGridBg = {
	[var_0_0.type.straight] = "v1a3_arm_puzzlepipegrid3",
	[var_0_0.type.corner] = "v1a3_arm_puzzlepipegrid2",
	[var_0_0.type.t_shape] = "v1a3_arm_puzzlepipegrid1",
	[var_0_0.type.zhanwei] = "v1a3_arm_puzzleputgrid2"
}
var_0_0.pathGridBg = {
	[0] = "v1a3_arm_puzzleputgrid1",
	"v1a3_arm_puzzleputgrid2",
	"v1a3_arm_puzzleputgrid3"
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
		[26] = {
			0
		},
		[24] = {
			270
		},
		[48] = {
			180
		},
		[68] = {
			90
		}
	},
	[var_0_0.type.t_shape] = {
		[468] = {
			0
		},
		[268] = {
			270
		},
		[246] = {
			180
		},
		[248] = {
			90
		}
	}
}
var_0_0.connDir = {
	[var_0_0.dir.left] = var_0_0.dir.right,
	[var_0_0.dir.right] = var_0_0.dir.left,
	[var_0_0.dir.up] = var_0_0.dir.down,
	[var_0_0.dir.down] = var_0_0.dir.up
}
var_0_0.posDir = {
	[var_0_0.dir.left] = {
		x = -1,
		y = 0
	},
	[var_0_0.dir.right] = {
		x = 1,
		y = 0
	},
	[var_0_0.dir.up] = {
		x = 0,
		y = 1
	},
	[var_0_0.dir.down] = {
		x = 0,
		y = -1
	}
}
var_0_0.PathNO = {
	PathOne = 1,
	PathTwo = 2
}
var_0_0.PathType = {
	Order = 1
}
var_0_0.AnimEvent_OnJump = "OnJump"
var_0_0.EpisodeState = {
	Finish = 1,
	Received = 2,
	Normal = 0
}
var_0_0.ComponentType = {
	Animator = typeof(UnityEngine.Animator)
}
var_0_0.AnimatorTime = {
	GameFinish = 2.2,
	WaitUnFixedTime = 0.3,
	UnFixedTime = 1.5,
	OpenView = 2
}

return var_0_0
