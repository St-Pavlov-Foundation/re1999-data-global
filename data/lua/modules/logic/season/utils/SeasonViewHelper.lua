module("modules.logic.season.utils.SeasonViewHelper", package.seeall)

local var_0_0 = class("SeasonViewHelper")

function var_0_0.openView(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.getViewName(arg_1_0, arg_1_1)

	if var_1_0 then
		ViewMgr.instance:openView(var_1_0, arg_1_2)
	end
end

function var_0_0.getViewName(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0 = arg_2_0 or Activity104Model.instance:getCurSeasonId()

	local var_2_0 = Activity104Enum.SeasonViewPrefix[arg_2_0] or ""
	local var_2_1 = string.format("Season%s%s", var_2_0, arg_2_1)
	local var_2_2 = ViewName[var_2_1]

	if not var_2_2 and not arg_2_2 then
		logError(string.format("cant find season view [%s] [%s]", arg_2_0, arg_2_1))
	end

	return var_2_2
end

function var_0_0.getSeasonIcon(arg_3_0, arg_3_1)
	arg_3_1 = arg_3_1 or Activity104Model.instance:getCurSeasonId()

	local var_3_0 = Activity104Enum.SeasonIconFolder[arg_3_1]

	return string.format("singlebg/%s/%s", var_3_0, arg_3_0)
end

function var_0_0.getAllSeasonViewList(arg_4_0)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(Activity104Enum.ViewName) do
		local var_4_1 = var_0_0.getViewName(arg_4_0, iter_4_1, true)

		if var_4_1 then
			table.insert(var_4_0, var_4_1)
		end
	end

	return var_4_0
end

function var_0_0.getIconUrl(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2 = arg_5_2 or Activity104Model.instance:getCurSeasonId()

	local var_5_0 = Activity104Enum.SeasonIconFolder[arg_5_2]

	return string.format(arg_5_0, var_5_0, arg_5_1)
end

return var_0_0
