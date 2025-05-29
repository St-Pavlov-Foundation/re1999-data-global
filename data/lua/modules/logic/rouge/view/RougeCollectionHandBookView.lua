module("modules.logic.rouge.view.RougeCollectionHandBookView", package.seeall)

local var_0_0 = class("RougeCollectionHandBookView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_fullbg")
	arg_1_0._btnfilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_filter")
	arg_1_0._scrollcollection = gohelper.findChildScrollRect(arg_1_0.viewGO, "Left/#scroll_collection")
	arg_1_0._txtTitleEn = gohelper.findChildText(arg_1_0.viewGO, "Left/#scroll_collection/Viewport/Content/item/smalltitle/txt_Title/#txt_TitleEn")
	arg_1_0._gocollectionitem = gohelper.findChild(arg_1_0.viewGO, "Left/#scroll_collection/Viewport/Content/#go_collectionitem")
	arg_1_0._imagebg = gohelper.findChildImage(arg_1_0.viewGO, "Left/#scroll_collection/Viewport/Content/item/#go_collectionitem/normal/#image_bg")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "Left/#scroll_collection/Viewport/Content/item/#go_collectionitem/normal/#txt_num")
	arg_1_0._simagecollection = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#scroll_collection/Viewport/Content/item/#go_collectionitem/normal/#simage_collection")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/top/#simage_icon")
	arg_1_0._txtcollectionname = gohelper.findChildText(arg_1_0.viewGO, "Right/top/#txt_collectionname")
	arg_1_0._gobasetags = gohelper.findChild(arg_1_0.viewGO, "Right/top/tags/#go_basetags")
	arg_1_0._gobasetagitem = gohelper.findChild(arg_1_0.viewGO, "Right/top/tags/#go_basetags/#go_basetagitem")
	arg_1_0._goextratags = gohelper.findChild(arg_1_0.viewGO, "Right/top/tags/#go_extratags")
	arg_1_0._goextratagitem = gohelper.findChild(arg_1_0.viewGO, "Right/top/tags/#go_extratags/#go_extratagitem")
	arg_1_0._goshapecell = gohelper.findChild(arg_1_0.viewGO, "Right/top/layout/shape/#go_shapecell")
	arg_1_0._scrollcollectiondesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/top/#scroll_collectiondesc")
	arg_1_0._godescContent = gohelper.findChild(arg_1_0.viewGO, "Right/top/#scroll_collectiondesc/Viewport/#go_descContent")
	arg_1_0._godescitem = gohelper.findChild(arg_1_0.viewGO, "Right/top/#scroll_collectiondesc/Viewport/#go_descContent/#go_descitem")
	arg_1_0._btnhandbook = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Bottom/#btn_handbook")
	arg_1_0._goholecontainer = gohelper.findChild(arg_1_0.viewGO, "Right/top/layout/#go_holecontainer")
	arg_1_0._goholeitem = gohelper.findChild(arg_1_0.viewGO, "Right/top/layout/#go_holecontainer/#go_holeitem")
	arg_1_0._gocompositelayout = gohelper.findChild(arg_1_0.viewGO, "Right/top/need/#go_compositelayout")
	arg_1_0._gocompositeitem = gohelper.findChild(arg_1_0.viewGO, "Right/top/need/#go_compositelayout/#go_compositeitem")
	arg_1_0._gocancomposite = gohelper.findChild(arg_1_0.viewGO, "Right/top/layout/#go_cancomposite")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_empty")

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

function var_0_0._editableInitView(arg_6_0)
	arg_6_0:addEventCb(RougeController.instance, RougeEvent.OnSelectCollectionHandBookItem, arg_6_0._onSelectHandBookItem, arg_6_0)
	arg_6_0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, arg_6_0._onSwitchCollectionInfoType, arg_6_0)

	arg_6_0._compositeItemTab = arg_6_0:getUserDataTb_()
	arg_6_0._collectionCellTab = arg_6_0:getUserDataTb_()
	arg_6_0._itemInstTab = arg_6_0:getUserDataTb_()
	arg_6_0._baseTagSelectMap = {}
	arg_6_0._extraTagSelectMap = {}
	arg_6_0._goshapecontainer = gohelper.findChild(arg_6_0.viewGO, "Right/top/layout/shape")
	arg_6_0._aniamtor = gohelper.onceAddComponent(arg_6_0.viewGO, gohelper.Type_Animator)
	arg_6_0._goright = gohelper.findChild(arg_6_0.viewGO, "Right")
	arg_6_0._rightAnimator = gohelper.onceAddComponent(arg_6_0._goright, gohelper.Type_Animator)
end

function var_0_0.onOpen(arg_7_0)
	RougeCollectionHandBookListModel.instance:onInit()
	arg_7_0:refreshSelectCollectionInfo()
	arg_7_0._aniamtor:Play("open", 0, 0)
end

function var_0_0.refreshSelectCollectionInfo(arg_8_0)
	local var_8_0 = RougeCollectionHandBookListModel.instance:getCurSelectCellId()
	local var_8_1 = RougeCollectionHandBookListModel.instance:getById(var_8_0)

	gohelper.setActive(arg_8_0._goright, var_8_1 ~= nil)
	gohelper.setActive(arg_8_0._goempty, var_8_1 == nil)

	if not var_8_1 then
		return
	end

	local var_8_2 = var_8_1.product
	local var_8_3 = RougeCollectionConfig.instance:getCollectionCfg(var_8_2)

	if not var_8_3 then
		return
	end

	arg_8_0._productId = var_8_2

	arg_8_0._simageicon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(var_8_2))

	arg_8_0._txtcollectionname.text = RougeCollectionConfig.instance:getCollectionName(var_8_2)

	arg_8_0:refrehsCollectionDesc()
	gohelper.CreateObjList(arg_8_0, arg_8_0.refreshCollectionTagIcon, var_8_3.tags, arg_8_0._gobasetags, arg_8_0._gobasetagitem)
	gohelper.CreateNumObjList(arg_8_0._goholecontainer, arg_8_0._goholeitem, var_8_3.holeNum)
	gohelper.setActive(arg_8_0._goholecontainer, var_8_3.holeNum > 0)

	local var_8_4 = RougeCollectionConfig.instance:getCollectionCompositeIds(var_8_0) or {}

	gohelper.CreateObjList(arg_8_0, arg_8_0.refreshCompositeItem, var_8_4, arg_8_0._gocompositelayout, arg_8_0._gocompositeitem)
	RougeCollectionHelper.loadShapeGrid(var_8_2, arg_8_0._goshapecontainer, arg_8_0._goshapecell, arg_8_0._collectionCellTab, false)

	local var_8_5 = RougeCollectionModel.instance:checkIsCanCompositeCollection(var_8_0)

	gohelper.setActive(arg_8_0._gocancomposite, var_8_5)
end

function var_0_0.refrehsCollectionDesc(arg_9_0)
	RougeCollectionDescHelper.setCollectionDescInfos2(arg_9_0._productId, nil, arg_9_0._godescContent, arg_9_0._itemInstTab)
end

function var_0_0.refreshCollectionTagIcon(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = gohelper.findChildImage(arg_10_1, "image_tagicon")
	local var_10_1 = gohelper.findChildImage(arg_10_1, "image_tagframe")
	local var_10_2 = lua_rouge_tag.configDict[arg_10_2]

	UISpriteSetMgr.instance:setRougeSprite(var_10_0, var_10_2.iconUrl)
	UISpriteSetMgr.instance:setRougeSprite(var_10_1, "rouge_collection_tagframe_1")
end

function var_0_0.refreshCompositeItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = RougeCollectionConfig.instance:getCollectionCfg(arg_11_2)

	if not var_11_0 then
		return
	end

	local var_11_1 = gohelper.findChildSingleImage(arg_11_1, "normal/#simage_collection")

	var_11_1:LoadImage(RougeCollectionHelper.getCollectionIconUrl(arg_11_2))

	gohelper.findChildText(arg_11_1, "normal/#txt_num").text = tostring(RougeEnum.CompositeCollectionCostCount)

	local var_11_2 = gohelper.findChildImage(arg_11_1, "normal/#image_bg")

	UISpriteSetMgr.instance:setRougeSprite(var_11_2, "rouge_episode_collectionbg_" .. tostring(var_11_0.showRare))

	arg_11_0._compositeItemTab[arg_11_3] = arg_11_0._compositeItemTab[arg_11_3] or arg_11_0:getUserDataTb_()
	arg_11_0._compositeItemTab[arg_11_3].icon = var_11_1

	local var_11_3 = gohelper.findChildButtonWithAudio(arg_11_1, "normal/#btn_click")

	var_11_3:RemoveClickListener()
	var_11_3:AddClickListener(arg_11_0.clickCompositeItemCallBack, arg_11_0, arg_11_2)

	arg_11_0._compositeItemTab[arg_11_3].btnClick = var_11_3
end

function var_0_0.clickCompositeItemCallBack(arg_12_0, arg_12_1)
	local var_12_0 = {
		interactable = false,
		collectionCfgId = arg_12_1,
		viewPosition = RougeEnum.CollectionTipPos.HandBook
	}

	RougeController.instance:openRougeCollectionTipView(var_12_0)
end

function var_0_0.releaseCompositeIconSingleImages(arg_13_0)
	if arg_13_0._compositeItemTab then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._compositeItemTab) do
			if iter_13_1 and iter_13_1.icon then
				iter_13_1.icon:UnLoadImage()
			end

			if iter_13_1 and iter_13_1.btnClick then
				iter_13_1.btnClick:RemoveClickListener()
			end
		end
	end
end

function var_0_0._onSelectHandBookItem(arg_14_0, arg_14_1)
	if arg_14_1 == RougeCollectionHandBookListModel.instance:getCurSelectCellId() then
		return
	end

	local var_14_0 = RougeCollectionHandBookListModel.instance:getById(arg_14_1)
	local var_14_1 = RougeCollectionHandBookListModel.instance:getIndex(var_14_0)

	RougeCollectionHandBookListModel.instance:selectCell(var_14_1, true)
	arg_14_0:delay2SwitchHandBookItem(var_0_0.DelayTime2SwitchCollection)
	arg_14_0._rightAnimator:Play("switch", 0, 0)
end

var_0_0.DelayTime2SwitchCollection = 0.3

function var_0_0.delay2SwitchHandBookItem(arg_15_0, arg_15_1)
	arg_15_1 = arg_15_1 or 0

	TaskDispatcher.cancelTask(arg_15_0.refreshSelectCollectionInfo, arg_15_0)
	TaskDispatcher.runDelay(arg_15_0.refreshSelectCollectionInfo, arg_15_0, arg_15_1)
end

function var_0_0.filterCompositeList(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = RougeCollectionHandBookListModel.instance:getCurSelectCellId()

	RougeCollectionHandBookListModel.instance:updateFilterMap(arg_16_1, arg_16_2)

	if var_16_0 ~= RougeCollectionHandBookListModel.instance:getCurSelectCellId() then
		arg_16_0:refreshSelectCollectionInfo()
	end
end

function var_0_0.refreshFilterButtonUI(arg_17_0)
	local var_17_0 = RougeCollectionHandBookListModel.instance:isFiltering()

	arg_17_0:_setFilterSelected(var_17_0)
end

function var_0_0._setFilterSelected(arg_18_0, arg_18_1)
	local var_18_0 = gohelper.findChild(arg_18_0._btnfilter.gameObject, "unselect")
	local var_18_1 = gohelper.findChild(arg_18_0._btnfilter.gameObject, "select")

	gohelper.setActive(var_18_1, arg_18_1)
	gohelper.setActive(var_18_0, not arg_18_1)
end

function var_0_0._onSwitchCollectionInfoType(arg_19_0)
	arg_19_0:refrehsCollectionDesc()
end

function var_0_0.onClose(arg_20_0)
	return
end

function var_0_0.onDestroyView(arg_21_0)
	arg_21_0._simageicon:UnLoadImage()
	arg_21_0:releaseCompositeIconSingleImages()
	TaskDispatcher.cancelTask(arg_21_0.refreshSelectCollectionInfo, arg_21_0)
end

return var_0_0
