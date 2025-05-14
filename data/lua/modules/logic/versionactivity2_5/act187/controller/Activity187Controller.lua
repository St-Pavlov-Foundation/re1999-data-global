module("modules.logic.versionactivity2_5.act187.controller.Activity187Controller", package.seeall)

local var_0_0 = class("Activity187Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.openAct187View(arg_5_0)
	arg_5_0:getAct187Info(arg_5_0._realOpenAct187View, arg_5_0, true)
end

function var_0_0.getAct187Info(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not Activity187Model.instance:isAct187Open(arg_6_3) then
		return
	end

	local var_6_0 = Activity187Model.instance:getAct187Id()

	Activity187Rpc.instance:sendGet187InfoRequest(var_6_0, arg_6_1, arg_6_2)
end

function var_0_0._realOpenAct187View(arg_7_0)
	ViewMgr.instance:openView(ViewName.Activity187View)
end

function var_0_0.finishPainting(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = Activity187Model.instance:getAct187Id()

	Activity187Rpc.instance:sendAct187FinishGameRequest(var_8_0, arg_8_1, arg_8_2)
end

function var_0_0.getAccrueReward(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = Activity187Model.instance:getAct187Id()

	Activity187Rpc.instance:sendAct187AcceptRewardRequest(var_9_0, arg_9_1, arg_9_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
