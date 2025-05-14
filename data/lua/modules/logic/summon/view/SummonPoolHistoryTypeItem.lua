module("modules.logic.summon.view.SummonPoolHistoryTypeItem", package.seeall)

local var_0_0 = class("SummonPoolHistoryTypeItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
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
	arg_4_0._gounselect = gohelper.findChild(arg_4_0.viewGO, "go_unselect")
	arg_4_0._txtunname = gohelper.findChildText(arg_4_0.viewGO, "go_unselect/txt_name")
	arg_4_0._goselect = gohelper.findChild(arg_4_0.viewGO, "go_select")
	arg_4_0._txtname = gohelper.findChildText(arg_4_0.viewGO, "go_select/txt_name")
	arg_4_0._btnitem = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "btn_item")
end

function var_0_0._editableAddEvents(arg_5_0)
	arg_5_0._btnitem:AddClickListener(arg_5_0._onClick, arg_5_0)
end

function var_0_0._editableRemoveEvents(arg_6_0)
	arg_6_0._btnitem:RemoveClickListener()
end

function var_0_0._onClick(arg_7_0)
	if arg_7_0._isSelect then
		return
	end

	SummonPoolHistoryTypeListModel.instance:setSelectId(arg_7_0._mo.id)
	SummonController.instance:dispatchEvent(SummonEvent.onSummonPoolHistorySelect, arg_7_0._mo.id)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Pool_History_Type_Switch)
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1
	arg_8_0._txtunname.text = arg_8_1.config.name
	arg_8_0._txtname.text = arg_8_1.config.name
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
