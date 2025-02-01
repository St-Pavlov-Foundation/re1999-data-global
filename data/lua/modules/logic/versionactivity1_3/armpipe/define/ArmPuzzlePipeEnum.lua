module("modules.logic.versionactivity1_3.armpipe.define.ArmPuzzlePipeEnum", package.seeall)

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
	first = 1,
	last = 2,
	corner = 6,
	wrong = 4,
	t_shape = 7,
	signsingle = 3,
	straight = 5,
	zhanwei = 8
}
slot0.status = {
	correct = 2,
	normal = 1
}
slot0.pathColor = {
	[0] = "#FFFFFF",
	"#BE8757",
	"#BB5F4C"
}
slot0.entryColor = {
	[0] = "#FFFFFF",
	"#9A4B05",
	"#AA0F09"
}
slot0.entryTypeColor = {
	[slot0.type.first] = {
		[1.0] = "#9D4D01",
		[2.0] = "#A93737"
	},
	[slot0.type.last] = {
		[1.0] = "#9D4D01",
		[2.0] = "#A93737"
	}
}
slot0.ruleConnect = {
	[slot0.type.first] = 2468,
	[slot0.type.last] = 2468,
	[slot0.type.signsingle] = 2468,
	[slot0.type.wrong] = 2468,
	[slot0.type.straight] = 28,
	[slot0.type.corner] = 26,
	[slot0.type.t_shape] = 468,
	[slot0.type.zhanwei] = 0
}
slot0.entry = {
	[slot0.type.first] = true,
	[slot0.type.last] = true,
	[slot0.type.signsingle] = true,
	[slot0.type.wrong] = true
}
slot0.pathConn = {
	[slot0.type.straight] = true,
	[slot0.type.corner] = true,
	[slot0.type.t_shape] = true
}
slot0.UIDragRes = {
	[slot0.type.straight] = "v1a3_arm_puzzlepipegrid3",
	[slot0.type.corner] = "v1a3_arm_puzzlepipegrid2",
	[slot0.type.t_shape] = "v1a3_arm_puzzlepipegrid1"
}
slot0.UIDragEmptyRes = {
	[slot0.type.straight] = "v1a3_arm_puzzlepipegrid3disable",
	[slot0.type.corner] = "v1a3_arm_puzzlepipegrid2disable",
	[slot0.type.t_shape] = "v1a3_arm_puzzlepipegrid1disable"
}
slot0.res = {
	[slot0.type.first] = {
		"v1a3_arm_puzzlesignstart",
		"v1a3_arm_puzzlesignstart"
	},
	[slot0.type.last] = {
		"v1a3_arm_puzzlesignend",
		"v1a3_arm_puzzlesignend"
	},
	[slot0.type.signsingle] = {
		"v1a3_arm_puzzlesignsingle",
		"v1a3_arm_puzzlesignright"
	},
	[slot0.type.wrong] = {
		"v1a3_arm_puzzlesignwrong",
		"v1a3_arm_puzzlesignright"
	},
	[slot0.type.straight] = {
		"v1a3_arm_puzzlepipe3",
		"v1a3_arm_puzzlepipepath3"
	},
	[slot0.type.corner] = {
		"v1a3_arm_puzzlepipe2",
		"v1a3_arm_puzzlepipepath2"
	},
	[slot0.type.t_shape] = {
		"v1a3_arm_puzzlepipe1",
		"v1a3_arm_puzzlepipepath1"
	},
	[slot0.type.zhanwei] = {
		"v1a3_arm_puzzleputgrid3",
		"v1a3_arm_puzzleputgrid3"
	}
}
slot0.resNumIcons = {
	"v1a3_arm_puzzlesignnum1",
	"v1a3_arm_puzzlesignnum2",
	"v1a3_arm_puzzlesignnum3",
	"v1a3_arm_puzzlesignnum4"
}
slot0.resGridBg = {
	[slot0.type.straight] = "v1a3_arm_puzzlepipegrid3",
	[slot0.type.corner] = "v1a3_arm_puzzlepipegrid2",
	[slot0.type.t_shape] = "v1a3_arm_puzzlepipegrid1",
	[slot0.type.zhanwei] = "v1a3_arm_puzzleputgrid2"
}
slot0.pathGridBg = {
	[0] = "v1a3_arm_puzzleputgrid1",
	"v1a3_arm_puzzleputgrid2",
	"v1a3_arm_puzzleputgrid3"
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
	[slot0.type.t_shape] = {
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
slot0.connDir = {
	[slot0.dir.left] = slot0.dir.right,
	[slot0.dir.right] = slot0.dir.left,
	[slot0.dir.up] = slot0.dir.down,
	[slot0.dir.down] = slot0.dir.up
}
slot0.posDir = {
	[slot0.dir.left] = {
		x = -1,
		y = 0
	},
	[slot0.dir.right] = {
		x = 1,
		y = 0
	},
	[slot0.dir.up] = {
		x = 0,
		y = 1
	},
	[slot0.dir.down] = {
		x = 0,
		y = -1
	}
}
slot0.PathNO = {
	PathOne = 1,
	PathTwo = 2
}
slot0.PathType = {
	Order = 1
}
slot0.AnimEvent_OnJump = "OnJump"
slot0.EpisodeState = {
	Finish = 1,
	Received = 2,
	Normal = 0
}
slot0.ComponentType = {
	Animator = typeof(UnityEngine.Animator)
}
slot0.AnimatorTime = {
	GameFinish = 2.2,
	WaitUnFixedTime = 0.3,
	UnFixedTime = 1.5,
	OpenView = 2
}

return slot0
