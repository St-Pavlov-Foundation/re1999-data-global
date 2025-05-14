module("modules.logic.handbook.rpc.HandbookRpc", package.seeall)

local var_0_0 = class("HandbookRpc", BaseRpc)

function var_0_0.sendGetHandbookInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = HandbookModule_pb.GetHandbookInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetHandbookInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	HandbookModel.instance:setReadInfos(arg_2_2.infos)
	HandbookModel.instance:setFragmentInfo(arg_2_2.elementInfo)
end

function var_0_0.sendHandbookReadRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = HandbookModule_pb.HandbookReadRequest()

	var_3_0.type = arg_3_1
	var_3_0.id = arg_3_2

	return arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveHandbookReadReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = {
		isRead = true,
		type = arg_4_2.type,
		id = arg_4_2.id
	}

	HandbookModel.instance:setReadInfo(var_4_0)
	HandbookController.instance:dispatchEvent(HandbookEvent.OnReadInfoChanged, var_4_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
