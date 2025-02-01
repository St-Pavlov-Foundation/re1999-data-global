module("modules.logic.main.view.MainThumbnailRecommendView", package.seeall)

slot0 = class("MainThumbnailRecommendView", BaseView)

function slot0.onInitView(slot0)
	slot0._goslider = gohelper.findChild(slot0.viewGO, "#go_banner/#go_slider")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_banner/#go_bannercontent")
	slot0._goscroll = gohelper.findChild(slot0.viewGO, "#go_banner/#go_bannerscroll")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._selectItems = {}
	slot0._helpItems = {}
	slot1 = recthelper.getWidth(slot0.viewGO.transform)
	slot0._space = 670
	slot0._scroll = SLFramework.UGUI.UIDragListener.Get(slot0._goscroll)

	slot0._scroll:AddDragBeginListener(slot0._onScrollDragBegin, slot0)
	slot0._scroll:AddDragEndListener(slot0._onScrollDragEnd, slot0)

	slot0._viewClick = gohelper.getClick(slot0._goscroll)

	slot0._viewClick:AddClickListener(slot0._onClickView, slot0)
end

function slot0._onScrollDragBegin(slot0, slot1, slot2)
	slot0._scrollStartPos = slot2.position
end

function slot0._onScrollDragEnd(slot0, slot1, slot2)
	if not slot0._scrollStartPos then
		return
	end

	slot3 = slot2.position
	slot0._scrollStartPos = nil

	if math.abs(slot3.x - slot0._scrollStartPos.x) < math.abs(slot3.y - slot0._scrollStartPos.y) then
		return
	end

	slot7 = slot0:getTargetPageIndex() <= #slot0._pagesCo

	if slot4 > 100 and slot6 >= 1 then
		slot0:setTargetPageIndex(slot6 - 1, slot6)
		slot0:_updateSelectedItem()
		slot0:statRecommendPage(StatEnum.RecommendType.Main, StatEnum.DragType.Manual)
	elseif slot4 < -100 and slot7 then
		slot0:setTargetPageIndex(slot6 + 1, slot6)
		slot0:_updateSelectedItem()
		slot0:statRecommendPage(StatEnum.RecommendType.Main, StatEnum.DragType.Manual)
	end

	slot0:_startAutoSwitch()
end

function slot0.statRecommendPage(slot0, slot1, slot2)
	StatController.instance:track(StatEnum.EventName.ShowRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = slot1,
		[StatEnum.EventProperties.ShowType] = slot2,
		[StatEnum.EventProperties.RecommendPageId] = tostring(slot0._pagesCo[slot0:getTargetPageIndex()].id)
	})
end

function slot0._startAutoSwitch(slot0)
	TaskDispatcher.cancelTask(slot0._onSwitch, slot0)
	TaskDispatcher.runRepeat(slot0._onSwitch, slot0, 5)
end

function slot0._onSwitch(slot0)
	if #slot0._pagesCo == 1 then
		TaskDispatcher.cancelTask(slot0._onSwitch, slot0)

		return
	end

	slot1 = slot0:getTargetPageIndex()

	slot0:setTargetPageIndex(slot1 + 1, slot1)
	slot0:_updateSelectedItem()

	if ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		slot0:statRecommendPage(StatEnum.RecommendType.Main, StatEnum.DragType.Auto)
	end
end

function slot0.setTargetPageIndex(slot0, slot1, slot2)
	slot0._targetPageIndex = slot1
	slot0._prevTargetPageIndex = slot2
end

function slot0.getTargetPageIndex(slot0)
	if slot0._targetPageIndex < 1 then
		return #slot0._pagesCo
	end

	if slot0._targetPageIndex > #slot0._pagesCo then
		return 1
	end

	return slot0._targetPageIndex
end

function slot0._onClickView(slot0)
	if slot0._scrollStartPos then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_jump)

	if slot0._pagesCo[slot0:getTargetPageIndex()] and string.nilorempty(slot1.systemJumpCode) == false then
		StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
			[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Main,
			[StatEnum.EventProperties.RecommendPageId] = tostring(slot1.id),
			[StatEnum.EventProperties.RecommendPageName] = slot1.name
		})
		GameFacade.jumpByAdditionParam(slot1.systemJumpCode)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0._checkExpire(slot0)
	for slot5, slot6 in ipairs(slot0.recommendList) do
		if slot6.type == 1 and slot0:_inOpenTime(slot6) and slot0:_checkRelations(slot6.relations) then
			if VersionValidator.instance:isInReviewing() ~= true or string.nilorempty(slot6.systemJumpCode) or JumpConfig.instance:isOpenJumpId(string.splitToNumber(slot6.systemJumpCode, "#")[1]) then
				slot1 = 0 + 1
			end
		end
	end

	if slot1 ~= slot0._totalPageCount then
		slot0:_clearPages()
		slot0:_initPages()
	end
end

function slot0._checkCountry(slot0, slot1)
	return slot1 == nil or tabletool.len(slot1) == 0 or tabletool.indexOf(slot1, SettingsModel.instance:getRegionShortcut()) ~= nil
end

function slot0._startCheckExpire(slot0)
	TaskDispatcher.cancelTask(slot0._checkExpire, slot0)
	TaskDispatcher.runRepeat(slot0._checkExpire, slot0, 1)
end

function slot0.onOpen(slot0)
	slot0.recommendList = {}

	for slot4, slot5 in ipairs(lua_store_recommend.configList) do
		if slot0:_checkCountry(slot5.country) then
			table.insert(slot0.recommendList, slot5)
		end
	end

	slot0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._checkExpire, slot0)

	if tabletool.len(slot0:_initPages(true)) > 0 then
		slot2 = {}

		for slot6, slot7 in pairs(slot1) do
			table.insert(slot2, slot6)
		end

		StoreRpc.instance:sendGetStoreInfosRequest(slot2)
	end
end

function slot0._initPages(slot0, slot1)
	recthelper.setAnchorX(slot0._gocontent.transform, 0)
	slot0:setTargetPageIndex(1)

	slot2 = {}
	slot0._pagesCo = {}
	slot0._totalPageCount = 0
	slot3 = {}
	slot0._openSummonPoolDic = {}

	for slot8, slot9 in ipairs(SummonMainModel.getValidPools()) do
		slot0._openSummonPoolDic[slot9.id] = slot9
	end

	for slot8, slot9 in ipairs(slot0.recommendList) do
		slot10, slot11, slot12 = slot0:_checkRelations(slot9.relations, nil, slot1)

		if slot9.type == 1 and slot0:_inOpenTime(slot9) and slot10 then
			if VersionValidator.instance:isInReviewing() ~= true or string.nilorempty(slot9.systemJumpCode) or JumpConfig.instance:isOpenJumpId(string.splitToNumber(slot9.systemJumpCode, "#")[1]) then
				table.insert(slot2, slot9)

				slot0._totalPageCount = slot0._totalPageCount + 1
			end
		end

		if slot12 then
			for slot16, slot17 in pairs(slot12) do
				slot3[slot16] = true
			end
		end
	end

	table.sort(slot2, slot0._sort)

	for slot9 = 1, CommonConfig.instance:getConstNum(ConstEnum.MainThumbnailRecommendItemCount) or 14 do
		if slot2[slot9] then
			slot0._pagesCo[#slot0._pagesCo + 1] = slot2[slot9]
		end
	end

	slot0:setSelectItem()
	slot0:setContentItem()
	slot0:_startAutoSwitch()
	slot0:_startCheckExpire()
	slot0:_updateSelectedItem()
	slot0:statRecommendPage(StatEnum.RecommendType.Main, StatEnum.DragType.First)

	return slot3
end

function slot0._sort(slot0, slot1)
	return slot0.order < slot1.order
end

function slot0._checkRelations(slot0, slot1, slot2, slot3)
	slot4 = GameUtil.splitString2(slot1, true)
	slot5 = false
	slot6 = false
	slot7 = nil

	if slot3 then
		slot7 = {}
	end

	if string.nilorempty(slot1) == false and slot4 and #slot4 > 0 then
		for slot11, slot12 in ipairs(slot4) do
			slot13 = true

			if slot12[1] == StoreEnum.RecommendRelationType.Summon then
				if slot0._openSummonPoolDic[slot12[2]] == nil then
					slot13 = false
				end
			elseif slot14 == StoreEnum.RecommendRelationType.PackageStoreGoods then
				if StoreModel.instance:getGoodsMO(slot15) == nil or slot16:isSoldOut() then
					slot13 = false
				end

				slot5 = true
			elseif slot14 == StoreEnum.RecommendRelationType.StoreGoods then
				if StoreModel.instance:getGoodsMO(slot15) == nil or slot16:isSoldOut() or slot16:alreadyHas() then
					slot13 = false
				end

				if slot3 and StoreConfig.instance:getGoodsConfig(slot15) then
					slot7[slot17.storeId] = true
				end
			elseif slot14 == StoreEnum.RecommendRelationType.OtherRecommendClose then
				slot16 = lua_store_entrance.configList[slot15]

				if StoreConfig.instance:getStoreRecommendConfig(slot15).type == 1 and slot0:_inOpenTime(slot17) and slot0:_checkRelations(slot17.relations) then
					slot13 = false
				end
			end

			slot6 = slot6 or slot13
		end
	else
		slot6 = true
	end

	return slot6, slot5, slot7
end

function slot0._inOpenTime(slot0, slot1)
	slot2 = ServerTime.now()

	return slot1.isOffline == 0 and (string.nilorempty(slot1.onlineTime) and slot2 or TimeUtil.stringToTimestamp(slot1.onlineTime)) <= slot2 and slot2 <= (string.nilorempty(slot1.offlineTime) and slot2 or TimeUtil.stringToTimestamp(slot1.offlineTime))
end

function slot0.onOpenFinish(slot0)
end

function slot0.setSelectItem(slot0)
	for slot5 = 1, #slot0._pagesCo do
		slot7 = MainThumbnailBannerSelectItem.New()

		slot7:init({
			go = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goslider),
			index = slot5,
			config = slot0._pagesCo[slot5],
			pos = slot0:_getPos(slot5)
		})
		slot7:updateItem(slot0:getTargetPageIndex(), #slot0._pagesCo)
		table.insert(slot0._selectItems, slot7)
	end
end

function slot0._getPos(slot0, slot1)
	return 55 * (slot1 - 0.5 * (#slot0._pagesCo + 1))
end

function slot0.setContentItem(slot0)
	for slot5 = 1, #slot0._pagesCo do
		slot7 = MainThumbnailBannerContent.New()

		slot7:init({
			go = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._gocontent),
			index = slot5,
			config = slot0._pagesCo[slot5],
			pos = slot0:_getContentPos(-1)
		})
		slot7:updateItem()
		table.insert(slot0._helpItems, slot7)
	end
end

function slot0._getContentPos(slot0, slot1)
	return slot0._space * (slot1 - 1)
end

function slot0._updateSelectedItem(slot0)
	for slot4, slot5 in pairs(slot0._selectItems) do
		slot5:updateItem(slot0:getTargetPageIndex(), #slot0._pagesCo)
	end

	for slot4, slot5 in ipairs(slot0._helpItems) do
		slot5:updateItem(slot0:getTargetPageIndex())
	end

	if not slot0._prevTargetPageIndex then
		slot0:_updateContentPos(slot0:getTargetPageIndex(), slot0:getTargetPageIndex(), true)

		return
	end

	slot0:_updateContentPos(slot0._prevTargetPageIndex, slot0._prevTargetPageIndex, true)
	slot0:_updateContentPos(slot0:getTargetPageIndex(), slot0._targetPageIndex, false)

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot0._tweenId = ZProj.TweenHelper.DOAnchorPosX(slot0._gocontent.transform, (1 - slot0._targetPageIndex) * slot0._space, 0.75, slot0._tweenPosFinish, slot0)
end

function slot0._updateContentPos(slot0, slot1, slot2, slot3)
	recthelper.setAnchorX(slot0._helpItems[slot1]._go.transform, slot0:_getContentPos(slot2))

	if not slot3 then
		return
	end

	recthelper.setAnchorX(slot0._gocontent.transform, (1 - slot2) * slot0._space)
end

function slot0._tweenPosFinish(slot0)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._initPages, slot0)
end

function slot0._clearPages(slot0)
	if slot0._selectItems then
		for slot4, slot5 in pairs(slot0._selectItems) do
			slot5:destroy()
		end

		slot0._selectItems = {}
	end

	if slot0._helpItems then
		for slot4, slot5 in pairs(slot0._helpItems) do
			slot5:destroy()
		end

		slot0._helpItems = {}
	end

	gohelper.destroyAllChildren(slot0._goslider)
	gohelper.destroyAllChildren(slot0._gocontent)
end

function slot0.onDestroyView(slot0)
	slot0:_clearPages()
	slot0._scroll:RemoveDragBeginListener()
	slot0._scroll:RemoveDragEndListener()
	slot0._viewClick:RemoveClickListener()
	TaskDispatcher.cancelTask(slot0._onSwitch, slot0)
	TaskDispatcher.cancelTask(slot0._checkExpire, slot0)
end

return slot0
