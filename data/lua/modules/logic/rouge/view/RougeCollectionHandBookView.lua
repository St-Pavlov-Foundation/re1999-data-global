module("modules.logic.rouge.view.RougeCollectionHandBookView", package.seeall)

slot0 = class("RougeCollectionHandBookView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_fullbg")
	slot0._btnfilter = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_filter")
	slot0._scrollcollection = gohelper.findChildScrollRect(slot0.viewGO, "Left/#scroll_collection")
	slot0._txtTitleEn = gohelper.findChildText(slot0.viewGO, "Left/#scroll_collection/Viewport/Content/item/smalltitle/txt_Title/#txt_TitleEn")
	slot0._gocollectionitem = gohelper.findChild(slot0.viewGO, "Left/#scroll_collection/Viewport/Content/#go_collectionitem")
	slot0._imagebg = gohelper.findChildImage(slot0.viewGO, "Left/#scroll_collection/Viewport/Content/item/#go_collectionitem/normal/#image_bg")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "Left/#scroll_collection/Viewport/Content/item/#go_collectionitem/normal/#txt_num")
	slot0._simagecollection = gohelper.findChildSingleImage(slot0.viewGO, "Left/#scroll_collection/Viewport/Content/item/#go_collectionitem/normal/#simage_collection")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "Right/top/#simage_icon")
	slot0._txtcollectionname = gohelper.findChildText(slot0.viewGO, "Right/top/#txt_collectionname")
	slot0._gobasetags = gohelper.findChild(slot0.viewGO, "Right/top/tags/#go_basetags")
	slot0._gobasetagitem = gohelper.findChild(slot0.viewGO, "Right/top/tags/#go_basetags/#go_basetagitem")
	slot0._goextratags = gohelper.findChild(slot0.viewGO, "Right/top/tags/#go_extratags")
	slot0._goextratagitem = gohelper.findChild(slot0.viewGO, "Right/top/tags/#go_extratags/#go_extratagitem")
	slot0._goshapecell = gohelper.findChild(slot0.viewGO, "Right/top/layout/shape/#go_shapecell")
	slot0._scrollcollectiondesc = gohelper.findChildScrollRect(slot0.viewGO, "Right/top/#scroll_collectiondesc")
	slot0._godescContent = gohelper.findChild(slot0.viewGO, "Right/top/#scroll_collectiondesc/Viewport/#go_descContent")
	slot0._godescitem = gohelper.findChild(slot0.viewGO, "Right/top/#scroll_collectiondesc/Viewport/#go_descContent/#go_descitem")
	slot0._btnhandbook = gohelper.findChildButtonWithAudio(slot0.viewGO, "Bottom/#btn_handbook")
	slot0._goholecontainer = gohelper.findChild(slot0.viewGO, "Right/top/layout/#go_holecontainer")
	slot0._goholeitem = gohelper.findChild(slot0.viewGO, "Right/top/layout/#go_holecontainer/#go_holeitem")
	slot0._gocompositelayout = gohelper.findChild(slot0.viewGO, "Right/top/need/#go_compositelayout")
	slot0._gocompositeitem = gohelper.findChild(slot0.viewGO, "Right/top/need/#go_compositelayout/#go_compositeitem")
	slot0._gocancomposite = gohelper.findChild(slot0.viewGO, "Right/top/layout/#go_cancomposite")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_empty")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnfilter:AddClickListener(slot0._btnfilterOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnfilter:RemoveClickListener()
end

function slot0._btnfilterOnClick(slot0)
	RougeController.instance:openRougeCollectionFilterView({
		confirmCallback = slot0.onConfirmTagFilterCallback,
		confirmCallbackObj = slot0,
		baseSelectMap = slot0._baseTagSelectMap,
		extraSelectMap = slot0._extraTagSelectMap
	})
end

function slot0.onConfirmTagFilterCallback(slot0, slot1, slot2)
	slot0:filterCompositeList(slot1, slot2)
	slot0:refreshFilterButtonUI()
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnSelectCollectionHandBookItem, slot0._onSelectHandBookItem, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, slot0._onSwitchCollectionInfoType, slot0)

	slot0._compositeItemTab = slot0:getUserDataTb_()
	slot0._collectionCellTab = slot0:getUserDataTb_()
	slot0._itemInstTab = slot0:getUserDataTb_()
	slot0._baseTagSelectMap = {}
	slot0._extraTagSelectMap = {}
	slot0._goshapecontainer = gohelper.findChild(slot0.viewGO, "Right/top/layout/shape")
	slot0._aniamtor = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_Animator)
	slot0._goright = gohelper.findChild(slot0.viewGO, "Right")
	slot0._rightAnimator = gohelper.onceAddComponent(slot0._goright, gohelper.Type_Animator)
end

function slot0.onOpen(slot0)
	RougeCollectionHandBookListModel.instance:onInit()
	slot0:refreshSelectCollectionInfo()
	slot0._aniamtor:Play("open", 0, 0)
end

function slot0.refreshSelectCollectionInfo(slot0)
	gohelper.setActive(slot0._goright, RougeCollectionHandBookListModel.instance:getById(RougeCollectionHandBookListModel.instance:getCurSelectCellId()) ~= nil)
	gohelper.setActive(slot0._goempty, slot2 == nil)

	if not slot2 then
		return
	end

	if not RougeCollectionConfig.instance:getCollectionCfg(slot2.product) then
		return
	end

	slot0._productId = slot3

	slot0._simageicon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot3))

	slot0._txtcollectionname.text = RougeCollectionConfig.instance:getCollectionName(slot3)

	slot0:refrehsCollectionDesc()
	gohelper.CreateObjList(slot0, slot0.refreshCollectionTagIcon, slot4.tags, slot0._gobasetags, slot0._gobasetagitem)
	gohelper.CreateNumObjList(slot0._goholecontainer, slot0._goholeitem, slot4.holeNum)
	gohelper.setActive(slot0._goholecontainer, slot4.holeNum > 0)
	gohelper.CreateObjList(slot0, slot0.refreshCompositeItem, RougeCollectionConfig.instance:getCollectionCompositeIds(slot1) or {}, slot0._gocompositelayout, slot0._gocompositeitem)
	RougeCollectionHelper.loadShapeGrid(slot3, slot0._goshapecontainer, slot0._goshapecell, slot0._collectionCellTab, false)
	gohelper.setActive(slot0._gocancomposite, RougeCollectionModel.instance:checkIsCanCompositeCollection(slot1))
end

function slot0.refrehsCollectionDesc(slot0)
	RougeCollectionDescHelper.setCollectionDescInfos2(slot0._productId, nil, slot0._godescContent, slot0._itemInstTab)
end

function slot0.refreshCollectionTagIcon(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setRougeSprite(gohelper.findChildImage(slot1, "image_tagicon"), lua_rouge_tag.configDict[slot2].iconUrl)
	UISpriteSetMgr.instance:setRougeSprite(gohelper.findChildImage(slot1, "image_tagframe"), "rouge_collection_tagframe_1")
end

function slot0.refreshCompositeItem(slot0, slot1, slot2, slot3)
	if not RougeCollectionConfig.instance:getCollectionCfg(slot2) then
		return
	end

	gohelper.findChildSingleImage(slot1, "normal/#simage_collection"):LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot2))

	gohelper.findChildText(slot1, "normal/#txt_num").text = tostring(RougeEnum.CompositeCollectionCostCount)

	UISpriteSetMgr.instance:setRougeSprite(gohelper.findChildImage(slot1, "normal/#image_bg"), "rouge_episode_collectionbg_" .. tostring(slot4.showRare))

	slot0._compositeItemTab[slot3] = slot0._compositeItemTab[slot3] or slot0:getUserDataTb_()
	slot0._compositeItemTab[slot3].icon = slot5
	slot8 = gohelper.findChildButtonWithAudio(slot1, "normal/#btn_click")

	slot8:RemoveClickListener()
	slot8:AddClickListener(slot0.clickCompositeItemCallBack, slot0, slot2)

	slot0._compositeItemTab[slot3].btnClick = slot8
end

function slot0.clickCompositeItemCallBack(slot0, slot1)
	RougeController.instance:openRougeCollectionTipView({
		collectionCfgId = slot1,
		viewPosition = RougeEnum.CollectionTipPos.HandBook
	})
end

function slot0.releaseCompositeIconSingleImages(slot0)
	if slot0._compositeItemTab then
		for slot4, slot5 in pairs(slot0._compositeItemTab) do
			if slot5 and slot5.icon then
				slot5.icon:UnLoadImage()
			end

			if slot5 and slot5.btnClick then
				slot5.btnClick:RemoveClickListener()
			end
		end
	end
end

function slot0._onSelectHandBookItem(slot0, slot1)
	if slot1 == RougeCollectionHandBookListModel.instance:getCurSelectCellId() then
		return
	end

	RougeCollectionHandBookListModel.instance:selectCell(RougeCollectionHandBookListModel.instance:getIndex(RougeCollectionHandBookListModel.instance:getById(slot1)), true)
	slot0:delay2SwitchHandBookItem(uv0.DelayTime2SwitchCollection)
	slot0._rightAnimator:Play("switch", 0, 0)
end

slot0.DelayTime2SwitchCollection = 0.3

function slot0.delay2SwitchHandBookItem(slot0, slot1)
	TaskDispatcher.cancelTask(slot0.refreshSelectCollectionInfo, slot0)
	TaskDispatcher.runDelay(slot0.refreshSelectCollectionInfo, slot0, slot1 or 0)
end

function slot0.filterCompositeList(slot0, slot1, slot2)
	RougeCollectionHandBookListModel.instance:updateFilterMap(slot1, slot2)

	if RougeCollectionHandBookListModel.instance:getCurSelectCellId() ~= RougeCollectionHandBookListModel.instance:getCurSelectCellId() then
		slot0:refreshSelectCollectionInfo()
	end
end

function slot0.refreshFilterButtonUI(slot0)
	slot0:_setFilterSelected(RougeCollectionHandBookListModel.instance:isFiltering())
end

function slot0._setFilterSelected(slot0, slot1)
	gohelper.setActive(gohelper.findChild(slot0._btnfilter.gameObject, "select"), slot1)
	gohelper.setActive(gohelper.findChild(slot0._btnfilter.gameObject, "unselect"), not slot1)
end

function slot0._onSwitchCollectionInfoType(slot0)
	slot0:refrehsCollectionDesc()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageicon:UnLoadImage()
	slot0:releaseCompositeIconSingleImages()
	TaskDispatcher.cancelTask(slot0.refreshSelectCollectionInfo, slot0)
end

return slot0
