module("modules.logic.rouge.view.RougeCollectionInitialCollectionItem", package.seeall)

slot0 = class("RougeCollectionInitialCollectionItem", RougeSimpleItemBase)

function slot0.onInitView(slot0)
	slot0._goenchantlist = gohelper.findChild(slot0.viewGO, "#go_enchantlist")
	slot0._gohole = gohelper.findChild(slot0.viewGO, "#go_enchantlist/#go_hole")
	slot0._gogrid = gohelper.findChild(slot0.viewGO, "Grid/#go_grid")
	slot0._simagecollection = gohelper.findChildSingleImage(slot0.viewGO, "#simage_collection")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._godescContent = gohelper.findChild(slot0.viewGO, "scroll_desc/Viewport/#go_descContent")
	slot0._godescitem = gohelper.findChild(slot0.viewGO, "scroll_desc/Viewport/#go_descContent/#go_descitem")
	slot0._gotags = gohelper.findChild(slot0.viewGO, "#go_tags")
	slot0._gotagitem = gohelper.findChild(slot0.viewGO, "#go_tags/#go_tagitem")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tags/#go_tagitem/#btn_click")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_tags/#go_tips")
	slot0._txttagitem = gohelper.findChildText(slot0.viewGO, "#go_tags/#go_tips/#txt_tagitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0.ctor(slot0, slot1)
	RougeSimpleItemBase.ctor(slot0, slot1)
end

function slot0._btnclickOnClick(slot0)
end

function slot0._editableInitView(slot0)
	RougeSimpleItemBase._editableInitView(slot0)

	slot0._tagObjList = {}
	slot0._tipsTagObjList = {}
	slot0._itemInstTab = slot0:getUserDataTb_()
	slot0._descParams = {
		isAllActive = true
	}
	slot0._txttagitemGo = slot0._txttagitem.gameObject
	slot0._gridGo = gohelper.findChild(slot0.viewGO, "Grid")
	slot0._scrollViewLimitScrollCmp = gohelper.findChild(slot0.viewGO, "scroll_desc"):GetComponent(gohelper.Type_LimitedScrollRect)

	slot0:_onSetScrollParentGameObject(slot0._scrollViewLimitScrollCmp)
	gohelper.setActive(slot0._gotagitem, false)
	gohelper.setActive(slot0._txttagitemGo, false)
	slot0:_setActiveLTTips(false)
	RougeController.instance:registerCallback(RougeEvent.SwitchCollectionInfoType, slot0._onSwitchCollectionInfoType, slot0)
end

function slot0.onDestroyView(slot0)
	GameUtil.onDestroyViewMember_SImage(slot0, "_simagecollection")
	GameUtil.onDestroyViewMemberList(slot0, "_tagObjList")
	GameUtil.onDestroyViewMemberList(slot0, "_tipsTagObjList")
	RougeController.instance:unregisterCallback(RougeEvent.SwitchCollectionInfoType, slot0._onSwitchCollectionInfoType, slot0)
end

function slot0.setData(slot0, slot1)
	if not RougeCollectionConfig.instance:getCollectionCfg(slot1) then
		logError("not found collectionCfgId" .. tostring(slot2))

		return
	end

	slot0._collectionCfgId = slot2

	slot0._simagecollection:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot2))
	gohelper.CreateNumObjList(slot0._goenchantlist, slot0._gohole, slot3.holeNum or 0)

	slot0._txtname.text = RougeCollectionConfig.instance:getCollectionName(slot2)

	RougeCollectionHelper.loadShapeGrid(slot2, slot0._gridGo, slot0._gogrid)
	slot0:_refreshDesc()
	slot0:_refreshTagList(slot3.tags or {})
end

function slot0._refreshDesc(slot0)
	RougeCollectionDescHelper.setCollectionDescInfos2(slot0._collectionCfgId, nil, slot0._godescContent, slot0._itemInstTab, nil, slot0._descParams)
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
	slot0:_setActiveLTTips(slot1)
	slot0:parent():setActiveBlock(slot1)
end

function slot0.onCloseBlock(slot0)
	slot0:_setActiveLTTips(false)
end

function slot0._setActiveLTTips(slot0, slot1)
	gohelper.setActive(slot0._gotips, slot1)
end

function slot0._onSwitchCollectionInfoType(slot0)
	slot0:_refreshDesc()
end

return slot0
