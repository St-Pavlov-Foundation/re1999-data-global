module("modules.logic.summon.view.SummonPoolHistoryView", package.seeall)

local var_0_0 = class("SummonPoolHistoryView", BaseView)

var_0_0.PAGE_ITEM_NUM = 10

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_blur")
	arg_1_0._simagetop = gohelper.findChildSingleImage(arg_1_0.viewGO, "allbg/#simage_top")
	arg_1_0._simagebottom = gohelper.findChildSingleImage(arg_1_0.viewGO, "allbg/#simage_bottom")
	arg_1_0._txtdes = gohelper.findChildText(arg_1_0.viewGO, "allbg/top/#txt_des")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "allbg/middle/#go_empty")
	arg_1_0._gobottom = gohelper.findChild(arg_1_0.viewGO, "allbg/#go_bottom")
	arg_1_0._btnarrowleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "allbg/#go_bottom/#btn_arrowleft")
	arg_1_0._imagearrowleft = gohelper.findChildImage(arg_1_0.viewGO, "allbg/#go_bottom/#btn_arrowleft/#image_arrowleft")
	arg_1_0._btnarrowright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "allbg/#go_bottom/#btn_arrowright")
	arg_1_0._imagearrowright = gohelper.findChildImage(arg_1_0.viewGO, "allbg/#go_bottom/#btn_arrowright/#image_arrowright")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "allbg/#go_bottom/#txt_num")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "allbg/#btn_close")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "bottomright/#txt_time")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnarrowleft:AddClickListener(arg_2_0._btnarrowleftOnClick, arg_2_0)
	arg_2_0._btnarrowright:AddClickListener(arg_2_0._btnarrowrightOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnarrowleft:RemoveClickListener()
	arg_3_0._btnarrowright:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnarrowleftOnClick(arg_5_0)
	if arg_5_0._curPage > 1 then
		arg_5_0._curPage = arg_5_0._curPage - 1

		arg_5_0:_refreshView()
	end
end

function var_0_0._btnarrowrightOnClick(arg_6_0)
	if arg_6_0:_getMaxPage() > arg_6_0._curPage then
		arg_6_0._curPage = arg_6_0._curPage + 1

		arg_6_0:_refreshView()
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	arg_7_0._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))
	gohelper.addUIClickAudio(arg_7_0._btnarrowleft.gameObject, AudioEnum.UI.Play_UI_Pool_History_Page_Switch)
	gohelper.addUIClickAudio(arg_7_0._btnarrowright.gameObject, AudioEnum.UI.Play_UI_Pool_History_Page_Switch)

	arg_7_0._curPage = 1
	arg_7_0._poolTypeId = nil

	arg_7_0:_initListItem()
	arg_7_0:_initPoolType()
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._simagetop:UnLoadImage()
	arg_8_0._simagebottom:UnLoadImage()
end

function var_0_0._initPoolType(arg_9_0)
	local var_9_0 = SummonMainModel.instance:getCurId()
	local var_9_1 = SummonPoolHistoryModel.instance:getShowPoolTypeByPoolId(var_9_0)

	if SummonPoolHistoryModel.instance:isCanShowByPoolTypeId(var_9_1) then
		arg_9_0._poolTypeId = var_9_1
	end
end

function var_0_0._initListItem(arg_10_0)
	if arg_10_0._historyListItems then
		return
	end

	local var_10_0 = gohelper.findChild(arg_10_0.viewGO, "allbg/middle/history/item")
	local var_10_1 = gohelper.findChild(arg_10_0.viewGO, "allbg/middle/history")

	arg_10_0._historyListItems = {}

	table.insert(arg_10_0._historyListItems, MonoHelper.addNoUpdateLuaComOnceToGo(var_10_0, SummonPoolHistoryListItem, arg_10_0))

	for iter_10_0 = 2, var_0_0.PAGE_ITEM_NUM do
		local var_10_2 = gohelper.clone(var_10_0, var_10_1, "item" .. iter_10_0)

		table.insert(arg_10_0._historyListItems, MonoHelper.addNoUpdateLuaComOnceToGo(var_10_2, SummonPoolHistoryListItem, arg_10_0))
	end
end

function var_0_0._refreshView(arg_11_0)
	local var_11_0 = SummonPoolHistoryModel.instance:getNumByPoolId(arg_11_0._poolTypeId)

	gohelper.setActive(arg_11_0._goempty, not (var_11_0 > 0))
	gohelper.setActive(arg_11_0._gobottom, var_11_0 > 0)

	local var_11_1 = (arg_11_0._curPage - 1) * #arg_11_0._historyListItems + 1
	local var_11_2 = SummonPoolHistoryModel.instance:getHistoryListByIndexOf(var_11_1, #arg_11_0._historyListItems, arg_11_0._poolTypeId)

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._historyListItems) do
		iter_11_1:onUpdateMO(var_11_2[iter_11_0])
	end

	if var_11_0 > 0 then
		local var_11_3 = arg_11_0:_getMaxPage()

		ZProj.UGUIHelper.SetColorAlpha(arg_11_0._imagearrowleft, arg_11_0._curPage < 2 and 0.25 or 1)
		ZProj.UGUIHelper.SetColorAlpha(arg_11_0._imagearrowright, var_11_3 <= arg_11_0._curPage and 0.25 or 1)

		arg_11_0._txtnum.text = arg_11_0._curPage .. "/" .. var_11_3
	end
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0:addEventCb(SummonController.instance, SummonEvent.onGetSummonPoolHistoryData, arg_13_0.handleGetHistoryData, arg_13_0)
	arg_13_0:addEventCb(SummonController.instance, SummonEvent.onSummonPoolHistorySelect, arg_13_0._onHandleHistorySelect, arg_13_0)
	arg_13_0:_checkRequese()

	local var_13_0 = SummonPoolHistoryTypeListModel.instance

	var_13_0:initPoolType()

	if not arg_13_0._poolTypeId then
		arg_13_0._poolTypeId = var_13_0:getFirstId()
	end

	var_13_0:setSelectId(arg_13_0._poolTypeId)
	arg_13_0:_refreshView()
end

function var_0_0.onClose(arg_14_0)
	arg_14_0:removeEventCb(SummonController.instance, SummonEvent.onGetSummonPoolHistoryData, arg_14_0.handleGetHistoryData, arg_14_0)
	arg_14_0:removeEventCb(SummonController.instance, SummonEvent.onSummonPoolHistorySelect, arg_14_0._onHandleHistorySelect, arg_14_0)
end

function var_0_0._onHandleHistorySelect(arg_15_0)
	local var_15_0 = SummonPoolHistoryTypeListModel.instance:getSelectId()

	if arg_15_0._poolTypeId ~= var_15_0 then
		arg_15_0._poolTypeId = var_15_0
		arg_15_0._curPage = 1

		arg_15_0:_refreshView()
	end
end

function var_0_0.handleGetHistoryData(arg_16_0)
	local var_16_0 = arg_16_0:_getMaxPage()

	if var_16_0 < arg_16_0._curPage then
		arg_16_0._curPage = math.max(1, var_16_0)
	end

	SummonPoolHistoryTypeListModel.instance:initPoolType()
	arg_16_0:_refreshView()
end

function var_0_0._getMaxPage(arg_17_0)
	local var_17_0 = SummonPoolHistoryModel.instance:getNumByPoolId(arg_17_0._poolTypeId)

	return (math.ceil(var_17_0 / var_0_0.PAGE_ITEM_NUM))
end

function var_0_0._checkRequese(arg_18_0)
	if not SummonPoolHistoryModel.instance:isDataValidity() then
		SummonPoolHistoryController.instance:request()
	end
end

return var_0_0
