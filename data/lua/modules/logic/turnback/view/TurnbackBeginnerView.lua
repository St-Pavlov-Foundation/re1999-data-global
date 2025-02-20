module("modules.logic.turnback.view.TurnbackBeginnerView", package.seeall)

slot0 = class("TurnbackBeginnerView", BaseView)

function slot0.onInitView(slot0)
	slot0._gosubview = gohelper.findChild(slot0.viewGO, "#go_subview")
	slot0._gocategory = gohelper.findChild(slot0.viewGO, "#go_category")
	slot0._scrollcategoryitem = gohelper.findChildScrollRect(slot0.viewGO, "#go_category/#scroll_categoryitem")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "lefttitle/#txt_time")
	slot0._gomonthcard = gohelper.findChild(slot0.viewGO, "#go_monthcard")
	slot0._simagemonthcardicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_monthcard/#simage_monthcard")
	slot0._btnmonthcard = gohelper.findChildButton(slot0.viewGO, "#go_monthcard/#btn_monthcard")
	slot0._txtmonthcard = gohelper.findChildText(slot0.viewGO, "#go_monthcard/#simage_monthcard/#txt_monthcard")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshBeginner, slot0.refreshView, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, slot0._refreshRemainTime, slot0)
	slot0:addEventCb(PayController.instance, PayEvent.PayFinished, slot0._onChargeBuySuccess, slot0)
	slot0._btnmonthcard:AddClickListener(slot0.onClickMonthCard, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshBeginner, slot0.refreshView, slot0)
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, slot0._refreshRemainTime, slot0)
	slot0:removeEventCb(PayController.instance, PayEvent.PayFinished, slot0._onChargeBuySuccess, slot0)
	slot0._btnmonthcard:RemoveClickListener()
end

slot1 = {
	[TurnbackEnum.ActivityId.SignIn] = ViewName.TurnbackSignInView,
	[TurnbackEnum.ActivityId.TaskView] = ViewName.TurnbackTaskView,
	[TurnbackEnum.ActivityId.DungeonShowView] = ViewName.TurnbackDungeonShowView,
	[TurnbackEnum.ActivityId.RewardShowView] = ViewName.TurnbackRewardShowView,
	[TurnbackEnum.ActivityId.RecommendView] = ViewName.TurnbackRecommendView
}

function slot0._editableInitView(slot0)
end

function slot0.onClickMonthCard(slot0)
	if TurnbackModel.instance:getMonthCardShowState() == false then
		return
	end

	logNormal("onClickMonthCard")
	StoreController.instance:openPackageStoreGoodsView(StoreModel.instance:getGoodsMO(TurnbackModel.instance:getCurTurnbackMo().config.monthCardAddedId))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.turnbackId = slot0.viewParam.turnbackId

	slot0:refreshView()
end

function slot0.refreshView(slot0)
	slot0.allActivityTab = TurnbackConfig.instance:getAllTurnbackSubModules(slot0.turnbackId)

	if slot0.allActivityTab == nil or GameUtil.getTabLen(slot0.allActivityTab) == 0 then
		slot0:closeThis()
	end

	slot4 = slot0.allActivityTab
	slot0.allActivityTab = TurnbackModel.instance:removeUnExitCategory(slot4)
	slot0.subViewTab = {}

	for slot4, slot5 in pairs(slot0.allActivityTab) do
		table.insert(slot0.subViewTab, {
			id = slot5,
			order = slot4,
			config = TurnbackConfig.instance:getTurnbackSubModuleCo(slot5)
		})
	end

	TurnbackBeginnerCategoryListModel.instance:setOpenViewTime()
	TurnbackBeginnerCategoryListModel.instance:setCategoryList(slot0.subViewTab)
	slot0:openSubView()
	slot0:_refreshRemainTime()
	slot0:_refreshMonthCardState()
end

function slot0.openSubView(slot0)
	if slot0._viewName then
		ViewMgr.instance:closeView(slot0._viewName, true)
	end

	slot1 = TurnbackModel.instance:getTargetCategoryId(slot0.turnbackId)
	slot0._viewName = uv0[slot1]

	if slot1 ~= 0 then
		TurnbackModel.instance:setTargetCategoryId(slot1)
	end

	ViewMgr.instance:openView(slot0._viewName, {
		parent = slot0._gosubview,
		actId = slot1
	}, true)

	slot0.viewParam = nil
end

function slot0._refreshRemainTime(slot0)
	slot0._txttime.text = TurnbackController.instance:refreshRemainTime()
end

function slot0._onChargeBuySuccess(slot0)
	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, slot0.onGetTurnBackInfo, slot0)
end

function slot0.onGetTurnBackInfo(slot0)
	slot0:_refreshMonthCardState()
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, slot0.onGetTurnBackInfo, slot0)
end

function slot0._refreshMonthCardState(slot0)
	gohelper.setActive(slot0._gomonthcard, TurnbackModel.instance:getMonthCardShowState())
end

function slot0.onClose(slot0)
	if slot0._viewName then
		ViewMgr.instance:closeView(slot0._viewName, true)

		slot0._viewName = nil
	end

	TurnbackModel.instance:setTargetCategoryId(0)
end

function slot0.onDestroyView(slot0)
end

return slot0
