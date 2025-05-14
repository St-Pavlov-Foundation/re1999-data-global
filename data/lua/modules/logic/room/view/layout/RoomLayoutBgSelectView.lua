module("modules.logic.room.view.layout.RoomLayoutBgSelectView", package.seeall)

local var_0_0 = class("RoomLayoutBgSelectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#go_content/Bg/#txt_title")
	arg_1_0._scrollCoverItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_content/#scroll_CoverItemList")
	arg_1_0._gocoveritem = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_coveritem")
	arg_1_0._simagecover = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_content/#go_coveritem/bg/#simage_cover")
	arg_1_0._txtcovername = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#go_coveritem/bg/covernamebg/#txt_covername")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()

	local var_4_0 = RoomLayoutBgResListModel.instance:getSelectMO()
	local var_4_1 = RoomLayoutListModel.instance:getSelectMO()

	if var_4_0 and var_4_1 and var_4_0.id ~= var_4_1:getCoverId() then
		RoomRpc.instance:sendSetRoomPlanCoverRequest(var_4_1.id, var_4_0.id)
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._viewGOTrs = arg_5_0.viewGO.transform
	arg_5_0._gocontentTrs = arg_5_0._gocontent.transform
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = RoomLayoutListModel.instance:getSelectMO()

	arg_7_0._txttitle.text = var_7_0 and var_7_0.name or ""

	local var_7_1 = RoomLayoutListModel.instance:getSelectMO()

	RoomLayoutBgResListModel.instance:setSelect(var_7_1 and var_7_1:getCoverId())

	if arg_7_0.viewParam and arg_7_0.viewParam.uiWorldPos then
		arg_7_0:layoutAnchor(arg_7_0.viewParam.uiWorldPos, arg_7_0.viewParam.offsetWidth, arg_7_0.viewParam.offsetHeight)
	end
end

function var_0_0.layoutAnchor(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	RoomLayoutHelper.tipLayoutAnchor(arg_8_0._gocontentTrs, arg_8_0._viewGOTrs, arg_8_1, arg_8_2, arg_8_3)
end

function var_0_0.onClose(arg_9_0)
	RoomLayoutController.instance:dispatchEvent(RoomEvent.UICancelLayoutPlanItemTab)
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
