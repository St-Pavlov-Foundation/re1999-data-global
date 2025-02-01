module("modules.logic.main.controller.work.MainThumbnailWork", package.seeall)

slot0 = class("MainThumbnailWork", BaseWork)

function slot0._checkShow()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.MainThumbnail) then
		return false
	end

	if PlayerModel.instance:getMainThumbnail() then
		return false
	end

	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return false
	end

	return true
end

function slot0.onStart(slot0, slot1)
	if not uv0._checkShow() then
		slot0:onDone(true)

		return
	end

	if ViewMgr.instance:isOpenFinish(ViewName.MainView) then
		slot0:_startMainThumbnailView()

		return
	end

	TaskDispatcher.cancelTask(slot0._overtimeHandler, slot0)
	TaskDispatcher.runDelay(slot0._overtimeHandler, slot0, 3)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinsh, slot0)
end

function slot0._overtimeHandler(slot0)
	slot0:_startMainThumbnailView()
end

function slot0._onOpenViewFinsh(slot0, slot1)
	if slot1 == ViewName.MainView then
		slot0:_startMainThumbnailView()
	end
end

function slot0._startMainThumbnailView(slot0)
	TaskDispatcher.cancelTask(slot0._overtimeHandler, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinsh, slot0)
	MainController.instance:dispatchEvent(MainEvent.OnShowMainThumbnailView)
	MainController.instance:registerCallback(MainEvent.OnMainThumbnailGreetingFinish, slot0._onMainThumbnailGreetingFinish, slot0)
	MainController.instance:openMainThumbnailView({
		needPlayGreeting = true
	})
end

function slot0._onMainThumbnailGreetingFinish(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._overtimeHandler, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinsh, slot0)
	MainController.instance:unregisterCallback(MainEvent.OnMainThumbnailGreetingFinish, slot0._onMainThumbnailGreetingFinish, slot0)
end

return slot0
