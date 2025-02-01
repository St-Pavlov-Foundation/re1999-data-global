module("modules.logic.gm.view.rouge.RougePathSelectMapEditorViewContainer", package.seeall)

slot0 = class("RougePathSelectMapEditorViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		RougePathSelectMapEditorView.New()
	}
end

return slot0
