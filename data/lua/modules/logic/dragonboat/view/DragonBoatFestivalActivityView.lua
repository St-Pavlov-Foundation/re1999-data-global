module("modules.logic.dragonboat.view.DragonBoatFestivalActivityView", package.seeall)

slot0 = class("DragonBoatFestivalActivityView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_PanelBG")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Root/Layout/image_LimitTimeBG/#txt_LimitTime")
	slot0._goDescr = gohelper.findChild(slot0.viewGO, "Root/Layout/image_Descr")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Root/Layout/image_Descr/#txt_Descr")
	slot0._scrollItemList = gohelper.findChildScrollRect(slot0.viewGO, "Root/#scroll_ItemList")
	slot0._goPuzzlePicClose = gohelper.findChild(slot0.viewGO, "Root/Right/#go_PuzzlePicClose")
	slot0._goPuzzlePicBG1 = gohelper.findChild(slot0.viewGO, "Root/Right/#go_PuzzlePicClose/#go_PuzzlePicBG1")
	slot0._goPuzzlePicBG2 = gohelper.findChild(slot0.viewGO, "Root/Right/#go_PuzzlePicClose/#go_PuzzlePicBG2")
	slot0._goPuzzlePicFG = gohelper.findChild(slot0.viewGO, "Root/Right/#go_PuzzlePicClose/#go_PuzzlePicFG")
	slot0._goPuzzlePicOpen = gohelper.findChild(slot0.viewGO, "Root/Right/#go_PuzzlePicOpen")
	slot0._imagePuzzlePic = gohelper.findChildImage(slot0.viewGO, "Root/Right/#go_PuzzlePicOpen/#image_PuzzlePic")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._goContentRoot = gohelper.findChild(slot0.viewGO, "Root/#scroll_ItemList/Viewport/Content")
	slot0._mapAnimator = slot0._goPuzzlePicOpen:GetComponent(typeof(UnityEngine.Animator))
	slot0._items = {}
	slot0._hasClickReward = false
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	DragonBoatFestivalModel.instance:setCurDay(nil)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
	slot0:addCustomEvents()
	slot0._simagePanelBG:LoadImage(ResUrl.getV1a9SignSingleBg("v1a9_dragonboat_panelbg"))
	slot0:_refreshItems()
	slot0:_refreshMap()
	AudioMgr.instance:trigger(AudioEnum.DragonBoatFestival.play_ui_jinye_spools_open)
	slot0._mapAnimator:Play("open", 0, 0)
	slot0:_getRemainTimeStr()
	TaskDispatcher.runRepeat(slot0._getRemainTimeStr, slot0, 1)
end

function slot0.addCustomEvents(slot0)
	slot0:addEventCb(DragonBoatFestivalController.instance, DragonBoatFestivalEvent.SelectItem, slot0._onSelectItem, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, slot0._refreshFestivalItem, slot0)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.CommonPropView then
		slot0._hasClickReward = true

		slot0:_onSelectItem()
	end
end

function slot0._getRemainTimeStr(slot0)
	slot0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(ActivityEnum.Activity.DragonBoatFestival)
end

function slot0._onSelectItem(slot0)
	slot0._hasClickReward = true

	if not slot0._goPuzzlePicOpen.activeSelf then
		slot0:_refreshItems()
		slot0:_refreshMap()

		if DragonBoatFestivalModel.instance:isGiftUnlock(DragonBoatFestivalModel.instance:getCurDay()) then
			AudioMgr.instance:trigger(AudioEnum.DragonBoatFestival.play_ui_jinye_spools_open)
			UIBlockMgrExtend.setNeedCircleMv(false)
			UIBlockMgr.instance:startBlock("mapAni")
			slot0._mapAnimator:Play("open", 0, 0)
			TaskDispatcher.runDelay(slot0._openFinished, slot0, 2.33)
		end
	else
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("mapAni")

		if slot2 then
			AudioMgr.instance:trigger(AudioEnum.DragonBoatFestival.play_ui_mln_details_open)
			slot0._mapAnimator:Play("switch", 0, 0)
			TaskDispatcher.runDelay(slot0._switchMap, slot0, 0.35)
		else
			AudioMgr.instance:trigger(AudioEnum.DragonBoatFestival.play_ui_mln_details_open)
			slot0._mapAnimator:Play("close", 0, 0)
			slot0:_refreshItems()
			TaskDispatcher.runDelay(slot0._closeFinished, slot0, 1)
		end
	end
end

function slot0._closeFinished(slot0)
	slot0:_refreshMap()
	UIBlockMgr.instance:endBlock("mapAni")
	DragonBoatFestivalController.instance:dispatchEvent(DragonBoatFestivalEvent.ShowMapFinished)
end

function slot0._switchMap(slot0)
	slot0:_refreshItems()
	slot0:_refreshMap()
	TaskDispatcher.runDelay(slot0._openFinished, slot0, 0.59)
end

function slot0._openFinished(slot0)
	UIBlockMgr.instance:endBlock("mapAni")
end

function slot0._refreshItems(slot0)
	slot0:_refreshFestivalItem()

	slot1 = DragonBoatFestivalModel.instance:getCurDay()
	slot2 = DragonBoatFestivalConfig.instance:getDragonBoatCo(slot1)
	slot3 = DragonBoatFestivalModel.instance:getMaxUnlockDay()

	if slot1 == slot3 and not DragonBoatFestivalModel.instance:isGiftGet(slot3) then
		gohelper.setActive(slot0._goDescr, false)

		slot0._txtDescr.text = ""
	else
		gohelper.setActive(slot0._goDescr, true)

		slot0._txtDescr.text = slot2.desc
	end
end

function slot0._refreshFestivalItem(slot0)
	for slot6, slot7 in ipairs(ActivityConfig.instance:getNorSignActivityCos(ActivityEnum.Activity.DragonBoatFestival)) do
		if not slot0._items[slot7.id] then
			slot9 = DragonBoatFestivalItem.New()

			slot9:init(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goContentRoot), slot7.id)

			slot0._items[slot7.id] = slot9
		else
			slot0._items[slot7.id]:refresh(slot7.id)
		end
	end
end

function slot0._refreshMap(slot0)
	slot1 = DragonBoatFestivalModel.instance:getCurDay()
	slot2 = DragonBoatFestivalModel.instance:getMaxUnlockDay()
	slot4 = DragonBoatFestivalConfig.instance:getDragonBoatCo(slot1)
	slot5 = DragonBoatFestivalModel.instance:isGiftUnlock(slot1)

	if slot1 == slot2 and not DragonBoatFestivalModel.instance:isGiftGet(slot2) and not slot0._hasClickReward then
		slot5 = false
	end

	gohelper.setActive(slot0._goPuzzlePicClose, not slot5)
	gohelper.setActive(slot0._goPuzzlePicOpen, slot5)
	UISpriteSetMgr.instance:setDragonBoatSprite(slot0._imagePuzzlePic, slot4.dayicon)
end

function slot0.onClose(slot0)
	slot0:removeCustomEvents()
end

function slot0.removeCustomEvents(slot0)
	slot0:removeEventCb(DragonBoatFestivalController.instance, DragonBoatFestivalEvent.SelectItem, slot0._onSelectItem, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, slot0._refreshFestivalItem, slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._getRemainTimeStr, slot0)
	TaskDispatcher.cancelTask(slot0._closeToOpen, slot0)
	TaskDispatcher.cancelTask(slot0._openFinished, slot0)
	TaskDispatcher.cancelTask(slot0._closeFinished, slot0)

	if slot0._items then
		for slot4, slot5 in pairs(slot0._items) do
			slot5:destroy()
		end
	end
end

return slot0
