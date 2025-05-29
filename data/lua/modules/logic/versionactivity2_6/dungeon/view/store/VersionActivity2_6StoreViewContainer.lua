module("modules.logic.versionactivity2_6.dungeon.view.store.VersionActivity2_6StoreViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_6StoreViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#scroll_store"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "#scroll_store/Viewport/#go_content/#go_storegoodsitem"
	var_1_0.cellClass = VersionActivity2_6StoreGoodsItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 4
	var_1_0.cellWidth = 316
	var_1_0.cellHeight = 365

	return {
		VersionActivity2_6StoreView.New(),
		VersionActivity2_6StoreTalk.New(),
		LuaListScrollView.New(VersionActivity2_6StoreListModel.instance, var_1_0),
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
			CurrencyEnum.CurrencyType.V2a6Dungeon
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

function var_0_0.onContainerInit(arg_4_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_6Enum.ActivityId.DungeonStore)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_6Enum.ActivityId.DungeonStore
	})
end

return var_0_0
