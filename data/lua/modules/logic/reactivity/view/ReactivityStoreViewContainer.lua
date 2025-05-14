module("modules.logic.reactivity.view.ReactivityStoreViewContainer", package.seeall)

local var_0_0 = class("ReactivityStoreViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ReactivityStoreView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end

	if arg_2_1 == 2 then
		local var_2_0 = ReactivityModel.instance:getActivityCurrencyId(arg_2_0.viewParam.actId)
		local var_2_1 = CurrencyView.New({
			var_2_0,
			CurrencyEnum.CurrencyType.ReactivityCurrency
		})

		var_2_1.foreHideBtn = true

		return {
			var_2_1
		}
	end
end

function var_0_0.playOpenTransition(arg_3_0)
	arg_3_0:startViewOpenBlock()
	arg_3_0.viewGO:GetComponent(typeof(UnityEngine.Animation)):Play("activitystore_open")
	TaskDispatcher.runDelay(arg_3_0.onPlayOpenTransitionFinish, arg_3_0, 0.5)
end

function var_0_0.playCloseTransition(arg_4_0)
	arg_4_0:startViewCloseBlock()
	arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animation)):Play("activitystore_close")
	TaskDispatcher.runDelay(arg_4_0.onPlayCloseTransitionFinish, arg_4_0, 0.167)
end

return var_0_0
