module("modules.logic.fight.model.FightReplayModel", package.seeall)

local var_0_0 = class("FightReplayModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._isReplay = false
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._isReplay = false
end

function var_0_0.isReplay(arg_3_0)
	if FightModel.instance:getVersion() >= 1 then
		return FightModel.instance:isRecord()
	end

	return arg_3_0._isReplay
end

function var_0_0.setReconnectReplay(arg_4_0, arg_4_1)
	arg_4_0._reconnectReplay = arg_4_1
end

function var_0_0.isReconnectReplay(arg_5_0)
	return arg_5_0._reconnectReplay
end

function var_0_0.setReplay(arg_6_0, arg_6_1)
	arg_6_0._isReplay = arg_6_1
end

function var_0_0.onReceiveGetFightOperReply(arg_7_0, arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.operRecords) do
		local var_7_1 = FightRoundOperRecordMO.New()

		var_7_1:init(iter_7_1)
		table.insert(var_7_0, var_7_1)
	end

	arg_7_0:setList(var_7_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
