module("modules.logic.bossrush.view.v2a9.V2a9_BossRushSkillBackpackViewContainer", package.seeall)

local var_0_0 = class("V2a9_BossRushSkillBackpackViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "root/#scroll_item"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "root/#scroll_item/viewport/content/#go_item"
	var_1_1.cellClass = V2a9_BossRushSkillBackpackItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 3
	var_1_1.cellWidth = 230
	var_1_1.cellHeight = 230
	var_1_1.cellSpaceV = 40
	var_1_1.cellSpaceH = 40

	table.insert(var_1_0, LuaListScrollView.New(V2a9BossRushSkillBackpackListModel.instance, var_1_1))
	table.insert(var_1_0, V2a9_BossRushSkillBackpackView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "root/#go_topleft"))

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
	end
end

return var_0_0
