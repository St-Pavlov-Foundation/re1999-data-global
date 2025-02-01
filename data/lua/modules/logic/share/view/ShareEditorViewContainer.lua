module("modules.logic.share.view.ShareEditorViewContainer", package.seeall)

slot0 = class("ShareEditorViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ShareEditorView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
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
