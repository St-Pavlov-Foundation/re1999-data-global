module("modules.logic.rouge.map.view.collectionabandon.RougeMapCollectionExchangeViewContainer", package.seeall)

local var_0_0 = class("RougeMapCollectionExchangeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeMapCollectionExchangeView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))
	table.insert(var_1_0, TabViewGroup.New(2, "#go_rougemapdetailcontainer"))

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "Left/#scroll_view"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = RougeMapEnum.CollectionLeftItemRes
	var_1_1.cellClass = RougeMapCollectionLossLeftItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 850
	var_1_1.cellHeight = 180
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 8
	var_1_1.startSpace = 0
	arg_1_0.scrollView = LuaListScrollView.New(RougeLossCollectionListModel.instance, var_1_1)

	table.insert(var_1_0, arg_1_0.scrollView)

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	elseif arg_2_1 == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

function var_0_0.onContainerInit(arg_3_0)
	arg_3_0.listRemoveComp = ListScrollAnimRemoveItem.Get(arg_3_0.scrollView)

	arg_3_0.listRemoveComp:setMoveInterval(0)
end

function var_0_0.getListRemoveComp(arg_4_0)
	return arg_4_0.listRemoveComp
end

return var_0_0
