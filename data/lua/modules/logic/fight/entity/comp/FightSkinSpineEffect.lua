module("modules.logic.fight.entity.comp.FightSkinSpineEffect", package.seeall)

slot0 = class("FightSkinSpineEffect", LuaCompBase)
slot1 = {
	buff_jjhhy = true
}
slot2 = {
	buff_jjhhy = true
}

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._effectWrapDict = nil
	slot0._monsterEffect = {}
end

function slot0.init(slot0, slot1)
	slot0._spine = slot0.entity.spine

	slot0._spine:registerCallback(UnitSpine.Evt_OnLoaded, slot0._onLoaded, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._spine:unregisterCallback(UnitSpine.Evt_OnLoaded, slot0._onLoaded, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	TaskDispatcher.cancelTask(slot0._delayShowSpine, slot0)
end

function slot0.onDestroy(slot0)
	if slot0._effectWrapDict then
		for slot4, slot5 in pairs(slot0._effectWrapDict) do
			slot0.entity.effect:removeEffect(slot5)
		end

		slot0._effectWrapDict = nil
	end
end

function slot0._onSkillPlayStart(slot0, slot1, slot2, slot3)
	if slot0.entity == slot1 then
		slot0:_setMonsterEffectActive(false, slot0.__cname)
	end
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2, slot3)
	if slot0.entity == slot1 then
		slot0:_setMonsterEffectActive(true, slot0.__cname)
	end
end

function slot0._setMonsterEffectActive(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0._monsterEffect) do
		if not uv0[slot6] then
			slot7:setActive(slot1, slot2)
		end
	end
end

function slot0._onLoaded(slot0)
	if not string.nilorempty(FightConfig.instance:getSkinCO(slot0.entity:getMO().skin).effect) then
		for slot8, slot9 in ipairs(string.split(slot2.effect, "#")) do
			slot0:_addEffect(slot9, string.split(slot2.effectHangPoint, "#")[slot8])
		end

		slot0:_setSpineAlphaForRoleEffect(slot3)
	end

	if lua_monster.configDict[slot1.modelId] and not string.nilorempty(slot3.effect) then
		for slot9, slot10 in ipairs(string.split(slot3.effect, "#")) do
			slot0._monsterEffect[slot10] = slot0:_addEffect(slot10, string.split(slot3.effectHangPoint, "#")[slot9])
		end

		slot0:_setSpineAlphaForRoleEffect(slot4)
	end
end

function slot0._setSpineAlphaForRoleEffect(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if uv0[slot6] then
			slot0.entity.spineRenderer:setAlpha(0, 0)
			TaskDispatcher.runDelay(slot0._delayShowSpine, slot0, 0.1)

			break
		end
	end
end

function slot0._delayShowSpine(slot0)
	slot0.entity.spineRenderer:setAlpha(1)
end

function slot0._addEffect(slot0, slot1, slot2)
	slot3 = slot0.entity.effect:addHangEffect(slot1, slot2)

	slot3:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(slot0.entity.id, slot3)

	slot0._effectWrapDict = slot0._effectWrapDict or {}
	slot0._effectWrapDict[slot1] = slot3

	return slot3
end

function slot0.hideEffects(slot0, slot1)
	if slot0._effectWrapDict then
		for slot5, slot6 in pairs(slot0._effectWrapDict) do
			if not uv0[slot5] then
				slot6:setActive(false, slot1)
			end
		end
	end
end

function slot0.showEffects(slot0, slot1)
	if slot0._effectWrapDict then
		for slot5, slot6 in pairs(slot0._effectWrapDict) do
			if not uv0[slot5] then
				slot6:setActive(true, slot1)
			end
		end
	end
end

return slot0
