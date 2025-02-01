module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5BuildingSkillViewContainer", package.seeall)

slot0 = class("V1a5BuildingSkillViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		V1a5BuildingSkillView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return slot0
