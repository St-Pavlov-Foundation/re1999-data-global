module("modules.versionactivitybase.fixed.dungeon.view.store.VersionActivityFixedStoreViewContainer", package.seeall)

local var_0_0 = class("VersionActivityFixedStoreViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._bigVersion, arg_1_0._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	return {
		VersionActivityFixedHelper.getVersionActivityStoreView(arg_1_0._bigVersion, arg_1_0._smallVersion).New(),
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
		local var_2_0 = VersionActivityFixedHelper.getVersionActivityCurrencyType(arg_2_0._bigVersion, arg_2_0._smallVersio)

		arg_2_0._currencyView = CurrencyView.New({
			var_2_0
		})

		arg_2_0._currencyView:setOpenCallback(arg_2_0._onCurrencyOpen, arg_2_0)

		return {
			arg_2_0._currencyView
		}
	end
end

function var_0_0._onCurrencyOpen(arg_3_0)
	arg_3_0:refreshCurrencyItem()
end

function var_0_0.refreshCurrencyItem(arg_4_0)
	local var_4_0 = arg_4_0._currencyView:getCurrencyItem(1)

	gohelper.setActive(var_4_0.btn, false)
	gohelper.setActive(var_4_0.click, true)
	recthelper.setAnchorX(var_4_0.txt.transform, 313)
end

function var_0_0.playOpenTransition(arg_5_0)
	arg_5_0:startViewOpenBlock()
	arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animation)):Play("activitystore_open")
	TaskDispatcher.runDelay(arg_5_0.onPlayOpenTransitionFinish, arg_5_0, 0.5)
end

function var_0_0.playCloseTransition(arg_6_0)
	arg_6_0:startViewCloseBlock()
	arg_6_0.viewGO:GetComponent(typeof(UnityEngine.Animation)):Play("activitystore_close")
	TaskDispatcher.runDelay(arg_6_0.onPlayCloseTransitionFinish, arg_6_0, 0.167)
end

return var_0_0
