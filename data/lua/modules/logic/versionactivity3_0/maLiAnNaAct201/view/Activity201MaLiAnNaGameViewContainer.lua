module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.Activity201MaLiAnNaGameViewContainer", package.seeall)

local var_0_0 = class("Activity201MaLiAnNaGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Activity201MaLiAnNaGameView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0._overrideClose, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0._overrideClose(arg_3_0)
	MaLiAnNaStatHelper.instance:sendGameExit(Activity201MaLiAnNaEnum.resultType.cancel)
	ViewMgr.instance:closeView(ViewName.Activity201MaLiAnNaGameView)
end

return var_0_0
