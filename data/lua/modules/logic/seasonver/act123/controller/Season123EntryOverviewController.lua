module("modules.logic.seasonver.act123.controller.Season123EntryOverviewController", package.seeall)

local var_0_0 = class("Season123EntryOverviewController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1)
	Season123EntryOverviewModel.instance:init(arg_1_1)
end

function var_0_0.onCloseView(arg_2_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
