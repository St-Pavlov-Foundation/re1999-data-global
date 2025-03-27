module("modules.logic.versionactivity2_4.pinball.view.PinballTalentViewContainer", package.seeall)

slot0 = class("PinballTalentViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		PinballTalentView.New(),
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
