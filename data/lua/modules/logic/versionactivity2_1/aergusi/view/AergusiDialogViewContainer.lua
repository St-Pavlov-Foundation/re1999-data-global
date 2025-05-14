module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogViewContainer", package.seeall)

local var_0_0 = class("AergusiDialogViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		AergusiDialogRoleView.New(),
		AergusiDialogContentView.New(),
		AergusiDialogTaskView.New(),
		AergusiDialogView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0._startServerTime = ServerTime.now()
	arg_2_0._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	arg_2_0._navigateButtonView:setOverrideClose(arg_2_0._overrideCloseFunc, arg_2_0)

	return {
		arg_2_0._navigateButtonView
	}
end

function var_0_0._overrideCloseFunc(arg_3_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act163ExitEvidence, MsgBoxEnum.BoxType.Yes_No, arg_3_0._startClose, nil, nil, arg_3_0)
end

function var_0_0._startClose(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = AergusiModel.instance.instance:getEpisodeClueConfigs(arg_4_0.viewParam.episodeId, true)

	for iter_4_0, iter_4_1 in pairs(var_4_1) do
		table.insert(var_4_0, iter_4_1.clueName)
	end

	StatController.instance:track(StatEnum.EventName.ExitArgusActivity, {
		[StatEnum.EventProperties.EpisodeId] = tostring(arg_4_0.viewParam.episodeId),
		[StatEnum.EventProperties.Result] = "Abort",
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - arg_4_0._startServerTime,
		[StatEnum.EventProperties.GoalNum] = AergusiDialogModel.instance:getFinishedTargetGroupCount(),
		[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
		[StatEnum.EventProperties.HoldClueName] = var_4_0
	})
	arg_4_0:closeThis()
end

function var_0_0.onContainerOpenFinish(arg_5_0)
	arg_5_0._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_Universal_Click)
end

return var_0_0
