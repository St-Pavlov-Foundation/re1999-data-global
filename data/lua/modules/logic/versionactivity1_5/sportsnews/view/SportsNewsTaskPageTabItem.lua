module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsTaskPageTabItem", package.seeall)

local var_0_0 = class("SportsNewsTaskPageTabItem", SportsNewsPageTabItem)

function var_0_0.initData(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.initData(arg_1_0, arg_1_1, arg_1_2)
end

function var_0_0.getTabStatus(arg_2_0)
	local var_2_0 = ActivityWarmUpTaskListModel.instance:getSelectedDay() == arg_2_0._index

	if arg_2_0._index > ActivityWarmUpModel.instance:getCurrentDay() then
		return SportsNewsEnum.PageTabStatus.Lock
	elseif var_2_0 then
		return SportsNewsEnum.PageTabStatus.Select
	else
		return SportsNewsEnum.PageTabStatus.UnSelect
	end
end

function var_0_0._btnclickOnClick(arg_3_0)
	if arg_3_0:getTabStatus() == SportsNewsEnum.PageTabStatus.UnSelect then
		ActivityWarmUpTaskController.instance:changeSelectedDay(arg_3_0._index)
		SportsNewsController.instance:dispatchEvent(SportsNewsEvent.OnCutTab, 2)
	end
end

function var_0_0.onRefresh(arg_4_0)
	var_0_0.super.onRefresh(arg_4_0)
	arg_4_0:redDot()
end

function var_0_0.redDot(arg_5_0)
	local var_5_0 = arg_5_0:isShowRedDot()

	arg_5_0:enableRedDot(var_5_0, RedDotEnum.DotNode.v1a5NewsTaskBonus)
end

function var_0_0.isShowRedDot(arg_6_0)
	if arg_6_0._index > ActivityWarmUpModel.instance:getCurrentDay() then
		return false
	end

	local var_6_0 = SportsNewsModel.instance:getSelectedDayTask(arg_6_0._index)

	if var_6_0 then
		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			local var_6_1 = iter_6_1:isFinished()
			local var_6_2 = iter_6_1:alreadyGotReward()

			if var_6_1 and not var_6_2 then
				return true
			end
		end
	end

	return false
end

function var_0_0.playTabAnim(arg_7_0)
	return
end

return var_0_0
