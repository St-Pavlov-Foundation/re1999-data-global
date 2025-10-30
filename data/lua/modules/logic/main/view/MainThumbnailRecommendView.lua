module("modules.logic.main.view.MainThumbnailRecommendView", package.seeall)

local var_0_0 = class("MainThumbnailRecommendView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goslider = gohelper.findChild(arg_1_0.viewGO, "#go_banner/#go_slider")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_banner/#go_bannercontent")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "#go_banner/#go_bannerscroll")

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
	arg_4_0._selectItems = {}
	arg_4_0._helpItems = {}

	local var_4_0 = recthelper.getWidth(arg_4_0.viewGO.transform)

	arg_4_0._space = 670
	arg_4_0._scroll = SLFramework.UGUI.UIDragListener.Get(arg_4_0._goscroll)

	arg_4_0._scroll:AddDragBeginListener(arg_4_0._onScrollDragBegin, arg_4_0)
	arg_4_0._scroll:AddDragEndListener(arg_4_0._onScrollDragEnd, arg_4_0)

	arg_4_0._viewClick = gohelper.getClick(arg_4_0._goscroll)

	arg_4_0._viewClick:AddClickListener(arg_4_0._onClickView, arg_4_0)
end

function var_0_0._onScrollDragBegin(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._scrollStartPos = arg_5_2.position
end

function var_0_0._onScrollDragEnd(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0._scrollStartPos then
		return
	end

	local var_6_0 = arg_6_2.position
	local var_6_1 = var_6_0.x - arg_6_0._scrollStartPos.x
	local var_6_2 = var_6_0.y - arg_6_0._scrollStartPos.y

	arg_6_0._scrollStartPos = nil

	if math.abs(var_6_1) < math.abs(var_6_2) then
		return
	end

	local var_6_3 = arg_6_0:getTargetPageIndex()
	local var_6_4 = var_6_3 <= #arg_6_0._pagesCo
	local var_6_5 = var_6_3 >= 1

	if var_6_1 > 100 and var_6_5 then
		arg_6_0:setTargetPageIndex(var_6_3 - 1, var_6_3)
		arg_6_0:_updateSelectedItem()
		arg_6_0:statRecommendPage(StatEnum.RecommendType.Main, StatEnum.DragType.Manual)
	elseif var_6_1 < -100 and var_6_4 then
		arg_6_0:setTargetPageIndex(var_6_3 + 1, var_6_3)
		arg_6_0:_updateSelectedItem()
		arg_6_0:statRecommendPage(StatEnum.RecommendType.Main, StatEnum.DragType.Manual)
	end

	arg_6_0:_startAutoSwitch()
end

function var_0_0.statRecommendPage(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._pagesCo[arg_7_0:getTargetPageIndex()]

	StatController.instance:track(StatEnum.EventName.ShowRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = arg_7_1,
		[StatEnum.EventProperties.ShowType] = arg_7_2,
		[StatEnum.EventProperties.RecommendPageId] = tostring(var_7_0.id)
	})
end

function var_0_0._startAutoSwitch(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._onSwitch, arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0._onSwitch, arg_8_0, 5)
end

function var_0_0._onSwitch(arg_9_0)
	if #arg_9_0._pagesCo == 1 then
		TaskDispatcher.cancelTask(arg_9_0._onSwitch, arg_9_0)

		return
	end

	local var_9_0 = arg_9_0:getTargetPageIndex()

	arg_9_0:setTargetPageIndex(var_9_0 + 1, var_9_0)
	arg_9_0:_updateSelectedItem()

	if ViewHelper.instance:checkViewOnTheTop(arg_9_0.viewName) then
		arg_9_0:statRecommendPage(StatEnum.RecommendType.Main, StatEnum.DragType.Auto)
	end
end

function var_0_0.setTargetPageIndex(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._targetPageIndex = arg_10_1
	arg_10_0._prevTargetPageIndex = arg_10_2
end

function var_0_0.getTargetPageIndex(arg_11_0)
	if arg_11_0._targetPageIndex < 1 then
		return #arg_11_0._pagesCo
	end

	if arg_11_0._targetPageIndex > #arg_11_0._pagesCo then
		return 1
	end

	return arg_11_0._targetPageIndex
end

function var_0_0._onClickView(arg_12_0)
	if arg_12_0._scrollStartPos then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_jump)

	local var_12_0 = arg_12_0._pagesCo[arg_12_0:getTargetPageIndex()]

	if var_12_0 and string.nilorempty(var_12_0.systemJumpCode) == false then
		StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
			[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Main,
			[StatEnum.EventProperties.RecommendPageId] = tostring(var_12_0.id),
			[StatEnum.EventProperties.RecommendPageName] = var_12_0.name,
			[StatEnum.EventProperties.RecommendPageRank] = arg_12_0:getTargetPageIndex()
		})
		GameFacade.jumpByAdditionParam(var_12_0.systemJumpCode)
	end
end

function var_0_0.onUpdateParam(arg_13_0)
	return
end

function var_0_0._checkExpire(arg_14_0)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.recommendList) do
		if iter_14_1.type == 1 and arg_14_0:_inOpenTime(iter_14_1) and arg_14_0:_checkRelations(iter_14_1.relations) then
			local var_14_1 = string.splitToNumber(iter_14_1.systemJumpCode, "#")[1]

			if VersionValidator.instance:isInReviewing() ~= true or string.nilorempty(iter_14_1.systemJumpCode) or JumpConfig.instance:isOpenJumpId(var_14_1) then
				var_14_0 = var_14_0 + 1
			end
		end
	end

	if var_14_0 ~= arg_14_0._totalPageCount then
		arg_14_0:_clearPages()
		arg_14_0:_initPages()
	end
end

function var_0_0._checkCountry(arg_15_0, arg_15_1)
	local var_15_0 = SettingsModel.instance:getRegionShortcut()

	return arg_15_1 == nil or tabletool.len(arg_15_1) == 0 or tabletool.indexOf(arg_15_1, var_15_0) ~= nil
end

function var_0_0._startCheckExpire(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._checkExpire, arg_16_0)
	TaskDispatcher.runRepeat(arg_16_0._checkExpire, arg_16_0, 1)
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0.recommendList = {}

	for iter_17_0, iter_17_1 in ipairs(lua_store_recommend.configList) do
		if arg_17_0:_checkCountry(iter_17_1.country) then
			table.insert(arg_17_0.recommendList, iter_17_1)
		end
	end

	arg_17_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_17_0._checkExpire, arg_17_0)

	local var_17_0 = arg_17_0:_initPages(true)

	if tabletool.len(var_17_0) > 0 then
		local var_17_1 = {}

		for iter_17_2, iter_17_3 in pairs(var_17_0) do
			table.insert(var_17_1, iter_17_2)
		end

		StoreRpc.instance:sendGetStoreInfosRequest(var_17_1)
	end
end

function var_0_0._initPages(arg_18_0, arg_18_1)
	recthelper.setAnchorX(arg_18_0._gocontent.transform, 0)

	local var_18_0 = {}

	arg_18_0._pagesCo = {}
	arg_18_0._totalPageCount = 0

	local var_18_1 = {}
	local var_18_2 = SummonMainModel.getValidPools()

	arg_18_0._openSummonPoolDic = {}

	for iter_18_0, iter_18_1 in ipairs(var_18_2) do
		arg_18_0._openSummonPoolDic[iter_18_1.id] = iter_18_1
	end

	for iter_18_2, iter_18_3 in ipairs(arg_18_0.recommendList) do
		local var_18_3, var_18_4, var_18_5 = arg_18_0:_checkRelations(iter_18_3.relations, nil, arg_18_1)

		if iter_18_3.type == 1 and arg_18_0:_inOpenTime(iter_18_3) and var_18_3 then
			local var_18_6 = string.splitToNumber(iter_18_3.systemJumpCode, "#")[1]

			if VersionValidator.instance:isInReviewing() ~= true or string.nilorempty(iter_18_3.systemJumpCode) or JumpConfig.instance:isOpenJumpId(var_18_6) then
				table.insert(var_18_0, iter_18_3)

				arg_18_0._totalPageCount = arg_18_0._totalPageCount + 1
			end
		end

		if var_18_5 then
			for iter_18_4, iter_18_5 in pairs(var_18_5) do
				var_18_1[iter_18_4] = true
			end
		end
	end

	local var_18_7 = CommonConfig.instance:getConstNum(ConstEnum.MainThumbnailRecommendItemCount) or 14

	arg_18_0:sortPage(var_18_0)

	for iter_18_6 = 1, var_18_7 do
		if var_18_0[iter_18_6] then
			arg_18_0._pagesCo[#arg_18_0._pagesCo + 1] = var_18_0[iter_18_6]
		end
	end

	local var_18_8 = arg_18_0:_getEnterPageIndex()

	arg_18_0:setTargetPageIndex(var_18_8)
	arg_18_0:setSelectItem()
	arg_18_0:setContentItem()
	arg_18_0:_startAutoSwitch()
	arg_18_0:_startCheckExpire()
	arg_18_0:_updateSelectedItem()
	arg_18_0:statRecommendPage(StatEnum.RecommendType.Main, StatEnum.DragType.First)

	return var_18_1
end

function var_0_0._sort(arg_19_0, arg_19_1)
	return arg_19_0.order < arg_19_1.order
end

function var_0_0.sortPage(arg_20_0, arg_20_1)
	arg_20_0:_cacheConfigGroupData(arg_20_1)
	table.sort(arg_20_1, function(arg_21_0, arg_21_1)
		return arg_20_0:_tabSortGroupFunction(arg_21_0, arg_21_1)
	end)

	arg_20_0._cacheConfigGroupDic = {}
	arg_20_0._cacheConfigOrderDic = {}
end

function var_0_0._cacheConfigGroupData(arg_22_0, arg_22_1)
	arg_22_0._cacheConfigGroupDic = {}
	arg_22_0._cacheConfigOrderDic = {}

	if not arg_22_1 or #arg_22_1 <= 0 then
		return
	end

	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		local var_22_0, var_22_1 = StoreHelper.getRecommendStoreGroupAndOrder(iter_22_1, false)

		arg_22_0._cacheConfigGroupDic[iter_22_1.id] = var_22_0
		arg_22_0._cacheConfigOrderDic[iter_22_1.id] = var_22_1
	end
end

function var_0_0._tabSortGroupFunction(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0._cacheConfigGroupDic[arg_23_1.id]
	local var_23_1 = arg_23_0._cacheConfigGroupDic[arg_23_2.id]

	if var_23_0 == var_23_1 then
		return arg_23_0._cacheConfigOrderDic[arg_23_1.id] < arg_23_0._cacheConfigOrderDic[arg_23_2.id]
	end

	return var_23_0 < var_23_1
end

function var_0_0._checkRelations(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = GameUtil.splitString2(arg_24_1, true)
	local var_24_1 = false
	local var_24_2 = false
	local var_24_3

	if arg_24_3 then
		var_24_3 = {}
	end

	if string.nilorempty(arg_24_1) == false and var_24_0 and #var_24_0 > 0 then
		for iter_24_0, iter_24_1 in ipairs(var_24_0) do
			local var_24_4 = true
			local var_24_5 = iter_24_1[1]
			local var_24_6 = iter_24_1[2]

			if var_24_5 == StoreEnum.RecommendRelationType.Summon then
				if arg_24_0._openSummonPoolDic[var_24_6] == nil then
					var_24_4 = false
				end
			elseif var_24_5 == StoreEnum.RecommendRelationType.PackageStoreGoods then
				local var_24_7 = StoreModel.instance:getGoodsMO(var_24_6)

				if var_24_7 == nil or var_24_7:isSoldOut() then
					var_24_4 = false
				end

				var_24_1 = true
			elseif var_24_5 == StoreEnum.RecommendRelationType.StoreGoods then
				local var_24_8 = StoreModel.instance:getGoodsMO(var_24_6)

				if var_24_8 == nil or var_24_8:isSoldOut() or var_24_8:alreadyHas() then
					var_24_4 = false
				end

				if arg_24_3 then
					local var_24_9 = StoreConfig.instance:getGoodsConfig(var_24_6)

					if var_24_9 then
						var_24_3[var_24_9.storeId] = true
					end
				end
			elseif var_24_5 == StoreEnum.RecommendRelationType.OtherRecommendClose then
				local var_24_10 = lua_store_entrance.configList[var_24_6]
				local var_24_11 = StoreConfig.instance:getStoreRecommendConfig(var_24_6)

				if var_24_11.type == 1 and arg_24_0:_inOpenTime(var_24_11) and arg_24_0:_checkRelations(var_24_11.relations) then
					var_24_4 = false
				end
			end

			var_24_2 = var_24_2 or var_24_4
		end
	else
		var_24_2 = true
	end

	return var_24_2, var_24_1, var_24_3
end

function var_0_0._inOpenTime(arg_25_0, arg_25_1)
	local var_25_0 = ServerTime.now()
	local var_25_1 = TimeUtil.stringToTimestamp(arg_25_1.onlineTime)
	local var_25_2 = TimeUtil.stringToTimestamp(arg_25_1.offlineTime)
	local var_25_3 = string.nilorempty(arg_25_1.onlineTime) and var_25_0 or var_25_1
	local var_25_4 = string.nilorempty(arg_25_1.offlineTime) and var_25_0 or var_25_2

	return arg_25_1.isOffline == 0 and var_25_3 <= var_25_0 and var_25_0 <= var_25_4
end

function var_0_0.onOpenFinish(arg_26_0)
	return
end

function var_0_0.setSelectItem(arg_27_0)
	local var_27_0 = arg_27_0.viewContainer:getSetting().otherRes[1]

	for iter_27_0 = 1, #arg_27_0._pagesCo do
		local var_27_1 = arg_27_0:getResInst(var_27_0, arg_27_0._goslider)
		local var_27_2 = MainThumbnailBannerSelectItem.New()

		var_27_2:init({
			go = var_27_1,
			index = iter_27_0,
			config = arg_27_0._pagesCo[iter_27_0],
			pos = arg_27_0:_getPos(iter_27_0)
		})
		var_27_2:updateItem(arg_27_0:getTargetPageIndex(), #arg_27_0._pagesCo)
		table.insert(arg_27_0._selectItems, var_27_2)
	end
end

function var_0_0._getPos(arg_28_0, arg_28_1)
	return 55 * (arg_28_1 - 0.5 * (#arg_28_0._pagesCo + 1))
end

function var_0_0.setContentItem(arg_29_0)
	local var_29_0 = arg_29_0.viewContainer:getSetting().otherRes[2]

	for iter_29_0 = 1, #arg_29_0._pagesCo do
		local var_29_1 = arg_29_0:getResInst(var_29_0, arg_29_0._gocontent)
		local var_29_2 = MainThumbnailBannerContent.New()

		var_29_2:init({
			go = var_29_1,
			index = iter_29_0,
			config = arg_29_0._pagesCo[iter_29_0],
			pos = arg_29_0:_getContentPos(-1)
		})
		var_29_2:updateItem()
		table.insert(arg_29_0._helpItems, var_29_2)
	end
end

function var_0_0._getContentPos(arg_30_0, arg_30_1)
	return arg_30_0._space * (arg_30_1 - 1)
end

function var_0_0._updateSelectedItem(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0._selectItems) do
		iter_31_1:updateItem(arg_31_0:getTargetPageIndex(), #arg_31_0._pagesCo)
	end

	for iter_31_2, iter_31_3 in ipairs(arg_31_0._helpItems) do
		iter_31_3:updateItem(arg_31_0:getTargetPageIndex())
	end

	if not arg_31_0._prevTargetPageIndex then
		arg_31_0:_updateContentPos(arg_31_0:getTargetPageIndex(), arg_31_0:getTargetPageIndex(), true)

		return
	end

	arg_31_0:_updateContentPos(arg_31_0._prevTargetPageIndex, arg_31_0._prevTargetPageIndex, true)
	arg_31_0:_updateContentPos(arg_31_0:getTargetPageIndex(), arg_31_0._targetPageIndex, false)

	if arg_31_0._tweenId then
		ZProj.TweenHelper.KillById(arg_31_0._tweenId)

		arg_31_0._tweenId = nil
	end

	local var_31_0 = (1 - arg_31_0._targetPageIndex) * arg_31_0._space

	arg_31_0._tweenId = ZProj.TweenHelper.DOAnchorPosX(arg_31_0._gocontent.transform, var_31_0, 0.75, arg_31_0._tweenPosFinish, arg_31_0)
end

function var_0_0._updateContentPos(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = arg_32_0._helpItems[arg_32_1]

	recthelper.setAnchorX(var_32_0._go.transform, arg_32_0:_getContentPos(arg_32_2))

	if not arg_32_3 then
		return
	end

	local var_32_1 = (1 - arg_32_2) * arg_32_0._space

	recthelper.setAnchorX(arg_32_0._gocontent.transform, var_32_1)
end

function var_0_0._tweenPosFinish(arg_33_0)
	return
end

function var_0_0._getEnterPageIndex(arg_34_0)
	local var_34_0 = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.MainThumbnailRecommendViewIndex, "")

	if string.nilorempty(var_34_0) then
		return 1
	else
		local var_34_1 = string.split(var_34_0, "#")
		local var_34_2 = var_34_1[1]
		local var_34_3 = tonumber(var_34_1[2])

		if var_34_2 ~= GameBranchMgr.instance:VHyphenA() then
			return 1
		elseif var_34_3 >= #arg_34_0._pagesCo then
			return 1
		else
			return var_34_3 + 1
		end
	end
end

function var_0_0.onClose(arg_35_0)
	arg_35_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_35_0._initPages, arg_35_0)

	local var_35_0 = GameBranchMgr.instance:VHyphenA() .. "#" .. arg_35_0._targetPageIndex

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.MainThumbnailRecommendViewIndex, var_35_0)
end

function var_0_0._clearPages(arg_36_0)
	if arg_36_0._selectItems then
		for iter_36_0, iter_36_1 in pairs(arg_36_0._selectItems) do
			iter_36_1:destroy()
		end

		arg_36_0._selectItems = {}
	end

	if arg_36_0._helpItems then
		for iter_36_2, iter_36_3 in pairs(arg_36_0._helpItems) do
			iter_36_3:destroy()
		end

		arg_36_0._helpItems = {}
	end

	gohelper.destroyAllChildren(arg_36_0._goslider)
	gohelper.destroyAllChildren(arg_36_0._gocontent)
end

function var_0_0.onDestroyView(arg_37_0)
	arg_37_0:_clearPages()
	arg_37_0._scroll:RemoveDragBeginListener()
	arg_37_0._scroll:RemoveDragEndListener()
	arg_37_0._viewClick:RemoveClickListener()
	TaskDispatcher.cancelTask(arg_37_0._onSwitch, arg_37_0)
	TaskDispatcher.cancelTask(arg_37_0._checkExpire, arg_37_0)
end

return var_0_0
