module("modules.logic.versionactivity2_4.pinball.view.PinballGameView", package.seeall)

local var_0_0 = class("PinballGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goDrag = gohelper.findChild(arg_1_0.viewGO, "#go_drag")
	arg_1_0._goDragArea = gohelper.findChild(arg_1_0.viewGO, "#go_drag_area")
	arg_1_0._goLine = gohelper.findChild(arg_1_0.viewGO, "#go_drag/#go_line")
	arg_1_0._goLine2 = gohelper.findChild(arg_1_0.viewGO, "#go_drag/#go_line/line")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#txt_name")
	arg_1_0._resItem = gohelper.findChild(arg_1_0.viewGO, "Right/list/item")
	arg_1_0._gobag = gohelper.findChild(arg_1_0.viewGO, "#go_bag")
	arg_1_0._btnOpenBag = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_click")
	arg_1_0._btnCloseBag = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_bag/#btn_closebag")
	arg_1_0._holeItem = gohelper.findChild(arg_1_0.viewGO, "Left/holes/item")
	arg_1_0._ballItem = gohelper.findChild(arg_1_0.viewGO, "Left/balls/item")
	arg_1_0._golighteff = gohelper.findChild(arg_1_0.viewGO, "Left/light_eff")
	arg_1_0._imageCurBall = gohelper.findChildImage(arg_1_0.viewGO, "#go_drag/#image_icon")
	arg_1_0._bagItem = gohelper.findChild(arg_1_0.viewGO, "#go_bag/root/balls/item")
	arg_1_0._txttask = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#txt_task")
	arg_1_0._gotaskfinish = gohelper.findChild(arg_1_0.viewGO, "Right/#go_taskFinished")
	arg_1_0._transLine = arg_1_0._goLine.transform
	arg_1_0._transLine2 = arg_1_0._goLine2.transform
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnOpenBag:AddClickListener(arg_2_0._onClickOpenBag, arg_2_0)
	arg_2_0._btnCloseBag:AddClickListener(arg_2_0._onClickCloseBag, arg_2_0)
	CommonDragHelper.instance:registerDragObj(arg_2_0._goDragArea, arg_2_0._onBeginDrag, arg_2_0._onDrag, arg_2_0._onEndDrag, arg_2_0._checkDrag, arg_2_0, nil, true)
	PinballController.instance:registerCallback(PinballEvent.GameResRefresh, arg_2_0._onGameRefresh, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.ClickBagItem, arg_2_0._onClickBagItem, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.ClickMarbles, arg_2_0._onClickBallItem, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.DragMarblesEnd, arg_2_0._onDragBallItem, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.MarblesDead, arg_2_0._onMarblesDead, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.GameResChange, arg_2_0._refreshTask, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onViewClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnOpenBag:RemoveClickListener()
	arg_3_0._btnCloseBag:RemoveClickListener()
	CommonDragHelper.instance:unregisterDragObj(arg_3_0._goDragArea)
	PinballController.instance:unregisterCallback(PinballEvent.GameResRefresh, arg_3_0._onGameRefresh, arg_3_0)
	PinballController.instance:unregisterCallback(PinballEvent.ClickBagItem, arg_3_0._onClickBagItem, arg_3_0)
	PinballController.instance:unregisterCallback(PinballEvent.ClickMarbles, arg_3_0._onClickBallItem, arg_3_0)
	PinballController.instance:unregisterCallback(PinballEvent.DragMarblesEnd, arg_3_0._onDragBallItem, arg_3_0)
	PinballController.instance:unregisterCallback(PinballEvent.MarblesDead, arg_3_0._onMarblesDead, arg_3_0)
	PinballController.instance:unregisterCallback(PinballEvent.GameResChange, arg_3_0._refreshTask, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onViewClose, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio12)
	PinballModel.instance:clearGameRes()
	gohelper.setActive(arg_4_0._goLine, false)
	gohelper.setActive(arg_4_0._gobag, false)
	PinballEntityMgr.instance:beginTick()
	arg_4_0:_onScreenResize()
	arg_4_0:loadMapEntity()
	arg_4_0:createResItem()
	arg_4_0:initMarbles()
	arg_4_0:_refreshTask()
	gohelper.setActive(arg_4_0._holeItemAnims[1], arg_4_0._curPlaceList[1] == 0)
end

function var_0_0._onScreenResize(arg_5_0)
	local var_5_0, var_5_1 = recthelper.getAnchor(arg_5_0._goDrag.transform)

	arg_5_0._defaultPos = Vector2(var_5_0, var_5_1)
end

function var_0_0.createResItem(arg_6_0)
	local var_6_0 = {
		PinballEnum.ResType.Wood,
		PinballEnum.ResType.Mine,
		PinballEnum.ResType.Stone,
		PinballEnum.ResType.Food
	}

	gohelper.CreateObjList(arg_6_0, arg_6_0._createResItem, var_6_0, nil, arg_6_0._resItem, PinballGameResItem)
end

function var_0_0._createResItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_1:setData(arg_7_2)
end

function var_0_0._onViewClose(arg_8_0, arg_8_1)
	if arg_8_1 ~= ViewName.PinballStartLoadingView then
		return
	end

	local var_8_0 = PinballModel.instance:getAllMarblesNum()
	local var_8_1 = 0

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		if iter_8_1 > 0 then
			var_8_1 = var_8_1 + 1
		end
	end

	if var_8_1 >= 2 then
		PinballController.instance:dispatchEvent(PinballEvent.GuideUnlockBallInGame)
	end
end

function var_0_0.initMarbles(arg_9_0)
	local var_9_0, var_9_1, var_9_2 = PinballModel.instance:getAllMarblesNum()
	local var_9_3 = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_4_Act178MarblesPlace, "")
	local var_9_4 = string.splitToNumber(var_9_3, "#") or {}

	if var_9_1 < #var_9_4 or not arg_9_0:checkMarble(var_9_0, var_9_4) then
		var_9_4 = {}

		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_4_Act178MarblesPlace, "")
	end

	local var_9_5 = {}
	local var_9_6 = {}

	arg_9_0._canPlaceNum = var_9_1
	arg_9_0._curBagDict = var_9_0
	arg_9_0._curUseList = {}

	PinballStatHelper.instance:setCurUseBallList(arg_9_0._curUseList)

	arg_9_0._curPlaceList = var_9_5

	for iter_9_0 = 1, var_9_1 do
		var_9_6[iter_9_0] = 1

		if var_9_4[iter_9_0] then
			var_9_5[iter_9_0] = var_9_4[iter_9_0]
			arg_9_0._canPlaceNum = arg_9_0._canPlaceNum - 1
			var_9_0[var_9_4[iter_9_0]] = var_9_0[var_9_4[iter_9_0]] - 1
		else
			var_9_5[iter_9_0] = 0
		end
	end

	for iter_9_1 = var_9_1 + 1, var_9_2 do
		var_9_6[iter_9_1] = 2
	end

	arg_9_0._holeItemAnims = arg_9_0:getUserDataTb_()
	arg_9_0._bagItems = {}
	arg_9_0._ballItems = {}

	gohelper.CreateObjList(arg_9_0, arg_9_0._createHole, var_9_6, nil, arg_9_0._holeItem)
	gohelper.CreateObjList(arg_9_0, arg_9_0._createBall, var_9_5, nil, arg_9_0._ballItem, PinballGameBallItem)

	local var_9_7 = {
		PinballEnum.UnitType.MarblesNormal,
		PinballEnum.UnitType.MarblesDivision,
		PinballEnum.UnitType.MarblesGlass,
		PinballEnum.UnitType.MarblesExplosion,
		PinballEnum.UnitType.MarblesElasticity
	}

	gohelper.CreateObjList(arg_9_0, arg_9_0._createBagItem, var_9_7, nil, arg_9_0._bagItem, PinballBagItem)

	local var_9_8 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.DefaultMarblesHoleNum)
	local var_9_9 = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Version2_4_Act178HoleNum, var_9_8)

	if var_9_9 < var_9_1 then
		GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.Version2_4_Act178HoleNum, var_9_1)

		for iter_9_2 = var_9_9 + 1, var_9_1 do
			-- block empty
		end
	end

	arg_9_0:updateCurUseMarbles()
end

function var_0_0.checkMarble(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_2) do
		var_10_0[iter_10_1] = (var_10_0[iter_10_1] or 0) + 1
	end

	for iter_10_2, iter_10_3 in pairs(arg_10_1) do
		if var_10_0[iter_10_2] and iter_10_3 < var_10_0[iter_10_2] then
			return false
		end
	end

	return true
end

function var_0_0._createHole(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0._holeItemAnims[arg_11_3] = gohelper.findChild(arg_11_1, "vx_eff")

	local var_11_0 = gohelper.findChild(arg_11_1, "#go_lock")

	gohelper.setActive(arg_11_0._holeItemAnims[arg_11_3], false)
	gohelper.setActive(var_11_0, arg_11_2 == 2)
end

function var_0_0._createBagItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0._bagItems[arg_12_2] = arg_12_1

	arg_12_1:setInfo(arg_12_2, arg_12_0._curBagDict[arg_12_2], arg_12_0._canPlaceNum)
end

function var_0_0._createBall(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0._ballItems[arg_13_3] = arg_13_1

	arg_13_1:setInfo(arg_13_2, arg_13_3, true)
end

function var_0_0._onMarblesDead(arg_14_0)
	arg_14_0._isPlaying = false

	if #arg_14_0._curPlaceList > 0 then
		arg_14_0:updateCurUseMarbles()
	else
		PinballEntityMgr.instance:pauseTick()
		Activity178Rpc.instance:sendAct178EndEpisode(VersionActivity2_4Enum.ActivityId.Pinball, PinballModel.instance.gameAddResDict, PinballModel.instance.leftEpisodeId)
	end
end

function var_0_0.updateCurUseMarbles(arg_15_0)
	local var_15_0 = 0

	if not arg_15_0._isPlaying then
		var_15_0 = arg_15_0._curPlaceList[1]
	end

	if arg_15_0._showId ~= var_15_0 then
		arg_15_0._showId = var_15_0

		gohelper.setActive(arg_15_0._goDrag, var_15_0 > 0)
		gohelper.setActive(arg_15_0._golighteff, var_15_0 > 0)

		if var_15_0 > 0 then
			local var_15_1 = lua_activity178_marbles.configDict[VersionActivity2_4Enum.ActivityId.Pinball][var_15_0]

			UISpriteSetMgr.instance:setAct178Sprite(arg_15_0._imageCurBall, var_15_1.icon, true)

			local var_15_2 = PinballModel.instance:getMarblesLvCache(var_15_0)
			local var_15_3 = string.splitToNumber(var_15_1.radius, "#") or {}
			local var_15_4 = (var_15_3[var_15_2] or var_15_3[#var_15_3] or 1000) / 1000
			local var_15_5 = PinballConst.Const7_1 * var_15_4

			transformhelper.setLocalScale(arg_15_0._goDrag.transform, var_15_5, var_15_5, var_15_5)
		end
	end
end

function var_0_0._onClickOpenBag(arg_16_0)
	if PinballHelper.isBanOper() then
		return
	end

	gohelper.setActive(arg_16_0._gobag, true)
end

function var_0_0._onClickCloseBag(arg_17_0)
	gohelper.setActive(arg_17_0._gobag, false)
end

function var_0_0._onClickBagItem(arg_18_0, arg_18_1)
	arg_18_0._curBagDict[arg_18_1] = arg_18_0._curBagDict[arg_18_1] - 1
	arg_18_0._canPlaceNum = arg_18_0._canPlaceNum - 1

	local var_18_0 = #arg_18_0._curPlaceList
	local var_18_1 = var_18_0 - arg_18_0._canPlaceNum

	arg_18_0._curPlaceList[var_18_1] = arg_18_1

	arg_18_0._ballItems[var_18_1]:setInfo(arg_18_1, var_18_1, var_18_1 <= var_18_0)
	arg_18_0:_refreshBagAndSaveData()
end

function var_0_0._onClickBallItem(arg_19_0, arg_19_1)
	if PinballHelper.isBanOper() then
		return
	end

	if not arg_19_0._gobag.activeSelf then
		gohelper.setActive(arg_19_0._gobag, true)

		return
	end

	if arg_19_0._curPlaceList[arg_19_1] == 0 or not arg_19_0._curPlaceList[arg_19_1] then
		return
	end

	local var_19_0 = table.remove(arg_19_0._curPlaceList, arg_19_1)

	table.insert(arg_19_0._curPlaceList, 0)

	arg_19_0._canPlaceNum = arg_19_0._canPlaceNum + 1
	arg_19_0._curBagDict[var_19_0] = arg_19_0._curBagDict[var_19_0] + 1

	arg_19_0._ballItems[arg_19_1]:setInfo(0, arg_19_1, true)

	if arg_19_0._curPlaceList[arg_19_1] == 0 then
		arg_19_0:_refreshBagAndSaveData()
	else
		for iter_19_0 = arg_19_1 + 1, #arg_19_0._curPlaceList do
			local var_19_1
			local var_19_2

			if iter_19_0 == arg_19_1 + 1 then
				UIBlockMgr.instance:startBlock("PinballGameView_Move_Swap")

				var_19_1, var_19_2 = arg_19_0.onMoveBack, arg_19_0
			end

			arg_19_0._ballItems[iter_19_0]:moveTo(arg_19_0._ballItems[iter_19_0 - 1]:getRootPos(), var_19_1, var_19_2)
		end
	end
end

function var_0_0.onBallUse(arg_20_0)
	arg_20_0._isPlaying = true

	table.insert(arg_20_0._curUseList, table.remove(arg_20_0._curPlaceList, 1))
	arg_20_0._ballItems[1]:setInfo(0, 1, arg_20_0._curPlaceList[1] and true or false)

	if #arg_20_0._curPlaceList > 0 then
		for iter_20_0 = 1, #arg_20_0._curPlaceList do
			local var_20_0
			local var_20_1

			if iter_20_0 == 1 then
				UIBlockMgr.instance:startBlock("PinballGameView_Move_Swap")

				var_20_0, var_20_1 = arg_20_0.onMoveBack, arg_20_0
			end

			arg_20_0._ballItems[iter_20_0 + 1]:moveTo(arg_20_0._ballItems[iter_20_0]:getRootPos(), var_20_0, var_20_1)
		end
	end

	arg_20_0:updateCurUseMarbles()
end

function var_0_0._refreshBagAndSaveData(arg_21_0)
	gohelper.setActive(arg_21_0._holeItemAnims[1], arg_21_0._curPlaceList[1] == 0)

	for iter_21_0, iter_21_1 in pairs(arg_21_0._bagItems) do
		iter_21_1:setInfo(iter_21_0, arg_21_0._curBagDict[iter_21_0], arg_21_0._canPlaceNum)
	end

	local var_21_0 = {}

	for iter_21_2, iter_21_3 in ipairs(arg_21_0._curUseList) do
		table.insert(var_21_0, iter_21_3)
	end

	for iter_21_4, iter_21_5 in ipairs(arg_21_0._curPlaceList) do
		if iter_21_5 == 0 then
			break
		end

		table.insert(var_21_0, iter_21_5)
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_4_Act178MarblesPlace, table.concat(var_21_0, "#"))
	arg_21_0:updateCurUseMarbles()
end

function var_0_0._onDragBallItem(arg_22_0, arg_22_1)
	local var_22_0

	for iter_22_0, iter_22_1 in pairs(arg_22_0._ballItems) do
		if iter_22_1:isMouseOver() then
			var_22_0 = iter_22_1:getIndex()
		end
	end

	if not var_22_0 or var_22_0 == arg_22_1 then
		arg_22_0._ballItems[arg_22_1]:moveBack()
	else
		arg_22_0._curPlaceList[arg_22_1], arg_22_0._curPlaceList[var_22_0] = arg_22_0._curPlaceList[var_22_0], arg_22_0._curPlaceList[arg_22_1]

		UIBlockMgr.instance:startBlock("PinballGameView_Move_Swap")
		arg_22_0._ballItems[arg_22_1]:moveTo(arg_22_0._ballItems[var_22_0]:getRootPos(), arg_22_0.onMoveBack, arg_22_0)
		arg_22_0._ballItems[var_22_0]:moveTo(arg_22_0._ballItems[arg_22_1]:getRootPos())
	end
end

function var_0_0.onMoveBack(arg_23_0)
	UIBlockMgr.instance:endBlock("PinballGameView_Move_Swap")

	local var_23_0 = #arg_23_0._curPlaceList

	for iter_23_0, iter_23_1 in pairs(arg_23_0._ballItems) do
		if iter_23_0 <= var_23_0 then
			iter_23_1:setInfo(arg_23_0._curPlaceList[iter_23_0], iter_23_0, true)
		else
			iter_23_1:setInfo(arg_23_0._curUseList[iter_23_0 - var_23_0], iter_23_0, false)
		end
	end

	arg_23_0:_refreshBagAndSaveData()
end

function var_0_0._onGameRefresh(arg_24_0)
	if not arg_24_0._mapCo then
		return
	end

	TaskDispatcher.cancelTask(arg_24_0._frameAddRes, arg_24_0)

	local var_24_0 = PinballEntityMgr.instance:getAllEntity()

	for iter_24_0, iter_24_1 in pairs(var_24_0) do
		if iter_24_1:isResType() then
			iter_24_1:markDead()
		end
	end

	arg_24_0._addResList = {}

	for iter_24_2, iter_24_3 in pairs(arg_24_0._mapCo.units) do
		if PinballHelper.isResType(iter_24_3.unitType) then
			if iter_24_3.speed.x ~= 0 or iter_24_3.speed.y ~= 0 then
				PinballEntityMgr.instance:addEntity(iter_24_3.unitType, iter_24_3)
			else
				table.insert(arg_24_0._addResList, iter_24_3)
			end
		end
	end

	TaskDispatcher.runRepeat(arg_24_0._frameAddRes, arg_24_0, 0.02, -1)
end

function var_0_0._frameAddRes(arg_25_0)
	if not arg_25_0._addResList or not next(arg_25_0._addResList) then
		TaskDispatcher.cancelTask(arg_25_0._frameAddRes, arg_25_0)

		return
	end

	local var_25_0 = 0

	for iter_25_0, iter_25_1 in pairs(arg_25_0._addResList) do
		PinballEntityMgr.instance:addEntity(iter_25_1.unitType, iter_25_1)

		arg_25_0._addResList[iter_25_0] = nil
		var_25_0 = var_25_0 + 1

		if var_25_0 > 10 then
			return
		end
	end
end

function var_0_0.loadMapEntity(arg_26_0)
	local var_26_0 = lua_activity178_episode.configDict[VersionActivity2_4Enum.ActivityId.Pinball][PinballModel.instance.leftEpisodeId]

	if not var_26_0 then
		return
	end

	local var_26_1 = var_26_0.mapId
	local var_26_2 = PinballConfig.instance:getMapCo(var_26_1)

	if not var_26_2 then
		logError("地图配置不存在" .. var_26_1)

		return
	end

	arg_26_0._mapCo = var_26_2
	arg_26_0._episodeCO = var_26_0
	PinballModel.instance.leftEpisodeId = var_26_0.id

	for iter_26_0, iter_26_1 in pairs(var_26_2.units) do
		PinballEntityMgr.instance:addEntity(iter_26_1.unitType, iter_26_1)
	end

	arg_26_0._txtname.text = var_26_0.name
end

function var_0_0._refreshTask(arg_27_0)
	if not arg_27_0._episodeCO then
		return
	end

	local var_27_0 = string.splitToNumber(arg_27_0._episodeCO.target, "#")

	if not var_27_0 or #var_27_0 ~= 2 then
		logError("任务配置错误" .. arg_27_0._episodeCO.id)

		return
	end

	local var_27_1 = var_27_0[1]
	local var_27_2 = PinballModel.instance:getGameRes(var_27_1)
	local var_27_3 = var_27_0[2]
	local var_27_4 = Mathf.Clamp(var_27_2, 0, var_27_3)
	local var_27_5 = ""

	if var_27_1 == 0 then
		var_27_5 = luaLang("pinball_any_res")
	else
		local var_27_6 = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][var_27_1]

		if var_27_6 then
			var_27_5 = var_27_6.name
		end
	end

	arg_27_0._txttask.text = GameUtil.getSubPlaceholderLuaLang(luaLang("pinball_game_target"), {
		var_27_3,
		var_27_5,
		var_27_4,
		var_27_3
	})

	gohelper.setActive(arg_27_0._gotaskfinish, var_27_3 <= var_27_4)
end

function var_0_0._onBeginDrag(arg_28_0, arg_28_1, arg_28_2)
	gohelper.setActive(arg_28_0._goLine, true)
	arg_28_0:_calcLineAngleAndLen(arg_28_2)
	PinballController.instance:dispatchEvent(PinballEvent.OnWaitDragEnd)
end

function var_0_0._onDrag(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0:_calcLineAngleAndLen(arg_29_2)
end

function var_0_0._calcLineAngleAndLen(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1.position - arg_30_1.pressPosition
	local var_30_1 = math.sqrt(var_30_0.x * var_30_0.x + var_30_0.y * var_30_0.y)
	local var_30_2 = Mathf.Clamp(var_30_1, 40, 150)

	recthelper.setWidth(arg_30_0._transLine2, var_30_2 * 2)

	arg_30_0._value = (var_30_2 - 40) / 110

	local var_30_3 = math.abs(math.atan2(var_30_0.y, var_30_0.x) / math.pi) - 0.5
	local var_30_4 = Mathf.Clamp(var_30_3, -0.5, 0.5)

	arg_30_0._force = var_30_4

	local var_30_5 = var_30_4 * 180

	transformhelper.setLocalRotation(arg_30_0._transLine, 0, 0, var_30_5)
end

function var_0_0._onEndDrag(arg_31_0)
	gohelper.setActive(arg_31_0._goLine, false)

	local var_31_0 = arg_31_0._curPlaceList[1]

	if isDebugBuild and PinballModel.instance._gmball > 0 then
		var_31_0 = PinballModel.instance._gmball
	end

	local var_31_1 = PinballEntityMgr.instance:addEntity(var_31_0)

	var_31_1.x = arg_31_0._defaultPos.x
	var_31_1.y = arg_31_0._defaultPos.y

	local var_31_2 = arg_31_0._value * (PinballConst.Const24 - PinballConst.Const23) + PinballConst.Const23
	local var_31_3, var_31_4 = PinballHelper.rotateAngle(0, -var_31_2, arg_31_0._force * 180)

	var_31_1.vx = var_31_3 * var_31_1.speedScale
	var_31_1.vy = var_31_4 * var_31_1.speedScale

	var_31_1:tick(0)

	if not isDebugBuild or PinballModel.instance._gmball == 0 then
		arg_31_0:onBallUse()
	end
end

function var_0_0._checkDrag(arg_32_0)
	return not arg_32_0._curPlaceList[1] or arg_32_0._curPlaceList[1] <= 0 or arg_32_0._isPlaying
end

function var_0_0.onClose(arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._frameAddRes, arg_33_0)
	PinballEntityMgr.instance:clear()
	UIBlockMgr.instance:endBlock("PinballGameView_Move_Swap")
end

return var_0_0
