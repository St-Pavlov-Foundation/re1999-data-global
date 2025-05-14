module("modules.logic.guide.controller.action.impl.WaitGuideActionSeasonRetail", package.seeall)

local var_0_0 = class("WaitGuideActionSeasonRetail", BaseGuideAction)
local var_0_1

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.split(arg_1_0.actionParam, "#")

	arg_1_0._viewName = ViewName[var_1_0[1]]

	local var_1_1 = var_1_0[2]

	arg_1_0._conditionParam = var_1_0[3]
	arg_1_0._conditionCheckFun = arg_1_0[var_1_1]

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0._checkOpenView, arg_1_0)
	Activity104Controller.instance:registerCallback(Activity104Event.RefreshRetail, arg_1_0._refreshRetail, arg_1_0)
end

function var_0_0._checkOpenView(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0._viewName == arg_2_1 and arg_2_0._conditionCheckFun(arg_2_0._conditionParam) then
		var_0_1 = var_0_1 or {}

		if not tabletool.indexOf(var_0_1, arg_2_0.guideId) then
			table.insert(var_0_1, arg_2_0.guideId)
		end

		TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 0.01)
	end
end

function var_0_0._refreshRetail(arg_3_0)
	if ViewMgr.instance:isOpen(arg_3_0._viewName) and arg_3_0._conditionCheckFun(arg_3_0._conditionParam) then
		var_0_1 = var_0_1 or {}

		if not tabletool.indexOf(var_0_1, arg_3_0.guideId) then
			table.insert(var_0_1, arg_3_0.guideId)
		end

		TaskDispatcher.runDelay(arg_3_0._delayDone, arg_3_0, 0.01)
	end
end

function var_0_0._delayDone(arg_4_0)
	if var_0_1 and GuideConfig.instance:getHighestPriorityGuideId(var_0_1) == arg_4_0.guideId then
		var_0_1 = nil

		arg_4_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_5_0._checkOpenView, arg_5_0)
	Activity104Controller.instance:unregisterCallback(Activity104Event.RefreshRetail, arg_5_0._refreshRetail, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayDone, arg_5_0)
end

function var_0_0.seasonRetailRare(arg_6_0)
	local var_6_0 = string.splitToNumber(arg_6_0, "_")
	local var_6_1 = Activity104Model.instance:getAct104Retails()

	for iter_6_0, iter_6_1 in pairs(var_6_1) do
		local var_6_2 = iter_6_1.position
		local var_6_3 = iter_6_1.advancedId
		local var_6_4 = iter_6_1.advancedRare

		if tabletool.indexOf(var_6_0, var_6_2) and var_6_3 ~= 0 and var_6_4 ~= 0 then
			return true
		end
	end

	return false
end

return var_0_0
