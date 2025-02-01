module("modules.logic.scene.explore.comp.ExploreSceneDirector", package.seeall)

slot0 = class("ExploreSceneDirector", BaseSceneComp)

function slot0.onInit(slot0)
	slot0._scene = slot0:getCurScene()
end

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()
	slot0._compInitSequence = FlowSequence.New()
	slot3 = FlowParallel.New()

	slot0._compInitSequence:addWork(slot3)
	slot3:addWork(RoomSceneWaitEventCompWork.New(slot0._scene.map, ExploreEvent.InitMapDone))
	slot3:addWork(RoomSceneWaitEventCompWork.New(slot0._scene.level, CommonSceneLevelComp.OnLevelLoaded))
	slot3:addWork(RoomSceneWaitEventCompWork.New(slot0._scene.preloader, ExploreEvent.OnExplorePreloadFinish))
	slot0._compInitSequence:registerDoneListener(slot0._compInitDone, slot0)
	slot0._compInitSequence:start({
		sceneId = slot1,
		levelId = slot2
	})
end

function slot0._compInitDone(slot0)
	slot0._scene:onPrepared()
end

function slot0.onSceneClose(slot0)
end

function slot0._onLevelLoaded(slot0, slot1)
end

return slot0
