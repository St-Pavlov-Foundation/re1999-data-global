module("modules.logic.equip.view.EquipTeamAttrItem", package.seeall)

local var_0_0 = class("EquipTeamAttrItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtvalue1 = gohelper.findChildText(arg_1_0.viewGO, "#txt_value1")
	arg_1_0._txtname1 = gohelper.findChildText(arg_1_0.viewGO, "#txt_name1")
	arg_1_0._simageicon1 = gohelper.findChildImage(arg_1_0.viewGO, "#simage_icon1")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1

	local var_7_0 = arg_7_0._mo.attrId
	local var_7_1 = HeroConfig.instance:getHeroAttributeCO(var_7_0)

	CharacterController.instance:SetAttriIcon(arg_7_0._simageicon1, var_7_0)

	arg_7_0._txtvalue1.text = EquipConfig.instance:getEquipValueStr(arg_7_0._mo)
	arg_7_0._txtname1.text = var_7_1.name
end

function var_0_0.onSelect(arg_8_0, arg_8_1)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
