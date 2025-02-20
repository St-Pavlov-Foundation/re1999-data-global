module("modules.logic.fight.system.work.FightWorkChangeCareer", package.seeall)

slot0 = class("FightWorkChangeCareer", FightEffectBase)
slot1 = {
	"buff/buff_lg_yan",
	"buff/buff_lg_xing",
	"buff/buff_lg_mu",
	"buff/buff_lg_shou",
	"buff/buff_lg_ling",
	"buff/buff_lg_zhi"
}

function slot0.onStart(slot0)
	slot1 = slot0:com_registWorkDoneFlowSequence()

	if FightDataHelper.entityMgr:getById(slot0._actEffectMO.targetId) and slot2.career ~= slot0._actEffectMO.effectNum then
		slot1:registWork(FightWorkFunction, slot0._playCareerChange, slot0)
		slot1:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.ChangeCareer))
	end

	slot1:start()
end

function slot0._playCareerChange(slot0)
	if FightDataHelper.entityMgr:getById(slot0._actEffectMO.targetId) then
		FightController.instance:dispatchEvent(FightEvent.ChangeCareer, slot1.id)

		if FightHelper.getEntity(slot1.id) and slot2.effect then
			slot3 = slot2.effect:addHangEffect(uv0[slot1.career], "mounttop", nil, 2)

			FightRenderOrderMgr.instance:onAddEffectWrap(slot2.id, slot3)
			slot3:setLocalPos(0, 0, 0)
		end
	end
end

function slot0._onFlowDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
