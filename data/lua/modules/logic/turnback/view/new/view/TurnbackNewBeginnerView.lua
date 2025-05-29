module("modules.logic.turnback.view.new.view.TurnbackNewBeginnerView", package.seeall)

local var_0_0 = class("TurnbackNewBeginnerView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gosubview = gohelper.findChild(arg_1_0.viewGO, "#go_subview")
	arg_1_0._gocategory = gohelper.findChild(arg_1_0.viewGO, "#go_category")
	arg_1_0._scrollcategoryitem = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_category/#scroll_categoryitem")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "lefttitle/#txt_time")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshBeginner, arg_2_0.refreshView, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, arg_2_0._refreshRemainTime, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshBeginner, arg_3_0.refreshView, arg_3_0)
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, arg_3_0._refreshRemainTime, arg_3_0)
end

local var_0_1 = {
	[TurnbackEnum.ActivityId.NewSignIn] = ViewName.TurnbackNewSignInView,
	[TurnbackEnum.ActivityId.NewTaskView] = ViewName.TurnbackNewTaskView,
	[TurnbackEnum.ActivityId.NewBenfitView] = ViewName.TurnbackNewBenfitView,
	[TurnbackEnum.ActivityId.NewProgressView] = ViewName.TurnbackNewProgressView,
	[TurnbackEnum.ActivityId.ReviewView] = ViewName.TurnbackReviewView
}

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.turnbackId = TurnbackModel.instance:getCurTurnbackId()

	arg_6_0:refreshView()
end

function var_0_0.refreshView(arg_7_0)
	arg_7_0.allActivityTab = TurnbackConfig.instance:getAllTurnbackSubModules(arg_7_0.turnbackId)

	if arg_7_0.allActivityTab == nil or GameUtil.getTabLen(arg_7_0.allActivityTab) == 0 then
		arg_7_0:closeThis()
	end

	arg_7_0.allActivityTab = TurnbackModel.instance:removeUnExitCategory(arg_7_0.allActivityTab)
	arg_7_0.subViewTab = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0.allActivityTab) do
		local var_7_0 = {
			id = iter_7_1,
			order = iter_7_0,
			config = TurnbackConfig.instance:getTurnbackSubModuleCo(iter_7_1)
		}

		table.insert(arg_7_0.subViewTab, var_7_0)
	end

	TurnbackBeginnerCategoryListModel.instance:setOpenViewTime()
	TurnbackBeginnerCategoryListModel.instance:setCategoryList(arg_7_0.subViewTab)
	arg_7_0:openSubView()
	arg_7_0:_refreshRemainTime()
end

function var_0_0.openSubView(arg_8_0)
	if arg_8_0._viewName then
		ViewMgr.instance:closeView(arg_8_0._viewName, true)
	end

	local var_8_0 = TurnbackModel.instance:getTargetCategoryId(arg_8_0.turnbackId)

	arg_8_0._viewName = var_0_1[var_8_0]

	if var_8_0 ~= 0 then
		TurnbackModel.instance:setTargetCategoryId(var_8_0)
	end

	local var_8_1 = {
		parent = arg_8_0._gosubview,
		actId = var_8_0
	}

	ViewMgr.instance:openView(arg_8_0._viewName, var_8_1, true)

	arg_8_0.viewParam = nil
end

function var_0_0._refreshRemainTime(arg_9_0)
	arg_9_0._txttime.text = TurnbackController.instance:refreshRemainTime()
end

function var_0_0.onClose(arg_10_0)
	if arg_10_0._viewName then
		ViewMgr.instance:closeView(arg_10_0._viewName, true)

		arg_10_0._viewName = nil
	end

	TurnbackModel.instance:setTargetCategoryId(0)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
