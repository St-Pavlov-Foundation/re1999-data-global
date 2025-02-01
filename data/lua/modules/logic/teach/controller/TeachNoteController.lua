module("modules.logic.teach.controller.TeachNoteController", package.seeall)

slot0 = class("TeachNoteController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.enterTeachNoteView(slot0, slot1, slot2)
	TeachNoteModel.instance:setJumpEnter(slot2)

	if not slot2 then
		TeachNoteModel.instance:setJumpEpisodeId(nil)
	end

	ViewMgr.instance:openView(ViewName.TeachNoteView, {
		isJump = slot2,
		episodeId = slot1
	})

	return ViewName.TeachNoteView
end

function slot0.enterTeachNoteDetailView(slot0, slot1)
	TeachNoteModel.instance:setJumpEnter(false)
	ViewMgr.instance:openView(ViewName.TeachNoteDetailView, slot1)

	return ViewName.TeachNoteDetailView
end

slot0.instance = slot0.New()

return slot0
