module("modules.logic.scene.cachot.comp.CachotSceneDirector", package.seeall)

slot0 = class("CachotSceneDirector", BaseSceneComp)

function slot0.onInit(slot0)
	slot0._scene = slot0:getCurScene()
end

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()
	slot0._compInitSequence = FlowSequence.New()

	slot0._compInitSequence:addWork(RoomSceneWaitEventCompWork.New(slot0._scene.preloader, V1a6_CachotEvent.ScenePreloaded))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.player))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.event))
	slot0._compInitSequence:registerDoneListener(slot0._compInitDone, slot0)
	slot0._compInitSequence:start({
		sceneId = slot1,
		levelId = slot2
	})
end

function slot0._compInitDone(slot0)
	slot0._scene:onPrepared()

	slot0._compInitSequence = nil
end

function slot0.onSceneClose(slot0)
	if slot0._compInitSequence then
		slot0._compInitSequence:onDestroy()

		slot0._compInitSequence = nil
	end
end

return slot0
