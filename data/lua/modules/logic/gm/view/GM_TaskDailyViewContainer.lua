module("modules.logic.gm.view.GM_TaskDailyViewContainer", package.seeall)

local var_0_0 = class("GM_TaskDailyViewContainer", GM_TaskListCommonItemContainer)
local var_0_1

function var_0_0.buildViews(arg_1_0)
	return {
		GM_TaskDailyView.New()
	}
end

function var_0_0._gm_showAllTabIdUpdate(arg_2_0, arg_2_1)
	assert(var_0_1)
	var_0_1:_gm_showAllTabIdUpdate(arg_2_1)
end

function var_0_0._gm_enableFinishOnSelect(arg_3_0, arg_3_1)
	assert(var_0_1)
	var_0_1:_gm_enableFinishOnSelect(arg_3_1)
end

function var_0_0._gm_onClickFinishAll(arg_4_0)
	assert(var_0_1)
	var_0_1:_gm_onClickFinishAll()
end

function var_0_0.addEvents(arg_5_0)
	var_0_1 = assert(arg_5_0)
end

function var_0_0.removeEvents(arg_6_0)
	var_0_1 = nil
end

return var_0_0
