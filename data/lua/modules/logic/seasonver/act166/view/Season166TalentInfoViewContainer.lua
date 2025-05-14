module("modules.logic.seasonver.act166.view.Season166TalentInfoViewContainer", package.seeall)

local var_0_0 = class("Season166TalentInfoViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Season166TalentInfoView.New())

	return var_1_0
end

return var_0_0
