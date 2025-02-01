module("modules.logic.scene.fight.comp.FightSceneCtrl02", package.seeall)

slot0 = class("FightSceneCtrl02", BaseSceneComp)

function slot0.onInit(slot0)
	slot0:getCurScene().level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
end

function slot0._onLevelLoaded(slot0, slot1)
	slot0._sceneCtrl02Comp = nil

	if slot0:getCurScene():getSceneContainerGO():GetComponentsInChildren(typeof(ZProj.SceneCtrl02)).Length > 0 then
		slot0._sceneCtrl02Comp = slot3[0]
		slot0._deadIdDict = {}

		FightController.instance:registerCallback(FightEvent.BeforePlayUniqueSkill, slot0._beforePlayUniqueSkill, slot0)
		FightController.instance:registerCallback(FightEvent.AfterPlayUniqueSkill, slot0._afterPlayUniqueSkill, slot0)
		FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, slot0._beforeDeadEffect, slot0)
		FightController.instance:registerCallback(FightEvent.OnSpineMaterialChange, slot0._onSpineMaterialChange, slot0)
		FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
		FightController.instance:registerCallback(FightEvent.BeforeEntityDestroy, slot0._beforeEntityDestroy, slot0)
		FightController.instance:registerCallback(FightEvent.PushEndFight, slot0._onEndFight, slot0)
		slot0:_setAllSpineMat()
	else
		FightController.instance:unregisterCallback(FightEvent.BeforePlayUniqueSkill, slot0._beforePlayUniqueSkill, slot0)
		FightController.instance:unregisterCallback(FightEvent.AfterPlayUniqueSkill, slot0._afterPlayUniqueSkill, slot0)
		FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, slot0._beforeDeadEffect, slot0)
		FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, slot0._onSpineMaterialChange, slot0)
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
		FightController.instance:unregisterCallback(FightEvent.BeforeEntityDestroy, slot0._beforeEntityDestroy, slot0)
		FightController.instance:unregisterCallback(FightEvent.PushEndFight, slot0._onEndFight, slot0)
	end
end

function slot0._setAllSpineMat(slot0)
	if slot0._sceneCtrl02Comp then
		for slot5, slot6 in ipairs(FightHelper.getAllEntitysContainUnitNpc()) do
			if slot6.spineRenderer then
				slot0._sceneCtrl02Comp:SetSpineMat(tostring(slot6.id), slot6.spineRenderer:getReplaceMat())
			end
		end
	end
end

function slot0._onSpineLoaded(slot0, slot1)
	if slot0._sceneCtrl02Comp then
		slot2 = slot1.unitSpawn

		if slot2.spineRenderer then
			slot0._sceneCtrl02Comp:SetSpineMat(tostring(slot2.id), slot2.spineRenderer:getReplaceMat())
		end
	end
end

function slot0._beforeEntityDestroy(slot0, slot1)
	if slot0._sceneCtrl02Comp and slot1 and slot1.spineRenderer then
		slot0._sceneCtrl02Comp:SetSpineMat(tostring(slot1.id), nil)
	end
end

function slot0._onSpineMaterialChange(slot0, slot1, slot2)
	if slot0._sceneCtrl02Comp and not slot0._deadIdDict[slot1] then
		slot0._sceneCtrl02Comp:SetSpineMat(tostring(slot1), slot2)
	end
end

function slot0._beforeDeadEffect(slot0, slot1)
	slot0._deadIdDict[slot1] = true

	slot0._sceneCtrl02Comp:SetSpineMat(tostring(slot1), nil)
end

function slot0._beforePlayUniqueSkill(slot0, slot1)
	if slot0._sceneCtrl02Comp then
		slot0._sceneCtrl02Comp.enabled = false
	end
end

function slot0._afterPlayUniqueSkill(slot0, slot1)
	if slot0._sceneCtrl02Comp then
		slot0._sceneCtrl02Comp.enabled = true
	end
end

function slot0._onEndFight(slot0)
	if slot0._sceneCtrl02Comp then
		slot0._sceneCtrl02Comp.enabled = false
	end
end

function slot0.onSceneClose(slot0)
	slot0._sceneCtrl02Comp = nil

	FightController.instance:unregisterCallback(FightEvent.BeforePlayUniqueSkill, slot0._beforePlayUniqueSkill, slot0)
	FightController.instance:unregisterCallback(FightEvent.AfterPlayUniqueSkill, slot0._afterPlayUniqueSkill, slot0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, slot0._beforeDeadEffect, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, slot0._onSpineMaterialChange, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	FightController.instance:unregisterCallback(FightEvent.BeforeEntityDestroy, slot0._beforeEntityDestroy, slot0)
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, slot0._onEndFight, slot0)
end

return slot0
