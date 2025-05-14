module("modules.logic.teach.controller.TeachNoteController", package.seeall)

local var_0_0 = class("TeachNoteController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.enterTeachNoteView(arg_5_0, arg_5_1, arg_5_2)
	TeachNoteModel.instance:setJumpEnter(arg_5_2)

	if not arg_5_2 then
		TeachNoteModel.instance:setJumpEpisodeId(nil)
	end

	local var_5_0 = {
		isJump = arg_5_2,
		episodeId = arg_5_1
	}

	ViewMgr.instance:openView(ViewName.TeachNoteView, var_5_0)

	return ViewName.TeachNoteView
end

function var_0_0.enterTeachNoteDetailView(arg_6_0, arg_6_1)
	TeachNoteModel.instance:setJumpEnter(false)
	ViewMgr.instance:openView(ViewName.TeachNoteDetailView, arg_6_1)

	return ViewName.TeachNoteDetailView
end

var_0_0.instance = var_0_0.New()

return var_0_0
