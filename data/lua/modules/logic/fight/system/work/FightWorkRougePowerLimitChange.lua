module("modules.logic.fight.system.work.FightWorkRougePowerLimitChange", package.seeall)

slot0 = class("FightWorkRougePowerLimitChange", FightEffectBase)

function slot0.onStart(slot0)
	FightModel.instance:setRougeExData(FightEnum.ExIndexForRouge.MagicLimit, FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.MagicLimit) + slot0._actEffectMO.effectNum)
	FightController.instance:dispatchEvent(FightEvent.RougeMagicLimitChange)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
