module("modules.logic.guide.controller.action.impl.WaitGuideActionOpenDungeonMapView", package.seeall)

local var_0_0 = class("WaitGuideActionOpenDungeonMapView", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._viewName = ViewName.DungeonMapView

	if not ViewMgr.instance:isOpen(arg_1_0._viewName) then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = ViewMgr.instance:getContainer(arg_1_0._viewName):getMapScene()
	local var_1_1 = var_1_0 and var_1_0:getSceneGo()

	if not gohelper.isNil(var_1_1) then
		arg_1_0:onDone(true)

		return
	end

	DungeonController.instance:registerCallback(DungeonEvent.OnShowMap, arg_1_0._onShowMap, arg_1_0)

	local var_1_2 = 2

	TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, var_1_2)
end

function var_0_0._onShowMap(arg_2_0)
	arg_2_0:clearWork()
	arg_2_0:onDone(true)
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:clearWork()
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnShowMap, arg_4_0._onShowMap, arg_4_0)
end

return var_0_0
