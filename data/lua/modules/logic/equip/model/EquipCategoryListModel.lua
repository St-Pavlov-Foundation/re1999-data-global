module("modules.logic.equip.model.EquipCategoryListModel", package.seeall)

local var_0_0 = class("EquipCategoryListModel", ListScrollModel)

var_0_0.ViewIndex = {
	EquipInfoViewIndex = 1,
	EquipRefineViewIndex = 3,
	EquipStrengthenViewIndex = 2,
	EquipStoryViewIndex = 4
}

function var_0_0.initCategory(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {}

	table.insert(var_1_0, arg_1_0:packMo(luaLang("equip_lang_18"), luaLang("p_equip_35"), var_0_0.ViewIndex.EquipInfoViewIndex))

	if arg_1_1 and arg_1_2.isExpEquip ~= 1 and arg_1_2.id ~= EquipConfig.instance:getEquipUniversalId() and not EquipHelper.isSpRefineEquip(arg_1_2) then
		table.insert(var_1_0, arg_1_0:packMo(luaLang("equip_lang_19"), luaLang("p_equip_36"), var_0_0.ViewIndex.EquipStrengthenViewIndex))
		table.insert(var_1_0, arg_1_0:packMo(luaLang("equip_lang_21"), luaLang("p_equip_39"), var_0_0.ViewIndex.EquipRefineViewIndex))
	end

	table.insert(var_1_0, arg_1_0:packMo(luaLang("equip_lang_20"), luaLang("p_equip_38"), var_0_0.ViewIndex.EquipStoryViewIndex))
	arg_1_0:setList(var_1_0)
end

function var_0_0.packMo(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._moList = arg_2_0._moList or {}

	local var_2_0 = arg_2_0._moList[arg_2_3]

	if not var_2_0 then
		var_2_0 = {}
		arg_2_0._moList[arg_2_3] = var_2_0
		var_2_0.cnName = arg_2_1
		var_2_0.enName = arg_2_2
		var_2_0.resIndex = arg_2_3
	end

	if var_2_0.cnName ~= arg_2_1 or var_2_0.enName ~= arg_2_2 or var_2_0.resIndex ~= arg_2_3 then
		var_2_0 = {}
		arg_2_0._moList[arg_2_3] = var_2_0
		var_2_0.cnName = arg_2_1
		var_2_0.enName = arg_2_2
		var_2_0.resIndex = arg_2_3
	end

	return var_2_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
