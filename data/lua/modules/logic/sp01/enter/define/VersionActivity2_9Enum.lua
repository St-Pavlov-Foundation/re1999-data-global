module("modules.logic.sp01.enter.define.VersionActivity2_9Enum", package.seeall)

local var_0_0 = _M

var_0_0.ActivityId = {
	EnterView2 = 130506,
	Outside = 130504,
	Dungeon2 = 130507,
	BossRush = 130505,
	ReactivityStore = 130508,
	DungeonStore = 130503,
	Dungeon = 130502,
	EnterView = 130501,
	Reactivity = VersionActivity2_3Enum.ActivityId.Dungeon,
	V2a9_Act204 = ActivityEnum.Activity.V2a9_Act204,
	V2a9_Act205 = ActivityEnum.Activity.V2a9_Act205
}

if GameBranchMgr.instance:isOnVer(2, 9) and SettingsModel.instance:isOverseas() then
	if _G.VersionActivity3_0Enum == nil then
		rawset(_G, "VersionActivity3_0Enum", {})

		VersionActivity3_0Enum.ActivityId = {
			BossRush = 13016,
			ReactivityStore = 13010,
			RoleStory1 = 13004,
			MaLiAnNa = 13011,
			Season = 13000,
			KaRong = 13015,
			DungeonStore = 13008,
			Dungeon = 13007,
			SeasonStore = 13003,
			EnterView = 13006,
			ActivityDrop = 13009,
			Reactivity = VersionActivity2_1Enum.ActivityId.Dungeon,
			StoryDeduction = VersionActivity2_1Enum.ActivityId.StoryDeduction
		}
	end

	var_0_0.ActivityId.Reactivity = VersionActivity3_0Enum.ActivityId.Reactivity
	var_0_0.ActivityId.ReactivityStore = VersionActivity3_0Enum.ActivityId.ReactivityStore
end

var_0_0.EnterViewActIdListWithGroup = {
	[var_0_0.ActivityId.EnterView] = {
		var_0_0.ActivityId.Outside,
		var_0_0.ActivityId.BossRush,
		var_0_0.ActivityId.DungeonStore,
		var_0_0.ActivityId.Dungeon
	},
	[var_0_0.ActivityId.EnterView2] = {
		var_0_0.ActivityId.Outside,
		var_0_0.ActivityId.DungeonStore,
		var_0_0.ActivityId.Dungeon,
		var_0_0.ActivityId.BossRush,
		var_0_0.ActivityId.Dungeon2
	}
}
var_0_0.EnterViewMainActIdList = {
	var_0_0.ActivityId.EnterView,
	var_0_0.ActivityId.EnterView2
}
var_0_0.ActId2Ambient = {
	[var_0_0.ActivityId.EnterView] = 3290001,
	[var_0_0.ActivityId.EnterView2] = 3290002
}
var_0_0.ActId2OpenAudio = {
	[var_0_0.ActivityId.EnterView] = 20305301,
	[var_0_0.ActivityId.EnterView2] = 20305301
}
var_0_0.DelaySwitchBgTime = 2.01
var_0_0.DelaySwitchHero2Idle = 2
var_0_0.DelayPlayGroupBgm = 2.5
var_0_0.NextGroupGuideId = 130501
var_0_0.actId2GuideId = {
	[var_0_0.ActivityId.EnterView2] = var_0_0.NextGroupGuideId
}
var_0_0.ActId2BgAudioName = {
	[var_0_0.ActivityId.EnterView] = "sp01_kv_up",
	[var_0_0.ActivityId.EnterView2] = "sp01_kv_down"
}

return var_0_0
