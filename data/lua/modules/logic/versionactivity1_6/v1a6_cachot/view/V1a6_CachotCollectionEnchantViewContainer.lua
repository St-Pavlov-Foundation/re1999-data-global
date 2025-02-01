module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionEnchantViewContainer", package.seeall)

slot0 = class("V1a6_CachotCollectionEnchantViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "left/#scroll_view"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "left/#scroll_view/Viewport/Content/#go_collectionbagitem"
	slot1.cellClass = V1a6_CachotEnchantBagItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 2
	slot1.cellWidth = 238
	slot1.cellHeight = 245
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = -8.3
	slot1.startSpace = 0
	slot1.endSpace = 0
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "right/#scroll_view"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "right/#scroll_view/Viewport/Content/#go_collectionenchantitem"
	slot2.cellClass = V1a6_CachotCollectionEnchantItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 615
	slot2.cellHeight = 235
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0.35
	slot2.startSpace = 0
	slot2.endSpace = 0
	slot0._collectionScrollView = LuaListScrollView.New(V1a6_CachotEnchantBagListModel.instance, slot1)
	slot0._enchantScrollView = LuaListScrollView.New(V1a6_CachotCollectionEnchantListModel.instance, slot2)
	slot0._collectionScrollView.onUpdateFinish = slot0.scrollFocusOnSelectCell

	return {
		V1a6_CachotCollectionEnchantView.New(),
		slot0._collectionScrollView,
		slot0._enchantScrollView
	}
end

function slot0.scrollFocusOnSelectCell(slot0)
	if not slot0:getFirstSelect() then
		return
	end

	slot4 = slot0._param.cellHeight + slot0._param.cellSpaceV

	if recthelper.getHeight(slot0._csListScroll.transform) < (math.ceil(slot0._model:getIndex(slot1) / slot0._param.lineCount) - 1) * slot4 + slot0._param.startSpace + slot4 - slot0._csListScroll.VerticalScrollPixel or slot7 < slot4 then
		slot0._csListScroll.VerticalScrollPixel = slot5
	end
end

return slot0
