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
	slot0:cancelFightWorkSafeTimer()

	slot0._flow = FlowSequence.New()

	slot0._flow:registerDoneListener(slot0._onFlowDone, slot0)

	if FightEntityModel.instance:getById(slot0._actEffectMO.targetId) and slot1.career ~= slot0._actEffectMO.effectNum then
		slot0._flow:addWork(FunctionWork.New(slot0._playCareerChange, slot0))
		slot0._flow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.ChangeCareer))
	end

	slot0._flow:start()
end

function slot0._playCareerChange(slot0)
	if FightEntityModel.instance:getById(slot0._actEffectMO.targetId) then
		slot1.career = slot0._actEffectMO.effectNum

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
	if slot0._flow then
		slot0._flow:unregisterDoneListener(slot0._onFlowDone, slot0)
		slot0._flow:stop()

		slot0._flow = nil
	end
end

return slot0
