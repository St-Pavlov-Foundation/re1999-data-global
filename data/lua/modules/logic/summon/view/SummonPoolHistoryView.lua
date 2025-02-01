module("modules.logic.summon.view.SummonPoolHistoryView", package.seeall)

slot0 = class("SummonPoolHistoryView", BaseView)
slot0.PAGE_ITEM_NUM = 10

function slot0.onInitView(slot0)
	slot0._simageblur = gohelper.findChildSingleImage(slot0.viewGO, "#simage_blur")
	slot0._simagetop = gohelper.findChildSingleImage(slot0.viewGO, "allbg/#simage_top")
	slot0._simagebottom = gohelper.findChildSingleImage(slot0.viewGO, "allbg/#simage_bottom")
	slot0._txtdes = gohelper.findChildText(slot0.viewGO, "allbg/top/#txt_des")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "allbg/middle/#go_empty")
	slot0._gobottom = gohelper.findChild(slot0.viewGO, "allbg/#go_bottom")
	slot0._btnarrowleft = gohelper.findChildButtonWithAudio(slot0.viewGO, "allbg/#go_bottom/#btn_arrowleft")
	slot0._imagearrowleft = gohelper.findChildImage(slot0.viewGO, "allbg/#go_bottom/#btn_arrowleft/#image_arrowleft")
	slot0._btnarrowright = gohelper.findChildButtonWithAudio(slot0.viewGO, "allbg/#go_bottom/#btn_arrowright")
	slot0._imagearrowright = gohelper.findChildImage(slot0.viewGO, "allbg/#go_bottom/#btn_arrowright/#image_arrowright")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "allbg/#go_bottom/#txt_num")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "allbg/#btn_close")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "bottomright/#txt_time")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnarrowleft:AddClickListener(slot0._btnarrowleftOnClick, slot0)
	slot0._btnarrowright:AddClickListener(slot0._btnarrowrightOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnarrowleft:RemoveClickListener()
	slot0._btnarrowright:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnarrowleftOnClick(slot0)
	if slot0._curPage > 1 then
		slot0._curPage = slot0._curPage - 1

		slot0:_refreshView()
	end
end

function slot0._btnarrowrightOnClick(slot0)
	if slot0._curPage < slot0:_getMaxPage() then
		slot0._curPage = slot0._curPage + 1

		slot0:_refreshView()
	end
end

function slot0._editableInitView(slot0)
	slot0._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	slot0._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))
	gohelper.addUIClickAudio(slot0._btnarrowleft.gameObject, AudioEnum.UI.Play_UI_Pool_History_Page_Switch)
	gohelper.addUIClickAudio(slot0._btnarrowright.gameObject, AudioEnum.UI.Play_UI_Pool_History_Page_Switch)

	slot0._curPage = 1
	slot0._poolTypeId = nil

	slot0:_initListItem()
	slot0:_initPoolType()
end

function slot0.onDestroyView(slot0)
	slot0._simagetop:UnLoadImage()
	slot0._simagebottom:UnLoadImage()
end

function slot0._initPoolType(slot0)
	if SummonPoolHistoryModel.instance:isCanShowByPoolTypeId(SummonPoolHistoryModel.instance:getShowPoolTypeByPoolId(SummonMainModel.instance:getCurId())) then
		slot0._poolTypeId = slot2
	end
end

function slot0._initListItem(slot0)
	if slot0._historyListItems then
		return
	end

	slot0._historyListItems = {}
	slot6 = gohelper.findChild(slot0.viewGO, "allbg/middle/history/item")

	table.insert(slot0._historyListItems, MonoHelper.addNoUpdateLuaComOnceToGo(slot6, SummonPoolHistoryListItem, slot0))

	for slot6 = 2, uv0.PAGE_ITEM_NUM do
		table.insert(slot0._historyListItems, MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot1, gohelper.findChild(slot0.viewGO, "allbg/middle/history"), "item" .. slot6), SummonPoolHistoryListItem, slot0))
	end
end

function slot0._refreshView(slot0)
	gohelper.setActive(slot0._goempty, SummonPoolHistoryModel.instance:getNumByPoolId(slot0._poolTypeId) <= 0)
	gohelper.setActive(slot0._gobottom, slot1 > 0)

	for slot7, slot8 in ipairs(slot0._historyListItems) do
		slot8:onUpdateMO(SummonPoolHistoryModel.instance:getHistoryListByIndexOf((slot0._curPage - 1) * #slot0._historyListItems + 1, #slot0._historyListItems, slot0._poolTypeId)[slot7])
	end

	if slot1 > 0 then
		slot4 = slot0:_getMaxPage()

		ZProj.UGUIHelper.SetColorAlpha(slot0._imagearrowleft, slot0._curPage < 2 and 0.25 or 1)
		ZProj.UGUIHelper.SetColorAlpha(slot0._imagearrowright, slot4 <= slot0._curPage and 0.25 or 1)

		slot0._txtnum.text = slot0._curPage .. "/" .. slot4
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onGetSummonPoolHistoryData, slot0.handleGetHistoryData, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonPoolHistorySelect, slot0._onHandleHistorySelect, slot0)
	slot0:_checkRequese()
	SummonPoolHistoryTypeListModel.instance:initPoolType()

	if not slot0._poolTypeId then
		slot0._poolTypeId = slot1:getFirstId()
	end

	slot1:setSelectId(slot0._poolTypeId)
	slot0:_refreshView()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onGetSummonPoolHistoryData, slot0.handleGetHistoryData, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonPoolHistorySelect, slot0._onHandleHistorySelect, slot0)
end

function slot0._onHandleHistorySelect(slot0)
	if slot0._poolTypeId ~= SummonPoolHistoryTypeListModel.instance:getSelectId() then
		slot0._poolTypeId = slot1
		slot0._curPage = 1

		slot0:_refreshView()
	end
end

function slot0.handleGetHistoryData(slot0)
	if slot0:_getMaxPage() < slot0._curPage then
		slot0._curPage = math.max(1, slot1)
	end

	SummonPoolHistoryTypeListModel.instance:initPoolType()
	slot0:_refreshView()
end

function slot0._getMaxPage(slot0)
	return math.ceil(SummonPoolHistoryModel.instance:getNumByPoolId(slot0._poolTypeId) / uv0.PAGE_ITEM_NUM)
end

function slot0._checkRequese(slot0)
	if not SummonPoolHistoryModel.instance:isDataValidity() then
		SummonPoolHistoryController.instance:request()
	end
end

return slot0
