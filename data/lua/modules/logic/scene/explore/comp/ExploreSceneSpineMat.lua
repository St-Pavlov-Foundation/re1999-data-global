module("modules.logic.scene.explore.comp.ExploreSceneSpineMat", package.seeall)

slot0 = class("ExploreSceneSpineMat", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0:_setLevelCO(slot2)
	ExploreController.instance:registerCallback(ExploreEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
end

function slot0.onScenePrepared(slot0, slot1, slot2)
end

function slot0.onSceneClose(slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)

	slot0._spineColor = nil
end

function slot0._onSpineLoaded(slot0, slot1)
	if slot0._spineColor and slot1 then
		MaterialUtil.setMainColor(slot1.unitSpawn.spineRenderer:getReplaceMat(), slot0._spineColor)
	end
end

function slot0._setLevelCO(slot0, slot1)
	slot0._spineColor = nil

	if lua_scene_level.configDict[slot1].spineR ~= 0 or slot2.spineG ~= 0 or slot2.spineB ~= 0 then
		slot0._spineColor = Color.New(slot2.spineR, slot2.spineG, slot2.spineB, 1)
	end
end

return slot0
