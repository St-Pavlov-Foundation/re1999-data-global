module("modules.logic.room.view.critter.RoomCritterTrainDetailItem", package.seeall)

local var_0_0 = class("RoomCritterTrainDetailItem", ListScrollCellExtend)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	if arg_1_1 then
		arg_1_0._view = arg_1_1
	end
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._txttrainlevel = gohelper.findChildText(arg_2_0.viewGO, "TrainProgress/#txt_trainlevel")
	arg_2_0._imagetotalBarValue = gohelper.findChildImage(arg_2_0.viewGO, "TrainProgress/ProgressBg/#image_totalBarValue")
	arg_2_0._goeventpointitem = gohelper.findChild(arg_2_0.viewGO, "TrainProgress/ProgressBg/eventlayout/#go_eventpointitem")
	arg_2_0._goeventtips = gohelper.findChild(arg_2_0.viewGO, "TrainProgress/ProgressBg/eventlayout/#go_eventtips")
	arg_2_0._txteventtime = gohelper.findChildText(arg_2_0.viewGO, "TrainProgress/ProgressBg/eventlayout/#go_eventtips/#txt_eventtime")
	arg_2_0._gotrainTime = gohelper.findChild(arg_2_0.viewGO, "TrainProgress/#go_trainTime")
	arg_2_0._txttotalTrainTime = gohelper.findChildText(arg_2_0.viewGO, "TrainProgress/#go_trainTime/#txt_totalTrainTime")
	arg_2_0._btnaccelerate = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "TrainProgress/#btn_accelerate")
	arg_2_0._btntrainfinish = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "TrainProgress/#btn_trainfinish")
	arg_2_0._gotrainslotitem = gohelper.findChild(arg_2_0.viewGO, "#go_trainslotitem")
	arg_2_0._gocrittericon = gohelper.findChild(arg_2_0.viewGO, "#go_trainslotitem/#go_critter_icon")
	arg_2_0._simageheroIcon = gohelper.findChildSingleImage(arg_2_0.viewGO, "#go_trainslotitem/#simage_heroIcon")
	arg_2_0._btncritterchange = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#go_trainslotitem/#btn_critterchange")
	arg_2_0._goinfo = gohelper.findChild(arg_2_0.viewGO, "#go_info")
	arg_2_0._txttrainingname = gohelper.findChildText(arg_2_0.viewGO, "#go_info/#txt_trainingname")
	arg_2_0._scrollbase = gohelper.findChildScrollRect(arg_2_0.viewGO, "#go_info/#scroll_base")
	arg_2_0._gobaseitem = gohelper.findChild(arg_2_0.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem")
	arg_2_0._imageicon = gohelper.findChildImage(arg_2_0.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem/#image_icon")
	arg_2_0._txtname = gohelper.findChildText(arg_2_0.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem/#txt_name")
	arg_2_0._txtlevel = gohelper.findChildText(arg_2_0.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem/go_ratelevel/#txt_level")
	arg_2_0._simagelevelBarValue = gohelper.findChildSingleImage(arg_2_0.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem/go_ratelevel/ProgressBg/#simage_levelBarValue")
	arg_2_0._simagetotalBarValue = gohelper.findChildSingleImage(arg_2_0.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem/go_detail/ProgressBg/#simage_totalBarValue")
	arg_2_0._txtnum = gohelper.findChildText(arg_2_0.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem/go_detail/#txt_num")
	arg_2_0._btnswitch = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#go_info/#btn_switch")
	arg_2_0._btndetail = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#btn_detail")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnaccelerate:AddClickListener(arg_3_0._btnaccelerateOnClick, arg_3_0)
	arg_3_0._btntrainfinish:AddClickListener(arg_3_0._btntrainfinishOnClick, arg_3_0)
	arg_3_0._btncritterchange:AddClickListener(arg_3_0._btncritterchangeOnClick, arg_3_0)
	arg_3_0._btnswitch:AddClickListener(arg_3_0._btnswitchOnClick, arg_3_0)
	arg_3_0._btndetail:AddClickListener(arg_3_0._btndetailOnClick, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnaccelerate:RemoveClickListener()
	arg_4_0._btntrainfinish:RemoveClickListener()
	arg_4_0._btncritterchange:RemoveClickListener()
	arg_4_0._btnswitch:RemoveClickListener()
	arg_4_0._btndetail:RemoveClickListener()
end

function var_0_0._btnswitchOnClick(arg_5_0)
	arg_5_0._showLv = not arg_5_0._showLv

	arg_5_0:refreshAttributeItem()
end

function var_0_0._btnaccelerateOnClick(arg_6_0)
	local var_6_0 = arg_6_0._critterMO

	if var_6_0 then
		RoomCritterController.instance:openTrainAccelerateView(var_6_0.uid)
	end
end

function var_0_0._btntrainfinishOnClick(arg_7_0)
	local var_7_0 = arg_7_0._critterMO

	if var_7_0 and var_7_0.trainInfo then
		if var_7_0.trainInfo:isFinishAllEvent() then
			RoomCritterController.instance:sendFinishTrainCritter(var_7_0.id)
		else
			GameFacade.showToast(ToastEnum.RoomCritterTrainEventNotFinished)
			RoomCritterController.instance:openTrainEventView(var_7_0.id)
		end
	end

	if arg_7_0._finishCallback then
		if arg_7_0._finishCallbackObj ~= nil then
			arg_7_0._finishCallback(arg_7_0._finishCallbackObj)
		else
			arg_7_0._finishCallback()
		end
	end
end

function var_0_0._btncritterchangeOnClick(arg_8_0)
	if arg_8_0._critterchangeCallback then
		if arg_8_0._critterchangeCallbackObj ~= nil then
			arg_8_0._critterchangeCallback(arg_8_0._critterchangeCallbackObj)
		else
			arg_8_0._critterchangeCallback()
		end
	end
end

function var_0_0._btndetailOnClick(arg_9_0)
	CritterController.instance:openRoomCritterDetailView(arg_9_0._critterMO.finishTrain ~= true, arg_9_0._critterMO, true)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._showStateInfo = true

	gohelper.setActive(arg_10_0._gobaseitem, false)
	gohelper.setActive(arg_10_0._goeventtips, false)
	gohelper.setActive(arg_10_0._btncritterchange, false)

	arg_10_0._gogrssBg = gohelper.findChild(arg_10_0.viewGO, "TrainProgress/bg")
	arg_10_0._gogressFinishBg = gohelper.findChild(arg_10_0.viewGO, "TrainProgress/#go_finishbg")
	arg_10_0._imageTrainBarValue = gohelper.findChildImage(arg_10_0.viewGO, "TrainProgress/ProgressBg/#simage_totalBarValue")
	arg_10_0._eventPointTbList = arg_10_0:getUserDataTb_()
	arg_10_0._attributeItems = {}
	arg_10_0._showLv = false
	arg_10_0._barTrs = arg_10_0._imagetotalBarValue.transform
	arg_10_0._goeventtipsTrs = arg_10_0._goeventtips.transform

	table.insert(arg_10_0._eventPointTbList, arg_10_0:_createEventPointTB(arg_10_0._goeventpointitem))
	arg_10_0:setBarValue(0)
end

function var_0_0._editableAddEvents(arg_11_0)
	RoomController.instance:registerCallback(RoomEvent.CritterTrainLevelFinished, arg_11_0._onTrainResultFinished, arg_11_0)
end

function var_0_0._editableRemoveEvents(arg_12_0)
	RoomController.instance:unregisterCallback(RoomEvent.CritterTrainLevelFinished, arg_12_0._onTrainResultFinished, arg_12_0)
end

function var_0_0._onTrainResultFinished(arg_13_0)
	arg_13_0._showLv = true

	arg_13_0:refreshAttributeItem()
end

function var_0_0.onUpdateMO(arg_14_0, arg_14_1)
	arg_14_0._critterMO = arg_14_1
	arg_14_0._critterId = arg_14_1 and arg_14_1.id

	arg_14_0:refreshUI()
end

function var_0_0.onSelect(arg_15_0, arg_15_1)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	if arg_16_0._attributeItems then
		for iter_16_0, iter_16_1 in pairs(arg_16_0._attributeItems) do
			iter_16_1:destroy()
		end

		arg_16_0._attributeItems = nil
	end

	if arg_16_0._eventPointTbList then
		local var_16_0 = arg_16_0._eventPointTbList

		arg_16_0._eventPointTbList = nil

		for iter_16_2, iter_16_3 in ipairs(var_16_0) do
			arg_16_0:_disposeEventPointBT(iter_16_3)
		end
	end
end

function var_0_0.setFinishCallback(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._finishCallback = arg_17_1
	arg_17_0._finishCallbackObj = arg_17_2
end

function var_0_0.setCritterChanageCallback(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._critterchangeCallback = arg_18_1
	arg_18_0._critterchangeCallbackObj = arg_18_2

	if arg_18_1 then
		gohelper.setActive(arg_18_0._btncritterchange, true)
	else
		gohelper.setActive(arg_18_0._btncritterchange, false)
	end
end

function var_0_0.tranCdTimeUpdate(arg_19_0)
	arg_19_0:refreshTrainProgressUI()
end

function var_0_0.refreshUI(arg_20_0)
	arg_20_0:refreshTrainProgressUI()
	arg_20_0:refreshSlotUI()
	arg_20_0:refreshAttributeItem()
end

function var_0_0.setShowStateInfo(arg_21_0, arg_21_1)
	arg_21_0._showStateInfo = arg_21_1 and true or false

	arg_21_0:refreshTrainProgressUI()
end

function var_0_0.refreshTrainProgressUI(arg_22_0)
	local var_22_0 = arg_22_0._critterMO

	if var_22_0 and var_22_0.trainInfo then
		local var_22_1 = var_22_0.trainInfo
		local var_22_2 = var_22_1:isTrainFinish()

		gohelper.setActive(arg_22_0._btntrainfinish, arg_22_0._showStateInfo and var_22_2)
		gohelper.setActive(arg_22_0._gogressFinishBg, arg_22_0._showStateInfo and var_22_2)
		gohelper.setActive(arg_22_0._gogrssBg, not arg_22_0._showStateInfo or not var_22_2)
		gohelper.setActive(arg_22_0._gotrainTime, arg_22_0._showStateInfo and not var_22_2)
		gohelper.setActive(arg_22_0._btnaccelerate, arg_22_0._showStateInfo and not var_22_2)
		arg_22_0:setBarValue(var_22_1:getProcess())

		arg_22_0._txttotalTrainTime.text = TimeUtil.second2TimeString(var_22_1:getCurCdTime(), true)

		arg_22_0:refreshEventPointUI()
	end

	arg_22_0:_refreshTipsUI()
end

function var_0_0.setBarValue(arg_23_0, arg_23_1)
	arg_23_0._barValue = arg_23_1
	arg_23_0._imagetotalBarValue.fillAmount = arg_23_1
end

function var_0_0.getBarValue(arg_24_0, arg_24_1)
	return arg_24_0._barValue
end

function var_0_0._refreshTipsUI(arg_25_0)
	if arg_25_0._lookTrainInfoMO then
		local var_25_0 = arg_25_0._lookEventTime - arg_25_0._lookTrainInfoMO:getProcessTime()

		if var_25_0 < 0 or arg_25_0._critterId ~= arg_25_0._lookCritterId then
			gohelper.setActive(arg_25_0._goeventtips, false)

			arg_25_0._lookTrainInfoMO = nil
			arg_25_0._lookCritterId = nil
		else
			arg_25_0._txteventtime.text = TimeUtil.second2TimeString(var_25_0, true)
		end
	end
end

function var_0_0.refreshSlotUI(arg_26_0)
	local var_26_0 = arg_26_0._critterMO

	if var_26_0 then
		if not arg_26_0.critterIcon then
			arg_26_0.critterIcon = IconMgr.instance:getCommonCritterIcon(arg_26_0._gocrittericon)
		end

		arg_26_0.critterIcon:setMOValue(var_26_0:getId(), var_26_0:getDefineId())

		local var_26_1 = HeroModel.instance:getByHeroId(var_26_0.trainInfo.heroId)
		local var_26_2 = var_26_1 and SkinConfig.instance:getSkinCo(var_26_1.skin)

		if var_26_2 then
			arg_26_0._simageheroIcon:LoadImage(ResUrl.getRoomHeadIcon(var_26_2.headIcon))
		end

		arg_26_0._txttrainingname.text = var_26_0:getName()
	end
end

function var_0_0.refreshEventPointUI(arg_27_0)
	if not arg_27_0._eventPointTbList then
		return
	end

	local var_27_0 = 0
	local var_27_1 = arg_27_0._critterMO

	if var_27_1 and var_27_1.trainInfo then
		local var_27_2 = var_27_1.trainInfo.eventTimePoints
		local var_27_3 = var_27_1:getTainTime()
		local var_27_4 = recthelper.getWidth(arg_27_0._barTrs)

		for iter_27_0 = 1, #var_27_2 do
			local var_27_5 = var_27_2[iter_27_0]

			var_27_0 = var_27_0 + 1

			local var_27_6 = arg_27_0._eventPointTbList[var_27_0]

			if not var_27_6 then
				local var_27_7 = gohelper.cloneInPlace(arg_27_0._goeventpointitem)

				var_27_6 = arg_27_0:_createEventPointTB(var_27_7)

				table.insert(arg_27_0._eventPointTbList, var_27_6)
			end

			var_27_6.roundIndex = var_27_0

			local var_27_8 = var_27_4 * var_27_5 / var_27_3

			arg_27_0:_updateEventPointTB(var_27_6, var_27_8, var_27_5, var_27_1.trainInfo, var_27_1.id)
		end
	end

	for iter_27_1, iter_27_2 in ipairs(arg_27_0._eventPointTbList) do
		gohelper.setActive(iter_27_2.go, iter_27_1 <= var_27_0)
	end
end

function var_0_0.refreshAttributeItem(arg_28_0)
	local var_28_0 = arg_28_0._critterMO

	if var_28_0 then
		for iter_28_0, iter_28_1 in pairs(arg_28_0._attributeItems) do
			iter_28_1:hideItem()
		end

		local var_28_1 = var_28_0:getAttributeInfos()

		for iter_28_2 = 1, #var_28_1 do
			if not arg_28_0._attributeItems[iter_28_2] then
				arg_28_0._attributeItems[iter_28_2] = RoomCritterTrainDetailItemAttributeItem.New()

				arg_28_0._attributeItems[iter_28_2]:init(arg_28_0._gobaseitem)
			end

			arg_28_0._attributeItems[iter_28_2]:setShowLv(arg_28_0._showLv)
			arg_28_0._attributeItems[iter_28_2]:refresh(var_28_1[iter_28_2], var_28_0)
		end
	end
end

function var_0_0.playLevelUp(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_0._critterMO then
		for iter_29_0, iter_29_1 in ipairs(arg_29_0._attributeItems) do
			local var_29_0 = false

			for iter_29_2 = 1, #arg_29_1 do
				if iter_29_1:getAttributeId() == arg_29_1[iter_29_2].attributeId then
					var_29_0 = true

					iter_29_1:playLevelUp(arg_29_1[iter_29_2], arg_29_2)
				end
			end

			if not var_29_0 then
				iter_29_1:playNoLevelUp()
			end
		end
	end
end

function var_0_0.playBarAdd(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_0._critterMO then
		for iter_30_0, iter_30_1 in ipairs(arg_30_0._attributeItems) do
			if arg_30_1 then
				for iter_30_2 = 1, #arg_30_2 do
					if iter_30_1:getAttributeId() == arg_30_2[iter_30_2].addAttriButes[1].attributeId then
						iter_30_1:playBarAdd(arg_30_1, arg_30_2[iter_30_2].addAttriButes[1])
					end
				end
			else
				iter_30_1:playBarAdd(arg_30_1)
			end
		end
	end
end

function var_0_0._updateEventPointTB(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5)
	arg_31_1.trainInfoMO = arg_31_4
	arg_31_1.critterId = arg_31_5
	arg_31_1.eventTime = arg_31_3

	local var_31_0 = arg_31_3 < arg_31_4:getProcessTime()
	local var_31_1 = arg_31_4:checkRoundFinish(arg_31_1.roundIndex, CritterEnum.EventType.ActiveTime)

	if arg_31_1.isLastActivie ~= var_31_0 or arg_31_1.isLastFinish ~= var_31_1 then
		arg_31_1.isLastActivie = var_31_0
		arg_31_1.isLastFinish = var_31_1

		gohelper.setActive(arg_31_1._gounactive, not var_31_0)
		gohelper.setActive(arg_31_1._gounfinish, var_31_0 and not var_31_1)
		gohelper.setActive(arg_31_1._gofinish, var_31_0 and var_31_1)
	end

	if arg_31_1.anchorX ~= arg_31_2 then
		arg_31_1.anchorX = arg_31_2

		recthelper.setAnchorX(arg_31_1.goTrs, arg_31_2)
	end
end

function var_0_0._tbunactiveOnClick(arg_32_0, arg_32_1)
	if arg_32_0._lookCritterId == arg_32_1.critterId and arg_32_0._lookEventTime == arg_32_1.eventTime then
		arg_32_0._lookTrainInfoMO = nil
		arg_32_0._lookCritterId = nil

		gohelper.setActive(arg_32_0._goeventtips, false)

		return
	end

	arg_32_0._lookTrainInfoMO = arg_32_1.trainInfoMO
	arg_32_0._lookCritterId = arg_32_1.critterId
	arg_32_0._lookEventTime = arg_32_1.eventTime

	recthelper.setAnchorX(arg_32_0._goeventtipsTrs, arg_32_1.anchorX)
	gohelper.setActive(arg_32_0._goeventtips, not arg_32_1.isLastActivie)
	arg_32_0:_refreshTipsUI()
end

function var_0_0._createEventPointTB(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:getUserDataTb_()

	var_33_0.go = arg_33_1
	var_33_0.goTrs = arg_33_1.transform
	var_33_0._gounfinish = gohelper.findChild(arg_33_1, "unfinish")
	var_33_0._gofinish = gohelper.findChild(arg_33_1, "finished")
	var_33_0._gounactive = gohelper.findChild(arg_33_1, "unactive")
	var_33_0._btnunactive = gohelper.findChildButtonWithAudio(arg_33_1, "unactive")

	var_33_0._btnunactive:AddClickListener(arg_33_0._tbunactiveOnClick, arg_33_0, var_33_0)

	return var_33_0
end

function var_0_0._disposeEventPointBT(arg_34_0, arg_34_1)
	if arg_34_1 then
		arg_34_1.go = nil
		arg_34_1.goTrs = nil
		arg_34_1._gounfinsh = nil
		arg_34_1._gofinish = nil

		if arg_34_1._btnunactive then
			arg_34_1._btnunactive:RemoveClickListener()
		end

		arg_34_1._btnunactive = nil
	end
end

function var_0_0.getUserDataTb_(arg_35_0)
	if arg_35_0._view then
		return arg_35_0._view:getUserDataTb_()
	end

	return {}
end

var_0_0.prefabPath = "ui/viewres/room/critter/roomcrittertraindetailitem.prefab"

return var_0_0
