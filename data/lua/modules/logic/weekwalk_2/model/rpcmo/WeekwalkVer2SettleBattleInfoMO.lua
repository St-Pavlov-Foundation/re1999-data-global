module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2SettleBattleInfoMO", package.seeall)

local var_0_0 = pureTable("WeekwalkVer2SettleBattleInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.battleId = arg_1_1.battleId
	arg_1_0.cupInfos = GameUtil.rpcInfosToMap(arg_1_1.cupInfos or {}, WeekwalkVer2CupInfoMO, "index")
end

return var_0_0
