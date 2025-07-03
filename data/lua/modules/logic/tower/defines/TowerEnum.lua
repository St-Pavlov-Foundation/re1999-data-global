module("modules.logic.tower.defines.TowerEnum", package.seeall)

local var_0_0 = _M

var_0_0.TowerType = {
	Boss = 2,
	Limited = 3,
	Normal = 1
}
var_0_0.TowerStatus = {
	Ready = 1,
	Open = 2,
	Close = 3,
	None = 0
}
var_0_0.PermanentUI = {
	SingleItemH = 120,
	LockTipH = 200,
	ScrollH = 950,
	ItemSpaceH = 90,
	StageTitleH = 80
}
var_0_0.PermanentTowerId = 0
var_0_0.ActTaskType = 1
var_0_0.MaxShowStarNum = 4
var_0_0.BossGuideId = 23205
var_0_0.TimeLimitGuideId = 23207
var_0_0.PermanentEliteEpisodeState = {
	Finish = 2,
	FinishSelect = 1,
	NormalSelect = 3,
	Normal = 4
}
var_0_0.PassEpisodeState = {
	Pass = 1,
	NotPass = 0
}
var_0_0.ShowState = {
	Hide = 0,
	Show = 1
}
var_0_0.JumpId = {
	TowerBoss = 2,
	TowerBossTeach = 4,
	TowerLimited = 3,
	TowerPermanent = 1
}
var_0_0.ConstId = {
	MopUpOpenLayerNum = 113,
	CustomTalentPlanCount = 119,
	MaxMopUpTimes = 101,
	BossHandbookOpen = 116,
	BalanceBossLevel = 118,
	MopUpRecoverTime = 102,
	TimeLimitEasyMulti = 104,
	BossTowerOpen = 111,
	HeroTrialRule = 120,
	TimeLimitOpenLayerNum = 112,
	StoreOpen = 122,
	MopUpTicketIcon = 114,
	TimeLimitNormalMulti = 105,
	TaskRewardOpen = 117,
	TeachBossLevel = 121,
	TimeLimitHardMulti = 106
}
var_0_0.LocalPrefsKey = {
	MopUpDailyRefresh = "MopUpDailyRefresh",
	TowerBossSPEpisodeFinishEffect = "TowerBossSPEpisodeFinishEffect",
	NewBossSpOpen = "NewBossSpOpen",
	NewTimeLimitOpen = "NewTimeLimitOpen",
	ReddotNewBossOpen = "ReddotNewBossOpen",
	TowerBossSelectHandBookEffect = "TowerBossSelectHandBookEffect",
	NewBossOpen = "NewBossOpen",
	TowerMainHeroTrialEffect = "TowerMainHeroTrialEffect",
	LastEntranceDifficulty = "LastEntranceDifficulty",
	ReddotNewLimitedActTask = "ReddotNewLimitedActTask",
	OpenMopUpViewWithFullTicket = "OpenMopUpViewWithFullTicket",
	TowerBossTeachFinishEffect = "TowerBossTeachFinishEffect",
	ReddotNewTimeLimitOpen = "ReddotNewTimeLimitOpen",
	ReddotNewHeroTrial = "ReddotNewHeroTrial"
}
var_0_0.LockKey = 0
var_0_0.UnlockKey = 1
var_0_0.Difficulty = {
	Normal = 2,
	Hard = 3,
	Easy = 1
}
var_0_0.AttrKey = {
	CriDmg = "criDmg",
	Attack = "attack",
	Cri = "cri"
}
var_0_0.UpAttrId = {
	[var_0_0.AttrKey.Cri] = 1,
	[var_0_0.AttrKey.CriDmg] = 1
}
var_0_0.AttrKey2AttrId = {
	[var_0_0.AttrKey.Attack] = CharacterEnum.AttrId.Attack,
	[var_0_0.AttrKey.Cri] = CharacterEnum.AttrId.Cri,
	[var_0_0.AttrKey.CriDmg] = CharacterEnum.AttrId.CriDmg
}

return var_0_0
