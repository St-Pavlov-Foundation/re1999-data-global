module("modules.logic.room.view.critter.RoomCritterTrainEventView", package.seeall)

local var_0_0 = class("RoomCritterTrainEventView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goeventitem = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_event_item")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "go_content/#go_event_item/#txt_name")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "go_content/#go_event_item/#txt_num")
	arg_1_0._btnevent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_content/#go_event_item/#btn_event")
	arg_1_0._gopos41 = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_pos4_1")
	arg_1_0._gopos42 = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_pos4_2")
	arg_1_0._gopos43 = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_pos4_3")
	arg_1_0._gopos44 = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_pos4_4")
	arg_1_0._gorighttopbtns = gohelper.findChild(arg_1_0.viewGO, "#go_righttopbtns")
	arg_1_0._btncurrency = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_righttopbtns/#go_container/currency/#btn_currency")
	arg_1_0._imagecurrency = gohelper.findChildImage(arg_1_0.viewGO, "#go_righttopbtns/#go_container/currency/#image")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_righttopbtns/#go_container/currency/#btn_add")
	arg_1_0._txtcurrency = gohelper.findChildText(arg_1_0.viewGO, "#go_righttopbtns/#go_container/currency/content/#txt")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncurrency:AddClickListener(arg_2_0._btncurrencyOnClick, arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
	arg_2_0._btnevent:AddClickListener(arg_2_0._btneventOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncurrency:RemoveClickListener()
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btnevent:RemoveClickListener()
end

function var_0_0._btncurrencyOnClick(arg_4_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.RoomCritterTrain, false, nil, false)
end

function var_0_0._btnaddOnClick(arg_5_0)
	local var_5_0 = {
		MaterialEnum.MaterialType.Currency,
		CurrencyEnum.CurrencyType.RoomCritterTrain,
		1
	}

	RoomCritterController.instance:openExchangeView(var_5_0)
end

function var_0_0._btneventOnClick(arg_6_0)
	return
end

function var_0_0._refreshCurrency(arg_7_0)
	local var_7_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.RoomCritterTrain)
	local var_7_1 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.RoomCritterTrain)

	arg_7_0._txtcurrency.text = GameUtil.numberDisplay(var_7_0.quantity)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_7_0._imagecurrency, var_7_1.icon .. "_1")
end

function var_0_0._editableInitView(arg_8_0)
	local var_8_0 = {
		arg_8_0._gopos41,
		arg_8_0._gopos42,
		arg_8_0._gopos43,
		arg_8_0._gopos44
	}

	arg_8_0._numPostDict = {
		[3] = {
			80,
			0,
			204,
			-41,
			252.8,
			97.4
		}
	}
	arg_8_0._eventIconDict = {
		[203] = "room_train_btn_3",
		[202] = "room_train_btn_4",
		[201] = "room_train_btn_1",
		[CritterEnum.EventType.Special] = "room_train_btn_2",
		[CritterEnum.EventType.ActiveTime] = "room_train_btn_1"
	}
	arg_8_0._eventTbList = arg_8_0:getUserDataTb_()

	for iter_8_0 = 1, #var_8_0 do
		local var_8_1 = gohelper.clone(arg_8_0._goeventitem, var_8_0[iter_8_0])

		table.insert(arg_8_0._eventTbList, arg_8_0:_initCreateTB(var_8_1))
	end

	gohelper.setActive(arg_8_0._goeventitem, false)
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:addEventCb(CritterController.instance, CritterEvent.TrainSelectEventOptionReply, arg_10_0._refreshUI, arg_10_0)
	CurrencyController.instance:registerCallback(CurrencyEvent.CurrencyChange, arg_10_0._refreshCurrency, arg_10_0)

	arg_10_0._critterUid = arg_10_0.viewParam and arg_10_0.viewParam.critterUid

	arg_10_0:_refreshUI()
end

function var_0_0.onClose(arg_11_0)
	CurrencyController.instance:unregisterCallback(CurrencyEvent.CurrencyChange, arg_11_0._refreshCurrency, arg_11_0)

	for iter_11_0 = 1, #arg_11_0._eventTbList do
		arg_11_0._eventTbList[iter_11_0]._btnevent:RemoveClickListener()
	end
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

function var_0_0._initCreateTB(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getUserDataTb_()

	var_13_0.go = arg_13_1
	var_13_0.goTrs = arg_13_1.transform
	var_13_0._gospecialbg = gohelper.findChild(arg_13_1, "specialbg")
	var_13_0._gonormalbg = gohelper.findChild(arg_13_1, "normalbg")
	var_13_0._gonumbg = gohelper.findChild(arg_13_1, "numbg")
	var_13_0._txtname = gohelper.findChildText(arg_13_1, "#txt_name")
	var_13_0._txtnum = gohelper.findChildText(arg_13_1, "#txt_num")
	var_13_0._imageicon = gohelper.findChildImage(arg_13_1, "#image_icon")
	var_13_0._btnevent = gohelper.findChildButtonWithAudio(arg_13_1, "#btn_event")

	var_13_0._btnevent:AddClickListener(arg_13_0._onItemEventClick, arg_13_0, var_13_0)

	var_13_0._gograyList = {
		var_13_0._imageicon.gameObject,
		var_13_0._gospecialbg,
		var_13_0._gonormalbg,
		var_13_0._gonumbg
	}
	var_13_0.eventMO = nil

	return var_13_0
end

function var_0_0._refreshTB(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if not arg_14_1 then
		return
	end

	arg_14_1.eventMO = arg_14_2
	arg_14_1.critterUid = arg_14_3

	if arg_14_2 then
		local var_14_0 = arg_14_2:getEventType() == CritterEnum.EventType.Special
		local var_14_1 = arg_14_2:getDefineCfg()

		arg_14_1._txtname.text = var_14_1 and var_14_1.name
		arg_14_1._txtnum.text = arg_14_2.remainCount

		gohelper.setActive(arg_14_1._gospecialbg, var_14_0)
		gohelper.setActive(arg_14_1._gonormalbg, not var_14_0)

		local var_14_2 = arg_14_2:isHasEventAction() and 0 or 1

		for iter_14_0, iter_14_1 in ipairs(arg_14_1._gograyList) do
			ZProj.UGUIHelper.SetGrayFactor(iter_14_1, var_14_2)
		end

		local var_14_3 = var_14_1 and var_14_1.id
		local var_14_4 = arg_14_0._eventIconDict[var_14_3] or arg_14_0._eventIconDict[CritterEnum.EventType.Special]

		UISpriteSetMgr.instance:setCritterSprite(arg_14_1._imageicon, var_14_4)
	end
end

function var_0_0._onItemEventClick(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.eventMO
	local var_15_1 = arg_15_0:getCritterMO()

	if var_15_1 and var_15_0 and var_15_0:isHasEventAction() and var_15_1.trainInfo:getProcessTime() >= var_15_0.activeTime then
		local var_15_2 = CritterConfig.instance:getCritterTrainEventCfg(var_15_0.eventId)

		if not var_15_2 then
			return
		end

		local var_15_3 = string.splitToNumber(var_15_2.cost, "#")
		local var_15_4 = var_15_3 and var_15_3[1]
		local var_15_5 = var_15_3 and var_15_3[2]
		local var_15_6 = var_15_3 and var_15_3[3]

		if var_15_6 and var_15_6 > 0 and var_15_6 > ItemModel.instance:getItemQuantity(var_15_4, var_15_5) then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomCritterTrainItemInsufficiency, MsgBoxEnum.BoxType.Yes_No, arg_15_0._onYesOpenTradeView, nil, nil, arg_15_0, nil, nil)

			return
		end

		arg_15_0:closeThis()

		local var_15_7 = var_15_1 and var_15_1.trainInfo.heroId

		RoomCritterController.instance:startTrain(var_15_0.eventId, arg_15_0._critterUid, var_15_7)
	end
end

function var_0_0._onYesOpenTradeView(arg_16_0)
	GameFacade.jump(JumpEnum.JumpId.RoomStoreTabFluff)
end

function var_0_0._refreshUI(arg_17_0)
	local var_17_0 = arg_17_0:getCritterMO()

	if not var_17_0 or not var_17_0.trainInfo or var_17_0.trainInfo:isFinishAllEvent() then
		arg_17_0:closeThis()

		return
	end

	arg_17_0:_refreshEventBnts(var_17_0.trainInfo.events)
	arg_17_0:_refreshCurrency()
end

function var_0_0._refreshEventBnts(arg_18_0, arg_18_1)
	local var_18_0 = 0

	if arg_18_1 then
		for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
			if CritterEnum.NeedActionEventTypeDict[iter_18_1:getEventType()] and arg_18_0:_checkEventMOShow(iter_18_1) then
				var_18_0 = var_18_0 + 1

				local var_18_1 = arg_18_0._eventTbList[var_18_0]

				arg_18_0:_refreshTB(var_18_1, iter_18_1, arg_18_0._critterUid)
			end
		end
	end

	local var_18_2 = arg_18_0._numPostDict[var_18_0]

	for iter_18_2 = 1, #arg_18_0._eventTbList do
		local var_18_3 = arg_18_0._eventTbList[iter_18_2]

		gohelper.setActive(var_18_3.go, iter_18_2 <= var_18_0)

		local var_18_4 = var_18_2 and var_18_2[2 * iter_18_2 - 1] or 0
		local var_18_5 = var_18_2 and var_18_2[2 * iter_18_2] or 0

		recthelper.setAnchor(var_18_3.goTrs, var_18_4, var_18_5)
	end
end

function var_0_0._checkEventMOShow(arg_19_0, arg_19_1)
	if arg_19_1:getEventType() == CritterEnum.EventType.Special then
		return arg_19_1:isEventActive()
	end

	return true
end

function var_0_0.getCritterMO(arg_20_0)
	return CritterModel.instance:getCritterMOByUid(arg_20_0._critterUid)
end

return var_0_0
