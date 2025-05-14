module("modules.logic.herogroup.view.HeroGroupRecommendViewContainer", package.seeall)

local var_0_0 = class("HeroGroupRecommendViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#scroll_character"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = HeroGroupRecommendCharacterItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 482
	var_1_0.cellHeight = 172
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 7.19
	var_1_0.startSpace = 0

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_group"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[2]
	var_1_1.cellClass = HeroGroupRecommendGroupItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 1362
	var_1_1.cellHeight = 172
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 7.19
	var_1_1.startSpace = 0

	local var_1_2 = {}
	local var_1_3

	for iter_1_0 = 1, 5 do
		var_1_2[iter_1_0] = (iter_1_0 - 1) * 0.06
	end

	return {
		HeroGroupRecommendView.New(),
		LuaListScrollViewWithAnimator.New(HeroGroupRecommendCharacterListModel.instance, var_1_0, var_1_2),
		LuaListScrollViewWithAnimator.New(HeroGroupRecommendGroupListModel.instance, var_1_1, var_1_2),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
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
