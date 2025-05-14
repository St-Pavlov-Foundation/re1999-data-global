module("modules.logic.turnback.view.TurnbackBeginnerView", package.seeall)

local var_0_0 = class("TurnbackBeginnerView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gosubview = gohelper.findChild(arg_1_0.viewGO, "#go_subview")
	arg_1_0._gocategory = gohelper.findChild(arg_1_0.viewGO, "#go_category")
	arg_1_0._scrollcategoryitem = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_category/#scroll_categoryitem")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "lefttitle/#txt_time")
	arg_1_0._gomonthcard = gohelper.findChild(arg_1_0.viewGO, "#go_monthcard")
	arg_1_0._simagemonthcardicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_monthcard/#simage_monthcard")
	arg_1_0._btnmonthcard = gohelper.findChildButton(arg_1_0.viewGO, "#go_monthcard/#btn_monthcard")
	arg_1_0._txtmonthcard = gohelper.findChildText(arg_1_0.viewGO, "#go_monthcard/#simage_monthcard/#txt_monthcard")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshBeginner, arg_2_0.refreshView, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, arg_2_0._refreshRemainTime, arg_2_0)
	arg_2_0:addEventCb(PayController.instance, PayEvent.PayFinished, arg_2_0._onChargeBuySuccess, arg_2_0)
	arg_2_0._btnmonthcard:AddClickListener(arg_2_0.onClickMonthCard, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshBeginner, arg_3_0.refreshView, arg_3_0)
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, arg_3_0._refreshRemainTime, arg_3_0)
	arg_3_0:removeEventCb(PayController.instance, PayEvent.PayFinished, arg_3_0._onChargeBuySuccess, arg_3_0)
	arg_3_0._btnmonthcard:RemoveClickListener()
end

local var_0_1 = {
	[TurnbackEnum.ActivityId.SignIn] = ViewName.TurnbackSignInView,
	[TurnbackEnum.ActivityId.TaskView] = ViewName.TurnbackTaskView,
	[TurnbackEnum.ActivityId.DungeonShowView] = ViewName.TurnbackDungeonShowView,
	[TurnbackEnum.ActivityId.RewardShowView] = ViewName.TurnbackRewardShowView,
	[TurnbackEnum.ActivityId.RecommendView] = ViewName.TurnbackRecommendView
}

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickMonthCard(arg_5_0)
	if TurnbackModel.instance:getMonthCardShowState() == false then
		return
	end

	logNormal("onClickMonthCard")

	local var_5_0 = TurnbackModel.instance:getCurTurnbackMo().config
	local var_5_1 = StoreModel.instance:getGoodsMO(var_5_0.monthCardAddedId)

	StoreController.instance:openPackageStoreGoodsView(var_5_1)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.turnbackId = arg_7_0.viewParam.turnbackId

	arg_7_0:refreshView()
end

function var_0_0.refreshView(arg_8_0)
	arg_8_0.allActivityTab = TurnbackConfig.instance:getAllTurnbackSubModules(arg_8_0.turnbackId)

	if arg_8_0.allActivityTab == nil or GameUtil.getTabLen(arg_8_0.allActivityTab) == 0 then
		arg_8_0:closeThis()
	end

	arg_8_0.allActivityTab = TurnbackModel.instance:removeUnExitCategory(arg_8_0.allActivityTab)
	arg_8_0.subViewTab = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_0.allActivityTab) do
		local var_8_0 = {
			id = iter_8_1,
			order = iter_8_0,
			config = TurnbackConfig.instance:getTurnbackSubModuleCo(iter_8_1)
		}

		table.insert(arg_8_0.subViewTab, var_8_0)
	end

	TurnbackBeginnerCategoryListModel.instance:setOpenViewTime()
	TurnbackBeginnerCategoryListModel.instance:setCategoryList(arg_8_0.subViewTab)
	arg_8_0:openSubView()
	arg_8_0:_refreshRemainTime()
	arg_8_0:_refreshMonthCardState()
end

function var_0_0.openSubView(arg_9_0)
	if arg_9_0._viewName then
		ViewMgr.instance:closeView(arg_9_0._viewName, true)
	end

	local var_9_0 = TurnbackModel.instance:getTargetCategoryId(arg_9_0.turnbackId)

	arg_9_0._viewName = var_0_1[var_9_0]

	if var_9_0 ~= 0 then
		TurnbackModel.instance:setTargetCategoryId(var_9_0)
	end

	local var_9_1 = {
		parent = arg_9_0._gosubview,
		actId = var_9_0
	}

	ViewMgr.instance:openView(arg_9_0._viewName, var_9_1, true)

	arg_9_0.viewParam = nil
end

function var_0_0._refreshRemainTime(arg_10_0)
	arg_10_0._txttime.text = TurnbackController.instance:refreshRemainTime()
end

function var_0_0._onChargeBuySuccess(arg_11_0)
	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
	arg_11_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_11_0.onGetTurnBackInfo, arg_11_0)
end

function var_0_0.onGetTurnBackInfo(arg_12_0)
	arg_12_0:_refreshMonthCardState()
	arg_12_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_12_0.onGetTurnBackInfo, arg_12_0)
end

function var_0_0._refreshMonthCardState(arg_13_0)
	local var_13_0 = TurnbackModel.instance:getMonthCardShowState()

	gohelper.setActive(arg_13_0._gomonthcard, var_13_0)
end

function var_0_0.onClose(arg_14_0)
	if arg_14_0._viewName then
		ViewMgr.instance:closeView(arg_14_0._viewName, true)

		arg_14_0._viewName = nil
	end

	TurnbackModel.instance:setTargetCategoryId(0)
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
