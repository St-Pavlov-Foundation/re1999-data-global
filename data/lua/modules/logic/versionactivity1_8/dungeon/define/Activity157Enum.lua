module("modules.logic.versionactivity1_8.dungeon.define.Activity157Enum", package.seeall)

slot0 = _M
slot0.MissionType = {
	MainMission = 1,
	SideMission = 2
}
slot0.MissionStatus = {
	Locked = 2,
	DispatchFinish = 4,
	Finish = 5,
	Dispatching = 3,
	Normal = 1
}
slot0.MissionStatusShowSetting = {
	[slot0.MissionStatus.Normal] = {
		fight = "v1a8_dungeon_factory_btn_fight",
		normal = "v1a8_dungeon_factory_btn_finishing"
	},
	[slot0.MissionStatus.Locked] = "v1a8_dungeon_factory_btn_locked",
	[slot0.MissionStatus.Dispatching] = "v1a8_dungeon_factory_btn_finishing",
	[slot0.MissionStatus.DispatchFinish] = "v1a8_dungeon_factory_btn_reward",
	[slot0.MissionStatus.Finish] = {
		story = "v1a8_dungeon_factory_btn_review",
		normal = "v1a8_dungeon_factory_btn_finished"
	}
}
slot0.MissionLineStatusIcon = {
	[slot0.MissionStatus.Normal] = {
		point = "v1a8_dungeon_factory_point_unlocked"
	},
	[slot0.MissionStatus.Locked] = {
		point = "v1a8_dungeon_factory_point_locked"
	},
	[slot0.MissionStatus.Finish] = {
		point = "v1a8_dungeon_factory_point_finished"
	},
	[slot0.MissionStatus.Dispatching] = {
		point = "v1a8_dungeon_factory_point_unlocked"
	},
	[slot0.MissionStatus.DispatchFinish] = {
		point = "v1a8_dungeon_factory_point_unlocked"
	}
}
slot0.ConstId = {
	FactoryCompositeCost = 3,
	FirstFactoryComponent = 2,
	UnlockEntranceElement = 1,
	FactoryRepairPartItem = 4,
	FactoryCompositeFormula = 6,
	FactoryProductCapacity = 7,
	FactoryMapNodeLineOffsetY = 11,
	FactoryRepairGameMapSize = 10
}
slot0.UnlockBlueprintElement = 1811801
slot0.res = {
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
slot0.entryColor = {
	[0] = "#FFFFFF",
	"#77251e",
	"#8b603d"
}
slot0.entryTypeColor = {
	[ArmPuzzlePipeEnum.type.first] = {
		[1.0] = "#7e251f",
		[2.0] = "#a4693a"
	},
	[ArmPuzzlePipeEnum.type.last] = {
		[1.0] = "#7e251f",
		[2.0] = "#a4693a"
	}
}
slot0.pathColor = {
	[0] = "#FFFFFF",
	"#7e251f",
	"#aa7e58"
}

return slot0
