module("modules.logic.rouge.dlc.101.define.RougeDLCEnum101", package.seeall)

local var_0_0 = _M

var_0_0.LimitState = {
	Unlocked = 2,
	Locked = 1
}
var_0_0.BuffType = {
	Middle = 2,
	Large = 3,
	Small = 1
}
var_0_0.BuffState = {
	Unlocked = 2,
	Locked = 1,
	CD = 3,
	Equiped = 4
}
var_0_0.MaxRiskDescCount = 3
var_0_0.Const = {
	SpeedupCost = 4,
	MaxEmblemCount = 5
}
var_0_0.LimiterBuffType = {
	Middle = 2,
	Large = 3,
	Small = 1
}
var_0_0.StressPrefabPath = "ui/viewres/fight/fightstressitem.prefab"

return var_0_0
