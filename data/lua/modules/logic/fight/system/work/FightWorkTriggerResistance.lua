module("modules.logic.fight.system.work.FightWorkTriggerResistance", package.seeall)

slot0 = class("FightWorkTriggerResistance", FightEffectBase)
slot0.effectPath = "buff/buff_streamer"
slot0.hangPoint = "mountroot"
slot0.relaseTime = 2

function slot0.onStart(slot0)
	if not FightHelper.getEntity(slot0._actEffectMO.targetId) then
		slot0:onDone(true)

		return
	end

	slot2 = slot1.effect:addHangEffect(uv0.effectPath, uv0.hangPoint, nil, uv0.relaseTime)

	slot2:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(slot1.id, slot2)
	slot0:onDone(true)
end

return slot0
