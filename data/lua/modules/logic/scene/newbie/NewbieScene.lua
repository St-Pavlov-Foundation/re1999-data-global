module("modules.logic.scene.newbie.NewbieScene", package.seeall)

local var_0_0 = class("NewbieScene", BaseScene)

function var_0_0._createAllComps(arg_1_0)
	return
end

function var_0_0.onClose(arg_2_0)
	var_0_0.super.onClose(arg_2_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_2_0._onOpenFinish, arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._resetScenePos, arg_2_0)
	arg_2_0:_removeEvents()
end

function var_0_0.onPrepared(arg_3_0)
	var_0_0.super.onPrepared(arg_3_0)

	if arg_3_0.level then
		local var_3_0 = arg_3_0.level:getSceneGo()

		if gohelper.isNil(var_3_0) then
			return
		end

		arg_3_0:_moveScene(0.5)

		if ViewMgr.instance:isOpenFinish(ViewName.StoryView) then
			arg_3_0:_onOpenFinish(ViewName.StoryView)

			return
		end

		arg_3_0:_addEvents()
	end
end

function var_0_0._addEvents(arg_4_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_4_0._onOpenFinish, arg_4_0)
	MainController.instance:registerCallback(MainEvent.GuideSetDelayTime, arg_4_0._onGuideSetDelayTime, arg_4_0)
end

function var_0_0._removeEvents(arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_5_0._onOpenFinish, arg_5_0)
	MainController.instance:unregisterCallback(MainEvent.GuideSetDelayTime, arg_5_0._onGuideSetDelayTime, arg_5_0)
end

function var_0_0._onGuideSetDelayTime(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.level:getSceneGo()

	if gohelper.isNil(var_6_0) then
		return
	end

	arg_6_0:_moveScene(arg_6_1)
	TaskDispatcher.runDelay(arg_6_0._resetScenePos, arg_6_0, 2)
end

function var_0_0._moveScene(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.level:getSceneGo()

	if gohelper.isNil(var_7_0) then
		return
	end

	transformhelper.setLocalPosXY(var_7_0.transform, 0, 100)

	arg_7_0._delayTime = tonumber(arg_7_1)
end

function var_0_0._onOpenFinish(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.StoryView and arg_8_0._delayTime then
		TaskDispatcher.cancelTask(arg_8_0._resetScenePos, arg_8_0)
		TaskDispatcher.runDelay(arg_8_0._resetScenePos, arg_8_0, arg_8_0._delayTime)

		arg_8_0._delayTime = nil
	end
end

function var_0_0._resetScenePos(arg_9_0)
	local var_9_0 = arg_9_0.level:getSceneGo()

	if gohelper.isNil(var_9_0) then
		return
	end

	transformhelper.setLocalPosXY(var_9_0.transform, 0, 0)
end

function var_0_0.onStart(arg_10_0, arg_10_1, arg_10_2)
	if not DungeonModel.instance:hasPassLevel(10003) then
		arg_10_0:onPrepared()
	else
		if not arg_10_0._isAddComps then
			arg_10_0._isAddComps = true

			arg_10_0:_addComp("level", NewbieSceneLevelComp)
			arg_10_0:_addComp("camera", CommonSceneCameraComp)
			arg_10_0:_addComp("yearAnimation", MainSceneYearAnimationComp)

			for iter_10_0, iter_10_1 in ipairs(arg_10_0._allComps) do
				if iter_10_1.onInit then
					iter_10_1:onInit()
				end
			end

			arg_10_0.yearAnimation.forcePlayAnimation = true
		end

		arg_10_2 = 10101

		var_0_0.super.onStart(arg_10_0, arg_10_1, arg_10_2)
	end
end

return var_0_0
