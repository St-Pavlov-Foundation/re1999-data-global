module("modules.logic.room.view.record.RoomCritterHandBookBackView", package.seeall)

local var_0_0 = class("RoomCritterHandBookBackView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "bg/#scroll_view")
	arg_1_0._simageback = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#go_show/#simage_back")
	arg_1_0._simageutm = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#go_show/#simage_utm")
	arg_1_0._gobackicon = gohelper.findChild(arg_1_0.viewGO, "bg/#go_show/#simage_back/icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "bg/#go_show/#txt_name")
	arg_1_0._gouse = gohelper.findChild(arg_1_0.viewGO, "bg/#go_use")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "bg/#go_empty")
	arg_1_0._goshow = gohelper.findChild(arg_1_0.viewGO, "bg/#go_show")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/#btn_confirm")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/#btn_close")
	arg_1_0._btnempty = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/maskbg")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "bg/txt_title")
	arg_1_0._scrollview = arg_1_0.viewContainer:getScrollView()

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnempty:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0:addEventCb(RoomHandBookController.instance, RoomHandBookEvent.refreshBack, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnempty:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0:removeEventCb(RoomHandBookController.instance, RoomHandBookEvent.refreshBack, arg_3_0.refreshUI, arg_3_0)
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnconfirmOnClick(arg_5_0)
	local var_5_0 = RoomHandBookModel.instance:getSelectMo().id
	local var_5_1 = RoomHandBookBackModel.instance:getSelectMo()
	local var_5_2 = var_5_1:isEmpty() and 0 or var_5_1.id

	CritterRpc.instance:sendSetCritterBookBackgroundRequest(var_5_0, var_5_2)
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.updateView(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.id
	local var_8_1 = arg_8_1.backgroundId
end

function var_0_0.onOpen(arg_9_0)
	RoomHandBookBackListModel.instance:init()
	arg_9_0:refreshUI()

	local var_9_0 = RoomHandBookBackListModel.instance:getSelectIndex()

	arg_9_0._scrollview:selectCell(var_9_0, true)
end

function var_0_0.refreshUI(arg_10_0)
	local var_10_0 = RoomHandBookBackModel.instance:getSelectMo()
	local var_10_1 = var_10_0 and var_10_0:isEmpty()

	gohelper.setActive(arg_10_0._goempty, var_10_1)
	gohelper.setActive(arg_10_0._goshow, not var_10_1)

	if var_10_0 and not var_10_0:isEmpty() then
		gohelper.setActive(arg_10_0._gobackicon, false)
		arg_10_0._simageutm:LoadImage(ResUrl.getPropItemIcon(var_10_0:getConfig().icon))

		arg_10_0._txtname.text = var_10_0:getConfig().name
	else
		gohelper.setActive(arg_10_0._gobackicon, true)
	end

	local var_10_2 = RoomHandBookModel.instance:getSelectMo()

	if var_10_2 then
		arg_10_0._txttitle.text = string.format(luaLang("critterhandbookbacktitle"), var_10_2:getConfig().name)
	end

	local var_10_3 = var_10_0:checkIsUse()

	gohelper.setActive(arg_10_0._gouse, var_10_3)
	gohelper.setActive(arg_10_0._btnconfirm.gameObject, not var_10_3)
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
