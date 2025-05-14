module("modules.logic.scene.summon.comp.SummonSceneViewComp", package.seeall)

local var_0_0 = class("SummonSceneViewComp", BaseSceneComp)

function var_0_0.openView(arg_1_0)
	arg_1_0._param = SummonController.instance.summonViewParam
	arg_1_0._viewOpenFromEnterScene = false

	arg_1_0:startOpenMainView()
end

function var_0_0.needWaitForViewOpen(arg_2_0)
	return not SummonController.instance:isInSummonGuide()
end

function var_0_0.startOpenMainView(arg_3_0)
	if arg_3_0:needWaitForViewOpen() then
		if not ViewMgr.instance:isOpen(ViewName.SummonADView) then
			ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_3_0.onViewOpened, arg_3_0)

			arg_3_0._viewOpenFromEnterScene = true

			SummonMainController.instance:openSummonView(arg_3_0._param, true)
		else
			TaskDispatcher.runDelay(arg_3_0.delayDispatchOpenViewFinish, arg_3_0, 0.001)
		end
	else
		TaskDispatcher.runDelay(arg_3_0.delayDispatchOpenViewFinish, arg_3_0, 0.001)
	end
end

function var_0_0.delayDispatchOpenViewFinish(arg_4_0)
	arg_4_0:dispatchEvent(SummonSceneEvent.OnViewFinish)
end

function var_0_0.onViewOpened(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.SummonADView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_5_0.onViewOpened, arg_5_0)
		arg_5_0:dispatchEvent(SummonSceneEvent.OnViewFinish)
	end
end

function var_0_0.onScenePrepared(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._viewOpenFromEnterScene then
		-- block empty
	end
end

function var_0_0.onSceneClose(arg_7_0)
	arg_7_0._viewOpenFromEnterScene = false

	TaskDispatcher.cancelTask(arg_7_0.delayDispatchOpenViewFinish, arg_7_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_7_0.onViewOpened, arg_7_0)
	ViewMgr.instance:closeView(ViewName.SummonView)

	if SummonController.instance:isInSummonGuide() then
		ViewMgr.instance:closeView(ViewName.SummonADView)
	end
end

function var_0_0.onSceneHide(arg_8_0)
	arg_8_0:onSceneClose()
end

return var_0_0
