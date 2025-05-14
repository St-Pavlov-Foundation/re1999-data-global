module("modules.logic.explore.controller.steps.ExploreCameraMoveBackStep", package.seeall)

local var_0_0 = class("ExploreCameraMoveBackStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0._data.toPos = ExploreMapTriggerController.instance:getMap():getHero():getPos()

	if arg_1_0._data.keepTime and arg_1_0._data.keepTime > 0 then
		TaskDispatcher.runDelay(arg_1_0.beginTween, arg_1_0, arg_1_0._data.keepTime)
	else
		arg_1_0:beginTween()
	end
end

function var_0_0.beginTween(arg_2_0)
	if arg_2_0._data.moveTime then
		arg_2_0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, arg_2_0._data.moveTime, arg_2_0.moveBack, arg_2_0.moveBackDone, arg_2_0)
	else
		ViewMgr.instance:openView(ViewName.ExploreBlackView)
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_2_0.onOpenViewFinish, arg_2_0)
	end
end

function var_0_0.onOpenViewFinish(arg_3_0, arg_3_1)
	if ViewName.ExploreBlackView ~= arg_3_1 then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_3_0.onOpenViewFinish, arg_3_0)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, arg_3_0._data.toPos)
	TaskDispatcher.runDelay(arg_3_0._delayLoadObj, arg_3_0, 0.1)
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, arg_3_0.onBlackEnd, arg_3_0)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function var_0_0._delayLoadObj(arg_4_0)
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, arg_4_0.onBlackEnd, arg_4_0)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function var_0_0.onBlackEnd(arg_5_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_5_0._onCloseViewFinish, arg_5_0)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
end

function var_0_0._onCloseViewFinish(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.ExploreBlackView then
		arg_6_0:onDone()
	end
end

function var_0_0.moveBack(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._data.fromPos - arg_7_0._data.offPos * arg_7_1

	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, var_7_0)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, var_7_0)
end

function var_0_0.moveBackDone(arg_8_0)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, arg_8_0._data.toPos)
	arg_8_0:onDone()
end

function var_0_0.onDestory(arg_9_0)
	var_0_0.super.onDestory(arg_9_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_9_0._onCloseViewFinish, arg_9_0)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.MoveCamera)
	TaskDispatcher.cancelTask(arg_9_0.beginTween, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._delayLoadObj, arg_9_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_9_0.onOpenViewFinish, arg_9_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, arg_9_0.onBlackEnd, arg_9_0)

	if arg_9_0.tweenId then
		ZProj.TweenHelper.KillById(arg_9_0.tweenId)

		arg_9_0.tweenId = nil
	end
end

return var_0_0
