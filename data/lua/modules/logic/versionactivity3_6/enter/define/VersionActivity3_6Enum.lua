-- chunkname: @modules/logic/versionactivity3_6/enter/define/VersionActivity3_6Enum.lua

module("modules.logic.versionactivity3_6.enter.define.VersionActivity3_6Enum", package.seeall)

local VersionActivity3_6Enum = _M

if SettingsModel.instance:isOverseas() and GameBranchMgr.instance:isOnVer(3, 6) then
	local VersionActivity3_8Enum = rawget(_G, "VersionActivity3_8Enum") or {}

	rawset(_G, "VersionActivity3_8Enum", VersionActivity3_8Enum)

	VersionActivity3_8Enum.ActivityId = VersionActivity3_8Enum.ActivityId or {
		FreeMonthCard = ActivityEnum.Activity.FreeMonthCard
	}

	local AudioEnum3_8 = rawget(_G, "AudioEnum3_8") or {}

	rawset(_G, "AudioEnum3_8", AudioEnum3_8)

	AudioEnum3_8.FreeMonthCard = AudioEnum3_8.FreeMonthCard or {
		play_ui_wulu_kerandian_monster02_stand = 380023,
		play_ui_mln_unlock = 380022
	}
end

VersionActivity3_6Enum.ActivityId = {
	Abyss = 13601,
	DungeonStore = 13605,
	BossRush = 13609,
	Dungeon = 13604,
	YaMi = 13608,
	EnterView = 13603
}
VersionActivity3_6Enum.CharacterActId = {
	[VersionActivity3_6Enum.ActivityId.YaMi] = 0
}
VersionActivity3_6Enum.EnterViewActSetting = {
	{
		actId = VersionActivity3_6Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity3_6Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity3_6Enum.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_6Enum.ActivityId.Abyss,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_6Enum.ActivityId.YaMi,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = ActivityEnum.Activity.WeekWalkDeepShow,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = ActivityEnum.Activity.WeekWalkDeepShow
	},
	{
		actId = ActivityEnum.Activity.Tower,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = ActivityEnum.Activity.WeekWalkHeartShow,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = ActivityEnum.Activity.WeekWalkHeartShow
	}
}
VersionActivity3_6Enum.EnterViewActIdListWithRedDot = {
	VersionActivity3_6Enum.ActivityId.Dungeon
}
VersionActivity3_6Enum.TabSetting = {
	select = {
		fontSize = 30,
		cnColor = "#DFD5CA",
		enFontSize = 16,
		enColor = "#C0773C",
		enAlpha = 1,
		act2TabImg = {
			[VersionActivity3_6Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v3a6_mainactivity_singlebg/v3a6_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 30,
		cnColor = "#AF7247",
		enFontSize = 16,
		enColor = "#C0773C",
		enAlpha = 0.5,
		act2TabImg = {
			[VersionActivity3_6Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v3a6_mainactivity_singlebg/v3a6_enterview_itemtitleselected.png"
		}
	}
}
VersionActivity3_6Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity3_6Enum.RedDotOffsetY = 56
VersionActivity3_6Enum.RedDotOffsetX = 10
VersionActivity3_6Enum.EnterLoopVideoName = "v3a6_kv_loop"
VersionActivity3_6Enum.EnterAnimVideoName = "v3a6_kv_open"
VersionActivity3_6Enum.EnterVideoDayKey = "v3a6_EnterVideoDayKey"
VersionActivity3_6Enum.OpenAnimDelayTime = 5
VersionActivity3_6Enum.ScriptSuffix = 1

return VersionActivity3_6Enum
