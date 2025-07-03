module("modules.logic.tower.view.TowerStoreView", package.seeall)

local var_0_0 = class("TowerStoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._scrollstore = gohelper.findChildScrollRect(arg_1_0.viewGO, "mask/#scroll_store")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content")
	arg_1_0._gostoreItem = gohelper.findChild(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem")
	arg_1_0._goTime = gohelper.findChild(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/tag1/#go_Time")
	arg_1_0._txtTime = gohelper.findChildText(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/tag1/#go_Time/image_TipsBG/#txt_Time")
	arg_1_0._btnTips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/tag1/#go_Time/image_TipsBG/#txt_Time/#btn_Tips")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/tag1/#go_Time/image_TipsBG/#txt_Time/#go_Tips")
	arg_1_0._txtTimeTips = gohelper.findChildText(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/tag1/#go_Time/image_TipsBG/#txt_Time/#go_Tips/image_Tips/#txt_TimeTips")
	arg_1_0._btnclosetip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/tag1/#go_Time/image_TipsBG/#txt_Time/#go_Tips/#btn_closetip")
	arg_1_0._gostoregoodsitem = gohelper.findChild(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem")
	arg_1_0._golimit = gohelper.findChild(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem/go_tag/#go_limit")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_righttop")
	arg_1_0._gotag = gohelper.findChild(arg_1_0.viewGO, "Tag2")
	arg_1_0._gotaglimit = gohelper.findChild(arg_1_0.viewGO, "Tag2/#go_taglimit")
	arg_1_0._txtlimit = gohelper.findChildText(arg_1_0.viewGO, "Tag2/#go_taglimit/#txt_limit")
	arg_1_0._txtTagName = gohelper.findChildText(arg_1_0.viewGO, "Tag2/txt_tagName")
	arg_1_0._btnTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Task")
	arg_1_0._gotaskReddot = gohelper.findChild(arg_1_0.viewGO, "#btn_Task/#go_taskReddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnTips:AddClickListener(arg_2_0._btnTipsOnClick, arg_2_0)
	arg_2_0._btnclosetip:AddClickListener(arg_2_0._btnclosetipOnClick, arg_2_0)
	arg_2_0._btnTask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_2_0.refreshStoreContent, arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_2_0.refreshStoreContent, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.OnHandleInStoreView, arg_2_0._OnHandleInStoreView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnTips:RemoveClickListener()
	arg_3_0._btnclosetip:RemoveClickListener()
	arg_3_0._btnTask:RemoveClickListener()
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_3_0.refreshStoreContent, arg_3_0)
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_3_0.refreshStoreContent, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.OnHandleInStoreView, arg_3_0._OnHandleInStoreView, arg_3_0)
end

function var_0_0._btnclosetipOnClick(arg_4_0)
	return
end

function var_0_0._btnTipsOnClick(arg_5_0)
	return
end

function var_0_0._btntaskOnClick(arg_6_0)
	local var_6_0 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()
	local var_6_1 = {
		towerType = TowerEnum.TowerType.Limited,
		towerId = var_6_0.towerId
	}

	TowerController.instance:openTowerTaskView(var_6_1)
end

function var_0_0._btntagOnClick(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.itemNormalized[arg_7_1]

	if var_7_0 and var_7_0.centerNormalized then
		arg_7_0:killTween()

		arg_7_0.tweenId = ZProj.TweenHelper.DOTweenFloat(arg_7_0._scrollstore.verticalNormalizedPosition, var_7_0.centerNormalized, 0.5, arg_7_0.tweenFrameCallback, nil, arg_7_0)
	end
end

function var_0_0._editableInitView(arg_8_0)
	gohelper.setActive(arg_8_0._gostoreItem, false)

	arg_8_0.storeItemList = arg_8_0:getUserDataTb_()
	arg_8_0._tagList = arg_8_0:getUserDataTb_()
	arg_8_0.showTagIndex = {
		2
	}

	for iter_8_0 = 1, 3 do
		local var_8_0 = gohelper.findChild(arg_8_0.viewGO, "Tag" .. iter_8_0)

		if var_8_0 then
			local var_8_1 = gohelper.findChildButtonWithAudio(var_8_0, "image_tagType/btn_tag")
			local var_8_2 = gohelper.findChildText(var_8_0, "txt_tagName")
			local var_8_3 = gohelper.findChild(var_8_0, "#go_taglimit")
			local var_8_4 = gohelper.findChildText(var_8_0, "#go_taglimit/#txt_limit")
			local var_8_5 = var_8_0:GetComponent(typeof(UnityEngine.CanvasGroup))
			local var_8_6 = {
				go = var_8_0
			}

			if var_8_1 then
				var_8_1:AddClickListener(arg_8_0._btntagOnClick, arg_8_0, iter_8_0)

				var_8_6.btn = var_8_1
			end

			if var_8_2 then
				var_8_6.titleTxt = var_8_2
			end

			if var_8_3 then
				var_8_6.limitgo = var_8_3

				if var_8_4 then
					var_8_6.limitTxt = var_8_4
				end
			end

			if var_8_5 then
				var_8_6.canvasGroup = var_8_5
			end

			arg_8_0._tagList[iter_8_0] = var_8_6

			gohelper.setActive(var_8_0, false)
		end
	end

	local var_8_7, var_8_8 = TowerStoreModel.instance:getStoreGroupName(StoreEnum.TowerStore.NormalStore)

	arg_8_0._txtTagName.text = var_8_7

	gohelper.setActive(arg_8_0._gotaglimit, false)
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0._onScrollValueChanged(arg_10_0)
	if #arg_10_0.storeItemList > 0 then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0.storeItemList) do
			if iter_10_0 == 1 then
				iter_10_1:refreshTagClip(arg_10_0._scrollstore)
			end
		end
	end

	arg_10_0:checkEnableTag()
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0._scrollstore:AddOnValueChanged(arg_11_0._onScrollValueChanged, arg_11_0)
	RedDotController.instance:addRedDot(arg_11_0._gotaskReddot, RedDotEnum.DotNode.TowerTask)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	TaskDispatcher.runRepeat(arg_11_0.refreshTime, arg_11_0, TimeUtil.OneMinuteSecond)
	arg_11_0:refreshTime()
	arg_11_0:refreshStoreContent()
	arg_11_0:_onScrollValueChanged()

	if not TowerStoreModel.instance:isUpdateStoreEmpty() then
		TowerStoreModel.instance:setNotNewStoreGoods()
	end

	TowerController.instance:dispatchEvent(TowerEvent.OnEnterStoreView)
end

function var_0_0.onOpenFinish(arg_12_0)
	arg_12_0._scrollstore.verticalNormalizedPosition = 1

	local var_12_0 = TowerStoreModel.instance:getStoreGroupMO()
	local var_12_1 = var_12_0 and var_12_0[StoreEnum.TowerStore.UpdateStore]

	if not (var_12_1 and next(var_12_1:getGoodsList()) == nil) then
		TaskDispatcher.runDelay(arg_12_0.checkFirstEnterOneDay, arg_12_0, 0.7)
	end
end

function var_0_0._OnHandleInStoreView(arg_13_0)
	arg_13_0._isHandleInStoreView = true
end

function var_0_0.checkFirstEnterOneDay(arg_14_0)
	if arg_14_0:getFirstEnterOneDayPref() == 0 then
		if not arg_14_0._isHandleInStoreView and arg_14_0._scrollstore.verticalNormalizedPosition == 1 then
			arg_14_0:_btntagOnClick(1)
		end

		arg_14_0:setFirstEnterOneDayPref()
	end
end

function var_0_0.refreshStoreContent(arg_15_0)
	local var_15_0 = TowerStoreModel.instance:getStoreGroupMO()
	local var_15_1 = TowerStoreModel.instance:getStore()

	for iter_15_0, iter_15_1 in pairs(var_15_1) do
		local var_15_2 = var_15_0[iter_15_1]

		if var_15_2.goodsInfos and #var_15_2:getGoodsList() > 0 then
			local var_15_3 = arg_15_0.storeItemList[iter_15_1]

			if not var_15_3 then
				var_15_3 = TowerStoreItem.New()

				local var_15_4 = gohelper.cloneInPlace(arg_15_0._gostoreItem, iter_15_1)

				var_15_3:onInitView(var_15_4)

				arg_15_0.storeItemList[iter_15_1] = var_15_3
			end

			var_15_3:updateInfo(iter_15_0, var_15_2)
		elseif arg_15_0.storeItemList[iter_15_1] then
			arg_15_0.storeItemList[iter_15_1]:hideStoreItem()
			arg_15_0.storeItemList[iter_15_1]:onClose()
			arg_15_0.storeItemList[iter_15_1]:onDestroy()

			arg_15_0.storeItemList[iter_15_1] = nil
		end
	end

	for iter_15_2, iter_15_3 in pairs(arg_15_0.storeItemList) do
		gohelper.setSibling(iter_15_3.go, iter_15_3.groupId or iter_15_2)
	end

	arg_15_0:refreshItemNormalized()
end

function var_0_0.onClose(arg_16_0)
	arg_16_0._scrollstore:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(arg_16_0.refreshTime, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.checkFirstEnterOneDay, arg_16_0)
	arg_16_0:killTween()

	if arg_16_0._tagList then
		for iter_16_0, iter_16_1 in pairs(arg_16_0._tagList) do
			if iter_16_1.btn then
				iter_16_1.btn:RemoveClickListener()
			end
		end
	end

	if arg_16_0.storeItemList then
		for iter_16_2, iter_16_3 in pairs(arg_16_0.storeItemList) do
			iter_16_3:onClose()
		end
	end

	TowerStoreModel.instance:saveAllStoreGroupNewData()
end

function var_0_0.onDestroyView(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.storeItemList) do
		iter_17_1:onDestroy()
	end
end

function var_0_0.refreshTime(arg_18_0)
	local var_18_0 = TowerStoreModel.instance:checkUpdateStoreActivity()
	local var_18_1 = ActivityModel.instance:getActivityInfo()[var_18_0]

	if var_18_1 then
		local var_18_2 = var_18_1:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(arg_18_0._txtTime.gameObject, var_18_2 > 0)

		if var_18_2 > 0 then
			local var_18_3 = TimeUtil.SecondToActivityTimeFormat(var_18_2)

			arg_18_0._txtTime.text = string.format(luaLang("v1a4_bossrush_scoreview_txt_closetime"), var_18_3)
		end
	else
		gohelper.setActive(arg_18_0._txtTime.gameObject, false)
	end
end

function var_0_0.refreshItemNormalized(arg_19_0)
	if arg_19_0.storeItemList then
		ZProj.UGUIHelper.RebuildLayout(arg_19_0._goContent.transform)

		local var_19_0 = recthelper.getHeight(arg_19_0._goContent.transform)

		arg_19_0.itemNormalized = {}

		local var_19_1 = recthelper.getHeight(arg_19_0._scrollstore.transform)
		local var_19_2 = {}

		for iter_19_0, iter_19_1 in pairs(arg_19_0.storeItemList) do
			table.insert(var_19_2, iter_19_1)
		end

		table.sort(var_19_2, function(arg_20_0, arg_20_1)
			return arg_20_0.groupId < arg_20_1.groupId
		end)

		if var_19_0 > 0 then
			local var_19_3 = 0
			local var_19_4 = 0
			local var_19_5 = 90
			local var_19_6 = var_19_0 - var_19_1

			for iter_19_2, iter_19_3 in ipairs(var_19_2) do
				local var_19_7 = iter_19_3:getHeight()
				local var_19_8 = {}
				local var_19_9 = var_19_3 == 0 and 0 or var_19_3
				local var_19_10 = var_19_4 + (var_19_7 - var_19_1)
				local var_19_11 = var_19_4

				var_19_3 = var_19_10 + var_19_5
				var_19_4 = var_19_11 + var_19_7 + var_19_5
				var_19_8.startNormalized = 1 - var_19_9 / var_19_6
				var_19_8.endNormalized = 1 - var_19_3 / var_19_6
				var_19_8.centerNormalized = 1 - var_19_11 / var_19_6

				table.insert(arg_19_0.itemNormalized, var_19_8)
			end
		end

		arg_19_0:checkEnableTag()
	end
end

function var_0_0.checkEnableTag(arg_21_0)
	if not arg_21_0.itemNormalized then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0._tagList) do
			gohelper.setActive(iter_21_1.go, false)
		end

		return
	end

	for iter_21_2, iter_21_3 in pairs(arg_21_0._tagList) do
		gohelper.setActive(iter_21_3.go, arg_21_0.itemNormalized[iter_21_2])
	end

	for iter_21_4, iter_21_5 in ipairs(arg_21_0.showTagIndex) do
		if not arg_21_0.itemNormalized[iter_21_5] then
			return
		end

		local var_21_0 = arg_21_0.itemNormalized[iter_21_5].startNormalized - 0.05
		local var_21_1 = arg_21_0._scrollstore.verticalNormalizedPosition
		local var_21_2 = arg_21_0._tagList[iter_21_5]

		if var_21_2 and var_21_0 then
			local var_21_3 = var_21_1 - var_21_0
			local var_21_4 = 0

			gohelper.setActive(var_21_2.go, true)

			local var_21_5 = 1 - (0.05 - var_21_3) / 0.05
			local var_21_6 = Mathf.Clamp01(var_21_5)

			var_21_2.canvasGroup.alpha = var_21_6

			transformhelper.setLocalPosXY(arg_21_0._gotag.transform, arg_21_0._gotag.transform.localPosition.x, -455 + var_21_6 * 83)
		end
	end

	local var_21_7 = TowerStoreModel.instance:getStoreGroupMO()
	local var_21_8 = var_21_7 and var_21_7[StoreEnum.TowerStore.UpdateStore]

	if var_21_8 and next(var_21_8:getGoodsList()) == nil then
		for iter_21_6, iter_21_7 in ipairs(arg_21_0._tagList) do
			gohelper.setActive(iter_21_7.go, false)
		end
	end
end

function var_0_0.killTween(arg_22_0)
	if arg_22_0.tweenId then
		ZProj.TweenHelper.KillById(arg_22_0.tweenId)

		arg_22_0.tweenId = nil
	end
end

function var_0_0.tweenFrameCallback(arg_23_0, arg_23_1)
	arg_23_0._scrollstore.verticalNormalizedPosition = arg_23_1
end

function var_0_0.getFirstEnterOneDayPref(arg_24_0)
	local var_24_0 = arg_24_0:getFirstEnterOneDayPrefKey()

	return (PlayerPrefsHelper.getNumber(var_24_0, 0))
end

function var_0_0.setFirstEnterOneDayPref(arg_25_0)
	local var_25_0 = arg_25_0:getFirstEnterOneDayPrefKey()

	PlayerPrefsHelper.setNumber(var_25_0, 1)
end

function var_0_0.getFirstEnterOneDayPrefKey(arg_26_0)
	local var_26_0 = PlayerModel.instance:getPlayinfo()
	local var_26_1 = var_26_0 and var_26_0.userId or 1999

	return "TowerStoreView_FirstEnterOneDay_" .. var_26_1
end

return var_0_0
