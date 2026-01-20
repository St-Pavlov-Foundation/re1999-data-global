-- chunkname: @modules/logic/fight/system/work/FightWorkEffectCardEffectChange.lua

module("modules.logic.fight.system.work.FightWorkEffectCardEffectChange", package.seeall)

local FightWorkEffectCardEffectChange = class("FightWorkEffectCardEffectChange", FightEffectBase)

function FightWorkEffectCardEffectChange:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	local indexs = string.splitToNumber(self.actEffectData.reserveStr, "#")
	local handCards = FightDataHelper.handCardMgr.handCard

	for i, v in ipairs(indexs) do
		if handCards[v] then
			FightController.instance:dispatchEvent(FightEvent.RefreshOneHandCard, v)
			FightController.instance:dispatchEvent(FightEvent.CardEffectChange, v)
		end
	end

	self:onDone(true)
end

function FightWorkEffectCardEffectChange:clearWork()
	return
end

return FightWorkEffectCardEffectChange
