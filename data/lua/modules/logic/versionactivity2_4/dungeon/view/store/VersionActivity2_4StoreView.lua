module("modules.logic.versionactivity2_4.dungeon.view.store.VersionActivity2_4StoreView", package.seeall)

slot0 = class("VersionActivity2_4StoreView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollstore = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_store")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#scroll_store/Viewport/#go_Content")
	slot0._gostoreItem = gohelper.findChild(slot0.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "title/image_LimitTimeBG/#txt_time")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._scrollstore:AddOnValueChanged(slot0._onScrollValueChanged, slot0)
	slot0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._scrollstore:RemoveOnValueChanged()
	slot0:removeEventCb(JumpController.instance, JumpEvent.BeforeJump, slot0.closeThis, slot0)
end

function slot0._onScrollValueChanged(slot0)
	if #slot0.storeItemList > 0 and slot0.storeItemList[1] then
		slot1:refreshTagClip(slot0._scrollstore)
	end
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gostoreItem, false)

	slot0.actId = VersionActivity2_4Enum.ActivityId.DungeonStore
	slot0.storeItemList = slot0:getUserDataTb_()
	slot0.rectTrContent = slot0._goContent:GetComponent(gohelper.Type_RectTransform)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	slot0:refreshTime()
	TaskDispatcher.runRepeat(slot0.refreshTime, slot0, TimeUtil.OneMinuteSecond)
	slot0:refreshStoreContent()
	slot0:_onScrollValueChanged()
	slot0:scrollToFirstNoSellOutStore()
end

function slot0.refreshTime(slot0)
	slot0._txttime.text = ActivityModel.instance:getActivityInfo()[VersionActivity2_4Enum.ActivityId.DungeonStore]:getRemainTimeStr3(false, false)
end

function slot0.refreshStoreContent(slot0)
	if not (slot0.actId and ActivityStoreConfig.instance:getActivityStoreGroupDict(slot0.actId)) then
		return
	end

	slot2 = nil

	for slot6 = 1, #slot1 do
		if not slot0.storeItemList[slot6] then
			slot2 = VersionActivity2_4StoreItem.New()

			slot2:onInitView(gohelper.cloneInPlace(slot0._gostoreItem))
			table.insert(slot0.storeItemList, slot2)
		end

		slot2:updateInfo(slot6, slot1[slot6])
	end
end

function slot0.scrollToFirstNoSellOutStore(slot0)
	if slot0:getFirstNoSellOutGroup() <= 1 then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(slot0.rectTrContent)

	slot2 = 0

	for slot6, slot7 in ipairs(slot0.storeItemList) do
		if slot1 <= slot6 then
			break
		end

		slot2 = slot2 + slot7:getHeight()
	end

	recthelper.setAnchorY(slot0.rectTrContent, math.min(slot2, recthelper.getHeight(slot0.rectTrContent) - recthelper.getHeight(gohelper.findChildComponent(slot0.viewGO, "#scroll_store/Viewport", gohelper.Type_RectTransform))))
end

function slot0.getFirstNoSellOutGroup(slot0)
	for slot5, slot6 in ipairs(ActivityStoreConfig.instance:getActivityStoreGroupDict(slot0.actId)) do
		for slot10, slot11 in ipairs(slot6) do
			if slot11.maxBuyCount == 0 then
				return slot5
			end

			if slot11.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(slot0.actId, slot11.id) > 0 then
				return slot5
			end
		end
	end

	return 1
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshTime, slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.storeItemList) do
		slot5:onDestroy()
	end
end

return slot0
