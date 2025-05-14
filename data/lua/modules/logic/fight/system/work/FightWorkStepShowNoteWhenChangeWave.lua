module("modules.logic.fight.system.work.FightWorkStepShowNoteWhenChangeWave", package.seeall)

local var_0_0 = class("FightWorkStepShowNoteWhenChangeWave", BaseWork)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = VersionActivity1_2NoteConfig.instance:getConfigList(FightModel.instance:getFightParam().episodeId)

	if var_1_0 then
		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			local var_1_1 = string.splitToNumber(iter_1_1.fightId, "#")

			if #var_1_1 > 0 and var_1_1[2] == FightModel.instance:getCurWaveId() then
				local var_1_2 = not VersionActivity1_2NoteModel.instance:getNote(iter_1_1.noteId)
				local var_1_3 = VersionActivity1_2NoteModel.instance:getClueData()

				if var_1_3 then
					for iter_1_2, iter_1_3 in ipairs(var_1_3) do
						if var_1_3.id == iter_1_3.noteId then
							var_1_2 = true

							table.remove(var_1_3, iter_1_2)

							break
						end
					end
				end

				if var_1_2 then
					ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._onCloseViewFinish, arg_1_0)
					ViewMgr.instance:openView(ViewName.VersionActivity_1_2_DungeonMapNoteView, {
						showPaper = true,
						id = iter_1_1.noteId
					})

					return
				end
			end
		end
	end

	arg_1_0:onDone(true)
end

function var_0_0._onCloseViewFinish(arg_2_0, arg_2_1)
	if arg_2_1 == ViewName.VersionActivity_1_2_DungeonMapNoteView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
end

return var_0_0
