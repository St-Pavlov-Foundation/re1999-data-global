module("modules.logic.activity.view.ActivityNormalView", package.seeall)

local var_0_0 = class("ActivityNormalView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gosubview = gohelper.findChild(arg_1_0.viewGO, "#go_subview")
	arg_1_0._scrollactivitylist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_activitylist")
	arg_1_0._gorule = gohelper.findChild(arg_1_0.viewGO, "#go_rule")
	arg_1_0._scrollruledesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_rule/#scroll_ruledesc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._viewName = nil
end

local var_0_1 = {}

function var_0_0.onOpen(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_open)
	arg_5_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_5_0._refreshView, arg_5_0)
	arg_5_0:_refreshView()
	NavigateMgr.instance:addEscape(ViewName.ActivityNormalView, arg_5_0._btncloseOnClick, arg_5_0)
end

function var_0_0._refreshView(arg_6_0)
	local var_6_0 = ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Normal)

	if not var_6_0 or not next(var_6_0) then
		arg_6_0:closeThis()
	end

	local var_6_1 = {}

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		local var_6_2 = {
			id = iter_6_1,
			co = ActivityConfig.instance:getActivityCo(iter_6_1),
			type = ActivityEnum.ActivityType.Normal
		}

		table.insert(var_6_1, var_6_2)
	end

	ActivityNormalCategoryListModel.instance:setCategoryList(var_6_1)
	arg_6_0:_openSubView()
end

function var_0_0._openSubView(arg_7_0)
	if ViewMgr.instance:isOpen(ViewName.ActivityTipView) then
		ViewMgr.instance:closeView(ViewName.ActivityTipView, true)
	end

	if arg_7_0._viewName then
		ViewMgr.instance:closeView(arg_7_0._viewName, true)
	end

	local var_7_0 = ActivityModel.instance:getTargetActivityCategoryId(ActivityEnum.ActivityType.Normal)

	arg_7_0._viewName = var_0_1[var_7_0]

	if not arg_7_0._viewName then
		return
	end

	local var_7_1 = ActivityConfig.instance:getActivityCo(var_7_0).banner

	if not var_7_1 or var_7_1 == "" then
		gohelper.setActive(arg_7_0._simagebg.gameObject, false)
	else
		gohelper.setActive(arg_7_0._simagebg.gameObject, true)
		arg_7_0._simagebg:LoadImage(ResUrl.getActivityBg(var_7_1))
	end

	ViewMgr.instance:openView(arg_7_0._viewName, arg_7_0._gosubview, true)
end

function var_0_0.closeSubView(arg_8_0)
	if arg_8_0._viewName then
		ViewMgr.instance:closeView(arg_8_0._viewName, true)

		arg_8_0._viewName = nil
	end
end

function var_0_0.onClose(arg_9_0)
	ActivityModel.instance:setTargetActivityCategoryId(0)
	arg_9_0:closeSubView()
	arg_9_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_9_0._refreshView, arg_9_0)
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
