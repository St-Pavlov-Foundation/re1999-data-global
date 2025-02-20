module("modules.logic.scene.fight.comp.FightSceneWadingEffect", package.seeall)

slot0 = class("FightSceneWadingEffect", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0:_setLevelCO(slot2)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, slot0._releaseEntityEffect, slot0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, slot0._releaseAllEntityEffect, slot0)
	FightController.instance:registerCallback(FightEvent.BeforeChangeSubHero, slot0._releaseEntityEffect, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:registerCallback(FightEvent.SetEntityAlpha, slot0._onSetEntityAlpha, slot0)
end

function slot0.onScenePrepared(slot0, slot1, slot2)
	slot0:getCurScene().level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
end

function slot0.onSceneClose(slot0)
	slot0:getCurScene().level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, slot0._releaseEntityEffect, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, slot0._releaseAllEntityEffect, slot0)
	FightController.instance:unregisterCallback(FightEvent.BeforeChangeSubHero, slot0._releaseEntityEffect, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.SetEntityAlpha, slot0._onSetEntityAlpha, slot0)
	slot0:_releaseEffect()
end

function slot0._onSpineLoaded(slot0, slot1)
	if not slot1 or not slot0._effectUrl then
		return
	end

	slot0:_setSpineEffect(slot1)
end

function slot0._onLevelLoaded(slot0, slot1)
	slot0:_releaseEffect()
	slot0:_setLevelCO(slot1)
	slot0:_setAllSpineEffect()
end

function slot0._setLevelCO(slot0, slot1)
	if not string.nilorempty(lua_scene_level.configDict[slot1].wadeEffect) then
		TaskDispatcher.runRepeat(slot0._onFrameUpdateEffectPos, slot0, 0.01)

		if string.split(slot3, "#")[1] == "1" then
			slot0._side = FightEnum.EntitySide.EnemySide
		elseif slot5 == "2" then
			slot0._side = FightEnum.EntitySide.MySide
		elseif slot5 == "3" then
			slot0._side = nil
		end

		slot0._effectUrl = slot4[2]
	end
end

function slot0._setAllSpineEffect(slot0)
	if not slot0._effectUrl then
		return
	end

	slot1 = nil

	if slot0._side then
		slot1 = FightHelper.getSideEntitys(slot0._side, true)
	else
		slot6 = FightEnum.EntitySide.MySide

		for slot5, slot6 in ipairs(FightHelper.getSideEntitys(slot6, true)) do
			table.insert({}, slot6)
		end

		slot6 = FightEnum.EntitySide.EnemySide

		for slot5, slot6 in ipairs(FightHelper.getSideEntitys(slot6, true)) do
			table.insert(slot1, slot6)
		end
	end

	for slot5, slot6 in ipairs(slot1) do
		if slot6.spine then
			slot0:_setSpineEffect(slot6.spine)
		end
	end
end

function slot0._setSpineEffect(slot0, slot1)
	slot2 = slot1.unitSpawn
	slot3 = slot2.id

	if not slot2:getMO() then
		return
	end

	if not FightConfig.instance:getSkinCO(slot4.skin) or slot5.isFly == 1 then
		return
	end

	if slot0._side and slot0._side ~= slot2:getSide() then
		return
	end

	if not slot0._effects then
		slot0._effects = {}
		slot0._originPos = {}
		slot0._standPos = {}
		slot0._effects2 = {}
	end

	if slot0._effects[slot3] then
		return
	end

	if slot2:getHangPoint(ModuleEnum.SpineHangPoint.mountbody) then
		slot7 = slot2.effect:addHangEffect(slot0._effectUrl, ModuleEnum.SpineHangPointRoot)
		slot0._effects[slot3] = slot7

		slot0._effects[slot3]:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(slot3, slot7)

		slot8, slot9, slot10 = FightHelper.getEntityStandPos(slot4)
		slot11, slot12, slot13 = transformhelper.getLocalPos(slot6.transform)
		slot0._originPos[slot3] = {
			slot8 + slot11,
			slot9 + slot12,
			slot10 + slot13
		}
		slot0._standPos[slot3] = {
			slot8,
			slot9,
			slot10
		}
		slot7 = slot2.effect:addGlobalEffect(slot0._effectUrl .. "_effect")

		slot7:setLocalPos(slot11 + slot8, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(slot3, slot7)

		slot0._effects2[slot3] = slot7
	end
end

slot1 = "_RolePos"

function slot0._onFrameUpdateEffectPos(slot0)
	if slot0._effects then
		for slot4, slot5 in pairs(slot0._effects) do
			if FightHelper.getEntity(slot4) then
				slot8, slot9, slot10 = transformhelper.getLocalPos(slot6.go.transform)

				if (slot8 ~= slot0._standPos[slot4][1] or slot9 ~= slot7[2] or slot10 ~= slot7[3]) and gohelper.findChildComponent(slot5.effectGO, "root/wave", typeof(UnityEngine.MeshRenderer)) and slot12.material then
					slot15, slot16, slot17 = transformhelper.getPos(FightHelper.getEntity(slot4):getHangPoint(ModuleEnum.SpineHangPoint.mountbody).transform)
					slot18 = slot0._originPos[slot4]

					MaterialUtil.setPropValue(slot12.material, uv0, "Vector4", MaterialUtil.getPropValueFromStr("Vector4", string.format("%f,%f,%f,0", slot15 - slot18[1], slot16 - slot18[2], slot17 - slot18[3])))

					if slot15 < 0 and slot20 < 1 then
						slot0._effects2[slot4]:setLocalPos(slot15, 0, slot17)
					end
				end
			end
		end
	end
end

slot2 = {
	[FightEnum.EffectType.MISS] = true,
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.SHIELD] = true,
	[FightEnum.EffectType.SHIELDDEL] = true
}

function slot0._onSkillPlayStart(slot0, slot1, slot2, slot3)
	slot4 = {
		[slot3.fromId] = true,
		[slot3.toId] = true,
		[slot9.targetId] = true
	}

	for slot8, slot9 in ipairs(slot3.actEffectMOs) do
		if uv0[slot9.effectType] then
			-- Nothing
		end
	end

	if slot0._effects2 then
		for slot8, slot9 in pairs(slot0._effects2) do
			if not slot4[slot8] then
				slot9:setActive(false, "FightSceneWadingEffect")
			end
		end
	end
end

function slot0._onSkillPlayFinish(slot0)
	if slot0._effects2 then
		for slot4, slot5 in pairs(slot0._effects2) do
			slot5:setActive(true, "FightSceneWadingEffect")
		end
	end
end

function slot0._onSetEntityAlpha(slot0, slot1, slot2)
	if slot0._effects2 and slot0._effects2[slot1] then
		slot0._effects2[slot1]:setActive(slot2, "_onSetEntityAlpha")
	end
end

function slot0._releaseEntityEffect(slot0, slot1)
	if slot0._effects and slot0._effects[slot1] then
		if FightHelper.getEntity(slot1) and slot3.effect then
			slot3.effect:removeEffect(slot2)
			slot3.effect:removeEffect(slot0._effects2[slot1])
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(slot1, slot2)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(slot1, slot0._effects2[slot1])

		slot0._effects[slot1] = nil
		slot0._effects2[slot1] = nil
	end
end

function slot0._releaseAllEntityEffect(slot0)
	if slot0._effects then
		for slot4, slot5 in pairs(slot0._effects) do
			slot0:_releaseEntityEffect(slot4)
		end
	end
end

function slot0._releaseEffect(slot0)
	TaskDispatcher.cancelTask(slot0._onFrameUpdateEffectPos, slot0)
	slot0:_releaseAllEntityEffect()

	slot0._effects = nil
	slot0._originPos = nil
	slot0._standPos = nil
	slot0._effectUrl = nil
end

return slot0
