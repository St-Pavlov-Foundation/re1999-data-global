module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6GameViewContainer", package.seeall)

local var_0_0 = class("LengZhou6GameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		LengZhou6GameView.New(),
		TabViewGroup.New(1, "#go_btns"),
		LengZhou6EliminateView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = arg_2_0:_getHelpId()

		arg_2_0.navigationView = NavigateButtonsView.New({
			true,
			false,
			var_2_0 ~= nil
		}, var_2_0)

		arg_2_0.navigationView:setOverrideClose(arg_2_0._overrideClose, arg_2_0)

		return {
			arg_2_0.navigationView
		}
	end
end

function var_0_0._overrideClose(arg_3_0)
	local var_3_0 = LengZhou6Model.instance:getCurEpisodeId()
	local var_3_1 = LengZhou6Model.instance:getEpisodeInfoMo(var_3_0)

	if var_3_1 then
		local var_3_2 = var_3_1:isEndlessEpisode() and LengZhou6Enum.GameResult.infiniteCancel or LengZhou6Enum.GameResult.normalCancel

		LengZhou6StatHelper.instance:setGameResult(var_3_2)
	end

	LengZhou6GameController.instance:levelGame(true)
	LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.OnClickCloseGameView)
	LengZhou6StatHelper.instance:sendGameExit()
end

function var_0_0.refreshHelpId(arg_4_0)
	local var_4_0 = arg_4_0:_getHelpId()

	if var_4_0 ~= nil and arg_4_0.navigationView ~= nil then
		arg_4_0.navigationView:setHelpId(var_4_0)
	end
end

function var_0_0._getHelpId(arg_5_0)
	return 2500200
end

function var_0_0.onContainerInit(arg_6_0)
	arg_6_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_6_0.refreshHelpId, arg_6_0)
end

return var_0_0
