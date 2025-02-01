module("modules.logic.fight.system.work.FightWork1_2ClueTips", package.seeall)

slot0 = class("FightWork1_2ClueTips", BaseWork)

function slot0.onStart(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)

	slot0._data = VersionActivity1_2NoteModel.instance:getClueData()

	slot0:_showView()
end

function slot0._showView(slot0)
	if slot0._data and #slot0._data > 0 then
		if table.remove(slot0._data, 1).id ~= 101 and slot1.id ~= 204 then
			ViewMgr.instance:openView(ViewName.VersionActivity_1_2_DungeonMapNoteView, slot1)
		else
			slot0:_showView()
		end
	else
		slot0:onDone(true)
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.VersionActivity_1_2_DungeonMapNoteView then
		slot0:_showView()
	end
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

return slot0
