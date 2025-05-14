module("modules.logic.room.view.backpack.RoomBackpackViewContainer", package.seeall)

local var_0_0 = class("RoomBackpackViewContainer", BaseViewContainer)
local var_0_1 = {
	Navigate = 1,
	SubView = 2
}

var_0_0.SubViewTabId = {
	Critter = 1,
	Prop = 2
}
var_0_0.TabSettingList = {
	{
		namecn = "room_critter_backpack_cn",
		nameen = "room_critter_backpack_en"
	},
	{
		namecn = "room_prop_backpack_cn",
		nameen = "room_prop_backpack_en"
	}
}

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomBackpackView.New())
	table.insert(var_1_0, TabViewGroup.New(var_0_1.Navigate, "#go_topleft"))
	table.insert(var_1_0, TabViewGroup.New(var_0_1.SubView, "#go_container"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == var_0_1.Navigate then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	elseif arg_2_1 == var_0_1.SubView then
		local var_2_0 = ListScrollParam.New()

		var_2_0.scrollGOPath = "#scroll_critter"
		var_2_0.prefabType = ScrollEnum.ScrollPrefabFromView
		var_2_0.prefabUrl = "#scroll_critter/viewport/content/#go_critterItem"
		var_2_0.cellClass = RoomBackpackCritterItem
		var_2_0.scrollDir = ScrollEnum.ScrollDirV
		var_2_0.lineCount = 8
		var_2_0.cellWidth = 152
		var_2_0.cellHeight = 152
		var_2_0.cellSpaceH = 30
		var_2_0.cellSpaceV = 30
		var_2_0.startSpace = 20
		var_2_0.minUpdateCountInFrame = 100

		local var_2_1 = MultiView.New({
			RoomBackpackCritterView.New(),
			LuaListScrollView.New(RoomBackpackCritterListModel.instance, var_2_0)
		})
		local var_2_2 = ListScrollParam.New()

		var_2_2.scrollGOPath = "#scroll_prop"
		var_2_2.prefabType = ScrollEnum.ScrollPrefabFromView
		var_2_2.prefabUrl = "#scroll_prop/viewport/content/#go_item"
		var_2_2.cellClass = RoomBackpackPropItem
		var_2_2.scrollDir = ScrollEnum.ScrollDirV
		var_2_2.lineCount = 7
		var_2_2.cellWidth = 220
		var_2_2.cellHeight = 220
		var_2_2.startSpace = 20
		var_2_2.endSpace = 10
		var_2_2.minUpdateCountInFrame = 100

		local var_2_3 = MultiView.New({
			RoomBackpackPropView.New(),
			LuaListScrollViewWithAnimator.New(RoomBackpackPropListModel.instance, var_2_2)
		})

		return {
			var_2_1,
			var_2_3
		}
	end
end

function var_0_0.onContainerInit(arg_3_0)
	if not arg_3_0.viewParam then
		return
	end

	local var_3_0 = arg_3_0:getDefaultSelectedTab()

	arg_3_0.viewParam.defaultTabIds = {}
	arg_3_0.viewParam.defaultTabIds[var_0_1.SubView] = var_3_0
end

function var_0_0.getDefaultSelectedTab(arg_4_0)
	local var_4_0 = var_0_0.SubViewTabId.Critter
	local var_4_1 = arg_4_0.viewParam and arg_4_0.viewParam.defaultTab

	if arg_4_0:checkTabId(var_4_1) then
		var_4_0 = var_4_1
	end

	return var_4_0
end

function var_0_0.checkTabId(arg_5_0, arg_5_1)
	local var_5_0 = false

	if arg_5_1 then
		for iter_5_0, iter_5_1 in pairs(var_0_0.SubViewTabId) do
			if iter_5_1 == arg_5_1 then
				var_5_0 = true

				break
			end
		end
	end

	return var_5_0
end

function var_0_0.switchTab(arg_6_0, arg_6_1)
	if not arg_6_0:checkTabId(arg_6_1) then
		return
	end

	arg_6_0:dispatchEvent(ViewEvent.ToSwitchTab, var_0_1.SubView, arg_6_1)
end

function var_0_0.onContainerCloseFinish(arg_7_0)
	RoomBackpackCritterListModel.instance:onInit()
end

return var_0_0
