module("modules.logic.room.view.critter.RoomCritterTrainView", package.seeall)

local var_0_0 = class("RoomCritterTrainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomapui = gohelper.findChild(arg_1_0.viewGO, "#go_mapui")
	arg_1_0._goheroSub = gohelper.findChild(arg_1_0.viewGO, "right/#go_heroSub")
	arg_1_0._btnherosort = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_heroSub/sort/#drop_herosort/#btn_herosort")
	arg_1_0._btnherofilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_heroSub/sort/#btn_herofilter")
	arg_1_0._gonoherofilter = gohelper.findChild(arg_1_0.viewGO, "right/#go_heroSub/sort/#btn_herofilter/#go_noherofilter")
	arg_1_0._goherofilter = gohelper.findChild(arg_1_0.viewGO, "right/#go_heroSub/sort/#btn_herofilter/#go_herofilter")
	arg_1_0._scrollhero = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/#go_heroSub/#scroll_hero")
	arg_1_0._gocritterSub = gohelper.findChild(arg_1_0.viewGO, "right/#go_critterSub")
	arg_1_0._btncrittersort = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_critterSub/sort/#drop_crittersort/#btn_crittersort")
	arg_1_0._btncritterfilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_critterSub/sort/#btn_critterfilter")
	arg_1_0._gonocritterfilter = gohelper.findChild(arg_1_0.viewGO, "right/#go_critterSub/sort/#btn_critterfilter/#go_nocritterfilter")
	arg_1_0._gocritterfilter = gohelper.findChild(arg_1_0.viewGO, "right/#go_critterSub/sort/#btn_critterfilter/#go_critterfilter")
	arg_1_0._scrollcritter = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/#go_critterSub/#scroll_critter")
	arg_1_0._goslotSub = gohelper.findChild(arg_1_0.viewGO, "right/#go_slotSub")
	arg_1_0._scrollslot = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/#go_slotSub/#scroll_slot")
	arg_1_0._btntrain = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_train")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "right/#btn_train/#txt_num")
	arg_1_0._gotrainfull = gohelper.findChild(arg_1_0.viewGO, "right/#go_trainfull")
	arg_1_0._btntrainstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_trainstart")
	arg_1_0._txtlefttitle = gohelper.findChildText(arg_1_0.viewGO, "left/#txt_lefttitle")
	arg_1_0._scrolldes = gohelper.findChildScrollRect(arg_1_0.viewGO, "left/#scroll_des")
	arg_1_0._txtleftDesc = gohelper.findChildText(arg_1_0.viewGO, "left/#scroll_des/viewport/content/#txt_leftDesc")
	arg_1_0._gotrainingdetail = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_trainingdetail")
	arg_1_0._gotrainselect = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_trainselect")
	arg_1_0._btncritterrefresh = gohelper.findChildButtonWithAudio(arg_1_0._gotrainingdetail, "#btn_critterrefresh")
	arg_1_0._btnheroselect = gohelper.findChildButtonWithAudio(arg_1_0._gotrainselect, "hero/#btn_hero_select")
	arg_1_0._btncritterselect = gohelper.findChildButtonWithAudio(arg_1_0._gotrainselect, "critter/#btn_critter_select")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnherosort:AddClickListener(arg_2_0._btnherosortOnClick, arg_2_0)
	arg_2_0._btnherofilter:AddClickListener(arg_2_0._btnherofilterOnClick, arg_2_0)
	arg_2_0._btncrittersort:AddClickListener(arg_2_0._btncrittersortOnClick, arg_2_0)
	arg_2_0._btncritterfilter:AddClickListener(arg_2_0._btncritterfilterOnClick, arg_2_0)
	arg_2_0._btntrain:AddClickListener(arg_2_0._btntrainOnClick, arg_2_0)
	arg_2_0._btntrainstart:AddClickListener(arg_2_0._btntrainstartOnClick, arg_2_0)
	arg_2_0._btncritterrefresh:AddClickListener(arg_2_0._btncritterrefreshOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnherosort:RemoveClickListener()
	arg_3_0._btnherofilter:RemoveClickListener()
	arg_3_0._btncrittersort:RemoveClickListener()
	arg_3_0._btncritterfilter:RemoveClickListener()
	arg_3_0._btntrain:RemoveClickListener()
	arg_3_0._btntrainstart:RemoveClickListener()
	arg_3_0._btncritterrefresh:RemoveClickListener()
end

function var_0_0._btntrainstartOnClick(arg_4_0)
	if not arg_4_0._selectSlotMO then
		return
	end

	if not arg_4_0._selectCritterUid then
		GameFacade.showToast(ToastEnum.RoomCritterTrainNoCritter)

		return
	end

	if not arg_4_0._selectHeroId then
		GameFacade.showToast(ToastEnum.RoomCritterTrainNoHero)

		return
	end

	local var_4_0 = arg_4_0._selectSlotMO.critterMO
	local var_4_1 = var_4_0 and var_4_0.id
	local var_4_2 = var_4_0 and var_4_0.trainInfo.heroId

	if arg_4_0:_getTrainBtnOpState() == arg_4_0._TrainBtnOpState.FinishTrain then
		if var_4_0.trainInfo:isFinishAllEvent() then
			RoomCritterController.instance:sendFinishTrainCritter(var_4_0.id)
		else
			RoomCritterController.instance:openTrainEventView(var_4_0.id)
		end

		return
	end

	local var_4_3

	if var_4_1 then
		if var_4_1 == arg_4_0._selectCritterUid and var_4_2 == arg_4_0._selectHeroId then
			var_4_3 = MessageBoxIdDefine.RoomCritterTrainChangeCancel
		elseif var_4_1 ~= arg_4_0._selectCritterUid then
			var_4_3 = MessageBoxIdDefine.RoomCritterTrainChangeCritter
		elseif var_4_2 ~= arg_4_0._selectHeroId then
			var_4_3 = MessageBoxIdDefine.RoomCritterTrainChangeHero
		end
	end

	if var_4_3 then
		GameFacade.showMessageBox(var_4_3, MsgBoxEnum.BoxType.Yes_No, arg_4_0._sendStartRequest, nil, nil, arg_4_0, nil, nil)
	else
		arg_4_0:_sendStartRequest()
	end
end

function var_0_0._sendStartRequest(arg_5_0)
	if not arg_5_0._selectSlotMO or not arg_5_0._selectCritterUid or not arg_5_0._selectHeroId then
		return
	end

	local var_5_0 = arg_5_0._selectSlotMO.critterMO
	local var_5_1 = var_5_0 and var_5_0.id
	local var_5_2 = var_5_0 and var_5_0.trainInfo.heroId

	if var_5_0 then
		CritterRpc.instance:sendCancelTrainRequest(var_5_0.id)
	end

	if var_5_1 ~= arg_5_0._selectCritterUid or var_5_2 ~= arg_5_0._selectHeroId then
		arg_5_0._selectSlotMO:setWaitingCritterUid(arg_5_0._selectCritterUid)

		local var_5_3 = GuideModel.instance:getLockGuideId()

		if var_5_3 == GuideEnum.GuideId.RoomCritterTrain then
			local var_5_4 = GuideModel.instance:getById(var_5_3).currStepId

			CritterRpc.instance:sendStartTrainCritterRequest(arg_5_0._selectCritterUid, arg_5_0._selectHeroId, var_5_3, var_5_4)
		else
			CritterRpc.instance:sendStartTrainCritterRequest(arg_5_0._selectCritterUid, arg_5_0._selectHeroId)
		end

		if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.RoomCritterTrainOcne, 0) then
			RedDotRpc.instance:sendGetRedDotInfosRequest({
				RedDotEnum.DotNode.RoomCritterTrainOcne
			})
		end
	end
end

function var_0_0._btnherosortOnClick(arg_6_0)
	arg_6_0:_btncrittersortOnClick()
end

function var_0_0._btnherofilterOnClick(arg_7_0)
	local var_7_0 = {
		CritterEnum.FilterType.Race
	}

	CritterController.instance:openCritterFilterView(var_7_0, arg_7_0.viewName)
end

function var_0_0._btncrittersortOnClick(arg_8_0)
	arg_8_0:_setSortIndex(arg_8_0._lastCritterIndex, arg_8_0._isHightToLow == false)
	arg_8_0:_refreshFilterUI()
end

function var_0_0._btncritterfilterOnClick(arg_9_0)
	local var_9_0 = {
		CritterEnum.FilterType.Race,
		CritterEnum.FilterType.SkillTag
	}

	CritterController.instance:openCritterFilterView(var_9_0, arg_9_0.viewName)
end

function var_0_0._btncritterrefreshOnClick(arg_10_0)
	arg_10_0:setShowSubSelectView(true)
	arg_10_0.viewContainer:dispatchEvent(CritterEvent.UIChangeTrainCritter, arg_10_0._selectSlotMO)
end

function var_0_0._btntrainOnClick(arg_11_0)
	local var_11_0 = RoomTrainSlotListModel.instance:findFreeSlotMO()

	if arg_11_0.viewContainer and var_11_0 then
		arg_11_0.viewContainer:dispatchEvent(CritterEvent.UITrainSelectSlot, var_11_0)
	end
end

function var_0_0._btnheroOnClick(arg_12_0)
	arg_12_0:_selectSubView(arg_12_0._TrainSubViewID.HeroSub)
end

function var_0_0._btncritterOnClick(arg_13_0)
	arg_13_0:_selectSubView(arg_13_0._TrainSubViewID.CritterSub)
end

function var_0_0._editableInitView(arg_14_0)
	gohelper.setActive(arg_14_0._btntrain, false)
	gohelper.setActive(arg_14_0._gotrainfull, false)

	arg_14_0._dropCritterSort = gohelper.findChildDropdown(arg_14_0.viewGO, "right/#go_critterSub/sort/#drop_crittersort")
	arg_14_0._dropHeroSort = gohelper.findChildDropdown(arg_14_0.viewGO, "right/#go_heroSub/sort/#drop_herosort")
	arg_14_0._txttrainstart = gohelper.findChildText(arg_14_0.viewGO, "right/#btn_trainstart/txt_start")
	arg_14_0._gocritterArrow = gohelper.findChild(arg_14_0.viewGO, "right/#go_critterSub/sort/#drop_crittersort/arrow")
	arg_14_0._goheroArrow = gohelper.findChild(arg_14_0.viewGO, "right/#go_heroSub/sort/#drop_herosort/arrow")
	arg_14_0._gocritterEmpty = gohelper.findChild(arg_14_0._gocritterSub, "#go_empty")
	arg_14_0._goheroEmpty = gohelper.findChild(arg_14_0._goheroSub, "#go_empty")
	arg_14_0._gocritterArrowTrs = arg_14_0._gocritterArrow.transform
	arg_14_0._goheroArrowTrs = arg_14_0._goheroArrow.transform
	arg_14_0._subGOList = arg_14_0:getUserDataTb_()

	table.insert(arg_14_0._subGOList, arg_14_0._goslotSub)
	table.insert(arg_14_0._subGOList, arg_14_0._gocritterSub)
	table.insert(arg_14_0._subGOList, arg_14_0._goheroSub)

	arg_14_0._TrainSubViewID = {
		CritterSub = 2,
		HeroSub = 3,
		SlotSub = 1
	}
	arg_14_0._TrainBtnOpState = {
		StartNewTrain = 1,
		FinishTrain = 4,
		CancelTrain = 2,
		ChangeTrain = 3
	}
	arg_14_0._TrainBtnLang = {
		[arg_14_0._TrainBtnOpState.StartNewTrain] = "critter_train_startnew_txt",
		[arg_14_0._TrainBtnOpState.CancelTrain] = "critter_train_cancel_txt",
		[arg_14_0._TrainBtnOpState.ChangeTrain] = "critter_train_change_txt",
		[arg_14_0._TrainBtnOpState.FinishTrain] = "critter_train_finish_txt"
	}

	arg_14_0:_initSortFilter()
end

function var_0_0.onUpdateParam(arg_15_0)
	return
end

function var_0_0.onOpen(arg_16_0)
	if arg_16_0.viewContainer then
		arg_16_0:addEventCb(arg_16_0.viewContainer, CritterEvent.UITrainSelectCritter, arg_16_0._onSelectCritterItem, arg_16_0)
		arg_16_0:addEventCb(arg_16_0.viewContainer, CritterEvent.UITrainSelectHero, arg_16_0._onSelectHeroItem, arg_16_0)
		arg_16_0:addEventCb(arg_16_0.viewContainer, CritterEvent.UITrainSelectSlot, arg_16_0._onSelectSlotItem, arg_16_0)
		arg_16_0:addEventCb(arg_16_0.viewContainer, CritterEvent.UITrainSubTab, arg_16_0._selectSubView, arg_16_0)
		arg_16_0:addEventCb(arg_16_0.viewContainer, CritterEvent.UIChangeTrainCritter, arg_16_0._onChangeTrainCritter, arg_16_0)
		arg_16_0:addEventCb(arg_16_0.viewContainer, CritterEvent.UITrainViewGoBack, arg_16_0._onTrainGoBack, arg_16_0)
	end

	arg_16_0:addEventCb(CritterController.instance, CritterEvent.TrainFinishTrainCritterReply, arg_16_0._onTrainFinishTrainCritterReply, arg_16_0)
	arg_16_0:addEventCb(CritterController.instance, CritterEvent.TrainStartTrainCritterReply, arg_16_0._onTrainStartTrainCritterReply, arg_16_0)
	arg_16_0:addEventCb(CritterController.instance, CritterEvent.TrainCancelTrainReply, arg_16_0._onTrainCancelTrainReply, arg_16_0)
	arg_16_0:addEventCb(CritterController.instance, CritterEvent.CritterChangeFilterType, arg_16_0._onCritterChangeFilterType, arg_16_0)
	arg_16_0:addEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, arg_16_0._onCritterInfoPushUpdate, arg_16_0)
	arg_16_0:addEventCb(ManufactureController.instance, ManufactureEvent.TradeLevelChange, arg_16_0._onTradeLevelChange, arg_16_0)

	arg_16_0.filterMO = CritterFilterModel.instance:generateFilterMO(arg_16_0.viewName)

	RoomTrainSlotListModel.instance:setSlotList()
	RoomTrainHeroListModel.instance:setHeroList(arg_16_0.filterMO)
	RoomTrainCritterListModel.instance:setCritterList(arg_16_0.filterMO)
	arg_16_0:_selectSubView(arg_16_0._TrainSubViewID.SlotSub)
	TaskDispatcher.cancelTask(arg_16_0._onRunCdTimeTask, arg_16_0)
	TaskDispatcher.runRepeat(arg_16_0._onRunCdTimeTask, arg_16_0, 1)
	arg_16_0:_refreshTarnBtnUI()

	local var_16_0 = RoomTrainSlotListModel.instance:getSelectMO()

	if arg_16_0.viewParam and arg_16_0.viewParam.critterUid then
		local var_16_1 = RoomTrainSlotListModel.instance:getSlotMOByCritterUi(arg_16_0.viewParam.critterUid)

		if var_16_1 then
			var_16_0 = var_16_1

			RoomTrainSlotListModel.instance:setSelect(var_16_1.id)
		end
	end

	if arg_16_0.viewContainer and var_16_0 and var_16_0.critterMO then
		arg_16_0.viewContainer:dispatchEvent(CritterEvent.UITrainSelectSlot, var_16_0)
	else
		gohelper.setActive(arg_16_0._gotrainingdetail, false)
		gohelper.setActive(arg_16_0._gomapui, false)
		gohelper.setActive(arg_16_0._gotrainselect, false)
	end

	arg_16_0:_refreshEmptyUI()

	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.RoomCritterTrainHas, 0) then
		RedDotRpc.instance:sendGetRedDotInfosRequest({
			RedDotEnum.DotNode.RoomCritterTrainHas
		})
	end
end

function var_0_0.onClose(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._onRunCdTimeTask, arg_17_0)
	arg_17_0._dropCritterSort:RemoveOnValueChanged()
	arg_17_0._dropHeroSort:RemoveOnValueChanged()

	local var_17_0 = RoomCameraController.instance:getRoomScene()

	if var_17_0 then
		var_17_0.cameraFollow:setFollowTarget(nil)
	end

	RoomCritterController.instance:setInteractionParam(nil)
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

var_0_0._sortAttrIdKey = "RoomCritterTrainView._sortAttrIdKey"

function var_0_0._initSortFilter(arg_19_0)
	arg_19_0._critterOptions = {}

	local var_19_0 = {}

	arg_19_0._selectAttrId = RoomTrainCritterListModel.instance:getSortAttrId()
	arg_19_0._isHightToLow = true

	local var_19_1 = 0

	tabletool.addValues(arg_19_0._critterOptions, lua_critter_attribute.configList)

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._critterOptions) do
		if iter_19_1.id == arg_19_0._selectAttrId then
			var_19_1 = iter_19_0 - 1
		end

		table.insert(var_19_0, iter_19_1.name)
	end

	arg_19_0:_setSortIndex(var_19_1, arg_19_0._isHightToLow)
	arg_19_0._dropCritterSort:ClearOptions()
	arg_19_0._dropCritterSort:AddOptions(var_19_0)
	arg_19_0._dropCritterSort:SetValue(var_19_1)
	arg_19_0._dropCritterSort:AddOnValueChanged(arg_19_0._onCritterDropValueChanged, arg_19_0)
	arg_19_0._dropHeroSort:ClearOptions()
	arg_19_0._dropHeroSort:AddOptions(var_19_0)
	arg_19_0._dropHeroSort:SetValue(var_19_1)
	arg_19_0._dropHeroSort:AddOnValueChanged(arg_19_0._onHeroDropValueChanged, arg_19_0)
	arg_19_0:_refreshFilterUI()
end

function var_0_0._refreshFilterUI(arg_20_0)
	local var_20_0 = arg_20_0.filterMO and arg_20_0.filterMO:isFiltering()

	gohelper.setActive(arg_20_0._gocritterfilter, var_20_0)
	gohelper.setActive(arg_20_0._gonocritterfilter, not var_20_0)
	gohelper.setActive(arg_20_0._goherofilter, var_20_0)
	gohelper.setActive(arg_20_0._gonoherofilter, not var_20_0)

	local var_20_1 = arg_20_0._isHightToLow and -1 or 1

	transformhelper.setLocalScale(arg_20_0._gocritterArrowTrs, 1, var_20_1, 1)
	transformhelper.setLocalScale(arg_20_0._goheroArrowTrs, 1, var_20_1, 1)
	arg_20_0:_refreshEmptyUI()
end

function var_0_0._refreshEmptyUI(arg_21_0)
	return
end

function var_0_0._setSortIndex(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0._lastCritterIndex == arg_22_1 and arg_22_0._isLastHightToLow == arg_22_2 then
		return
	end

	arg_22_0._lastCritterIndex = arg_22_1
	arg_22_0._isLastHightToLow = arg_22_2
	arg_22_0._isHightToLow = arg_22_2

	local var_22_0 = arg_22_0._critterOptions[arg_22_1 + 1]

	if var_22_0 then
		arg_22_0._selectAttrId = var_22_0.id

		RoomTrainCritterListModel.instance:sortByAttrId(arg_22_0._selectAttrId, arg_22_0._isHightToLow)
		RoomTrainHeroListModel.instance:sortByAttrId(arg_22_0._selectAttrId, arg_22_0._isHightToLow)
		RoomTrainCritterListModel.instance:onModelUpdate()
		RoomTrainHeroListModel.instance:onModelUpdate()
	end
end

function var_0_0._onCritterDropValueChanged(arg_23_0, arg_23_1)
	arg_23_0:_setSortIndex(arg_23_1, arg_23_0._isHightToLow)
	arg_23_0._dropHeroSort:SetValue(arg_23_1)
end

function var_0_0._onHeroDropValueChanged(arg_24_0, arg_24_1)
	arg_24_0:_setSortIndex(arg_24_1, arg_24_0._isHightToLow)
	arg_24_0._dropCritterSort:SetValue(arg_24_1)
end

function var_0_0._onRunCdTimeTask(arg_25_0)
	if arg_25_0.viewContainer and arg_25_0.viewContainer:isOpen() then
		arg_25_0.viewContainer:dispatchEvent(CritterEvent.UITrainCdTime)
	else
		TaskDispatcher.cancelTask(arg_25_0._onRunCdTimeTask, arg_25_0)
	end
end

function var_0_0._selectSubView(arg_26_0, arg_26_1)
	arg_26_1 = arg_26_1 or arg_26_0._TrainSubViewID.SlotSub
	arg_26_0._curSubTagIdx = arg_26_1

	for iter_26_0 = 1, #arg_26_0._subGOList do
		gohelper.setActive(arg_26_0._subGOList[iter_26_0], iter_26_0 == arg_26_1)
	end
end

function var_0_0._setSelectSlotMO(arg_27_0, arg_27_1)
	arg_27_0._selectHeroId = nil
	arg_27_0._trainHeroId = nil
	arg_27_0._trainCritterUid = nil
	arg_27_0._selectCritterUid = nil
	arg_27_0._selectSlotMO = arg_27_1
	arg_27_0._selectSlotId = arg_27_1 and arg_27_1.id

	local var_27_0 = arg_27_1 and arg_27_1.critterMO

	if var_27_0 then
		arg_27_0._trainCritterUid = var_27_0.id
		arg_27_0._trainHeroId = var_27_0.trainInfo.heroId
		arg_27_0._selectCritterUid = var_27_0.id
		arg_27_0._selectHeroId = var_27_0.trainInfo.heroId
	end
end

function var_0_0._onSelectSlotItem(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = (arg_28_1 and arg_28_1.critterMO and arg_28_1.critterMO.id) == nil

	arg_28_0:_setSelectSlotMO(arg_28_1)
	RoomTrainSlotListModel.instance:setSelect(arg_28_1.id)
	RoomTrainHeroListModel.instance:setSelect(nil)
	RoomTrainCritterListModel.instance:setSelect(nil)
	arg_28_0:setShowSubSelectView(var_28_0, arg_28_2)
end

function var_0_0._onSelectCritterItem(arg_29_0, arg_29_1)
	if arg_29_0._selectCritterUid ~= arg_29_1.id then
		arg_29_0._selectCritterUid = arg_29_1.id

		RoomTrainCritterListModel.instance:setSelect(arg_29_1.id)
		arg_29_0:setShowSubSelectView(true)
		RoomTrainHeroListModel.instance:updateHeroList()
	end
end

function var_0_0._onSelectHeroItem(arg_30_0, arg_30_1)
	arg_30_0._selectHeroMO = arg_30_1

	if arg_30_0._selectHeroId ~= arg_30_1.id then
		arg_30_0._selectHeroId = arg_30_1.id

		RoomTrainHeroListModel.instance:setSelect(arg_30_1.id)
		arg_30_0:setShowSubSelectView(true)
		RoomTrainCritterListModel.instance:updateCritterList()
	end
end

function var_0_0._onChangeTrainCritter(arg_31_0, arg_31_1)
	arg_31_0:_setSelectSlotMO(arg_31_1)
	RoomTrainHeroListModel.instance:setSelect(arg_31_0._selectCritterUid)
	RoomTrainCritterListModel.instance:setSelect(arg_31_0._selectHeroId)
	arg_31_0:setShowSubSelectView(true)
	RoomTrainHeroListModel.instance:updateHeroList()
	RoomTrainCritterListModel.instance:updateCritterList()
end

function var_0_0._onTrainGoBack(arg_32_0)
	arg_32_0:_setSelectSlotMO(arg_32_0._selectSlotMO)
	RoomTrainHeroListModel.instance:setSelect(nil)
	RoomTrainCritterListModel.instance:setSelect(nil)
	arg_32_0:setShowSubSelectView(false, true)
end

function var_0_0._onTrainStartTrainCritterReply(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0:_updateSelectReply(arg_33_1)
end

function var_0_0._onTrainFinishTrainCritterReply(arg_34_0, arg_34_1)
	arg_34_0:_updateSelectReply(arg_34_1, true)
end

function var_0_0._onTrainCancelTrainReply(arg_35_0, arg_35_1)
	arg_35_0:_updateSelectReply(arg_35_1)
end

function var_0_0._onTradeLevelChange(arg_36_0)
	RoomTrainSlotListModel.instance:updateSlotList()
end

function var_0_0._onCritterInfoPushUpdate(arg_37_0)
	RoomTrainCritterListModel.instance:updateCritterList()
end

function var_0_0._udateCritterAndHeroList(arg_38_0, arg_38_1)
	RoomTrainCritterListModel.instance:updateCritterList()

	if arg_38_1 == true then
		RoomTrainHeroListModel.instance:updateCritterList()
	end
end

function var_0_0._onCritterChangeFilterType(arg_39_0, arg_39_1)
	if arg_39_0.viewName == arg_39_1 then
		RoomTrainHeroListModel.instance:setHeroList(arg_39_0.filterMO)
		RoomTrainCritterListModel.instance:setCritterList(arg_39_0.filterMO)
		arg_39_0:_refreshFilterUI()
	end
end

function var_0_0._updateSelectReply(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_0._selectCritterUid == arg_40_1 and (not arg_40_2 or arg_40_0._trainCritterUid == arg_40_1) then
		if arg_40_0._selectSlotMO then
			arg_40_0.viewContainer:dispatchEvent(CritterEvent.UITrainSelectSlot, arg_40_0._selectSlotMO)
		end

		arg_40_0:setShowSubSelectView(false)
	end

	RoomTrainSlotListModel.instance:onModelUpdate()
	RoomTrainCritterListModel.instance:updateCritterList()
	RoomTrainHeroListModel.instance:updateHeroList()
	arg_40_0:_refreshEmptyUI()
end

function var_0_0.setShowSubSelectView(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_1 and CritterEnum.TrainOPState.PairOP or CritterEnum.TrainOPState.Normal

	arg_41_0:_setOpState(var_41_0)

	local var_41_1 = arg_41_0._trainCritterUid ~= nil

	arg_41_0._isShowSubSelect = arg_41_1

	gohelper.setActive(arg_41_0._gotrainingdetail, not arg_41_1 and var_41_1)
	gohelper.setActive(arg_41_0._gomapui, not arg_41_1 and var_41_1)
	gohelper.setActive(arg_41_0._gotrainselect, arg_41_1)

	if arg_41_1 then
		if not arg_41_0._curSubTagIdx or arg_41_0._curSubTagIdx == arg_41_0._TrainSubViewID.SlotSub then
			arg_41_0:_selectSubView(arg_41_0._TrainSubViewID.CritterSub)
		end
	else
		arg_41_0:_selectSubView(arg_41_0._TrainSubViewID.SlotSub)
	end

	arg_41_0:_refreshTarnBtnUI()

	if arg_41_2 ~= true then
		if arg_41_1 then
			arg_41_0:_followTrainHero(0)
		else
			arg_41_0:_followTrainHero(arg_41_0._trainHeroId or 0)
		end
	end
end

function var_0_0._setOpState(arg_42_0, arg_42_1)
	if arg_42_0.viewContainer and arg_42_0.viewContainer.setContainerTabState then
		if arg_42_0._lastOptate == arg_42_1 then
			return
		end

		arg_42_0._lastOptate = arg_42_1

		arg_42_0.viewContainer:setContainerTabState(RoomCritterBuildingViewContainer.SubViewTabId.Training, arg_42_1)

		if CritterEnum.TrainOPState.Normal == arg_42_1 then
			CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingShowView)
		else
			CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingHideView, true)
		end
	end
end

function var_0_0._refreshTarnBtnUI(arg_43_0)
	local var_43_0 = 0

	if arg_43_0._isShowSubSelect then
		var_43_0 = 1
	else
		local var_43_1, var_43_2 = RoomTrainSlotListModel.instance:getTrarinAndFreeCount()

		if var_43_2 > 0 then
			var_43_0 = 2
			arg_43_0._txtnum.text = string.format("%s/%s", var_43_1, var_43_1 + var_43_2)
		end
	end

	gohelper.setActive(arg_43_0._btntrainstart, var_43_0 == 1)

	if var_43_0 == 1 then
		local var_43_3 = arg_43_0:_getTrainBtnOpState()

		arg_43_0._txttrainstart.text = luaLang(arg_43_0._TrainBtnLang[var_43_3])
	end
end

function var_0_0._getTrainBtnOpState(arg_44_0)
	if arg_44_0._trainCritterUid then
		if arg_44_0._trainCritterUid == arg_44_0._selectCritterUid and arg_44_0._trainHeroId == arg_44_0._selectHeroId then
			local var_44_0 = arg_44_0._selectSlotMO and arg_44_0._selectSlotMO.critterMO

			if var_44_0 and var_44_0.trainInfo:isTrainFinish() then
				return arg_44_0._TrainBtnOpState.FinishTrain
			end

			return arg_44_0._TrainBtnOpState.CancelTrain
		end

		return arg_44_0._TrainBtnOpState.ChangeTrain
	end

	return arg_44_0._TrainBtnOpState.StartNewTrain
end

function var_0_0._followTrainHero(arg_45_0, arg_45_1)
	if arg_45_0.viewContainer:getContainerCurSelectTab() ~= RoomCritterBuildingViewContainer.SubViewTabId.Training then
		RoomCritterController.instance:setInteractionParam(nil)

		return
	end

	arg_45_1 = arg_45_1 or 0

	if arg_45_0._lastFollowHeroId == arg_45_1 then
		return
	end

	local var_45_0 = RoomCameraController.instance:getRoomScene()

	if not var_45_0 then
		return
	end

	arg_45_0._lastFollowHeroId = arg_45_1

	local var_45_1 = var_45_0.charactermgr:getUnit(RoomCharacterEntity:getTag(), arg_45_1)

	if var_45_1 then
		local var_45_2, var_45_3, var_45_4 = transformhelper.getPos(var_45_1.goTrs)
		local var_45_5 = {
			focusX = var_45_2,
			focusY = var_45_4
		}

		var_45_0.cameraFollow._offsetY = var_45_3

		local var_45_6 = RoomEnum.CameraState.ThirdPerson

		var_45_0.camera:setChangeCameraParamsById(var_45_6, RoomEnum.CameraParamId.CritterTrainHeroFollow)
		var_45_0.camera:switchCameraState(var_45_6, var_45_5, nil, arg_45_0._onTweenCameraFollerMoveFinish, arg_45_0)
		var_45_0.cameraFollow:setFollowTarget(var_45_1.cameraFollowTargetComp, false)
		var_45_0.cameraFollow:setIsPass(true)
		RoomCritterController.instance:setInteractionParam(arg_45_0._lastFollowHeroId)
	else
		RoomCritterController.instance:setInteractionParam(nil)

		local var_45_7, var_45_8 = arg_45_0.viewContainer:getContainerViewBuilding()

		if not var_45_8 then
			return
		end

		local var_45_9 = var_45_8.buildingId
		local var_45_10 = ManufactureConfig.instance:getBuildingCameraIdByIndex(var_45_9, arg_45_0.viewContainer:getContainerCurSelectTab())

		if RoomCameraController.instance:getRoomCamera() and var_45_10 then
			RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(var_45_7, var_45_10)
		end
	end
end

function var_0_0._onTweenCameraFollerMoveFinish(arg_46_0)
	if arg_46_0.viewContainer:getContainerCurSelectTab() == RoomCritterBuildingViewContainer.SubViewTabId.Training then
		local var_46_0 = RoomCameraController.instance:getRoomScene()

		if var_46_0 then
			var_46_0.cameraFollow:setIsPass(false)
		end
	end
end

return var_0_0
