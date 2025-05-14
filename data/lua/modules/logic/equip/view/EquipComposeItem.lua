module("modules.logic.equip.view.EquipComposeItem", package.seeall)

local var_0_0 = class("EquipComposeItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goequip = gohelper.findChild(arg_1_0.viewGO, "#go_equip")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#txt_num")
	arg_1_0._goavaliable = gohelper.findChild(arg_1_0.viewGO, "#go_avaliable")
	arg_1_0._gosummon = gohelper.findChild(arg_1_0.viewGO, "#go_avaliable/#go_summon")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_avaliable/#go_selected")
	arg_1_0._gonormalblackbg = gohelper.findChild(arg_1_0.viewGO, "#go_normalblackbg")
	arg_1_0._goblackbg = gohelper.findChild(arg_1_0.viewGO, "#go_avaliable/#go_blackbg")

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
	arg_4_0._itemIcon = IconMgr.instance:getCommonEquipIcon(arg_4_0._goequip)

	arg_4_0._itemIcon:hideLockIcon()
	arg_4_0._itemIcon:hideLv(true)
	gohelper.setActive(arg_4_0._gonormalblackbg, true)

	arg_4_0._click = gohelper.getClick(arg_4_0.viewGO)

	arg_4_0._click:AddClickListener(arg_4_0._onClick, arg_4_0)
end

function var_0_0._onClick(arg_5_0)
	if arg_5_0._num < arg_5_0._needNum then
		GameFacade.showToast(ToastEnum.EquipCompose)

		return
	end

	arg_5_0._mo._selected = not arg_5_0._mo._selected

	arg_5_0:_updateSelected()
end

function var_0_0.onDestroyView(arg_6_0)
	arg_6_0._click:RemoveClickListener()
end

function var_0_0._editableAddEvents(arg_7_0)
	return
end

function var_0_0._editableRemoveEvents(arg_8_0)
	return
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._mo = arg_9_1
	arg_9_0._equipId = arg_9_1[3].id
	arg_9_0._needNum = arg_9_1[2]

	arg_9_0._itemIcon:setMOValue(MaterialEnum.MaterialType.Equip, arg_9_0._equipId, 0)

	arg_9_0._num = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, arg_9_1[1])
	arg_9_0._txtnum.text = string.format("%s/%s", arg_9_0._num, arg_9_0._needNum)
	arg_9_0._avalible = arg_9_0._num >= arg_9_0._needNum

	gohelper.setActive(arg_9_0._goavaliable, arg_9_0._avalible)
	gohelper.setActive(arg_9_0._gonormalblackbg, not arg_9_0._avalible)
	arg_9_0:_updateSelected()
end

function var_0_0._updateSelected(arg_10_0)
	if arg_10_0._avalible then
		gohelper.setActive(arg_10_0._gosummon, not arg_10_0._mo._selected)
		gohelper.setActive(arg_10_0._goblackbg, arg_10_0._mo._selected)
		gohelper.setActive(arg_10_0._goselected, arg_10_0._mo._selected)
	end
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	return
end

return var_0_0
