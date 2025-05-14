module("modules.logic.gm.view.rouge.RougeMapEditorViewContainer", package.seeall)

local var_0_0 = class("RougeMapEditorViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		RougeMapEditorView.New()
	}
end

return var_0_0
