module("modules.logic.scene.fight.comp.FightSceneEntityFootRing", package.seeall)

slot0 = class("FightSceneEntityFootRing", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0:_setLevelCO(slot2)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, slot0._onEntityDeadBefore, slot0)
	FightController.instance:registerCallback(FightEvent.BeforePlayUniqueSkill, slot0._onBeforePlayUniqueSkill, slot0)
	FightController.instance:registerCallback(FightEvent.AfterPlayUniqueSkill, slot0._onAfterPlayUniqueSkill, slot0)
	FightController.instance:registerCallback(FightEvent.SetEntityFootEffectVisible, slot0._onSetEntityFootEffectVisible, slot0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, slot0._releaseAllEntityEffect, slot0)
end

function slot0.onScenePrepared(slot0, slot1, slot2)
	slot0:getCurScene().level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
end

function slot0.onSceneClose(slot0)
	slot0:getCurScene().level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, slot0._onEntityDeadBefore, slot0)
	FightController.instance:unregisterCallback(FightEvent.BeforePlayUniqueSkill, slot0._onBeforePlayUniqueSkill, slot0)
	FightController.instance:unregisterCallback(FightEvent.AfterPlayUniqueSkill, slot0._onAfterPlayUniqueSkill, slot0)
	FightController.instance:unregisterCallback(FightEvent.SetEntityFootEffectVisible, slot0._onSetEntityFootEffectVisible, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, slot0._releaseAllEntityEffect, slot0)
	slot0:_releaseFlyEffect()
end

function slot0._onSpineLoaded(slot0, slot1)
	if not slot1 or not slot0._fly_effect_url then
		return
	end

	slot0:_setSpineFlyEffect(slot1)
end

function slot0._onLevelLoaded(slot0, slot1)
	slot0:_releaseFlyEffect()
	slot0:_setLevelCO(slot1)
	slot0:_setAllSpineFlyEffect()
end

function slot0._setLevelCO(slot0, slot1)
	if not string.nilorempty(lua_scene_level.configDict[slot1].flyEffect) then
		TaskDispatcher.runRepeat(slot0._onFrameUpdateEffectPos, slot0, 0.01)

		slot0._fly_effect_url = "buff/buff_feixing"
	end
end

function slot0._setAllSpineFlyEffect(slot0)
	if not slot0._fly_effect_url then
		return
	end

	for slot5, slot6 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)) do
		if slot6.spine and slot0._fly_effect_url then
			slot0:_setSpineFlyEffect(slot6.spine)
		end
	end
end

function slot0._setSpineFlyEffect(slot0, slot1)
	if not slot1.unitSpawn:isMySide() then
		return
	end

	slot3 = slot2.id

	if not slot2:getMO() then
		return
	end

	if not FightConfig.instance:getSkinCO(slot4.skin) or slot5.isFly == 1 then
		return
	end

	if not slot0.foot_effect then
		slot0.foot_effect = {}
		slot0.origin_pos_y = {}
		slot0.cache_entity = {}
	end

	if slot0.cache_entity[slot3] then
		slot0:_onEntityDeadBefore(slot3)
	end

	slot6, slot0.origin_pos_y[slot3] = FightHelper.getEntityStandPos(slot4)
	slot0.cache_entity[slot3] = slot2
	slot0.foot_effect[slot3] = slot0.foot_effect[slot3] or slot2.effect:addHangEffect(slot0._fly_effect_url)
end

function slot0._onFrameUpdateEffectPos(slot0)
	if slot0.foot_effect then
		for slot4, slot5 in pairs(slot0.foot_effect) do
			if slot0.cache_entity[slot4] and not gohelper.isNil(slot6.go) and slot6.go then
				slot8, slot9, slot10 = transformhelper.getPos(slot7.transform)

				slot0.foot_effect[slot4]:setWorldPos(slot8, slot0.origin_pos_y[slot4], slot10)
			end
		end
	end
end

function slot0._onBeforePlayUniqueSkill(slot0)
	if slot0.foot_effect then
		for slot4, slot5 in pairs(slot0.foot_effect) do
			gohelper.setActive(slot5.containerGO, false)
		end
	end
end

function slot0._onAfterPlayUniqueSkill(slot0)
	if slot0.foot_effect then
		for slot4, slot5 in pairs(slot0.foot_effect) do
			gohelper.setActive(slot5.containerGO, true)
		end
	end
end

function slot0._onEntityDeadBefore(slot0, slot1)
	if slot0.foot_effect and slot0.foot_effect[slot1] then
		if slot0.cache_entity[slot1] and slot2.effect then
			slot2.effect:removeEffect(slot0.foot_effect[slot1])
		end

		slot0.foot_effect[slot1] = nil
		slot0.cache_entity[slot1] = nil
	end
end

function slot0._onSetEntityFootEffectVisible(slot0, slot1, slot2)
	if slot0.foot_effect and slot0.foot_effect[slot1] then
		slot0:_onFrameUpdateEffectPos()
		gohelper.setActive(slot0.foot_effect[slot1].containerGO, slot2 or false)
	end
end

function slot0._releaseAllEntityEffect(slot0)
	if slot0.foot_effect then
		for slot4, slot5 in pairs(slot0.foot_effect) do
			slot0:_onEntityDeadBefore(slot4)
		end
	end
end

function slot0._releaseFlyEffect(slot0)
	TaskDispatcher.cancelTask(slot0._onFrameUpdateEffectPos, slot0)
	slot0:_releaseAllEntityEffect()

	slot0.origin_pos_y = nil
	slot0.foot_effect = nil
	slot0._fly_effect_url = nil
	slot0.cache_entity = nil
end

return slot0
