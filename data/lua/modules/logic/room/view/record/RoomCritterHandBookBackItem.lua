module("modules.logic.room.view.record.RoomCritterHandBookBackItem", package.seeall)

local var_0_0 = class("RoomCritterHandBookBackItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageitem = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_item")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._gouse = gohelper.findChild(arg_1_0.viewGO, "#go_use")
	arg_1_0._gonew = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_new")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_empty")
	arg_1_0._gonoraml = gohelper.findChild(arg_1_0.viewGO, "#go_normal")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0:addEventCb(RoomHandBookController.instance, RoomHandBookEvent.refreshBack, arg_2_0.refreshUse, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0:removeEventCb(RoomHandBookController.instance, RoomHandBookEvent.refreshBack, arg_3_0.refreshUse, arg_3_0)
end

function var_0_0._btnclickOnClick(arg_4_0)
	arg_4_0._view:selectCell(arg_4_0._index, true)
	RoomHandBookBackModel.instance:setSelectMo(arg_4_0._mo)
	RoomHandBookController.instance:dispatchEvent(RoomHandBookEvent.refreshBack)
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1
	arg_8_0._id = arg_8_1.id
	arg_8_0._config = arg_8_1:getConfig()
	arg_8_0._isuse = arg_8_1:checkIsUse()
	arg_8_0._isEmpty = arg_8_1:isEmpty()

	gohelper.setActive(arg_8_0._goempty, arg_8_0._isEmpty)
	gohelper.setActive(arg_8_0._gonoraml, not arg_8_0._isEmpty)
	gohelper.setActive(arg_8_0._gouse, arg_8_0._isuse)
	gohelper.setActive(arg_8_0._gonew, arg_8_1:checkNew())
	gohelper.setActive(arg_8_0._simageitem.gameObject, not arg_8_0._isEmpty)

	if not arg_8_0._isEmpty then
		arg_8_0._simageitem:LoadImage(ResUrl.getPropItemIcon(arg_8_0._config.icon))
	end
end

function var_0_0.refreshUse(arg_9_0)
	arg_9_0._isuse = arg_9_0._mo:checkIsUse()

	gohelper.setActive(arg_9_0._gouse, arg_9_0._isuse)
end

function var_0_0.onSelect(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goselect, arg_10_1)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
