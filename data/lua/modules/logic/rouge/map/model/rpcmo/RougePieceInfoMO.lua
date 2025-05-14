module("modules.logic.rouge.map.model.rpcmo.RougePieceInfoMO", package.seeall)

local var_0_0 = pureTable("RougePieceInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.index = arg_1_1.index
	arg_1_0.id = arg_1_1.id
	arg_1_0.talkId = arg_1_1.talkId
	arg_1_0.finish = arg_1_1.finish
	arg_1_0.selectId = arg_1_1.selectId

	arg_1_0:updateTriggerStr(arg_1_1.triggerStr)

	arg_1_0.pieceCo = RougeMapConfig.instance:getPieceCo(arg_1_0.id)
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0.finish = arg_2_1.finish
	arg_2_0.selectId = arg_2_1.selectId

	arg_2_0:updateTriggerStr(arg_2_1.triggerStr)
end

function var_0_0.updateTriggerStr(arg_3_0, arg_3_1)
	if string.nilorempty(arg_3_1) or arg_3_1 == "null" then
		arg_3_0.triggerStr = nil
	else
		arg_3_0.triggerStr = cjson.decode(arg_3_1)
	end
end

function var_0_0.getPieceCo(arg_4_0)
	return arg_4_0.pieceCo
end

function var_0_0.isFinish(arg_5_0)
	return arg_5_0.finish
end

return var_0_0
