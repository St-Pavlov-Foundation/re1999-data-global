module("modules.logic.bossrush.view.v2a1.V2a1_BossRush_OfferRoleViewContainer", package.seeall)

slot0 = class("V2a1_BossRush_OfferRoleViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "root/Left/#scroll_Char"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = V2a1_BossRush_OfferRoleItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 2
	slot1.cellWidth = 200
	slot1.cellHeight = 225
	slot1.cellSpaceH = 20
	slot1.cellSpaceV = 20

	return {
		LuaListScrollView.New(BossRushEnhanceRoleViewListModel.instance, slot1),
		V2a1_BossRush_OfferRoleView.New()
	}
end

return slot0
