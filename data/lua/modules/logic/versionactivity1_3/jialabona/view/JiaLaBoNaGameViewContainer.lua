module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaGameViewContainer", package.seeall)

local var_0_0 = class("JiaLaBoNaGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, JiaLaBoNaGameView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_BackBtns"))
	table.insert(var_1_0, TabViewGroup.New(2, "gamescene"))

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		local var_3_0 = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.VersionActivity_1_3Role1Chess)

		var_3_0:setOverrideClose(arg_3_0._overrideCloseFunc, arg_3_0)

		return {
			var_3_0
		}
	elseif arg_3_1 == 2 then
		return {
			JiaLaBoNaGameScene.New()
		}
	end
end

function var_0_0._overrideCloseFunc(arg_4_0)
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	if not arg_4_0._yesExitFunc then
		function arg_4_0._yesExitFunc()
			Stat1_3Controller.instance:jiaLaBoNaStatAbort()
			arg_4_0:closeThis()
		end
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, arg_4_0._yesExitFunc)
end

function var_0_0._onEscape(arg_6_0)
	arg_6_0:_overrideCloseFunc()
end

return var_0_0
