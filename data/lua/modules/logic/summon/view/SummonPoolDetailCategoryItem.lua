module("modules.logic.summon.view.SummonPoolDetailCategoryItem", package.seeall)

local var_0_0 = class("SummonPoolDetailCategoryItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gounselect = gohelper.findChild(arg_1_0.viewGO, "#go_unselect")
	arg_1_0._txttitle1 = gohelper.findChildText(arg_1_0.viewGO, "#go_unselect/#txt_title1")
	arg_1_0._txttitle1En = gohelper.findChildText(arg_1_0.viewGO, "#go_unselect/#txt_title1En")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._txttitle2 = gohelper.findChildText(arg_1_0.viewGO, "#go_select/#txt_title2")
	arg_1_0._txttitle2En = gohelper.findChildText(arg_1_0.viewGO, "#go_select/#txt_title2En")

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
	arg_7_0._view.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 1, arg_7_0._mo.resIndex)
	SummonController.instance:dispatchEvent(SummonEvent.onSummonPoolDetailCategoryClick, arg_7_0._mo.resIndex)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1
	arg_8_0._txttitle1.text = arg_8_1.cnName
	arg_8_0._txttitle2.text = arg_8_1.cnName
	arg_8_0._txttitle1En.text = arg_8_1.enName
	arg_8_0._txttitle2En.text = arg_8_1.enName
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	arg_9_0._isSelect = arg_9_1

	arg_9_0._gounselect:SetActive(not arg_9_0._isSelect)
	arg_9_0._goselect:SetActive(arg_9_0._isSelect)
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
