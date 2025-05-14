module("modules.logic.seasonver.act123.utils.Season123ViewHelper", package.seeall)

local var_0_0 = class("Season123ViewHelper")

function var_0_0.openView(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.getViewName(arg_1_0, arg_1_1)

	if var_1_0 then
		ViewMgr.instance:openView(var_1_0, arg_1_2)
	end
end

function var_0_0.getViewName(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0 = arg_2_0 or Season123Model.instance:getCurSeasonId()

	local var_2_0 = Activity123Enum.SeasonViewPrefix[arg_2_0] or ""
	local var_2_1 = string.format("Season123%s%s", var_2_0, arg_2_1)
	local var_2_2 = ViewName[var_2_1]

	if not var_2_2 and not arg_2_2 then
		logError(string.format("cant find season123 view [%s] [%s]", arg_2_0, arg_2_1))
	end

	return var_2_2 or var_2_1
end

function var_0_0.getIconUrl(arg_3_0, arg_3_1, arg_3_2)
	arg_3_2 = arg_3_2 or Season123Model.instance:getCurSeasonId()

	local var_3_0 = Activity123Enum.SeasonResourcePrefix[arg_3_2]

	return string.format(arg_3_0, var_3_0, arg_3_1)
end

return var_0_0
