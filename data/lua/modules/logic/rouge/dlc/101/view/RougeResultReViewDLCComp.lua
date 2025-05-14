module("modules.logic.rouge.dlc.101.view.RougeResultReViewDLCComp", package.seeall)

local var_0_0 = class("RougeResultReViewDLCComp", RougeBaseDLCViewComp)

function var_0_0.getSeason(arg_1_0)
	local var_1_0 = arg_1_0.viewParam and arg_1_0.viewParam.reviewInfo

	return var_1_0 and var_1_0.season
end

function var_0_0.getVersions(arg_2_0)
	local var_2_0 = arg_2_0.viewParam and arg_2_0.viewParam.reviewInfo

	return var_2_0 and var_2_0:getVersions()
end

return var_0_0
