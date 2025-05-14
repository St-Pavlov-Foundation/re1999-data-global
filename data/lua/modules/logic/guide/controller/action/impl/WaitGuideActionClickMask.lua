module("modules.logic.guide.controller.action.impl.WaitGuideActionClickMask", package.seeall)

local var_0_0 = class("WaitGuideActionClickMask", BaseGuideAction)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	local var_1_0 = string.split(arg_1_3, "#")

	arg_1_0._beforeClickWaitSecond = #var_1_0 >= 1 and tonumber(var_1_0[1]) or 0
	arg_1_0._afterClickWaitSecond = #var_1_0 >= 2 and tonumber(var_1_0[2]) or 0
	arg_1_0._isForceGuide = GuideConfig.instance:getStepCO(arg_1_1, arg_1_2).notForce == 0
	arg_1_0._alpha = nil

	if #var_1_0 >= 3 then
		arg_1_0._alpha = tonumber(var_1_0[3])
	end

	arg_1_0._goPath = GuideModel.instance:getStepGOPath(arg_1_1, arg_1_2)
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_0, arg_2_1)

	if arg_2_0._beforeClickWaitSecond > 0 then
		GuideViewMgr.instance:disableHoleClick()
		TaskDispatcher.runDelay(arg_2_0._onDelayStart, arg_2_0, arg_2_0._beforeClickWaitSecond)
	else
		arg_2_0:_onDelayStart()
	end
end

function var_0_0.clearWork(arg_3_0)
	GuideViewMgr.instance:setHoleClickCallback(nil, nil)
	TaskDispatcher.cancelTask(arg_3_0._onDelayStart, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._onDelayDone, arg_3_0)
end

function var_0_0._onClickTarget(arg_4_0, arg_4_1)
	if arg_4_1 or not arg_4_0._isForceGuide then
		GuideViewMgr.instance:disableHoleClick()
		GuideViewMgr.instance:setHoleClickCallback(nil, nil)

		arg_4_0._isInside = arg_4_1

		TaskDispatcher.runDelay(arg_4_0._onDelayDone, arg_4_0, arg_4_0._afterClickWaitSecond + 0.01)
	end
end

function var_0_0._onDelayStart(arg_5_0)
	local var_5_0 = arg_5_0._alpha or arg_5_0._isForceGuide == false and 0 or nil

	if var_5_0 then
		GuideViewMgr.instance:setMaskAlpha(var_5_0)
	end

	GuideViewMgr.instance:enableHoleClick()
	GuideViewMgr.instance:setHoleClickCallback(arg_5_0._onClickTarget, arg_5_0)
end

function var_0_0._onDelayDone(arg_6_0)
	if arg_6_0._isInside then
		arg_6_0:onDone(true)
	elseif not arg_6_0._isForceGuide then
		GuideController.instance:oneKeyFinishGuide(arg_6_0.guideId, false)
	end
end

return var_0_0
