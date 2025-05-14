module("modules.logic.seasonver.act166.view.Season166TeachViewContainer", package.seeall)

local var_0_0 = class("Season166TeachViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Season166TeachView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0.overrideClose, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.overrideClose(arg_3_0)
	if Season166TeachModel.instance:checkIsAllTeachFinish(arg_3_0.viewParam.actId) then
		arg_3_0:closeThis()
	else
		GameFacade.showOptionMessageBox(MessageBoxIdDefine.Season166CloseTeachTip, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.NotShow, arg_3_0.onYesClick, nil, nil, arg_3_0)
	end
end

function var_0_0.onYesClick(arg_4_0)
	arg_4_0:closeThis()
end

return var_0_0
