module("modules.logic.gm.view.rouge.RougeMapEditorViewContainer", package.seeall)

slot0 = class("RougeMapEditorViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		RougeMapEditorView.New()
	}
end

return slot0
