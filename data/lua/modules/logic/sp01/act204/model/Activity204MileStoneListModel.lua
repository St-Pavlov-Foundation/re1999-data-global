module("modules.logic.sp01.act204.model.Activity204MileStoneListModel", package.seeall)

local var_0_0 = class("Activity204MileStoneListModel", MixScrollModel)
local var_0_1 = 21

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.actMo = arg_1_1
end

function var_0_0.refresh(arg_2_0)
	local var_2_0 = Activity204Config.instance:getMileStoneList(arg_2_0.actMo.id)
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_2 = {
			id = iter_2_1.rewardId,
			rewardId = iter_2_1.rewardId,
			activityId = iter_2_1.activityId,
			isLoopBonus = iter_2_1.isLoopBonus,
			bonus = iter_2_1.bonus,
			isSpBonus = iter_2_1.isSpBonus
		}

		table.insert(var_2_1, var_2_2)
	end

	arg_2_0:setList(var_2_1)
end

function var_0_0.caleProgressIndex(arg_3_0)
	local var_3_0 = Activity204Config.instance:getMileStoneList(arg_3_0.actMo.id)
	local var_3_1 = 0
	local var_3_2 = Activity204Config.instance:getConstNum(Activity204Enum.ConstId.CurrencyId)
	local var_3_3 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, var_3_2)
	local var_3_4 = 0

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_5 = iter_3_1.coinNum

		if var_3_3 < var_3_5 then
			var_3_1 = iter_3_0 + (var_3_3 - var_3_4) / (var_3_5 - var_3_4) - 1

			return var_3_1
		end

		var_3_4 = var_3_5
	end

	local var_3_6 = #var_3_0
	local var_3_7

	var_3_7 = var_3_0[var_3_6 - 1] and var_3_0[var_3_6 - 1].coinNum or 0

	local var_3_8 = var_3_0[var_3_6]
	local var_3_9 = arg_3_0.actMo.getMilestoneProgress
	local var_3_10 = var_3_8.loopBonusIntervalNum or 1
	local var_3_11 = var_3_8.coinNum

	if var_3_9 < var_3_11 then
		var_3_1 = var_3_6
	else
		local var_3_12 = (var_3_3 - var_3_11) / var_3_10
		local var_3_13 = math.floor(var_3_12)

		if var_3_13 > math.floor((var_3_9 - var_3_11) / var_3_10) then
			var_3_1 = var_3_6
		else
			var_3_1 = var_3_6 - 1 + var_3_12 - var_3_13
		end
	end

	return var_3_1
end

function var_0_0.getMaxMileStoneValue(arg_4_0)
	for iter_4_0 = arg_4_0:getCount(), 1, -1 do
		local var_4_0 = arg_4_0:getByIndex(iter_4_0)
		local var_4_1 = Activity204Model.instance:getById(var_4_0.activityId)

		if var_4_1 and not var_4_0.isLoopBonus then
			return var_4_1:getMilestoneValue(var_4_0.rewardId)
		end
	end

	return 0
end

function var_0_0.getInfoList(arg_5_0, arg_5_1)
	arg_5_0._mixCellInfo = {}

	local var_5_0 = arg_5_0:getList()

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_1 = GameUtil.splitString2(iter_5_1.bonus, true)
		local var_5_2 = (var_5_1 and #var_5_1 or 0) * 215
		local var_5_3 = SLFramework.UGUI.MixCellInfo.New(iter_5_0, var_5_2, iter_5_0)

		table.insert(arg_5_0._mixCellInfo, var_5_3)
	end

	return arg_5_0._mixCellInfo
end

function var_0_0.getItemPosX(arg_6_0, arg_6_1)
	if arg_6_1 <= 0 then
		return 0
	end

	local var_6_0 = var_0_1
	local var_6_1 = 0

	for iter_6_0 = 1, arg_6_1 - 1 do
		var_6_0 = var_6_0 + arg_6_0:getItemWidth(iter_6_0)
	end

	local var_6_2 = arg_6_0:getItemWidth(arg_6_1)

	return var_6_0 + var_6_1 / 2 + var_6_2 / 2
end

function var_0_0.getItemWidth(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return 0
	end

	local var_7_0 = arg_7_0._mixCellInfo and arg_7_0._mixCellInfo[arg_7_1]

	return var_7_0 and var_7_0.lineLength or 0
end

function var_0_0.getItemFocusPosX(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getItemWidth(arg_8_1 - 1)

	return arg_8_0:getItemPosX(arg_8_1 - 1) + var_8_0 / 2
end

var_0_0.instance = var_0_0.New()

return var_0_0
