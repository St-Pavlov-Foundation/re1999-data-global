module("modules.logic.fight.entity.comp.specialskineffect.FightEntitySpecialSkinEffect307301_buff4150002", package.seeall)

slot0 = class("FightEntitySpecialSkinEffect307301_buff4150002", FightEntitySpecialEffectBase)

function slot0.initClass(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SetEntityAlpha, slot0._onSetEntityAlpha, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SetBuffEffectVisible, slot0._onSetBuffEffectVisible, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforeEnterStepBehaviour, slot0._onBeforeEnterStepBehaviour, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforeDeadEffect, slot0._onBeforeDeadEffect, slot0)
end

function slot0._releaseEffect(slot0)
	if slot0._effectWrap then
		slot0._entity.effect:removeEffect(slot0._effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._entity.id, slot0._effectWrap)

		slot0._effectWrap = nil
	end
end

slot1 = "v1a5_kerandian/kerandian_innate_1"

function slot0._createEffect(slot0)
	slot0._effectWrap = slot0._effectWrap or slot0._entity.effect:addHangEffect(uv0, ModuleEnum.SpineHangPoint.mountweapon)

	FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot0._effectWrap)
	slot0._effectWrap:setLocalPos(0, 0, 0)
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3, slot4)
	if slot1 ~= slot0._entity.id then
		return
	end

	if slot3 == 4150002 then
		if slot0._entity.buff and slot0._entity.buff:haveBuffId(slot3) then
			slot0:_createEffect()
		else
			slot0:_releaseEffect()
		end
	end
end

function slot0._onBeforeEnterStepBehaviour(slot0)
	if slot0._entity:getMO() then
		for slot6, slot7 in pairs(slot1:getBuffDic()) do
			slot0:_onBuffUpdate(slot0._entity.id, FightEnum.EffectType.BUFFADD, slot7.buffId, slot7.uid)
		end
	end
end

function slot0._onSetEntityAlpha(slot0, slot1, slot2)
	slot0:_onSetBuffEffectVisible(slot1, slot2, "_onSetEntityAlpha")
end

function slot0._onSetBuffEffectVisible(slot0, slot1, slot2, slot3)
	if slot0._entity.id == slot1 and slot0._effectWrap then
		slot0._effectWrap:setActive(slot2, slot3 or "FightEntitySpecialSkinEffect307301_buff4150002")
	end
end

function slot0._onBeforeDeadEffect(slot0, slot1)
	if slot1 == slot0._entity.id then
		slot0:_releaseEffect()
	end
end

function slot0.releaseSelf(slot0)
	slot0:_releaseEffect()
end

return slot0
