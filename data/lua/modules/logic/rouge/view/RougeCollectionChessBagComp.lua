module("modules.logic.rouge.view.RougeCollectionChessBagComp", package.seeall)

local var_0_0 = class("RougeCollectionChessBagComp", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golistbag = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_listbag")
	arg_1_0._golistbagitem = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_listbag/#go_listbagitem")
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_pagearea/#btn_next")
	arg_1_0._btnlast = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_pagearea/#btn_last")
	arg_1_0._txtcurpage = gohelper.findChildText(arg_1_0.viewGO, "#go_pagearea/#txt_curpage")
	arg_1_0._gosizebag = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_sizebag")
	arg_1_0._gosizeitem = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_sizebag/#go_sizecollections/#go_sizeitem")
	arg_1_0._btnlayout = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_layout")
	arg_1_0._btnfilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_filter")
	arg_1_0._gosizecellcontainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_sizebag/#go_sizecellcontainer")
	arg_1_0._gosizecell = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_sizebag/#go_sizecellcontainer/#go_sizecell")
	arg_1_0._gosizecollections = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_sizebag/#go_sizecellcontainer/#go_sizecollections")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_empty")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
	arg_2_0._btnlast:AddClickListener(arg_2_0._btnlastOnClick, arg_2_0)
	arg_2_0._btnlayout:AddClickListener(arg_2_0._btnlayoutOnClick, arg_2_0)
	arg_2_0._btnfilter:AddClickListener(arg_2_0._btnfilterOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnext:RemoveClickListener()
	arg_3_0._btnlast:RemoveClickListener()
	arg_3_0._btnlayout:RemoveClickListener()
	arg_3_0._btnfilter:RemoveClickListener()
end

function var_0_0._btnnextOnClick(arg_4_0)
	arg_4_0:switchPage(true)
end

function var_0_0._btnlastOnClick(arg_5_0)
	arg_5_0:switchPage(false)
end

function var_0_0._btnlayoutOnClick(arg_6_0)
	arg_6_0:onSwitchLayoutType(not arg_6_0._isListLayout)
	arg_6_0:playSwitchLayoutAnim()
	RougeCollectionChessController.instance:closeCollectionTipView()
end

function var_0_0._btnfilterOnClick(arg_7_0)
	RougeCollectionChessController.instance:closeCollectionTipView()

	local var_7_0 = {
		confirmCallback = arg_7_0.onConfirmTagFilterCallback,
		confirmCallbackObj = arg_7_0,
		baseSelectMap = arg_7_0._baseTagSelectMap,
		extraSelectMap = arg_7_0._extraTagSelectMap
	}

	RougeController.instance:openRougeCollectionFilterView(var_7_0)
end

function var_0_0.onConfirmTagFilterCallback(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:onFilterCollectionBag(arg_8_1, arg_8_2)
	arg_8_0:refreshFilterButtonUI()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._sizeCollections = {}
	arg_9_0._sizePlaceCollectionCache = {}
	arg_9_0._listCollections = {}
	arg_9_0._isListLayout = true
	arg_9_0._baseTagSelectMap = {}
	arg_9_0._extraTagSelectMap = {}

	arg_9_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.UpdateCollectionBag, arg_9_0.updateCollectionBag, arg_9_0)

	arg_9_0._animator = gohelper.onceAddComponent(arg_9_0.viewGO, gohelper.Type_Animator)

	gohelper.setActive(arg_9_0._golistbagitem, false)
	gohelper.setActive(arg_9_0._gosizeitem, false)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._curPageIndex = 1

	arg_10_0:buildCollectionSizeBagPlaceInfo()
	arg_10_0:onSwitchLayoutType(true)
end

local var_0_1 = 4

function var_0_0.updateBagList(arg_11_0, arg_11_1, arg_11_2)
	arg_11_1 = arg_11_1 or 0
	arg_11_2 = arg_11_2 or 0

	local var_11_0 = RougeCollectionBagListModel.instance:getList()
	local var_11_1 = var_11_0 and #var_11_0
	local var_11_2 = {}

	if var_11_1 > 0 then
		local var_11_3 = (arg_11_1 - 1) * var_0_1 + 1
		local var_11_4 = arg_11_1 * var_0_1

		var_11_4 = var_11_1 < var_11_4 and var_11_1 or var_11_4

		if var_11_3 <= var_11_4 then
			for iter_11_0 = var_11_3, var_11_4 do
				local var_11_5 = RougeCollectionBagListModel.instance:getByIndex(iter_11_0)
				local var_11_6 = iter_11_0 - var_11_3 + 1
				local var_11_7 = arg_11_0._listCollections[var_11_6]

				if not var_11_7 then
					local var_11_8 = gohelper.cloneInPlace(arg_11_0._golistbagitem, "bagItem_" .. var_11_6)

					var_11_7 = RougeCollectionBagItem.New()

					var_11_7:onInitView(arg_11_0, var_11_8)

					arg_11_0._listCollections[var_11_6] = var_11_7
				end

				var_11_7:reset()
				var_11_7:onUpdateMO(var_11_5)

				var_11_2[var_11_7] = true
			end
		end
	end

	if var_11_2 and arg_11_0._listCollections then
		for iter_11_1, iter_11_2 in pairs(arg_11_0._listCollections) do
			if not var_11_2[iter_11_2] then
				iter_11_2:reset()
			end
		end
	end

	arg_11_0._curPageIndex = arg_11_1
	arg_11_0._txtcurpage.text = string.format("%s / %s", arg_11_1, arg_11_2)
end

function var_0_0.switchPage(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1 and arg_12_0._curPageIndex + 1 or arg_12_0._curPageIndex - 1
	local var_12_1 = arg_12_0:getTotalPageCount()
	local var_12_2 = var_12_1 > 0 and 1 or 0
	local var_12_3 = Mathf.Clamp(var_12_0, var_12_2, var_12_1)

	if var_12_3 == arg_12_0._curPageIndex then
		return
	end

	if arg_12_0._isListLayout then
		arg_12_0:updateBagList(var_12_3, var_12_1)
	else
		arg_12_0:updateSizeList(var_12_3, var_12_1)
	end

	arg_12_0:refreshButtonUI(var_12_3, var_12_2, var_12_1)
	arg_12_0:playSwitchLayoutAnim()
	RougeCollectionChessController.instance:closeCollectionTipView()
end

function var_0_0.getTotalPageCount(arg_13_0)
	local var_13_0 = 0

	if arg_13_0._isListLayout then
		var_13_0 = math.ceil(RougeCollectionBagListModel.instance:getCount() / var_0_1)
	else
		var_13_0 = tabletool.len(arg_13_0._sizePlaceCollectionCache)
	end

	return var_13_0
end

function var_0_0.updateSizeList(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._curPageIndex = arg_14_1

	arg_14_0:placeCollection2SizeBag(arg_14_1)

	arg_14_0._txtcurpage.text = string.format("%s / %s", arg_14_1, arg_14_2)
end

function var_0_0.buildCollectionSizeBagPlaceInfo(arg_15_0)
	local var_15_0 = RougeCollectionBagListModel.instance:getList()

	arg_15_0._unplaceCollections = tabletool.copy(var_15_0)

	table.sort(arg_15_0._unplaceCollections, arg_15_0.sortCollectionByRare)

	local var_15_1 = 1

	arg_15_0._sizePlaceCollectionCache = {}

	local var_15_2 = 200
	local var_15_3 = Vector2(0, 0)

	while #arg_15_0._unplaceCollections > 0 and var_15_2 > 0 do
		arg_15_0:buildPlaceCollectionInfo(var_15_3, RougeEnum.MaxCollectionBagSize, arg_15_0._unplaceCollections, var_15_1)

		var_15_1 = var_15_1 + 1
		var_15_2 = var_15_2 - 1
	end

	if var_15_2 <= 0 then
		logError("构建肉鸽造物背包摆放数据时循环执行超过< %s >次,请检查!!!", var_15_2)
	end
end

function var_0_0.buildPlaceCollectionInfo(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	arg_16_5 = arg_16_5 or 1

	if not arg_16_3 or not arg_16_3[arg_16_5] or not (arg_16_2.x >= 1) or not (arg_16_2.y >= 1) then
		return
	end

	local var_16_0 = arg_16_3[arg_16_5]
	local var_16_1, var_16_2 = RougeCollectionConfig.instance:getShapeSize(var_16_0.cfgId)

	if var_16_1 <= 0 or var_16_2 <= 0 then
		table.remove(arg_16_3, arg_16_5)
		logError("获取造物形状范围不可小于0, id = " .. tostring(var_16_0.cfgId))

		return
	end

	if var_16_1 > arg_16_2.x or var_16_2 > arg_16_2.y then
		return arg_16_0:buildPlaceCollectionInfo(arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5 + 1)
	end

	table.remove(arg_16_3, arg_16_5)

	arg_16_0._sizePlaceCollectionCache[arg_16_4] = arg_16_0._sizePlaceCollectionCache[arg_16_4] or {}

	table.insert(arg_16_0._sizePlaceCollectionCache[arg_16_4], {
		id = var_16_0.id,
		startPlacePos = arg_16_1
	})

	local var_16_3 = arg_16_2.y - var_16_2
	local var_16_4 = arg_16_2.x - var_16_1
	local var_16_5 = Vector2(var_16_4, var_16_2)
	local var_16_6 = Vector2(arg_16_2.x, var_16_3)
	local var_16_7 = arg_16_1 + Vector2(var_16_1, 0)
	local var_16_8 = arg_16_1 + Vector2(0, var_16_2)

	arg_16_0:buildPlaceCollectionInfo(var_16_7, var_16_5, arg_16_3, arg_16_4)
	arg_16_0:buildPlaceCollectionInfo(var_16_8, var_16_6, arg_16_3, arg_16_4)
end

local var_0_2 = Vector2(104, 104)

function var_0_0.placeCollection2SizeBag(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._sizePlaceCollectionCache and arg_17_0._sizePlaceCollectionCache[arg_17_1]
	local var_17_1 = {}

	if var_17_0 then
		for iter_17_0 = 1, #var_17_0 do
			local var_17_2 = arg_17_0._sizeCollections[iter_17_0]

			if not var_17_2 then
				var_17_2 = arg_17_0.viewContainer:getRougePoolComp():getCollectionItem(RougeCollectionSizeBagItem.__cname)

				local var_17_3 = gohelper.cloneInPlace(arg_17_0._gosizeitem, "item_" .. iter_17_0)

				var_17_2:onInit(var_17_3)

				arg_17_0._sizeCollections[iter_17_0] = var_17_2
			end

			var_17_1[var_17_2] = true

			local var_17_4 = RougeCollectionModel.instance:getCollectionByUid(var_17_0[iter_17_0].id)

			var_17_2:reset()
			var_17_2:setPerCellWidthAndHeight(var_0_2.x, var_0_2.y)
			var_17_2:onUpdateMO(var_17_4)

			local var_17_5 = var_17_0[iter_17_0].startPlacePos

			recthelper.setAnchor(var_17_2.viewGO.transform, var_17_5.x * var_0_2.x, -var_17_5.y * var_0_2.y)
		end
	end

	if var_17_1 and arg_17_0._sizeCollections then
		for iter_17_1, iter_17_2 in pairs(arg_17_0._sizeCollections) do
			if not var_17_1[iter_17_2] then
				iter_17_2:reset()
			end
		end
	end
end

function var_0_0.onSwitchLayoutType(arg_18_0, arg_18_1)
	arg_18_0._isListLayout = arg_18_1

	local var_18_0 = arg_18_0:getTotalPageCount()
	local var_18_1 = var_18_0 > 0 and 1 or 0

	gohelper.setActive(arg_18_0._golistbag, arg_18_0._isListLayout)
	gohelper.setActive(arg_18_0._gosizebag, not arg_18_0._isListLayout)
	gohelper.setActive(arg_18_0._goempty, var_18_0 <= 0)

	arg_18_0._curPageIndex = Mathf.Clamp(arg_18_0._curPageIndex, var_18_1, var_18_0)

	if arg_18_0._isListLayout then
		arg_18_0:updateBagList(arg_18_0._curPageIndex, var_18_0)
	else
		arg_18_0:updateSizeList(arg_18_0._curPageIndex, var_18_0)
	end

	arg_18_0:refreshButtonUI(arg_18_0._curPageIndex, var_18_1, var_18_0)
	arg_18_0:refreshLayoutButtonUI()
end

function var_0_0.refreshButtonUI(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = gohelper.findChild(arg_19_0._btnnext.gameObject, "light")
	local var_19_1 = gohelper.findChild(arg_19_0._btnnext.gameObject, "dark")
	local var_19_2 = gohelper.findChild(arg_19_0._btnlast.gameObject, "light")
	local var_19_3 = gohelper.findChild(arg_19_0._btnlast.gameObject, "dark")
	local var_19_4 = arg_19_3 >= arg_19_1 + 1
	local var_19_5 = arg_19_2 <= arg_19_1 - 1

	gohelper.setActive(var_19_0, var_19_4)
	gohelper.setActive(var_19_1, not var_19_4)
	gohelper.setActive(var_19_2, var_19_5)
	gohelper.setActive(var_19_3, not var_19_5)
end

function var_0_0.playSwitchLayoutAnim(arg_20_0)
	local var_20_0 = arg_20_0._isListLayout and "switch_listbg" or "switch_sizebag"

	arg_20_0._animator:Play(var_20_0, 0, 0)
end

function var_0_0.sortCollectionByRare(arg_21_0, arg_21_1)
	local var_21_0 = RougeCollectionConfig.instance:getCollectionCfg(arg_21_0.cfgId)
	local var_21_1 = RougeCollectionConfig.instance:getCollectionCfg(arg_21_1.cfgId)

	if var_21_0.showRare ~= var_21_1.showRare then
		return var_21_0.showRare > var_21_1.showRare
	end

	return var_21_0.id < var_21_1.id
end

function var_0_0.onFilterCollectionBag(arg_22_0, arg_22_1, arg_22_2)
	RougeCollectionBagListModel.instance:onInitData(arg_22_1, arg_22_2)
	arg_22_0:updateCollectionBag()
end

function var_0_0.updateCollectionBag(arg_23_0)
	RougeCollectionBagListModel.instance:filterCollection()
	arg_23_0:buildCollectionSizeBagPlaceInfo()
	arg_23_0:onSwitchLayoutType(arg_23_0._isListLayout)
end

function var_0_0.refreshFilterButtonUI(arg_24_0)
	local var_24_0 = RougeCollectionBagListModel.instance:isFiltering()
	local var_24_1 = gohelper.findChild(arg_24_0._btnfilter.gameObject, "unselect")
	local var_24_2 = gohelper.findChild(arg_24_0._btnfilter.gameObject, "select")

	gohelper.setActive(var_24_2, var_24_0)
	gohelper.setActive(var_24_1, not var_24_0)
end

function var_0_0.refreshLayoutButtonUI(arg_25_0)
	local var_25_0 = gohelper.findChild(arg_25_0._btnlayout.gameObject, "unselect")
	local var_25_1 = gohelper.findChild(arg_25_0._btnlayout.gameObject, "select")

	gohelper.setActive(var_25_1, not arg_25_0._isListLayout)
	gohelper.setActive(var_25_0, arg_25_0._isListLayout)
end

function var_0_0.onClose(arg_26_0)
	return
end

function var_0_0.onDestroyView(arg_27_0)
	if arg_27_0._listCollections then
		for iter_27_0, iter_27_1 in pairs(arg_27_0._listCollections) do
			iter_27_1:destroy()
		end
	end

	if arg_27_0._sizeCollections then
		for iter_27_2, iter_27_3 in pairs(arg_27_0._sizeCollections) do
			iter_27_3:destroy()
		end
	end
end

return var_0_0
