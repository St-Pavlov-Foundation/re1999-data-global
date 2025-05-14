module("modules.logic.room.view.debug.RoomDebugBuildingItem", package.seeall)

local var_0_0 = class("RoomDebugBuildingItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtbuildingid = gohelper.findChildText(arg_1_0.viewGO, "#txt_buildingid")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")

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
	RoomDebugBuildingListModel.instance:setSelect(arg_4_0._mo.id)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._isSelect = false

	gohelper.addUIClickAudio(arg_5_0._btnclick.gameObject, AudioEnum.UI.UI_Common_Click)
end

function var_0_0._refreshUI(arg_6_0)
	arg_6_0._txtbuildingid.text = arg_6_0._mo.id
	arg_6_0._txtname.text = arg_6_0._mo.config.name
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0._goselect, arg_7_0._isSelect)

	arg_7_0._mo = arg_7_1

	arg_7_0:_refreshUI()
end

function var_0_0.onSelect(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._goselect, arg_8_1)

	arg_8_0._isSelect = arg_8_1
end

function var_0_0.onDestroy(arg_9_0)
	return
end

return var_0_0
