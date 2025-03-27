module("modules.logic.fight.system.work.FightWorkIndicatorChange", package.seeall)

slot0 = class("FightWorkIndicatorChange", FightEffectBase)
slot0.ConfigEffect = {
	ClearIndicator = 60017,
	AddIndicator = 60016
}

function slot0.onStart(slot0)
	FightModel.instance:setWaitIndicatorAnimation(false)
	slot0:com_sendFightEvent(FightEvent.OnIndicatorChange, tonumber(slot0._actEffectMO.targetId))

	if FightModel.instance:isWaitIndicatorAnimation() then
		slot0:com_registTimer(slot0._delayDone, 3)
		slot0:com_registFightEvent(FightEvent.OnIndicatorAnimationDone, slot0._delayDone)
	else
		slot0:onDone(true)
	end
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
