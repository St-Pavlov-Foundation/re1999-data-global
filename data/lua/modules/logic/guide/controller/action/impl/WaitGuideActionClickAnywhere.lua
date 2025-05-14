module("modules.logic.guide.controller.action.impl.WaitGuideActionClickAnywhere", package.seeall)

local var_0_0 = class("WaitGuideActionClickAnywhere", BaseGuideAction)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_0, arg_2_1)
	GuideViewMgr.instance:setHoleClickCallback(arg_2_0._onClickTarget, arg_2_0)
	GuideViewMgr.instance:enableSpaceBtn(true)
end

function var_0_0.clearWork(arg_3_0)
	GuideViewMgr.instance:setHoleClickCallback(nil, nil)
	GuideViewMgr.instance:enableSpaceBtn(false)
	TaskDispatcher.cancelTask(arg_3_0._delayCheckPressingState, arg_3_0)
end

function var_0_0._onClickTarget(arg_4_0, arg_4_1)
	arg_4_0:onDone(true)
end

return var_0_0
