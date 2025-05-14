module("modules.logic.rouge.view.RougeCollectionEnchantViewContainer", package.seeall)

local var_0_0 = class("RougeCollectionEnchantViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "right/#scroll_enchants"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "right/#scroll_enchants/Viewport/Content/#go_enchantitem"
	var_1_0.cellClass = RougeCollectionEnchantListItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 3
	var_1_0.cellWidth = 186
	var_1_0.cellHeight = 186
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 0
	var_1_0.startSpace = 9
	var_1_0.endSpace = 0
	arg_1_0._enchantScrollView = LuaListScrollView.New(RougeCollectionEnchantListModel.instance, var_1_0)

	return {
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_rougemapdetailcontainer"),
		RougeCollectionEnchantView.New(),
		arg_1_0._enchantScrollView
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0._navigateButtonView
		}
	elseif arg_2_1 == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

return var_0_0
