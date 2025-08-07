module("modules.logic.bossrush.model.v2a9.V2a9BossRushSkillBackpackListModel", package.seeall)

local var_0_0 = class("V2a9BossRushSkillBackpackListModel", ListScrollModel)

function var_0_0.setMoList(arg_1_0, arg_1_1)
	local var_1_0 = AssassinItemModel.instance:getAssassinItemMoList()
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_2 = V2a9BossRushAssassinMO.New()

		var_1_2:init(iter_1_1, arg_1_1)
		table.insert(var_1_1, var_1_2)
	end

	arg_1_0:setList(var_1_1, arg_1_1)
end

function var_0_0.initSelect(arg_2_0)
	local var_2_0 = V2a9BossRushModel.instance:getSelectedItemId()
	local var_2_1 = arg_2_0:getList()
	local var_2_2

	if var_2_0 then
		local var_2_3 = arg_2_0:getById(var_2_0)

		var_2_2 = arg_2_0:getIndex(var_2_3)
	else
		var_2_2 = 1
		var_2_0 = var_2_1[var_2_2] and var_2_1[var_2_2]:getId()

		V2a9BossRushModel.instance:selectSpItemId(var_2_0)
	end

	if var_2_0 and var_2_2 then
		arg_2_0:selectCell(var_2_2, true)
	end
end

function var_0_0.getMObyItemType(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0:getList()) do
		if iter_3_1.itemType == arg_3_1 then
			return iter_3_1
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
