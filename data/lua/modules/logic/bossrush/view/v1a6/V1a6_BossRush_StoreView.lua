module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_StoreView", package.seeall)

slot0 = class("V1a6_BossRush_StoreView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._scrollstore = gohelper.findChildScrollRect(slot0.viewGO, "mask/#scroll_store")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "mask/#scroll_store/Viewport/#go_Content")
	slot0._gostoreItem = gohelper.findChild(slot0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem")
	slot0._goTime = gohelper.findChild(slot0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/tag2/#go_Time")
	slot0._txtTime = gohelper.findChildText(slot0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/tag2/#go_Time/image_TipsBG/#txt_Time")
	slot0._btnTips = gohelper.findChildButtonWithAudio(slot0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/tag2/#go_Time/image_TipsBG/#txt_Time/#btn_Tips")
	slot0._goTips = gohelper.findChild(slot0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/tag2/#go_Time/image_TipsBG/#txt_Time/#go_Tips")
	slot0._txtTimeTips = gohelper.findChildText(slot0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/tag2/#go_Time/image_TipsBG/#txt_Time/#go_Tips/image_Tips/#txt_TimeTips")
	slot0._btnclosetip = gohelper.findChildButtonWithAudio(slot0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/tag2/#go_Time/image_TipsBG/#txt_Time/#go_Tips/#btn_closetip")
	slot0._gostoregoodsitem = gohelper.findChild(slot0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem")
	slot0._golimit = gohelper.findChild(slot0.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem/go_tag/#go_limit")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "#go_righttop")
	slot0._gotag = gohelper.findChild(slot0.viewGO, "Tag2")
	slot0._gotaglimit = gohelper.findChild(slot0.viewGO, "Tag2/#go_taglimit")
	slot0._txtlimit = gohelper.findChildText(slot0.viewGO, "Tag2/#go_taglimit/#txt_limit")
	slot0._txtTagName = gohelper.findChildText(slot0.viewGO, "Tag2/txt_tagName")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnTips:AddClickListener(slot0._btnTipsOnClick, slot0)
	slot0._btnclosetip:AddClickListener(slot0._btnclosetipOnClick, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0.refreshStoreContent, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0.refreshStoreContent, slot0)
	slot0:addEventCb(BossRushController.instance, BossRushEvent.OnHandleInStoreView, slot0._OnHandleInStoreView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnTips:RemoveClickListener()
	slot0._btnclosetip:RemoveClickListener()
	slot0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0.refreshStoreContent, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0.refreshStoreContent, slot0)
	slot0:removeEventCb(BossRushController.instance, BossRushEvent.OnHandleInStoreView, slot0._OnHandleInStoreView, slot0)
end

function slot0._btnclosetipOnClick(slot0)
end

function slot0._btnTipsOnClick(slot0)
end

function slot0._btntagOnClick(slot0, slot1)
	if slot0.itemNormalized[slot1] and slot2.centerNormalized then
		slot0:killTween()

		slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(slot0._scrollstore.verticalNormalizedPosition, slot2.centerNormalized, 0.5, slot0.tweenFrameCallback, nil, slot0)
	end
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gostoreItem, false)

	slot0.storeItemList = slot0:getUserDataTb_()
	slot0._tagList = slot0:getUserDataTb_()
	slot0.showTagIndex = {
		2
	}

	for slot4 = 1, 3 do
		if gohelper.findChild(slot0.viewGO, "Tag" .. slot4) then
			slot7 = gohelper.findChildText(slot5, "txt_tagName")
			slot8 = gohelper.findChild(slot5, "#go_taglimit")
			slot9 = gohelper.findChildText(slot5, "#go_taglimit/#txt_limit")
			slot10 = slot5:GetComponent(typeof(UnityEngine.CanvasGroup))

			if gohelper.findChildButtonWithAudio(slot5, "image_tagType/btn_tag") then
				slot6:AddClickListener(slot0._btntagOnClick, slot0, slot4)
			end

			if slot7 then
				slot11.titleTxt = slot7
			end

			if slot8 then
				slot11.limitgo = slot8

				if slot9 then
					slot11.limitTxt = slot9
				end
			end

			if slot10 then
				slot11.canvasGroup = slot10
			end

			slot0._tagList[slot4] = {
				go = slot5,
				btn = slot6
			}

			gohelper.setActive(slot5, false)
		end
	end

	slot0._txtTagName.text, slot2 = V1a6_BossRush_StoreModel.instance:getStoreGroupName(StoreEnum.BossRushStore.UpdateStore)
end

function slot0.onUpdateParam(slot0)
end

slot0.ActId = VersionActivity1_6Enum.ActivityId.BossRush

function slot0._onScrollValueChanged(slot0)
	if #slot0.storeItemList > 0 then
		for slot4, slot5 in ipairs(slot0.storeItemList) do
			if slot4 == 1 then
				slot5:refreshTagClip(slot0._scrollstore)
			end
		end
	end

	slot0:checkEnableTag()
end

function slot0.onOpen(slot0)
	slot0._scrollstore:AddOnValueChanged(slot0._onScrollValueChanged, slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	TaskDispatcher.runRepeat(slot0.refreshTime, slot0, TimeUtil.OneMinuteSecond)
	slot0:refreshTime()
	slot0:refreshStoreContent()
	slot0:_onScrollValueChanged()
	V1a6_BossRush_StoreModel.instance:setNotNewStoreGoods()
	BossRushController.instance:dispatchEvent(BossRushEvent.OnEnterStoreView)
end

function slot0.onOpenFinish(slot0)
	slot0._scrollstore.verticalNormalizedPosition = 1
	slot2 = V1a6_BossRush_StoreModel.instance:getStoreGroupMO() and slot1[StoreEnum.BossRushStore.UpdateStore]

	if not (slot2 and next(slot2:getGoodsList()) == nil) then
		TaskDispatcher.runDelay(slot0.checkFirstEnterOneDay, slot0, 0.7)
	end
end

function slot0._OnHandleInStoreView(slot0)
	slot0._isHandleInStoreView = true
end

function slot0.checkFirstEnterOneDay(slot0)
	if slot0:getFirstEnterOneDayPref() == 0 then
		if not slot0._isHandleInStoreView and slot0._scrollstore.verticalNormalizedPosition == 1 then
			slot0:_btntagOnClick(2)
		end

		slot0:setFirstEnterOneDayPref()
	end
end

function slot0.refreshStoreContent(slot0)
	for slot6, slot7 in pairs(V1a6_BossRush_StoreModel.instance:getStore()) do
		slot8 = V1a6_BossRush_StoreModel.instance:getStoreGroupMO()[slot7]

		if not slot0.storeItemList[slot7] then
			slot9 = V1a6_BossRush_StoreItem.New()

			slot9:onInitView(gohelper.cloneInPlace(slot0._gostoreItem, slot7))

			slot0.storeItemList[slot7] = slot9
		end

		slot9:updateInfo(slot6, slot8)
	end

	for slot6, slot7 in pairs(slot0.storeItemList) do
		gohelper.setSibling(slot7.go, slot7.groupId or slot6)
	end

	slot0:refreshItemNormalized()
end

function slot0.onClose(slot0)
	slot0._scrollstore:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(slot0.refreshTime, slot0)
	TaskDispatcher.cancelTask(slot0.checkFirstEnterOneDay, slot0)
	slot0:killTween()

	if slot0._tagList then
		for slot4, slot5 in pairs(slot0._tagList) do
			if slot5.btn then
				slot5.btn:RemoveClickListener()
			end
		end
	end

	if slot0.storeItemList then
		for slot4, slot5 in pairs(slot0.storeItemList) do
			slot5:onClose()
		end
	end

	V1a6_BossRush_StoreModel.instance:saveAllStoreGroupNewData()
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0.storeItemList) do
		slot5:onDestroy()
	end
end

function slot0.refreshTime(slot0)
	slot0._txtlimit.text = V1a6_BossRush_StoreModel.instance:getUpdateStoreRemainTime()

	if ActivityModel.instance:getActivityInfo()[V1a6_BossRush_StoreModel.instance:checkUpdateStoreActivity() or BossRushConfig.instance:getActivityId()] then
		gohelper.setActive(slot0._txtTime.gameObject, slot3:getRealEndTimeStamp() - ServerTime.now() > 0)

		if slot4 > 0 then
			slot0._txtTime.text = string.format(luaLang("v1a4_bossrush_scoreview_txt_closetime"), TimeUtil.SecondToActivityTimeFormat(slot4))
		end
	end
end

function slot0.refreshItemNormalized(slot0)
	if slot0.storeItemList then
		ZProj.UGUIHelper.RebuildLayout(slot0._goContent.transform)

		slot1 = recthelper.getHeight(slot0._goContent.transform)
		slot0.itemNormalized = {}
		slot2 = recthelper.getHeight(slot0._scrollstore.transform)
		slot3 = {}

		for slot7, slot8 in pairs(slot0.storeItemList) do
			table.insert(slot3, slot8)
		end

		table.sort(slot3, function (slot0, slot1)
			return slot0.groupId < slot1.groupId
		end)

		if slot1 > 0 then
			slot4 = 0
			slot6 = 90
			slot1 = slot1 - slot2

			for slot10, slot11 in ipairs(slot3) do
				slot12 = slot11:getHeight()
				slot16 = 0

				table.insert(slot0.itemNormalized, {
					startNormalized = 1 - (slot4 == 0 and 0 or slot4) / slot1,
					endNormalized = 1 - (slot16 + slot12 + slot6 + slot12 - slot2 + slot6) / slot1,
					centerNormalized = 1 - slot16 / slot1
				})
			end
		end

		slot0:checkEnableTag()
	end
end

function slot0.checkEnableTag(slot0)
	if not slot0.itemNormalized then
		for slot4, slot5 in ipairs(slot0._tagList) do
			gohelper.setActive(slot5.go, false)
		end

		return
	end

	for slot4, slot5 in ipairs(slot0.showTagIndex) do
		if not slot0.itemNormalized[slot5] then
			return
		end

		slot6 = slot0.itemNormalized[slot5].startNormalized - 0.05

		if slot0._tagList[slot5] and slot6 then
			slot10 = 0

			gohelper.setActive(slot8.go, true)

			slot10 = Mathf.Clamp01(1 - (0.05 - (slot0._scrollstore.verticalNormalizedPosition - slot6)) / 0.05)
			slot8.canvasGroup.alpha = slot10

			transformhelper.setLocalPosXY(slot0._gotag.transform, slot0._gotag.transform.localPosition.x, -455 + slot10 * 83)
		end
	end
end

function slot0.killTween(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end
end

function slot0.tweenFrameCallback(slot0, slot1)
	slot0._scrollstore.verticalNormalizedPosition = slot1
end

function slot0.getFirstEnterOneDayPref(slot0)
	return PlayerPrefsHelper.getNumber(slot0:getFirstEnterOneDayPrefKey(), 0)
end

function slot0.setFirstEnterOneDayPref(slot0)
	PlayerPrefsHelper.setNumber(slot0:getFirstEnterOneDayPrefKey(), 1)
end

function slot0.getFirstEnterOneDayPrefKey(slot0)
	return "BossRush_StoreView_FirstEnterOneDay_" .. (PlayerModel.instance:getPlayinfo() and slot1.userId or 1999)
end

return slot0
