module("modules.logic.fight.entity.comp.specialeffect.FightSceneSpecialEffect0_HuanJingKa", package.seeall)

slot0 = class("FightSceneSpecialEffect0_HuanJingKa", FightEntitySpecialEffectBase)
slot1 = "v1a3_huanjing/v1a3_scene_huanjing_effect_01"
slot2 = "v1a3_scene_huanjing_effect_01"
slot3 = "v1a3_scene_huanjing_effect_03"
slot4 = "v1a3_scene_huanjing_effect_04"

function slot0.initClass(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnFightReconnectLastWork, slot0._onFightReconnectLastWork, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.EntityEffectLoaded, slot0._onEntityEffectLoaded, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3)
	if slot0:_isEffectBuff(slot3) then
		slot0:_dealHuanJingChangJingTeXiao(slot1, slot2, slot3)
	end
end

function slot0._dealHuanJingChangJingTeXiao(slot0, slot1, slot2, slot3)
	if FightHelper.getEntity(slot1) and slot4:getMO() and slot5.side == FightEnum.EntitySide.MySide and slot2 == FightEnum.EffectType.BUFFADD then
		slot0:_showEffect()
	end
end

function slot0._showEffect(slot0)
	if slot0._playing then
		return
	end

	slot0._playing = true
	slot0._aniName = uv0

	if not slot0._effectWrap then
		slot0._effectWrap = slot0._entity.effect:addGlobalEffect(uv1)
	else
		slot0._effectWrap:setActive(true)
		slot0:_refreshAni()
	end
end

function slot0._onEntityEffectLoaded(slot0, slot1, slot2)
	if slot1 ~= slot0._entity.id then
		return
	end

	if slot2.path == FightHelper.getEffectUrlWithLod(uv0) then
		slot0._ani = gohelper.onceAddComponent(gohelper.findChild(slot2.effectGO, "root"), typeof(UnityEngine.Animator))

		slot0:_refreshAni()
	end
end

function slot0._refreshAni(slot0)
	if slot0._ani then
		if slot0._aniName == uv0 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_effects_fight_dreamland02)
		elseif slot0._aniName ~= uv1 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_effects_fight_dreamland01)
		end

		slot0._ani:Play(slot0._aniName)
	end
end

function slot0._hideEffect(slot0)
	slot0._aniName = uv0

	slot0:_refreshAni()
end

function slot0._onRoundSequenceFinish(slot0)
	if not slot0:_detectHaveBuff() and slot0._effectWrap then
		if not slot0._playing then
			return
		end

		slot0._playing = false

		slot0:_hideEffect()
	end
end

function slot0._onFightReconnectLastWork(slot0)
	if slot0:_detectHaveBuff() then
		slot0:_showEffect()
	end
end

function slot0._detectHaveBuff(slot0)
	slot1 = false

	for slot6, slot7 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)) do
		if slot7:getMO() then
			for slot13, slot14 in pairs(slot8:getBuffDic()) do
				if slot0:_isEffectBuff(slot14.buffId) then
					slot1 = true

					break
				end
			end

			if slot1 then
				break
			end
		end
	end

	return slot1
end

function slot0._isEffectBuff(slot0, slot1)
	if lua_skill_buff.configDict[slot1] and (slot2.typeId == 2130101 or slot2.typeId == 2130102 or slot2.typeId == 2130103 or slot2.typeId == 2130104 or slot2.typeId == 4130030 or slot2.typeId == 4130031 or slot2.typeId == 4130059 or slot2.typeId == 4130060 or slot2.typeId == 4130061 or slot2.typeId == 4130062) then
		return true
	end
end

function slot0._onSkillPlayStart(slot0, slot1, slot2)
	if slot1:getMO() and slot3:isUniqueSkill(slot2) and slot0:_detectHaveBuff() and slot0._effectWrap then
		slot0:_hideEffect()
	end
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2)
	if slot1:getMO() and slot3:isUniqueSkill(slot2) and slot0:_detectHaveBuff() and slot0._effectWrap then
		slot0._aniName = uv0

		slot0:_refreshAni()
	end
end

function slot0._releaseEffect(slot0)
	if slot0._effectWrap then
		FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._entity.id, slot0._effectWrap)

		slot0._effectWrap = nil
	end
end

function slot0.releaseSelf(slot0)
	slot0:_releaseEffect()
end

return slot0
