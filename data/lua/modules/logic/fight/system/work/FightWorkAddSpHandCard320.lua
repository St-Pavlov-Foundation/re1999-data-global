-- chunkname: @modules/logic/fight/system/work/FightWorkAddSpHandCard320.lua

module("modules.logic.fight.system.work.FightWorkAddSpHandCard320", package.seeall)

local FightWorkAddSpHandCard320 = class("FightWorkAddSpHandCard320", FightEffectBase)

function FightWorkAddSpHandCard320:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	self._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_add_universalcard)
	FightController.instance:dispatchEvent(FightEvent.SpCardAdd, #FightDataHelper.handCardMgr.handCard)
	self:com_registTimer(self._delayAfterPerformance, 0.7 / FightModel.instance:getUISpeed())
end

function FightWorkAddSpHandCard320:clearWork()
	if self._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return FightWorkAddSpHandCard320
