module("modules.logic.versionactivity2_2.eliminate.defines.EliminateLevelEnum", package.seeall)

slot0 = class("EliminateLevelEnum")
slot0.levelType = {
	boss = "boss",
	elite = "elite",
	normal = "normal"
}
slot0.scenePathToStrongLandImageName = {
	["scenes/v2a2_m_s12_xdwf/scenes_prefab/v2a2_m_s12_xdwf_jd1_p.prefab"] = "v2a2_eliminate_teamchess_platebg1",
	["scenes/v2a2_m_s12_xdwf/scenes_prefab/v2a2_m_s12_xdwf_jd_p.prefab"] = "v2a2_eliminate_teamchess_platebg3",
	["scenes/v2a2_m_s12_xdwf/scenes_prefab/v2a2_m_s12_xdwf_jd2_p.prefab"] = "v2a2_eliminate_teamchess_platebg2"
}
slot0.resultStatUse = {
	lose = "失败",
	draw = "主动中断",
	win = "成功"
}
slot0.skillShowType = {
	skill = 1,
	forecast = 2
}
slot0.winColor = GameUtil.parseColor("#88CC66")
slot0.loserColor = GameUtil.parseColor("#e5e0cf")
slot0.winSize = 42
slot0.loserSize = 34
slot0.winImageName1 = "v2a2_eliminate_enemy_pointhpbg"
slot0.loserImageName1 = "v2a2_eliminate_enemy_selfhpbg"
slot0.winImageName2 = "v2a2_eliminate_enemy_pointhpbg3"
slot0.loserImageName2 = "v2a2_eliminate_enemy_selfhpbg23"

return slot0
