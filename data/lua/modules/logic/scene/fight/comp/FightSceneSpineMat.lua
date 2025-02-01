module("modules.logic.scene.fight.comp.FightSceneSpineMat", package.seeall)

slot0 = class("FightSceneSpineMat", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0:_setLevelCO(slot2)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
end

function slot0.onScenePrepared(slot0, slot1, slot2)
	slot0:getCurScene().level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
	slot0:_setAllSpineColor()
end

function slot0.onSceneClose(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	slot0:getCurScene().level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)

	slot0._spineColor = nil
end

function slot0._onSpineLoaded(slot0, slot1)
	if slot0._spineColor and slot1 then
		MaterialUtil.setMainColor(slot1.unitSpawn.spineRenderer:getReplaceMat(), slot0._spineColor)
	end
end

function slot0._onLevelLoaded(slot0, slot1)
	slot0:_setLevelCO(slot1)
	slot0:_setAllSpineColor()
end

function slot0._setLevelCO(slot0, slot1)
	slot0._spineColor = nil

	if lua_scene_level.configDict[slot1].spineR ~= 0 or slot2.spineG ~= 0 or slot2.spineB ~= 0 then
		slot0._spineColor = Color.New(slot2.spineR, slot2.spineG, slot2.spineB, 1)
	end
end

function slot0._setAllSpineColor(slot0)
	if not slot0._spineColor then
		return
	end

	for slot5, slot6 in ipairs(FightHelper.getAllEntitysContainUnitNpc()) do
		if slot6.spineRenderer then
			MaterialUtil.setMainColor(slot6.spineRenderer:getReplaceMat(), slot0._spineColor)
		end
	end
end

return slot0
