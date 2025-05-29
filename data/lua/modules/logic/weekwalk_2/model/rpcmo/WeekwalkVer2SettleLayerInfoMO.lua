module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2SettleLayerInfoMO", package.seeall)

local var_0_0 = pureTable("WeekwalkVer2SettleLayerInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.layerId = arg_1_1.layerId
	arg_1_0.battleInfos = GameUtil.rpcInfosToMap(arg_1_1.battleInfos, WeekwalkVer2SettleBattleInfoMO, "battleId")
	arg_1_0.config = lua_weekwalk_ver2.configDict[arg_1_0.layerId]
	arg_1_0.sceneConfig = lua_weekwalk_ver2_scene.configDict[arg_1_0.config.sceneId]
end

return var_0_0
