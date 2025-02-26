module("modules.logic.scene.explore.comp.ExploreSceneMap", package.seeall)

slot0 = class("ExploreSceneMap", BaseSceneComp)

function slot0.onInit(slot0)
	slot0._scene = slot0:getCurScene()
end

function slot0.init(slot0, slot1, slot2)
end

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._scene.level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
end

function slot0._onLevelLoaded(slot0, slot1, slot2)
	slot6 = slot0.initMapDone
	slot7 = slot0

	ExploreController.instance:registerCallback(ExploreEvent.InitMapDone, slot6, slot7)

	slot0._comps = {}

	for slot6, slot7 in pairs(ExploreEnum.MapCompType) do
		if slot6 ~= "Map" then
			slot8 = "ExploreMap" .. slot6
		end

		slot0._comps[slot7] = _G[slot8].New()

		ExploreController.instance:registerMapComp(slot7, slot0._comps[slot7])
	end

	for slot6, slot7 in pairs(slot0._comps) do
		if slot7.loadMap then
			slot7:loadMap()
		end
	end
end

function slot0.initMapDone(slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.InitMapDone, slot0.initMapDone, slot0)
	slot0:dispatchEvent(ExploreEvent.InitMapDone)
end

function slot0.onSceneClose(slot0, slot1, slot2)
	slot0._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)

	slot6 = slot0.initMapDone
	slot7 = slot0

	ExploreController.instance:unregisterCallback(ExploreEvent.InitMapDone, slot6, slot7)

	for slot6, slot7 in pairs(slot0._comps) do
		if slot7.unloadMap then
			slot7:unloadMap()
		end
	end

	ExploreStepController.instance:clear()

	for slot6 in pairs(slot0._comps) do
		ExploreController.instance:unRegisterMapComp(slot6)
	end

	slot0._comps = {}
end

return slot0
