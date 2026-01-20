-- chunkname: @modules/logic/fight/system/work/FightWorkSendOperate2Server.lua

module("modules.logic.fight.system.work.FightWorkSendOperate2Server", package.seeall)

local FightWorkSendOperate2Server = class("FightWorkSendOperate2Server", FightWorkItem)

function FightWorkSendOperate2Server:onConstructor()
	return
end

function FightWorkSendOperate2Server:onStart()
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.SendOperation2Server)

	local flow = self:com_registFlowSequence()
	local cardAniWork = FightMsgMgr.sendMsg(FightMsgId.RegistCardEndAniFlow)

	if cardAniWork then
		flow:addWork(cardAniWork)
	end

	flow:registFinishCallback(self.onFinish, self)
	self:playWorkAndDone(flow)
end

function FightWorkSendOperate2Server:onFinish()
	local cards = FightDataHelper.handCardMgr.handCard

	FightDataUtil.coverData(cards, FightLocalDataMgr.instance.handCardMgr:getHandCard())
	FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, false)

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	FightRpc.instance:sendBeginRoundRequest(FightDataHelper.operationDataMgr:getOpList())

	local version = FightModel.instance:getVersion()

	if version >= 1 then
		FightController.instance:dispatchEvent(FightEvent.ShowSimulateClientUsedCard)

		return
	end

	FightPlayCardModel.instance:updateClientOps()
	FightController.instance:dispatchEvent(FightEvent.UpdateWaitingArea)
end

return FightWorkSendOperate2Server
