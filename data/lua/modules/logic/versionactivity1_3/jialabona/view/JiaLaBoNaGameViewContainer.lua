module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaGameViewContainer", package.seeall)

slot0 = class("JiaLaBoNaGameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, JiaLaBoNaGameView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_BackBtns"))
	table.insert(slot1, TabViewGroup.New(2, "gamescene"))

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot2 = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.VersionActivity_1_3Role1Chess)

		slot2:setOverrideClose(slot0._overrideCloseFunc, slot0)

		return {
			slot2
		}
	elseif slot1 == 2 then
		return {
			JiaLaBoNaGameScene.New()
		}
	end
end

function slot0._overrideCloseFunc(slot0)
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	if not slot0._yesExitFunc then
		function slot0._yesExitFunc()
			Stat1_3Controller.instance:jiaLaBoNaStatAbort()
			uv0:closeThis()
		end
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, slot0._yesExitFunc)
end

function slot0._onEscape(slot0)
	slot0:_overrideCloseFunc()
end

return slot0
