module("modules.logic.fight.system.work.FightWorkContract", package.seeall)

slot0 = class("FightWorkContract", FightEffectBase)

function slot0.onStart(slot0)
	if FightDataHelper.entityMgr:getById(slot0._actEffectMO.targetId) then
		slot1:clearNotifyBindContract()
		FightModel.instance:setContractEntityUid(slot1.uid)
	end

	slot0:onDone(true)
end

return slot0
