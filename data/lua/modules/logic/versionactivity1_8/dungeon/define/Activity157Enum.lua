module("modules.logic.versionactivity1_8.dungeon.define.Activity157Enum", package.seeall)

local var_0_0 = _M

var_0_0.MissionType = {
	MainMission = 1,
	SideMission = 2
}
var_0_0.MissionStatus = {
	Locked = 2,
	DispatchFinish = 4,
	Finish = 5,
	Dispatching = 3,
	Normal = 1
}
var_0_0.MissionStatusShowSetting = {
	[var_0_0.MissionStatus.Normal] = {
		fight = "v1a8_dungeon_factory_btn_fight",
		normal = "v1a8_dungeon_factory_btn_finishing"
	},
	[var_0_0.MissionStatus.Locked] = "v1a8_dungeon_factory_btn_locked",
	[var_0_0.MissionStatus.Dispatching] = "v1a8_dungeon_factory_btn_finishing",
	[var_0_0.MissionStatus.DispatchFinish] = "v1a8_dungeon_factory_btn_reward",
	[var_0_0.MissionStatus.Finish] = {
		story = "v1a8_dungeon_factory_btn_review",
		normal = "v1a8_dungeon_factory_btn_finished"
	}
}
var_0_0.MissionLineStatusIcon = {
	[var_0_0.MissionStatus.Normal] = {
		point = "v1a8_dungeon_factory_point_unlocked"
	},
	[var_0_0.MissionStatus.Locked] = {
		point = "v1a8_dungeon_factory_point_locked"
	},
	[var_0_0.MissionStatus.Finish] = {
		point = "v1a8_dungeon_factory_point_finished"
	},
	[var_0_0.MissionStatus.Dispatching] = {
		point = "v1a8_dungeon_factory_point_unlocked"
	},
	[var_0_0.MissionStatus.DispatchFinish] = {
		point = "v1a8_dungeon_factory_point_unlocked"
	}
}
var_0_0.ConstId = {
	FactoryCompositeCost = 3,
	FirstFactoryComponent = 2,
	UnlockEntranceElement = 1,
	FactoryRepairPartItem = 4,
	FactoryCompositeFormula = 6,
	FactoryProductCapacity = 7,
	FactoryMapNodeLineOffsetY = 11,
	FactoryRepairGameMapSize = 10
}
var_0_0.UnlockBlueprintElement = 1811801
var_0_0.res = {
	[ArmPuzzlePipeEnum.type.straight] = {
		"",
		"v1a8_dungeon_factory_pipepath3"
	},
	[ArmPuzzlePipeEnum.type.corner] = {
		"",
		"v1a8_dungeon_factory_pipepath2"
	},
	[ArmPuzzlePipeEnum.type.t_shape] = {
		"",
		"v1a8_dungeon_factory_pipepath1"
	}
}
var_0_0.entryColor = {
	[0] = "#FFFFFF",
	"#77251e",
	"#8b603d"
}
var_0_0.entryTypeColor = {
	[ArmPuzzlePipeEnum.type.first] = {
		[1] = "#7e251f",
		[2] = "#a4693a"
	},
	[ArmPuzzlePipeEnum.type.last] = {
		[1] = "#7e251f",
		[2] = "#a4693a"
	}
}
var_0_0.pathColor = {
	[0] = "#FFFFFF",
	"#7e251f",
	"#aa7e58"
}

return var_0_0
