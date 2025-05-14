module("modules.logic.room.view.layout.RoomLayoutItemTips", package.seeall)

local var_0_0 = class("RoomLayoutItemTips", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#go_content/Bg/#txt_title")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_content/#scroll_ItemList")
	arg_1_0._gonormalitem = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_normalitem")
	arg_1_0._gobuildingicon = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_normalitem/#go_buildingicon")
	arg_1_0._godikuaiicon = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_normalitem/#go_dikuaiicon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#go_normalitem/#txt_name")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#go_normalitem/#txt_num")
	arg_1_0._txtdegree = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#go_normalitem/#txt_degree")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(RoomMapController.instance, RoomEvent.NewBuildingPush, arg_2_0.onGainItem, arg_2_0)
	arg_2_0:addEventCb(RoomMapController.instance, RoomEvent.NewBlockPackagePush, arg_2_0.onGainItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(RoomMapController.instance, RoomEvent.NewBuildingPush, arg_3_0.onGainItem, arg_3_0)
	arg_3_0:removeEventCb(RoomMapController.instance, RoomEvent.NewBlockPackagePush, arg_3_0.onGainItem, arg_3_0)
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onGainItem(arg_5_0)
	RoomLayoutItemListModel.instance:resortList()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._viewGOTrs = arg_6_0.viewGO.transform
	arg_6_0._gocontentTrs = arg_6_0._gocontent.transform
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	local var_8_0 = arg_8_0.viewContainer:getTipsHeight()

	recthelper.setHeight(arg_8_0._gocontentTrs, var_8_0)

	if arg_8_0.viewParam then
		if arg_8_0.viewParam.titleStr then
			arg_8_0._txttitle.text = arg_8_0.viewParam.titleStr
		end

		if arg_8_0.viewParam.uiWorldPos then
			arg_8_0:layoutAnchor(arg_8_0.viewParam.uiWorldPos, arg_8_0.viewParam.offsetWidth, arg_8_0.viewParam.offsetHeight)
		end
	end
end

function var_0_0.layoutAnchor(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	RoomLayoutHelper.tipLayoutAnchor(arg_9_0._gocontentTrs, arg_9_0._viewGOTrs, arg_9_1, arg_9_2, arg_9_3)
end

function var_0_0.onClose(arg_10_0)
	RoomLayoutController.instance:dispatchEvent(RoomEvent.UICancelLayoutPlanItemTab)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
