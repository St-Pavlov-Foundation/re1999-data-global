module("modules.logic.rouge.view.RougeCollectionListView", package.seeall)

local var_0_0 = class("RougeCollectionListView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_fullbg")
	arg_1_0._scrollcollection = gohelper.findChildScrollRect(arg_1_0.viewGO, "Left/#scroll_collection")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "Left/#scroll_collection/Viewport/#go_content")
	arg_1_0._btnfilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_filter")
	arg_1_0._golayout = gohelper.findChild(arg_1_0.viewGO, "Left/#go_layout")
	arg_1_0._gosmalltitle = gohelper.findChild(arg_1_0.viewGO, "Left/#go_smalltitle")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_smalltitle/#txt_Title")
	arg_1_0._txtTitleEn = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_smalltitle/#txt_Title/#txt_TitleEn")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "Left/#go_smalltitle/#image_icon")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "Right/#go_normal")
	arg_1_0._simageicon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#go_normal/#simage_icon1")
	arg_1_0._txtcollectionname1 = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_normal/#txt_collectionname1")
	arg_1_0._gobasetags1 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_normal/tags/#go_basetags1")
	arg_1_0._gobasetagitem1 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_normal/tags/#go_basetags1/#go_basetagitem1")
	arg_1_0._goextratags1 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_normal/tags/#go_extratags1")
	arg_1_0._goextratagitem1 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_normal/tags/#go_extratags1/#go_extratagitem1")
	arg_1_0._goshapecell1 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_normal/shape/#go_shapecell1")
	arg_1_0._scrollcollectiondesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/#go_normal/#scroll_collectiondesc")
	arg_1_0._godescContent = gohelper.findChild(arg_1_0.viewGO, "Right/#go_normal/#scroll_collectiondesc/Viewport/#go_descContent")
	arg_1_0._godescitem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_normal/#scroll_collectiondesc/Viewport/#go_descContent/#go_descitem")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.viewGO, "Right/#go_locked")
	arg_1_0._txtlocked = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_locked/locked/#txt_locked")
	arg_1_0._txtlockedName = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_locked/txt_locked")
	arg_1_0._gounget = gohelper.findChild(arg_1_0.viewGO, "Right/#go_unget")
	arg_1_0._simageicon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#go_unget/#simage_icon2")
	arg_1_0._txtcollectionname2 = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_unget/#txt_collectionname2")
	arg_1_0._gobasetags2 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_unget/tags/#go_basetags2")
	arg_1_0._gobasetagitem2 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_unget/tags/#go_basetags2/#go_basetagitem2")
	arg_1_0._goextratags2 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_unget/tags/#go_extratags2")
	arg_1_0._goextratagitem2 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_unget/tags/#go_extratags2/#go_extratagitem2")
	arg_1_0._goshapecell2 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_unget/shape/#go_shapecell2")
	arg_1_0._gotips1 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_normal/tags/#go_tips1")
	arg_1_0._txttagitem1 = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_normal/tags/#go_tips1/#txt_tagitem1")
	arg_1_0._gotips2 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_unget/tags/#go_tips2")
	arg_1_0._txttagitem2 = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_unget/tags/#go_tips2/#txt_tagitem2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnfilter:AddClickListener(arg_2_0._btnfilterOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnfilter:RemoveClickListener()
end

function var_0_0._btnfilterOnClick(arg_4_0)
	local var_4_0 = {
		confirmCallback = arg_4_0.onConfirmTagFilterCallback,
		confirmCallbackObj = arg_4_0,
		baseSelectMap = arg_4_0._baseTagSelectMap,
		extraSelectMap = arg_4_0._extraTagSelectMap
	}

	RougeController.instance:openRougeCollectionFilterView(var_4_0)
end

function var_0_0.onConfirmTagFilterCallback(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:filterCompositeList(arg_5_1, arg_5_2)
	arg_5_0:refreshFilterButtonUI()
end

function var_0_0.filterCompositeList(arg_6_0, arg_6_1, arg_6_2)
	RougeCollectionListModel.instance:onInitData(arg_6_1, arg_6_2, arg_6_0._selectIndex)
end

function var_0_0.refreshFilterButtonUI(arg_7_0)
	local var_7_0 = RougeCollectionListModel.instance:isFiltering()

	arg_7_0:_setFilterSelected(var_7_0)
end

function var_0_0._btnlistOnClick(arg_8_0)
	return
end

function var_0_0._btnhandbookOnClick(arg_9_0)
	return
end

function var_0_0._editableInitView(arg_10_0)
	gohelper.setActive(arg_10_0._txtTitleEn, false)

	arg_10_0._gonormalcancomposit = gohelper.findChild(arg_10_0.viewGO, "Right/#go_normal/go_cancomposit")
	arg_10_0._goungetcancomposit = gohelper.findChild(arg_10_0.viewGO, "Right/#go_unget/go_cancomposit")
	arg_10_0._goUnselectLayout = gohelper.findChild(arg_10_0._golayout.gameObject, "unselected")
	arg_10_0._goSelectLayout = gohelper.findChild(arg_10_0._golayout.gameObject, "selected")
	arg_10_0._goUnselectFilter = gohelper.findChild(arg_10_0._btnfilter.gameObject, "unselect")
	arg_10_0._goSelectFilter = gohelper.findChild(arg_10_0._btnfilter.gameObject, "select")
	arg_10_0._goshapecell1Icon = gohelper.findChild(arg_10_0._goshapecell1, "icon")
	arg_10_0._goshapecell2Icon = gohelper.findChild(arg_10_0._goshapecell2, "icon")
	arg_10_0._cellModelTab = arg_10_0:getUserDataTb_()
	arg_10_0._baseTagSelectMap = {}
	arg_10_0._extraTagSelectMap = {}

	arg_10_0:_setFilterSelected(false)
	arg_10_0:_setAllSelected(true)

	arg_10_0._enchantList = {}
	arg_10_0._itemInstTab = arg_10_0:getUserDataTb_()
	arg_10_0._gocontenttransform = arg_10_0._gocontent.transform

	arg_10_0._scrollcollection:AddOnValueChanged(arg_10_0._onScrollChange, arg_10_0)

	arg_10_0._dropherogroup = gohelper.findChildDropdown(arg_10_0.viewGO, "Left/#go_layout")

	arg_10_0._dropherogroup:AddOnValueChanged(arg_10_0._onDropValueChanged, arg_10_0)

	arg_10_0._dropherogrouparrow = gohelper.findChild(arg_10_0.viewGO, "Left/#go_layout/selected/Label/go_arrow").transform
	arg_10_0._dropgroupchildcount = arg_10_0._goSelectLayout.transform.childCount
	arg_10_0._selectIndex = 1

	local var_10_0 = {
		luaLang("p_all"),
		luaLang("p_handbookequipviewfilterview_haveget"),
		luaLang("p_handbookequipviewfilterview_notget")
	}

	arg_10_0._dropherogroup:ClearOptions()
	arg_10_0._dropherogroup:AddOptions(var_10_0)
	arg_10_0._dropherogroup:SetValue(arg_10_0._selectIndex - 1)
	TaskDispatcher.runRepeat(arg_10_0._checkDropArrow, arg_10_0, 0)

	local var_10_1 = gohelper.findChild(arg_10_0.viewGO, "Right")

	arg_10_0._rightAnimator = gohelper.onceAddComponent(var_10_1, gohelper.Type_Animator)
	arg_10_0._aniamtor = gohelper.onceAddComponent(arg_10_0.viewGO, gohelper.Type_Animator)
	arg_10_0._baseTagSelectMap = {}
	arg_10_0._extraTagSelectMap = {}

	RougeCollectionListModel.instance:onInitData(arg_10_0._baseTagSelectMap, arg_10_0._extraTagSelectMap, arg_10_0._selectIndex, true)
	arg_10_0:addEventCb(RougeController.instance, RougeEvent.OnClickCollectionListItem, arg_10_0._onClickCollectionListItem, arg_10_0)
	arg_10_0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, arg_10_0._onSwitchCollectionInfoType, arg_10_0)
	arg_10_0:_refreshSelectCollectionInfo()
end

function var_0_0._onDropValueChanged(arg_11_0, arg_11_1)
	arg_11_0._selectIndex = arg_11_1 + 1

	RougeCollectionListModel.instance:onInitData(arg_11_0._baseTagSelectMap, arg_11_0._extraTagSelectMap, arg_11_0._selectIndex)
	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio7)
end

function var_0_0._checkDropArrow(arg_12_0)
	local var_12_0 = arg_12_0._goSelectLayout.transform.childCount

	if var_12_0 ~= arg_12_0._dropDownChildCount then
		arg_12_0._dropDownChildCount = var_12_0

		local var_12_1 = arg_12_0._dropgroupchildcount ~= var_12_0

		transformhelper.setLocalScale(arg_12_0._dropherogrouparrow, 1, var_12_1 and -1 or 1, 1)
	end
end

function var_0_0._onScrollChange(arg_13_0)
	local var_13_0 = recthelper.getAnchorY(arg_13_0._gocontenttransform)
	local var_13_1 = RougeCollectionListModel.instance
	local var_13_2 = var_13_1:getTypeHeightMap()
	local var_13_3 = var_13_1:getTypeList()
	local var_13_4

	for iter_13_0, iter_13_1 in ipairs(var_13_3) do
		local var_13_5 = iter_13_1.type

		if var_13_0 > (var_13_2[var_13_5] or 0) + 48 then
			var_13_4 = var_13_5
		else
			break
		end
	end

	var_13_4 = var_13_4 or var_13_1:getFirstType() or var_13_3[1].type

	local var_13_6 = var_13_4 ~= nil and #RougeCollectionListModel.instance:getList() > 0

	gohelper.setActive(arg_13_0._gosmalltitle, var_13_6)

	if var_13_6 then
		local var_13_7 = RougeCollectionConfig.instance:getTagConfig(var_13_4)

		if not var_13_7 then
			return
		end

		arg_13_0._txtTitle.text = var_13_7.name

		UISpriteSetMgr.instance:setRougeSprite(arg_13_0._imageicon, var_13_7.iconUrl)
	end
end

function var_0_0._setFilterSelected(arg_14_0, arg_14_1)
	arg_14_0._isFilterSelected = arg_14_1

	gohelper.setActive(arg_14_0._goSelectFilter, arg_14_1)
	gohelper.setActive(arg_14_0._goUnselectFilter, not arg_14_1)
end

function var_0_0._setAllSelected(arg_15_0, arg_15_1)
	arg_15_0._isAllSelected = arg_15_1

	gohelper.setActive(arg_15_0._goSelectLayout, arg_15_1)
	gohelper.setActive(arg_15_0._goUnselectLayout, not arg_15_1)
end

function var_0_0._onClickCollectionListItem(arg_16_0)
	arg_16_0._rightAnimator:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(arg_16_0._refreshSelectCollectionInfo, arg_16_0)
	TaskDispatcher.runDelay(arg_16_0._refreshSelectCollectionInfo, arg_16_0, RougeEnum.CollectionListViewDelayTime)
end

function var_0_0._refreshSelectCollectionInfo(arg_17_0)
	local var_17_0 = RougeCollectionListModel.instance:getSelectedConfig()

	if not var_17_0 then
		return
	end

	local var_17_1 = var_17_0.id
	local var_17_2 = RougeCollectionConfig.instance:getCollectionCfg(var_17_1)

	if not var_17_2 then
		return
	end

	local var_17_3 = RougeFavoriteModel.instance:collectionIsUnlock(var_17_2.id)
	local var_17_4 = RougeOutsideModel.instance:collectionIsPass(var_17_2.id)
	local var_17_5 = var_17_3 and var_17_4
	local var_17_6 = not var_17_3
	local var_17_7 = var_17_3 and not var_17_4

	gohelper.setActive(arg_17_0._gonormal, var_17_5)
	gohelper.setActive(arg_17_0._golocked, var_17_6)
	gohelper.setActive(arg_17_0._gounget, var_17_7)

	local var_17_8 = arg_17_0.viewContainer:getDropDownView():getHoleMoList()

	tabletool.clear(arg_17_0._enchantList)

	for iter_17_0, iter_17_1 in pairs(var_17_8) do
		table.insert(arg_17_0._enchantList, iter_17_1.id)
	end

	if var_17_5 then
		gohelper.setActive(arg_17_0._gonormalcancomposit, RougeCollectionConfig.instance:canSynthesized(var_17_2.id))

		arg_17_0._txtcollectionname1.text = RougeCollectionConfig.instance:getCollectionName(var_17_1, arg_17_0._enchantList)

		arg_17_0._simageicon1:LoadImage(RougeCollectionHelper.getCollectionIconUrl(var_17_1))
		RougeCollectionHelper.loadCollectionAndEnchantTags(var_17_1, arg_17_0._enchantList, arg_17_0._gobasetags1, arg_17_0._gobasetagitem1)
		RougeCollectionHelper.loadCollectionAndEnchantTagNames(var_17_1, arg_17_0._enchantList, arg_17_0._gotips1, arg_17_0._txttagitem1.gameObject, RougeCollectionHelper._loadCollectionTagNameCallBack)
	end

	if var_17_6 then
		arg_17_0._txtlockedName.text = luaLang("p_rougecollectionchessview_txt_locked")

		local var_17_9 = lua_rouge_collection_unlock.configDict[var_17_1]

		if var_17_9 then
			arg_17_0._txtlocked.text = RougeMapUnlockHelper.getLockTips(var_17_9.unlockType, var_17_9.unlockParam)
		else
			logError("缺少造物解锁条件配置:" .. tostring(var_17_1))
		end
	end

	if var_17_7 then
		gohelper.setActive(arg_17_0._goungetcancomposit, RougeCollectionConfig.instance:canSynthesized(var_17_2.id))

		arg_17_0._txtcollectionname2.text = RougeCollectionConfig.instance:getCollectionName(var_17_1, arg_17_0._enchantList)

		arg_17_0._simageicon2:LoadImage(RougeCollectionHelper.getCollectionIconUrl(var_17_1))
		RougeCollectionHelper.loadCollectionAndEnchantTags(var_17_1, arg_17_0._enchantList, arg_17_0._gobasetags2, arg_17_0._gobasetagitem2)
		RougeCollectionHelper.loadCollectionAndEnchantTagNames(var_17_1, arg_17_0._enchantList, arg_17_0._gotips2, arg_17_0._txttagitem2.gameObject, RougeCollectionHelper._loadCollectionTagNameCallBack)
	end

	arg_17_0._productId = var_17_1

	RougeCollectionDescHelper.setCollectionDescInfos2(var_17_1, arg_17_0._enchantList, arg_17_0._godescContent, arg_17_0._itemInstTab)
	RougeCollectionHelper.loadShapeGrid(var_17_1, arg_17_0._goshapecell1, arg_17_0._goshapecell1Icon, arg_17_0._cellModelTab, false)
end

function var_0_0._onSwitchCollectionInfoType(arg_18_0)
	RougeCollectionDescHelper.setCollectionDescInfos2(arg_18_0._productId, arg_18_0._enchantList, arg_18_0._godescContent, arg_18_0._itemInstTab)
end

function var_0_0.onOpen(arg_19_0)
	arg_19_0._aniamtor:Play("open", 0, 0)
end

function var_0_0.onClose(arg_20_0)
	return
end

function var_0_0.onDestroyView(arg_21_0)
	arg_21_0._scrollcollection:RemoveOnValueChanged()
	arg_21_0._dropherogroup:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(arg_21_0._checkDropArrow, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._refreshSelectCollectionInfo, arg_21_0)
end

return var_0_0
