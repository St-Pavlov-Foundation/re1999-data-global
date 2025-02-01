module("modules.logic.fight.system.work.FightWorkRougeCoinChange", package.seeall)

slot0 = class("FightWorkRougeCoinChange", FightEffectBase)

function slot0.onStart(slot0)
	FightModel.instance:setRougeExData(FightEnum.ExIndexForRouge.Coin, FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.Coin) + slot0._actEffectMO.effectNum)
	FightController.instance:dispatchEvent(FightEvent.RougeCoinChange, slot0._actEffectMO.effectNum)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
