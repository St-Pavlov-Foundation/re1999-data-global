module("modules.logic.player.model.IconTipModel", package.seeall)

local var_0_0 = class("IconTipModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._iconslist = {}
end

function var_0_0.setIconList(arg_2_0, arg_2_1)
	arg_2_0._iconslist = {}

	local var_2_0 = ItemModel.instance:getItemList()
	local var_2_1 = {}
	local var_2_2 = {}
	local var_2_3 = {}

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		local var_2_4 = lua_item.configDict[iter_2_1.id]

		if var_2_4 and var_2_4.subType == ItemEnum.SubType.Portrait and not var_2_1[iter_2_1.id] then
			local var_2_5 = {
				id = var_2_4.id,
				icon = var_2_4.icon,
				name = var_2_4.name,
				isused = var_2_4.id == arg_2_1 and 1 or 0,
				effect = var_2_4.effect
			}
			local var_2_6 = var_2_3[var_2_4.effect]

			if not var_2_6 then
				var_2_6 = {}

				for iter_2_2, iter_2_3 in ipairs(string.split(var_2_4.effect, "#")) do
					table.insert(var_2_6, tonumber(iter_2_3) or 0)
				end

				var_2_3[var_2_4.effect] = var_2_6
			end

			local var_2_7 = #var_2_6

			if var_2_7 > 0 then
				local var_2_8 = false

				var_2_5.effectPortraitDic = {}

				for iter_2_4 = var_2_7, 1, -1 do
					local var_2_9 = var_2_6[iter_2_4]

					var_2_5.effectPortraitDic[var_2_9] = true

					if var_2_8 then
						var_2_1[var_2_9] = true
					elseif var_2_9 == var_2_4.id then
						var_2_8 = true
					end
				end
			end

			var_2_2[var_2_4.id] = var_2_5
		end
	end

	for iter_2_5, iter_2_6 in pairs(var_2_2) do
		if not var_2_1[iter_2_5] then
			table.insert(arg_2_0._iconslist, iter_2_6)
		end
	end

	arg_2_0:setIconsList()
end

function var_0_0.setSelectIcon(arg_3_0, arg_3_1)
	arg_3_0._selectIcon = arg_3_1

	PlayerController.instance:dispatchEvent(PlayerEvent.SelectPortrait, arg_3_1)
end

function var_0_0.getSelectIcon(arg_4_0)
	return arg_4_0._selectIcon
end

function var_0_0.setIconsList(arg_5_0)
	IconListModel.instance:setIconList(arg_5_0._iconslist)
end

var_0_0.instance = var_0_0.New()

return var_0_0
