module("modules.logic.main.controller.work.ActivityRoleSignWork_1_6", package.seeall)

slot0 = class("ActivityRoleSignWork_1_6", ActivityRoleSignWorkBase)

function slot0.onGetViewNames(slot0)
	return {
		ViewName.V1a6_Role_PanelSignView_Part1,
		ViewName.V1a6_Role_PanelSignView_Part2
	}
end

function slot0.onGetActIds(slot0)
	return {
		ActivityEnum.Activity.RoleSignViewPart1_1_6,
		ActivityEnum.Activity.RoleSignViewPart2_1_6
	}
end

return slot0
