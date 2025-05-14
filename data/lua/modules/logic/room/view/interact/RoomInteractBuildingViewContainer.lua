module("modules.logic.room.view.interact.RoomInteractBuildingViewContainer", package.seeall)

local var_0_0 = class("RoomInteractBuildingViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._interactView = RoomInteractBuildingView.New()

	table.insert(var_1_0, arg_1_0._interactView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_BackBtns"))

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#go_right/#go_hero/#scroll_hero"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = RoomInteractCharacterItem.prefabUrl
	var_1_1.cellClass = RoomInteractCharacterItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.cellWidth = 200
	var_1_1.lineCount = 3
	var_1_1.cellHeight = 205
	var_1_1.cellSpaceH = 5
	var_1_1.cellSpaceV = 4.6
	var_1_1.startSpace = 10
	var_1_1.emptyScrollParam = EmptyScrollParam.New()

	var_1_1.emptyScrollParam:setFromView("#go_right/#go_hero/#go_empty")
	table.insert(var_1_0, LuaListScrollView.New(RoomInteractCharacterListModel.instance, var_1_1))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0.navigateView:setCloseCheck(arg_2_0._navigateCloseView, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0._navigateCloseView(arg_3_0)
	if arg_3_0._interactView then
		arg_3_0._interactView:goBackClose()
	else
		arg_3_0:closeThis()
	end
end

return var_0_0
