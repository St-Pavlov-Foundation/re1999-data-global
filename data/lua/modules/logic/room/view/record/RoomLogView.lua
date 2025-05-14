module("modules.logic.room.view.record.RoomLogView", package.seeall)

local var_0_0 = class("RoomLogView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnbook = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_book")
	arg_1_0._gohandbookreddot = gohelper.findChild(arg_1_0.viewGO, "root/#btn_book/#go_handbookreddot")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_task")
	arg_1_0._gotaskreddot = gohelper.findChild(arg_1_0.viewGO, "root/#btn_task/#go_taskreddot")
	arg_1_0._txtleftpages = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_leftpages")
	arg_1_0._txtrightpages = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_rightpages")
	arg_1_0._btnback = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_back")
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_next")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_reward")
	arg_1_0._gobookContent = gohelper.findChild(arg_1_0.viewGO, "root/content")
	arg_1_0._gobookItem = gohelper.findChild(arg_1_0.viewGO, "root/content/bookitem")
	arg_1_0._gopool = gohelper.findChild(arg_1_0.viewGO, "pool")
	arg_1_0._goleftempty = gohelper.findChild(arg_1_0.viewGO, "root/#go_leftempty")
	arg_1_0._gorightempty = gohelper.findChild(arg_1_0.viewGO, "root/#go_rightempty")
	arg_1_0._gorewardreddot = gohelper.findChild(arg_1_0.viewGO, "root/#btn_reward/#go_rewardreddot")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._leftContentHeight = 740
	arg_1_0._rightContentHeight = 925.7935
	arg_1_0._singleTextHeight = 37.1
	arg_1_0._itemspace = 40
	arg_1_0._contentHeight = 0
	arg_1_0._isLeftFull = false
	arg_1_0._isRightFull = false
	arg_1_0._itempool = {}
	arg_1_0._itemList = {}
	arg_1_0._leftItemList = {}
	arg_1_0._rightItemList = {}
	arg_1_0._moIndex = 1
	arg_1_0._pageToMo = {}
	arg_1_0._curCreateBookItem = nil
	arg_1_0._bookItemTab = {}
	arg_1_0._bookPage = 1

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbook:AddClickListener(arg_2_0._btnbookOnClick, arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btnback:AddClickListener(arg_2_0._btnbackOnClick, arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0:addEventCb(RoomTradeController.instance, RoomTradeEvent.OnGetTradeTaskExtraBonusReply, arg_2_0.refreshBtn, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbook:RemoveClickListener()
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnback:RemoveClickListener()
	arg_3_0._btnnext:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0:removeEventCb(RoomTradeController.instance, RoomTradeEvent.OnGetTradeTaskExtraBonusReply, arg_3_0.refreshBtn, arg_3_0)
end

function var_0_0._btnbookOnClick(arg_4_0)
	RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
		animName = RoomRecordEnum.AnimName.Log2HandBook,
		view = RoomRecordEnum.View.HandBook
	})
end

function var_0_0._btntaskOnClick(arg_5_0)
	RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
		animName = RoomRecordEnum.AnimName.Log2Task,
		view = RoomRecordEnum.View.Task
	})
end

function var_0_0._btnbackOnClick(arg_6_0)
	arg_6_0._bookPage = arg_6_0._bookPage - 1

	arg_6_0._animator:Play("switch", 0, 0)
	arg_6_0:refreshUI()
end

function var_0_0._btnrewardOnClick(arg_7_0)
	RoomRpc.instance:sendGetTradeTaskExtraBonusRequest()
end

function var_0_0.refreshBtn(arg_8_0)
	local var_8_0 = RoomTradeTaskModel.instance:getCanGetExtraBonus()

	gohelper.setActive(arg_8_0._btnreward.gameObject, var_8_0)
end

function var_0_0._btnnextOnClick(arg_9_0)
	arg_9_0._bookPage = arg_9_0._bookPage + 1

	if arg_9_0._moIndex ~= #arg_9_0._molist then
		arg_9_0._moIndex = arg_9_0._moIndex + 1
	end

	arg_9_0._animator:Play("switch", 0, 0)
	arg_9_0:refreshUI()
end

function var_0_0._editableInitView(arg_10_0)
	return
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._molist = RoomLogModel.instance:getInfos()

	local var_12_0 = false

	if not arg_12_0._molist or #arg_12_0._molist == 0 then
		var_12_0 = true
	end

	gohelper.setActive(arg_12_0._gobookContent, not var_12_0)
	gohelper.setActive(arg_12_0._goleftempty, var_12_0)
	gohelper.setActive(arg_12_0._gorightempty, var_12_0)

	if not var_12_0 then
		arg_12_0:updateView()
		arg_12_0:refreshBtn()
	end

	RedDotController.instance:addRedDot(arg_12_0._gotaskreddot, RedDotEnum.DotNode.TradeTask)
	RedDotController.instance:addRedDot(arg_12_0._gorewardreddot, RedDotEnum.DotNode.StrikerReward)
	RedDotController.instance:addRedDot(arg_12_0._gohandbookreddot, RedDotEnum.DotNode.CritterHandBook)
end

function var_0_0.updateView(arg_13_0)
	gohelper.setActive(arg_13_0._goleftempty, false)
	gohelper.setActive(arg_13_0._gorightempty, false)

	local var_13_0 = arg_13_0:createBookItem()

	if not var_13_0.isFull then
		local var_13_1 = arg_13_0._molist[arg_13_0._moIndex]

		arg_13_0:buildLogItem(var_13_1, arg_13_0._moIndex)

		if not arg_13_0._rightItemList[var_13_0.page] then
			gohelper.setActive(var_13_0.goempty, true)
		end
	end

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._bookItemTab) do
		gohelper.setActive(iter_13_1.go, iter_13_1.page == arg_13_0._bookPage)
	end

	if arg_13_0._bookPage == 1 then
		gohelper.setActive(arg_13_0._btnback.gameObject, false)

		if arg_13_0._moIndex ~= #arg_13_0._molist then
			gohelper.setActive(arg_13_0._btnnext.gameObject, true)
		end
	else
		gohelper.setActive(arg_13_0._btnback.gameObject, true)
	end

	if arg_13_0._bookPage ~= #arg_13_0._bookItemTab then
		gohelper.setActive(arg_13_0._btnnext.gameObject, true)
	elseif arg_13_0._moIndex == #arg_13_0._molist then
		gohelper.setActive(arg_13_0._btnnext.gameObject, false)
	end

	arg_13_0._txtleftpages.text = arg_13_0._bookPage * 2 - 1
	arg_13_0._txtrightpages.text = arg_13_0._bookPage * 2
end

function var_0_0.createBookItem(arg_14_0)
	local var_14_0 = arg_14_0._bookItemTab[arg_14_0._bookPage]

	if not var_14_0 then
		var_14_0 = arg_14_0:getUserDataTb_()
		var_14_0.page = arg_14_0._bookPage
		var_14_0.go = gohelper.cloneInPlace(arg_14_0._gobookItem, "bookItem" .. arg_14_0._bookPage)
		var_14_0.goLeft = gohelper.findChild(var_14_0.go, "left/content")
		var_14_0.goRight = gohelper.findChild(var_14_0.go, "right/content")
		var_14_0.goempty = gohelper.findChild(var_14_0.go, "#go_empty")

		gohelper.setActive(var_14_0.go, true)

		arg_14_0._bookItemTab[arg_14_0._bookPage] = var_14_0
		arg_14_0._curCreateBookItem = var_14_0
	end

	return var_14_0
end

function var_0_0.createLogItem(arg_15_0)
	local var_15_0 = arg_15_0._molist[arg_15_0._moIndex]

	if var_15_0 then
		arg_15_0:buildLogItem(var_15_0, arg_15_0._moIndex)
	end
end

function var_0_0.checkContinue(arg_16_0)
	if arg_16_0._curCreateBookItem.isFull then
		return false
	end

	if arg_16_0._isLeftFull and arg_16_0._isRightFull then
		return false
	end

	if tabletool.len(arg_16_0._molist) <= arg_16_0._moIndex then
		return false
	end

	return true
end

function var_0_0.buildLogItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0:createOrGetItem()

	var_17_0.mo = arg_17_1
	var_17_0.index = arg_17_2
	arg_17_0.localContentHeight = 0

	if arg_17_1.type == RoomRecordEnum.LogType.Normal then
		var_17_0 = arg_17_0:buildNoramlItem(var_17_0, arg_17_1, arg_17_2)
	elseif arg_17_1.type == RoomRecordEnum.LogType.Speical then
		var_17_0 = arg_17_0:buildSpeicalItem(var_17_0, arg_17_1, arg_17_2)
	elseif arg_17_1.type == RoomRecordEnum.LogType.Custom then
		var_17_0 = arg_17_0:buildCustomItem(var_17_0, arg_17_1, arg_17_2)
	elseif arg_17_1.type == RoomRecordEnum.LogType.Time then
		var_17_0 = arg_17_0:buildTimeItem(var_17_0, arg_17_1, arg_17_2)
	end

	if var_17_0 then
		arg_17_0:setParent(var_17_0)
		arg_17_0:checkSingleItemHeightIsFull()
	end

	if arg_17_0:checkContinue() then
		arg_17_0._moIndex = arg_17_0._moIndex + 1

		arg_17_0:createLogItem()
	else
		arg_17_0._curCreateBookItem.isFull = true
	end
end

function var_0_0.buildNoramlItem(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0:handleType(arg_18_1, arg_18_2)

	if var_18_0 then
		local var_18_1 = gohelper.findChild(var_18_0, "timebg")
		local var_18_2 = gohelper.findChildText(var_18_0, "timebg/#txt_time")
		local var_18_3 = gohelper.findChild(var_18_0, "icon")

		gohelper.setActive(var_18_1, not arg_18_2.isclone)
		gohelper.setActive(var_18_3, not arg_18_2.isclone)

		var_18_2.text = arg_18_2.timestr

		local var_18_4 = gohelper.findChild(var_18_0, "#scroll_details/Viewport/Content")
		local var_18_5 = var_18_4:GetComponent(gohelper.Type_VerticalLayoutGroup)

		arg_18_1.cscontent = var_18_5

		local var_18_6 = gohelper.findChild(var_18_0, "#scroll_details/Viewport/Content/logitem")

		if arg_18_2.content then
			gohelper.setActive(var_18_6, true)

			local var_18_7 = arg_18_2.content
			local var_18_8 = gohelper.findChildText(var_18_6, "#txt_log")
			local var_18_9 = gohelper.findChild(var_18_6, "icon")

			gohelper.setActive(var_18_9, not arg_18_2.isclone)

			var_18_8.text = var_18_7

			ZProj.UGUIHelper.RebuildLayout(var_18_4.transform)
			arg_18_0:checkSingleItemHeightIsFull(true)

			if arg_18_0:checkAndHandleOverText(arg_18_2, arg_18_1.index, nil, var_18_5, false, var_18_8) then
				ZProj.UGUIHelper.RebuildLayout(var_18_4.transform)
			else
				arg_18_0:resetFunc(arg_18_1)
				gohelper.destroy(arg_18_1.go)

				arg_18_1 = nil

				if not arg_18_0._isLeftFull then
					arg_18_0._isLeftFull = true
				else
					arg_18_0._isRightFull = true
				end

				return false
			end
		end

		arg_18_1.preferredHeight = var_18_5.preferredHeight
	end

	return arg_18_1
end

function var_0_0.buildSpeicalItem(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_0:handleType(arg_19_1, arg_19_2)

	if var_19_0 then
		local var_19_1 = gohelper.findChild(var_19_0, "timebg")
		local var_19_2 = gohelper.findChildText(var_19_0, "timebg/#txt_time")
		local var_19_3 = gohelper.findChild(var_19_0, "icon")

		var_19_2.text = arg_19_2.timestr

		gohelper.setActive(var_19_1, not arg_19_2.isclone)
		gohelper.setActive(var_19_3, not arg_19_2.isclone)

		local var_19_4 = arg_19_1.go:GetComponent(gohelper.Type_VerticalLayoutGroup)

		arg_19_1.cscontent = var_19_4

		local var_19_5 = gohelper.findChild(var_19_0, "#scroll_details/Viewport/Content/logitem")

		if arg_19_2.logConfigList and #arg_19_2.logConfigList > 0 then
			local var_19_6 = arg_19_0:getUserDataTb_()

			for iter_19_0, iter_19_1 in ipairs(arg_19_2.logConfigList) do
				local var_19_7 = gohelper.cloneInPlace(var_19_5, "speicalLog" .. iter_19_0)

				gohelper.setActive(var_19_7, true)

				local var_19_8 = iter_19_1.speaker
				local var_19_9 = iter_19_1.content
				local var_19_10 = var_19_7:GetComponent(gohelper.Type_HorizontalLayoutGroup)
				local var_19_11 = gohelper.findChildText(var_19_7, "#txt_log")

				var_19_11.text = "<color=#A14114>" .. var_19_8 .. "</color>" .. ":" .. var_19_9

				ZProj.UGUIHelper.RebuildLayout(var_19_7.transform)
				ZProj.UGUIHelper.RebuildLayout(arg_19_1.go.transform)

				if not arg_19_0:checkSingleItemHeightIsFull(false, var_19_10.preferredHeight) then
					gohelper.destroy(var_19_7)

					break
				end

				if arg_19_0:checkAndHandleOverText(arg_19_2, arg_19_1.index, iter_19_0, var_19_4, true, var_19_11) then
					table.insert(var_19_6, var_19_7)
				else
					gohelper.destroy(var_19_7)

					break
				end
			end

			arg_19_1.logList = var_19_6
		end

		if not arg_19_1.logList or not next(arg_19_1.logList) then
			arg_19_0:resetFunc(arg_19_1)
			gohelper.destroy(arg_19_1.go)

			arg_19_1 = nil

			return false
		end

		ZProj.UGUIHelper.RebuildLayout(arg_19_1.go.transform)

		arg_19_1.preferredHeight = var_19_4.preferredHeight
	end

	return arg_19_1
end

function var_0_0.buildCustomItem(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_0:handleType(arg_20_1, arg_20_2)

	if not arg_20_0._isLeftFull or not arg_20_0._rightContentHeight then
		local var_20_1 = arg_20_0._leftContentHeight
	end

	local var_20_2 = arg_20_2.num or math.random(1, 2)

	if var_20_0 then
		local var_20_3 = arg_20_0:getUserDataTb_()

		for iter_20_0 = 1, 2 do
			local var_20_4 = gohelper.findChild(var_20_0, "#scroll_details/image_detailsbg" .. iter_20_0)

			gohelper.setActive(var_20_4, false)
		end

		var_20_3.num = var_20_2

		local var_20_5 = gohelper.findChild(var_20_0, "#scroll_details/image_detailsbg" .. var_20_2)
		local var_20_6 = gohelper.findChild(var_20_5, "dec")
		local var_20_7 = gohelper.findChild(var_20_5, "dec/icon")
		local var_20_8 = gohelper.findChild(var_20_5, "timebg")

		gohelper.findChildText(var_20_5, "timebg/#txt_time").text = arg_20_2.timestr

		gohelper.setActive(var_20_5, true)

		var_20_3.simagesticker = gohelper.findChildSingleImage(var_20_0, "#scroll_details/#simage_stickers")
		var_20_3.simagesignature = gohelper.findChildSingleImage(var_20_0, "#scroll_details/#simage_signature")

		local var_20_9 = gohelper.findChildText(var_20_0, "#scroll_details/#txt_name")
		local var_20_10 = gohelper.findChild(var_20_0, "#scroll_details/Viewport/Content/logitem")

		var_20_9.text = arg_20_2.name

		local var_20_11 = string.split(arg_20_2.config.extraBonus, "#")[2]
		local var_20_12 = arg_20_2.config.icon

		if var_20_11 then
			var_20_3.simagesticker:LoadImage(ResUrl.getPropItemIcon(var_20_11))
		end

		if var_20_12 then
			var_20_3.simagesignature:LoadImage(ResUrl.getSignature("characterget/" .. var_20_12))
		end

		gohelper.setActive(var_20_7, not arg_20_2.isclone)
		gohelper.setActive(var_20_6, not arg_20_2.isclone)
		gohelper.setActive(var_20_8, not arg_20_2.isclone)
		gohelper.setActive(var_20_3.simagesticker.gameObject, not arg_20_2.isclone)
		gohelper.setActive(var_20_9.gameObject, not arg_20_2.isclone)

		local var_20_13 = arg_20_1.go:GetComponent(gohelper.Type_VerticalLayoutGroup)

		arg_20_1.cscontent = var_20_13

		if arg_20_2.logConfigList and #arg_20_2.logConfigList > 0 then
			local var_20_14 = arg_20_0:getUserDataTb_()

			for iter_20_1, iter_20_2 in ipairs(arg_20_2.logConfigList) do
				local var_20_15 = gohelper.cloneInPlace(var_20_10, "customLog" .. iter_20_1)

				gohelper.setActive(var_20_15, true)

				local var_20_16 = var_20_15:GetComponent(gohelper.Type_VerticalLayoutGroup)
				local var_20_17 = gohelper.findChildText(var_20_15, "#txt_log")

				var_20_17.text = iter_20_2.content

				ZProj.UGUIHelper.RebuildLayout(var_20_15.transform)
				ZProj.UGUIHelper.RebuildLayout(arg_20_1.go.transform)
				arg_20_0:checkSingleItemHeightIsFull(false, var_20_16.preferredHeight)

				if arg_20_0:checkAndHandleOverText(arg_20_2, arg_20_1.index, iter_20_1, var_20_13, true, var_20_17, var_20_3) then
					table.insert(var_20_14, var_20_15)
				else
					gohelper.destroy(var_20_15)

					break
				end
			end

			arg_20_1.logList = var_20_14
		end

		if not arg_20_1.logList or not next(arg_20_1.logList) then
			arg_20_0:resetFunc(arg_20_1)
			gohelper.destroy(arg_20_1.go)

			arg_20_1 = nil

			return false
		end

		ZProj.UGUIHelper.RebuildLayout(arg_20_1.go.transform)

		arg_20_1.preferredHeight = var_20_13.preferredHeight
	end

	return arg_20_1
end

function var_0_0.buildTimeItem(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_0:handleType(arg_21_1, arg_21_2)

	if var_21_0 then
		local var_21_1 = arg_21_1.go:GetComponent(gohelper.Type_VerticalLayoutGroup)

		arg_21_1.cscontent = var_21_1
		gohelper.findChildText(var_21_0, "bg/#txt_time").text = luaLang("weekday" .. tonumber(arg_21_2.day))

		ZProj.UGUIHelper.RebuildLayout(arg_21_1.go.transform)

		arg_21_1.preferredHeight = var_21_1.preferredHeight

		if not arg_21_0:checkSingleItemHeightIsFull(false, arg_21_1.preferredHeight) then
			table.insert(arg_21_0._molist, arg_21_3 + 1, arg_21_2)
			arg_21_0:resetFunc(arg_21_1)
			gohelper.destroy(arg_21_1.go)

			arg_21_1 = nil

			return false
		end
	end

	return arg_21_1
end

function var_0_0.checkSingleItemHeightIsFull(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = 16
	local var_22_1 = 16
	local var_22_2 = arg_22_1 and 40 or 0
	local var_22_3 = arg_22_2 or arg_22_0._singleTextHeight

	if not arg_22_0._isLeftFull then
		if var_22_0 + var_22_3 + var_22_1 + var_22_2 > arg_22_0._leftContentHeight - arg_22_0._contentHeight then
			arg_22_0._isLeftFull = true

			return false
		end
	elseif not arg_22_0._isRightFull and var_22_0 + var_22_3 + var_22_1 + var_22_2 > arg_22_0._rightContentHeight - arg_22_0._contentHeight then
		arg_22_0._isRightFull = true

		return false
	end

	return true
end

function var_0_0.handleType(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0

	for iter_23_0, iter_23_1 in ipairs(arg_23_1.gotypelist) do
		if iter_23_0 == arg_23_2.type then
			gohelper.setActive(iter_23_1, true)

			var_23_0 = iter_23_1
		else
			gohelper.setActive(iter_23_1, false)
		end
	end

	return var_23_0
end

function var_0_0.createOrGetItem(arg_24_0)
	local var_24_0

	if not var_24_0 then
		var_24_0 = arg_24_0:getUserDataTb_()

		local var_24_1 = arg_24_0.viewContainer:getSetting().otherRes[3]
		local var_24_2 = arg_24_0._isLeftFull and arg_24_0._curCreateBookItem.goRight or arg_24_0._curCreateBookItem.goLeft

		var_24_0.go = arg_24_0:getResInst(var_24_1, var_24_2, "item")
		var_24_0.gotypelist = {}

		for iter_24_0 = 1, 4 do
			local var_24_3 = gohelper.findChild(var_24_0.go, "type" .. iter_24_0)

			table.insert(var_24_0.gotypelist, var_24_3)
		end
	end

	gohelper.setActive(var_24_0.go, true)

	return var_24_0
end

function var_0_0.setParent(arg_25_0, arg_25_1)
	local var_25_0 = not arg_25_0._isLeftFull and true or false
	local var_25_1 = arg_25_0._isLeftFull and arg_25_0._rightContentHeight or arg_25_0._leftContentHeight

	arg_25_0._contentHeight = arg_25_0:calculateHeight(var_25_0)

	function arg_25_0.checkfunc(arg_26_0)
		if arg_25_0._contentHeight + arg_26_0.preferredHeight > var_25_1 then
			if arg_26_0.logList and #arg_26_0.logList > 1 then
				local var_26_0 = table.remove(arg_26_0.logList)

				gohelper.destroy(var_26_0)
				ZProj.UGUIHelper.RebuildLayout(arg_26_0.go.transform)

				arg_26_0.preferredHeight = arg_26_0.cscontent.preferredHeight

				arg_25_0.checkfunc(arg_26_0, arg_25_0)
			else
				if var_25_0 then
					arg_25_0._isLeftFull = true
				else
					arg_25_0._isRightFull = true
				end

				arg_25_0._contentHeight = 0

				arg_25_0:resetFunc(arg_26_0)

				arg_26_0 = nil
			end
		elseif var_25_0 then
			arg_26_0.go.transform:SetParent(arg_25_0._curCreateBookItem.goLeft.transform)

			arg_25_0._leftItemList[arg_25_0._bookPage] = arg_25_0._leftItemList[arg_25_0._bookPage] or {}

			table.insert(arg_25_0._leftItemList[arg_25_0._bookPage], arg_26_0)

			arg_25_0._pageToMo[arg_25_0._bookPage] = arg_25_0._pageToMo[arg_25_0._bookPage] or {}
			arg_25_0._pageToMo[arg_25_0._bookPage][arg_26_0.index] = arg_26_0.mo
			arg_25_0._contentHeight = arg_25_0:calculateHeight(true)
		else
			arg_26_0.go.transform:SetParent(arg_25_0._curCreateBookItem.goRight.transform)

			arg_25_0._rightItemList[arg_25_0._bookPage] = arg_25_0._rightItemList[arg_25_0._bookPage] or {}

			table.insert(arg_25_0._rightItemList[arg_25_0._bookPage], arg_26_0)

			arg_25_0._pageToMo[arg_25_0._bookPage][arg_26_0.index] = arg_26_0.mo
			arg_25_0._contentHeight = arg_25_0:calculateHeight(false)
		end
	end

	arg_25_0.checkfunc(arg_25_1, arg_25_0)
end

function var_0_0.refreshUI(arg_27_0)
	arg_27_0._isLeftFull = false
	arg_27_0._isRightFull = false
	arg_27_0._contentHeight = 0

	arg_27_0:updateView()
end

function var_0_0.resetFunc(arg_28_0, arg_28_1)
	if arg_28_1.logList and #arg_28_1.logList > 0 then
		for iter_28_0, iter_28_1 in ipairs(arg_28_1.logList) do
			gohelper.destroy(iter_28_1)
		end

		arg_28_1.logList = nil
	end
end

function var_0_0.checkAndHandleOverText(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5, arg_29_6, arg_29_7)
	local var_29_0 = arg_29_4.preferredHeight
	local var_29_1 = 16
	local var_29_2 = 16
	local var_29_3 = 10
	local var_29_4 = 220
	local var_29_5 = 30
	local var_29_6 = 80
	local var_29_7 = not arg_29_0._isLeftFull and true or false
	local var_29_8 = arg_29_0._isLeftFull and arg_29_0._rightContentHeight or arg_29_0._leftContentHeight

	arg_29_0.localContentHeight = arg_29_0.localContentHeight == 0 and arg_29_0:calculateHeight(var_29_7) or arg_29_0.localContentHeight

	if not arg_29_5 or #arg_29_1.logConfigList == 1 then
		local var_29_9 = arg_29_0:calculateHeight(var_29_7)
		local var_29_10 = arg_29_6.text
		local var_29_11 = arg_29_6:GetTextInfo(var_29_10)
		local var_29_12 = var_29_11.lineCount
		local var_29_13 = 0

		for iter_29_0 = 0, var_29_12 - 1 do
			var_29_9 = var_29_9 + var_29_11.lineInfo[iter_29_0].lineHeight

			if var_29_8 < var_29_1 + var_29_9 + var_29_2 + (iter_29_0 + 1) * var_29_3 then
				if iter_29_0 > 1 then
					var_29_13 = var_29_11.lineInfo[iter_29_0 - 1].firstVisibleCharacterIndex
				else
					table.insert(arg_29_0._molist, arg_29_2 + 1, arg_29_1)

					return false
				end

				arg_29_6.text = GameUtil.utf8sub(var_29_10, 1, var_29_13)

				local var_29_14 = GameUtil.utf8sub(var_29_10, var_29_13 + 1, var_29_11.characterCount)

				if arg_29_1.type == RoomRecordEnum.LogType.Normal then
					local var_29_15 = arg_29_1

					var_29_15.content = var_29_14
					var_29_15.isclone = true

					table.insert(arg_29_0._molist, arg_29_2 + 1, var_29_15)

					return true
				else
					local var_29_16 = arg_29_1

					var_29_16.logConfigList[1].content = var_29_14
					var_29_16.isclone = true

					table.insert(arg_29_0._molist, arg_29_2 + 1, var_29_16)

					return true
				end
			end
		end
	elseif arg_29_1.type == RoomRecordEnum.LogType.Custom then
		local var_29_17 = arg_29_0:calculateHeight(var_29_7)

		if var_29_4 > var_29_8 - var_29_17 - var_29_5 - var_29_6 then
			if var_29_7 then
				arg_29_0._isLeftFull = true
			else
				arg_29_0._isRightFull = true
			end

			table.insert(arg_29_0._molist, arg_29_2 + 1, arg_29_1)

			return false
		elseif var_29_8 < var_29_17 + var_29_0 then
			local var_29_18 = arg_29_1

			arg_29_1.num = arg_29_7.num

			local var_29_19 = {}

			var_29_18.isclone = true

			for iter_29_1 = arg_29_3, #arg_29_1.logConfigList do
				table.insert(var_29_19, arg_29_1.logConfigList[iter_29_1])
			end

			var_29_18.logConfigList = var_29_19

			table.insert(arg_29_0._molist, arg_29_2 + 1, var_29_18)

			if arg_29_7 then
				gohelper.setActive(arg_29_7.simagesignature.gameObject, false)
			end

			return false
		end
	elseif var_29_8 < arg_29_0:calculateHeight(var_29_7) + var_29_0 then
		local var_29_20 = arg_29_1
		local var_29_21 = {}

		var_29_20.isclone = true

		for iter_29_2 = arg_29_3, #arg_29_1.logConfigList do
			table.insert(var_29_21, arg_29_1.logConfigList[iter_29_2])
		end

		var_29_20.logConfigList = var_29_21

		table.insert(arg_29_0._molist, arg_29_2 + 1, var_29_20)

		return false
	end

	return true
end

function var_0_0.calculateHeight(arg_30_0, arg_30_1)
	local var_30_0 = 0
	local var_30_1 = 16
	local var_30_2 = 16

	if arg_30_1 then
		if arg_30_0._leftItemList[arg_30_0._bookPage] and #arg_30_0._leftItemList[arg_30_0._bookPage] > 0 then
			for iter_30_0, iter_30_1 in ipairs(arg_30_0._leftItemList[arg_30_0._bookPage]) do
				var_30_0 = var_30_0 + iter_30_1.preferredHeight
			end

			var_30_0 = var_30_0 + arg_30_0._itemspace * (#arg_30_0._leftItemList[arg_30_0._bookPage] - 1)
		end
	elseif arg_30_0._rightItemList[arg_30_0._bookPage] and #arg_30_0._rightItemList[arg_30_0._bookPage] > 0 then
		for iter_30_2, iter_30_3 in ipairs(arg_30_0._rightItemList[arg_30_0._bookPage]) do
			var_30_0 = var_30_0 + iter_30_3.preferredHeight
		end

		var_30_0 = var_30_0 + arg_30_0._itemspace * (#arg_30_0._rightItemList[arg_30_0._bookPage] - 1)
	end

	return var_30_0
end

function var_0_0.onClose(arg_31_0)
	return
end

function var_0_0.onDestroyView(arg_32_0)
	return
end

return var_0_0
