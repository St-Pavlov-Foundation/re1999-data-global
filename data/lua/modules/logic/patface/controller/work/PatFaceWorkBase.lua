module("modules.logic.patface.controller.work.PatFaceWorkBase", package.seeall)

local var_0_0 = class("PatFaceWorkBase", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._patFaceId = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	if not arg_2_0._patFaceId or arg_2_0._patFaceId == PatFaceEnum.NoneNum then
		arg_2_0:patComplete()

		return
	end

	arg_2_0._patViewName = PatFaceConfig.instance:getPatFaceViewName(arg_2_0._patFaceId)
	arg_2_0._patStoryId = PatFaceConfig.instance:getPatFaceStoryId(arg_2_0._patFaceId)
	arg_2_0._patFaceType = arg_2_1 and arg_2_1.patFaceType

	if arg_2_0:checkCanPat() then
		arg_2_0:startPat()
	else
		arg_2_0:patComplete()
	end
end

function var_0_0.checkCanPat(arg_3_0)
	local var_3_0 = false
	local var_3_1 = PatFaceEnum.CustomCheckCanPatFun[arg_3_0._patFaceId]

	if var_3_1 then
		var_3_0 = var_3_1(arg_3_0._patFaceId)
	else
		var_3_0 = arg_3_0:defaultCheckCanPat()
	end

	return var_3_0
end

function var_0_0.defaultCheckCanPat(arg_4_0)
	local var_4_0 = false
	local var_4_1 = PatFaceConfig.instance:getPatFaceActivityId(arg_4_0._patFaceId)

	if var_4_1 and var_4_1 ~= PatFaceEnum.NoneNum then
		var_4_0 = ActivityHelper.getActivityStatus(var_4_1) == ActivityEnum.ActivityStatus.Normal
	else
		local var_4_2 = string.format("PatFaceWorkBase:defaultCheckCanPat error, actId invalid,patFaceId:%s, actId:%s", arg_4_0._patFaceId, var_4_1)

		logNormal(var_4_2)
	end

	return var_4_0
end

function var_0_0.startPat(arg_5_0)
	if not string.nilorempty(arg_5_0._patViewName) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_5_0.onCloseViewFinish, arg_5_0)
		arg_5_0:patView()
	elseif arg_5_0._patStoryId and arg_5_0._patStoryId ~= PatFaceEnum.NoneNum then
		arg_5_0:patStory()
	else
		arg_5_0:patComplete()
	end
end

function var_0_0.onResume(arg_6_0)
	if not string.nilorempty(arg_6_0._patViewName) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_6_0.onCloseViewFinish, arg_6_0)
	end
end

function var_0_0.patView(arg_7_0)
	local var_7_0 = PatFaceEnum.CustomPatFun[arg_7_0._patFaceId]

	if var_7_0 then
		var_7_0(arg_7_0._patFaceId)
	else
		ViewMgr.instance:openView(arg_7_0._patViewName)
	end
end

function var_0_0.patStory(arg_8_0)
	StoryController.instance:playStory(arg_8_0._patStoryId, nil, arg_8_0.onPlayPatStoryFinish, arg_8_0)
end

function var_0_0.onCloseViewFinish(arg_9_0, arg_9_1)
	if string.nilorempty(arg_9_0._patViewName) or arg_9_0._patViewName == arg_9_1 then
		arg_9_0:patComplete()
	end
end

function var_0_0.onPlayPatStoryFinish(arg_10_0)
	arg_10_0:patComplete()
end

function var_0_0.patComplete(arg_11_0)
	arg_11_0:onDone(true)
end

function var_0_0.clearWork(arg_12_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_12_0.onCloseViewFinish, arg_12_0)
end

return var_0_0
