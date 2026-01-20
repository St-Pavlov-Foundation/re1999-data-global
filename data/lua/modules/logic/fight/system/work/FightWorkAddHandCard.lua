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

	local version = FightModel.instance:getVersion()

	if version >= 4 then
		local delayTime = 0.5

		self:com_registTimer(self._delayAfterPerformance, delayTime)
		FightController.instance:dispatchEvent(FightEvent.AddHandCard)
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
