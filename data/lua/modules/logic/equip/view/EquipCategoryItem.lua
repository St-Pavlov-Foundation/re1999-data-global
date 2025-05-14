module("modules.logic.equip.view.EquipCategoryItem", package.seeall)

local var_0_0 = class("EquipCategoryItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gounselected = gohelper.findChild(arg_1_0.viewGO, "#go_unselected")
	arg_1_0._txtitemcn1 = gohelper.findChildText(arg_1_0.viewGO, "#go_unselected/#txt_itemcn1")
	arg_1_0._txtitemen1 = gohelper.findChildText(arg_1_0.viewGO, "#go_unselected/#txt_itemen1")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")
	arg_1_0._txtitemcn2 = gohelper.findChildText(arg_1_0.viewGO, "#go_selected/#txt_itemcn2")
	arg_1_0._txtitemen2 = gohelper.findChildText(arg_1_0.viewGO, "#go_selected/#txt_itemen2")

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
	arg_4_0._click = gohelper.getClickWithAudio(arg_4_0.viewGO)
end

function var_0_0._editableAddEvents(arg_5_0)
	arg_5_0._click:AddClickListener(arg_5_0._onClick, arg_5_0)
end

function var_0_0._editableRemoveEvents(arg_6_0)
	arg_6_0._click:RemoveClickListener()
end

function var_0_0._onClick(arg_7_0)
	if arg_7_0._isSelect then
		return
	end

	arg_7_0._view:selectCell(arg_7_0._index, true)

	EquipCategoryListModel.instance.curCategoryIndex = arg_7_0._mo.resIndex

	arg_7_0._view.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_7_0._mo.resIndex)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_transverse_tabs_click)
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1
	arg_8_0._txtitemcn1.text = arg_8_1.cnName
	arg_8_0._txtitemcn2.text = arg_8_1.cnName
	arg_8_0._txtitemen1.text = arg_8_1.enName
	arg_8_0._txtitemen2.text = arg_8_1.enName
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	arg_9_0._isSelect = arg_9_1

	arg_9_0._gounselected:SetActive(not arg_9_0._isSelect)
	arg_9_0._goselected:SetActive(arg_9_0._isSelect)
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
