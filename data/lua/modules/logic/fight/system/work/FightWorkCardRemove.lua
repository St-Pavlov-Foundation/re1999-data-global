-- chunkname: @modules/logic/fight/system/work/FightWorkCardRemove.lua

module("modules.logic.fight.system.work.FightWorkCardRemove", package.seeall)

local FightWorkCardRemove = class("FightWorkCardRemove", FightEffectBase)

function FightWorkCardRemove:beforePlayEffectData()
	self.oldCardList = FightDataUtil.copyData(FightDataHelper.handCardMgr.handCard)
end

function FightWorkCardRemove:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	self._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local removeIndexes = string.splitToNumber(self.actEffectData.reserveStr, "#")

	if #removeIndexes > 0 then
		local cards = self.oldCardList

		table.sort(removeIndexes, FightWorkCardRemove2.sort)

		local delayTime = FightCardDataHelper.calcRemoveCardTime(cards, removeIndexes)

		for i, v in ipairs(removeIndexes) do
			table.remove(cards, v)
		end

		local version = FightModel.instance:getVersion()

		if version >= 4 then
			self:com_registTimer(self._delayAfterPerformance, delayTime / FightModel.instance:getUISpeed())
			FightController.instance:dispatchEvent(FightEvent.CardRemove, removeIndexes)
		else
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			self:onDone(true)
		end

		return
	end

	self:onDone(true)
end

function FightWorkCardRemove:_onCombineDone()
	self:onDone(true)
end

function FightWorkCardRemove:_delayAfterPerformance()
	self:onDone(true)
end

function FightWorkCardRemove:_delayDone()
	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	self:onDone(true)
end

function FightWorkCardRemove:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._onCombineDone, self)

	if self._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return FightWorkCardRemove
