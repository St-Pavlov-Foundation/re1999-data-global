module("modules.logic.room.view.critter.RoomCritterTrainEventView", package.seeall)

slot0 = class("RoomCritterTrainEventView", BaseView)

function slot0.onInitView(slot0)
	slot0._goeventitem = gohelper.findChild(slot0.viewGO, "go_content/#go_event_item")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "go_content/#go_event_item/#txt_name")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "go_content/#go_event_item/#txt_num")
	slot0._btnevent = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_content/#go_event_item/#btn_event")
	slot0._gopos41 = gohelper.findChild(slot0.viewGO, "go_content/#go_pos4_1")
	slot0._gopos42 = gohelper.findChild(slot0.viewGO, "go_content/#go_pos4_2")
	slot0._gopos43 = gohelper.findChild(slot0.viewGO, "go_content/#go_pos4_3")
	slot0._gopos44 = gohelper.findChild(slot0.viewGO, "go_content/#go_pos4_4")
	slot0._gorighttopbtns = gohelper.findChild(slot0.viewGO, "#go_righttopbtns")
	slot0._btncurrency = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_righttopbtns/#go_container/currency/#btn_currency")
	slot0._imagecurrency = gohelper.findChildImage(slot0.viewGO, "#go_righttopbtns/#go_container/currency/#image")
	slot0._btnadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_righttopbtns/#go_container/currency/#btn_add")
	slot0._txtcurrency = gohelper.findChildText(slot0.viewGO, "#go_righttopbtns/#go_container/currency/content/#txt")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncurrency:AddClickListener(slot0._btncurrencyOnClick, slot0)
	slot0._btnadd:AddClickListener(slot0._btnaddOnClick, slot0)
	slot0._btnevent:AddClickListener(slot0._btneventOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncurrency:RemoveClickListener()
	slot0._btnadd:RemoveClickListener()
	slot0._btnevent:RemoveClickListener()
end

function slot0._btncurrencyOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.RoomCritterTrain, false, nil, false)
end

function slot0._btnaddOnClick(slot0)
	RoomCritterController.instance:openExchangeView({
		MaterialEnum.MaterialType.Currency,
		CurrencyEnum.CurrencyType.RoomCritterTrain,
		1
	})
end

function slot0._btneventOnClick(slot0)
end

function slot0._refreshCurrency(slot0)
	slot0._txtcurrency.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.RoomCritterTrain).quantity)

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagecurrency, CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.RoomCritterTrain).icon .. "_1")
end

function slot0._editableInitView(slot0)
	slot0._numPostDict = {
		[3] = {
			80,
			0,
			204,
			-41,
			252.8,
			97.4
		}
	}
	slot0._eventIconDict = {
		[203.0] = "room_train_btn_3",
		[202.0] = "room_train_btn_4",
		[201.0] = "room_train_btn_1",
		[CritterEnum.EventType.Special] = "room_train_btn_2",
		[CritterEnum.EventType.ActiveTime] = "room_train_btn_1"
	}
	slot0._eventTbList = slot0:getUserDataTb_()

	for slot5 = 1, #{
		slot0._gopos41,
		slot0._gopos42,
		slot0._gopos43,
		slot0._gopos44
	} do
		table.insert(slot0._eventTbList, slot0:_initCreateTB(gohelper.clone(slot0._goeventitem, slot1[slot5])))
	end

	gohelper.setActive(slot0._goeventitem, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.TrainSelectEventOptionReply, slot0._refreshUI, slot0)
	CurrencyController.instance:registerCallback(CurrencyEvent.CurrencyChange, slot0._refreshCurrency, slot0)

	slot0._critterUid = slot0.viewParam and slot0.viewParam.critterUid

	slot0:_refreshUI()
end

function slot0.onClose(slot0)
	slot4 = slot0._refreshCurrency

	CurrencyController.instance:unregisterCallback(CurrencyEvent.CurrencyChange, slot4, slot0)

	for slot4 = 1, #slot0._eventTbList do
		slot0._eventTbList[slot4]._btnevent:RemoveClickListener()
	end
end

function slot0.onDestroyView(slot0)
end

function slot0._initCreateTB(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2.goTrs = slot1.transform
	slot2._gospecialbg = gohelper.findChild(slot1, "specialbg")
	slot2._gonormalbg = gohelper.findChild(slot1, "normalbg")
	slot2._gonumbg = gohelper.findChild(slot1, "numbg")
	slot2._txtname = gohelper.findChildText(slot1, "#txt_name")
	slot2._txtnum = gohelper.findChildText(slot1, "#txt_num")
	slot2._imageicon = gohelper.findChildImage(slot1, "#image_icon")
	slot2._btnevent = gohelper.findChildButtonWithAudio(slot1, "#btn_event")

	slot2._btnevent:AddClickListener(slot0._onItemEventClick, slot0, slot2)

	slot2._gograyList = {
		slot2._imageicon.gameObject,
		slot2._gospecialbg,
		slot2._gonormalbg,
		slot2._gonumbg
	}
	slot2.eventMO = nil

	return slot2
end

function slot0._refreshTB(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	slot1.eventMO = slot2
	slot1.critterUid = slot3

	if slot2 then
		slot4 = slot2:getEventType() == CritterEnum.EventType.Special
		slot1._txtname.text = slot2:getDefineCfg() and slot5.name
		slot1._txtnum.text = slot2.remainCount

		gohelper.setActive(slot1._gospecialbg, slot4)
		gohelper.setActive(slot1._gonormalbg, not slot4)

		for slot10, slot11 in ipairs(slot1._gograyList) do
			ZProj.UGUIHelper.SetGrayFactor(slot11, slot2:isHasEventAction() and 0 or 1)
		end

		UISpriteSetMgr.instance:setCritterSprite(slot1._imageicon, slot0._eventIconDict[slot5 and slot5.id] or slot0._eventIconDict[CritterEnum.EventType.Special])
	end
end

function slot0._onItemEventClick(slot0, slot1)
	slot2 = slot1.eventMO

	if slot0:getCritterMO() and slot2 and slot2:isHasEventAction() and slot2.activeTime <= slot3.trainInfo:getProcessTime() then
		if not CritterConfig.instance:getCritterTrainEventCfg(slot2.eventId) then
			return
		end

		if slot6 and slot6[3] and slot9 > 0 and ItemModel.instance:getItemQuantity(string.splitToNumber(slot5.cost, "#") and slot6[1], slot6 and slot6[2]) < slot9 then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomCritterTrainItemInsufficiency, MsgBoxEnum.BoxType.Yes_No, slot0._onYesOpenTradeView, nil, , slot0, nil, )

			return
		end

		slot0:closeThis()
		RoomCritterController.instance:startTrain(slot2.eventId, slot0._critterUid, slot3 and slot3.trainInfo.heroId)
	end
end

function slot0._onYesOpenTradeView(slot0)
	GameFacade.jump(JumpEnum.JumpId.RoomStoreTabFluff)
end

function slot0._refreshUI(slot0)
	if not slot0:getCritterMO() or not slot1.trainInfo or slot1.trainInfo:isFinishAllEvent() then
		slot0:closeThis()

		return
	end

	slot0:_refreshEventBnts(slot1.trainInfo.events)
	slot0:_refreshCurrency()
end

function slot0._refreshEventBnts(slot0, slot1)
	slot2 = 0

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			if CritterEnum.NeedActionEventTypeDict[slot7:getEventType()] and slot0:_checkEventMOShow(slot7) then
				slot0:_refreshTB(slot0._eventTbList[slot2 + 1], slot7, slot0._critterUid)
			end
		end
	end

	slot3 = slot0._numPostDict[slot2]

	for slot7 = 1, #slot0._eventTbList do
		gohelper.setActive(slot0._eventTbList[slot7].go, slot7 <= slot2)
		recthelper.setAnchor(slot8.goTrs, slot3 and slot3[2 * slot7 - 1] or 0, slot3 and slot3[2 * slot7] or 0)
	end
end

function slot0._checkEventMOShow(slot0, slot1)
	if slot1:getEventType() == CritterEnum.EventType.Special then
		return slot1:isEventActive()
	end

	return true
end

function slot0.getCritterMO(slot0)
	return CritterModel.instance:getCritterMOByUid(slot0._critterUid)
end

return slot0
