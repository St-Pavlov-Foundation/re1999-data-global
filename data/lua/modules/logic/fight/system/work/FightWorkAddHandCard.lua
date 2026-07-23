-- chunkname: @modules/logic/fight/system/work/FightWorkAddHandCard.lua

module("modules.logic.fight.system.work.FightWorkAddHandCard", package.seeall)

local FightWorkAddHandCard = class("FightWorkAddHandCard", FightEffectBase)

function FightWorkAddHandCard:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	self._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local skillId = self.actEffectData.effectNum
	local version = FightModel.instance:getVersion()

	if version >= 4 then
		local flow = self:com_registFlowParallel()

		if self.actEffectData.reserveId == "10034" then
			local cardList = FightDataHelper.handCardMgr:getHandCard()
			local cardData = cardList[#cardList]

			cardData.clientData.custom_addFromRefrigerator = true

			local work = FightMsgMgr.sendMsg(FightMsgId.CardAddRefrieratorTimeline)

			flow:addWork(work)
		end

		local delayTime = 0.5 / FightModel.instance:getUISpeed()

		flow:registWork(FightWorkDelayTimer, delayTime)
		flow:registWork(FightWorkSendEvent, FightEvent.AddHandCard)
		self:playWorkAndDone(flow)
	else
		FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
		self:onDone(true)
	end
end

function FightWorkAddHandCard:clearWork()
	if self._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return FightWorkAddHandCard
