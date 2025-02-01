module("modules.logic.versionactivity1_7.lantern.controller.LanternFestivalController", package.seeall)

slot0 = class("LanternFestivalController", BaseController)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
end

function slot0.addConstEvents(slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, slot0._checkActivityInfo, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._checkActivityInfo, slot0)
end

function slot0._checkActivityInfo(slot0)
	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.LanternFestival) then
		Activity154Rpc.instance:sendGet154InfosRequest(ActivityEnum.Activity.LanternFestival)
	end
end

function slot0.openQuestionTipView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.LanternFestivalQuestionTipView, slot1)
end

function slot0.openLanternFestivalView(slot0)
	ViewMgr.instance:openView(ViewName.LanternFestivalView)
end

slot0.instance = slot0.New()

return slot0
