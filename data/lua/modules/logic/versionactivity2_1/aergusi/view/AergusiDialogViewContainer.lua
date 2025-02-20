module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogViewContainer", package.seeall)

slot0 = class("AergusiDialogViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		AergusiDialogRoleView.New(),
		AergusiDialogContentView.New(),
		AergusiDialogTaskView.New(),
		AergusiDialogView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot0._startServerTime = ServerTime.now()
	slot0._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	slot0._navigateButtonView:setOverrideClose(slot0._overrideCloseFunc, slot0)

	return {
		slot0._navigateButtonView
	}
end

function slot0._overrideCloseFunc(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act163ExitEvidence, MsgBoxEnum.BoxType.Yes_No, slot0._startClose, nil, , slot0)
end

function slot0._startClose(slot0)
	slot1 = {}
	slot6 = true

	for slot6, slot7 in pairs(AergusiModel.instance.instance:getEpisodeClueConfigs(slot0.viewParam.episodeId, slot6)) do
		table.insert(slot1, slot7.clueName)
	end

	StatController.instance:track(StatEnum.EventName.ExitArgusActivity, {
		[StatEnum.EventProperties.EpisodeId] = tostring(slot0.viewParam.episodeId),
		[StatEnum.EventProperties.Result] = "Abort",
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - slot0._startServerTime,
		[StatEnum.EventProperties.GoalNum] = AergusiDialogModel.instance:getFinishedTargetGroupCount(),
		[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
		[StatEnum.EventProperties.HoldClueName] = slot1
	})
	slot0:closeThis()
end

function slot0.onContainerOpenFinish(slot0)
	slot0._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_Universal_Click)
end

return slot0
