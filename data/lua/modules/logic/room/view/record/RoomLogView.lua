module("modules.logic.room.view.record.RoomLogView", package.seeall)

slot0 = class("RoomLogView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnbook = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_book")
	slot0._gohandbookreddot = gohelper.findChild(slot0.viewGO, "root/#btn_book/#go_handbookreddot")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_task")
	slot0._gotaskreddot = gohelper.findChild(slot0.viewGO, "root/#btn_task/#go_taskreddot")
	slot0._txtleftpages = gohelper.findChildText(slot0.viewGO, "root/#txt_leftpages")
	slot0._txtrightpages = gohelper.findChildText(slot0.viewGO, "root/#txt_rightpages")
	slot0._btnback = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_back")
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_next")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_reward")
	slot0._gobookContent = gohelper.findChild(slot0.viewGO, "root/content")
	slot0._gobookItem = gohelper.findChild(slot0.viewGO, "root/content/bookitem")
	slot0._gopool = gohelper.findChild(slot0.viewGO, "pool")
	slot0._goleftempty = gohelper.findChild(slot0.viewGO, "root/#go_leftempty")
	slot0._gorightempty = gohelper.findChild(slot0.viewGO, "root/#go_rightempty")
	slot0._gorewardreddot = gohelper.findChild(slot0.viewGO, "root/#btn_reward/#go_rewardreddot")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._leftContentHeight = 740
	slot0._rightContentHeight = 925.7935
	slot0._singleTextHeight = 37.1
	slot0._itemspace = 40
	slot0._contentHeight = 0
	slot0._isLeftFull = false
	slot0._isRightFull = false
	slot0._itempool = {}
	slot0._itemList = {}
	slot0._leftItemList = {}
	slot0._rightItemList = {}
	slot0._moIndex = 1
	slot0._pageToMo = {}
	slot0._curCreateBookItem = nil
	slot0._bookItemTab = {}
	slot0._bookPage = 1

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbook:AddClickListener(slot0._btnbookOnClick, slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
	slot0._btnback:AddClickListener(slot0._btnbackOnClick, slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0:addEventCb(RoomTradeController.instance, RoomTradeEvent.OnGetTradeTaskExtraBonusReply, slot0.refreshBtn, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbook:RemoveClickListener()
	slot0._btntask:RemoveClickListener()
	slot0._btnback:RemoveClickListener()
	slot0._btnnext:RemoveClickListener()
	slot0._btnreward:RemoveClickListener()
	slot0:removeEventCb(RoomTradeController.instance, RoomTradeEvent.OnGetTradeTaskExtraBonusReply, slot0.refreshBtn, slot0)
end

function slot0._btnbookOnClick(slot0)
	RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
		animName = RoomRecordEnum.AnimName.Log2HandBook,
		view = RoomRecordEnum.View.HandBook
	})
end

function slot0._btntaskOnClick(slot0)
	RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
		animName = RoomRecordEnum.AnimName.Log2Task,
		view = RoomRecordEnum.View.Task
	})
end

function slot0._btnbackOnClick(slot0)
	slot0._bookPage = slot0._bookPage - 1

	slot0._animator:Play("switch", 0, 0)
	slot0:refreshUI()
end

function slot0._btnrewardOnClick(slot0)
	RoomRpc.instance:sendGetTradeTaskExtraBonusRequest()
end

function slot0.refreshBtn(slot0)
	gohelper.setActive(slot0._btnreward.gameObject, RoomTradeTaskModel.instance:getCanGetExtraBonus())
end

function slot0._btnnextOnClick(slot0)
	slot0._bookPage = slot0._bookPage + 1

	if slot0._moIndex ~= #slot0._molist then
		slot0._moIndex = slot0._moIndex + 1
	end

	slot0._animator:Play("switch", 0, 0)
	slot0:refreshUI()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._molist = RoomLogModel.instance:getInfos()
	slot1 = false

	if not slot0._molist or #slot0._molist == 0 then
		slot1 = true
	end

	gohelper.setActive(slot0._gobookContent, not slot1)
	gohelper.setActive(slot0._goleftempty, slot1)
	gohelper.setActive(slot0._gorightempty, slot1)

	if not slot1 then
		slot0:updateView()
		slot0:refreshBtn()
	end

	RedDotController.instance:addRedDot(slot0._gotaskreddot, RedDotEnum.DotNode.TradeTask)
	RedDotController.instance:addRedDot(slot0._gorewardreddot, RedDotEnum.DotNode.StrikerReward)
	RedDotController.instance:addRedDot(slot0._gohandbookreddot, RedDotEnum.DotNode.CritterHandBook)
end

function slot0.updateView(slot0)
	gohelper.setActive(slot0._goleftempty, false)
	gohelper.setActive(slot0._gorightempty, false)

	if not slot0:createBookItem().isFull then
		slot0:buildLogItem(slot0._molist[slot0._moIndex], slot0._moIndex)

		if not slot0._rightItemList[slot1.page] then
			gohelper.setActive(slot1.goempty, true)
		end
	end

	for slot5, slot6 in ipairs(slot0._bookItemTab) do
		gohelper.setActive(slot6.go, slot6.page == slot0._bookPage)
	end

	if slot0._bookPage == 1 then
		gohelper.setActive(slot0._btnback.gameObject, false)

		if slot0._moIndex ~= #slot0._molist then
			gohelper.setActive(slot0._btnnext.gameObject, true)
		end
	else
		gohelper.setActive(slot0._btnback.gameObject, true)
	end

	if slot0._bookPage ~= #slot0._bookItemTab then
		gohelper.setActive(slot0._btnnext.gameObject, true)
	elseif slot0._moIndex == #slot0._molist then
		gohelper.setActive(slot0._btnnext.gameObject, false)
	end

	slot0._txtleftpages.text = slot0._bookPage * 2 - 1
	slot0._txtrightpages.text = slot0._bookPage * 2
end

function slot0.createBookItem(slot0)
	if not slot0._bookItemTab[slot0._bookPage] then
		slot1 = slot0:getUserDataTb_()
		slot1.page = slot0._bookPage
		slot1.go = gohelper.cloneInPlace(slot0._gobookItem, "bookItem" .. slot0._bookPage)
		slot1.goLeft = gohelper.findChild(slot1.go, "left/content")
		slot1.goRight = gohelper.findChild(slot1.go, "right/content")
		slot1.goempty = gohelper.findChild(slot1.go, "#go_empty")

		gohelper.setActive(slot1.go, true)

		slot0._bookItemTab[slot0._bookPage] = slot1
		slot0._curCreateBookItem = slot1
	end

	return slot1
end

function slot0.createLogItem(slot0)
	if slot0._molist[slot0._moIndex] then
		slot0:buildLogItem(slot1, slot0._moIndex)
	end
end

function slot0.checkContinue(slot0)
	if slot0._curCreateBookItem.isFull then
		return false
	end

	if slot0._isLeftFull and slot0._isRightFull then
		return false
	end

	if tabletool.len(slot0._molist) <= slot0._moIndex then
		return false
	end

	return true
end

function slot0.buildLogItem(slot0, slot1, slot2)
	slot3 = slot0:createOrGetItem()
	slot3.mo = slot1
	slot3.index = slot2
	slot0.localContentHeight = 0

	if slot1.type == RoomRecordEnum.LogType.Normal then
		slot3 = slot0:buildNoramlItem(slot3, slot1, slot2)
	elseif slot1.type == RoomRecordEnum.LogType.Speical then
		slot3 = slot0:buildSpeicalItem(slot3, slot1, slot2)
	elseif slot1.type == RoomRecordEnum.LogType.Custom then
		slot3 = slot0:buildCustomItem(slot3, slot1, slot2)
	elseif slot1.type == RoomRecordEnum.LogType.Time then
		slot3 = slot0:buildTimeItem(slot3, slot1, slot2)
	end

	if slot3 then
		slot0:setParent(slot3)
		slot0:checkSingleItemHeightIsFull()
	end

	if slot0:checkContinue() then
		slot0._moIndex = slot0._moIndex + 1

		slot0:createLogItem()
	else
		slot0._curCreateBookItem.isFull = true
	end
end

function slot0.buildNoramlItem(slot0, slot1, slot2, slot3)
	if slot0:handleType(slot1, slot2) then
		gohelper.setActive(gohelper.findChild(slot4, "timebg"), not slot2.isclone)
		gohelper.setActive(gohelper.findChild(slot4, "icon"), not slot2.isclone)

		gohelper.findChildText(slot4, "timebg/#txt_time").text = slot2.timestr
		slot1.cscontent = gohelper.findChild(slot4, "#scroll_details/Viewport/Content"):GetComponent(gohelper.Type_VerticalLayoutGroup)
		slot10 = gohelper.findChild(slot4, "#scroll_details/Viewport/Content/logitem")

		if slot2.content then
			gohelper.setActive(slot10, true)

			slot12 = gohelper.findChildText(slot10, "#txt_log")

			gohelper.setActive(gohelper.findChild(slot10, "icon"), not slot2.isclone)

			slot12.text = slot2.content

			ZProj.UGUIHelper.RebuildLayout(slot8.transform)
			slot0:checkSingleItemHeightIsFull(true)

			if slot0:checkAndHandleOverText(slot2, slot1.index, nil, slot9, false, slot12) then
				ZProj.UGUIHelper.RebuildLayout(slot8.transform)
			else
				slot0:resetFunc(slot1)
				gohelper.destroy(slot1.go)

				slot1 = nil

				if not slot0._isLeftFull then
					slot0._isLeftFull = true
				else
					slot0._isRightFull = true
				end

				return false
			end
		end

		slot1.preferredHeight = slot9.preferredHeight
	end

	return slot1
end

function slot0.buildSpeicalItem(slot0, slot1, slot2, slot3)
	if slot0:handleType(slot1, slot2) then
		gohelper.findChildText(slot4, "timebg/#txt_time").text = slot2.timestr

		gohelper.setActive(gohelper.findChild(slot4, "timebg"), not slot2.isclone)
		gohelper.setActive(gohelper.findChild(slot4, "icon"), not slot2.isclone)

		slot1.cscontent = slot1.go:GetComponent(gohelper.Type_VerticalLayoutGroup)
		slot9 = gohelper.findChild(slot4, "#scroll_details/Viewport/Content/logitem")

		if slot2.logConfigList and #slot2.logConfigList > 0 then
			slot10 = slot0:getUserDataTb_()

			for slot14, slot15 in ipairs(slot2.logConfigList) do
				slot16 = gohelper.cloneInPlace(slot9, "speicalLog" .. slot14)

				gohelper.setActive(slot16, true)

				gohelper.findChildText(slot16, "#txt_log").text = "<color=#A14114>" .. slot15.speaker .. "</color>" .. ":" .. slot15.content

				ZProj.UGUIHelper.RebuildLayout(slot16.transform)
				ZProj.UGUIHelper.RebuildLayout(slot1.go.transform)

				if not slot0:checkSingleItemHeightIsFull(false, slot16:GetComponent(gohelper.Type_HorizontalLayoutGroup).preferredHeight) then
					gohelper.destroy(slot16)

					break
				end

				if slot0:checkAndHandleOverText(slot2, slot1.index, slot14, slot8, true, slot20) then
					table.insert(slot10, slot16)
				else
					gohelper.destroy(slot16)

					break
				end
			end

			slot1.logList = slot10
		end

		if not slot1.logList or not next(slot1.logList) then
			slot0:resetFunc(slot1)
			gohelper.destroy(slot1.go)

			slot1 = nil

			return false
		end

		ZProj.UGUIHelper.RebuildLayout(slot1.go.transform)

		slot1.preferredHeight = slot8.preferredHeight
	end

	return slot1
end

function slot0.buildCustomItem(slot0, slot1, slot2, slot3)
	slot5 = slot0._isLeftFull and slot0._rightContentHeight or slot0._leftContentHeight
	slot6 = slot2.num or math.random(1, 2)

	if slot0:handleType(slot1, slot2) then
		slot7 = slot0:getUserDataTb_()

		for slot11 = 1, 2 do
			gohelper.setActive(gohelper.findChild(slot4, "#scroll_details/image_detailsbg" .. slot11), false)
		end

		slot7.num = slot6
		slot8 = gohelper.findChild(slot4, "#scroll_details/image_detailsbg" .. slot6)
		slot9 = gohelper.findChild(slot8, "dec")
		slot10 = gohelper.findChild(slot8, "dec/icon")
		slot11 = gohelper.findChild(slot8, "timebg")
		gohelper.findChildText(slot8, "timebg/#txt_time").text = slot2.timestr

		gohelper.setActive(slot8, true)

		slot7.simagesticker = gohelper.findChildSingleImage(slot4, "#scroll_details/#simage_stickers")
		slot7.simagesignature = gohelper.findChildSingleImage(slot4, "#scroll_details/#simage_signature")
		slot14 = gohelper.findChild(slot4, "#scroll_details/Viewport/Content/logitem")
		gohelper.findChildText(slot4, "#scroll_details/#txt_name").text = slot2.name
		slot17 = slot2.config.icon

		if string.split(slot2.config.extraBonus, "#")[2] then
			slot7.simagesticker:LoadImage(ResUrl.getPropItemIcon(slot16))
		end

		if slot17 then
			slot7.simagesignature:LoadImage(ResUrl.getSignature("characterget/" .. slot17))
		end

		gohelper.setActive(slot10, not slot2.isclone)
		gohelper.setActive(slot9, not slot2.isclone)
		gohelper.setActive(slot11, not slot2.isclone)
		gohelper.setActive(slot7.simagesticker.gameObject, not slot2.isclone)
		gohelper.setActive(slot13.gameObject, not slot2.isclone)

		slot1.cscontent = slot1.go:GetComponent(gohelper.Type_VerticalLayoutGroup)

		if slot2.logConfigList and #slot2.logConfigList > 0 then
			slot19 = slot0:getUserDataTb_()

			for slot23, slot24 in ipairs(slot2.logConfigList) do
				slot25 = gohelper.cloneInPlace(slot14, "customLog" .. slot23)

				gohelper.setActive(slot25, true)

				slot27 = gohelper.findChildText(slot25, "#txt_log")
				slot27.text = slot24.content

				ZProj.UGUIHelper.RebuildLayout(slot25.transform)
				ZProj.UGUIHelper.RebuildLayout(slot1.go.transform)
				slot0:checkSingleItemHeightIsFull(false, slot25:GetComponent(gohelper.Type_VerticalLayoutGroup).preferredHeight)

				if slot0:checkAndHandleOverText(slot2, slot1.index, slot23, slot18, true, slot27, slot7) then
					table.insert(slot19, slot25)
				else
					gohelper.destroy(slot25)

					break
				end
			end

			slot1.logList = slot19
		end

		if not slot1.logList or not next(slot1.logList) then
			slot0:resetFunc(slot1)
			gohelper.destroy(slot1.go)

			slot1 = nil

			return false
		end

		ZProj.UGUIHelper.RebuildLayout(slot1.go.transform)

		slot1.preferredHeight = slot18.preferredHeight
	end

	return slot1
end

function slot0.buildTimeItem(slot0, slot1, slot2, slot3)
	if slot0:handleType(slot1, slot2) then
		slot5 = slot1.go:GetComponent(gohelper.Type_VerticalLayoutGroup)
		slot1.cscontent = slot5
		gohelper.findChildText(slot4, "bg/#txt_time").text = luaLang("weekday" .. tonumber(slot2.day))

		ZProj.UGUIHelper.RebuildLayout(slot1.go.transform)

		slot1.preferredHeight = slot5.preferredHeight

		if not slot0:checkSingleItemHeightIsFull(false, slot1.preferredHeight) then
			table.insert(slot0._molist, slot3 + 1, slot2)
			slot0:resetFunc(slot1)
			gohelper.destroy(slot1.go)

			slot1 = nil

			return false
		end
	end

	return slot1
end

function slot0.checkSingleItemHeightIsFull(slot0, slot1, slot2)
	if not slot0._isLeftFull then
		if 16 + (slot2 or slot0._singleTextHeight) + 16 + (slot1 and 40 or 0) > slot0._leftContentHeight - slot0._contentHeight then
			slot0._isLeftFull = true

			return false
		end
	elseif not slot0._isRightFull and slot3 + slot6 + slot4 + slot5 > slot0._rightContentHeight - slot0._contentHeight then
		slot0._isRightFull = true

		return false
	end

	return true
end

function slot0.handleType(slot0, slot1, slot2)
	slot3 = nil

	for slot7, slot8 in ipairs(slot1.gotypelist) do
		if slot7 == slot2.type then
			gohelper.setActive(slot8, true)

			slot3 = slot8
		else
			gohelper.setActive(slot8, false)
		end
	end

	return slot3
end

function slot0.createOrGetItem(slot0)
	if not nil then
		slot1 = slot0:getUserDataTb_()
		slot1.go = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[3], slot0._isLeftFull and slot0._curCreateBookItem.goRight or slot0._curCreateBookItem.goLeft, "item")
		slot1.gotypelist = {}

		for slot7 = 1, 4 do
			table.insert(slot1.gotypelist, gohelper.findChild(slot1.go, "type" .. slot7))
		end
	end

	gohelper.setActive(slot1.go, true)

	return slot1
end

function slot0.setParent(slot0, slot1)
	slot3 = slot0._isLeftFull and slot0._rightContentHeight or slot0._leftContentHeight
	slot0._contentHeight = slot0:calculateHeight(not slot0._isLeftFull and true or false)

	function slot0.checkfunc(slot0)
		if uv1 < uv0._contentHeight + slot0.preferredHeight then
			if slot0.logList and #slot0.logList > 1 then
				gohelper.destroy(table.remove(slot0.logList))
				ZProj.UGUIHelper.RebuildLayout(slot0.go.transform)

				slot0.preferredHeight = slot0.cscontent.preferredHeight

				uv0.checkfunc(slot0, uv0)
			else
				if uv2 then
					uv0._isLeftFull = true
				else
					uv0._isRightFull = true
				end

				uv0._contentHeight = 0

				uv0:resetFunc(slot0)

				slot0 = nil
			end
		elseif uv2 then
			slot0.go.transform:SetParent(uv0._curCreateBookItem.goLeft.transform)

			uv0._leftItemList[uv0._bookPage] = uv0._leftItemList[uv0._bookPage] or {}

			table.insert(uv0._leftItemList[uv0._bookPage], slot0)

			uv0._pageToMo[uv0._bookPage] = uv0._pageToMo[uv0._bookPage] or {}
			uv0._pageToMo[uv0._bookPage][slot0.index] = slot0.mo
			uv0._contentHeight = uv0:calculateHeight(true)
		else
			slot0.go.transform:SetParent(uv0._curCreateBookItem.goRight.transform)

			uv0._rightItemList[uv0._bookPage] = uv0._rightItemList[uv0._bookPage] or {}

			table.insert(uv0._rightItemList[uv0._bookPage], slot0)

			uv0._pageToMo[uv0._bookPage][slot0.index] = slot0.mo
			uv0._contentHeight = uv0:calculateHeight(false)
		end
	end

	slot0.checkfunc(slot1, slot0)
end

function slot0.refreshUI(slot0)
	slot0._isLeftFull = false
	slot0._isRightFull = false
	slot0._contentHeight = 0

	slot0:updateView()
end

function slot0.resetFunc(slot0, slot1)
	if slot1.logList and #slot1.logList > 0 then
		for slot5, slot6 in ipairs(slot1.logList) do
			gohelper.destroy(slot6)
		end

		slot1.logList = nil
	end
end

function slot0.checkAndHandleOverText(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot8 = slot4.preferredHeight
	slot9 = 16
	slot10 = 16
	slot11 = 10
	slot12 = 220
	slot13 = 30
	slot14 = 80
	slot16 = slot0._isLeftFull and slot0._rightContentHeight or slot0._leftContentHeight
	slot0.localContentHeight = slot0.localContentHeight == 0 and slot0:calculateHeight(not slot0._isLeftFull and true or false) or slot0.localContentHeight

	if not slot5 or #slot1.logConfigList == 1 then
		slot21 = 0

		for slot25 = 0, slot6:GetTextInfo(slot6.text).lineCount - 1 do
			if slot16 < slot9 + slot0:calculateHeight(slot15) + slot19.lineInfo[slot25].lineHeight + slot10 + (slot25 + 1) * slot11 then
				if slot25 > 1 then
					slot21 = slot19.lineInfo[slot25 - 1].firstVisibleCharacterIndex
				else
					table.insert(slot0._molist, slot2 + 1, slot1)

					return false
				end

				slot6.text = GameUtil.utf8sub(slot18, 1, slot21)

				if slot1.type == RoomRecordEnum.LogType.Normal then
					slot28 = slot1
					slot28.content = GameUtil.utf8sub(slot18, slot21 + 1, slot19.characterCount)
					slot28.isclone = true

					table.insert(slot0._molist, slot2 + 1, slot28)

					return true
				else
					slot28 = slot1
					slot28.logConfigList[1].content = slot27
					slot28.isclone = true

					table.insert(slot0._molist, slot2 + 1, slot28)

					return true
				end
			end
		end
	elseif slot1.type == RoomRecordEnum.LogType.Custom then
		if slot12 > slot16 - slot0:calculateHeight(slot15) - slot13 - slot14 then
			if slot15 then
				slot0._isLeftFull = true
			else
				slot0._isRightFull = true
			end

			table.insert(slot0._molist, slot2 + 1, slot1)

			return false
		elseif slot16 < slot17 + slot8 then
			slot1.num = slot7.num
			slot19 = {}
			slot1.isclone = true

			for slot23 = slot3, #slot1.logConfigList do
				table.insert(slot19, slot1.logConfigList[slot23])
			end

			slot18.logConfigList = slot19

			table.insert(slot0._molist, slot2 + 1, slot18)

			if slot7 then
				gohelper.setActive(slot7.simagesignature.gameObject, false)
			end

			return false
		end
	elseif slot16 < slot0:calculateHeight(slot15) + slot8 then
		slot19 = {}
		slot1.isclone = true

		for slot23 = slot3, #slot1.logConfigList do
			table.insert(slot19, slot1.logConfigList[slot23])
		end

		slot18.logConfigList = slot19

		table.insert(slot0._molist, slot2 + 1, slot18)

		return false
	end

	return true
end

function slot0.calculateHeight(slot0, slot1)
	slot2 = 0
	slot3 = 16
	slot4 = 16

	if slot1 then
		if slot0._leftItemList[slot0._bookPage] and #slot0._leftItemList[slot0._bookPage] > 0 then
			for slot8, slot9 in ipairs(slot0._leftItemList[slot0._bookPage]) do
				slot2 = slot2 + slot9.preferredHeight
			end

			slot2 = slot2 + slot0._itemspace * (#slot0._leftItemList[slot0._bookPage] - 1)
		end
	elseif slot0._rightItemList[slot0._bookPage] and #slot0._rightItemList[slot0._bookPage] > 0 then
		for slot8, slot9 in ipairs(slot0._rightItemList[slot0._bookPage]) do
			slot2 = slot2 + slot9.preferredHeight
		end

		slot2 = slot2 + slot0._itemspace * (#slot0._rightItemList[slot0._bookPage] - 1)
	end

	return slot2
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
