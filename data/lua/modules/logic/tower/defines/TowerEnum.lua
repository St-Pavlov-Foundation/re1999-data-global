module("modules.logic.tower.defines.TowerEnum", package.seeall)

slot0 = _M
slot0.TowerType = {
	Boss = 2,
	Limited = 3,
	Normal = 1
}
slot0.TowerStatus = {
	Ready = 1,
	Open = 2,
	Close = 3,
	None = 0
}
slot0.PermanentUI = {
	SingleItemH = 120,
	LockTipH = 200,
	ScrollH = 950,
	ItemSpaceH = 90,
	StageTitleH = 80
}
slot0.PermanentTowerId = 0
slot0.PermanentEliteEpisodeState = {
	Finish = 2,
	FinishSelect = 1,
	NormalSelect = 3,
	Normal = 4
}
slot0.PassEpisodeState = {
	Pass = 1,
	NotPass = 0
}
slot0.ShowState = {
	Hide = 0,
	Show = 1
}
slot0.JumpId = {
	TowerBoss = 2,
	TowerLimited = 3,
	TowerPermanent = 1
}
slot0.ConstId = {
	MopUpOpenLayerNum = 113,
	TimeLimitEasyMulti = 104,
	MaxMopUpTimes = 101,
	BossHandbookOpen = 116,
	MopUpRecoverTime = 102,
	BossTowerOpen = 111,
	TimeLimitOpenLayerNum = 112,
	MopUpTicketIcon = 114,
	TimeLimitNormalMulti = 105,
	TaskRewardOpen = 117,
	TimeLimitHardMulti = 106
}
slot0.LocalPrefsKey = {
	NewTimeLimitOpen = "NewTimeLimitOpen",
	LastEntranceDifficulty = "LastEntranceDifficulty",
	OpenMopUpViewWithFullTicket = "OpenMopUpViewWithFullTicket",
	NewBossSpOpen = "NewBossSpOpen",
	NewBossOpen = "NewBossOpen",
	MopUpDailyRefresh = "MopUpDailyRefresh",
	ReddotNewBossOpen = "ReddotNewBossOpen",
	ReddotNewTimeLimitOpen = "ReddotNewTimeLimitOpen"
}
slot0.LockKey = 0
slot0.UnlockKey = 1
slot0.Difficulty = {
	Normal = 2,
	Hard = 3,
	Easy = 1
}
slot0.AttrKey = {
	CriDmg = "criDmg",
	Attack = "attack",
	Cri = "cri"
}
slot0.UpAttrId = {
	[slot0.AttrKey.Cri] = 1,
	[slot0.AttrKey.CriDmg] = 1
}
slot0.AttrKey2AttrId = {
	[slot0.AttrKey.Attack] = CharacterEnum.AttrId.Attack,
	[slot0.AttrKey.Cri] = CharacterEnum.AttrId.Cri,
	[slot0.AttrKey.CriDmg] = CharacterEnum.AttrId.CriDmg
}

return slot0
