module("modules.logic.room.view.critter.RoomCritterTrainView", package.seeall)

slot0 = class("RoomCritterTrainView", BaseView)

function slot0.onInitView(slot0)
	slot0._gomapui = gohelper.findChild(slot0.viewGO, "#go_mapui")
	slot0._goheroSub = gohelper.findChild(slot0.viewGO, "right/#go_heroSub")
	slot0._btnherosort = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_heroSub/sort/#drop_herosort/#btn_herosort")
	slot0._btnherofilter = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_heroSub/sort/#btn_herofilter")
	slot0._gonoherofilter = gohelper.findChild(slot0.viewGO, "right/#go_heroSub/sort/#btn_herofilter/#go_noherofilter")
	slot0._goherofilter = gohelper.findChild(slot0.viewGO, "right/#go_heroSub/sort/#btn_herofilter/#go_herofilter")
	slot0._scrollhero = gohelper.findChildScrollRect(slot0.viewGO, "right/#go_heroSub/#scroll_hero")
	slot0._gocritterSub = gohelper.findChild(slot0.viewGO, "right/#go_critterSub")
	slot0._btncrittersort = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_critterSub/sort/#drop_crittersort/#btn_crittersort")
	slot0._btncritterfilter = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_critterSub/sort/#btn_critterfilter")
	slot0._gonocritterfilter = gohelper.findChild(slot0.viewGO, "right/#go_critterSub/sort/#btn_critterfilter/#go_nocritterfilter")
	slot0._gocritterfilter = gohelper.findChild(slot0.viewGO, "right/#go_critterSub/sort/#btn_critterfilter/#go_critterfilter")
	slot0._scrollcritter = gohelper.findChildScrollRect(slot0.viewGO, "right/#go_critterSub/#scroll_critter")
	slot0._goslotSub = gohelper.findChild(slot0.viewGO, "right/#go_slotSub")
	slot0._scrollslot = gohelper.findChildScrollRect(slot0.viewGO, "right/#go_slotSub/#scroll_slot")
	slot0._btntrain = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_train")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "right/#btn_train/#txt_num")
	slot0._gotrainfull = gohelper.findChild(slot0.viewGO, "right/#go_trainfull")
	slot0._btntrainstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_trainstart")
	slot0._txtlefttitle = gohelper.findChildText(slot0.viewGO, "left/#txt_lefttitle")
	slot0._scrolldes = gohelper.findChildScrollRect(slot0.viewGO, "left/#scroll_des")
	slot0._txtleftDesc = gohelper.findChildText(slot0.viewGO, "left/#scroll_des/viewport/content/#txt_leftDesc")
	slot0._gotrainingdetail = gohelper.findChild(slot0.viewGO, "bottom/#go_trainingdetail")
	slot0._gotrainselect = gohelper.findChild(slot0.viewGO, "bottom/#go_trainselect")
	slot0._btncritterrefresh = gohelper.findChildButtonWithAudio(slot0._gotrainingdetail, "#btn_critterrefresh")
	slot0._btnheroselect = gohelper.findChildButtonWithAudio(slot0._gotrainselect, "hero/#btn_hero_select")
	slot0._btncritterselect = gohelper.findChildButtonWithAudio(slot0._gotrainselect, "critter/#btn_critter_select")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnherosort:AddClickListener(slot0._btnherosortOnClick, slot0)
	slot0._btnherofilter:AddClickListener(slot0._btnherofilterOnClick, slot0)
	slot0._btncrittersort:AddClickListener(slot0._btncrittersortOnClick, slot0)
	slot0._btncritterfilter:AddClickListener(slot0._btncritterfilterOnClick, slot0)
	slot0._btntrain:AddClickListener(slot0._btntrainOnClick, slot0)
	slot0._btntrainstart:AddClickListener(slot0._btntrainstartOnClick, slot0)
	slot0._btncritterrefresh:AddClickListener(slot0._btncritterrefreshOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnherosort:RemoveClickListener()
	slot0._btnherofilter:RemoveClickListener()
	slot0._btncrittersort:RemoveClickListener()
	slot0._btncritterfilter:RemoveClickListener()
	slot0._btntrain:RemoveClickListener()
	slot0._btntrainstart:RemoveClickListener()
	slot0._btncritterrefresh:RemoveClickListener()
end

function slot0._btntrainstartOnClick(slot0)
	if not slot0._selectSlotMO then
		return
	end

	if not slot0._selectCritterUid then
		GameFacade.showToast(ToastEnum.RoomCritterTrainNoCritter)

		return
	end

	if not slot0._selectHeroId then
		GameFacade.showToast(ToastEnum.RoomCritterTrainNoHero)

		return
	end

	slot2 = slot0._selectSlotMO.critterMO and slot1.id
	slot3 = slot1 and slot1.trainInfo.heroId

	if slot0:_getTrainBtnOpState() == slot0._TrainBtnOpState.FinishTrain then
		if slot1.trainInfo:isFinishAllEvent() then
			RoomCritterController.instance:sendFinishTrainCritter(slot1.id)
		else
			RoomCritterController.instance:openTrainEventView(slot1.id)
		end

		return
	end

	slot4 = nil

	if slot2 then
		if slot2 == slot0._selectCritterUid and slot3 == slot0._selectHeroId then
			slot4 = MessageBoxIdDefine.RoomCritterTrainChangeCancel
		elseif slot2 ~= slot0._selectCritterUid then
			slot4 = MessageBoxIdDefine.RoomCritterTrainChangeCritter
		elseif slot3 ~= slot0._selectHeroId then
			slot4 = MessageBoxIdDefine.RoomCritterTrainChangeHero
		end
	end

	if slot4 then
		GameFacade.showMessageBox(slot4, MsgBoxEnum.BoxType.Yes_No, slot0._sendStartRequest, nil, , slot0, nil, )
	else
		slot0:_sendStartRequest()
	end
end

function slot0._sendStartRequest(slot0)
	if not slot0._selectSlotMO or not slot0._selectCritterUid or not slot0._selectHeroId then
		return
	end

	slot2 = slot0._selectSlotMO.critterMO and slot1.id
	slot3 = slot1 and slot1.trainInfo.heroId

	if slot1 then
		CritterRpc.instance:sendCancelTrainRequest(slot1.id)
	end

	if slot2 ~= slot0._selectCritterUid or slot3 ~= slot0._selectHeroId then
		slot0._selectSlotMO:setWaitingCritterUid(slot0._selectCritterUid)

		if GuideModel.instance:getLockGuideId() == GuideEnum.GuideId.RoomCritterTrain then
			CritterRpc.instance:sendStartTrainCritterRequest(slot0._selectCritterUid, slot0._selectHeroId, slot4, GuideModel.instance:getById(slot4).currStepId)
		else
			CritterRpc.instance:sendStartTrainCritterRequest(slot0._selectCritterUid, slot0._selectHeroId)
		end

		if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.RoomCritterTrainOcne, 0) then
			RedDotRpc.instance:sendGetRedDotInfosRequest({
				RedDotEnum.DotNode.RoomCritterTrainOcne
			})
		end
	end
end

function slot0._btnherosortOnClick(slot0)
	slot0:_btncrittersortOnClick()
end

function slot0._btnherofilterOnClick(slot0)
	CritterController.instance:openCritterFilterView({
		CritterEnum.FilterType.Race
	}, slot0.viewName)
end

function slot0._btncrittersortOnClick(slot0)
	slot0:_setSortIndex(slot0._lastCritterIndex, slot0._isHightToLow == false)
	slot0:_refreshFilterUI()
end

function slot0._btncritterfilterOnClick(slot0)
	CritterController.instance:openCritterFilterView({
		CritterEnum.FilterType.Race,
		CritterEnum.FilterType.SkillTag
	}, slot0.viewName)
end

function slot0._btncritterrefreshOnClick(slot0)
	slot0:setShowSubSelectView(true)
	slot0.viewContainer:dispatchEvent(CritterEvent.UIChangeTrainCritter, slot0._selectSlotMO)
end

function slot0._btntrainOnClick(slot0)
	slot1 = RoomTrainSlotListModel.instance:findFreeSlotMO()

	if slot0.viewContainer and slot1 then
		slot0.viewContainer:dispatchEvent(CritterEvent.UITrainSelectSlot, slot1)
	end
end

function slot0._btnheroOnClick(slot0)
	slot0:_selectSubView(slot0._TrainSubViewID.HeroSub)
end

function slot0._btncritterOnClick(slot0)
	slot0:_selectSubView(slot0._TrainSubViewID.CritterSub)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._btntrain, false)
	gohelper.setActive(slot0._gotrainfull, false)

	slot0._dropCritterSort = gohelper.findChildDropdown(slot0.viewGO, "right/#go_critterSub/sort/#drop_crittersort")
	slot0._dropHeroSort = gohelper.findChildDropdown(slot0.viewGO, "right/#go_heroSub/sort/#drop_herosort")
	slot0._txttrainstart = gohelper.findChildText(slot0.viewGO, "right/#btn_trainstart/txt_start")
	slot0._gocritterArrow = gohelper.findChild(slot0.viewGO, "right/#go_critterSub/sort/#drop_crittersort/arrow")
	slot0._goheroArrow = gohelper.findChild(slot0.viewGO, "right/#go_heroSub/sort/#drop_herosort/arrow")
	slot0._gocritterEmpty = gohelper.findChild(slot0._gocritterSub, "#go_empty")
	slot0._goheroEmpty = gohelper.findChild(slot0._goheroSub, "#go_empty")
	slot0._gocritterArrowTrs = slot0._gocritterArrow.transform
	slot0._goheroArrowTrs = slot0._goheroArrow.transform
	slot0._subGOList = slot0:getUserDataTb_()

	table.insert(slot0._subGOList, slot0._goslotSub)
	table.insert(slot0._subGOList, slot0._gocritterSub)
	table.insert(slot0._subGOList, slot0._goheroSub)

	slot0._TrainSubViewID = {
		CritterSub = 2,
		HeroSub = 3,
		SlotSub = 1
	}
	slot0._TrainBtnOpState = {
		StartNewTrain = 1,
		FinishTrain = 4,
		CancelTrain = 2,
		ChangeTrain = 3
	}
	slot0._TrainBtnLang = {
		[slot0._TrainBtnOpState.StartNewTrain] = "critter_train_startnew_txt",
		[slot0._TrainBtnOpState.CancelTrain] = "critter_train_cancel_txt",
		[slot0._TrainBtnOpState.ChangeTrain] = "critter_train_change_txt",
		[slot0._TrainBtnOpState.FinishTrain] = "critter_train_finish_txt"
	}

	slot0:_initSortFilter()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if slot0.viewContainer then
		slot0:addEventCb(slot0.viewContainer, CritterEvent.UITrainSelectCritter, slot0._onSelectCritterItem, slot0)
		slot0:addEventCb(slot0.viewContainer, CritterEvent.UITrainSelectHero, slot0._onSelectHeroItem, slot0)
		slot0:addEventCb(slot0.viewContainer, CritterEvent.UITrainSelectSlot, slot0._onSelectSlotItem, slot0)
		slot0:addEventCb(slot0.viewContainer, CritterEvent.UITrainSubTab, slot0._selectSubView, slot0)
		slot0:addEventCb(slot0.viewContainer, CritterEvent.UIChangeTrainCritter, slot0._onChangeTrainCritter, slot0)
		slot0:addEventCb(slot0.viewContainer, CritterEvent.UITrainViewGoBack, slot0._onTrainGoBack, slot0)
	end

	slot0:addEventCb(CritterController.instance, CritterEvent.TrainFinishTrainCritterReply, slot0._onTrainFinishTrainCritterReply, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.TrainStartTrainCritterReply, slot0._onTrainStartTrainCritterReply, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.TrainCancelTrainReply, slot0._onTrainCancelTrainReply, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterChangeFilterType, slot0._onCritterChangeFilterType, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, slot0._onCritterInfoPushUpdate, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.TradeLevelChange, slot0._onTradeLevelChange, slot0)

	slot0.filterMO = CritterFilterModel.instance:generateFilterMO(slot0.viewName)

	RoomTrainSlotListModel.instance:setSlotList()
	RoomTrainHeroListModel.instance:setHeroList(slot0.filterMO)
	RoomTrainCritterListModel.instance:setCritterList(slot0.filterMO)
	slot0:_selectSubView(slot0._TrainSubViewID.SlotSub)
	TaskDispatcher.cancelTask(slot0._onRunCdTimeTask, slot0)
	TaskDispatcher.runRepeat(slot0._onRunCdTimeTask, slot0, 1)
	slot0:_refreshTarnBtnUI()

	slot1 = RoomTrainSlotListModel.instance:getSelectMO()

	if slot0.viewParam and slot0.viewParam.critterUid and RoomTrainSlotListModel.instance:getSlotMOByCritterUi(slot0.viewParam.critterUid) then
		slot1 = slot2

		RoomTrainSlotListModel.instance:setSelect(slot2.id)
	end

	if slot0.viewContainer and slot1 and slot1.critterMO then
		slot0.viewContainer:dispatchEvent(CritterEvent.UITrainSelectSlot, slot1)
	else
		gohelper.setActive(slot0._gotrainingdetail, false)
		gohelper.setActive(slot0._gomapui, false)
		gohelper.setActive(slot0._gotrainselect, false)
	end

	slot0:_refreshEmptyUI()

	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.RoomCritterTrainHas, 0) then
		RedDotRpc.instance:sendGetRedDotInfosRequest({
			RedDotEnum.DotNode.RoomCritterTrainHas
		})
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onRunCdTimeTask, slot0)
	slot0._dropCritterSort:RemoveOnValueChanged()
	slot0._dropHeroSort:RemoveOnValueChanged()

	if RoomCameraController.instance:getRoomScene() then
		slot1.cameraFollow:setFollowTarget(nil)
	end

	RoomCritterController.instance:setInteractionParam(nil)
end

function slot0.onDestroyView(slot0)
end

slot0._sortAttrIdKey = "RoomCritterTrainView._sortAttrIdKey"

function slot0._initSortFilter(slot0)
	slot0._critterOptions = {}
	slot1 = {}
	slot0._selectAttrId = RoomTrainCritterListModel.instance:getSortAttrId()
	slot0._isHightToLow = true
	slot2 = 0
	slot6 = lua_critter_attribute.configList

	tabletool.addValues(slot0._critterOptions, slot6)

	for slot6, slot7 in ipairs(slot0._critterOptions) do
		if slot7.id == slot0._selectAttrId then
			slot2 = slot6 - 1
		end

		table.insert(slot1, slot7.name)
	end

	slot0:_setSortIndex(slot2, slot0._isHightToLow)
	slot0._dropCritterSort:ClearOptions()
	slot0._dropCritterSort:AddOptions(slot1)
	slot0._dropCritterSort:SetValue(slot2)
	slot0._dropCritterSort:AddOnValueChanged(slot0._onCritterDropValueChanged, slot0)
	slot0._dropHeroSort:ClearOptions()
	slot0._dropHeroSort:AddOptions(slot1)
	slot0._dropHeroSort:SetValue(slot2)
	slot0._dropHeroSort:AddOnValueChanged(slot0._onHeroDropValueChanged, slot0)
	slot0:_refreshFilterUI()
end

function slot0._refreshFilterUI(slot0)
	slot1 = slot0.filterMO and slot0.filterMO:isFiltering()

	gohelper.setActive(slot0._gocritterfilter, slot1)
	gohelper.setActive(slot0._gonocritterfilter, not slot1)
	gohelper.setActive(slot0._goherofilter, slot1)
	gohelper.setActive(slot0._gonoherofilter, not slot1)

	slot2 = slot0._isHightToLow and -1 or 1

	transformhelper.setLocalScale(slot0._gocritterArrowTrs, 1, slot2, 1)
	transformhelper.setLocalScale(slot0._goheroArrowTrs, 1, slot2, 1)
	slot0:_refreshEmptyUI()
end

function slot0._refreshEmptyUI(slot0)
end

function slot0._setSortIndex(slot0, slot1, slot2)
	if slot0._lastCritterIndex == slot1 and slot0._isLastHightToLow == slot2 then
		return
	end

	slot0._lastCritterIndex = slot1
	slot0._isLastHightToLow = slot2
	slot0._isHightToLow = slot2

	if slot0._critterOptions[slot1 + 1] then
		slot0._selectAttrId = slot3.id

		RoomTrainCritterListModel.instance:sortByAttrId(slot0._selectAttrId, slot0._isHightToLow)
		RoomTrainHeroListModel.instance:sortByAttrId(slot0._selectAttrId, slot0._isHightToLow)
		RoomTrainCritterListModel.instance:onModelUpdate()
		RoomTrainHeroListModel.instance:onModelUpdate()
	end
end

function slot0._onCritterDropValueChanged(slot0, slot1)
	slot0:_setSortIndex(slot1, slot0._isHightToLow)
	slot0._dropHeroSort:SetValue(slot1)
end

function slot0._onHeroDropValueChanged(slot0, slot1)
	slot0:_setSortIndex(slot1, slot0._isHightToLow)
	slot0._dropCritterSort:SetValue(slot1)
end

function slot0._onRunCdTimeTask(slot0)
	if slot0.viewContainer and slot0.viewContainer:isOpen() then
		slot0.viewContainer:dispatchEvent(CritterEvent.UITrainCdTime)
	else
		TaskDispatcher.cancelTask(slot0._onRunCdTimeTask, slot0)
	end
end

function slot0._selectSubView(slot0, slot1)
	slot0._curSubTagIdx = slot1 or slot0._TrainSubViewID.SlotSub

	for slot5 = 1, #slot0._subGOList do
		gohelper.setActive(slot0._subGOList[slot5], slot5 == slot1)
	end
end

function slot0._setSelectSlotMO(slot0, slot1)
	slot0._selectHeroId = nil
	slot0._trainHeroId = nil
	slot0._trainCritterUid = nil
	slot0._selectCritterUid = nil
	slot0._selectSlotMO = slot1
	slot0._selectSlotId = slot1 and slot1.id

	if slot1 and slot1.critterMO then
		slot0._trainCritterUid = slot2.id
		slot0._trainHeroId = slot2.trainInfo.heroId
		slot0._selectCritterUid = slot2.id
		slot0._selectHeroId = slot2.trainInfo.heroId
	end
end

function slot0._onSelectSlotItem(slot0, slot1, slot2)
	slot0:_setSelectSlotMO(slot1)
	RoomTrainSlotListModel.instance:setSelect(slot1.id)
	RoomTrainHeroListModel.instance:setSelect(nil)
	RoomTrainCritterListModel.instance:setSelect(nil)
	slot0:setShowSubSelectView((slot1 and slot1.critterMO and slot1.critterMO.id) == nil, slot2)
end

function slot0._onSelectCritterItem(slot0, slot1)
	if slot0._selectCritterUid ~= slot1.id then
		slot0._selectCritterUid = slot1.id

		RoomTrainCritterListModel.instance:setSelect(slot1.id)
		slot0:setShowSubSelectView(true)
		RoomTrainHeroListModel.instance:updateHeroList()
	end
end

function slot0._onSelectHeroItem(slot0, slot1)
	slot0._selectHeroMO = slot1

	if slot0._selectHeroId ~= slot1.id then
		slot0._selectHeroId = slot1.id

		RoomTrainHeroListModel.instance:setSelect(slot1.id)
		slot0:setShowSubSelectView(true)
		RoomTrainCritterListModel.instance:updateCritterList()
	end
end

function slot0._onChangeTrainCritter(slot0, slot1)
	slot0:_setSelectSlotMO(slot1)
	RoomTrainHeroListModel.instance:setSelect(slot0._selectCritterUid)
	RoomTrainCritterListModel.instance:setSelect(slot0._selectHeroId)
	slot0:setShowSubSelectView(true)
	RoomTrainHeroListModel.instance:updateHeroList()
	RoomTrainCritterListModel.instance:updateCritterList()
end

function slot0._onTrainGoBack(slot0)
	slot0:_setSelectSlotMO(slot0._selectSlotMO)
	RoomTrainHeroListModel.instance:setSelect(nil)
	RoomTrainCritterListModel.instance:setSelect(nil)
	slot0:setShowSubSelectView(false, true)
end

function slot0._onTrainStartTrainCritterReply(slot0, slot1, slot2)
	slot0:_updateSelectReply(slot1)
end

function slot0._onTrainFinishTrainCritterReply(slot0, slot1)
	slot0:_updateSelectReply(slot1, true)
end

function slot0._onTrainCancelTrainReply(slot0, slot1)
	slot0:_updateSelectReply(slot1)
end

function slot0._onTradeLevelChange(slot0)
	RoomTrainSlotListModel.instance:updateSlotList()
end

function slot0._onCritterInfoPushUpdate(slot0)
	RoomTrainCritterListModel.instance:updateCritterList()
end

function slot0._udateCritterAndHeroList(slot0, slot1)
	RoomTrainCritterListModel.instance:updateCritterList()

	if slot1 == true then
		RoomTrainHeroListModel.instance:updateCritterList()
	end
end

function slot0._onCritterChangeFilterType(slot0, slot1)
	if slot0.viewName == slot1 then
		RoomTrainHeroListModel.instance:setHeroList(slot0.filterMO)
		RoomTrainCritterListModel.instance:setCritterList(slot0.filterMO)
		slot0:_refreshFilterUI()
	end
end

function slot0._updateSelectReply(slot0, slot1, slot2)
	if slot0._selectCritterUid == slot1 and (not slot2 or slot0._trainCritterUid == slot1) then
		if slot0._selectSlotMO then
			slot0.viewContainer:dispatchEvent(CritterEvent.UITrainSelectSlot, slot0._selectSlotMO)
		end

		slot0:setShowSubSelectView(false)
	end

	RoomTrainSlotListModel.instance:onModelUpdate()
	RoomTrainCritterListModel.instance:updateCritterList()
	RoomTrainHeroListModel.instance:updateHeroList()
	slot0:_refreshEmptyUI()
end

function slot0.setShowSubSelectView(slot0, slot1, slot2)
	slot0:_setOpState(slot1 and CritterEnum.TrainOPState.PairOP or CritterEnum.TrainOPState.Normal)

	slot4 = slot0._trainCritterUid ~= nil
	slot0._isShowSubSelect = slot1

	gohelper.setActive(slot0._gotrainingdetail, not slot1 and slot4)
	gohelper.setActive(slot0._gomapui, not slot1 and slot4)
	gohelper.setActive(slot0._gotrainselect, slot1)

	if slot1 then
		if not slot0._curSubTagIdx or slot0._curSubTagIdx == slot0._TrainSubViewID.SlotSub then
			slot0:_selectSubView(slot0._TrainSubViewID.CritterSub)
		end
	else
		slot0:_selectSubView(slot0._TrainSubViewID.SlotSub)
	end

	slot0:_refreshTarnBtnUI()

	if slot2 ~= true then
		if slot1 then
			slot0:_followTrainHero(0)
		else
			slot0:_followTrainHero(slot0._trainHeroId or 0)
		end
	end
end

function slot0._setOpState(slot0, slot1)
	if slot0.viewContainer and slot0.viewContainer.setContainerTabState then
		if slot0._lastOptate == slot1 then
			return
		end

		slot0._lastOptate = slot1

		slot0.viewContainer:setContainerTabState(RoomCritterBuildingViewContainer.SubViewTabId.Training, slot1)

		if CritterEnum.TrainOPState.Normal == slot1 then
			CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingShowView)
		else
			CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingHideView, true)
		end
	end
end

function slot0._refreshTarnBtnUI(slot0)
	slot1 = 0

	if slot0._isShowSubSelect then
		slot1 = 1
	else
		slot2, slot3 = RoomTrainSlotListModel.instance:getTrarinAndFreeCount()

		if slot3 > 0 then
			slot1 = 2
			slot0._txtnum.text = string.format("%s/%s", slot2, slot2 + slot3)
		end
	end

	gohelper.setActive(slot0._btntrainstart, slot1 == 1)

	if slot1 == 1 then
		slot0._txttrainstart.text = luaLang(slot0._TrainBtnLang[slot0:_getTrainBtnOpState()])
	end
end

function slot0._getTrainBtnOpState(slot0)
	if slot0._trainCritterUid then
		if slot0._trainCritterUid == slot0._selectCritterUid and slot0._trainHeroId == slot0._selectHeroId then
			if slot0._selectSlotMO and slot0._selectSlotMO.critterMO and slot1.trainInfo:isTrainFinish() then
				return slot0._TrainBtnOpState.FinishTrain
			end

			return slot0._TrainBtnOpState.CancelTrain
		end

		return slot0._TrainBtnOpState.ChangeTrain
	end

	return slot0._TrainBtnOpState.StartNewTrain
end

function slot0._followTrainHero(slot0, slot1)
	if slot0.viewContainer:getContainerCurSelectTab() ~= RoomCritterBuildingViewContainer.SubViewTabId.Training then
		RoomCritterController.instance:setInteractionParam(nil)

		return
	end

	if slot0._lastFollowHeroId == (slot1 or 0) then
		return
	end

	if not RoomCameraController.instance:getRoomScene() then
		return
	end

	slot0._lastFollowHeroId = slot1

	if slot2.charactermgr:getUnit(RoomCharacterEntity:getTag(), slot1) then
		slot4, slot2.cameraFollow._offsetY, slot6 = transformhelper.getPos(slot3.goTrs)
		slot8 = RoomEnum.CameraState.ThirdPerson

		slot2.camera:setChangeCameraParamsById(slot8, RoomEnum.CameraParamId.CritterTrainHeroFollow)
		slot2.camera:switchCameraState(slot8, {
			focusX = slot4,
			focusY = slot6
		}, nil, slot0._onTweenCameraFollerMoveFinish, slot0)
		slot2.cameraFollow:setFollowTarget(slot3.cameraFollowTargetComp, false)
		slot2.cameraFollow:setIsPass(true)
		RoomCritterController.instance:setInteractionParam(slot0._lastFollowHeroId)
	else
		RoomCritterController.instance:setInteractionParam(nil)

		slot4, slot5 = slot0.viewContainer:getContainerViewBuilding()

		if not slot5 then
			return
		end

		slot7 = ManufactureConfig.instance:getBuildingCameraIdByIndex(slot5.buildingId, slot0.viewContainer:getContainerCurSelectTab())

		if RoomCameraController.instance:getRoomCamera() and slot7 then
			RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(slot4, slot7)
		end
	end
end

function slot0._onTweenCameraFollerMoveFinish(slot0)
	if slot0.viewContainer:getContainerCurSelectTab() == RoomCritterBuildingViewContainer.SubViewTabId.Training and RoomCameraController.instance:getRoomScene() then
		slot1.cameraFollow:setIsPass(false)
	end
end

return slot0
