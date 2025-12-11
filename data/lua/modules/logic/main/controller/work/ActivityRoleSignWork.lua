module("modules.logic.main.controller.work.ActivityRoleSignWork", package.seeall)

local var_0_0 = class("ActivityRoleSignWork", ActivityRoleSignWorkBase)

function var_0_0.onGetViewNames(arg_1_0)
	return {
		ViewName.Role_PanelSignView_Part1,
		ViewName.Role_PanelSignView_Part2
	}
end

function var_0_0.onGetActIds(arg_2_0)
	return ActivityType101Model.instance:getRoleSignActIdList()
end

return var_0_0
