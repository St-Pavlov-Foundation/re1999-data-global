module("modules.logic.explore.controller.steps.ExploreCameraMoveStep", package.seeall)

local var_0_0 = class("ExploreCameraMoveStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data.id

	arg_1_0.moveTime = arg_1_0._data.moveTime
	arg_1_0.keepTime = arg_1_0._data.keepTime

	local var_1_1 = ExploreMapTriggerController.instance:getMap()
	local var_1_2 = var_1_1:getUnit(var_1_0)

	if var_1_2 then
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.MoveCamera)

		local var_1_3 = var_1_1:getHero()

		arg_1_0.tarPos = var_1_2:getPos()
		arg_1_0.startPos = var_1_3:getPos()
		arg_1_0.offPos = arg_1_0.tarPos - arg_1_0.startPos

		local var_1_4 = {
			alwaysLast = true,
			stepType = ExploreEnum.StepType.CameraMoveBack,
			keepTime = arg_1_0.keepTime
		}

		if arg_1_0.offPos.sqrMagnitude > 100 then
			ViewMgr.instance:openView(ViewName.ExploreBlackView)
			ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0.onOpenViewFinish, arg_1_0)
		else
			var_1_4.fromPos = arg_1_0.tarPos
			var_1_4.offPos = arg_1_0.offPos
			var_1_4.moveTime = arg_1_0.moveTime
			arg_1_0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, arg_1_0.moveTime, arg_1_0.moveToTar, arg_1_0.moveToTarDone, arg_1_0)
		end

		ExploreStepController.instance:insertClientStep(var_1_4)
	else
		logError("Explore not find unit:" .. var_1_0)
		arg_1_0:onDone()
	end
end

function var_0_0.moveToTar(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.startPos + arg_2_0.offPos * arg_2_1

	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, var_2_0)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, var_2_0)
end

function var_0_0.moveToTarDone(arg_3_0)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, arg_3_0.tarPos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, arg_3_0.tarPos)
	arg_3_0:onDone()
end

function var_0_0.startMoveBack(arg_4_0)
	arg_4_0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, arg_4_0.moveTime, arg_4_0.moveBack, arg_4_0.moveBackDone, arg_4_0)
end

function var_0_0.onOpenViewFinish(arg_5_0, arg_5_1)
	if arg_5_1 ~= ViewName.ExploreBlackView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_5_0.onOpenViewFinish, arg_5_0)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, arg_5_0.tarPos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, arg_5_0.tarPos)
	TaskDispatcher.runDelay(arg_5_0._delayLoadObj, arg_5_0, 0.1)
end

function var_0_0._delayLoadObj(arg_6_0)
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, arg_6_0.onBlackEnd, arg_6_0)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function var_0_0.onBlackEnd(arg_7_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_7_0._onCloseViewFinish, arg_7_0)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
end

function var_0_0._onCloseViewFinish(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.ExploreBlackView then
		arg_8_0:onDone()
	end
end

function var_0_0.onDestory(arg_9_0)
	var_0_0.super.onDestory(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._delayLoadObj, arg_9_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_9_0._onCloseViewFinish, arg_9_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, arg_9_0.onBlackEnd, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.startMoveBack, arg_9_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_9_0.onOpenViewFinish, arg_9_0)

	if arg_9_0.tweenId then
		ZProj.TweenHelper.KillById(arg_9_0.tweenId)

		arg_9_0.tweenId = nil
	end
end

return var_0_0
