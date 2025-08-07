module("modules.logic.bossrush.config.BossRushEnum", package.seeall)

local var_0_0 = _M
local var_0_1 = "ui/viewres/versionactivity_1_4/v1a4_bossrush/"

var_0_0.ResPath = {
	v1a4_bossrush_battle_assessicon = var_0_1 .. "v1a4_bossrush_battle_assessicon.prefab",
	v1a4_bossrush_result_assess = var_0_1 .. "v1a4_bossrush_result_assess.prefab",
	v1a4_bossrush_scheduleitem = var_0_1 .. "v1a4_bossrush_scheduleitem.prefab",
	v1a4_bossrush_ig_scoretips = var_0_1 .. "v1a4_bossrush_ig_scoretips.prefab",
	v1a4_bossrushleveldetail_spine = var_0_1 .. "v1a4_bossrushleveldetail_spine.prefab",
	v1a4_bossrush_mainview_assessicon = var_0_1 .. "v1a4_bossrush_mainview_assessicon.prefab",
	v1a4_bossrush_leveldetail_assessicon = var_0_1 .. "v1a4_bossrush_leveldetail_assessicon.prefab",
	v1a4_bossrush_achievement_assessicon = var_0_1 .. "v1a4_bossrush_achievement_assessicon.prefab",
	v1a4_bossrush_herogroup = var_0_1 .. "v1a4_bossrush_herogroup.prefab",
	v1a4_bossrush_herogroupitem1 = var_0_1 .. "v1a4_bossrush_herogroupitem1.prefab",
	v1a4_bossrush_herogroupitem2 = var_0_1 .. "v1a4_bossrush_herogroupitem2.prefab",
	v1a4_bossrushmainitem = var_0_1 .. "v1a4_bossrushmainitem.prefab",
	v1a6_bossrush_result_assess = var_0_1 .. "v1a6_bossrush_resultassess.prefab",
	v1a6_bossrush_achievementview = var_0_1 .. "v1a6_bossrush_achievementview.prefab",
	v1a6_bossrush_scheduleview = var_0_1 .. "v1a6_bossrush_scheduleview.prefab",
	v2a1_bossrush_specialscheduleview = var_0_1 .. "v2a1_bossrush_specialscheduleview.prefab",
	v1a4_bossrushmainview = var_0_1 .. "v1a4_bossrushmainview.prefab",
	v1a4_bossrushleveldetail = var_0_1 .. "v1a4_bossrushleveldetail.prefab"
}
var_0_0.Color = {
	POINTVALUE_NORMAL = "#666362",
	POINTVALUE_GOT = "#AC5320",
	WHITE = "#FFFFFF",
	GRAY = "#666666"
}
var_0_0.TaskListenerType = {
	layer4Reward = "Act128BossLayer4TotalPoint",
	highestPoint = "Act128BossHighestPoint",
	SpHighestPoint = "Act128BossSpHighestPoint"
}
var_0_0.ScoreLevel = {
	S_AA = 9,
	C = 1,
	S = 7,
	S_AAA = 10,
	C_A = 2,
	B_A = 4,
	A = 5,
	A_A = 6,
	S_A = 8,
	B = 3
}
var_0_0.HpColor = {
	Orange = 2,
	Green = 4,
	Blue = 5,
	Red = 1,
	Yellow = 3,
	Purple = 6
}
var_0_0.AnimLevelDetail = {
	HardEnter = "hard",
	NormalEnter = "normal",
	SwitchToHard = "tohard",
	Layer4 = "layer4",
	EndlessEnter = "endless",
	SwitchToEndless = "toendless",
	SwitchToLayer4 = "tolayer4",
	SwitchToNormal = "tonormal",
	CloseView = "close"
}
var_0_0.AnimLevelDetailBtn = {
	Select = "select",
	LockedIdle = "locked_idle",
	UnlockedIdle = "unlocked_idle"
}
var_0_0.AnimTriggerLevelDetailBtn = {
	PlayUnlock = "play_unlock"
}
var_0_0.AnimScheduleItemRewardItem = {
	ReceiveEnter = "v1a4_bossrush_scheduleitem_receiveenter",
	Idle = "v1a4_bossrush_scheduleitem_default_idle",
	Got = "v1a4_bossrush_scheduleitem_default_get"
}
var_0_0.AnimScheduleItemRewardItem_HasGet = {
	Idle = "v1a4_bossrush_go_hasget_idle",
	Got = "v1a4_bossrush_go_hasget_in"
}
var_0_0.AnimScoreTips = {
	LevelUp = "levelup",
	ScoreNumChange = "txt_scorenum_change"
}
var_0_0.AnimResultPanel = {
	InNotEmpty = "innotempty",
	InEmpty = "inempty"
}
var_0_0.AnimEvtAchievementItem = {
	onBtnGoEnter = "onBtnGoEnter",
	onFinishEnd = "onFinishEnd",
	onEndBlock = "onEndBlock"
}
var_0_0.AnimEvtResultPanel = {
	onOpenEnd = "onOpenEnd",
	EvaluateItemAnim = "EvaluateItemAnim",
	ScoreTween = "ScoreTween",
	onCompleteOpenStart = "onCompleteOpenStart",
	CompleteFinish = "CompleteFinish"
}
var_0_0.AnimEvtLevelDetail = {
	onPlayCloseTransitionFinish = "onPlayCloseTransitionFinish"
}
var_0_0.AnimEvtLevelDetailItem = {
	onPlayUnlockSound = "onPlayUnlockSound"
}
var_0_0.AnimMainItem = {
	Unlocking = "unlocking",
	OpeningUnlocked = "opening_unlocked",
	LockedIdle = "locked_idle",
	UnlockedIdle = "unlocked_idle",
	OpeningLocked = "opening_locked",
	Unlock = "unlock"
}
var_0_0.BonusViewTab = {
	SpecialScheduleTab = 3,
	ScheduleTab = 2,
	AchievementTab = 1
}
var_0_0.V2a9BonusViewTab = {
	V2a9Special = 2,
	V2a9TotalSchedule = 3,
	V2a9Normal = 1
}
var_0_0.V1a6_ResultAnimName = {
	NoEvaluate = "in",
	OpenEmpty = "openempty",
	Close = "close",
	HasEvaluate = "in2",
	Open = "open"
}
var_0_0.V1a6_BonusViewAnimName = {
	Out = "out",
	Idle = "idle",
	In = "in",
	Finish = "finish",
	Open = "open"
}
var_0_0.PlayUnlockAnimStage = "BossRushMainItem_%s_%s"
var_0_0.LayerRes = {
	EnterLevelBtn = {
		"v1a4_bossrush_btn_go2",
		nil,
		"v1a4_bossrush_btn_go3",
		"v2a1_bossrush_btn_go4"
	},
	EnterLevelBtnTxtColor = {
		"#070706",
		nil,
		"#F7F0E8",
		"#EBFDFF"
	}
}
var_0_0.StoreActivityId = 11604
var_0_0.LayerEnum = {
	Simple = 1,
	Endless = 3,
	Layer4 = 4,
	V2a9 = 5,
	Hard = 2
}
var_0_0.V2a9StageEnum = {
	Second = 2,
	First = 1
}
var_0_0.V2a9FightEquipSkillMaxCount = 4
var_0_0.V2a9FightCanEquipSkillCountConst = 4
var_0_0.S01Anim = {
	Load = "load",
	Unload = "unload"
}
var_0_0.MainView = {
	[VersionActivity1_4Enum.ActivityId.BossRush] = {
		MainViewPath = var_0_1 .. "v1a4_bossrushmainview.prefab",
		MainViewItemPath = var_0_1 .. "v1a4_bossrushmainitem.prefab",
		MainViewClass = V1a4_BossRushMainView,
		LeveldetailViewPath = var_0_1 .. "v1a4_bossrushleveldetail.prefab",
		LevelDetail = V1a4_BossRushLevelDetail
	},
	[VersionActivity2_9Enum.ActivityId.BossRush] = {
		MainViewPath = var_0_1 .. "v2a9_bossrush_mainview.prefab",
		MainViewItemPath = var_0_1 .. "v2a9_bossrush_mainitem.prefab",
		MainViewClass = V2a9_BossRushMainView,
		LeveldetailViewPath = var_0_1 .. "v2a9_bossrush_leveldetail.prefab",
		LevelDetail = V2a9_BossRushLevelDetail
	}
}
var_0_0.BonusTab = {
	[VersionActivity1_4Enum.ActivityId.BossRush] = {
		{
			ResIndex = 1,
			ViewPath = var_0_0.ResPath.v1a6_bossrush_achievementview,
			Reddot = RedDotEnum.DotNode.BossRushBossAchievement,
			TaskListenerType = var_0_0.TaskListenerType.highestPoint,
			CellClass = V1a6_BossRush_AchievementItem,
			ListModel = V1a4_BossRush_ScoreTaskAchievementListModel.instance,
			ViewClass = V1a6_BossRush_AchievementView
		},
		{
			ResIndex = 2,
			ViewPath = var_0_0.ResPath.v1a6_bossrush_scheduleview,
			Reddot = RedDotEnum.DotNode.BossRushBossSchedule,
			CellClass = V1a6_BossRush_ScheduleItem,
			ListModel = V1a4_BossRush_ScheduleViewListModel.instance,
			ViewClass = V2a1_BossRush_SpecialScheduleView
		}
	},
	[VersionActivity2_1Enum.ActivityId.BossRush] = {
		{
			ResIndex = 4,
			ViewPath = var_0_0.ResPath.v1a6_bossrush_achievementview,
			Reddot = RedDotEnum.DotNode.BossRushBossAchievement,
			TaskListenerType = var_0_0.TaskListenerType.layer4Reward,
			CellClass = V2a1_BossRush_SpecialScheduleItem,
			ListModel = V2a1_BossRush_SpecialScheduleViewListModel.instance,
			ViewClass = V2a1_BossRush_SpecialScheduleView
		},
		{
			ResIndex = 1,
			ViewPath = var_0_0.ResPath.v1a6_bossrush_achievementview,
			Reddot = RedDotEnum.DotNode.BossRushBossAchievement,
			TaskListenerType = var_0_0.TaskListenerType.highestPoint,
			CellClass = V1a6_BossRush_AchievementItem,
			ListModel = V1a4_BossRush_ScoreTaskAchievementListModel.instance,
			ViewClass = V1a6_BossRush_AchievementView
		},
		{
			ResIndex = 2,
			ViewPath = var_0_0.ResPath.v1a6_bossrush_scheduleview,
			Reddot = RedDotEnum.DotNode.BossRushBossSchedule,
			CellClass = V1a6_BossRush_ScheduleItem,
			ListModel = V1a4_BossRush_ScheduleViewListModel.instance,
			ViewClass = V1a6_BossRush_ScheduleView
		}
	},
	[VersionActivity2_9Enum.ActivityId.BossRush] = {
		{
			ScoreDesc = "p_v2a9_bossrushleveldetail_txt_ScoreDesc1",
			ResIndex = 1,
			ViewPath = var_0_0.ResPath.v1a6_bossrush_achievementview,
			Reddot = RedDotEnum.DotNode.BossRushBossAchievement,
			TaskListenerType = var_0_0.TaskListenerType.SpHighestPoint,
			CellClass = V1a6_BossRush_AchievementItem,
			ListModel = V1a4_BossRush_ScoreTaskAchievementListModel.instance,
			ViewClass = V1a6_BossRush_AchievementView,
			SpModel = V2a9BossRushModel
		},
		{
			ResIndex = 1,
			ScoreDesc = "p_v2a9_bossrushleveldetail_txt_ScoreDesc2",
			ViewPath = var_0_0.ResPath.v1a6_bossrush_achievementview,
			Reddot = RedDotEnum.DotNode.BossRushBossAchievement,
			TaskListenerType = var_0_0.TaskListenerType.highestPoint,
			CellClass = V1a6_BossRush_AchievementItem,
			ListModel = V1a4_BossRush_ScoreTaskAchievementListModel.instance,
			ViewClass = V1a6_BossRush_AchievementView
		},
		{
			ResIndex = 2,
			ViewPath = var_0_0.ResPath.v1a6_bossrush_scheduleview,
			Reddot = RedDotEnum.DotNode.BossRushBossSchedule,
			CellClass = V1a6_BossRush_ScheduleItem,
			ListModel = V1a4_BossRush_ScheduleViewListModel.instance,
			ViewClass = V1a6_BossRush_ScheduleView
		}
	}
}
var_0_0.DefaultAcitvityId = VersionActivity1_4Enum.ActivityId.BossRush

return var_0_0
