﻿module("modules.logic.activity.view.LinkageActivity_PanelViewContainer", package.seeall)

local var_0_0 = class("LinkageActivity_PanelViewContainer", LinkageActivity_BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._view = LinkageActivity_PanelView.New()

	table.insert(var_1_0, arg_1_0._view)

	return var_1_0
end

function var_0_0.view(arg_2_0)
	return arg_2_0._view
end

return var_0_0
