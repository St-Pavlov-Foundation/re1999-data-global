module("modules.logic.rouge.view.RougeCollectionListView", package.seeall)

slot0 = class("RougeCollectionListView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_fullbg")
	slot0._scrollcollection = gohelper.findChildScrollRect(slot0.viewGO, "Left/#scroll_collection")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "Left/#scroll_collection/Viewport/#go_content")
	slot0._btnfilter = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_filter")
	slot0._golayout = gohelper.findChild(slot0.viewGO, "Left/#go_layout")
	slot0._gosmalltitle = gohelper.findChild(slot0.viewGO, "Left/#go_smalltitle")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Left/#go_smalltitle/#txt_Title")
	slot0._txtTitleEn = gohelper.findChildText(slot0.viewGO, "Left/#go_smalltitle/#txt_Title/#txt_TitleEn")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "Left/#go_smalltitle/#image_icon")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "Right/#go_normal")
	slot0._simageicon1 = gohelper.findChildSingleImage(slot0.viewGO, "Right/#go_normal/#simage_icon1")
	slot0._txtcollectionname1 = gohelper.findChildText(slot0.viewGO, "Right/#go_normal/#txt_collectionname1")
	slot0._gobasetags1 = gohelper.findChild(slot0.viewGO, "Right/#go_normal/tags/#go_basetags1")
	slot0._gobasetagitem1 = gohelper.findChild(slot0.viewGO, "Right/#go_normal/tags/#go_basetags1/#go_basetagitem1")
	slot0._goextratags1 = gohelper.findChild(slot0.viewGO, "Right/#go_normal/tags/#go_extratags1")
	slot0._goextratagitem1 = gohelper.findChild(slot0.viewGO, "Right/#go_normal/tags/#go_extratags1/#go_extratagitem1")
	slot0._goshapecell1 = gohelper.findChild(slot0.viewGO, "Right/#go_normal/shape/#go_shapecell1")
	slot0._scrollcollectiondesc = gohelper.findChildScrollRect(slot0.viewGO, "Right/#go_normal/#scroll_collectiondesc")
	slot0._godescContent = gohelper.findChild(slot0.viewGO, "Right/#go_normal/#scroll_collectiondesc/Viewport/#go_descContent")
	slot0._godescitem = gohelper.findChild(slot0.viewGO, "Right/#go_normal/#scroll_collectiondesc/Viewport/#go_descContent/#go_descitem")
	slot0._golocked = gohelper.findChild(slot0.viewGO, "Right/#go_locked")
	slot0._txtlocked = gohelper.findChildText(slot0.viewGO, "Right/#go_locked/locked/#txt_locked")
	slot0._txtlockedName = gohelper.findChildText(slot0.viewGO, "Right/#go_locked/txt_locked")
	slot0._gounget = gohelper.findChild(slot0.viewGO, "Right/#go_unget")
	slot0._simageicon2 = gohelper.findChildSingleImage(slot0.viewGO, "Right/#go_unget/#simage_icon2")
	slot0._txtcollectionname2 = gohelper.findChildText(slot0.viewGO, "Right/#go_unget/#txt_collectionname2")
	slot0._gobasetags2 = gohelper.findChild(slot0.viewGO, "Right/#go_unget/tags/#go_basetags2")
	slot0._gobasetagitem2 = gohelper.findChild(slot0.viewGO, "Right/#go_unget/tags/#go_basetags2/#go_basetagitem2")
	slot0._goextratags2 = gohelper.findChild(slot0.viewGO, "Right/#go_unget/tags/#go_extratags2")
	slot0._goextratagitem2 = gohelper.findChild(slot0.viewGO, "Right/#go_unget/tags/#go_extratags2/#go_extratagitem2")
	slot0._goshapecell2 = gohelper.findChild(slot0.viewGO, "Right/#go_unget/shape/#go_shapecell2")
	slot0._gotips1 = gohelper.findChild(slot0.viewGO, "Right/#go_normal/tags/#go_tips1")
	slot0._txttagitem1 = gohelper.findChildText(slot0.viewGO, "Right/#go_normal/tags/#go_tips1/#txt_tagitem1")
	slot0._gotips2 = gohelper.findChild(slot0.viewGO, "Right/#go_unget/tags/#go_tips2")
	slot0._txttagitem2 = gohelper.findChildText(slot0.viewGO, "Right/#go_unget/tags/#go_tips2/#txt_tagitem2")

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

function slot0.filterCompositeList(slot0, slot1, slot2)
	RougeCollectionListModel.instance:onInitData(slot1, slot2, slot0._selectIndex)
end

function slot0.refreshFilterButtonUI(slot0)
	slot0:_setFilterSelected(RougeCollectionListModel.instance:isFiltering())
end

function slot0._btnlistOnClick(slot0)
end

function slot0._btnhandbookOnClick(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._txtTitleEn, false)

	slot0._gonormalcancomposit = gohelper.findChild(slot0.viewGO, "Right/#go_normal/go_cancomposit")
	slot0._goungetcancomposit = gohelper.findChild(slot0.viewGO, "Right/#go_unget/go_cancomposit")
	slot0._goUnselectLayout = gohelper.findChild(slot0._golayout.gameObject, "unselected")
	slot0._goSelectLayout = gohelper.findChild(slot0._golayout.gameObject, "selected")
	slot0._goUnselectFilter = gohelper.findChild(slot0._btnfilter.gameObject, "unselect")
	slot0._goSelectFilter = gohelper.findChild(slot0._btnfilter.gameObject, "select")
	slot0._goshapecell1Icon = gohelper.findChild(slot0._goshapecell1, "icon")
	slot0._goshapecell2Icon = gohelper.findChild(slot0._goshapecell2, "icon")
	slot0._cellModelTab = slot0:getUserDataTb_()
	slot0._baseTagSelectMap = {}
	slot0._extraTagSelectMap = {}

	slot0:_setFilterSelected(false)
	slot0:_setAllSelected(true)

	slot0._enchantList = {}
	slot0._itemInstTab = slot0:getUserDataTb_()
	slot0._gocontenttransform = slot0._gocontent.transform

	slot0._scrollcollection:AddOnValueChanged(slot0._onScrollChange, slot0)

	slot0._dropherogroup = gohelper.findChildDropdown(slot0.viewGO, "Left/#go_layout")

	slot0._dropherogroup:AddOnValueChanged(slot0._onDropValueChanged, slot0)

	slot0._dropherogrouparrow = gohelper.findChild(slot0.viewGO, "Left/#go_layout/selected/Label/go_arrow").transform
	slot0._dropgroupchildcount = slot0._goSelectLayout.transform.childCount
	slot0._selectIndex = 1

	slot0._dropherogroup:ClearOptions()
	slot0._dropherogroup:AddOptions({
		luaLang("p_all"),
		luaLang("p_handbookequipviewfilterview_haveget"),
		luaLang("p_handbookequipviewfilterview_notget")
	})
	slot0._dropherogroup:SetValue(slot0._selectIndex - 1)
	TaskDispatcher.runRepeat(slot0._checkDropArrow, slot0, 0)

	slot0._rightAnimator = gohelper.onceAddComponent(gohelper.findChild(slot0.viewGO, "Right"), gohelper.Type_Animator)
	slot0._aniamtor = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_Animator)
	slot0._baseTagSelectMap = {}
	slot0._extraTagSelectMap = {}

	RougeCollectionListModel.instance:onInitData(slot0._baseTagSelectMap, slot0._extraTagSelectMap, slot0._selectIndex, true)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnClickCollectionListItem, slot0._onClickCollectionListItem, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, slot0._onSwitchCollectionInfoType, slot0)
	slot0:_refreshSelectCollectionInfo()
end

function slot0._onDropValueChanged(slot0, slot1)
	slot0._selectIndex = slot1 + 1

	RougeCollectionListModel.instance:onInitData(slot0._baseTagSelectMap, slot0._extraTagSelectMap, slot0._selectIndex)
	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio7)
end

function slot0._checkDropArrow(slot0)
	if slot0._goSelectLayout.transform.childCount ~= slot0._dropDownChildCount then
		slot0._dropDownChildCount = slot1

		transformhelper.setLocalScale(slot0._dropherogrouparrow, 1, slot0._dropgroupchildcount ~= slot1 and -1 or 1, 1)
	end
end

function slot0._onScrollChange(slot0)
	slot2 = RougeCollectionListModel.instance
	slot5 = nil

	for slot9, slot10 in ipairs(slot2:getTypeList()) do
		if recthelper.getAnchorY(slot0._gocontenttransform) > (slot2:getTypeHeightMap()[slot10.type] or 0) + 48 then
			slot5 = slot11
		else
			break
		end
	end

	slot6 = (slot5 or slot2:getFirstType() or slot4[1].type) ~= nil and #RougeCollectionListModel.instance:getList() > 0

	gohelper.setActive(slot0._gosmalltitle, slot6)

	if slot6 then
		if not RougeCollectionConfig.instance:getTagConfig(slot5) then
			return
		end

		slot0._txtTitle.text = slot7.name

		UISpriteSetMgr.instance:setRougeSprite(slot0._imageicon, slot7.iconUrl)
	end
end

function slot0._setFilterSelected(slot0, slot1)
	slot0._isFilterSelected = slot1

	gohelper.setActive(slot0._goSelectFilter, slot1)
	gohelper.setActive(slot0._goUnselectFilter, not slot1)
end

function slot0._setAllSelected(slot0, slot1)
	slot0._isAllSelected = slot1

	gohelper.setActive(slot0._goSelectLayout, slot1)
	gohelper.setActive(slot0._goUnselectLayout, not slot1)
end

function slot0._onClickCollectionListItem(slot0)
	slot0._rightAnimator:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(slot0._refreshSelectCollectionInfo, slot0)
	TaskDispatcher.runDelay(slot0._refreshSelectCollectionInfo, slot0, RougeEnum.CollectionListViewDelayTime)
end

function slot0._refreshSelectCollectionInfo(slot0)
	if not RougeCollectionListModel.instance:getSelectedConfig() then
		return
	end

	if not RougeCollectionConfig.instance:getCollectionCfg(slot1.id) then
		return
	end

	slot5 = RougeOutsideModel.instance:collectionIsPass(slot3.id)

	gohelper.setActive(slot0._gonormal, RougeFavoriteModel.instance:collectionIsUnlock(slot3.id) and slot5)
	gohelper.setActive(slot0._golocked, not slot4)
	gohelper.setActive(slot0._gounget, slot4 and not slot5)
	tabletool.clear(slot0._enchantList)

	for slot14, slot15 in pairs(slot0.viewContainer:getDropDownView():getHoleMoList()) do
		table.insert(slot0._enchantList, slot15.id)
	end

	if slot6 then
		gohelper.setActive(slot0._gonormalcancomposit, RougeCollectionConfig.instance:canSynthesized(slot3.id))

		slot0._txtcollectionname1.text = RougeCollectionConfig.instance:getCollectionName(slot2, slot0._enchantList)

		slot0._simageicon1:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot2))
		RougeCollectionHelper.loadCollectionAndEnchantTags(slot2, slot0._enchantList, slot0._gobasetags1, slot0._gobasetagitem1)
		RougeCollectionHelper.loadCollectionAndEnchantTagNames(slot2, slot0._enchantList, slot0._gotips1, slot0._txttagitem1.gameObject, RougeCollectionHelper._loadCollectionTagNameCallBack)
	end

	if slot7 then
		slot0._txtlockedName.text = luaLang("p_rougecollectionchessview_txt_locked")

		if lua_rouge_collection_unlock.configDict[slot2] then
			slot0._txtlocked.text = RougeMapUnlockHelper.getLockTips(slot11.unlockType, slot11.unlockParam)
		else
			logError("缺少造物解锁条件配置:" .. tostring(slot2))
		end
	end

	if slot8 then
		gohelper.setActive(slot0._goungetcancomposit, RougeCollectionConfig.instance:canSynthesized(slot3.id))

		slot0._txtcollectionname2.text = RougeCollectionConfig.instance:getCollectionName(slot2, slot0._enchantList)

		slot0._simageicon2:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot2))
		RougeCollectionHelper.loadCollectionAndEnchantTags(slot2, slot0._enchantList, slot0._gobasetags2, slot0._gobasetagitem2)
		RougeCollectionHelper.loadCollectionAndEnchantTagNames(slot2, slot0._enchantList, slot0._gotips2, slot0._txttagitem2.gameObject, RougeCollectionHelper._loadCollectionTagNameCallBack)
	end

	slot0._productId = slot2

	RougeCollectionDescHelper.setCollectionDescInfos2(slot2, slot0._enchantList, slot0._godescContent, slot0._itemInstTab)
	RougeCollectionHelper.loadShapeGrid(slot2, slot0._goshapecell1, slot0._goshapecell1Icon, slot0._cellModelTab, false)
end

function slot0._onSwitchCollectionInfoType(slot0)
	RougeCollectionDescHelper.setCollectionDescInfos2(slot0._productId, slot0._enchantList, slot0._godescContent, slot0._itemInstTab)
end

function slot0.onOpen(slot0)
	slot0._aniamtor:Play("open", 0, 0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._scrollcollection:RemoveOnValueChanged()
	slot0._dropherogroup:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(slot0._checkDropArrow, slot0)
	TaskDispatcher.cancelTask(slot0._refreshSelectCollectionInfo, slot0)
end

return slot0
