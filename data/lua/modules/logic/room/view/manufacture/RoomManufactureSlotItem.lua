module("modules.logic.room.view.manufacture.RoomManufactureSlotItem", package.seeall)

local var_0_0 = class("RoomManufactureSlotItem", UserDataDispose)
local var_0_1 = 1
local var_0_2 = "slotItem"

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.trans = arg_1_0.go.transform
	arg_1_0.parentView = arg_1_2
	arg_1_0._curViewSlotState = nil

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end

	arg_1_0:addEventListeners()
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._gocontent = gohelper.findChild(arg_2_0.go, "content")
	arg_2_0._golocked = gohelper.findChild(arg_2_0.go, "content/#go_locked")
	arg_2_0._gounlocked = gohelper.findChild(arg_2_0.go, "content/#go_unlocked")
	arg_2_0._goadd = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/slotItemHead/#go_add")
	arg_2_0._goitem = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/slotItemHead/#go_item")
	arg_2_0._imgquality = gohelper.findChildImage(arg_2_0.go, "content/#go_unlocked/slotItemHead/#go_item/#image_quality")
	arg_2_0._txtitemName = gohelper.findChildText(arg_2_0.go, "content/#go_unlocked/slotItemHead/#go_item/#txt_itemName")
	arg_2_0._gowrong = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/slotItemHead/#go_wrong")
	arg_2_0._gowrongwait = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/slotItemHead/#go_wrong/#go_wait")
	arg_2_0._gowrongstop = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/slotItemHead/#go_wrong/#go_stop")
	arg_2_0._goget = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/slotItemHead/#go_get")
	arg_2_0._btngetclick = gohelper.findChildClickWithDefaultAudio(arg_2_0.go, "content/#go_unlocked/slotItemHead/#go_get")
	arg_2_0._goitemBar = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/#go_itemBar")
	arg_2_0._gowait = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/#go_itemBar/wait")
	arg_2_0._gopause = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/#go_itemBar/pause")
	arg_2_0._iconwrongstatus = gohelper.findChildImage(arg_2_0.go, "content/#go_unlocked/#go_itemBar/pause/#simage_status")
	arg_2_0._txtwrongstatus = gohelper.findChildText(arg_2_0.go, "content/#go_unlocked/#go_itemBar/pause/#simage_status/#txt_status")
	arg_2_0._simagepausebarValue = gohelper.findChildImage(arg_2_0.go, "content/#go_unlocked/#go_itemBar/pause/#simage_totalBarValue")
	arg_2_0._txtpauseTime = gohelper.findChildText(arg_2_0.go, "content/#go_unlocked/#go_itemBar/pause/#go_totalTime/#txt_totalTime")
	arg_2_0._gorunning = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/#go_itemBar/producing")
	arg_2_0._simagerunningbarValue = gohelper.findChildImage(arg_2_0.go, "content/#go_unlocked/#go_itemBar/producing/#simage_totalBarValue")
	arg_2_0._txtrunningTime = gohelper.findChildText(arg_2_0.go, "content/#go_unlocked/#go_itemBar/producing/#go_totalTime/#txt_totalTime")
	arg_2_0._goselected = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/#go_selected")
	arg_2_0._goAddEff = gohelper.findChild(arg_2_0.go, "content/#add_effect")
	arg_2_0._btnremove = gohelper.findChildButtonWithAudio(arg_2_0.go, "#btn_remove")
	arg_2_0._gobtnremove = arg_2_0._btnremove.gameObject
	arg_2_0._btnclick = gohelper.findChildClickWithDefaultAudio(arg_2_0.go, "#btn_click")
	arg_2_0._btnmove = gohelper.findChildClickWithDefaultAudio(arg_2_0.go, "#btn_move")
	arg_2_0._gobtnmove = arg_2_0._btnmove.gameObject
	arg_2_0._gomoveup = gohelper.findChild(arg_2_0.go, "#btn_move/#go_up")
	arg_2_0._gomovedown = gohelper.findChild(arg_2_0.go, "#btn_move/#go_down")

	arg_2_0:reset()
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btngetclick:AddClickListener(arg_3_0._onClick, arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._onClick, arg_3_0)
	arg_3_0._btnremove:AddClickListener(arg_3_0._btnremoveOnClick, arg_3_0)
	arg_3_0._btnmove:AddClickListener(arg_3_0._btnmoveOnClick, arg_3_0)
	arg_3_0:addEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedSlotItem, arg_3_0._onChangeSelectedSlotItem, arg_3_0)
	arg_3_0:addEventCb(ManufactureController.instance, ManufactureEvent.PlayAddManufactureItemEff, arg_3_0._onAddManufactureItem, arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onViewChange, arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onViewChange, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btngetclick:RemoveClickListener()
	arg_4_0._btnclick:RemoveClickListener()
	arg_4_0._btnremove:RemoveClickListener()
	arg_4_0._btnmove:RemoveClickListener()
	arg_4_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedSlotItem, arg_4_0._onChangeSelectedSlotItem, arg_4_0)
	arg_4_0:removeEventCb(ManufactureController.instance, ManufactureEvent.PlayAddManufactureItemEff, arg_4_0._onAddManufactureItem, arg_4_0)
	arg_4_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_4_0._onViewChange, arg_4_0)
	arg_4_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_4_0._onViewChange, arg_4_0)
end

function var_0_0._onClick(arg_5_0)
	local var_5_0 = arg_5_0:getViewBuilding()

	ManufactureController.instance:clickSlotItem(var_5_0, arg_5_0.slotId, nil, nil, arg_5_0.index)
end

function var_0_0._btnremoveOnClick(arg_6_0)
	local var_6_0 = arg_6_0:getViewBuilding()

	ManufactureController.instance:clickRemoveSlotManufactureItem(var_6_0, arg_6_0.slotId)
end

function var_0_0._btnmoveOnClick(arg_7_0)
	local var_7_0 = arg_7_0:getViewBuilding()

	ManufactureController.instance:moveManufactureItem(var_7_0, arg_7_0.slotId, arg_7_0._isShowDown)
end

function var_0_0._onChangeSelectedSlotItem(arg_8_0)
	arg_8_0:refreshSelected()
end

function var_0_0._onAddManufactureItem(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	local var_9_0 = arg_9_0:getViewBuilding()
	local var_9_1 = arg_9_0:getSlotId()

	if arg_9_1[var_9_0] and arg_9_1[var_9_0][var_9_1] then
		arg_9_0:playAddManufactureItemEff()
	end
end

function var_0_0._onViewChange(arg_10_0, arg_10_1)
	if arg_10_1 ~= ViewName.RoomManufactureAddPopView then
		return
	end

	arg_10_0:checkBtnShow()
end

function var_0_0.playAddManufactureItemEff(arg_11_0)
	gohelper.setActive(arg_11_0._goAddEff, false)
	gohelper.setActive(arg_11_0._goAddEff, true)
end

function var_0_0.getViewBuilding(arg_12_0)
	local var_12_0
	local var_12_1

	if arg_12_0.parentView then
		var_12_0, var_12_1 = arg_12_0.parentView:getViewBuilding()
	end

	return var_12_0, var_12_1
end

function var_0_0.getSlotId(arg_13_0)
	return arg_13_0.slotId
end

function var_0_0.getItemHeight(arg_14_0)
	return (recthelper.getHeight(arg_14_0.trans))
end

function var_0_0.setData(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:closeGuideTween()

	arg_15_0.slotId = arg_15_1
	arg_15_0.index = arg_15_2
	arg_15_0.go.name = tostring(arg_15_2)

	arg_15_0:refresh()
	gohelper.setActive(arg_15_0._goAddEff, false)
	gohelper.setActive(arg_15_0.go, true)
end

function var_0_0.refresh(arg_16_0)
	arg_16_0:checkState()
	arg_16_0:refreshMoveBtn()
	arg_16_0:refreshManufactureItem()
	arg_16_0:refreshTime()
	arg_16_0:refreshSelected()
	arg_16_0:checkBtnShow()
	arg_16_0:refreshWrong()
end

function var_0_0.checkState(arg_17_0)
	local var_17_0, var_17_1 = arg_17_0:getViewBuilding()
	local var_17_2 = var_17_1 and var_17_1:getSlotState(arg_17_0.slotId) or false

	if arg_17_0._curViewSlotState == var_17_2 then
		return
	end

	arg_17_0._curViewSlotState = var_17_2

	local var_17_3 = false
	local var_17_4 = false
	local var_17_5 = false
	local var_17_6 = false
	local var_17_7 = false
	local var_17_8 = not arg_17_0._curViewSlotState or arg_17_0._curViewSlotState == RoomManufactureEnum.SlotState.Locked

	if not var_17_8 then
		var_17_3 = arg_17_0._curViewSlotState == RoomManufactureEnum.SlotState.None
		var_17_4 = arg_17_0._curViewSlotState == RoomManufactureEnum.SlotState.Running
		var_17_5 = arg_17_0._curViewSlotState == RoomManufactureEnum.SlotState.Wait
		var_17_6 = arg_17_0._curViewSlotState == RoomManufactureEnum.SlotState.Stop
		var_17_7 = arg_17_0._curViewSlotState == RoomManufactureEnum.SlotState.Complete
	end

	gohelper.setActive(arg_17_0._golocked, var_17_8)
	gohelper.setActive(arg_17_0._gounlocked, not var_17_8)
	gohelper.setActive(arg_17_0._goadd, var_17_3)

	local var_17_9 = var_17_4 or var_17_5 or var_17_6 or var_17_7

	gohelper.setActive(arg_17_0._goitem, var_17_9)
	gohelper.setActive(arg_17_0._goget, var_17_7)
	gohelper.setActive(arg_17_0._goitemBar, var_17_4 or var_17_5 or var_17_6)
	gohelper.setActive(arg_17_0._gowait, var_17_5)
	gohelper.setActive(arg_17_0._gorunning, var_17_4)
	gohelper.setActive(arg_17_0._gopause, var_17_6)
	arg_17_0:refreshTime()
	arg_17_0:checkBtnShow()
end

function var_0_0.refreshManufactureItem(arg_18_0)
	local var_18_0, var_18_1 = arg_18_0:getViewBuilding()
	local var_18_2 = var_18_1 and var_18_1:getSlotManufactureItemId(arg_18_0.slotId)

	if not var_18_2 or var_18_2 == 0 then
		return
	end

	local var_18_3 = ManufactureConfig.instance:getItemId(var_18_2)

	if not var_18_3 then
		return
	end

	if not arg_18_0._itemIcon then
		arg_18_0._itemIcon = IconMgr.instance:getCommonItemIcon(arg_18_0._goitem)

		arg_18_0._itemIcon:isEnableClick(false)
		arg_18_0._itemIcon:isShowQuality(false)
	end

	local var_18_4 = ManufactureConfig.instance:getBatchIconPath(var_18_2)

	arg_18_0._itemIcon:setMOValue(MaterialEnum.MaterialType.Item, var_18_3, nil, nil, nil, {
		specificIcon = var_18_4
	})

	local var_18_5 = ManufactureConfig.instance:getManufactureItemName(var_18_2)

	arg_18_0._txtitemName.text = var_18_5 or ""

	local var_18_6 = arg_18_0._itemIcon:getRare()
	local var_18_7 = RoomManufactureEnum.RareImageMap[var_18_6]

	UISpriteSetMgr.instance:setCritterSprite(arg_18_0._imgquality, var_18_7)
end

function var_0_0.refreshTime(arg_19_0)
	local var_19_0 = 0
	local var_19_1 = ""
	local var_19_2, var_19_3 = arg_19_0:getViewBuilding()

	if var_19_3 then
		var_19_0 = var_19_3:getSlotProgress(arg_19_0.slotId)
		var_19_1 = var_19_3:getSlotRemainStrTime(arg_19_0.slotId)
	end

	arg_19_0._txtrunningTime.text = var_19_1
	arg_19_0._txtpauseTime.text = var_19_1

	arg_19_0:_setBarVal(var_19_0)
end

function var_0_0._setBarVal(arg_20_0, arg_20_1)
	arg_20_0._simagerunningbarValue.fillAmount = arg_20_1
	arg_20_0._simagepausebarValue.fillAmount = arg_20_1
	arg_20_0.totalProgress = arg_20_1
end

function var_0_0.refreshMoveBtn(arg_21_0)
	arg_21_0._isShowDown = arg_21_0.index == var_0_1

	gohelper.setActive(arg_21_0._gomoveup, not arg_21_0._isShowDown)
	gohelper.setActive(arg_21_0._gomovedown, arg_21_0._isShowDown)
end

function var_0_0.refreshSelected(arg_22_0)
	local var_22_0 = false

	if arg_22_0.slotId then
		local var_22_1, var_22_2 = ManufactureModel.instance:getSelectedSlot()
		local var_22_3 = arg_22_0:getViewBuilding()

		if var_22_1 and var_22_3 == var_22_1 then
			var_22_0 = true
		end
	end

	gohelper.setActive(arg_22_0._goselected, var_22_0)
end

function var_0_0.checkBtnShow(arg_23_0)
	local var_23_0 = false
	local var_23_1 = false
	local var_23_2, var_23_3 = arg_23_0:getViewBuilding()
	local var_23_4 = ViewMgr.instance:isOpen(ViewName.RoomManufactureAddPopView)

	if var_23_3 and var_23_4 and arg_23_0._curViewSlotState ~= RoomManufactureEnum.SlotState.Complete then
		local var_23_5 = var_23_3:getSlotManufactureItemId(arg_23_0.slotId)

		if var_23_5 and var_23_5 ~= 0 then
			var_23_0 = true
			var_23_1 = var_23_3:getOccupySlotCount(true) > var_0_1
		end
	end

	gohelper.setActive(arg_23_0._gobtnremove, var_23_0)
	gohelper.setActive(arg_23_0._gobtnmove, var_23_1)
end

function var_0_0.refreshWrong(arg_24_0)
	local var_24_0 = arg_24_0:getViewBuilding()
	local var_24_1 = ""
	local var_24_2 = RoomManufactureEnum.DefaultPauseIcon
	local var_24_3 = ManufactureModel.instance:getManufactureWrongType(var_24_0, arg_24_0.slotId)

	if var_24_3 then
		local var_24_4 = RoomManufactureEnum.ManufactureWrongDisplay[var_24_3]

		if var_24_4 then
			var_24_2 = var_24_4.icon
			var_24_1 = luaLang(var_24_4.desc)
		end

		local var_24_5 = var_24_3 == RoomManufactureEnum.ManufactureWrongType.WaitPreMat

		gohelper.setActive(arg_24_0._gowrongwait, var_24_5)
		gohelper.setActive(arg_24_0._gowrongstop, not var_24_5)
	end

	arg_24_0._txtwrongstatus.text = var_24_1

	if not string.nilorempty(var_24_2) then
		UISpriteSetMgr.instance:setRoomSprite(arg_24_0._iconwrongstatus, var_24_2)
	end

	gohelper.setActive(arg_24_0._iconwrongstatus, var_24_2)
	gohelper.setActive(arg_24_0._gowrong, var_24_3)
end

function var_0_0.checkPlayGuideTween(arg_25_0)
	if arg_25_0._guideTweenId then
		return true
	end

	local var_25_0, var_25_1 = arg_25_0:getViewBuilding()
	local var_25_2 = var_25_1 and var_25_1:getSlotState(arg_25_0.slotId, true)
	local var_25_3 = arg_25_0._curViewSlotState == RoomManufactureEnum.SlotState.Running and var_25_2 == RoomManufactureEnum.SlotState.Complete

	if var_25_3 then
		arg_25_0._curViewSlotState = -1

		local var_25_4 = arg_25_0.totalProgress or 0
		local var_25_5 = 1

		arg_25_0._guideTweenId = ZProj.TweenHelper.DOTweenFloat(var_25_4, var_25_5, 1, arg_25_0._setBarVal, arg_25_0._onGuideTweenFinish, arg_25_0, nil, EaseType.Linear)
	end

	return var_25_3
end

function var_0_0.closeGuideTween(arg_26_0)
	if arg_26_0._guideTweenId then
		ZProj.TweenHelper.KillById(arg_26_0._guideTweenId)

		arg_26_0._guideTweenId = nil
	end
end

function var_0_0._onGuideTweenFinish(arg_27_0)
	arg_27_0:closeGuideTween()
	RoomController.instance:dispatchEvent(RoomEvent.ManufactureGuideTweenFinish)
end

function var_0_0.everySecondCall(arg_28_0)
	if arg_28_0._curViewSlotState == RoomManufactureEnum.SlotState.Running then
		arg_28_0:refreshTime()
	end
end

function var_0_0.reset(arg_29_0)
	arg_29_0.slotId = nil
	arg_29_0.index = nil
	arg_29_0._curViewSlotState = nil
	arg_29_0._isShowDown = nil
	arg_29_0.go.name = var_0_2

	gohelper.setActive(arg_29_0._goAddEff, false)
	gohelper.setActive(arg_29_0.go, false)
end

function var_0_0.destroy(arg_30_0)
	arg_30_0:closeGuideTween()
	arg_30_0:removeEventListeners()
	arg_30_0:reset()
	arg_30_0:__onDispose()
end

return var_0_0
