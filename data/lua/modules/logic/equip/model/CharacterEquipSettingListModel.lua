module("modules.logic.equip.model.CharacterEquipSettingListModel", package.seeall)

local var_0_0 = class("CharacterEquipSettingListModel", EquipInfoBaseListModel)

function var_0_0.onOpen(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.heroMo = arg_1_1.heroMo

	arg_1_0:initEquipList(arg_1_2)
	arg_1_0:setCurrentShowHeroMo(arg_1_1.heroMo)

	local var_1_0 = EquipModel.instance:getEquip(arg_1_1.heroMo.defaultEquipUid) or arg_1_0.equipMoList and arg_1_0.equipMoList[1]

	arg_1_0:setCurrentSelectEquipMo(var_1_0)
end

function var_0_0.setCurrentShowHeroMo(arg_2_0, arg_2_1)
	arg_2_0.currentShowHeroMo = arg_2_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
