module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaLevelViewContainer", package.seeall)

local var_0_0 = class("TianShiNaNaLevelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._mapViewScene = TianShiNaNaLevelScene.New()

	return {
		TianShiNaNaLevelView.New(),
		TianShiNaNaOperView.New(),
		arg_1_0._mapViewScene,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			false,
			false
		})

		var_2_0:setOverrideClose(arg_2_0.defaultOverrideCloseClick, arg_2_0)

		return {
			var_2_0
		}
	end
end

function var_0_0.defaultOverrideCloseClick(arg_3_0)
	if TianShiNaNaHelper.isBanOper() then
		return
	end

	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.Act167Abort, MsgBoxEnum.BoxType.Yes_No, arg_3_0.closeThis, nil, nil, arg_3_0)
end

function var_0_0.setVisibleInternal(arg_4_0, arg_4_1)
	if arg_4_0._mapViewScene then
		arg_4_0._mapViewScene:setSceneVisible(arg_4_1)
	end

	var_0_0.super.setVisibleInternal(arg_4_0, arg_4_1)
end

return var_0_0
