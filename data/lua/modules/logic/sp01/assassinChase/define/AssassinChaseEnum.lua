module("modules.logic.sp01.assassinChase.define.AssassinChaseEnum", package.seeall)

local var_0_0 = _M

var_0_0.ConstId = {
	TotalGameTime = 7,
	ChangeDirectionTimeLimit = 2,
	DirectionChangeCount = 3,
	EndTime = 4,
	DirectionCount = 1
}
var_0_0.ViewState = {
	Select = 1,
	Progress = 2,
	Result = 3
}
var_0_0.SpineState = {
	Skill = 3,
	Idle = 1,
	Walk = 2
}
var_0_0.MainRoleSpineState = {
	[var_0_0.SpineState.Idle] = "idle",
	[var_0_0.SpineState.Walk] = "walk",
	[var_0_0.SpineState.Skill] = "idle_room"
}
var_0_0.OtherRoleSpineState = {
	[var_0_0.SpineState.Idle] = "idle",
	[var_0_0.SpineState.Walk] = "walk",
	[var_0_0.SpineState.Skill] = "idle"
}
var_0_0.SpineDefaultHeight = -132.5
var_0_0.MainRoleIndex = 1
var_0_0.AppleRoleIndex = 2
var_0_0.OtherRoleIndex = 3
var_0_0.OtherRoleRunOffset = 200
var_0_0.MainRoleRunOffset = -100
var_0_0.OtherRoleFinishOffset = -25
var_0_0.MainRoleFinishOffset = 25
var_0_0.SpineResPath = {
	"roles/s01_500501_xingti2hao_ui_xx/500501_xingti2hao_ui_xx_ui.prefab",
	"roles/s01_302801_apple_ui_xx/302801_apple_ui_xx_ui.prefab",
	"roles/s01_312301_ajaadtl_ui_xx/312301_ajaadtl_ui_xx_ui.prefab"
}
var_0_0.MaterialResPath = "ui/materials/dynamic/ui_spine_assassin_chase_game.mat"
var_0_0.ForceEndLockTime = 5
var_0_0.AutoGetRewardDelay = 0.5

return var_0_0
