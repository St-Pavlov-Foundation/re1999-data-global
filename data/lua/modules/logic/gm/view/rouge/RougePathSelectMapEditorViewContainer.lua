module("modules.logic.gm.view.rouge.RougePathSelectMapEditorViewContainer", package.seeall)

local var_0_0 = class("RougePathSelectMapEditorViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		RougePathSelectMapEditorView.New()
	}
end

return var_0_0
