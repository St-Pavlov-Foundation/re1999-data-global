module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicFreeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, VersionActivity2_4MusicFreeView.New())
	table.insert(var_1_0, VersionActivity2_4MusicFreeNoteView.New())
	table.insert(var_1_0, VersionActivity2_4MusicFreeTrackView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_left"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.MusicGameFreeHelp)

		arg_2_0.navigateView:setHomeCheck(arg_2_0._closeHomeCheckFunc, arg_2_0)
		arg_2_0.navigateView:setCloseCheck(arg_2_0._closeThisCheckFunc, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0._closeHomeCheckFunc(arg_3_0)
	if VersionActivity2_4MusicFreeModel.instance:isRecordStatus() then
		GameFacade.showMessageBox(MessageBoxIdDefine.MusicFreeQuitConfirm, MsgBoxEnum.BoxType.Yes_No, function()
			arg_3_0.navigateView:_reallyHome()
		end)

		return false
	end

	return true
end

function var_0_0._closeThisCheckFunc(arg_5_0)
	if VersionActivity2_4MusicFreeModel.instance:isRecordStatus() then
		GameFacade.showMessageBox(MessageBoxIdDefine.MusicFreeQuitConfirm, MsgBoxEnum.BoxType.Yes_No, function()
			arg_5_0:closeThis()
		end)

		return false
	end

	return true
end

function var_0_0.onContainerInit(arg_7_0)
	VersionActivity2_4MultiTouchController.instance:startMultiTouch(arg_7_0.viewName)
end

function var_0_0.onContainerDestroy(arg_8_0)
	VersionActivity2_4MultiTouchController.instance:endMultiTouch()
end

return var_0_0
