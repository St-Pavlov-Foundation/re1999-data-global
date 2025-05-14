module("modules.logic.versionactivity2_2.eliminate.defines.EliminateLevelEnum", package.seeall)

local var_0_0 = class("EliminateLevelEnum")

var_0_0.levelType = {
	boss = "boss",
	elite = "elite",
	normal = "normal"
}
var_0_0.scenePathToStrongLandImageName = {
	["scenes/v2a2_m_s12_xdwf/scenes_prefab/v2a2_m_s12_xdwf_jd1_p.prefab"] = "v2a2_eliminate_teamchess_platebg1",
	["scenes/v2a2_m_s12_xdwf/scenes_prefab/v2a2_m_s12_xdwf_jd_p.prefab"] = "v2a2_eliminate_teamchess_platebg3",
	["scenes/v2a2_m_s12_xdwf/scenes_prefab/v2a2_m_s12_xdwf_jd2_p.prefab"] = "v2a2_eliminate_teamchess_platebg2"
}
var_0_0.resultStatUse = {
	lose = "失败",
	draw = "主动中断",
	win = "成功"
}
var_0_0.skillShowType = {
	skill = 1,
	forecast = 2
}
var_0_0.winColor = GameUtil.parseColor("#88CC66")
var_0_0.loserColor = GameUtil.parseColor("#e5e0cf")
var_0_0.winSize = 42
var_0_0.loserSize = 34
var_0_0.winImageName1 = "v2a2_eliminate_enemy_pointhpbg"
var_0_0.loserImageName1 = "v2a2_eliminate_enemy_selfhpbg"
var_0_0.winImageName2 = "v2a2_eliminate_enemy_pointhpbg3"
var_0_0.loserImageName2 = "v2a2_eliminate_enemy_selfhpbg23"

return var_0_0
