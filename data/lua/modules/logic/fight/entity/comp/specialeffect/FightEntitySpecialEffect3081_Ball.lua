module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffect3081_Ball", package.seeall)

slot0 = class("FightEntitySpecialEffect3081_Ball", FightEntitySpecialEffectBase)

function slot0.initClass(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SetBuffEffectVisible, slot0._onSetBuffEffectVisible, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0, LuaEventSystem.High)
	slot0:addEventCb(FightController.instance, FightEvent.BeforeEnterStepBehaviour, slot0._onBeforeEnterStepBehaviour, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforeDeadEffect, slot0._onBeforeDeadEffect, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SkillEditorRefreshBuff, slot0._onSkillEditorRefreshBuff, slot0)

	slot0._ballEffect = {}
end

slot1 = "default"
slot0.skin2EffectPath = {
	{
		[308103.0] = "v2a1_ysed_jscq/ysed_jscq_idle_01_head02",
		[slot1] = "v1a7_ysed/ysed_idle_01_head02"
	},
	{
		[308103.0] = "v2a1_ysed_jscq/ysed_jscq_idle_02_head02",
		[slot1] = "v1a7_ysed/ysed_idle_02_head02"
	},
	{
		[308103.0] = "v2a1_ysed_jscq/ysed_jscq_idle_03_head02",
		[slot1] = "v1a7_ysed/ysed_idle_03_head02"
	}
}
slot0.buffId2EffectPath = {
	[30810101] = slot0.skin2EffectPath[1],
	[30810102] = slot0.skin2EffectPath[2],
	[30810110] = slot0.skin2EffectPath[2],
	[30810112] = slot0.skin2EffectPath[2],
	[30810114] = slot0.skin2EffectPath[2],
	[30810103] = slot0.skin2EffectPath[3],
	[30810111] = slot0.skin2EffectPath[3],
	[30810113] = slot0.skin2EffectPath[3],
	[30810115] = slot0.skin2EffectPath[3]
}

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3, slot4)
	if slot1 ~= slot0._entity.id then
		return
	end

	if not lua_skill_buff.configDict[slot3] then
		logError("buff表找不到id:" .. slot3)

		return
	end

	if not slot0._entity:getMO() then
		return
	end

	if uv0.buffId2EffectPath[slot3] then
		if slot2 == FightEnum.EffectType.BUFFADD then
			slot0:_releaseEffect(slot3)

			slot8 = slot0._entity.effect:addHangEffect(slot7[slot6.skin] or slot7[uv1], ModuleEnum.SpineHangPointRoot)

			slot8:setLocalPos(slot0._entity:isMySide() and 1 or -1, 3.1, 0)

			slot0._ballEffect[slot3] = slot8
		elseif slot2 == FightEnum.EffectType.BUFFDEL then
			slot0:_releaseEffect(slot3)
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

function slot0._onSkillEditorRefreshBuff(slot0)
	slot0:releaseAllEffect()
	slot0:_onBeforeEnterStepBehaviour()
end

function slot0._onSetBuffEffectVisible(slot0, slot1, slot2, slot3)
	if slot0._entity.id == slot1 and slot0._ballEffect then
		for slot7, slot8 in pairs(slot0._ballEffect) do
			slot8:setActive(slot2, slot3 or "FightEntitySpecialEffect3081_Ball")
		end
	end
end

function slot0._onSkillPlayStart(slot0, slot1)
	slot0:_onSetBuffEffectVisible(slot1.id, false, "FightEntitySpecialEffect3081_Ball_PlaySkill")
end

function slot0._onSkillPlayFinish(slot0, slot1)
	slot0:_onSetBuffEffectVisible(slot1.id, true, "FightEntitySpecialEffect3081_Ball_PlaySkill")
end

function slot0._releaseEffect(slot0, slot1)
	if slot0._ballEffect[slot1] then
		slot0._entity.effect:removeEffect(slot2)
	end

	slot0._ballEffect[slot1] = nil
end

function slot0.releaseAllEffect(slot0)
	for slot4, slot5 in pairs(slot0._ballEffect) do
		slot0:_releaseEffect(slot4)
	end
end

function slot0._onBeforeDeadEffect(slot0, slot1)
	if slot1 == slot0._entity.id then
		slot0:releaseAllEffect()
	end
end

function slot0.releaseSelf(slot0)
	slot0:releaseAllEffect()
end

return slot0
