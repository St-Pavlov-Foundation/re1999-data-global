module("modules.logic.rouge.view.RougeCollectionGiftViewItem", package.seeall)

slot0 = class("RougeCollectionGiftViewItem", RougeSimpleItemBase)

function slot0.onInitView(slot0)
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_select")
	slot0._gotagitem = gohelper.findChild(slot0.viewGO, "tags/#go_tagitem")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "tags/#go_tips")
	slot0._txttagitem = gohelper.findChildText(slot0.viewGO, "tags/#go_tips/#txt_tagitem")
	slot0._goenchantlist = gohelper.findChild(slot0.viewGO, "#go_enchantlist")
	slot0._gohole = gohelper.findChild(slot0.viewGO, "#go_enchantlist/#go_hole")
	slot0._gogrid = gohelper.findChild(slot0.viewGO, "Grid/#go_grid")
	slot0._simagecollection = gohelper.findChildSingleImage(slot0.viewGO, "#simage_collection")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._goskillcontainer = gohelper.findChild(slot0.viewGO, "scroll_desc/Viewport/#go_skillcontainer")
	slot0._goskillitem = gohelper.findChild(slot0.viewGO, "scroll_desc/Viewport/#go_skillcontainer/#go_skillitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.ctor(slot0, slot1)
	RougeSimpleItemBase.ctor(slot0, slot1)
end

function slot0._btnclickOnClick(slot0)
end

function slot0.addEventListeners(slot0)
	RougeSimpleItemBase.addEventListeners(slot0)
	slot0._itemClick:AddClickListener(slot0._onItemClick, slot0)
end

function slot0.removeEventListeners(slot0)
	RougeSimpleItemBase.removeEventListeners(slot0)
	GameUtil.onDestroyViewMember_ClickListener(slot0, "_itemClick")
end

function slot0.onDestroyView(slot0)
	RougeSimpleItemBase.onDestroyView(slot0)
	slot0._simagecollection:UnLoadImage()
	GameUtil.onDestroyViewMemberList(slot0, "_tagObjList")
	GameUtil.onDestroyViewMemberList(slot0, "_tipsTagObjList")
end

function slot0._onItemClick(slot0)
	slot0:baseViewContainer():dispatchEvent(RougeEvent.RougeCollectionGiftView_OnSelectIndex, slot0:index())
end

function slot0.setSelected(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)
end

function slot0._editableInitView(slot0)
	RougeSimpleItemBase._editableInitView(slot0)

	slot0._gridList = slot0:getUserDataTb_()
	slot0._tagObjList = {}
	slot0._tipsTagObjList = {}

	slot0:_onSetScrollParentGameObject(gohelper.findChild(slot0.viewGO, "scroll_desc"):GetComponent(gohelper.Type_LimitedScrollRect))

	slot0._itemClick = gohelper.getClickWithAudio(slot0.viewGO)
	slot0._gridLayout = gohelper.findChild(slot0.viewGO, "Grid")
	slot0._txttagitemGo = slot0._txttagitem.gameObject

	gohelper.setActive(slot0._gohole, false)
	gohelper.setActive(slot0._gogrid, false)
	gohelper.setActive(slot0._gotagitem, false)
	gohelper.setActive(slot0._txttagitemGo, false)
	slot0:setSelected(false)
	slot0:_setActiveLTTips(false)
end

function slot0.setData(slot0, slot1)
	if slot1.type == RougeCollectionGiftView.Type.DropGroup then
		slot0:_onUpdateMO_DropGroup(slot1)
	else
		slot0:_onUpdateMO_default(slot1)
	end
end

function slot0._onUpdateMO_default(slot0, slot1)
	slot0:_createDescList(slot1.descList)
	GameUtil.loadSImage(slot0._simagecollection, slot1.resUrl)

	slot0._txtname.text = slot1.title
end

function slot0._onUpdateMO_DropGroup(slot0, slot1)
	slot3 = slot1.data.collectionId

	slot0:_createDescList(slot1.descList)

	slot4 = RougeCollectionConfig.instance:getCollectionCfg(slot3)

	slot0:_refreshHole(slot4.holeNum)
	slot0:_refreshGrids(slot3)
	slot0:_refreshTagList(slot4.tags or {})
	GameUtil.loadSImage(slot0._simagecollection, RougeCollectionHelper.getCollectionIconUrl(slot3))

	slot0._txtname.text = RougeCollectionConfig.instance:getCollectionName(slot3)
end

function slot0._refreshHole(slot0, slot1)
	gohelper.CreateNumObjList(slot0._goenchantlist, slot0._gohole, slot1 or 0)
end

function slot0._refreshGrids(slot0, slot1)
	RougeCollectionHelper.loadShapeGrid(slot1, slot0._gridLayout, slot0._gogrid, slot0._gridList)
end

function slot0._createDescList(slot0, slot1)
	gohelper.CreateObjList(slot0, slot0._descListCallback, slot1, slot0._goskillcontainer, slot0._goskillitem)
end

function slot0._descListCallback(slot0, slot1, slot2, slot3)
	gohelper.findChildText(slot1, "txt_desc").text = slot2
end

function slot0._refreshTagList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = nil

		if slot5 > #slot0._tagObjList then
			table.insert(slot0._tagObjList, slot0:_create_RougeCollectionInitialCollectionTagItem(slot5))
		else
			slot7 = slot0._tagObjList[slot5]
		end

		slot7:onUpdateMO(slot6)
		slot7:setActive(true)

		slot8 = nil

		if slot5 > #slot0._tipsTagObjList then
			table.insert(slot0._tipsTagObjList, slot0:_create_RougeCollectionInitialCollectionTipsTagItem(slot5))
		else
			slot8 = slot0._tipsTagObjList[slot5]
		end

		slot8:onUpdateMO(slot6)
		slot8:setActive(true)
	end

	for slot6 = #slot1 + 1, math.max(#slot0._tagObjList, #slot0._tipsTagObjList) do
		if slot0._tagObjList[slot6] then
			slot7:setActive(false)
		end

		if slot0._tipsTagObjList[slot6] then
			slot8:setActive(false)
		end
	end
end

function slot0._create_RougeCollectionInitialCollectionTagItem(slot0, slot1)
	slot3 = RougeCollectionInitialCollectionTagItem.New({
		parent = slot0,
		baseViewContainer = slot0:baseViewContainer()
	})

	slot3:setIndex(slot1)
	slot3:init(gohelper.cloneInPlace(slot0._gotagitem))

	return slot3
end

function slot0._create_RougeCollectionInitialCollectionTipsTagItem(slot0, slot1)
	slot3 = RougeCollectionInitialCollectionTipsTagItem.New({
		parent = slot0,
		baseViewContainer = slot0:baseViewContainer()
	})

	slot3:setIndex(slot1)
	slot3:init(gohelper.cloneInPlace(slot0._txttagitemGo))

	return slot3
end

function slot0.setActiveTips(slot0, slot1)
	gohelper.setActive(slot0._gotips, slot1)
	slot0:parent():setActiveBlock(slot1)
end

function slot0.onCloseBlock(slot0)
	slot0:_setActiveLTTips(false)
end

function slot0._setActiveLTTips(slot0, slot1)
	gohelper.setActive(slot0._gotips, slot1)
end

return slot0
