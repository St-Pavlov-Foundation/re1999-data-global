module("modules.logic.activitywelfare.view.ActivityWelfareView", package.seeall)

local var_0_0 = class("ActivityWelfareView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocategory = gohelper.findChild(arg_1_0.viewGO, "#go_category")
	arg_1_0._scrollitem = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_category/#scroll_categoryitem")
	arg_1_0._gosubview = gohelper.findChild(arg_1_0.viewGO, "#go_subview")

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
	return
end

local var_0_1 = {
	[ActivityEnum.Activity.NewWelfare] = ViewName.NewWelfareView,
	[ActivityEnum.Activity.NoviceSign] = ViewName.ActivityNoviceSignView,
	[ActivityEnum.Activity.StoryShow] = ViewName.ActivityStoryShowView,
	[ActivityEnum.Activity.ClassShow] = ViewName.ActivityClassShowView,
	[ActivityEnum.Activity.V2a7_NewInsight] = ViewName.ActivityInsightShowView_2_7,
	[ActivityEnum.Activity.V2a7_SelfSelectSix2] = ViewName.V2a7_SelfSelectSix_FullView
}

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_open)
	arg_6_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_6_0._refreshView, arg_6_0)
	arg_6_0:addEventCb(ActivityController.instance, ActivityEvent.SetBannerViewCategoryListInteract, arg_6_0.setCategoryListInteractable, arg_6_0)
	arg_6_0:addEventCb(ActivityController.instance, ActivityEvent.SwitchWelfareActivity, arg_6_0._openSubView, arg_6_0)
	arg_6_0:_refreshView()
end

function var_0_0._refreshView(arg_7_0)
	local var_7_0 = ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Welfare)

	if not var_7_0 or not next(var_7_0) then
		arg_7_0:closeThis()
	end

	ActivityModel.instance:removeFinishedWelfare(var_7_0)

	local var_7_1 = arg_7_0.data and tabletool.copy(arg_7_0.data) or nil
	local var_7_2 = {}

	arg_7_0.data = {}

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		local var_7_3 = {
			id = iter_7_1,
			co = ActivityConfig.instance:getActivityCo(iter_7_1),
			type = ActivityEnum.ActivityType.Welfare
		}

		table.insert(arg_7_0.data, var_7_3)

		var_7_2[iter_7_1] = var_7_3
	end

	ActivityWelfareListModel.instance:setOpenViewTime()

	local var_7_4 = var_7_1 == nil

	if var_7_1 ~= nil then
		if #var_7_1 ~= #arg_7_0.data then
			var_7_4 = true
		else
			for iter_7_2, iter_7_3 in ipairs(var_7_1) do
				if not var_7_2[iter_7_3.id] then
					var_7_4 = true

					break
				end
			end
		end
	end

	if not var_7_4 and arg_7_0._viewName then
		local var_7_5 = ViewMgr.instance:getContainer(arg_7_0._viewName)

		if var_7_5 then
			ViewMgr.instance:openView(arg_7_0._viewName, var_7_5.viewParam, true)

			return
		end
	end

	ActivityWelfareListModel.instance:setCategoryList(arg_7_0.data)
	arg_7_0:_openSubView()
end

function var_0_0._openSubView(arg_8_0)
	if arg_8_0._viewName then
		ViewMgr.instance:closeView(arg_8_0._viewName, true)
	end

	local var_8_0 = ActivityModel.instance:getTargetActivityCategoryId(ActivityEnum.ActivityType.Welfare)

	arg_8_0._viewName = var_0_1[var_8_0]

	if not arg_8_0._viewName then
		return
	end

	if var_8_0 == ActivityEnum.Activity.StoryShow or var_8_0 == ActivityEnum.Activity.ClassShow then
		arg_8_0:setCategoryRedDotData(var_8_0)
	end

	arg_8_0.viewContainer:hideHelp()

	local var_8_1 = {
		parent = arg_8_0._gosubview,
		actId = var_8_0,
		root = arg_8_0.viewGO
	}

	ViewMgr.instance:openView(arg_8_0._viewName, var_8_1, true)
end

function var_0_0.setCategoryRedDotData(arg_9_0, arg_9_1)
	local var_9_0 = PlayerPrefsKey.FirstEnterActivityShow .. "#" .. tostring(arg_9_1) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setString(var_9_0, "hasEnter")

	return var_9_0
end

function var_0_0.closeSubView(arg_10_0)
	if arg_10_0._viewName then
		ViewMgr.instance:closeView(arg_10_0._viewName, true)

		arg_10_0._viewName = nil
	end
end

function var_0_0.onClose(arg_11_0)
	ActivityModel.instance:setTargetActivityCategoryId(0)
	arg_11_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_11_0._refreshView, arg_11_0)
	arg_11_0:removeEventCb(ActivityController.instance, ActivityEvent.SetBannerViewCategoryListInteract, arg_11_0.setCategoryListInteractable, arg_11_0)
	arg_11_0:closeSubView()
	ActivityModel.instance:setTargetActivityCategoryId(0)
	ActivityWelfareListModel.instance:clear()
end

function var_0_0.setCategoryListInteractable(arg_12_0, arg_12_1)
	if not arg_12_0._categoryListCanvasGroup then
		arg_12_0._categoryListCanvasGroup = gohelper.onceAddComponent(arg_12_0._gocategory, typeof(UnityEngine.CanvasGroup))
	end

	arg_12_0._categoryListCanvasGroup.interactable = arg_12_1
	arg_12_0._categoryListCanvasGroup.blocksRaycasts = arg_12_1
	arg_12_0._categoryListCanvasGroup.blocksRaycasts = arg_12_1
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
