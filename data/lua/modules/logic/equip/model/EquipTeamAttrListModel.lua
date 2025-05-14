module("modules.logic.equip.model.EquipTeamAttrListModel", package.seeall)

local var_0_0 = class("EquipTeamAttrListModel", ListScrollModel)

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.SetAttrList(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = EquipTeamListModel.instance:getTeamEquip()

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		local var_2_2 = EquipModel.instance:getEquip(iter_2_1)

		if var_2_2 then
			local var_2_3, var_2_4, var_2_5, var_2_6, var_2_7 = EquipConfig.instance:getEquipStrengthenAttr(var_2_2)

			arg_2_0:setAttr(var_2_0, 101, 0, var_2_3)
			arg_2_0:setAttr(var_2_0, 102, 0, var_2_4)
			arg_2_0:setAttr(var_2_0, 103, 0, var_2_5)
			arg_2_0:setAttr(var_2_0, 104, 0, var_2_6)

			for iter_2_2, iter_2_3 in pairs(lua_character_attribute.configDict) do
				if iter_2_3.type == 2 or iter_2_3.type == 3 then
					arg_2_0:setAttr(var_2_0, iter_2_2, iter_2_3.showType, var_2_7[iter_2_3.attrType])
				end
			end
		end
	end

	local var_2_8 = {}

	for iter_2_4, iter_2_5 in pairs(var_2_0) do
		for iter_2_6, iter_2_7 in pairs(iter_2_5) do
			table.insert(var_2_8, {
				attrId = iter_2_4,
				showType = iter_2_6,
				value = iter_2_7
			})
		end
	end

	table.sort(var_2_8, var_0_0._sort)
	arg_2_0:setList(var_2_8)
end

function var_0_0._sort(arg_3_0, arg_3_1)
	return arg_3_0.attrId < arg_3_1.attrId
end

function var_0_0.setAttr(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_4 <= -1 then
		return
	end

	local var_4_0 = arg_4_1[arg_4_2] or {}

	arg_4_1[arg_4_2] = var_4_0
	var_4_0[arg_4_3] = (var_4_0[arg_4_3] or 0) + arg_4_4
end

var_0_0.instance = var_0_0.New()

return var_0_0
