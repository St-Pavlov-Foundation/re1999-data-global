module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryEditViewContainer", package.seeall)

slot0 = class("Activity165StoryEditViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0.editView = Activity165StoryEditView.New()
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))
	table.insert(slot1, slot0.editView)

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

function slot0.playCloseTransition(slot0)
	slot0:startViewCloseBlock()
	slot0.editView:playCloseAnim(slot0.onPlayCloseTransitionFinish, slot0)
end

return slot0
