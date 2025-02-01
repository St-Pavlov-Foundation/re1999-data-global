module("modules.logic.versionactivity.view.VersionActivityStoreView", package.seeall)

slot0 = class("VersionActivityStoreView", BaseView)

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
	slot0._simagebg:LoadImage(ResUrl.getVersionActivityIcon("full/img_bg"))
	gohelper.setActive(slot0._gostoreItem, false)

	slot0.storeItemList = slot0:getUserDataTb_()
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
	slot0:refreshTime()
	slot0:refreshStoreContent()
	slot0:_onScrollValueChanged()
end

function slot0.refreshStoreContent(slot0)
	slot2 = nil

	for slot6 = 1, #ActivityStoreConfig.instance:getActivityStoreGroupDict(VersionActivityEnum.ActivityId.Act107) do
		if not slot0.storeItemList[slot6] then
			slot2 = VersionActivityStoreItem.New()

			slot2:onInitView(gohelper.cloneInPlace(slot0._gostoreItem))
			table.insert(slot0.storeItemList, slot2)
		end

		slot2:updateInfo(slot6, slot1[slot6])
	end
end

function slot0.refreshTime(slot0)
	slot2 = ActivityModel.instance:getActivityInfo()[VersionActivityEnum.ActivityId.Act107]:getRealEndTimeStamp() - ServerTime.now()
	slot4 = slot2 % TimeUtil.OneDaySecond
	slot0._txttime.text = string.format(luaLang("versionactivitystoreview_remaintime"), Mathf.Floor(slot2 / TimeUtil.OneDaySecond), Mathf.Floor(slot4 / TimeUtil.OneHourSecond), Mathf.Ceil(slot4 % TimeUtil.OneHourSecond / TimeUtil.OneMinuteSecond))
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
