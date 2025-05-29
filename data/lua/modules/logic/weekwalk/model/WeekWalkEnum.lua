module("modules.logic.weekwalk.model.WeekWalkEnum", package.seeall)

local var_0_0 = _M

var_0_0.ElementType = {
	Dialog = 4,
	General = 2,
	MaxCount = 4,
	Battle = 1,
	Respawn = 3
}
var_0_0.GeneralType = {
	Audio = 1,
	Bgm = 0
}
var_0_0.BuffType = {
	Pray = 3,
	Assist = 2,
	Special = 1
}
var_0_0.TaskType = {
	Week = 2,
	Challenge = 4,
	Dream = 3
}
var_0_0.SacrificeEffectType = {
	ExAttr = 2,
	PassiveSkill = 3,
	BaseAttr = 1
}
var_0_0.ShallowMapIds = {
	[204] = true,
	[202] = true,
	[104] = true,
	[205] = true,
	[101] = true,
	[102] = true,
	[201] = true,
	[103] = true,
	[105] = true,
	[203] = true
}
var_0_0.episodeId = 90101
var_0_0.MaxLevel = 2
var_0_0.SevenDaySec = 604800
var_0_0.orthographicSize = 5
var_0_0.FirstDeepLayer = 11
var_0_0.OneDeepLayerFirstBattle = 1
var_0_0.LastShallowLayer = 10
var_0_0.NewDeepLayerMaxNum = 7
var_0_0.ShallowLayerMaxNum = 10
var_0_0.HardDeepLayerId = 17

return var_0_0
