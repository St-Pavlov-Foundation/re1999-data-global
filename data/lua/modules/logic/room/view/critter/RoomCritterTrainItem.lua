module("modules.logic.room.view.critter.RoomCritterTrainItem", package.seeall)

local var_0_0 = class("RoomCritterTrainItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goicon = gohelper.findChild(arg_1_0.viewGO, "#go_icon")
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "#go_info")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#txt_name")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._scrollbase = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_base")
	arg_1_0._gobaseitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_base/viewport/content/#go_baseitem")
	arg_1_0._btnclickitem = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_clickitem")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_detail")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnclickitem:AddClickListener(arg_2_0._btnclickitemOnClick, arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnclickitem:RemoveClickListener()
	arg_3_0._btndetail:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	arg_4_0:_btnclickitemOnClick()
end

function var_0_0._btndetailOnClick(arg_5_0)
	CritterController.instance:openRoomCritterDetailView(true, arg_5_0._mo, true)
end

function var_0_0._btnclickitemOnClick(arg_6_0)
	if arg_6_0._view and arg_6_0._view.viewContainer then
		arg_6_0._view.viewContainer:dispatchEvent(CritterEvent.UITrainSelectCritter, arg_6_0:getDataMO())
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._goScrollbaseContent = gohelper.findChild(arg_7_0.viewGO, "#scroll_base/viewport/content")
end

function var_0_0._editableAddEvents(arg_8_0)
	return
end

function var_0_0._editableRemoveEvents(arg_9_0)
	return
end

function var_0_0.getDataMO(arg_10_0)
	return arg_10_0._mo
end

function var_0_0.onUpdateMO(arg_11_0, arg_11_1)
	arg_11_0._mo = arg_11_1

	arg_11_0:refreshUI()
end

function var_0_0.onSelect(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._goselected, arg_12_1)
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

function var_0_0.refreshUI(arg_14_0)
	local var_14_0 = arg_14_0._mo

	if var_14_0 then
		if not arg_14_0.critterIcon then
			arg_14_0.critterIcon = IconMgr.instance:getCommonCritterIcon(arg_14_0._goicon)
		end

		arg_14_0.critterIcon:setMOValue(var_14_0:getId(), var_14_0:getDefineId())

		arg_14_0._txtname.text = var_14_0:getName()

		arg_14_0:_refreshLineLinkUI()
	end
end

function var_0_0._refreshLineLinkUI(arg_15_0)
	if arg_15_0._mo then
		arg_15_0._dataList = arg_15_0._mo:getAttributeInfos()

		local var_15_0 = arg_15_0._goScrollbaseContent
		local var_15_1 = arg_15_0._gobaseitem

		gohelper.CreateObjList(arg_15_0, arg_15_0._onCritterArrComp, arg_15_0._dataList, var_15_0, var_15_1, RoomCritterAttrScrollCell)
	end
end

function var_0_0._onCritterArrComp(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_1:onUpdateMO(arg_16_2)

	if not arg_16_1._view then
		arg_16_1._view = arg_16_0._view
	end
end

var_0_0.prefabPath = "ui/viewres/room/critter/roomcrittertrainitem.prefab"

return var_0_0
