module("modules.logic.bossrush.view.v2a1.V2a1_BossRush_OfferRoleViewContainer", package.seeall)

local var_0_0 = class("V2a1_BossRush_OfferRoleViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "root/Left/#scroll_Char"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = V2a1_BossRush_OfferRoleItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 2
	var_1_0.cellWidth = 200
	var_1_0.cellHeight = 225
	var_1_0.cellSpaceH = 20
	var_1_0.cellSpaceV = 20

	local var_1_1 = LuaListScrollView.New(BossRushEnhanceRoleViewListModel.instance, var_1_0)

	return {
		var_1_1,
		V2a1_BossRush_OfferRoleView.New()
	}
end

return var_0_0
