module("modules.logic.rouge.model.RougeResultReportListModel", package.seeall)

local var_0_0 = class("RougeResultReportListModel", ListScrollModel)

function var_0_0.init(arg_1_0)
	local var_1_0 = RougeFavoriteModel.instance:getReviewInfoList()

	table.sort(var_1_0, function(arg_2_0, arg_2_1)
		return arg_2_0.finishTime > arg_2_1.finishTime
	end)
	arg_1_0:setList(var_1_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
