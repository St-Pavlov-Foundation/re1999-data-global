module("modules.logic.room.view.critter.RoomCritterTrainDetailItem", package.seeall)

slot0 = class("RoomCritterTrainDetailItem", ListScrollCellExtend)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	if slot1 then
		slot0._view = slot1
	end
end

function slot0.onInitView(slot0)
	slot0._txttrainlevel = gohelper.findChildText(slot0.viewGO, "TrainProgress/#txt_trainlevel")
	slot0._imagetotalBarValue = gohelper.findChildImage(slot0.viewGO, "TrainProgress/ProgressBg/#image_totalBarValue")
	slot0._goeventpointitem = gohelper.findChild(slot0.viewGO, "TrainProgress/ProgressBg/eventlayout/#go_eventpointitem")
	slot0._goeventtips = gohelper.findChild(slot0.viewGO, "TrainProgress/ProgressBg/eventlayout/#go_eventtips")
	slot0._txteventtime = gohelper.findChildText(slot0.viewGO, "TrainProgress/ProgressBg/eventlayout/#go_eventtips/#txt_eventtime")
	slot0._gotrainTime = gohelper.findChild(slot0.viewGO, "TrainProgress/#go_trainTime")
	slot0._txttotalTrainTime = gohelper.findChildText(slot0.viewGO, "TrainProgress/#go_trainTime/#txt_totalTrainTime")
	slot0._btnaccelerate = gohelper.findChildButtonWithAudio(slot0.viewGO, "TrainProgress/#btn_accelerate")
	slot0._btntrainfinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "TrainProgress/#btn_trainfinish")
	slot0._gotrainslotitem = gohelper.findChild(slot0.viewGO, "#go_trainslotitem")
	slot0._gocrittericon = gohelper.findChild(slot0.viewGO, "#go_trainslotitem/#go_critter_icon")
	slot0._simageheroIcon = gohelper.findChildSingleImage(slot0.viewGO, "#go_trainslotitem/#simage_heroIcon")
	slot0._btncritterchange = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_trainslotitem/#btn_critterchange")
	slot0._goinfo = gohelper.findChild(slot0.viewGO, "#go_info")
	slot0._txttrainingname = gohelper.findChildText(slot0.viewGO, "#go_info/#txt_trainingname")
	slot0._scrollbase = gohelper.findChildScrollRect(slot0.viewGO, "#go_info/#scroll_base")
	slot0._gobaseitem = gohelper.findChild(slot0.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem/#image_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem/#txt_name")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem/go_ratelevel/#txt_level")
	slot0._simagelevelBarValue = gohelper.findChildSingleImage(slot0.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem/go_ratelevel/ProgressBg/#simage_levelBarValue")
	slot0._simagetotalBarValue = gohelper.findChildSingleImage(slot0.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem/go_detail/ProgressBg/#simage_totalBarValue")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem/go_detail/#txt_num")
	slot0._btnswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_info/#btn_switch")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_detail")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnaccelerate:AddClickListener(slot0._btnaccelerateOnClick, slot0)
	slot0._btntrainfinish:AddClickListener(slot0._btntrainfinishOnClick, slot0)
	slot0._btncritterchange:AddClickListener(slot0._btncritterchangeOnClick, slot0)
	slot0._btnswitch:AddClickListener(slot0._btnswitchOnClick, slot0)
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnaccelerate:RemoveClickListener()
	slot0._btntrainfinish:RemoveClickListener()
	slot0._btncritterchange:RemoveClickListener()
	slot0._btnswitch:RemoveClickListener()
	slot0._btndetail:RemoveClickListener()
end

function slot0._btnswitchOnClick(slot0)
	slot0._showLv = not slot0._showLv

	slot0:refreshAttributeItem()
end

function slot0._btnaccelerateOnClick(slot0)
	if slot0._critterMO then
		RoomCritterController.instance:openTrainAccelerateView(slot1.uid)
	end
end

function slot0._btntrainfinishOnClick(slot0)
	if slot0._critterMO and slot1.trainInfo then
		if slot1.trainInfo:isFinishAllEvent() then
			RoomCritterController.instance:sendFinishTrainCritter(slot1.id)
		else
			GameFacade.showToast(ToastEnum.RoomCritterTrainEventNotFinished)
			RoomCritterController.instance:openTrainEventView(slot1.id)
		end
	end

	if slot0._finishCallback then
		if slot0._finishCallbackObj ~= nil then
			slot0._finishCallback(slot0._finishCallbackObj)
		else
			slot0._finishCallback()
		end
	end
end

function slot0._btncritterchangeOnClick(slot0)
	if slot0._critterchangeCallback then
		if slot0._critterchangeCallbackObj ~= nil then
			slot0._critterchangeCallback(slot0._critterchangeCallbackObj)
		else
			slot0._critterchangeCallback()
		end
	end
end

function slot0._btndetailOnClick(slot0)
	CritterController.instance:openRoomCritterDetailView(slot0._critterMO.finishTrain ~= true, slot0._critterMO, true)
end

function slot0._editableInitView(slot0)
	slot0._showStateInfo = true

	gohelper.setActive(slot0._gobaseitem, false)
	gohelper.setActive(slot0._goeventtips, false)
	gohelper.setActive(slot0._btncritterchange, false)

	slot0._gogrssBg = gohelper.findChild(slot0.viewGO, "TrainProgress/bg")
	slot0._gogressFinishBg = gohelper.findChild(slot0.viewGO, "TrainProgress/#go_finishbg")
	slot0._imageTrainBarValue = gohelper.findChildImage(slot0.viewGO, "TrainProgress/ProgressBg/#simage_totalBarValue")
	slot0._eventPointTbList = slot0:getUserDataTb_()
	slot0._attributeItems = {}
	slot0._showLv = false
	slot0._barTrs = slot0._imagetotalBarValue.transform
	slot0._goeventtipsTrs = slot0._goeventtips.transform

	table.insert(slot0._eventPointTbList, slot0:_createEventPointTB(slot0._goeventpointitem))
	slot0:setBarValue(0)
end

function slot0._editableAddEvents(slot0)
	RoomController.instance:registerCallback(RoomEvent.CritterTrainLevelFinished, slot0._onTrainResultFinished, slot0)
end

function slot0._editableRemoveEvents(slot0)
	RoomController.instance:unregisterCallback(RoomEvent.CritterTrainLevelFinished, slot0._onTrainResultFinished, slot0)
end

function slot0._onTrainResultFinished(slot0)
	slot0._showLv = true

	slot0:refreshAttributeItem()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._critterMO = slot1
	slot0._critterId = slot1 and slot1.id

	slot0:refreshUI()
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	if slot0._attributeItems then
		for slot4, slot5 in pairs(slot0._attributeItems) do
			slot5:destroy()
		end

		slot0._attributeItems = nil
	end

	if slot0._eventPointTbList then
		slot0._eventPointTbList = nil

		for slot5, slot6 in ipairs(slot0._eventPointTbList) do
			slot0:_disposeEventPointBT(slot6)
		end
	end
end

function slot0.setFinishCallback(slot0, slot1, slot2)
	slot0._finishCallback = slot1
	slot0._finishCallbackObj = slot2
end

function slot0.setCritterChanageCallback(slot0, slot1, slot2)
	slot0._critterchangeCallback = slot1
	slot0._critterchangeCallbackObj = slot2

	if slot1 then
		gohelper.setActive(slot0._btncritterchange, true)
	else
		gohelper.setActive(slot0._btncritterchange, false)
	end
end

function slot0.tranCdTimeUpdate(slot0)
	slot0:refreshTrainProgressUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshTrainProgressUI()
	slot0:refreshSlotUI()
	slot0:refreshAttributeItem()
end

function slot0.setShowStateInfo(slot0, slot1)
	slot0._showStateInfo = slot1 and true or false

	slot0:refreshTrainProgressUI()
end

function slot0.refreshTrainProgressUI(slot0)
	if slot0._critterMO and slot1.trainInfo then
		slot3 = slot1.trainInfo:isTrainFinish()

		gohelper.setActive(slot0._btntrainfinish, slot0._showStateInfo and slot3)
		gohelper.setActive(slot0._gogressFinishBg, slot0._showStateInfo and slot3)
		gohelper.setActive(slot0._gogrssBg, not slot0._showStateInfo or not slot3)
		gohelper.setActive(slot0._gotrainTime, slot0._showStateInfo and not slot3)
		gohelper.setActive(slot0._btnaccelerate, slot0._showStateInfo and not slot3)
		slot0:setBarValue(slot2:getProcess())

		slot0._txttotalTrainTime.text = TimeUtil.second2TimeString(slot2:getCurCdTime(), true)

		slot0:refreshEventPointUI()
	end

	slot0:_refreshTipsUI()
end

function slot0.setBarValue(slot0, slot1)
	slot0._barValue = slot1
	slot0._imagetotalBarValue.fillAmount = slot1
end

function slot0.getBarValue(slot0, slot1)
	return slot0._barValue
end

function slot0._refreshTipsUI(slot0)
	if slot0._lookTrainInfoMO then
		if slot0._lookEventTime - slot0._lookTrainInfoMO:getProcessTime() < 0 or slot0._critterId ~= slot0._lookCritterId then
			gohelper.setActive(slot0._goeventtips, false)

			slot0._lookTrainInfoMO = nil
			slot0._lookCritterId = nil
		else
			slot0._txteventtime.text = TimeUtil.second2TimeString(slot1, true)
		end
	end
end

function slot0.refreshSlotUI(slot0)
	if slot0._critterMO then
		if not slot0.critterIcon then
			slot0.critterIcon = IconMgr.instance:getCommonCritterIcon(slot0._gocrittericon)
		end

		slot0.critterIcon:setMOValue(slot1:getId(), slot1:getDefineId())

		if HeroModel.instance:getByHeroId(slot1.trainInfo.heroId) and SkinConfig.instance:getSkinCo(slot2.skin) then
			slot0._simageheroIcon:LoadImage(ResUrl.getRoomHeadIcon(slot3.headIcon))
		end

		slot0._txttrainingname.text = slot1:getName()
	end
end

function slot0.refreshEventPointUI(slot0)
	if not slot0._eventPointTbList then
		return
	end

	slot1 = 0

	if slot0._critterMO and slot2.trainInfo then
		slot4 = slot2:getTainTime()
		slot5 = recthelper.getWidth(slot0._barTrs)

		for slot9 = 1, #slot2.trainInfo.eventTimePoints do
			slot10 = slot3[slot9]

			if not slot0._eventPointTbList[slot1 + 1] then
				table.insert(slot0._eventPointTbList, slot0:_createEventPointTB(gohelper.cloneInPlace(slot0._goeventpointitem)))
			end

			slot11.roundIndex = slot1

			slot0:_updateEventPointTB(slot11, slot5 * slot10 / slot4, slot10, slot2.trainInfo, slot2.id)
		end
	end

	for slot6, slot7 in ipairs(slot0._eventPointTbList) do
		gohelper.setActive(slot7.go, slot6 <= slot1)
	end
end

function slot0.refreshAttributeItem(slot0)
	if slot0._critterMO then
		for slot5, slot6 in pairs(slot0._attributeItems) do
			slot6:hideItem()
		end

		for slot6 = 1, #slot1:getAttributeInfos() do
			if not slot0._attributeItems[slot6] then
				slot0._attributeItems[slot6] = RoomCritterTrainDetailItemAttributeItem.New()

				slot0._attributeItems[slot6]:init(slot0._gobaseitem)
			end

			slot0._attributeItems[slot6]:setShowLv(slot0._showLv)
			slot0._attributeItems[slot6]:refresh(slot2[slot6], slot1)
		end
	end
end

function slot0.playLevelUp(slot0, slot1, slot2)
	if slot0._critterMO then
		for slot7, slot8 in ipairs(slot0._attributeItems) do
			slot9 = false

			for slot13 = 1, #slot1 do
				if slot8:getAttributeId() == slot1[slot13].attributeId then
					slot9 = true

					slot8:playLevelUp(slot1[slot13], slot2)
				end
			end

			if not slot9 then
				slot8:playNoLevelUp()
			end
		end
	end
end

function slot0.playBarAdd(slot0, slot1, slot2)
	if slot0._critterMO then
		for slot7, slot8 in ipairs(slot0._attributeItems) do
			if slot1 then
				for slot12 = 1, #slot2 do
					if slot8:getAttributeId() == slot2[slot12].addAttriButes[1].attributeId then
						slot8:playBarAdd(slot1, slot2[slot12].addAttriButes[1])
					end
				end
			else
				slot8:playBarAdd(slot1)
			end
		end
	end
end

function slot0._updateEventPointTB(slot0, slot1, slot2, slot3, slot4, slot5)
	slot1.trainInfoMO = slot4
	slot1.critterId = slot5
	slot1.eventTime = slot3
	slot7 = slot4:checkRoundFinish(slot1.roundIndex, CritterEnum.EventType.ActiveTime)

	if slot1.isLastActivie ~= (slot3 < slot4:getProcessTime()) or slot1.isLastFinish ~= slot7 then
		slot1.isLastActivie = slot6
		slot1.isLastFinish = slot7

		gohelper.setActive(slot1._gounactive, not slot6)
		gohelper.setActive(slot1._gounfinish, slot6 and not slot7)
		gohelper.setActive(slot1._gofinish, slot6 and slot7)
	end

	if slot1.anchorX ~= slot2 then
		slot1.anchorX = slot2

		recthelper.setAnchorX(slot1.goTrs, slot2)
	end
end

function slot0._tbunactiveOnClick(slot0, slot1)
	if slot0._lookCritterId == slot1.critterId and slot0._lookEventTime == slot1.eventTime then
		slot0._lookTrainInfoMO = nil
		slot0._lookCritterId = nil

		gohelper.setActive(slot0._goeventtips, false)

		return
	end

	slot0._lookTrainInfoMO = slot1.trainInfoMO
	slot0._lookCritterId = slot1.critterId
	slot0._lookEventTime = slot1.eventTime

	recthelper.setAnchorX(slot0._goeventtipsTrs, slot1.anchorX)
	gohelper.setActive(slot0._goeventtips, not slot1.isLastActivie)
	slot0:_refreshTipsUI()
end

function slot0._createEventPointTB(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2.goTrs = slot1.transform
	slot2._gounfinish = gohelper.findChild(slot1, "unfinish")
	slot2._gofinish = gohelper.findChild(slot1, "finished")
	slot2._gounactive = gohelper.findChild(slot1, "unactive")
	slot2._btnunactive = gohelper.findChildButtonWithAudio(slot1, "unactive")

	slot2._btnunactive:AddClickListener(slot0._tbunactiveOnClick, slot0, slot2)

	return slot2
end

function slot0._disposeEventPointBT(slot0, slot1)
	if slot1 then
		slot1.go = nil
		slot1.goTrs = nil
		slot1._gounfinsh = nil
		slot1._gofinish = nil

		if slot1._btnunactive then
			slot1._btnunactive:RemoveClickListener()
		end

		slot1._btnunactive = nil
	end
end

function slot0.getUserDataTb_(slot0)
	if slot0._view then
		return slot0._view:getUserDataTb_()
	end

	return {}
end

slot0.prefabPath = "ui/viewres/room/critter/roomcrittertraindetailitem.prefab"

return slot0
