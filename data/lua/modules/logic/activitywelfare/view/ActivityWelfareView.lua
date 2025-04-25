module("modules.logic.activitywelfare.view.ActivityWelfareView", package.seeall)

slot0 = class("ActivityWelfareView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocategory = gohelper.findChild(slot0.viewGO, "#go_category")
	slot0._scrollitem = gohelper.findChildScrollRect(slot0.viewGO, "#go_category/#scroll_categoryitem")
	slot0._gosubview = gohelper.findChild(slot0.viewGO, "#go_subview")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

slot1 = {
	[ActivityEnum.Activity.NewWelfare] = ViewName.NewWelfareView,
	[ActivityEnum.Activity.NoviceSign] = ViewName.ActivityNoviceSignView,
	[ActivityEnum.Activity.StoryShow] = ViewName.ActivityStoryShowView,
	[ActivityEnum.Activity.ClassShow] = ViewName.ActivityClassShowView,
	[ActivityEnum.Activity.NewInsight] = ViewName.ActivityInsightShowView,
	[ActivityEnum.Activity.V2a3_NewInsight] = ViewName.ActivityInsightShowView_2_3,
	[ActivityEnum.Activity.V2a4_NewInsight] = ViewName.ActivityInsightShowView_2_4,
	[ActivityEnum.Activity.V2a5_NewInsight] = ViewName.ActivityInsightShowView_2_5
}

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_open)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._refreshView, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.SetBannerViewCategoryListInteract, slot0.setCategoryListInteractable, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.SwitchWelfareActivity, slot0._openSubView, slot0)
	slot0:_refreshView()
end

function slot0._refreshView(slot0)
	if not ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Welfare) or not next(slot1) then
		slot0:closeThis()
	end

	ActivityModel.instance:removeFinishedWelfare(slot1)

	slot0.data = {}

	for slot5, slot6 in pairs(slot1) do
		table.insert(slot0.data, {
			id = slot6,
			co = ActivityConfig.instance:getActivityCo(slot6),
			type = ActivityEnum.ActivityType.Welfare
		})
	end

	ActivityWelfareListModel.instance:setOpenViewTime()
	ActivityWelfareListModel.instance:setCategoryList(slot0.data)
	slot0:_openSubView()
end

function slot0._openSubView(slot0)
	if slot0._viewName then
		ViewMgr.instance:closeView(slot0._viewName, true)
	end

	slot0._viewName = uv0[ActivityModel.instance:getTargetActivityCategoryId(ActivityEnum.ActivityType.Welfare)]

	if not slot0._viewName then
		return
	end

	if slot1 == ActivityEnum.Activity.StoryShow or slot1 == ActivityEnum.Activity.ClassShow then
		slot0:setCategoryRedDotData(slot1)
	end

	slot0.viewContainer:hideHelp()
	ViewMgr.instance:openView(slot0._viewName, {
		parent = slot0._gosubview,
		actId = slot1,
		root = slot0.viewGO
	}, true)
end

function slot0.setCategoryRedDotData(slot0, slot1)
	slot2 = PlayerPrefsKey.FirstEnterActivityShow .. "#" .. tostring(slot1) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setString(slot2, "hasEnter")

	return slot2
end

function slot0.closeSubView(slot0)
	if slot0._viewName then
		ViewMgr.instance:closeView(slot0._viewName, true)

		slot0._viewName = nil
	end
end

function slot0.onClose(slot0)
	ActivityModel.instance:setTargetActivityCategoryId(0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._refreshView, slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.SetBannerViewCategoryListInteract, slot0.setCategoryListInteractable, slot0)
	slot0:closeSubView()
	ActivityModel.instance:setTargetActivityCategoryId(0)
	ActivityWelfareListModel.instance:clear()
end

function slot0.setCategoryListInteractable(slot0, slot1)
	if not slot0._categoryListCanvasGroup then
		slot0._categoryListCanvasGroup = gohelper.onceAddComponent(slot0._gocategory, typeof(UnityEngine.CanvasGroup))
	end

	slot0._categoryListCanvasGroup.interactable = slot1
	slot0._categoryListCanvasGroup.blocksRaycasts = slot1
	slot0._categoryListCanvasGroup.blocksRaycasts = slot1
end

function slot0.onDestroyView(slot0)
end

return slot0
