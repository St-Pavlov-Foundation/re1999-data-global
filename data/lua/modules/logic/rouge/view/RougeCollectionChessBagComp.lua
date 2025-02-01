module("modules.logic.rouge.view.RougeCollectionChessBagComp", package.seeall)

slot0 = class("RougeCollectionChessBagComp", BaseView)

function slot0.onInitView(slot0)
	slot0._golistbag = gohelper.findChild(slot0.viewGO, "chessboard/#go_listbag")
	slot0._golistbagitem = gohelper.findChild(slot0.viewGO, "chessboard/#go_listbag/#go_listbagitem")
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_pagearea/#btn_next")
	slot0._btnlast = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_pagearea/#btn_last")
	slot0._txtcurpage = gohelper.findChildText(slot0.viewGO, "#go_pagearea/#txt_curpage")
	slot0._gosizebag = gohelper.findChild(slot0.viewGO, "chessboard/#go_sizebag")
	slot0._gosizeitem = gohelper.findChild(slot0.viewGO, "chessboard/#go_sizebag/#go_sizecollections/#go_sizeitem")
	slot0._btnlayout = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_layout")
	slot0._btnfilter = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_filter")
	slot0._gosizecellcontainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_sizebag/#go_sizecellcontainer")
	slot0._gosizecell = gohelper.findChild(slot0.viewGO, "chessboard/#go_sizebag/#go_sizecellcontainer/#go_sizecell")
	slot0._gosizecollections = gohelper.findChild(slot0.viewGO, "chessboard/#go_sizebag/#go_sizecellcontainer/#go_sizecollections")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "chessboard/#go_empty")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
	slot0._btnlast:AddClickListener(slot0._btnlastOnClick, slot0)
	slot0._btnlayout:AddClickListener(slot0._btnlayoutOnClick, slot0)
	slot0._btnfilter:AddClickListener(slot0._btnfilterOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnext:RemoveClickListener()
	slot0._btnlast:RemoveClickListener()
	slot0._btnlayout:RemoveClickListener()
	slot0._btnfilter:RemoveClickListener()
end

function slot0._btnnextOnClick(slot0)
	slot0:switchPage(true)
end

function slot0._btnlastOnClick(slot0)
	slot0:switchPage(false)
end

function slot0._btnlayoutOnClick(slot0)
	slot0:onSwitchLayoutType(not slot0._isListLayout)
	slot0:playSwitchLayoutAnim()
	RougeCollectionChessController.instance:closeCollectionTipView()
end

function slot0._btnfilterOnClick(slot0)
	RougeCollectionChessController.instance:closeCollectionTipView()
	RougeController.instance:openRougeCollectionFilterView({
		confirmCallback = slot0.onConfirmTagFilterCallback,
		confirmCallbackObj = slot0,
		baseSelectMap = slot0._baseTagSelectMap,
		extraSelectMap = slot0._extraTagSelectMap
	})
end

function slot0.onConfirmTagFilterCallback(slot0, slot1, slot2)
	slot0:onFilterCollectionBag(slot1, slot2)
	slot0:refreshFilterButtonUI()
end

function slot0._editableInitView(slot0)
	slot0._sizeCollections = {}
	slot0._sizePlaceCollectionCache = {}
	slot0._listCollections = {}
	slot0._isListLayout = true
	slot0._baseTagSelectMap = {}
	slot0._extraTagSelectMap = {}

	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.UpdateCollectionBag, slot0.updateCollectionBag, slot0)

	slot0._animator = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_Animator)

	gohelper.setActive(slot0._golistbagitem, false)
	gohelper.setActive(slot0._gosizeitem, false)
end

function slot0.onOpen(slot0)
	slot0._curPageIndex = 1

	slot0:buildCollectionSizeBagPlaceInfo()
	slot0:onSwitchLayoutType(true)
end

slot1 = 4

function slot0.updateBagList(slot0, slot1, slot2)
	slot1 = slot1 or 0
	slot2 = slot2 or 0
	slot5 = {}

	if (RougeCollectionBagListModel.instance:getList() and #slot3) > 0 then
		slot6 = (slot1 - 1) * uv0 + 1

		if slot4 < slot1 * uv0 then
			slot7 = slot4 or slot7
		end

		if slot6 <= slot7 then
			for slot11 = slot6, slot7 do
				slot12 = RougeCollectionBagListModel.instance:getByIndex(slot11)

				if not slot0._listCollections[slot11 - slot6 + 1] then
					slot14 = RougeCollectionBagItem.New()

					slot14:onInitView(slot0, gohelper.cloneInPlace(slot0._golistbagitem, "bagItem_" .. slot13))

					slot0._listCollections[slot13] = slot14
				end

				slot14:reset()
				slot14:onUpdateMO(slot12)

				slot5[slot14] = true
			end
		end
	end

	if slot5 and slot0._listCollections then
		for slot9, slot10 in pairs(slot0._listCollections) do
			if not slot5[slot10] then
				slot10:reset()
			end
		end
	end

	slot0._curPageIndex = slot1
	slot0._txtcurpage.text = string.format("%s / %s", slot1, slot2)
end

function slot0.switchPage(slot0, slot1)
	if Mathf.Clamp(slot1 and slot0._curPageIndex + 1 or slot0._curPageIndex - 1, slot0:getTotalPageCount() > 0 and 1 or 0, slot3) == slot0._curPageIndex then
		return
	end

	if slot0._isListLayout then
		slot0:updateBagList(slot2, slot3)
	else
		slot0:updateSizeList(slot2, slot3)
	end

	slot0:refreshButtonUI(slot2, slot4, slot3)
	slot0:playSwitchLayoutAnim()
	RougeCollectionChessController.instance:closeCollectionTipView()
end

function slot0.getTotalPageCount(slot0)
	slot1 = 0

	return (not slot0._isListLayout or math.ceil(RougeCollectionBagListModel.instance:getCount() / uv0)) and tabletool.len(slot0._sizePlaceCollectionCache)
end

function slot0.updateSizeList(slot0, slot1, slot2)
	slot0._curPageIndex = slot1

	slot0:placeCollection2SizeBag(slot1)

	slot0._txtcurpage.text = string.format("%s / %s", slot1, slot2)
end

function slot0.buildCollectionSizeBagPlaceInfo(slot0)
	slot0._unplaceCollections = tabletool.copy(RougeCollectionBagListModel.instance:getList())

	table.sort(slot0._unplaceCollections, slot0.sortCollectionByRare)

	slot2 = 1
	slot0._sizePlaceCollectionCache = {}
	slot3 = 200
	slot4 = Vector2(0, 0)

	while #slot0._unplaceCollections > 0 and slot3 > 0 do
		slot0:buildPlaceCollectionInfo(slot4, RougeEnum.MaxCollectionBagSize, slot0._unplaceCollections, slot2)

		slot2 = slot2 + 1
		slot3 = slot3 - 1
	end

	if slot3 <= 0 then
		logError("构建肉鸽造物背包摆放数据时循环执行超过< %s >次,请检查!!!", slot3)
	end
end

function slot0.buildPlaceCollectionInfo(slot0, slot1, slot2, slot3, slot4, slot5)
	slot5 = slot5 or 1

	if not slot3 or not slot3[slot5] or slot2.x < 1 or slot2.y < 1 then
		return
	end

	slot7, slot8 = RougeCollectionConfig.instance:getShapeSize(slot3[slot5].cfgId)

	if slot7 <= 0 or slot8 <= 0 then
		table.remove(slot3, slot5)
		logError("获取造物形状范围不可小于0, id = " .. tostring(slot6.cfgId))

		return
	end

	if slot2.x < slot7 or slot2.y < slot8 then
		return slot0:buildPlaceCollectionInfo(slot1, slot2, slot3, slot4, slot5 + 1)
	end

	table.remove(slot3, slot5)

	slot0._sizePlaceCollectionCache[slot4] = slot0._sizePlaceCollectionCache[slot4] or {}

	table.insert(slot0._sizePlaceCollectionCache[slot4], {
		id = slot6.id,
		startPlacePos = slot1
	})
	slot0:buildPlaceCollectionInfo(slot1 + Vector2(slot7, 0), Vector2(slot2.x - slot7, slot8), slot3, slot4)
	slot0:buildPlaceCollectionInfo(slot1 + Vector2(0, slot8), Vector2(slot2.x, slot2.y - slot8), slot3, slot4)
end

slot2 = Vector2(104, 104)

function slot0.placeCollection2SizeBag(slot0, slot1)
	slot3 = {}

	if slot0._sizePlaceCollectionCache and slot0._sizePlaceCollectionCache[slot1] then
		for slot7 = 1, #slot2 do
			if not slot0._sizeCollections[slot7] then
				slot8 = slot0.viewContainer:getRougePoolComp():getCollectionItem(RougeCollectionSizeBagItem.__cname)

				slot8:onInit(gohelper.cloneInPlace(slot0._gosizeitem, "item_" .. slot7))

				slot0._sizeCollections[slot7] = slot8
			end

			slot3[slot8] = true

			slot8:reset()
			slot8:setPerCellWidthAndHeight(uv0.x, uv0.y)
			slot8:onUpdateMO(RougeCollectionModel.instance:getCollectionByUid(slot2[slot7].id))

			slot10 = slot2[slot7].startPlacePos

			recthelper.setAnchor(slot8.viewGO.transform, slot10.x * uv0.x, -slot10.y * uv0.y)
		end
	end

	if slot3 and slot0._sizeCollections then
		for slot7, slot8 in pairs(slot0._sizeCollections) do
			if not slot3[slot8] then
				slot8:reset()
			end
		end
	end
end

function slot0.onSwitchLayoutType(slot0, slot1)
	slot0._isListLayout = slot1

	gohelper.setActive(slot0._golistbag, slot0._isListLayout)
	gohelper.setActive(slot0._gosizebag, not slot0._isListLayout)
	gohelper.setActive(slot0._goempty, slot2 <= 0)

	slot0._curPageIndex = Mathf.Clamp(slot0._curPageIndex, slot0:getTotalPageCount() > 0 and 1 or 0, slot2)

	if slot0._isListLayout then
		slot0:updateBagList(slot0._curPageIndex, slot2)
	else
		slot0:updateSizeList(slot0._curPageIndex, slot2)
	end

	slot0:refreshButtonUI(slot0._curPageIndex, slot3, slot2)
	slot0:refreshLayoutButtonUI()
end

function slot0.refreshButtonUI(slot0, slot1, slot2, slot3)
	slot8 = slot3 >= slot1 + 1
	slot9 = slot2 <= slot1 - 1

	gohelper.setActive(gohelper.findChild(slot0._btnnext.gameObject, "light"), slot8)
	gohelper.setActive(gohelper.findChild(slot0._btnnext.gameObject, "dark"), not slot8)
	gohelper.setActive(gohelper.findChild(slot0._btnlast.gameObject, "light"), slot9)
	gohelper.setActive(gohelper.findChild(slot0._btnlast.gameObject, "dark"), not slot9)
end

function slot0.playSwitchLayoutAnim(slot0)
	slot0._animator:Play(slot0._isListLayout and "switch_listbg" or "switch_sizebag", 0, 0)
end

function slot0.sortCollectionByRare(slot0, slot1)
	if RougeCollectionConfig.instance:getCollectionCfg(slot0.cfgId).showRare ~= RougeCollectionConfig.instance:getCollectionCfg(slot1.cfgId).showRare then
		return slot3.showRare < slot2.showRare
	end

	return slot2.id < slot3.id
end

function slot0.onFilterCollectionBag(slot0, slot1, slot2)
	RougeCollectionBagListModel.instance:onInitData(slot1, slot2)
	slot0:updateCollectionBag()
end

function slot0.updateCollectionBag(slot0)
	RougeCollectionBagListModel.instance:filterCollection()
	slot0:buildCollectionSizeBagPlaceInfo()
	slot0:onSwitchLayoutType(slot0._isListLayout)
end

function slot0.refreshFilterButtonUI(slot0)
	slot1 = RougeCollectionBagListModel.instance:isFiltering()

	gohelper.setActive(gohelper.findChild(slot0._btnfilter.gameObject, "select"), slot1)
	gohelper.setActive(gohelper.findChild(slot0._btnfilter.gameObject, "unselect"), not slot1)
end

function slot0.refreshLayoutButtonUI(slot0)
	gohelper.setActive(gohelper.findChild(slot0._btnlayout.gameObject, "select"), not slot0._isListLayout)
	gohelper.setActive(gohelper.findChild(slot0._btnlayout.gameObject, "unselect"), slot0._isListLayout)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._listCollections then
		for slot4, slot5 in pairs(slot0._listCollections) do
			slot5:destroy()
		end
	end

	if slot0._sizeCollections then
		for slot4, slot5 in pairs(slot0._sizeCollections) do
			slot5:destroy()
		end
	end
end

return slot0
