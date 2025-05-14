module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateEffectViewContainer", package.seeall)

local var_0_0 = class("EliminateEffectViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, EliminateEffectView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0._overrideCloseFunc, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0._overrideCloseFunc(arg_3_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.EliminateLevelClose, MsgBoxEnum.BoxType.Yes_No, arg_3_0._closeLevel, nil, nil, arg_3_0, nil, nil)
end

function var_0_0._closeLevel(arg_4_0)
	EliminateLevelModel.instance:sendStatData(EliminateLevelEnum.resultStatUse.draw)
	EliminateLevelController.instance:closeLevel()
end

return var_0_0
