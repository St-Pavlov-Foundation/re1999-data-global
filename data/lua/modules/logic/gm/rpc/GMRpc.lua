module("modules.logic.gm.rpc.GMRpc", package.seeall)

slot0 = class("GMRpc", BaseRpc)

function slot0.sendGMRequest(slot0, slot1, slot2, slot3)
	slot4 = GMModule_pb.GMRequest()

	logNormal("sendGMRequest: " .. slot1)

	slot4.commandText = slot1
	slot0.callback = slot2
	slot0.callbackObj = slot3

	slot0:sendMsg(slot4)
end

function slot0.onReceiveGMReply(slot0, slot1, slot2)
	if slot0.callback then
		if slot0.callbackObj then
			slot0.callback(slot0.callbackObj)
		else
			slot0.callback()
		end

		slot0.callback = nil
		slot0.callbackObj = nil
	end

	if isDebugBuild then
		if slot2.result == 1 then
			ToastController.instance:showToastWithString("GM 执行失败")
		elseif slot2.result == 2 then
			ToastController.instance:showToastWithString("GM 命令不存在")
		end
	end
end

function slot0.sendGpuCpuLogRequest(slot0, slot1, slot2)
	slot3 = GMModule_pb.GpuCpuLogRequest()
	slot3.cpu = slot1
	slot3.gpu = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveGpuCpuLogReply(slot0, slot1, slot2)
end

function slot0.onReceiveTestGMTextReply(slot0, slot1, slot2)
	GMBattleModel.instance:setBattleParam(slot2.text)
end

function slot0.onReceiveGMSummonResultPush(slot0, slot1, slot2)
	GMSummonModel.instance:setInfo(slot2)

	if not ViewMgr.instance:isOpen(ViewName.GMSummonView) then
		ViewMgr.instance:openView(ViewName.GMSummonView)
	end
end

function slot0.onReceiveFightTipsMessagePush(slot0, slot1, slot2)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	logError("FightTipsMessagePush: " .. slot2.msg)
end

slot0.instance = slot0.New()

return slot0
