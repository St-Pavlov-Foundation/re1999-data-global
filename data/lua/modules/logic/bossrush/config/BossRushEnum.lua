module("modules.logic.bossrush.config.BossRushEnum", package.seeall)

slot0 = _M
slot1 = "ui/viewres/versionactivity_1_4/v1a4_bossrush/"
slot0.ResPath = {
	v1a4_bossrush_battle_assessicon = slot1 .. "v1a4_bossrush_battle_assessicon.prefab",
	v1a4_bossrush_result_assess = slot1 .. "v1a4_bossrush_result_assess.prefab",
	v1a4_bossrush_scheduleitem = slot1 .. "v1a4_bossrush_scheduleitem.prefab",
	v1a4_bossrush_ig_scoretips = slot1 .. "v1a4_bossrush_ig_scoretips.prefab",
	v1a4_bossrushleveldetail_spine = slot1 .. "v1a4_bossrushleveldetail_spine.prefab",
	v1a4_bossrush_mainview_assessicon = slot1 .. "v1a4_bossrush_mainview_assessicon.prefab",
	v1a4_bossrush_leveldetail_assessicon = slot1 .. "v1a4_bossrush_leveldetail_assessicon.prefab",
	v1a4_bossrush_achievement_assessicon = slot1 .. "v1a4_bossrush_achievement_assessicon.prefab",
	v1a4_bossrush_herogroup = slot1 .. "v1a4_bossrush_herogroup.prefab",
	v1a4_bossrush_herogroupitem1 = slot1 .. "v1a4_bossrush_herogroupitem1.prefab",
	v1a4_bossrush_herogroupitem2 = slot1 .. "v1a4_bossrush_herogroupitem2.prefab",
	v1a4_bossrushmainitem = slot1 .. "v1a4_bossrushmainitem.prefab",
	v1a6_bossrush_result_assess = slot1 .. "v1a6_bossrush_resultassess.prefab"
}
slot0.Color = {
	POINTVALUE_NORMAL = "#666362",
	POINTVALUE_GOT = "#AC5320",
	WHITE = "#FFFFFF",
	GRAY = "#666666"
}
slot0.TaskListenerType = {
	highestPoint = "Act128BossHighestPoint",
	layer4Reward = "Act128BossLayer4TotalPoint"
}
slot0.ScoreLevel = {
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
slot0.HpColor = {
	Orange = 2,
	Green = 4,
	Blue = 5,
	Red = 1,
	Yellow = 3,
	Purple = 6
}
slot0.AnimLevelDetail = {
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
slot0.AnimLevelDetailBtn = {
	Select = "select",
	LockedIdle = "locked_idle",
	UnlockedIdle = "unlocked_idle"
}
slot0.AnimTriggerLevelDetailBtn = {
	PlayUnlock = "play_unlock"
}
slot0.AnimScheduleItemRewardItem = {
	ReceiveEnter = "v1a4_bossrush_scheduleitem_receiveenter",
	Idle = "v1a4_bossrush_scheduleitem_default_idle",
	Got = "v1a4_bossrush_scheduleitem_default_get"
}
slot0.AnimScheduleItemRewardItem_HasGet = {
	Idle = "v1a4_bossrush_go_hasget_idle",
	Got = "v1a4_bossrush_go_hasget_in"
}
slot0.AnimScoreTips = {
	LevelUp = "levelup",
	ScoreNumChange = "txt_scorenum_change"
}
slot0.AnimResultPanel = {
	InNotEmpty = "innotempty",
	InEmpty = "inempty"
}
slot0.AnimEvtAchievementItem = {
	onBtnGoEnter = "onBtnGoEnter",
	onFinishEnd = "onFinishEnd",
	onEndBlock = "onEndBlock"
}
slot0.AnimEvtResultPanel = {
	onOpenEnd = "onOpenEnd",
	EvaluateItemAnim = "EvaluateItemAnim",
	ScoreTween = "ScoreTween",
	onCompleteOpenStart = "onCompleteOpenStart",
	CompleteFinish = "CompleteFinish"
}
slot0.AnimEvtLevelDetail = {
	onPlayCloseTransitionFinish = "onPlayCloseTransitionFinish"
}
slot0.AnimEvtLevelDetailItem = {
	onPlayUnlockSound = "onPlayUnlockSound"
}
slot0.AnimMainItem = {
	Unlocking = "unlocking",
	OpeningUnlocked = "opening_unlocked",
	LockedIdle = "locked_idle",
	UnlockedIdle = "unlocked_idle",
	OpeningLocked = "opening_locked",
	Unlock = "unlock"
}
slot0.BonusViewTab = {
	SpecialScheduleTab = 1,
	ScheduleTab = 3,
	AchievementTab = 2
}
slot0.V1a6_ResultAnimName = {
	NoEvaluate = "in",
	OpenEmpty = "openempty",
	Close = "close",
	HasEvaluate = "in2",
	Open = "open"
}
slot0.V1a6_BonusViewAnimName = {
	Out = "out",
	Idle = "idle",
	In = "in",
	Finish = "finish",
	Open = "open"
}
slot0.LayerRes = {
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
slot0.StoreActivityId = 11604

return slot0
