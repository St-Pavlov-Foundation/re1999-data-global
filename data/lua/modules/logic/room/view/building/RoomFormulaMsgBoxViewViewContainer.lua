module("modules.logic.room.view.building.RoomFormulaMsgBoxViewViewContainer", package.seeall)

local var_0_0 = class("RoomFormulaMsgBoxViewViewContainer", BaseViewContainer)

var_0_0.lineCount = 4

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "Exchange/Left/ScrollView"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "Exchange/Left/ScrollView/Viewport/Content/#go_PropItem"
	var_1_1.cellClass = RoomFormulaMsgBoxItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.cellWidth = 120
	var_1_1.cellHeight = 106
	var_1_1.cellSpaceH = 70
	var_1_1.lineCount = arg_1_0.lineCount

	table.insert(var_1_0, RoomFormulaMsgBoxView.New())
	table.insert(var_1_0, LuaListScrollView.New(RoomFormulaMsgBoxModel.instance, var_1_1))
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topright"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = {
			CurrencyEnum.CurrencyType.Gold
		}

		return {
			CurrencyView.New(var_2_0, nil, nil, nil, true)
		}
	end
end

return var_0_0
