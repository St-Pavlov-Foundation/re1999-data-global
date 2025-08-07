module("modules.logic.sp01.odyssey.view.OdysseyLevelRewardViewContainer", package.seeall)

local var_0_0 = class("OdysseyLevelRewardViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0:buildLevelScrollViews()
	table.insert(var_1_0, OdysseyLevelRewardView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(var_1_0, arg_1_0.scrollView)

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.buildLevelScrollViews(arg_3_0)
	local var_3_0 = ListScrollParam.New()

	var_3_0.scrollGOPath = "root/Reward/#scroll_RewardList"
	var_3_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_3_0.prefabUrl = "root/Reward/#scroll_RewardList/Viewport/#go_Content/#go_rewarditem"
	var_3_0.cellClass = OdysseyLevelRewardItem
	var_3_0.scrollDir = ScrollEnum.ScrollDirH
	var_3_0.lineCount = 1
	var_3_0.cellWidth = 384
	var_3_0.cellHeight = 300
	var_3_0.cellSpaceH = 42
	var_3_0.cellSpaceV = 0
	var_3_0.startSpace = 18
	var_3_0.frameUpdateMs = 100
	arg_3_0.scrollView = LuaListScrollView.New(OdysseyTaskModel.instance, var_3_0)
end

return var_0_0
