module("modules.logic.fight.system.work.FightWorkBeContract", package.seeall)

slot0 = class("FightWorkBeContract", FightEffectBase)

function slot0.onStart(slot0)
	FightModel.instance:setBeContractEntityUid(slot0._actEffectMO.targetId)
	slot0:onDone(true)
end

return slot0
