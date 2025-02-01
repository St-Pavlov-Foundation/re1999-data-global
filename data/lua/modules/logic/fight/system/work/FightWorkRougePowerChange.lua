module("modules.logic.fight.system.work.FightWorkRougePowerChange", package.seeall)

slot0 = class("FightWorkRougePowerChange", FightEffectBase)

function slot0.onStart(slot0)
	FightModel.instance:setRougeExData(FightEnum.ExIndexForRouge.Magic, FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.Magic) + slot0._actEffectMO.effectNum)
	FightController.instance:dispatchEvent(FightEvent.RougeMagicChange)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
