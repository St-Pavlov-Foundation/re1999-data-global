module("modules.logic.explore.controller.steps.ExploreArchiveClientStep", package.seeall)

slot0 = class("ExploreArchiveClientStep", ExploreStepBase)

function slot0.onStart(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
	ViewMgr.instance:openView(ViewName.ExploreArchivesDetailView, {
		id = slot0._data.archiveId,
		chapterId = ExploreConfig.instance:getMapIdConfig(ExploreModel.instance:getMapId()).chapterId
	})
end

function slot0._onCloseViewFinish(slot0, slot1)
	if ViewName.ExploreArchivesDetailView == slot1 then
		slot0:onDone()
	end
end

function slot0.onDestory(slot0)
	uv0.super.onDestory(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
end

return slot0
