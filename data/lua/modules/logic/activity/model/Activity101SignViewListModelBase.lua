module("modules.logic.activity.model.Activity101SignViewListModelBase", package.seeall)

local var_0_0 = class("Activity101SignViewListModelBase", ListScrollModel)

function var_0_0.getViewportItemCount(arg_1_0)
	return 7.2
end

function var_0_0.setList(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:getList()

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_1 = arg_2_1[iter_2_0]

		if var_2_1 then
			var_2_1.__isPlayedOpenAnim = iter_2_1.__isPlayedOpenAnim
		end
	end

	var_0_0.super.setList(arg_2_0, arg_2_1)
end

function var_0_0.setDefaultPinStartIndex(arg_3_0, arg_3_1, arg_3_2)
	arg_3_2 = arg_3_2 or 1

	if not arg_3_1 or #arg_3_1 == 0 then
		arg_3_0:setStartPinIndex(1)

		return
	end

	local var_3_0 = #arg_3_1
	local var_3_1 = math.max(1, math.ceil(var_3_0 - arg_3_0:getViewportItemCount()))

	arg_3_0:setStartPinIndex(var_3_1 < arg_3_2 and var_3_1 or 1)
end

function var_0_0.setStartPinIndex(arg_4_0, arg_4_1)
	arg_4_0._startPinIndex = arg_4_1
end

function var_0_0.getStartPinIndex(arg_5_0)
	return arg_5_0._startPinIndex or 1
end

return var_0_0
