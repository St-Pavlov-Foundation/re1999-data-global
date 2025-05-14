module("modules.logic.room.view.RoomInformReportTypeItem", package.seeall)

local var_0_0 = class("RoomInformReportTypeItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn_click")
	arg_1_0.gonormalicon = gohelper.findChild(arg_1_0.viewGO, "go_normalicon")
	arg_1_0.goselecticon = gohelper.findChild(arg_1_0.viewGO, "go_selecticon")
	arg_1_0.txtinform = gohelper.findChildText(arg_1_0.viewGO, "txt_inform")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	RoomReportTypeListModel.instance:setSelectId(arg_4_0.reportMo.id)
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onSelect(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0.gonormalicon, not arg_6_1)
	gohelper.setActive(arg_6_0.goselecticon, arg_6_1)
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0.reportMo = arg_7_1
	arg_7_0.txtinform.text = arg_7_0.reportMo.desc
end

function var_0_0.getMo(arg_8_0)
	return arg_8_0.reportMo
end

return var_0_0
