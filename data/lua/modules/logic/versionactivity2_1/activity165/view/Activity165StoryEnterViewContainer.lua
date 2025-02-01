module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryEnterViewContainer", package.seeall)

slot0 = class("Activity165StoryEnterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Activity165StoryEnterView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return slot0
