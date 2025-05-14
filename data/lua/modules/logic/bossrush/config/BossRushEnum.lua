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
	v1a6_bossrush_result_assess = var_0_1 .. "v1a6_bossrush_resultassess.prefab"
}
var_0_0.Color = {
	POINTVALUE_NORMAL = "#666362",
	POINTVALUE_GOT = "#AC5320",
	WHITE = "#FFFFFF",
	GRAY = "#666666"
}
var_0_0.TaskListenerType = {
	highestPoint = "Act128BossHighestPoint",
	layer4Reward = "Act128BossLayer4TotalPoint"
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
	SpecialScheduleTab = 1,
	ScheduleTab = 3,
	AchievementTab = 2
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

return var_0_0
