module("modules.logic.versionactivity2_4.dungeon.view.store.VersionActivity2_4StoreViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_4StoreViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		VersionActivity2_4StoreView.New(),
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
		arg_2_0._currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.V2a4Dungeon
		})

		arg_2_0._currencyView:setOpenCallback(arg_2_0._onCurrencyOpen, arg_2_0)

		return {
			arg_2_0._currencyView
		}
	end
end

function var_0_0._onCurrencyOpen(arg_3_0)
	local var_3_0 = arg_3_0._currencyView:getCurrencyItem(1)

	gohelper.setActive(var_3_0.btn, false)
	gohelper.setActive(var_3_0.click, true)
	recthelper.setAnchorX(var_3_0.txt.transform, 313)
end

function var_0_0.playOpenTransition(arg_4_0)
	arg_4_0:startViewOpenBlock()
	arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animation)):Play("activitystore_open")
	TaskDispatcher.runDelay(arg_4_0.onPlayOpenTransitionFinish, arg_4_0, 0.5)
end

function var_0_0.playCloseTransition(arg_5_0)
	arg_5_0:startViewCloseBlock()
	arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animation)):Play("activitystore_close")
	TaskDispatcher.runDelay(arg_5_0.onPlayCloseTransitionFinish, arg_5_0, 0.167)
end

return var_0_0
