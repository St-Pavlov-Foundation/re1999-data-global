module("modules.logic.fight.system.work.FightWorkStepShowNoteWhenChangeWave", package.seeall)

slot0 = class("FightWorkStepShowNoteWhenChangeWave", BaseWork)

function slot0.onStart(slot0)
	if VersionActivity1_2NoteConfig.instance:getConfigList(FightModel.instance:getFightParam().episodeId) then
		for slot5, slot6 in ipairs(slot1) do
			if #string.splitToNumber(slot6.fightId, "#") > 0 and slot7[2] == FightModel.instance:getCurWaveId() then
				slot8 = not VersionActivity1_2NoteModel.instance:getNote(slot6.noteId)

				if VersionActivity1_2NoteModel.instance:getClueData() then
					for slot13, slot14 in ipairs(slot9) do
						if slot9.id == slot14.noteId then
							slot8 = true

							table.remove(slot9, slot13)

							break
						end
					end
				end

				if slot8 then
					ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
					ViewMgr.instance:openView(ViewName.VersionActivity_1_2_DungeonMapNoteView, {
						showPaper = true,
						id = slot6.noteId
					})

					return
				end
			end
		end
	end

	slot0:onDone(true)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.VersionActivity_1_2_DungeonMapNoteView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

return slot0
