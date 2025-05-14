module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreTweenCamera", package.seeall)

local var_0_0 = class("WaitGuideActionExploreTweenCamera", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.MoveCamera)

	local var_1_0 = ExploreController.instance:getMap()

	if not var_1_0 then
		logError("不在密室中？？？")
		arg_1_0:onDone(true)
	else
		local var_1_1 = string.split(arg_1_0.actionParam, "#")
		local var_1_2
		local var_1_3

		if var_1_1[1] == "POS" then
			local var_1_4 = tonumber(var_1_1[2]) or 0
			local var_1_5 = tonumber(var_1_1[3]) or 0

			var_1_3 = tonumber(var_1_1[4]) or 0

			local var_1_6 = ExploreMapModel.instance:getNode(ExploreHelper.getKeyXY(var_1_4, var_1_5))
			local var_1_7 = 0

			if var_1_6 then
				var_1_7 = var_1_6.rawHeight
			end

			var_1_2 = Vector3.New(var_1_4 + 0.5, var_1_7, var_1_5 + 0.5)
		elseif var_1_1[1] == "ID" then
			local var_1_8 = var_1_0:getUnit(tonumber(var_1_1[2]))

			if var_1_8 then
				var_1_2 = var_1_8:getPos()
			end

			var_1_3 = tonumber(var_1_1[3]) or 0
		elseif var_1_1[1] == "HERO" then
			local var_1_9 = var_1_0:getHero()

			if var_1_9 then
				var_1_2 = var_1_9:getPos()
			end

			var_1_3 = tonumber(var_1_1[2]) or 0

			ExploreController.instance:registerCallback(ExploreEvent.OnCharacterPosChange, arg_1_0.onHeroPosChange, arg_1_0)
		else
			logError("暂不支持相机移动类型")
		end

		if not var_1_2 then
			arg_1_0:onDone(true)
		else
			arg_1_0._movePos = var_1_2
			arg_1_0._moveTime = var_1_3

			if var_1_3 > 0 then
				GuideBlockMgr.instance:startBlock(var_1_3)
			end

			arg_1_0:_beginMove()
		end
	end
end

function var_0_0.onHeroPosChange(arg_2_0, arg_2_1)
	arg_2_0._movePos = arg_2_1
	arg_2_0._offPos = arg_2_0._movePos - arg_2_0._beginPos
end

function var_0_0._beginMove(arg_3_0)
	arg_3_0._beginPos = CameraMgr.instance:getFocusTrs().position
	arg_3_0._offPos = arg_3_0._movePos - arg_3_0._beginPos

	if arg_3_0._offPos.sqrMagnitude > 100 then
		ViewMgr.instance:openView(ViewName.ExploreBlackView)
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_3_0.onOpenViewFinish, arg_3_0)
	else
		arg_3_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, arg_3_0._moveTime, arg_3_0._moveToTar, arg_3_0._moveToTarDone, arg_3_0)
	end
end

function var_0_0._moveToTar(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._beginPos + arg_4_0._offPos * arg_4_1

	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, var_4_0)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, var_4_0)
end

function var_0_0._moveToTarDone(arg_5_0)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, arg_5_0._movePos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, arg_5_0._movePos)
	arg_5_0:onDone(true)
end

function var_0_0.onOpenViewFinish(arg_6_0, arg_6_1)
	if arg_6_1 ~= ViewName.ExploreBlackView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_6_0.onOpenViewFinish, arg_6_0)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, arg_6_0._movePos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, arg_6_0._movePos)
	TaskDispatcher.runDelay(arg_6_0._delayLoadObj, arg_6_0, 0.1)
end

function var_0_0._delayLoadObj(arg_7_0)
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, arg_7_0._onBlackEnd, arg_7_0)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function var_0_0._onBlackEnd(arg_8_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_8_0._onCloseViewFinish, arg_8_0)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
end

function var_0_0._onCloseViewFinish(arg_9_0, arg_9_1)
	if arg_9_1 == ViewName.ExploreBlackView then
		arg_9_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_10_0)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos)
	TaskDispatcher.cancelTask(arg_10_0._delayLoadObj, arg_10_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_10_0._onCloseViewFinish, arg_10_0)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.MoveCamera)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterPosChange, arg_10_0.onHeroPosChange, arg_10_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, arg_10_0._onBlackEnd, arg_10_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_10_0.onOpenViewFinish, arg_10_0)

	if arg_10_0._tweenId then
		ZProj.TweenHelper.KillById(arg_10_0._tweenId)

		arg_10_0._tweenId = nil
	end
end

return var_0_0
