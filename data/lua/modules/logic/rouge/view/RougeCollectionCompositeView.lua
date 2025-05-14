module("modules.logic.rouge.view.RougeCollectionCompositeView", package.seeall)

local var_0_0 = class("RougeCollectionCompositeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._txtcollectionname = gohelper.findChildText(arg_1_0.viewGO, "right/collection/#txt_collectionname")
	arg_1_0._godescContent = gohelper.findChild(arg_1_0.viewGO, "right/collection/#scroll_desc/Viewport/#go_descContent")
	arg_1_0._godescitem = gohelper.findChild(arg_1_0.viewGO, "right/collection/#scroll_desc/Viewport/#go_descContent/#go_descitem")
	arg_1_0._goenchantlist = gohelper.findChild(arg_1_0.viewGO, "right/collection/#go_enchantlist")
	arg_1_0._gohole = gohelper.findChild(arg_1_0.viewGO, "right/collection/#go_enchantlist/#go_hole")
	arg_1_0._gocollectionicon = gohelper.findChild(arg_1_0.viewGO, "right/collection/#go_collectionicon")
	arg_1_0._gotags = gohelper.findChild(arg_1_0.viewGO, "right/collection/#go_tags")
	arg_1_0._gotagitem = gohelper.findChild(arg_1_0.viewGO, "right/collection/#go_tags/#go_tagitem")
	arg_1_0._goframe = gohelper.findChild(arg_1_0.viewGO, "right/composite/#go_frame")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "right/composite/#go_frame/#go_line")
	arg_1_0._gocompositecontainer = gohelper.findChild(arg_1_0.viewGO, "right/composite/#go_frame/#go_compositecontainer")
	arg_1_0._gocompositeitem = gohelper.findChild(arg_1_0.viewGO, "right/composite/#go_frame/#go_compositecontainer/#go_compositeitem")
	arg_1_0._btncomposite = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_composite")
	arg_1_0._golist = gohelper.findChild(arg_1_0.viewGO, "left/#go_list")
	arg_1_0._btnfilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#go_list/#btn_filter")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._gocompositeeffect = gohelper.findChild(arg_1_0.viewGO, "right/collection/#go_compositeeffect")
	arg_1_0._gorougefunctionitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_rougefunctionitem2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncomposite:AddClickListener(arg_2_0._btncompositeOnClick, arg_2_0)
	arg_2_0._btnfilter:AddClickListener(arg_2_0._btnfilterOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncomposite:RemoveClickListener()
	arg_3_0._btnfilter:RemoveClickListener()
end

function var_0_0._btncompositeOnClick(arg_4_0)
	local var_4_0 = RougeCollectionCompositeListModel.instance:getCurSelectCellId()

	if not RougeCollectionModel.instance:checkIsCanCompositeCollection(var_4_0) then
		GameFacade.showToast(ToastEnum.RougeCompositeFailed)

		return
	end

	arg_4_0._consumeIds, arg_4_0._placeSlotCollections = arg_4_0:getNeedCostConsumeIds(var_4_0)

	if arg_4_0._placeSlotCollections and #arg_4_0._placeSlotCollections > 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.RougeCollectionCompositeConfirm, MsgBoxEnum.BoxType.Yes_No, arg_4_0.confirm2CompositeCollection, arg_4_0.cancel2CompositeCollection, nil, arg_4_0, arg_4_0)

		return
	end

	arg_4_0:confirm2CompositeCollection()
end

function var_0_0.confirm2CompositeCollection(arg_5_0)
	arg_5_0:playCompositeEffect()

	local var_5_0 = RougeCollectionCompositeListModel.instance:getCurSelectCellId()
	local var_5_1 = RougeModel.instance:getSeason()

	RougeRpc.instance:sendRougeComposeRequest(var_5_1, var_5_0, arg_5_0._consumeIds)
end

function var_0_0.cancel2CompositeCollection(arg_6_0)
	return
end

function var_0_0._btnfilterOnClick(arg_7_0)
	local var_7_0 = {
		confirmCallback = arg_7_0.onConfirmTagFilterCallback,
		confirmCallbackObj = arg_7_0,
		baseSelectMap = arg_7_0._baseTagSelectMap,
		extraSelectMap = arg_7_0._extraTagSelectMap
	}

	RougeController.instance:openRougeCollectionFilterView(var_7_0)
end

function var_0_0.onConfirmTagFilterCallback(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:filterCompositeList(arg_8_1, arg_8_2)
	arg_8_0:refreshFilterButtonUI()
end

var_0_0.CompositeEffectDuration = 1.2

function var_0_0.playCompositeEffect(arg_9_0)
	gohelper.setActive(arg_9_0._gocompositeeffect, true)
	TaskDispatcher.cancelTask(arg_9_0._hideCompositeEffect, arg_9_0)
	TaskDispatcher.runDelay(arg_9_0._hideCompositeEffect, arg_9_0, var_0_0.CompositeEffectDuration)
end

function var_0_0._hideCompositeEffect(arg_10_0)
	gohelper.setActive(arg_10_0._gocompositeeffect, false)
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0:addEventCb(RougeController.instance, RougeEvent.OnSelectCollectionCompositeItem, arg_11_0._onSelectCompositeItem, arg_11_0)
	arg_11_0:addEventCb(RougeController.instance, RougeEvent.CompositeCollectionSucc, arg_11_0._compositeCollectionSucc, arg_11_0)
	arg_11_0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, arg_11_0._onSwitchCollectionInfoType, arg_11_0)

	arg_11_0._compositeItemTab = arg_11_0:getUserDataTb_()
	arg_11_0._baseTagSelectMap = {}
	arg_11_0._extraTagSelectMap = {}
	arg_11_0._itemInstTab = arg_11_0:getUserDataTb_()
	arg_11_0._descParams = {
		isAllActive = true
	}
	arg_11_0.goCollection = arg_11_0.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, arg_11_0._gorougefunctionitem2)
	arg_11_0.collectionComp = RougeCollectionComp.Get(arg_11_0.goCollection)
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	RougeCollectionCompositeListModel.instance:onInitData()
	RougeCollectionCompositeListModel.instance:selectFirstOrDefault()
	arg_13_0:updateSelectCollectionInfo()
	arg_13_0.collectionComp:onOpen()
end

function var_0_0.updateSelectCollectionInfo(arg_14_0)
	local var_14_0 = RougeCollectionCompositeListModel.instance:getCurSelectCellId()
	local var_14_1 = RougeCollectionCompositeListModel.instance:getById(var_14_0)

	if not var_14_1 then
		return
	end

	local var_14_2 = var_14_1.product
	local var_14_3 = RougeCollectionConfig.instance:getCollectionCfg(var_14_2)

	if not var_14_3 then
		return
	end

	arg_14_0._productId = var_14_2
	arg_14_0._txtcollectionname.text = RougeCollectionConfig.instance:getCollectionName(var_14_2)

	arg_14_0:refreshCollectionDesc()
	arg_14_0:refreshSelectProductIcon(var_14_2)

	local var_14_4 = RougeCollectionConfig.instance:getCollectionCompositeIds(var_14_0)

	gohelper.setActive(arg_14_0._goline, var_14_4 and #var_14_4 > 1)
	arg_14_0:buildCollectionCountMap(var_14_4)
	gohelper.CreateObjList(arg_14_0, arg_14_0.refreshCompositeCollectionItem, var_14_4, arg_14_0._gocompositecontainer, arg_14_0._gocompositeitem)
	gohelper.CreateObjList(arg_14_0, arg_14_0.refreshCollectionBaseTag, var_14_3.tags, arg_14_0._gotags, arg_14_0._gotagitem)
	gohelper.CreateNumObjList(arg_14_0._goenchantlist, arg_14_0._gohole, var_14_3.holeNum)
end

function var_0_0.refreshCollectionDesc(arg_15_0)
	local var_15_0 = RougeCollectionDescHelper.getShowDescTypesWithoutText()

	RougeCollectionDescHelper.setCollectionDescInfos2(arg_15_0._productId, nil, arg_15_0._godescContent, arg_15_0._itemInstTab, var_15_0, arg_15_0._descParams)
end

function var_0_0.buildCollectionCountMap(arg_16_0, arg_16_1)
	arg_16_0._collectionCountMap = {}

	if arg_16_1 then
		local var_16_0 = {}

		for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
			local var_16_1 = var_16_0[iter_16_1]

			if not var_16_0[iter_16_1] then
				var_16_1 = RougeCollectionModel.instance:getCollectionCountById(iter_16_1)
				var_16_0[iter_16_1] = var_16_1 or 0
			end

			arg_16_0._collectionCountMap[iter_16_0] = var_16_1 > 0 and 1 or 0
			var_16_0[iter_16_1] = var_16_0[iter_16_1] - 1
		end
	end
end

local var_0_1 = 160
local var_0_2 = 160

function var_0_0.refreshSelectProductIcon(arg_17_0, arg_17_1)
	if not RougeCollectionConfig.instance:getCollectionCfg(arg_17_1) then
		return
	end

	if not arg_17_0._productIconItem then
		local var_17_0 = arg_17_0.viewContainer:getSetting()
		local var_17_1 = arg_17_0:getResInst(var_17_0.otherRes[1], arg_17_0._gocollectionicon, "productItemIcon")

		arg_17_0._productIconItem = RougeCollectionIconItem.New(var_17_1)

		arg_17_0._productIconItem:setHolesVisible(false)
		arg_17_0._productIconItem:setCollectionIconSize(var_0_1, var_0_2)
	end

	arg_17_0._productIconItem:onUpdateMO(arg_17_1)
end

function var_0_0.refreshCollectionBaseTag(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = gohelper.findChildImage(arg_18_1, "image_tagicon")
	local var_18_1 = gohelper.findChildImage(arg_18_1, "image_tagframe")
	local var_18_2 = lua_rouge_tag.configDict[arg_18_2]

	UISpriteSetMgr.instance:setRougeSprite(var_18_0, var_18_2.iconUrl)
	UISpriteSetMgr.instance:setRougeSprite(var_18_1, "rouge_collection_tagframe_1")
end

local var_0_3 = "#A36431"
local var_0_4 = "#9A3C27"
local var_0_5 = 160
local var_0_6 = 160

function var_0_0.refreshCompositeCollectionItem(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_2 = tonumber(arg_19_2)

	if not RougeCollectionConfig.instance:getCollectionCfg(arg_19_2) then
		logError("找不到合成基底造物配置, 合成基底造物id = " .. tostring(arg_19_2))

		return
	end

	local var_19_0 = arg_19_0._collectionCountMap[arg_19_3] or 0
	local var_19_1 = var_19_0 > 0
	local var_19_2 = gohelper.findChildText(arg_19_1, "txt_num")
	local var_19_3 = var_19_1 and var_0_3 or var_0_4

	var_19_2.text = string.format("<%s>%s</color>/%s", var_19_3, var_19_0, RougeEnum.CompositeCollectionCostCount)
	arg_19_0._compositeItemTab[arg_19_3] = arg_19_0._compositeItemTab[arg_19_3] or arg_19_0:getUserDataTb_()

	local var_19_4 = arg_19_0._compositeItemTab[arg_19_3].item

	if not var_19_4 then
		local var_19_5 = arg_19_0.viewContainer:getSetting()
		local var_19_6 = gohelper.findChild(arg_19_1, "go_icon")
		local var_19_7 = arg_19_0:getResInst(var_19_5.otherRes[1], var_19_6, "itemicon")

		var_19_4 = RougeCollectionIconItem.New(var_19_7)

		var_19_4:setHolesVisible(false)
		var_19_4:setCollectionIconSize(var_0_5, var_0_6)

		arg_19_0._compositeItemTab[arg_19_3].item = var_19_4
	end

	local var_19_8 = gohelper.findChildButtonWithAudio(arg_19_1, "btn_click")

	var_19_8:RemoveClickListener()
	var_19_8:AddClickListener(arg_19_0.clickCompositeItem, arg_19_0, arg_19_2)

	arg_19_0._compositeItemTab[arg_19_3].btnclick = var_19_8

	var_19_4:onUpdateMO(arg_19_2)
end

function var_0_0.clickCompositeItem(arg_20_0, arg_20_1)
	local var_20_0 = {
		collectionCfgId = arg_20_1,
		viewPosition = RougeEnum.CollectionTipPos.CompositeBaseCollection
	}

	RougeController.instance:openRougeCollectionTipView(var_20_0)
end

function var_0_0._onSelectCompositeItem(arg_21_0, arg_21_1)
	if arg_21_1 == RougeCollectionCompositeListModel.instance:getCurSelectCellId() then
		return
	end

	local var_21_0 = RougeCollectionCompositeListModel.instance:getById(arg_21_1)
	local var_21_1 = RougeCollectionCompositeListModel.instance:getIndex(var_21_0)

	RougeCollectionCompositeListModel.instance:selectCell(var_21_1, true)
	arg_21_0:updateSelectCollectionInfo()
	gohelper.setActive(arg_21_0._gocompositeeffect, false)
	TaskDispatcher.cancelTask(arg_21_0._hideCompositeEffect, arg_21_0)
end

function var_0_0.filterCompositeList(arg_22_0, arg_22_1, arg_22_2)
	RougeCollectionCompositeListModel.instance:onInitData(arg_22_1, arg_22_2)

	local var_22_0 = RougeCollectionCompositeListModel.instance:getCurSelectCellId()

	if not RougeCollectionCompositeListModel.instance:getById(var_22_0) then
		RougeCollectionCompositeListModel.instance:selectFirstOrDefault()
		arg_22_0:updateSelectCollectionInfo()
	end
end

function var_0_0.getNeedCostConsumeIds(arg_23_0, arg_23_1)
	local var_23_0 = RougeCollectionConfig.instance:getCollectionCompositeIds(arg_23_1)
	local var_23_1 = {}
	local var_23_2 = {}
	local var_23_3 = {}

	if var_23_0 then
		for iter_23_0, iter_23_1 in ipairs(var_23_0) do
			arg_23_0:selectNeedCostConsumeIds(iter_23_1, var_23_1, var_23_2, var_23_3)
		end
	end

	return var_23_1, var_23_3
end

function var_0_0.selectNeedCostConsumeIds(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	local var_24_0 = RougeCollectionModel.instance:getCollectionByCfgId(arg_24_1)

	if var_24_0 then
		local var_24_1 = 0

		for iter_24_0 = 1, #var_24_0 do
			local var_24_2 = var_24_0[iter_24_0] and var_24_0[iter_24_0].id

			if var_24_2 and not arg_24_3[var_24_2] then
				table.insert(arg_24_2, var_24_2)

				arg_24_3[var_24_2] = true
				var_24_1 = var_24_1 + 1

				if RougeCollectionModel.instance:isCollectionPlaceInSlotArea(var_24_2) then
					table.insert(arg_24_4, var_24_2)
				end
			end

			if var_24_1 >= RougeEnum.CompositeCollectionCostCount then
				break
			end
		end
	end
end

function var_0_0._compositeCollectionSucc(arg_25_0)
	RougeCollectionCompositeListModel.instance:onModelUpdate()
	arg_25_0:updateSelectCollectionInfo()
end

function var_0_0.refreshFilterButtonUI(arg_26_0)
	local var_26_0 = RougeCollectionCompositeListModel.instance:isFiltering()
	local var_26_1 = gohelper.findChild(arg_26_0._btnfilter.gameObject, "unselect")
	local var_26_2 = gohelper.findChild(arg_26_0._btnfilter.gameObject, "select")

	gohelper.setActive(var_26_2, var_26_0)
	gohelper.setActive(var_26_1, not var_26_0)
end

function var_0_0._onSwitchCollectionInfoType(arg_27_0)
	arg_27_0:refreshCollectionDesc()
end

function var_0_0.onClose(arg_28_0)
	arg_28_0.collectionComp:onClose()
end

function var_0_0.onDestroyView(arg_29_0)
	if arg_29_0._compositeItemTab then
		for iter_29_0, iter_29_1 in pairs(arg_29_0._compositeItemTab) do
			if iter_29_1.item then
				iter_29_1.item:destroy()
			end

			if iter_29_1.btnclick then
				iter_29_1.btnclick:RemoveClickListener()
			end
		end
	end

	if arg_29_0._productIconItem then
		arg_29_0._productIconItem:destroy()

		arg_29_0._productIconItem = nil
	end

	TaskDispatcher.cancelTask(arg_29_0._hideCompositeEffect, arg_29_0)
	arg_29_0.collectionComp:destroy()
end

return var_0_0
