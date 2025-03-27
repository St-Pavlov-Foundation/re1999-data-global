module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicBeatViewContainer", package.seeall)

slot0 = class("VersionActivity2_4MusicBeatViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._noteView = VersionActivity2_4MusicBeatNoteView.New()
	slot0._beatView = VersionActivity2_4MusicBeatView.New()
	slot1 = {}

	table.insert(slot1, slot0._noteView)
	table.insert(slot1, slot0._beatView)
	table.insert(slot1, TabViewGroup.New(1, "#go_left"))

	return slot1
end

function slot0.getNoteView(slot0)
	return slot0._noteView
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.MusicGameBeatHelp)

		slot0.navigateView:setHomeCheck(slot0._closeHomeCheckFunc, slot0)
		slot0.navigateView:setCloseCheck(slot0._closeThisCheckFunc, slot0)

		return {
			slot0.navigateView
		}
	end
end

function slot0._closeHomeCheckFunc(slot0)
	if slot0._beatView:isCountDown() then
		return false
	end

	if slot0._beatView:isPlaying() then
		GameFacade.showMessageBox(MessageBoxIdDefine.MusicBeatQuitConfirm, MsgBoxEnum.BoxType.Yes_No, function ()
			uv0.navigateView:_reallyHome()
		end)

		return false
	end

	return true
end

function slot0._closeThisCheckFunc(slot0)
	if slot0._beatView:isCountDown() then
		return false
	end

	if slot0._beatView:isPlaying() then
		GameFacade.showMessageBox(MessageBoxIdDefine.MusicBeatQuitConfirm, MsgBoxEnum.BoxType.Yes_No, function ()
			uv0:closeThis()
		end)

		return false
	end

	return true
end

function slot0.onContainerInit(slot0)
	VersionActivity2_4MultiTouchController.instance:startMultiTouch(slot0.viewName)
end

function slot0.onContainerDestroy(slot0)
	VersionActivity2_4MultiTouchController.instance:endMultiTouch()
end

return slot0
