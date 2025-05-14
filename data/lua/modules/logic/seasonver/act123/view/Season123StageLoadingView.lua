module("modules.logic.seasonver.act123.view.Season123StageLoadingView", package.seeall)

local var_0_0 = class("Season123StageLoadingView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onDestroyView(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.handleDelayAnimTransition, arg_5_0)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_6_0.handleOpenView, arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_leimi_map_upgrade)

	local var_6_0 = arg_6_0.viewParam.actId
	local var_6_1 = arg_6_0.viewParam.stage

	logNormal(string.format("Season123StageLoadingView actId=%s, stage=%s", var_6_0, var_6_1))
	TaskDispatcher.runDelay(arg_6_0.handleDelayAnimTransition, arg_6_0, 2.5)
end

function var_0_0.onClose(arg_7_0)
	Season123Controller.instance:dispatchEvent(Season123Event.EnterEpiosdeList, true)
end

function var_0_0.handleDelayAnimTransition(arg_8_0)
	ViewMgr.instance:openView(Season123Controller.instance:getEpisodeListViewName(), {
		actId = arg_8_0.viewParam.actId,
		stage = arg_8_0.viewParam.stage
	})
end

function var_0_0.handleOpenView(arg_9_0, arg_9_1)
	if arg_9_1 == Season123Controller.instance:getEpisodeListViewName() then
		arg_9_0:closeThis()
	end
end

return var_0_0
