module("modules.logic.weather.eggs.SceneEggPreviewSceneTransition", package.seeall)

local var_0_0 = class("SceneEggPreviewSceneTransition", SceneBaseEgg)

function var_0_0._onEnable(arg_1_0)
	if arg_1_0._context.isMainScene then
		return
	end

	arg_1_0:_showEffect()
end

function var_0_0._onDisable(arg_2_0)
	if arg_2_0._context.isMainScene then
		return
	end

	arg_2_0:_delayHideGoList()
end

function var_0_0._showEffect(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._delayHideGoList, arg_3_0)
	TaskDispatcher.runDelay(arg_3_0._delayHideGoList, arg_3_0, 2)
	arg_3_0:setGoListVisible(true)
	PostProcessingMgr.instance:setUnitPPValue("sceneMaskTexDownTimes", 0)
	MainSceneSwitchCameraController.instance:setUnitPPValue("sceneMaskTexDownTimes", 0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_3_0._onOpenViewFinish, arg_3_0, LuaEventSystem.High)
end

function var_0_0._onOpenViewFinish(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.MainSceneSkinMaterialTipView then
		TaskDispatcher.cancelTask(arg_4_0._delayHideGoList, arg_4_0)
		arg_4_0:_delayHideGoList()
	end
end

function var_0_0._delayHideGoList(arg_5_0)
	arg_5_0:setGoListVisible(false)
	PostProcessingMgr.instance:setUnitPPValue("sceneMaskTexDownTimes", 1)
	MainSceneSwitchCameraController.instance:setUnitPPValue("sceneMaskTexDownTimes", 1)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_5_0._onOpenViewFinish, arg_5_0)
end

function var_0_0._onInit(arg_6_0)
	if arg_6_0._context.isMainScene then
		return
	end

	arg_6_0:_showEffect()
end

function var_0_0._onSceneClose(arg_7_0)
	if arg_7_0._context.isMainScene then
		return
	end

	TaskDispatcher.cancelTask(arg_7_0._delayHideGoList, arg_7_0)
	arg_7_0:_delayHideGoList()
end

return var_0_0
