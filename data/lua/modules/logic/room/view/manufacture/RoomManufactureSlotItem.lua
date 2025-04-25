module("modules.logic.room.view.manufacture.RoomManufactureSlotItem", package.seeall)

slot0 = class("RoomManufactureSlotItem", UserDataDispose)
slot1 = 1
slot2 = "slotItem"

function slot0.ctor(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.go = slot1
	slot0.trans = slot0.go.transform
	slot0.parentView = slot2
	slot0._curViewSlotState = nil

	if slot0._editableInitView then
		slot0:_editableInitView()
	end

	slot0:addEventListeners()
end

function slot0._editableInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.go, "content")
	slot0._golocked = gohelper.findChild(slot0.go, "content/#go_locked")
	slot0._gounlocked = gohelper.findChild(slot0.go, "content/#go_unlocked")
	slot0._goadd = gohelper.findChild(slot0.go, "content/#go_unlocked/slotItemHead/#go_add")
	slot0._goitem = gohelper.findChild(slot0.go, "content/#go_unlocked/slotItemHead/#go_item")
	slot0._imgquality = gohelper.findChildImage(slot0.go, "content/#go_unlocked/slotItemHead/#go_item/#image_quality")
	slot0._txtitemName = gohelper.findChildText(slot0.go, "content/#go_unlocked/slotItemHead/#go_item/#txt_itemName")
	slot0._gowrong = gohelper.findChild(slot0.go, "content/#go_unlocked/slotItemHead/#go_wrong")
	slot0._gowrongwait = gohelper.findChild(slot0.go, "content/#go_unlocked/slotItemHead/#go_wrong/#go_wait")
	slot0._gowrongstop = gohelper.findChild(slot0.go, "content/#go_unlocked/slotItemHead/#go_wrong/#go_stop")
	slot0._goget = gohelper.findChild(slot0.go, "content/#go_unlocked/slotItemHead/#go_get")
	slot0._btngetclick = gohelper.findChildClickWithDefaultAudio(slot0.go, "content/#go_unlocked/slotItemHead/#go_get")
	slot0._goitemBar = gohelper.findChild(slot0.go, "content/#go_unlocked/#go_itemBar")
	slot0._gowait = gohelper.findChild(slot0.go, "content/#go_unlocked/#go_itemBar/wait")
	slot0._gopause = gohelper.findChild(slot0.go, "content/#go_unlocked/#go_itemBar/pause")
	slot0._iconwrongstatus = gohelper.findChildImage(slot0.go, "content/#go_unlocked/#go_itemBar/pause/#simage_status")
	slot0._txtwrongstatus = gohelper.findChildText(slot0.go, "content/#go_unlocked/#go_itemBar/pause/#simage_status/#txt_status")
	slot0._simagepausebarValue = gohelper.findChildImage(slot0.go, "content/#go_unlocked/#go_itemBar/pause/#simage_totalBarValue")
	slot0._txtpauseTime = gohelper.findChildText(slot0.go, "content/#go_unlocked/#go_itemBar/pause/#go_totalTime/#txt_totalTime")
	slot0._gorunning = gohelper.findChild(slot0.go, "content/#go_unlocked/#go_itemBar/producing")
	slot0._simagerunningbarValue = gohelper.findChildImage(slot0.go, "content/#go_unlocked/#go_itemBar/producing/#simage_totalBarValue")
	slot0._txtrunningTime = gohelper.findChildText(slot0.go, "content/#go_unlocked/#go_itemBar/producing/#go_totalTime/#txt_totalTime")
	slot0._goselected = gohelper.findChild(slot0.go, "content/#go_unlocked/#go_selected")
	slot0._goAddEff = gohelper.findChild(slot0.go, "content/#add_effect")
	slot0._btnremove = gohelper.findChildButtonWithAudio(slot0.go, "#btn_remove")
	slot0._gobtnremove = slot0._btnremove.gameObject
	slot0._btnclick = gohelper.findChildClickWithDefaultAudio(slot0.go, "#btn_click")
	slot0._btnmove = gohelper.findChildClickWithDefaultAudio(slot0.go, "#btn_move")
	slot0._gobtnmove = slot0._btnmove.gameObject
	slot0._gomoveup = gohelper.findChild(slot0.go, "#btn_move/#go_up")
	slot0._gomovedown = gohelper.findChild(slot0.go, "#btn_move/#go_down")

	slot0:reset()
end

function slot0.addEventListeners(slot0)
	slot0._btngetclick:AddClickListener(slot0._onClick, slot0)
	slot0._btnclick:AddClickListener(slot0._onClick, slot0)
	slot0._btnremove:AddClickListener(slot0._btnremoveOnClick, slot0)
	slot0._btnmove:AddClickListener(slot0._btnmoveOnClick, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedSlotItem, slot0._onChangeSelectedSlotItem, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.PlayAddManufactureItemEff, slot0._onAddManufactureItem, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onViewChange, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onViewChange, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btngetclick:RemoveClickListener()
	slot0._btnclick:RemoveClickListener()
	slot0._btnremove:RemoveClickListener()
	slot0._btnmove:RemoveClickListener()
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedSlotItem, slot0._onChangeSelectedSlotItem, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.PlayAddManufactureItemEff, slot0._onAddManufactureItem, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onViewChange, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onViewChange, slot0)
end

function slot0._onClick(slot0)
	ManufactureController.instance:clickSlotItem(slot0:getViewBuilding(), slot0.slotId, nil, , slot0.index)
end

function slot0._btnremoveOnClick(slot0)
	ManufactureController.instance:clickRemoveSlotManufactureItem(slot0:getViewBuilding(), slot0.slotId)
end

function slot0._btnmoveOnClick(slot0)
	ManufactureController.instance:moveManufactureItem(slot0:getViewBuilding(), slot0.slotId, slot0._isShowDown)
end

function slot0._onChangeSelectedSlotItem(slot0)
	slot0:refreshSelected()
end

function slot0._onAddManufactureItem(slot0, slot1)
	if not slot1 then
		return
	end

	if slot1[slot0:getViewBuilding()] and slot1[slot2][slot0:getSlotId()] then
		slot0:playAddManufactureItemEff()
	end
end

function slot0._onViewChange(slot0, slot1)
	if slot1 ~= ViewName.RoomManufactureAddPopView then
		return
	end

	slot0:checkBtnShow()
end

function slot0.playAddManufactureItemEff(slot0)
	gohelper.setActive(slot0._goAddEff, false)
	gohelper.setActive(slot0._goAddEff, true)
end

function slot0.getViewBuilding(slot0)
	slot1, slot2 = nil

	if slot0.parentView then
		slot1, slot2 = slot0.parentView:getViewBuilding()
	end

	return slot1, slot2
end

function slot0.getSlotId(slot0)
	return slot0.slotId
end

function slot0.getItemHeight(slot0)
	return recthelper.getHeight(slot0.trans)
end

function slot0.setData(slot0, slot1, slot2)
	slot0:closeGuideTween()

	slot0.slotId = slot1
	slot0.index = slot2
	slot0.go.name = tostring(slot2)

	slot0:refresh()
	gohelper.setActive(slot0._goAddEff, false)
	gohelper.setActive(slot0.go, true)
end

function slot0.refresh(slot0)
	slot0:checkState()
	slot0:refreshMoveBtn()
	slot0:refreshManufactureItem()
	slot0:refreshTime()
	slot0:refreshSelected()
	slot0:checkBtnShow()
	slot0:refreshWrong()
end

function slot0.checkState(slot0)
	slot1, slot2 = slot0:getViewBuilding()

	if slot0._curViewSlotState == (slot2 and slot2:getSlotState(slot0.slotId) or false) then
		return
	end

	slot0._curViewSlotState = slot3
	slot4 = false
	slot5 = false
	slot6 = false
	slot7 = false
	slot8 = false

	if not (not slot0._curViewSlotState or slot0._curViewSlotState == RoomManufactureEnum.SlotState.Locked) then
		slot4 = slot0._curViewSlotState == RoomManufactureEnum.SlotState.None
		slot5 = slot0._curViewSlotState == RoomManufactureEnum.SlotState.Running
		slot6 = slot0._curViewSlotState == RoomManufactureEnum.SlotState.Wait
		slot7 = slot0._curViewSlotState == RoomManufactureEnum.SlotState.Stop
		slot8 = slot0._curViewSlotState == RoomManufactureEnum.SlotState.Complete
	end

	gohelper.setActive(slot0._golocked, slot9)
	gohelper.setActive(slot0._gounlocked, not slot9)
	gohelper.setActive(slot0._goadd, slot4)
	gohelper.setActive(slot0._goitem, slot5 or slot6 or slot7 or slot8)
	gohelper.setActive(slot0._goget, slot8)
	gohelper.setActive(slot0._goitemBar, slot5 or slot6 or slot7)
	gohelper.setActive(slot0._gowait, slot6)
	gohelper.setActive(slot0._gorunning, slot5)
	gohelper.setActive(slot0._gopause, slot7)
	slot0:refreshTime()
	slot0:checkBtnShow()
end

function slot0.refreshManufactureItem(slot0)
	slot1, slot2 = slot0:getViewBuilding()

	if not slot2 or not slot2:getSlotManufactureItemId(slot0.slotId) or slot3 == 0 then
		return
	end

	if not ManufactureConfig.instance:getItemId(slot3) then
		return
	end

	if not slot0._itemIcon then
		slot0._itemIcon = IconMgr.instance:getCommonItemIcon(slot0._goitem)

		slot0._itemIcon:isEnableClick(false)
		slot0._itemIcon:isShowQuality(false)
	end

	slot0._itemIcon:setMOValue(MaterialEnum.MaterialType.Item, slot4, nil, , , {
		specificIcon = ManufactureConfig.instance:getBatchIconPath(slot3)
	})

	slot0._txtitemName.text = ManufactureConfig.instance:getManufactureItemName(slot3) or ""

	UISpriteSetMgr.instance:setCritterSprite(slot0._imgquality, RoomManufactureEnum.RareImageMap[slot0._itemIcon:getRare()])
end

function slot0.refreshTime(slot0)
	slot1 = 0
	slot2 = ""
	slot3, slot4 = slot0:getViewBuilding()

	if slot4 then
		slot1 = slot4:getSlotProgress(slot0.slotId)
		slot2 = slot4:getSlotRemainStrTime(slot0.slotId)
	end

	slot0._txtrunningTime.text = slot2
	slot0._txtpauseTime.text = slot2

	slot0:_setBarVal(slot1)
end

function slot0._setBarVal(slot0, slot1)
	slot0._simagerunningbarValue.fillAmount = slot1
	slot0._simagepausebarValue.fillAmount = slot1
	slot0.totalProgress = slot1
end

function slot0.refreshMoveBtn(slot0)
	slot0._isShowDown = slot0.index == uv0

	gohelper.setActive(slot0._gomoveup, not slot0._isShowDown)
	gohelper.setActive(slot0._gomovedown, slot0._isShowDown)
end

function slot0.refreshSelected(slot0)
	slot1 = false

	if slot0.slotId then
		slot2, slot3 = ManufactureModel.instance:getSelectedSlot()

		if slot2 and slot0:getViewBuilding() == slot2 then
			slot1 = true
		end
	end

	gohelper.setActive(slot0._goselected, slot1)
end

function slot0.checkBtnShow(slot0)
	slot1 = false
	slot2 = false
	slot3, slot4 = slot0:getViewBuilding()

	if slot4 and ViewMgr.instance:isOpen(ViewName.RoomManufactureAddPopView) and slot0._curViewSlotState ~= RoomManufactureEnum.SlotState.Complete and slot4:getSlotManufactureItemId(slot0.slotId) and slot6 ~= 0 then
		slot1 = true
		slot2 = uv0 < slot4:getOccupySlotCount(true)
	end

	gohelper.setActive(slot0._gobtnremove, slot1)
	gohelper.setActive(slot0._gobtnmove, slot2)
end

function slot0.refreshWrong(slot0)
	slot2 = ""
	slot3 = RoomManufactureEnum.DefaultPauseIcon

	if ManufactureModel.instance:getManufactureWrongType(slot0:getViewBuilding(), slot0.slotId) then
		if RoomManufactureEnum.ManufactureWrongDisplay[slot4] then
			slot3 = slot5.icon
			slot2 = luaLang(slot5.desc)
		end

		slot6 = slot4 == RoomManufactureEnum.ManufactureWrongType.WaitPreMat

		gohelper.setActive(slot0._gowrongwait, slot6)
		gohelper.setActive(slot0._gowrongstop, not slot6)
	end

	slot0._txtwrongstatus.text = slot2

	if not string.nilorempty(slot3) then
		UISpriteSetMgr.instance:setRoomSprite(slot0._iconwrongstatus, slot3)
	end

	gohelper.setActive(slot0._iconwrongstatus, slot3)
	gohelper.setActive(slot0._gowrong, slot4)
end

function slot0.checkPlayGuideTween(slot0)
	if slot0._guideTweenId then
		return true
	end

	slot1, slot2 = slot0:getViewBuilding()

	if slot0._curViewSlotState == RoomManufactureEnum.SlotState.Running and (slot2 and slot2:getSlotState(slot0.slotId, true)) == RoomManufactureEnum.SlotState.Complete then
		slot0._curViewSlotState = -1
		slot0._guideTweenId = ZProj.TweenHelper.DOTweenFloat(slot0.totalProgress or 0, 1, 1, slot0._setBarVal, slot0._onGuideTweenFinish, slot0, nil, EaseType.Linear)
	end

	return slot4
end

function slot0.closeGuideTween(slot0)
	if slot0._guideTweenId then
		ZProj.TweenHelper.KillById(slot0._guideTweenId)

		slot0._guideTweenId = nil
	end
end

function slot0._onGuideTweenFinish(slot0)
	slot0:closeGuideTween()
	RoomController.instance:dispatchEvent(RoomEvent.ManufactureGuideTweenFinish)
end

function slot0.everySecondCall(slot0)
	if slot0._curViewSlotState == RoomManufactureEnum.SlotState.Running then
		slot0:refreshTime()
	end
end

function slot0.reset(slot0)
	slot0.slotId = nil
	slot0.index = nil
	slot0._curViewSlotState = nil
	slot0._isShowDown = nil
	slot0.go.name = uv0

	gohelper.setActive(slot0._goAddEff, false)
	gohelper.setActive(slot0.go, false)
end

function slot0.destroy(slot0)
	slot0:closeGuideTween()
	slot0:removeEventListeners()
	slot0:reset()
	slot0:__onDispose()
end

return slot0
