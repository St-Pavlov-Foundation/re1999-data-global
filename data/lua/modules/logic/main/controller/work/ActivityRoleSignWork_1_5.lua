module("modules.logic.main.controller.work.ActivityRoleSignWork_1_5", package.seeall)

slot0 = class("ActivityRoleSignWork_1_5", ActivityRoleSignWorkBase)

function slot0.onGetViewNames(slot0)
	return {
		ViewName.V1a5_Role_PanelSignView_Part1,
		ViewName.V1a5_Role_PanelSignView_Part2,
		ViewName.V1a5_DoubleFestival_PanelSignView,
		ViewName.V1a5_HarvestSeason_PanelSignView
	}
end

function slot0.onGetActIds(slot0)
	return {
		ActivityEnum.Activity.RoleSignViewPart1_1_5,
		ActivityEnum.Activity.RoleSignViewPart2_1_5,
		ActivityEnum.Activity.DoubleFestivalSign_1_5,
		ActivityEnum.Activity.HarvestSeasonView_1_5
	}
end

return slot0
