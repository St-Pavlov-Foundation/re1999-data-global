module("modules.logic.season.view1_6.Season1_6StoreView", package.seeall)

slot0 = class("Season1_6StoreView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "title/#txt_time")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "mask/#scroll_store/Viewport/#go_Content")
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
	slot0._simagebg:LoadImage(SeasonViewHelper.getSeasonIcon("full/shangcheng_bj.png"))
	gohelper.setActive(slot0._gostoreItem, false)

	slot0.storeItemList = slot0:getUserDataTb_()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnGet107GoodsInfo, slot0._onGet107GoodsInfo, slot0)
	slot0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, slot0._onBuyGoodsSuccess, slot0)

	slot0.actId = slot0.viewParam.actId

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	TaskDispatcher.runRepeat(slot0.refreshTime, slot0, TimeUtil.OneMinuteSecond)
	slot0:refreshTime()
	slot0:updateView()
end

function slot0._onGet107GoodsInfo(slot0, slot1)
	if slot1 ~= slot0.actId then
		return
	end

	slot0:updateView()
end

function slot0._onBuyGoodsSuccess(slot0, slot1)
	if slot1 ~= slot0.actId then
		return
	end

	slot0:updateView()
end

function slot0.updateView(slot0)
	slot0:refreshStoreContent()
end

function slot0.refreshStoreContent(slot0)
	slot2 = {}

	if ActivityStoreConfig.instance:getActivityStoreGroupDict(slot0.actId) then
		for slot6, slot7 in pairs(slot1) do
			for slot11, slot12 in pairs(slot7) do
				table.insert(slot2, slot12)
			end
		end
	end

	table.sort(slot2, uv0.sortGoods)

	slot6 = #slot2

	for slot6 = 1, math.max(slot6, #slot0.storeItemList) do
		if not slot0.storeItemList[slot6] then
			slot0.storeItemList[slot6] = Season1_6StoreItem.New(slot0:getItemGo(slot6))
		end

		slot7:setData(slot2[slot6])
	end
end

function slot0.sortGoods(slot0, slot1)
	if (slot0.maxBuyCount ~= 0 and slot0.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(slot0.activityId, slot0.id) <= 0) ~= (slot1.maxBuyCount ~= 0 and slot1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(slot1.activityId, slot1.id) <= 0) then
		if slot2 then
			return false
		end

		return true
	end

	return slot0.id < slot1.id
end

function slot0.getItemGo(slot0, slot1)
	return slot0.viewContainer:getResInst(slot0.viewContainer:getSetting().otherRes.itemPath, slot0._goContent, string.format("item%s", slot1))
end

function slot0.refreshTime(slot0)
	slot2 = ActivityModel.instance:getActMO(slot0.actId):getRealEndTimeStamp() - ServerTime.now()
	slot4 = slot2 % TimeUtil.OneDaySecond
	slot0._txttime.text = string.format(luaLang("versionactivitystoreview_remaintime"), Mathf.Floor(slot2 / TimeUtil.OneDaySecond), Mathf.Floor(slot4 / TimeUtil.OneHourSecond), Mathf.Ceil(slot4 % TimeUtil.OneHourSecond / TimeUtil.OneMinuteSecond))
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshTime, slot0)
	slot0:removeEventCb(VersionActivityController.instance, VersionActivityEvent.OnGet107GoodsInfo, slot0._onGet107GoodsInfo, slot0)
	slot0:removeEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, slot0._onBuyGoodsSuccess, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()

	for slot4, slot5 in ipairs(slot0.storeItemList) do
		slot5:destory()
	end

	slot0.storeItemList = nil
end

return slot0
