module("modules.logic.rouge.map.view.choice.RougeMapChoiceTipView", package.seeall)

local var_0_0 = class("RougeMapChoiceTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gochoicetips = gohelper.findChild(arg_1_0.viewGO, "#go_choicetips")
	arg_1_0._gocollectiontips = gohelper.findChild(arg_1_0.viewGO, "#go_collectiontips")
	arg_1_0._goclosetip = gohelper.findChild(arg_1_0.viewGO, "#go_choicetips/#go_closetip")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#go_choicetips/Scroll View/Viewport/Content/title/#txt_title")
	arg_1_0._gocollectionitem = gohelper.findChild(arg_1_0.viewGO, "#go_choicetips/Scroll View/Viewport/Content/#go_collectionitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._gochoicetips, false)
	gohelper.setActive(arg_4_0._gocollectionitem, false)

	arg_4_0.rectViewPort = gohelper.findChild(arg_4_0.viewGO, "#go_choicetips/Scroll View/Viewport"):GetComponent(gohelper.Type_RectTransform)
	arg_4_0.rectCollectionTip = arg_4_0._gocollectiontips:GetComponent(gohelper.Type_RectTransform)
	arg_4_0.rectTrContent = gohelper.findChild(arg_4_0.viewGO, "#go_choicetips/Scroll View/Viewport/Content"):GetComponent(gohelper.Type_RectTransform)
	arg_4_0.click = gohelper.getClickWithDefaultAudio(arg_4_0._goclosetip)

	arg_4_0.click:AddClickListener(arg_4_0.onClickThis, arg_4_0)

	arg_4_0.collectionItemList = {}

	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onClickChoiceDetail, arg_4_0.onClickChoiceDetail, arg_4_0)
	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onClickPieceStoreDetail, arg_4_0.onClickPieceStoreDetail, arg_4_0)
end

function var_0_0.onClickThis(arg_5_0)
	arg_5_0:hideTip()
end

function var_0_0.onClickChoiceDetail(arg_6_0, arg_6_1)
	arg_6_0.collectionIdList = arg_6_1

	arg_6_0:showTip()
end

function var_0_0.onClickPieceStoreDetail(arg_7_0, arg_7_1)
	arg_7_0.collectionIdList = arg_7_1

	arg_7_0:showTip()
end

function var_0_0.showTip(arg_8_0)
	gohelper.setActive(arg_8_0._gochoicetips, true)
	arg_8_0:refreshUI()
end

function var_0_0.hideTip(arg_9_0)
	gohelper.setActive(arg_9_0._gochoicetips, false)
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0._txttitle.text = luaLang("rouge_may_get_collections")

	arg_10_0:refreshCollectionList()
end

function var_0_0.refreshCollectionList(arg_11_0)
	local var_11_0 = arg_11_0:_getOrCreateExtraParams()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.collectionIdList) do
		local var_11_1 = arg_11_0:getCollectionItem(iter_11_0)

		gohelper.setActive(var_11_1.go, true)
		RougeCollectionDescHelper.setCollectionDescInfos3(iter_11_1, nil, var_11_1.txtDesc, nil, var_11_0)

		var_11_1.txtName.text = RougeCollectionConfig.instance:getCollectionName(iter_11_1)

		var_11_1.sImageCollection:LoadImage(RougeCollectionHelper.getCollectionIconUrl(iter_11_1))

		local var_11_2 = RougeCollectionConfig.instance:getCollectionCfg(iter_11_1)

		arg_11_0:refreshHole(var_11_1, var_11_2.holeNum)
	end

	for iter_11_2 = #arg_11_0.collectionIdList + 1, #arg_11_0.collectionItemList do
		local var_11_3 = arg_11_0.collectionItemList[iter_11_2]

		gohelper.setActive(var_11_3.go, false)
	end

	ZProj.UGUIHelper.RebuildLayout(arg_11_0.rectTrContent)

	local var_11_4 = recthelper.getHeight(arg_11_0.rectTrContent)
	local var_11_5 = math.min(var_11_4, RougeMapEnum.MaxTipHeight)

	recthelper.setHeight(arg_11_0.rectViewPort, var_11_5)
end

function var_0_0._getOrCreateExtraParams(arg_12_0)
	if not arg_12_0._extraParams then
		arg_12_0._extraParams = {
			isAllActive = true,
			showDescToListFunc = arg_12_0._ShowDescToListFunc
		}
	end

	return arg_12_0._extraParams
end

local var_0_1 = "#352E24"

function var_0_0._ShowDescToListFunc(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = {}
	local var_13_1 = arg_13_3 and arg_13_3.isAllActive

	for iter_13_0, iter_13_1 in ipairs(arg_13_0) do
		local var_13_2 = arg_13_1[iter_13_1]

		if var_13_2 then
			for iter_13_2, iter_13_3 in ipairs(var_13_2) do
				local var_13_3 = var_13_1 or iter_13_3.isActive
				local var_13_4 = RougeCollectionDescHelper._decorateCollectionEffectStr(iter_13_3.content, var_13_3, var_0_1)
				local var_13_5 = RougeCollectionDescHelper._decorateCollectionEffectStr(iter_13_3.condition, var_13_3, var_0_1)

				table.insert(var_13_0, var_13_4)
				table.insert(var_13_0, var_13_5)
			end
		end
	end

	arg_13_2.text = table.concat(var_13_0, "\n")
end

function var_0_0.getCollectionItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.collectionItemList[arg_14_1]

	if var_14_0 then
		return var_14_0
	end

	local var_14_1 = arg_14_0:getUserDataTb_()

	var_14_1.go = gohelper.cloneInPlace(arg_14_0._gocollectionitem)
	var_14_1.txtDesc = gohelper.findChildText(var_14_1.go, "#txt_desc")
	var_14_1.sImageCollection = gohelper.findChildSingleImage(var_14_1.go, "other/#simage_collection")
	var_14_1.txtName = gohelper.findChildText(var_14_1.go, "other/layout_name/#txt_name")
	var_14_1.goEnchant = gohelper.findChild(var_14_1.go, "other/layout/#go_enchant")
	var_14_1.goEnchantList = arg_14_0:getUserDataTb_()
	var_14_1.click = gohelper.findChildClickWithDefaultAudio(var_14_1.go, "#btn_detail")

	var_14_1.click:AddClickListener(arg_14_0.onClickCollection, arg_14_0, arg_14_1)
	table.insert(var_14_1.goEnchantList, var_14_1.goEnchant)
	table.insert(arg_14_0.collectionItemList, var_14_1)

	return var_14_1
end

function var_0_0.refreshHole(arg_15_0, arg_15_1, arg_15_2)
	for iter_15_0 = 1, arg_15_2 do
		local var_15_0 = arg_15_1.goEnchantList[iter_15_0]

		if not var_15_0 then
			var_15_0 = gohelper.cloneInPlace(arg_15_1.goEnchant)

			table.insert(arg_15_1.goEnchantList, var_15_0)
		end

		gohelper.setActive(var_15_0, true)
	end

	for iter_15_1 = arg_15_2 + 1, #arg_15_1.goEnchantList do
		gohelper.setActive(arg_15_1.goEnchantList[iter_15_1], false)
	end
end

function var_0_0.onClickCollection(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.collectionIdList[arg_16_1]
	local var_16_1 = recthelper.uiPosToScreenPos(arg_16_0.rectCollectionTip)
	local var_16_2 = {
		interactable = false,
		collectionCfgId = var_16_0,
		viewPosition = var_16_1,
		source = RougeEnum.OpenCollectionTipSource.ChoiceView
	}

	RougeController.instance:openRougeCollectionTipView(var_16_2)
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.collectionItemList) do
		iter_18_1.sImageCollection:UnLoadImage()
		iter_18_1.click:RemoveClickListener()
	end

	arg_18_0.click:RemoveClickListener()
end

return var_0_0
