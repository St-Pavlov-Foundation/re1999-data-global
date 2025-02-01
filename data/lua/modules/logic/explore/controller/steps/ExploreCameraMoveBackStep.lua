module("modules.logic.explore.controller.steps.ExploreCameraMoveBackStep", package.seeall)

slot0 = class("ExploreCameraMoveBackStep", ExploreStepBase)

function slot0.onStart(slot0)
	slot0._data.toPos = ExploreMapTriggerController.instance:getMap():getHero():getPos()

	if slot0._data.keepTime and slot0._data.keepTime > 0 then
		TaskDispatcher.runDelay(slot0.beginTween, slot0, slot0._data.keepTime)
	else
		slot0:beginTween()
	end
end

function slot0.beginTween(slot0)
	if slot0._data.moveTime then
		slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, slot0._data.moveTime, slot0.moveBack, slot0.moveBackDone, slot0)
	else
		ViewMgr.instance:openView(ViewName.ExploreBlackView)
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	end
end

function slot0.onOpenViewFinish(slot0, slot1)
	if ViewName.ExploreBlackView ~= slot1 then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, slot0._data.toPos)
	TaskDispatcher.runDelay(slot0._delayLoadObj, slot0, 0.1)
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, slot0.onBlackEnd, slot0)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function slot0._delayLoadObj(slot0)
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, slot0.onBlackEnd, slot0)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function slot0.onBlackEnd(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.ExploreBlackView then
		slot0:onDone()
	end
end

function slot0.moveBack(slot0, slot1)
	slot2 = slot0._data.fromPos - slot0._data.offPos * slot1

	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, slot2)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, slot2)
end

function slot0.moveBackDone(slot0)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, slot0._data.toPos)
	slot0:onDone()
end

function slot0.onDestory(slot0)
	uv0.super.onDestory(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.MoveCamera)
	TaskDispatcher.cancelTask(slot0.beginTween, slot0)
	TaskDispatcher.cancelTask(slot0._delayLoadObj, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, slot0.onBlackEnd, slot0)

	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end
end

return slot0
