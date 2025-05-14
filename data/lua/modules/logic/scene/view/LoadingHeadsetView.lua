module("modules.logic.scene.view.LoadingHeadsetView", package.seeall)

local var_0_0 = class("LoadingHeadsetView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._onShowFinished, arg_6_0, 4.5)
	TaskDispatcher.runDelay(arg_6_0.closeThis, arg_6_0, 4.667)
end

function var_0_0._onShowFinished(arg_7_0)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitCloseHeadsetView)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._onShowFinished, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.closeThis, arg_9_0)
end

return var_0_0
