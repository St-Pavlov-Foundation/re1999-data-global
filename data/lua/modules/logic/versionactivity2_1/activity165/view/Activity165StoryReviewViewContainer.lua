module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryReviewViewContainer", package.seeall)

slot0 = class("Activity165StoryReviewViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Activity165StoryReviewView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		})
	}
end

return slot0
