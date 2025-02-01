module("modules.logic.login.work.AutoOpenNoticeWork", package.seeall)

slot0 = class("AutoOpenNoticeWork", BaseWork)

function slot0.onStart(slot0, slot1)
	if VersionValidator.instance:isInReviewing() then
		slot0:onDone(true)

		return
	end

	if GameFacade.isExternalTest() then
		slot0:onDone(true)

		return
	end

	if SDKMgr.getShowNotice and not SDKMgr.instance:getShowNotice() then
		slot0:onDone(true)

		return
	end

	NoticeController.instance:startRequest(slot0.onReceiveNotice, slot0)
end

function slot0.onReceiveNotice(slot0, slot1, slot2)
	if not slot1 then
		return slot0:onDone(true)
	end

	if not NoticeModel.instance:canAutoOpen() then
		return slot0:onDone(true)
	end

	NoticeController.instance:getNoticeConfig(slot0.autoOpenNoticeView, slot0)
end

function slot0.autoOpenNoticeView(slot0)
	slot0:saveCurrentTime()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
	NoticeController.instance:setAutoOpenNoticeView(true)
	ViewMgr.instance:openView(ViewName.NoticeView)
end

function slot0.saveCurrentTime(slot0)
	slot4 = os.date("*t", ServerTime.nowInLocal() - TimeDispatcher.DailyRefreshTime * TimeUtil.OneHourSecond)

	if not string.nilorempty(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.NoticePatKey), "")) then
		slot9 = slot2 .. NoticeEnum.SecondSplitChar .. string.format("%s%s%s%s%s%s%s", slot4.year, NoticeEnum.FirstSplitChar, slot4.month, NoticeEnum.FirstSplitChar, slot4.day, NoticeEnum.FirstSplitChar, slot4.hour)
	end

	PlayerPrefsHelper.setString(slot1, slot9)
end

function slot0.onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.NoticeView then
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
	NoticeController.instance:stopRequest()
	NoticeController.instance:stopGetConfigRequest()
end

return slot0
