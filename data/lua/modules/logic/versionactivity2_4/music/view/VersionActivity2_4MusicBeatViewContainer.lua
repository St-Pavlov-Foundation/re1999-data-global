module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicBeatViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicBeatViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._noteView = VersionActivity2_4MusicBeatNoteView.New()
	arg_1_0._beatView = VersionActivity2_4MusicBeatView.New()

	local var_1_0 = {}

	table.insert(var_1_0, arg_1_0._noteView)
	table.insert(var_1_0, arg_1_0._beatView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_left"))

	return var_1_0
end

function var_0_0.getNoteView(arg_2_0)
	return arg_2_0._noteView
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.MusicGameBeatHelp)

		arg_3_0.navigateView:setHomeCheck(arg_3_0._closeHomeCheckFunc, arg_3_0)
		arg_3_0.navigateView:setCloseCheck(arg_3_0._closeThisCheckFunc, arg_3_0)

		return {
			arg_3_0.navigateView
		}
	end
end

function var_0_0._closeHomeCheckFunc(arg_4_0)
	if arg_4_0._beatView:isCountDown() then
		return false
	end

	if arg_4_0._beatView:isPlaying() then
		GameFacade.showMessageBox(MessageBoxIdDefine.MusicBeatQuitConfirm, MsgBoxEnum.BoxType.Yes_No, function()
			arg_4_0.navigateView:_reallyHome()
		end)

		return false
	end

	return true
end

function var_0_0._closeThisCheckFunc(arg_6_0)
	if arg_6_0._beatView:isCountDown() then
		return false
	end

	if arg_6_0._beatView:isPlaying() then
		GameFacade.showMessageBox(MessageBoxIdDefine.MusicBeatQuitConfirm, MsgBoxEnum.BoxType.Yes_No, function()
			arg_6_0:closeThis()
		end)

		return false
	end

	return true
end

function var_0_0.onContainerInit(arg_8_0)
	VersionActivity2_4MultiTouchController.instance:startMultiTouch(arg_8_0.viewName)
end

function var_0_0.onContainerDestroy(arg_9_0)
	VersionActivity2_4MultiTouchController.instance:endMultiTouch()
end

return var_0_0
