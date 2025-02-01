module("modules.logic.versionactivity2_2.dungeon.view.store.VersionActivity2_2StoreView", package.seeall)

slot0 = class("VersionActivity2_2StoreView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._scrollstore = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_store")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#scroll_store/Viewport/#go_Content")
	slot0._gostoreItem = gohelper.findChild(slot0.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	slot0._gostoregoodsitem = gohelper.findChild(slot0.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "title/#txt_time")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, slot0.onBuyGoodsSuccess, slot0)
	slot0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, slot0.closeThis, slot0)
end

function slot0.onBuyGoodsSuccess(slot0)
	slot0:refreshStore()
end

function slot0.onOpen(slot0)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshStore()
	slot0:refreshTime()
end

function slot0.refreshStore(slot0)
	VersionActivity2_2StoreListModel.instance:refreshStore()
end

function slot0.refreshTime(slot0)
	slot0._txttime.text = TimeUtil.SecondToActivityTimeFormat(ActivityModel.instance:getActivityInfo()[VersionActivity2_2Enum.ActivityId.DungeonStore]:getRealEndTimeStamp() - ServerTime.now())
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
