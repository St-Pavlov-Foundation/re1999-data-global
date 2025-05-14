module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationGiftRewardViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_3NewCultivationGiftRewardViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#scroll_reward"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "#scroll_reward/viewport/content/#go_rewarditem"
	var_1_0.cellClass = VersionActivity2_3NewCultivationRewardItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 6
	var_1_0.cellWidth = 250
	var_1_0.cellHeight = 250
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 0
	var_1_0.startSpace = 20
	var_1_0.endSpace = 10
	var_1_0.minUpdateCountInFrame = 100

	local var_1_1 = {}

	table.insert(var_1_1, VersionActivity2_3NewCultivationGiftRewardView.New())
	table.insert(var_1_1, LuaListScrollView.New(VersionActivity2_3NewCultivationGiftRewardListModel.instance, var_1_0))

	return var_1_1
end

return var_0_0
