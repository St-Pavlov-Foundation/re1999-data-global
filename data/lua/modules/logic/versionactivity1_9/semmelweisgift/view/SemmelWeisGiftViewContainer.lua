module("modules.logic.versionactivity1_9.semmelweisgift.view.SemmelWeisGiftViewContainer", package.seeall)

local var_0_0 = class("SemmelWeisGiftViewContainer", DecalogPresentViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, SemmelWeisGiftView.New())

	return var_1_0
end

return var_0_0
