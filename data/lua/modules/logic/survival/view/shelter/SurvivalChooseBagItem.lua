module("modules.logic.survival.view.shelter.SurvivalChooseBagItem", package.seeall)

local var_0_0 = class("SurvivalChooseBagItem", SurvivalBagItem)

function var_0_0.getEquipId(arg_1_0)
	return arg_1_0._mo.id
end

function var_0_0.updateMo(arg_2_0, arg_2_1)
	var_0_0.super.updateMo(arg_2_0, arg_2_1)

	arg_2_0._txtnum.text = ""

	local var_2_0 = SurvivalShelterChooseEquipListModel.instance:getSelectIdByPos(1)

	gohelper.setActive(arg_2_0._goCollectionSelectTips, var_2_0 ~= nil and arg_2_0:getEquipId() == var_2_0)
end

function var_0_0._onItemClick(arg_3_0)
	if arg_3_0._mo:isEmpty() and not arg_3_0._canClickEmpty then
		return
	end

	SurvivalShelterChooseEquipListModel.instance:setSelectEquip(arg_3_0:getEquipId())

	if arg_3_0._callback then
		arg_3_0._callback(arg_3_0._callobj, arg_3_0)

		return
	end
end

return var_0_0
