module("modules.logic.activity.view.ActivityNormalView", package.seeall)

slot0 = class("ActivityNormalView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._gosubview = gohelper.findChild(slot0.viewGO, "#go_subview")
	slot0._scrollactivitylist = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_activitylist")
	slot0._gorule = gohelper.findChild(slot0.viewGO, "#go_rule")
	slot0._scrollruledesc = gohelper.findChildScrollRect(slot0.viewGO, "#go_rule/#scroll_ruledesc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._viewName = nil
end

slot1 = {}

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_open)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._refreshView, slot0)
	slot0:_refreshView()
	NavigateMgr.instance:addEscape(ViewName.ActivityNormalView, slot0._btncloseOnClick, slot0)
end

function slot0._refreshView(slot0)
	if not ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Normal) or not next(slot1) then
		slot0:closeThis()
	end

	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		table.insert(slot2, {
			id = slot7,
			co = ActivityConfig.instance:getActivityCo(slot7),
			type = ActivityEnum.ActivityType.Normal
		})
	end

	ActivityNormalCategoryListModel.instance:setCategoryList(slot2)
	slot0:_openSubView()
end

function slot0._openSubView(slot0)
	if ViewMgr.instance:isOpen(ViewName.ActivityTipView) then
		ViewMgr.instance:closeView(ViewName.ActivityTipView, true)
	end

	if slot0._viewName then
		ViewMgr.instance:closeView(slot0._viewName, true)
	end

	slot0._viewName = uv0[ActivityModel.instance:getTargetActivityCategoryId(ActivityEnum.ActivityType.Normal)]

	if not slot0._viewName then
		return
	end

	if not ActivityConfig.instance:getActivityCo(slot1).banner or slot2 == "" then
		gohelper.setActive(slot0._simagebg.gameObject, false)
	else
		gohelper.setActive(slot0._simagebg.gameObject, true)
		slot0._simagebg:LoadImage(ResUrl.getActivityBg(slot2))
	end

	ViewMgr.instance:openView(slot0._viewName, slot0._gosubview, true)
end

function slot0.closeSubView(slot0)
	if slot0._viewName then
		ViewMgr.instance:closeView(slot0._viewName, true)

		slot0._viewName = nil
	end
end

function slot0.onClose(slot0)
	ActivityModel.instance:setTargetActivityCategoryId(0)
	slot0:closeSubView()
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._refreshView, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
