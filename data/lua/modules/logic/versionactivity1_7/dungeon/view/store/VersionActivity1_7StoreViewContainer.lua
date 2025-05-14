module("modules.logic.versionactivity1_7.dungeon.view.store.VersionActivity1_7StoreViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_7StoreViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#scroll_store"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "#scroll_store/Viewport/#go_content/#go_storegoodsitem"
	var_1_0.cellClass = VersionActivity1_7StoreGoodsItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 4
	var_1_0.cellWidth = 316
	var_1_0.cellHeight = 365

	return {
		VersionActivity1_7StoreView.New(),
		VersionActivity1_7StoreTalk.New(),
		LuaListScrollView.New(VersionActivity1_7StoreListModel.instance, var_1_0),
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
			CurrencyEnum.CurrencyType.V1a7Dungeon
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
	TaskDispatcher.runDelay(arg_4_0.onPlayOpenTransitionFinish, arg_4_0, 1.6)
end

function var_0_0.playCloseTransition(arg_5_0)
	arg_5_0:startViewCloseBlock()
	arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animation)):Play("activitystore_close")
	TaskDispatcher.runDelay(arg_5_0.onPlayCloseTransitionFinish, arg_5_0, 0.167)
end

function var_0_0.onContainerInit(arg_6_0)
	return
end

return var_0_0
