-- chunkname: @modules/logic/fight/system/work/FightWorkNuoDiKaRandomAttackNum349.lua

module("modules.logic.fight.system.work.FightWorkNuoDiKaRandomAttackNum349", package.seeall)

local FightWorkNuoDiKaRandomAttackNum349 = class("FightWorkNuoDiKaRandomAttackNum349", FightEffectBase)

function FightWorkNuoDiKaRandomAttackNum349:onStart()
	local actEffectData = self.actEffectData

	self:com_sendFightEvent(FightEvent.Blood2BengFa, actEffectData)

	local waitPerformance = true

	if actEffectData.effectNum1 == 0 then
		waitPerformance = false
	end

	if waitPerformance then
		self:com_registTimer(self.finishWork, 0.5)
	else
		self:onDone(true)
	end
end

return FightWorkNuoDiKaRandomAttackNum349
