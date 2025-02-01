module("modules.logic.fight.system.work.FightWorkIndicatorChange", package.seeall)

slot0 = class("FightWorkIndicatorChange", FightEffectBase)
slot0.ConfigEffect = {
	ClearIndicator = 60017,
	AddIndicator = 60016
}

function slot0.onStart(slot0)
	FightModel.instance:setWaitIndicatorAnimation(false)

	if slot0._actEffectMO.configEffect == uv0.ConfigEffect.AddIndicator then
		FightModel.instance:setIndicatorNum(tonumber(slot0._actEffectMO.targetId), slot0._actEffectMO.effectNum)
	elseif slot0._actEffectMO.configEffect == uv0.ConfigEffect.ClearIndicator then
		FightModel.instance:clearIndicatorNum(slot1)
	end

	if FightModel.instance:isWaitIndicatorAnimation() then
		FightController.instance:registerCallback(FightEvent.OnIndicatorAnimationDone, slot0._delayDone, slot0)
		slot0:com_registTimer(slot0._delayDone, 3)
	else
		slot0:onDone(true)
	end
end

function slot0._delayDone(slot0)
	slot0:clearWork()
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnIndicatorAnimationDone, slot0._delayDone, slot0)
end

return slot0
