module("modules.logic.versionactivity1_6.dungeon.view.store.VersionActivity1_6StoreView", package.seeall)

slot0 = class("VersionActivity1_6StoreView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "title/#txt_time")
	slot0._scrollstore = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_store")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#scroll_store/Viewport/#go_Content")
	slot0._gostoreItem = gohelper.findChild(slot0.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	slot0._gostoregoodsitem = gohelper.findChild(slot0.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "#go_righttop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._scrollstore:AddOnValueChanged(slot0._onScrollValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._scrollstore:RemoveOnValueChanged()
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage("singlebg/v1a6_enterview_singlebg/v1a6_store_fullbg.png")
	gohelper.setActive(slot0._gostoreItem, false)

	slot0.actId = VersionActivity1_6Enum.ActivityId.DungeonStore
	slot0.storeItemList = slot0:getUserDataTb_()
	slot0.rectTrContent = slot0._goContent:GetComponent(gohelper.Type_RectTransform)
end

function slot0.onUpdateParam(slot0)
end

function slot0._onScrollValueChanged(slot0)
	if #slot0.storeItemList > 0 then
		for slot4, slot5 in ipairs(slot0.storeItemList) do
			if slot4 == 1 then
				slot5:refreshTagClip(slot0._scrollstore)
			end
		end
	end
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	TaskDispatcher.runRepeat(slot0.refreshTime, slot0, TimeUtil.OneMinuteSecond)
	slot0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, slot0.closeThis, slot0)
	slot0:refreshTime()
	slot0:refreshStoreContent()
	slot0:_onScrollValueChanged()
	slot0:scrollToFirstNoSellOutStore()
end

function slot0.refreshStoreContent(slot0)
	if not ActivityStoreConfig.instance:getActivityStoreGroupDict(VersionActivity1_6Enum.ActivityId.DungeonStore) then
		return
	end

	slot2 = nil

	for slot6 = 1, #slot1 do
		if not slot0.storeItemList[slot6] then
			slot2 = VersionActivity1_6StoreItem.New()

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

	slot5 = recthelper.getHeight(slot0.rectTrContent) - recthelper.getHeight(gohelper.findChildComponent(slot0.viewGO, "#scroll_store/Viewport", gohelper.Type_RectTransform))
	slot6 = 0

	for slot10, slot11 in ipairs(slot0.storeItemList) do
		if slot1 <= slot10 then
			break
		end

		slot6 = slot6 + slot11:getHeight()
	end

	recthelper.setAnchorY(slot0.rectTrContent, math.min(slot6, slot5))
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

function slot0.refreshTime(slot0)
	slot0._txttime.text = ActivityModel.instance:getActivityInfo()[VersionActivity1_6Enum.ActivityId.DungeonStore]:getRemainTimeStr3(false, true)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshTime, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()

	for slot4, slot5 in ipairs(slot0.storeItemList) do
		slot5:onDestroy()
	end
end

return slot0
