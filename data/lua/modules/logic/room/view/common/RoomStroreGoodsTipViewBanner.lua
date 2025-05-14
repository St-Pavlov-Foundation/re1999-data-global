module("modules.logic.room.view.common.RoomStroreGoodsTipViewBanner", package.seeall)

local var_0_0 = class("RoomStroreGoodsTipViewBanner", RoomMaterialTipViewBanner)

function var_0_0._getItemDataList(arg_1_0)
	local var_1_0 = arg_1_0.viewParam.storeGoodsMO.config
	local var_1_1 = GameUtil.splitString2(var_1_0.product, true)
	local var_1_2 = {
		MaterialEnum.MaterialType.RoomTheme,
		MaterialEnum.MaterialType.BlockPackage,
		MaterialEnum.MaterialType.Building
	}
	local var_1_3 = {}
	local var_1_4 = #var_1_1 > 1

	for iter_1_0 = 1, #var_1_1 do
		local var_1_5 = var_1_1[iter_1_0]
		local var_1_6 = var_1_5[1]
		local var_1_7 = var_1_5[2]

		if var_1_4 then
			local var_1_8 = RoomConfig.instance:getThemeIdByItem(var_1_7, var_1_6)

			if var_1_8 then
				arg_1_0:_addItemInfoToDic(var_1_3, var_1_8, MaterialEnum.MaterialType.RoomTheme)
			end
		end

		if tabletool.indexOf(var_1_2, var_1_6) then
			arg_1_0:_addItemInfoToDic(var_1_3, var_1_7, var_1_6)
		end
	end

	local var_1_9 = {}

	for iter_1_1, iter_1_2 in ipairs(var_1_2) do
		if var_1_3[iter_1_2] then
			for iter_1_3, iter_1_4 in ipairs(var_1_3[iter_1_2]) do
				table.insert(var_1_9, {
					itemId = iter_1_4,
					itemType = iter_1_2
				})
			end
		end
	end

	return var_1_9
end

function var_0_0._addItemInfoToDic(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_1 = arg_2_1 or {}

	if not arg_2_1[arg_2_3] then
		arg_2_1[arg_2_3] = {}
	end

	if tabletool.indexOf(arg_2_1[arg_2_3], arg_2_2) == nil then
		table.insert(arg_2_1[arg_2_3], arg_2_2)
	end

	return arg_2_1
end

return var_0_0
