module("modules.logic.main.controller.work.ActivityRoleSignWork_1_6", package.seeall)

local var_0_0 = class("ActivityRoleSignWork_1_6", ActivityRoleSignWorkBase)

function var_0_0.onGetViewNames(arg_1_0)
	return {
		ViewName.V1a6_Role_PanelSignView_Part1,
		ViewName.V1a6_Role_PanelSignView_Part2
	}
end

function var_0_0.onGetActIds(arg_2_0)
	return {
		ActivityEnum.Activity.RoleSignViewPart1_1_6,
		ActivityEnum.Activity.RoleSignViewPart2_1_6
	}
end

return var_0_0
