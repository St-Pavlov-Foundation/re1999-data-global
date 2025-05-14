module("modules.logic.guide.controller.action.impl.WaitGuideActionOpenViewWithEpisode", package.seeall)

local var_0_0 = class("WaitGuideActionOpenViewWithEpisode", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.split(arg_1_0.actionParam, "#")

	arg_1_0._viewName = ViewName[var_1_0[1]]
	arg_1_0._targetEposideId = tonumber(var_1_0[2])

	if ViewMgr.instance:isOpen(arg_1_0._viewName) and arg_1_0._targetEposideId == DungeonModel.instance.curLookEpisodeId then
		arg_1_0:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0._checkOpenView, arg_1_0)
end

function var_0_0._checkOpenView(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0._viewName == arg_2_1 and arg_2_0._targetEposideId == DungeonModel.instance.curLookEpisodeId then
		arg_2_0:clearWork()
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_3_0._checkOpenView, arg_3_0)
end

return var_0_0
