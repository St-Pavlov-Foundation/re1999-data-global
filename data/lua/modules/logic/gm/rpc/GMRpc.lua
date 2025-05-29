module("modules.logic.gm.rpc.GMRpc", package.seeall)

local var_0_0 = class("GMRpc", BaseRpc)

function var_0_0.sendGMRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = GMModule_pb.GMRequest()

	logNormal("sendGMRequest: " .. arg_1_1)

	var_1_0.commandText = arg_1_1
	arg_1_0.callback = arg_1_2
	arg_1_0.callbackObj = arg_1_3

	arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveGMReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.callback then
		if arg_2_0.callbackObj then
			arg_2_0.callback(arg_2_0.callbackObj)
		else
			arg_2_0.callback()
		end

		arg_2_0.callback = nil
		arg_2_0.callbackObj = nil
	end

	if isDebugBuild then
		if arg_2_2.result == 1 then
			ToastController.instance:showToastWithString("GM 执行失败")
		elseif arg_2_2.result == 2 then
			ToastController.instance:showToastWithString("GM 命令不存在")
		end
	end
end

function var_0_0.sendGpuCpuLogRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = GMModule_pb.GpuCpuLogRequest()

	var_3_0.cpu = arg_3_1
	var_3_0.gpu = arg_3_2

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveGpuCpuLogReply(arg_4_0, arg_4_1, arg_4_2)
	return
end

function var_0_0.onReceiveTestGMTextReply(arg_5_0, arg_5_1, arg_5_2)
	GMBattleModel.instance:setBattleParam(arg_5_2.text)
end

function var_0_0.onReceiveGMSummonResultPush(arg_6_0, arg_6_1, arg_6_2)
	GMSummonModel.instance:setInfo(arg_6_2)

	if not ViewMgr.instance:isOpen(ViewName.GMSummonView) then
		ViewMgr.instance:openView(ViewName.GMSummonView)
	end
end

function var_0_0.onReceiveFightTipsMessagePush(arg_7_0, arg_7_1, arg_7_2)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	logError("FightTipsMessagePush: " .. arg_7_2.msg)
end

function var_0_0.onReceiveServerErrorInfoPush(arg_8_0, arg_8_1, arg_8_2)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	logError("服务器报错了: " .. arg_8_2.msg)
end

var_0_0.instance = var_0_0.New()

return var_0_0
