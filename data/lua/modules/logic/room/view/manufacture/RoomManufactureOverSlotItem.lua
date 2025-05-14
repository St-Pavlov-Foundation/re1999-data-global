module("modules.logic.room.view.manufacture.RoomManufactureOverSlotItem", package.seeall)

local var_0_0 = class("RoomManufactureOverSlotItem", UserDataDispose)
local var_0_1 = 1
local var_0_2 = "slotItem"
local var_0_3 = 20

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.trans = arg_1_0.go.transform
	arg_1_0.parent = arg_1_2

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end

	arg_1_0:addEventListeners()
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._gocontent = gohelper.findChild(arg_2_0.go, "content")
	arg_2_0._golocked = gohelper.findChild(arg_2_0.go, "content/#go_locked")
	arg_2_0._gounlocked = gohelper.findChild(arg_2_0.go, "content/#go_unlocked")
	arg_2_0._imgquality = gohelper.findChildImage(arg_2_0.go, "content/#go_unlocked/slotItemHead/#image_quality")
	arg_2_0._goadd = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/slotItemHead/#go_add")
	arg_2_0._goitem = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/slotItemHead/#go_item")
	arg_2_0._gowrong = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/slotItemHead/#go_wrong")
	arg_2_0._gowrongwait = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/slotItemHead/#go_wrong/#go_wait")
	arg_2_0._gowrongstop = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/slotItemHead/#go_wrong/#go_stop")
	arg_2_0._goget = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/slotItemHead/#go_get")
	arg_2_0._gopause = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/pause")
	arg_2_0._iconwrongstatus = gohelper.findChildImage(arg_2_0.go, "content/#go_unlocked/pause/#simage_status")
	arg_2_0._imagepausebarValue = gohelper.findChildImage(arg_2_0.go, "content/#go_unlocked/pause/#simage_barValue")
	arg_2_0._gorunning = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/producing")
	arg_2_0._imagerunningbarValue = gohelper.findChildImage(arg_2_0.go, "content/#go_unlocked/producing/#simage_barValue")
	arg_2_0._txtrunningTime = gohelper.findChildText(arg_2_0.go, "content/#go_unlocked/producing/#txt_time")
	arg_2_0._goselected = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/#go_selected")
	arg_2_0._goAddEff = gohelper.findChild(arg_2_0.go, "content/#go_unlocked/#add")
	arg_2_0._btnremove = gohelper.findChildButtonWithAudio(arg_2_0.go, "content/#btn_remove")
	arg_2_0._gobtnremove = arg_2_0._btnremove.gameObject
	arg_2_0._btnclick = gohelper.findChildClickWithDefaultAudio(arg_2_0.go, "#btn_click")
	arg_2_0._btnmove = gohelper.findChildClickWithDefaultAudio(arg_2_0.go, "#btn_move")
	arg_2_0._gobtnmove = arg_2_0._btnmove.gameObject
	arg_2_0._gomoveup = gohelper.findChild(arg_2_0.go, "#btn_move/#go_up")
	arg_2_0._gomovedown = gohelper.findChild(arg_2_0.go, "#btn_move/#go_down")

	arg_2_0:reset()
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._onClick, arg_3_0)
	arg_3_0._btnremove:AddClickListener(arg_3_0._btnremoveOnClick, arg_3_0)
	arg_3_0._btnmove:AddClickListener(arg_3_0._btnmoveOnClick, arg_3_0)
	arg_3_0:addEventCb(ManufactureController.instance, ManufactureEvent.PlayAddManufactureItemEff, arg_3_0._onAddManufactureItem, arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onViewChange, arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnclick:RemoveClickListener()
	arg_4_0._btnremove:RemoveClickListener()
	arg_4_0._btnmove:RemoveClickListener()
	arg_4_0:removeEventCb(ManufactureController.instance, ManufactureEvent.PlayAddManufactureItemEff, arg_4_0._onAddManufactureItem, arg_4_0)
	arg_4_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_4_0._onViewChange, arg_4_0)
	arg_4_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_4_0._onCloseView, arg_4_0)
end

function var_0_0._onClick(arg_5_0)
	local var_5_0 = arg_5_0:getBelongBuilding()

	ManufactureController.instance:clickSlotItem(var_5_0, arg_5_0.slotId, true, nil, arg_5_0.index)
end

function var_0_0._btnremoveOnClick(arg_6_0)
	local var_6_0 = arg_6_0:getBelongBuilding()

	ManufactureController.instance:clickRemoveSlotManufactureItem(var_6_0, arg_6_0.slotId)
end

function var_0_0._btnmoveOnClick(arg_7_0)
	local var_7_0 = arg_7_0:getBelongBuilding()

	ManufactureController.instance:moveManufactureItem(var_7_0, arg_7_0.slotId, arg_7_0._isShowDown)
end

function var_0_0.onChangeSelectedSlotItem(arg_8_0)
	arg_8_0:refreshSelected()
	arg_8_0:checkBtnShow()
end

function var_0_0._onAddManufactureItem(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	local var_9_0 = arg_9_0:getBelongBuilding()
	local var_9_1 = arg_9_0:getSlotId()

	if arg_9_1[var_9_0] and arg_9_1[var_9_0][var_9_1] then
		arg_9_0:playAddManufactureItemEff()
	end
end

function var_0_0._onCloseView(arg_10_0, arg_10_1)
	if arg_10_1 == ViewName.RoomOneKeyView and arg_10_0._playEffWaitCloseView then
		arg_10_0:playAddManufactureItemEff()
	end

	arg_10_0:_onViewChange(arg_10_1)
end

function var_0_0._onViewChange(arg_11_0, arg_11_1)
	if arg_11_1 ~= ViewName.RoomManufactureAddPopView then
		return
	end

	arg_11_0:checkBtnShow()
end

function var_0_0.getBelongBuilding(arg_12_0)
	if not arg_12_0.parent then
		return
	end

	local var_12_0, var_12_1 = arg_12_0.parent:getViewBuilding()

	return var_12_0, var_12_1
end

function var_0_0.getSlotId(arg_13_0)
	return arg_13_0.slotId
end

function var_0_0.getItemWidth(arg_14_0)
	return (recthelper.getWidth(arg_14_0.trans))
end

function var_0_0.setData(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.slotId = arg_15_1
	arg_15_0.index = arg_15_2
	arg_15_0._playEffWaitCloseView = false

	local var_15_0 = ""
	local var_15_1, var_15_2 = arg_15_0:getBelongBuilding()
	local var_15_3
	local var_15_4

	if var_15_2 then
		var_15_3 = var_15_2.buildingId
		var_15_4 = var_15_2:getSlotPriority(arg_15_0.slotId)
	end

	if var_15_4 then
		var_15_0 = string.format("bId-%s_id-%s_i-%s_p-%s", var_15_3, arg_15_0.slotId, arg_15_0.index, var_15_4)
	else
		var_15_0 = string.format("bId-%s_id-%s_i-%s", var_15_3, arg_15_0.slotId, arg_15_0.index)
	end

	arg_15_0:setPos()

	arg_15_0.go.name = var_15_0

	arg_15_0:refresh()
	arg_15_0:checkBtnShow()
	gohelper.setActive(arg_15_0.go, true)
end

function var_0_0.setPos(arg_16_0, arg_16_1)
	local var_16_0 = 0
	local var_16_1 = 0

	if arg_16_1 then
		var_16_0 = arg_16_1.x
		var_16_1 = arg_16_1.y
	else
		local var_16_2 = arg_16_0:getItemWidth()

		var_16_0 = (var_16_2 + RoomManufactureEnum.OverviewSlotItemSpace) * (arg_16_0.index - 1) + var_16_2 / 2
	end

	transformhelper.setLocalPosXY(arg_16_0.trans, var_16_0 + var_0_3, var_16_1)
end

function var_0_0.refresh(arg_17_0)
	arg_17_0:checkState()
	arg_17_0:refreshMoveBtn()
	arg_17_0:refreshManufactureItem()
	arg_17_0:refreshTime()
	arg_17_0:refreshSelected()
	arg_17_0:checkBtnShow()
	arg_17_0:refreshWrong()
end

function var_0_0.checkState(arg_18_0)
	local var_18_0, var_18_1 = arg_18_0:getBelongBuilding()
	local var_18_2 = var_18_1 and var_18_1:getSlotState(arg_18_0.slotId) or false

	if arg_18_0._curViewSlotState == var_18_2 then
		return
	end

	arg_18_0._curViewSlotState = var_18_2

	local var_18_3 = false
	local var_18_4 = false
	local var_18_5 = false
	local var_18_6 = false
	local var_18_7 = false
	local var_18_8 = not arg_18_0._curViewSlotState or arg_18_0._curViewSlotState == RoomManufactureEnum.SlotState.Locked

	if not var_18_8 then
		var_18_3 = arg_18_0._curViewSlotState == RoomManufactureEnum.SlotState.None
		var_18_4 = arg_18_0._curViewSlotState == RoomManufactureEnum.SlotState.Running
		var_18_5 = arg_18_0._curViewSlotState == RoomManufactureEnum.SlotState.Wait
		var_18_6 = arg_18_0._curViewSlotState == RoomManufactureEnum.SlotState.Stop
		var_18_7 = arg_18_0._curViewSlotState == RoomManufactureEnum.SlotState.Complete
	end

	gohelper.setActive(arg_18_0._golocked, var_18_8)
	gohelper.setActive(arg_18_0._gounlocked, not var_18_8)
	gohelper.setActive(arg_18_0._goadd, var_18_3)

	local var_18_9 = var_18_4 or var_18_5 or var_18_6 or var_18_7

	gohelper.setActive(arg_18_0._goitem, var_18_9)
	gohelper.setActive(arg_18_0._goget, var_18_7)
	gohelper.setActive(arg_18_0._gorunning, var_18_4)
	gohelper.setActive(arg_18_0._gopause, var_18_6)
	arg_18_0:refreshTime()
end

function var_0_0.refreshManufactureItem(arg_19_0)
	local var_19_0, var_19_1 = arg_19_0:getBelongBuilding()
	local var_19_2 = var_19_1 and var_19_1:getSlotManufactureItemId(arg_19_0.slotId)

	if not var_19_2 or var_19_2 == 0 then
		return
	end

	local var_19_3 = var_19_2 and ManufactureConfig.instance:getItemId(var_19_2)

	if not var_19_3 then
		return
	end

	if not arg_19_0._itemIcon then
		arg_19_0._itemIcon = IconMgr.instance:getCommonItemIcon(arg_19_0._goitem)

		arg_19_0._itemIcon:isEnableClick(false)
		arg_19_0._itemIcon:isShowQuality(false)
	end

	local var_19_4 = ManufactureConfig.instance:getBatchIconPath(var_19_2)

	arg_19_0._itemIcon:setMOValue(MaterialEnum.MaterialType.Item, var_19_3, nil, nil, nil, {
		specificIcon = var_19_4
	})

	local var_19_5 = arg_19_0._itemIcon:getRare()
	local var_19_6 = RoomManufactureEnum.RareImageMap[var_19_5]

	UISpriteSetMgr.instance:setCritterSprite(arg_19_0._imgquality, var_19_6)
end

function var_0_0.refreshTime(arg_20_0)
	local var_20_0 = ""
	local var_20_1 = 0
	local var_20_2, var_20_3 = arg_20_0:getBelongBuilding()

	if var_20_3 then
		var_20_1 = var_20_3:getSlotProgress(arg_20_0.slotId)
		var_20_0 = var_20_3:getSlotRemainStrTime(arg_20_0.slotId)
	end

	arg_20_0._imagepausebarValue.fillAmount = var_20_1
	arg_20_0._imagerunningbarValue.fillAmount = var_20_1
	arg_20_0._txtrunningTime.text = var_20_0
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
		local var_22_3 = arg_22_0:getBelongBuilding()

		if var_22_1 and var_22_3 == var_22_1 then
			var_22_0 = true
		end
	end

	gohelper.setActive(arg_22_0._goselected, var_22_0)
end

function var_0_0.checkBtnShow(arg_23_0)
	local var_23_0 = false
	local var_23_1 = false
	local var_23_2, var_23_3 = arg_23_0:getBelongBuilding()
	local var_23_4 = ViewMgr.instance:isOpen(ViewName.RoomManufactureAddPopView)

	if var_23_3 and var_23_4 and arg_23_0._curViewSlotState ~= RoomManufactureEnum.SlotState.Complete then
		local var_23_5 = ManufactureModel.instance:getSelectedSlot()

		if var_23_5 and var_23_2 == var_23_5 then
			local var_23_6 = var_23_3:getSlotManufactureItemId(arg_23_0.slotId)

			if var_23_6 and var_23_6 ~= 0 then
				var_23_0 = true
				var_23_1 = var_23_3:getOccupySlotCount(true) > var_0_1
			end
		end
	end

	gohelper.setActive(arg_23_0._gobtnremove, var_23_0)
	gohelper.setActive(arg_23_0._gobtnmove, var_23_1)
end

function var_0_0.refreshWrong(arg_24_0)
	local var_24_0 = arg_24_0:getBelongBuilding()
	local var_24_1 = RoomManufactureEnum.DefaultPauseIcon
	local var_24_2 = ManufactureModel.instance:getManufactureWrongType(var_24_0, arg_24_0.slotId)

	if var_24_2 then
		local var_24_3 = RoomManufactureEnum.ManufactureWrongDisplay[var_24_2]

		if var_24_3 then
			var_24_1 = var_24_3.icon
		end

		local var_24_4 = var_24_2 == RoomManufactureEnum.ManufactureWrongType.WaitPreMat

		gohelper.setActive(arg_24_0._gowrongwait, var_24_4)
		gohelper.setActive(arg_24_0._gowrongstop, not var_24_4)
	end

	if not string.nilorempty(var_24_1) then
		UISpriteSetMgr.instance:setRoomSprite(arg_24_0._iconwrongstatus, var_24_1)
	end

	gohelper.setActive(arg_24_0._iconwrongstatus, var_24_1)
	gohelper.setActive(arg_24_0._gowrong, var_24_2)
end

function var_0_0.playAddManufactureItemEff(arg_25_0)
	if ViewMgr.instance:isOpen(ViewName.RoomOneKeyView) then
		arg_25_0._playEffWaitCloseView = true
	else
		gohelper.setActive(arg_25_0._goAddEff, false)
		gohelper.setActive(arg_25_0._goAddEff, true)

		arg_25_0._playEffWaitCloseView = false
	end
end

function var_0_0.everySecondCall(arg_26_0)
	if arg_26_0._curViewSlotState == RoomManufactureEnum.SlotState.Running then
		arg_26_0:refreshTime()
	end
end

function var_0_0.reset(arg_27_0)
	arg_27_0.slotId = nil
	arg_27_0.index = nil
	arg_27_0._curViewSlotState = nil
	arg_27_0._isShowDown = nil
	arg_27_0.go.name = var_0_2
	arg_27_0._playEffWaitCloseView = false

	gohelper.setActive(arg_27_0.go, false)
end

function var_0_0.destroy(arg_28_0)
	arg_28_0:removeEventListeners()
	arg_28_0:reset()
	arg_28_0:__onDispose()
end

return var_0_0
