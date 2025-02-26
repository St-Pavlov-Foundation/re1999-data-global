module("modules.logic.room.view.RoomInventorySelectEffect", package.seeall)

slot0 = class("RoomInventorySelectEffect", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._goreclaim = gohelper.findChild(slot0.viewGO, "go_content/go_count/#reclaim")
	slot0._gomassif = gohelper.findChild(slot0.viewGO, "go_content/go_count/#reclaim/reclaim_massif/#massif")
	slot0._goreclaimtips = gohelper.findChild(slot0.viewGO, "go_content/#go_reclaimtips")
	slot0._gomassiftips = gohelper.findChild(slot0.viewGO, "go_content/#go_reclaimtips/#massiftips")

	gohelper.setActive(slot0._gomassif, false)
	gohelper.setActive(slot0._gomassiftips, false)
	gohelper.setActive(slot0._goreclaimtips, true)

	slot0._isViewShow = false
	slot0._isViewShowing = false
	slot0._nextPlayTipsTime = 0
	slot0._isFlag = false
	slot0._massifEffList = {}
	slot0._massifTipEffList = {}
	slot0._reclaimEffTab = slot0:_getUserDataTbEffect(slot0._goreclaim)
	slot0._backBlockIds = {}
	slot0._tipsInfoList = {}
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.BackBlockListDataChanged, slot0._onBackBlockChanged, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.BackBlockPlayUIAnim, slot0._onBackBlockPlayUIAnim, slot0)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._delayPlayTipsEffect, slot0)

	if slot0._reclaimEffTab then
		slot0._reclaimEffTab:dispose()
	end

	slot0._reclaimEffTab = nil

	for slot4 = 1, #slot0._massifEffList do
		slot0._massifEffList[slot4]:dispose()
	end

	slot0._massifEffList = {}

	for slot4 = 1, #slot0._massifTipEffList do
		slot0._massifTipEffList[slot4]:dispose()
	end

	slot0._massifTipEffList = {}
end

function slot0._onBackBlockChanged(slot0, slot1, slot2, slot3)
	tabletool.addValues(slot0._backBlockIds, slot1)

	for slot7 = 1, #slot1 do
		if RoomConfig.instance:getBlock(slot1[slot7]) then
			slot0:_addPackageId(slot8.packageId)
		end
	end

	if slot3 and #slot3 > 0 then
		for slot7 = 1, #slot3 do
			slot0:_addBuildingId(slot3[slot7])
		end
	end

	slot0:_playEffect()
end

function slot0._onBackBlockPlayUIAnim(slot0)
	slot0:_playEffect()
end

function slot0._getIsShow(slot0)
	if RoomMapBlockModel.instance:isBackMore() or RoomBuildingController.instance:isBuildingListShow() then
		return false
	end

	return true
end

function slot0._playEffect(slot0)
	slot0:_playMassifEffect()
	slot0:_playTipsEffect()
end

function slot0._addPackageId(slot0, slot1)
	if slot0:_getTipsInfo(slot1, true) then
		slot3.count = slot3.count + 1
	elseif RoomConfig.instance:getBlockPackageConfig(slot1) then
		table.insert(slot0._tipsInfoList, {
			count = 1,
			id = slot1,
			isBlock = slot2,
			name = slot4.name,
			rare = slot4.rare
		})
	end
end

function slot0._addBuildingId(slot0, slot1)
	if slot0:_getTipsInfo(slot1, false) then
		slot3.count = slot3.count + 1
	elseif RoomConfig.instance:getBuildingConfig(slot1) then
		table.insert(slot0._tipsInfoList, {
			count = 1,
			id = slot1,
			isBlock = slot2,
			name = slot4.name,
			rare = slot4.rare
		})
	end
end

function slot0._getTipsInfo(slot0, slot1, slot2)
	for slot7 = 1, #slot0._tipsInfoList do
		if slot3[slot7].id == slot1 and slot8.isBlock == slot2 then
			return slot8
		end
	end
end

function slot0._getUserDataTbEffect(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2.effectTime = 2
	slot2.isRunning = false

	function slot2.playEffect(slot0, slot1)
		slot0.isRunning = true

		TaskDispatcher.cancelTask(slot0._playEffect, slot0)
		TaskDispatcher.runDelay(slot0._playEffect, slot0, slot1 or 0)
	end

	function slot2._playEffect(slot0)
		gohelper.setActive(slot0.go, false)
		gohelper.setActive(slot0.go, true)
		TaskDispatcher.cancelTask(slot0._stopEffect, slot0)
		TaskDispatcher.runDelay(slot0._stopEffect, slot0, slot0.effectTime or 1.5)
	end

	function slot2._stopEffect(slot0)
		slot0.isRunning = false

		gohelper.setActive(slot0.go, false)
	end

	function slot2._clearTask(slot0)
		TaskDispatcher.cancelTask(slot0._playEffect, slot0)
		TaskDispatcher.cancelTask(slot0._stopEffect, slot0)
	end

	function slot2.dispose(slot0)
		slot0:_clearTask()
		slot0:_stopEffect()
	end

	return slot2
end

function slot0._playMassifEffect(slot0)
	if not slot0:_getIsShow() then
		return
	end

	slot0._backBlockIds = {}

	if math.min(5, #slot0._backBlockIds) > 0 then
		slot0._reclaimEffTab.effectTime = 3

		slot0._reclaimEffTab:playEffect()
	end

	for slot6 = 1, slot2 do
		if not slot0._massifEffList[slot6] then
			table.insert(slot0._massifEffList, slot0:_getUserDataTbEffect(gohelper.cloneInPlace(slot0._gomassif, "massif" .. slot6)))
		end

		slot7:playEffect(slot6 * 0.06)
	end
end

function slot0._delayPlayTipsEffect(slot0)
	if #slot0._tipsInfoList > 0 then
		slot0:_playTipsEffect()
	end
end

function slot0._playTipsEffect(slot0)
	if not slot0:_getIsShow() then
		return
	end

	slot1 = Time.time
	slot2 = slot0._tipsInfoList
	slot3 = 1
	slot4 = RoomInventoryBlockModel.instance:getCurPackageMO()

	for slot8 = 1, 5 do
		if not slot0._massifTipEffList[slot8] then
			slot10 = gohelper.cloneInPlace(slot0._gomassiftips, "gomassiftips" .. slot8)
			slot9 = slot0:_getUserDataTbEffect(slot10)
			slot9._imagerare = gohelper.findChildImage(slot10, "bg/rare")
			slot9._txtname = gohelper.findChildText(slot10, "bg/txt_name")
			slot9._txtnum = gohelper.findChildText(slot10, "bg/txt_num")
			slot9._goicon = gohelper.findChild(slot10, "bg/txt_num/icon")
			slot9._gobuildingicon = gohelper.findChild(slot10, "bg/txt_num/building_icon")
			slot9.finishTime = 0
			slot9.effectTime = 3.7

			table.insert(slot0._massifTipEffList, slot9)
		end

		if slot1 < slot9.finishTime then
			slot3 = math.min(slot3, slot9.finishTime - slot1)
		elseif #slot2 > 0 then
			slot10 = slot2[1]

			table.remove(slot2, 1)

			slot11 = slot4 and slot10.isBlock and slot4.id == slot10.id
			slot12 = slot11 and "#FFFFFF" or "#FFFFFF"
			slot9._txtname.text = slot11 and luaLang("room_backblock_curpackage") or slot10.name
			slot9._txtnum.text = "+" .. slot10.count
			slot9.finishTime = slot1 + slot9.effectTime

			if slot9.isBlock ~= slot10.isBlock then
				slot9.isBlock = slot10.isBlock

				gohelper.setActive(slot9._goicon, slot10.isBlock)
				gohelper.setActive(slot9._gobuildingicon, not slot10.isBlock)
			end

			if slot9.txtColorStr ~= slot12 then
				slot9.txtColorStr = slot12

				SLFramework.UGUI.GuiHelper.SetColor(slot9._txtnum, slot12)
				SLFramework.UGUI.GuiHelper.SetColor(slot9._txtname, slot12)
			end

			UISpriteSetMgr.instance:setRoomSprite(slot9._imagerare, RoomBlockPackageEnum.RareIcon[slot10.rare] or RoomBlockPackageEnum.RareIcon[1])
			slot9:playEffect()
			gohelper.setAsLastSibling(slot9.go)
		end

		if #slot2 < 1 then
			break
		end
	end

	if #slot2 > 0 then
		TaskDispatcher.runDelay(slot0._delayPlayTipsEffect, slot0, slot3)
	end
end

return slot0
