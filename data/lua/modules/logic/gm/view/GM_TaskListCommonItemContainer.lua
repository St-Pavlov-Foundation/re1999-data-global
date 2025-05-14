module("modules.logic.gm.view.GM_TaskListCommonItemContainer", package.seeall)

local var_0_0 = class("GM_TaskListCommonItemContainer", BaseViewContainer)

function var_0_0.onContainerClickModalMask(arg_1_0)
	ViewMgr.instance:closeView(arg_1_0.viewName)
end

function var_0_0.buildViews(arg_2_0)
	assert(false)
end

function var_0_0._gm_showAllTabIdUpdate(arg_3_0)
	assert(false, "please override this function")
end

function var_0_0._gm_enableFinishOnSelect(arg_4_0)
	assert(false, "please override this function")
end

function var_0_0._gm_onClickFinishAll(arg_5_0)
	assert(false, "please override this function")
end

return var_0_0
