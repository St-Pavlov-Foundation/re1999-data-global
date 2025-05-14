module("modules.logic.guide.controller.action.impl.WaitGuideActionAnyTouch", package.seeall)

local var_0_0 = class("WaitGuideActionAnyTouch", BaseGuideAction)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_0, arg_2_1)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, arg_2_0._onTouchScreen, arg_2_0)
end

function var_0_0.clearWork(arg_3_0)
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, arg_3_0._onTouchScreen, arg_3_0)
end

function var_0_0._onTouchScreen(arg_4_0)
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, arg_4_0._onTouchScreen, arg_4_0)
	TaskDispatcher.runDelay(function()
		arg_4_0:onDone(true)
	end, nil, 0.1)
end

return var_0_0
