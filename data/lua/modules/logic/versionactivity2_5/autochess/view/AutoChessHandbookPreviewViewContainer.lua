module("modules.logic.versionactivity2_5.autochess.view.AutoChessHandbookPreviewViewContainer", package.seeall)

local var_0_0 = class("AutoChessHandbookPreviewViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, AutoChessHandbookPreviewView.New())

	return var_1_0
end

return var_0_0
