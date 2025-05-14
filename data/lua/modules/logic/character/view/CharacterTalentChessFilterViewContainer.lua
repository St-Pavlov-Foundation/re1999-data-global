module("modules.logic.character.view.CharacterTalentChessFilterViewContainer", package.seeall)

local var_0_0 = class("CharacterTalentChessFilterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "container/Scroll View"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "container/Scroll View/Viewport/Content/#go_item"
	var_1_0.cellClass = CharacterTalentChessFilterItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 646
	var_1_0.cellHeight = 162
	var_1_0.cellSpaceV = 0

	local var_1_1 = LuaListScrollView.New(TalentStyleListModel.instance, var_1_0)

	return {
		var_1_1,
		CharacterTalentChessFilterView.New()
	}
end

return var_0_0
