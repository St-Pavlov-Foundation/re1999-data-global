module("modules.logic.commandstation.view.CommandStationPaperGetViewContainer", package.seeall)

local var_0_0 = class("CommandStationPaperGetViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		CommandStationPaperGetView.New()
	}
end

return var_0_0
