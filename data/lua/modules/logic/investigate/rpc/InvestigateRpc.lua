module("modules.logic.investigate.rpc.InvestigateRpc", package.seeall)

local var_0_0 = class("InvestigateRpc", BaseRpc)

function var_0_0.sendGetInvestigateRequest(arg_1_0)
	local var_1_0 = InvestigateModule_pb.GetInvestigateRequest()

	arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveGetInvestigateReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	local var_2_0 = arg_2_2.info

	InvestigateOpinionModel.instance:initOpinionInfo(var_2_0)
end

function var_0_0.sendPutClueRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = InvestigateModule_pb.PutClueRequest()

	var_3_0.id = arg_3_1
	var_3_0.clueId = arg_3_2

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceivePutClueReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = arg_4_2.id
	local var_4_1 = arg_4_2.clueId

	InvestigateOpinionModel.instance:setLinkedStatus(var_4_1, true)
	InvestigateController.instance:dispatchEvent(InvestigateEvent.LinkedOpinionSuccess, var_4_1)
end

function var_0_0.onReceiveInvestigateInfoPush(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= 0 then
		return
	end

	local var_5_0 = arg_5_2.info

	InvestigateOpinionModel.instance:initOpinionInfo(var_5_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
