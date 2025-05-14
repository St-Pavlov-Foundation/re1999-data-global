module("modules.logic.fight.system.work.FightWork1_2ClueTips", package.seeall)

local var_0_0 = class("FightWork1_2ClueTips", BaseWork)

function var_0_0.onStart(arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._onCloseViewFinish, arg_1_0)

	arg_1_0._data = VersionActivity1_2NoteModel.instance:getClueData()

	arg_1_0:_showView()
end

function var_0_0._showView(arg_2_0)
	if arg_2_0._data and #arg_2_0._data > 0 then
		local var_2_0 = table.remove(arg_2_0._data, 1)

		if var_2_0.id ~= 101 and var_2_0.id ~= 204 then
			ViewMgr.instance:openView(ViewName.VersionActivity_1_2_DungeonMapNoteView, var_2_0)
		else
			arg_2_0:_showView()
		end
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0._onCloseViewFinish(arg_3_0, arg_3_1)
	if arg_3_1 == ViewName.VersionActivity_1_2_DungeonMapNoteView then
		arg_3_0:_showView()
	end
end

function var_0_0.clearWork(arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_4_0._onCloseViewFinish, arg_4_0)
end

return var_0_0
