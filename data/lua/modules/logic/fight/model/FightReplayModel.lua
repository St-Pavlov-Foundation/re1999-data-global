module("modules.logic.fight.model.FightReplayModel", package.seeall)

local var_0_0 = class("FightReplayModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onReceiveGetFightOperReply(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.operRecords) do
		local var_3_1 = FightRoundOperRecordMO.New()

		var_3_1:init(iter_3_1)
		table.insert(var_3_0, var_3_1)
	end

	arg_3_0:setList(var_3_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
