module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGamePackViewContainer", package.seeall)

local var_0_0 = class("AiZiLaGamePackViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_Items"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = AiZiLaGoodsItem.prefabPath
	var_1_1.cellClass = AiZiLaGoodsItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 5
	var_1_1.cellWidth = 270
	var_1_1.cellHeight = 250
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0

	table.insert(var_1_0, LuaListScrollView.New(AiZiLaGamePackListModel.instance, var_1_1))
	table.insert(var_1_0, AiZiLaGamePackView.New())

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return var_0_0
