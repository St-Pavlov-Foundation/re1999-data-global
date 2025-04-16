module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffect3079_Buff", package.seeall)

slot0 = class("FightEntitySpecialEffect3079_Buff", FightEntitySpecialEffectBase)

function slot0.initClass(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)

	slot0._showBuffIdList = {}
end

slot1 = 1.5
slot2 = 0.9

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if slot1 ~= slot0._entity.id then
		return
	end

	if not slot6 then
		return
	end

	if not FightDataHelper.entityMgr:getById(slot6.fromUid) then
		return
	end

	slot8 = lua_fight_6_buff_effect.configDict[slot7.skin] or lua_fight_6_buff_effect.configDict[0]

	if slot8 and slot8[slot3] and slot2 == FightEnum.EffectType.BUFFADD then
		table.insert(slot0._showBuffIdList, {
			buffId = slot3,
			config = slot8
		})

		if not slot0._playing then
			slot0:_showBuffEffect()
		end
	end
end

function slot0._showBuffEffect(slot0)
	if table.remove(slot0._showBuffIdList, 1) then
		slot0._playing = true
		slot4 = slot0._entity.effect:addHangEffect(slot2.effect, string.nilorempty(slot1.config.effectHang) and ModuleEnum.SpineHangPointRoot or slot2.effectHang, nil, uv0)

		FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot4)
		slot4:setLocalPos(0, 0, 0)
		TaskDispatcher.runDelay(slot0._showBuffEffect, slot0, uv1)

		if slot2.audioId ~= 0 then
			AudioMgr.instance:trigger(slot2.audioId)
		end
	else
		slot0._playing = false
	end
end

function slot0.releaseSelf(slot0)
	TaskDispatcher.cancelTask(slot0._showBuffEffect, slot0)
end

return slot0
