module("modules.logic.versionactivity1_2.versionactivity1_2dungeonother.view.VersionActivity1_2StoreView", package.seeall)

slot0 = class("VersionActivity1_2StoreView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._scrollstore = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_store")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#scroll_store/Viewport/#go_Content")
	slot0._gostoreItem = gohelper.findChild(slot0.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	slot0._gostoregoodsitem = gohelper.findChild(slot0.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "title/time/#txt_time")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "#go_righttop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getVersionTradeBargainBg("linzhonggelou_bj"))
	gohelper.setActive(slot0._gostoreItem, false)

	slot0.storeItemList = {}
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)

	slot0.actId = VersionActivity1_2Enum.ActivityId.DungeonStore

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(slot0.actId, slot0._onOpen, slot0)
end

function slot0._onOpen(slot0)
	TaskDispatcher.runRepeat(slot0.refreshTime, slot0, TimeUtil.OneMinuteSecond)
	slot0:refreshTime()
	slot0:refreshStoreContent()
	slot0:scrollToFirstNoSellOutStore()
end

function slot0.refreshTime(slot0)
	slot2 = ActivityModel.instance:getActivityInfo()[slot0.actId]:getRealEndTimeStamp() - ServerTime.now()
	slot5 = Mathf.Floor(slot2 % TimeUtil.OneDaySecond / TimeUtil.OneHourSecond)

	if Mathf.Floor(slot2 / TimeUtil.OneDaySecond) >= 1 then
		if LangSettings.instance:isEn() then
			slot0._txttime.text = string.format(luaLang("remain"), string.format("%s%s %s%s", slot3, luaLang("time_day"), slot5, luaLang("time_hour2")))
		else
			slot0._txttime.text = string.format(luaLang("remain"), string.format("%s%s%s%s", slot3, luaLang("time_day"), slot5, luaLang("time_hour2")))
		end

		return
	end

	if slot5 >= 1 then
		slot0._txttime.text = string.format(luaLang("remain"), slot5 .. luaLang("time_hour2"))

		return
	end

	if Mathf.Floor(slot4 % TimeUtil.OneHourSecond / TimeUtil.OneMinuteSecond) >= 1 then
		slot0._txttime.text = string.format(luaLang("remain"), slot7 .. luaLang("time_minute2"))

		return
	end

	slot0._txttime.text = string.format(luaLang("remain"), "<1" .. luaLang("time_minute2"))
end

function slot0.refreshStoreContent(slot0)
	slot2 = nil

	for slot6 = 1, #ActivityStoreConfig.instance:getActivityStoreGroupDict(slot0.actId) do
		if not slot0.storeItemList[slot6] then
			slot2 = VersionActivity1_2StoreItem.New()

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

	ZProj.UGUIHelper.RebuildLayout(slot0._goContent.transform)

	slot2 = recthelper.getHeight(slot0._scrollstore.gameObject.transform)
	slot3 = 0

	for slot7, slot8 in ipairs(slot0.storeItemList) do
		if slot1 < slot7 then
			break
		end

		slot3 = slot3 + slot8:getHeight()
	end

	slot0._scrollstore.verticalNormalizedPosition = 1 - (slot3 - slot2) / (recthelper.getHeight(slot0._goContent.transform) - slot2)
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
	slot0._simagebg:UnLoadImage()

	for slot4, slot5 in ipairs(slot0.storeItemList) do
		slot5:onDestroy()
	end

	slot0.storeItemList = nil
end

return slot0
