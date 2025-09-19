module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_StoreView", package.seeall)

local var_0_0 = class("V1a6_BossRush_StoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._scrollstore = gohelper.findChildScrollRect(arg_1_0.viewGO, "mask/#scroll_store")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content")
	arg_1_0._gostoreItem = gohelper.findChild(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem")
	arg_1_0._goTime = gohelper.findChild(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/tag2/#go_Time")
	arg_1_0._txtTime = gohelper.findChildText(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/tag2/#go_Time/image_TipsBG/#txt_Time")
	arg_1_0._btnTips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/tag2/#go_Time/image_TipsBG/#txt_Time/#btn_Tips")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/tag2/#go_Time/image_TipsBG/#txt_Time/#go_Tips")
	arg_1_0._txtTimeTips = gohelper.findChildText(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/tag2/#go_Time/image_TipsBG/#txt_Time/#go_Tips/image_Tips/#txt_TimeTips")
	arg_1_0._btnclosetip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/tag2/#go_Time/image_TipsBG/#txt_Time/#go_Tips/#btn_closetip")
	arg_1_0._gostoregoodsitem = gohelper.findChild(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem")
	arg_1_0._golimit = gohelper.findChild(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem/go_tag/#go_limit")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_righttop")
	arg_1_0._gotag = gohelper.findChild(arg_1_0.viewGO, "Tag2")
	arg_1_0._gotaglimit = gohelper.findChild(arg_1_0.viewGO, "Tag2/#go_taglimit")
	arg_1_0._txtlimit = gohelper.findChildText(arg_1_0.viewGO, "Tag2/#go_taglimit/#txt_limit")
	arg_1_0._txtTagName = gohelper.findChildText(arg_1_0.viewGO, "Tag2/txt_tagName")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnTips:AddClickListener(arg_2_0._btnTipsOnClick, arg_2_0)
	arg_2_0._btnclosetip:AddClickListener(arg_2_0._btnclosetipOnClick, arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_2_0.refreshStoreContent, arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_2_0.refreshStoreContent, arg_2_0)
	arg_2_0:addEventCb(BossRushController.instance, BossRushEvent.OnHandleInStoreView, arg_2_0._OnHandleInStoreView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnTips:RemoveClickListener()
	arg_3_0._btnclosetip:RemoveClickListener()
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_3_0.refreshStoreContent, arg_3_0)
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_3_0.refreshStoreContent, arg_3_0)
	arg_3_0:removeEventCb(BossRushController.instance, BossRushEvent.OnHandleInStoreView, arg_3_0._OnHandleInStoreView, arg_3_0)
end

function var_0_0._btnclosetipOnClick(arg_4_0)
	return
end

function var_0_0._btnTipsOnClick(arg_5_0)
	return
end

function var_0_0._btntagOnClick(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.itemNormalized[arg_6_1]

	if var_6_0 and var_6_0.centerNormalized then
		arg_6_0:killTween()

		arg_6_0.tweenId = ZProj.TweenHelper.DOTweenFloat(arg_6_0._scrollstore.verticalNormalizedPosition, var_6_0.centerNormalized, 0.5, arg_6_0.tweenFrameCallback, nil, arg_6_0)
	end
end

function var_0_0._editableInitView(arg_7_0)
	gohelper.setActive(arg_7_0._gostoreItem, false)

	arg_7_0.storeItemList = arg_7_0:getUserDataTb_()
	arg_7_0._tagList = arg_7_0:getUserDataTb_()
	arg_7_0.showTagIndex = {
		2
	}

	for iter_7_0 = 1, 3 do
		local var_7_0 = gohelper.findChild(arg_7_0.viewGO, "Tag" .. iter_7_0)

		if var_7_0 then
			local var_7_1 = gohelper.findChildButtonWithAudio(var_7_0, "image_tagType/btn_tag")
			local var_7_2 = gohelper.findChildText(var_7_0, "txt_tagName")
			local var_7_3 = gohelper.findChild(var_7_0, "#go_taglimit")
			local var_7_4 = gohelper.findChildText(var_7_0, "#go_taglimit/#txt_limit")
			local var_7_5 = var_7_0:GetComponent(typeof(UnityEngine.CanvasGroup))
			local var_7_6 = {
				go = var_7_0
			}

			if var_7_1 then
				var_7_1:AddClickListener(arg_7_0._btntagOnClick, arg_7_0, iter_7_0)

				var_7_6.btn = var_7_1
			end

			if var_7_2 then
				var_7_6.titleTxt = var_7_2
			end

			if var_7_3 then
				var_7_6.limitgo = var_7_3

				if var_7_4 then
					var_7_6.limitTxt = var_7_4
				end
			end

			if var_7_5 then
				var_7_6.canvasGroup = var_7_5
			end

			arg_7_0._tagList[iter_7_0] = var_7_6

			gohelper.setActive(var_7_0, false)
		end
	end

	local var_7_7, var_7_8 = V1a6_BossRush_StoreModel.instance:getStoreGroupName(StoreEnum.BossRushStore.UpdateStore)

	arg_7_0._txtTagName.text = var_7_7
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

var_0_0.ActId = VersionActivity1_6Enum.ActivityId.BossRush

function var_0_0._onScrollValueChanged(arg_9_0)
	if #arg_9_0.storeItemList > 0 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.storeItemList) do
			if iter_9_0 == 1 then
				iter_9_1:refreshTagClip(arg_9_0._scrollstore)
			end
		end
	end

	arg_9_0:checkEnableTag()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._scrollstore:AddOnValueChanged(arg_10_0._onScrollValueChanged, arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	TaskDispatcher.runRepeat(arg_10_0.refreshTime, arg_10_0, TimeUtil.OneMinuteSecond)
	arg_10_0:refreshTime()
	arg_10_0:refreshStoreContent()
	arg_10_0:_onScrollValueChanged()
	V1a6_BossRush_StoreModel.instance:setNotNewStoreGoods()
	BossRushController.instance:dispatchEvent(BossRushEvent.OnEnterStoreView)
end

function var_0_0.onOpenFinish(arg_11_0)
	arg_11_0._scrollstore.verticalNormalizedPosition = 1

	local var_11_0 = V1a6_BossRush_StoreModel.instance:getStoreGroupMO()
	local var_11_1 = var_11_0 and var_11_0[StoreEnum.BossRushStore.UpdateStore]

	if not (var_11_1 and next(var_11_1:getGoodsList()) == nil) then
		TaskDispatcher.runDelay(arg_11_0.checkFirstEnterOneDay, arg_11_0, 0.7)
	end
end

function var_0_0._OnHandleInStoreView(arg_12_0)
	arg_12_0._isHandleInStoreView = true
end

function var_0_0.checkFirstEnterOneDay(arg_13_0)
	if arg_13_0:getFirstEnterOneDayPref() == 0 then
		if not arg_13_0._isHandleInStoreView and arg_13_0._scrollstore.verticalNormalizedPosition == 1 then
			arg_13_0:_btntagOnClick(2)
		end

		arg_13_0:setFirstEnterOneDayPref()
	end
end

function var_0_0.refreshStoreContent(arg_14_0)
	local var_14_0 = V1a6_BossRush_StoreModel.instance:getStoreGroupMO()
	local var_14_1 = V1a6_BossRush_StoreModel.instance:getStore()

	for iter_14_0, iter_14_1 in pairs(var_14_1) do
		local var_14_2 = var_14_0[iter_14_1]
		local var_14_3 = arg_14_0.storeItemList[iter_14_1]

		if not var_14_3 then
			var_14_3 = V1a6_BossRush_StoreItem.New()

			local var_14_4 = gohelper.cloneInPlace(arg_14_0._gostoreItem, iter_14_1)

			var_14_3:onInitView(var_14_4)

			arg_14_0.storeItemList[iter_14_1] = var_14_3
		end

		var_14_3:updateInfo(iter_14_0, var_14_2)
	end

	for iter_14_2, iter_14_3 in pairs(arg_14_0.storeItemList) do
		gohelper.setSibling(iter_14_3.go, iter_14_3.groupId or iter_14_2)
	end

	arg_14_0:refreshItemNormalized()
end

function var_0_0.onClose(arg_15_0)
	arg_15_0._scrollstore:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(arg_15_0.refreshTime, arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0.checkFirstEnterOneDay, arg_15_0)
	arg_15_0:killTween()

	if arg_15_0._tagList then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._tagList) do
			if iter_15_1.btn then
				iter_15_1.btn:RemoveClickListener()
			end
		end
	end

	if arg_15_0.storeItemList then
		for iter_15_2, iter_15_3 in pairs(arg_15_0.storeItemList) do
			iter_15_3:onClose()
		end
	end

	V1a6_BossRush_StoreModel.instance:saveAllStoreGroupNewData()
end

function var_0_0.onDestroyView(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.storeItemList) do
		iter_16_1:onDestroy()
	end
end

function var_0_0.refreshTime(arg_17_0)
	local var_17_0 = V1a6_BossRush_StoreModel.instance:getUpdateStoreRemainTime()

	arg_17_0._txtlimit.text = var_17_0

	local var_17_1 = V1a6_BossRush_StoreModel.instance:checkUpdateStoreActivity() or BossRushConfig.instance:getActivityId()
	local var_17_2 = ActivityModel.instance:getActivityInfo()[var_17_1]

	if var_17_2 then
		local var_17_3 = var_17_2:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(arg_17_0._txtTime.gameObject, var_17_3 > 0)

		if var_17_3 > 0 then
			local var_17_4 = TimeUtil.SecondToActivityTimeFormat(var_17_3)

			arg_17_0._txtTime.text = string.format(luaLang("v1a4_bossrush_scoreview_txt_closetime"), var_17_4)
		end
	end
end

function var_0_0.refreshItemNormalized(arg_18_0)
	if arg_18_0.storeItemList then
		ZProj.UGUIHelper.RebuildLayout(arg_18_0._goContent.transform)

		local var_18_0 = recthelper.getHeight(arg_18_0._goContent.transform)

		arg_18_0.itemNormalized = {}

		local var_18_1 = recthelper.getHeight(arg_18_0._scrollstore.transform)
		local var_18_2 = {}

		for iter_18_0, iter_18_1 in pairs(arg_18_0.storeItemList) do
			table.insert(var_18_2, iter_18_1)
		end

		table.sort(var_18_2, function(arg_19_0, arg_19_1)
			return arg_19_0.groupId < arg_19_1.groupId
		end)

		if var_18_0 > 0 then
			local var_18_3 = 0
			local var_18_4 = 0
			local var_18_5 = 90
			local var_18_6 = var_18_0 - var_18_1

			for iter_18_2, iter_18_3 in ipairs(var_18_2) do
				local var_18_7 = iter_18_3:getHeight()
				local var_18_8 = {}
				local var_18_9 = var_18_3 == 0 and 0 or var_18_3
				local var_18_10 = var_18_4 + (var_18_7 - var_18_1)
				local var_18_11 = var_18_4

				var_18_3 = var_18_10 + var_18_5
				var_18_4 = var_18_11 + var_18_7 + var_18_5
				var_18_8.startNormalized = 1 - var_18_9 / var_18_6
				var_18_8.endNormalized = 1 - var_18_3 / var_18_6
				var_18_8.centerNormalized = 1 - var_18_11 / var_18_6

				table.insert(arg_18_0.itemNormalized, var_18_8)
			end
		end

		arg_18_0:checkEnableTag()
	end
end

function var_0_0.checkEnableTag(arg_20_0)
	if not arg_20_0.itemNormalized then
		for iter_20_0, iter_20_1 in ipairs(arg_20_0._tagList) do
			gohelper.setActive(iter_20_1.go, false)
		end

		return
	end

	for iter_20_2, iter_20_3 in ipairs(arg_20_0.showTagIndex) do
		if not arg_20_0.itemNormalized[iter_20_3] then
			return
		end

		local var_20_0 = arg_20_0.itemNormalized[iter_20_3].startNormalized - 0.05
		local var_20_1 = arg_20_0._scrollstore.verticalNormalizedPosition
		local var_20_2 = arg_20_0._tagList[iter_20_3]

		if var_20_2 and var_20_0 then
			local var_20_3 = var_20_1 - var_20_0
			local var_20_4 = 0

			gohelper.setActive(var_20_2.go, true)

			local var_20_5 = 1 - (0.05 - var_20_3) / 0.05
			local var_20_6 = Mathf.Clamp01(var_20_5)

			var_20_2.canvasGroup.alpha = var_20_6

			transformhelper.setLocalPosXY(arg_20_0._gotag.transform, arg_20_0._gotag.transform.localPosition.x, -455 + var_20_6 * 83)
		end
	end
end

function var_0_0.killTween(arg_21_0)
	if arg_21_0.tweenId then
		ZProj.TweenHelper.KillById(arg_21_0.tweenId)

		arg_21_0.tweenId = nil
	end
end

function var_0_0.tweenFrameCallback(arg_22_0, arg_22_1)
	arg_22_0._scrollstore.verticalNormalizedPosition = arg_22_1
end

function var_0_0.getFirstEnterOneDayPref(arg_23_0)
	local var_23_0 = arg_23_0:getFirstEnterOneDayPrefKey()

	return (PlayerPrefsHelper.getNumber(var_23_0, 0))
end

function var_0_0.setFirstEnterOneDayPref(arg_24_0)
	local var_24_0 = arg_24_0:getFirstEnterOneDayPrefKey()

	PlayerPrefsHelper.setNumber(var_24_0, 1)
end

function var_0_0.getFirstEnterOneDayPrefKey(arg_25_0)
	local var_25_0 = PlayerModel.instance:getPlayinfo()
	local var_25_1 = var_25_0 and var_25_0.userId or 1999

	return "BossRush_StoreView_FirstEnterOneDay_" .. var_25_1
end

return var_0_0
