module("modules.logic.rouge.model.RougeIllustrationListModel", package.seeall)

local var_0_0 = class("RougeIllustrationListModel", MixScrollModel)

function var_0_0.initList(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = RougeFavoriteConfig.instance:getIllustrationPages()

	tabletool.addValues(var_1_0, var_1_1)

	local var_1_2 = RougeFavoriteConfig.instance:getNormalIllustrationPageCount()

	if var_1_2 > 0 then
		local var_1_3 = arg_1_0:getSplitSpaceInfoItem()

		table.insert(var_1_0, var_1_2 + 1, var_1_3)
	end

	arg_1_0:setList(var_1_0)
end

local var_0_1 = {
	480,
	660,
	1140,
	1500,
	1770,
	2103
}
local var_0_2 = 300
local var_0_3 = 1000

function var_0_0.getInfoList(arg_2_0, arg_2_1)
	local var_2_0 = {}
	local var_2_1 = arg_2_0:getList()

	arg_2_0._splitSpaceStartPosX = 0

	local var_2_2 = false

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		local var_2_3

		if iter_2_1.isSplitSpace then
			var_2_3 = SLFramework.UGUI.MixCellInfo.New(var_0_3, var_0_2, iter_2_0)
			var_2_2 = true
		else
			local var_2_4 = #iter_2_1

			var_2_3 = SLFramework.UGUI.MixCellInfo.New(var_2_4, var_0_1[var_2_4], iter_2_0)

			if not var_2_2 then
				arg_2_0._splitSpaceStartPosX = arg_2_0._splitSpaceStartPosX + var_0_1[var_2_4]
			end
		end

		table.insert(var_2_0, var_2_3)
	end

	return var_2_0
end

function var_0_0.getSplitSpaceInfoItem(arg_3_0)
	if not arg_3_0._splitSpaceItem then
		arg_3_0._splitSpaceItem = {
			isSplitSpace = true
		}
	end

	return arg_3_0._splitSpaceItem
end

function var_0_0.getSplitEmptySpaceStartPosX(arg_4_0)
	return arg_4_0._splitSpaceStartPosX or 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
