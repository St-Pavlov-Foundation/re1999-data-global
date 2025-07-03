module("modules.logic.versionactivity2_7.act191.model.Act191NodeDetailMO", package.seeall)

local var_0_0 = pureTable("Act191NodeDetailMO")

function var_0_0.init(arg_1_0, arg_1_1)
	local var_1_0 = cjson.decode(arg_1_1)

	arg_1_0.type = var_1_0.type
	arg_1_0.shopId = var_1_0.shopId
	arg_1_0.shopFreshNum = var_1_0.shopFreshNum
	arg_1_0.shopPosMap = var_1_0.shopPosMap
	arg_1_0.boughtSet = var_1_0.boughtSet
	arg_1_0.enhanceList = var_1_0.enhanceList
	arg_1_0.enhanceNumList = var_1_0.enhanceNumList
	arg_1_0.eventId = var_1_0.eventId
	arg_1_0.fightEventId = var_1_0.fightEventId

	if var_1_0.matchInfo then
		arg_1_0.matchInfo = Act191MatchMO.New()

		arg_1_0.matchInfo:init(var_1_0.matchInfo)
	end
end

return var_0_0
