module("modules.logic.tower.defines.TowerDeepEnum", package.seeall)

local var_0_0 = _M

var_0_0.DeepLayerStage = 7
var_0_0.DefaultDeepRare = 1
var_0_0.MaxDeepRare = 5
var_0_0.MaxNormalBgStage = 5
var_0_0.ConstId = {
	FirstEnterDeepGuideId = 7,
	RewardTaskId = 4,
	EndDeepHigh = 9,
	NormalDeepEpisodeId = 5,
	UnlockLayer = 1,
	ResultBossDescSucc = 11,
	HeroGroupSaveCount = 3,
	ResultBossDescFail = 10,
	StartDeepHigh = 8,
	EndlessDeepEpisodeId = 6,
	HeroGroupTeamNum = 2
}
var_0_0.TeamOperateType = {
	Load = 1,
	Save = 2
}
var_0_0.FightResult = {
	Succ = 1,
	Fail = 0,
	NotFinish = -1
}

return var_0_0
