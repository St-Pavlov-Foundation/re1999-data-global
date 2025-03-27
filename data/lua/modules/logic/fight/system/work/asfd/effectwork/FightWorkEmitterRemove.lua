module("modules.logic.fight.system.work.asfd.effectwork.FightWorkEmitterRemove", package.seeall)

slot0 = class("FightWorkEmitterRemove", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0.emitterMo = FightDataHelper.entityMgr:getASFDEntityMo(slot0._actEffectMO.effectNum)
end

function slot0.onStart(slot0)
	if not slot0.emitterMo then
		return slot0:onDone(true)
	end

	if not (GameSceneMgr.instance:getCurScene() and slot1.entityMgr) then
		return slot0:onDone(true)
	end

	if FightHelper.getEntity(slot0.emitterMo.id) then
		slot2:removeUnit(slot3:getTag(), slot3.id)
	end

	slot0:onDone(true)
end

return slot0
