module("modules.logic.versionactivity1_5.aizila.view.AiZiLaHandbookViewContainer", package.seeall)

local var_0_0 = class("AiZiLaHandbookViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "Right/#scroll_Items"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = AiZiLaGoodsItem.prefabPath
	var_1_1.cellClass = AiZiLaHandbookItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 4
	var_1_1.cellWidth = 286
	var_1_1.cellHeight = 236
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0

	table.insert(var_1_0, LuaListScrollView.New(AiZiLaHandbookListModel.instance, var_1_1))
	table.insert(var_1_0, AiZiLaHandbookView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_BackBtns"))

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	return
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return var_0_0
