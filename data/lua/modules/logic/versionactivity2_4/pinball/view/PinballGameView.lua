module("modules.logic.versionactivity2_4.pinball.view.PinballGameView", package.seeall)

slot0 = class("PinballGameView", BaseView)

function slot0.onInitView(slot0)
	slot0._goDrag = gohelper.findChild(slot0.viewGO, "#go_drag")
	slot0._goDragArea = gohelper.findChild(slot0.viewGO, "#go_drag_area")
	slot0._goLine = gohelper.findChild(slot0.viewGO, "#go_drag/#go_line")
	slot0._goLine2 = gohelper.findChild(slot0.viewGO, "#go_drag/#go_line/line")
	slot0._txtname = gohelper.findChildTextMesh(slot0.viewGO, "Right/#txt_name")
	slot0._resItem = gohelper.findChild(slot0.viewGO, "Right/list/item")
	slot0._gobag = gohelper.findChild(slot0.viewGO, "#go_bag")
	slot0._btnOpenBag = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_click")
	slot0._btnCloseBag = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_bag/#btn_closebag")
	slot0._holeItem = gohelper.findChild(slot0.viewGO, "Left/holes/item")
	slot0._ballItem = gohelper.findChild(slot0.viewGO, "Left/balls/item")
	slot0._golighteff = gohelper.findChild(slot0.viewGO, "Left/light_eff")
	slot0._imageCurBall = gohelper.findChildImage(slot0.viewGO, "#go_drag/#image_icon")
	slot0._bagItem = gohelper.findChild(slot0.viewGO, "#go_bag/root/balls/item")
	slot0._txttask = gohelper.findChildTextMesh(slot0.viewGO, "Right/#txt_task")
	slot0._gotaskfinish = gohelper.findChild(slot0.viewGO, "Right/#go_taskFinished")
	slot0._transLine = slot0._goLine.transform
	slot0._transLine2 = slot0._goLine2.transform
end

function slot0.addEvents(slot0)
	slot0._btnOpenBag:AddClickListener(slot0._onClickOpenBag, slot0)
	slot0._btnCloseBag:AddClickListener(slot0._onClickCloseBag, slot0)
	CommonDragHelper.instance:registerDragObj(slot0._goDragArea, slot0._onBeginDrag, slot0._onDrag, slot0._onEndDrag, slot0._checkDrag, slot0, nil, true)
	PinballController.instance:registerCallback(PinballEvent.GameResRefresh, slot0._onGameRefresh, slot0)
	PinballController.instance:registerCallback(PinballEvent.ClickBagItem, slot0._onClickBagItem, slot0)
	PinballController.instance:registerCallback(PinballEvent.ClickMarbles, slot0._onClickBallItem, slot0)
	PinballController.instance:registerCallback(PinballEvent.DragMarblesEnd, slot0._onDragBallItem, slot0)
	PinballController.instance:registerCallback(PinballEvent.MarblesDead, slot0._onMarblesDead, slot0)
	PinballController.instance:registerCallback(PinballEvent.GameResChange, slot0._refreshTask, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onViewClose, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnOpenBag:RemoveClickListener()
	slot0._btnCloseBag:RemoveClickListener()
	CommonDragHelper.instance:unregisterDragObj(slot0._goDragArea)
	PinballController.instance:unregisterCallback(PinballEvent.GameResRefresh, slot0._onGameRefresh, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.ClickBagItem, slot0._onClickBagItem, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.ClickMarbles, slot0._onClickBallItem, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.DragMarblesEnd, slot0._onDragBallItem, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.MarblesDead, slot0._onMarblesDead, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.GameResChange, slot0._refreshTask, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onViewClose, slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio12)
	PinballModel.instance:clearGameRes()
	gohelper.setActive(slot0._goLine, false)
	gohelper.setActive(slot0._gobag, false)
	PinballEntityMgr.instance:beginTick()
	slot0:_onScreenResize()
	slot0:loadMapEntity()
	slot0:createResItem()
	slot0:initMarbles()
	slot0:_refreshTask()
	gohelper.setActive(slot0._holeItemAnims[1], slot0._curPlaceList[1] == 0)
end

function slot0._onScreenResize(slot0)
	slot1, slot2 = recthelper.getAnchor(slot0._goDrag.transform)
	slot0._defaultPos = Vector2(slot1, slot2)
end

function slot0.createResItem(slot0)
	gohelper.CreateObjList(slot0, slot0._createResItem, {
		PinballEnum.ResType.Wood,
		PinballEnum.ResType.Mine,
		PinballEnum.ResType.Stone,
		PinballEnum.ResType.Food
	}, nil, slot0._resItem, PinballGameResItem)
end

function slot0._createResItem(slot0, slot1, slot2, slot3)
	slot1:setData(slot2)
end

function slot0._onViewClose(slot0, slot1)
	if slot1 ~= ViewName.PinballStartLoadingView then
		return
	end

	for slot7, slot8 in pairs(PinballModel.instance:getAllMarblesNum()) do
		if slot8 > 0 then
			slot3 = 0 + 1
		end
	end

	if slot3 >= 2 then
		PinballController.instance:dispatchEvent(PinballEvent.GuideUnlockBallInGame)
	end
end

function slot0.initMarbles(slot0)
	slot1, slot2, slot3 = PinballModel.instance:getAllMarblesNum()

	if slot2 < #(string.splitToNumber(GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_4_Act178MarblesPlace, ""), "#") or {}) or not slot0:checkMarble(slot1, slot5) then
		slot5 = {}

		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_4_Act178MarblesPlace, "")
	end

	slot7 = {
		[slot11] = 1
	}
	slot0._canPlaceNum = slot2
	slot0._curBagDict = slot1
	slot0._curUseList = {}

	PinballStatHelper.instance:setCurUseBallList(slot0._curUseList)

	slot0._curPlaceList = {}

	for slot11 = 1, slot2 do
		if slot5[slot11] then
			slot6[slot11] = slot5[slot11]
			slot0._canPlaceNum = slot0._canPlaceNum - 1
			slot1[slot5[slot11]] = slot1[slot5[slot11]] - 1
		else
			slot6[slot11] = 0
		end
	end

	for slot11 = slot2 + 1, slot3 do
		slot7[slot11] = 2
	end

	slot0._holeItemAnims = slot0:getUserDataTb_()
	slot0._bagItems = {}
	slot0._ballItems = {}

	gohelper.CreateObjList(slot0, slot0._createHole, slot7, nil, slot0._holeItem)
	gohelper.CreateObjList(slot0, slot0._createBall, slot6, nil, slot0._ballItem, PinballGameBallItem)
	gohelper.CreateObjList(slot0, slot0._createBagItem, {
		PinballEnum.UnitType.MarblesNormal,
		PinballEnum.UnitType.MarblesDivision,
		PinballEnum.UnitType.MarblesGlass,
		PinballEnum.UnitType.MarblesExplosion,
		PinballEnum.UnitType.MarblesElasticity
	}, nil, slot0._bagItem, PinballBagItem)

	if GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Version2_4_Act178HoleNum, PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.DefaultMarblesHoleNum)) < slot2 then
		GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.Version2_4_Act178HoleNum, slot2)

		for slot14 = slot10 + 1, slot2 do
		end
	end

	slot0:updateCurUseMarbles()
end

function slot0.checkMarble(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in pairs(slot2) do
		slot3[slot8] = (slot3[slot8] or 0) + 1
	end

	for slot7, slot8 in pairs(slot1) do
		if slot3[slot7] and slot8 < slot3[slot7] then
			return false
		end
	end

	return true
end

function slot0._createHole(slot0, slot1, slot2, slot3)
	slot0._holeItemAnims[slot3] = gohelper.findChild(slot1, "vx_eff")

	gohelper.setActive(slot0._holeItemAnims[slot3], false)
	gohelper.setActive(gohelper.findChild(slot1, "#go_lock"), slot2 == 2)
end

function slot0._createBagItem(slot0, slot1, slot2, slot3)
	slot0._bagItems[slot2] = slot1

	slot1:setInfo(slot2, slot0._curBagDict[slot2], slot0._canPlaceNum)
end

function slot0._createBall(slot0, slot1, slot2, slot3)
	slot0._ballItems[slot3] = slot1

	slot1:setInfo(slot2, slot3, true)
end

function slot0._onMarblesDead(slot0)
	slot0._isPlaying = false

	if #slot0._curPlaceList > 0 then
		slot0:updateCurUseMarbles()
	else
		PinballEntityMgr.instance:pauseTick()
		Activity178Rpc.instance:sendAct178EndEpisode(VersionActivity2_4Enum.ActivityId.Pinball, PinballModel.instance.gameAddResDict, PinballModel.instance.leftEpisodeId)
	end
end

function slot0.updateCurUseMarbles(slot0)
	slot1 = 0

	if not slot0._isPlaying then
		slot1 = slot0._curPlaceList[1]
	end

	if slot0._showId ~= slot1 then
		slot0._showId = slot1

		gohelper.setActive(slot0._goDrag, slot1 > 0)
		gohelper.setActive(slot0._golighteff, slot1 > 0)

		if slot1 > 0 then
			slot2 = lua_activity178_marbles.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot1]

			UISpriteSetMgr.instance:setAct178Sprite(slot0._imageCurBall, slot2.icon, true)

			slot4 = string.splitToNumber(slot2.radius, "#") or {}
			slot6 = PinballConst.Const7_1 * (slot4[PinballModel.instance:getMarblesLvCache(slot1)] or slot4[#slot4] or 1000) / 1000

			transformhelper.setLocalScale(slot0._goDrag.transform, slot6, slot6, slot6)
		end
	end
end

function slot0._onClickOpenBag(slot0)
	if PinballHelper.isBanOper() then
		return
	end

	gohelper.setActive(slot0._gobag, true)
end

function slot0._onClickCloseBag(slot0)
	gohelper.setActive(slot0._gobag, false)
end

function slot0._onClickBagItem(slot0, slot1)
	slot0._curBagDict[slot1] = slot0._curBagDict[slot1] - 1
	slot0._canPlaceNum = slot0._canPlaceNum - 1
	slot2 = #slot0._curPlaceList
	slot3 = slot2 - slot0._canPlaceNum
	slot0._curPlaceList[slot3] = slot1

	slot0._ballItems[slot3]:setInfo(slot1, slot3, slot3 <= slot2)
	slot0:_refreshBagAndSaveData()
end

function slot0._onClickBallItem(slot0, slot1)
	if PinballHelper.isBanOper() then
		return
	end

	if not slot0._gobag.activeSelf then
		gohelper.setActive(slot0._gobag, true)

		return
	end

	if slot0._curPlaceList[slot1] == 0 or not slot0._curPlaceList[slot1] then
		return
	end

	slot2 = table.remove(slot0._curPlaceList, slot1)

	table.insert(slot0._curPlaceList, 0)

	slot0._canPlaceNum = slot0._canPlaceNum + 1
	slot0._curBagDict[slot2] = slot0._curBagDict[slot2] + 1

	slot0._ballItems[slot1]:setInfo(0, slot1, true)

	if slot0._curPlaceList[slot1] == 0 then
		slot0:_refreshBagAndSaveData()
	else
		for slot6 = slot1 + 1, #slot0._curPlaceList do
			slot7, slot8 = nil

			if slot6 == slot1 + 1 then
				UIBlockMgr.instance:startBlock("PinballGameView_Move_Swap")

				slot8 = slot0
				slot7 = slot0.onMoveBack
			end

			slot0._ballItems[slot6]:moveTo(slot0._ballItems[slot6 - 1]:getRootPos(), slot7, slot8)
		end
	end
end

function slot0.onBallUse(slot0)
	slot0._isPlaying = true

	table.insert(slot0._curUseList, table.remove(slot0._curPlaceList, 1))
	slot0._ballItems[1]:setInfo(0, 1, slot0._curPlaceList[1] and true or false)

	if #slot0._curPlaceList > 0 then
		for slot4 = 1, #slot0._curPlaceList do
			slot5, slot6 = nil

			if slot4 == 1 then
				UIBlockMgr.instance:startBlock("PinballGameView_Move_Swap")

				slot6 = slot0
				slot5 = slot0.onMoveBack
			end

			slot0._ballItems[slot4 + 1]:moveTo(slot0._ballItems[slot4]:getRootPos(), slot5, slot6)
		end
	end

	slot0:updateCurUseMarbles()
end

function slot0._refreshBagAndSaveData(slot0)
	gohelper.setActive(slot0._holeItemAnims[1], slot0._curPlaceList[1] == 0)

	for slot4, slot5 in pairs(slot0._bagItems) do
		slot5:setInfo(slot4, slot0._curBagDict[slot4], slot0._canPlaceNum)
	end

	for slot5, slot6 in ipairs(slot0._curUseList) do
		table.insert({}, slot6)
	end

	for slot5, slot6 in ipairs(slot0._curPlaceList) do
		if slot6 == 0 then
			break
		end

		table.insert(slot1, slot6)
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_4_Act178MarblesPlace, table.concat(slot1, "#"))
	slot0:updateCurUseMarbles()
end

function slot0._onDragBallItem(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in pairs(slot0._ballItems) do
		if slot7:isMouseOver() then
			slot2 = slot7:getIndex()
		end
	end

	if not slot2 or slot2 == slot1 then
		slot0._ballItems[slot1]:moveBack()
	else
		slot0._curPlaceList[slot2] = slot0._curPlaceList[slot1]
		slot0._curPlaceList[slot1] = slot0._curPlaceList[slot2]

		UIBlockMgr.instance:startBlock("PinballGameView_Move_Swap")
		slot0._ballItems[slot1]:moveTo(slot0._ballItems[slot2]:getRootPos(), slot0.onMoveBack, slot0)
		slot0._ballItems[slot2]:moveTo(slot0._ballItems[slot1]:getRootPos())
	end
end

function slot0.onMoveBack(slot0)
	UIBlockMgr.instance:endBlock("PinballGameView_Move_Swap")

	for slot5, slot6 in pairs(slot0._ballItems) do
		if slot5 <= #slot0._curPlaceList then
			slot6:setInfo(slot0._curPlaceList[slot5], slot5, true)
		else
			slot6:setInfo(slot0._curUseList[slot5 - slot1], slot5, false)
		end
	end

	slot0:_refreshBagAndSaveData()
end

function slot0._onGameRefresh(slot0)
	if not slot0._mapCo then
		return
	end

	TaskDispatcher.cancelTask(slot0._frameAddRes, slot0)

	for slot5, slot6 in pairs(PinballEntityMgr.instance:getAllEntity()) do
		if slot6:isResType() then
			slot6:markDead()
		end
	end

	slot0._addResList = {}

	for slot5, slot6 in pairs(slot0._mapCo.units) do
		if PinballHelper.isResType(slot6.unitType) then
			if slot6.speed.x ~= 0 or slot6.speed.y ~= 0 then
				PinballEntityMgr.instance:addEntity(slot6.unitType, slot6)
			else
				table.insert(slot0._addResList, slot6)
			end
		end
	end

	TaskDispatcher.runRepeat(slot0._frameAddRes, slot0, 0.02, -1)
end

function slot0._frameAddRes(slot0)
	if not slot0._addResList or not next(slot0._addResList) then
		TaskDispatcher.cancelTask(slot0._frameAddRes, slot0)

		return
	end

	for slot5, slot6 in pairs(slot0._addResList) do
		PinballEntityMgr.instance:addEntity(slot6.unitType, slot6)

		slot0._addResList[slot5] = nil

		if 0 + 1 > 10 then
			return
		end
	end
end

function slot0.loadMapEntity(slot0)
	if not lua_activity178_episode.configDict[VersionActivity2_4Enum.ActivityId.Pinball][PinballModel.instance.leftEpisodeId] then
		return
	end

	if not PinballConfig.instance:getMapCo(slot1.mapId) then
		logError("地图配置不存在" .. slot2)

		return
	end

	slot0._mapCo = slot3
	slot0._episodeCO = slot1
	PinballModel.instance.leftEpisodeId = slot1.id

	for slot7, slot8 in pairs(slot3.units) do
		PinballEntityMgr.instance:addEntity(slot8.unitType, slot8)
	end

	slot0._txtname.text = slot1.name
end

function slot0._refreshTask(slot0)
	if not slot0._episodeCO then
		return
	end

	if not string.splitToNumber(slot0._episodeCO.target, "#") or #slot1 ~= 2 then
		logError("任务配置错误" .. slot0._episodeCO.id)

		return
	end

	slot2 = slot1[1]
	slot3 = Mathf.Clamp(PinballModel.instance:getGameRes(slot2), 0, slot1[2])
	slot5 = ""

	if slot2 == 0 then
		slot5 = luaLang("pinball_any_res")
	elseif lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot2] then
		slot5 = slot6.name
	end

	slot0._txttask.text = GameUtil.getSubPlaceholderLuaLang(luaLang("pinball_game_target"), {
		slot4,
		slot5,
		slot3,
		slot4
	})

	gohelper.setActive(slot0._gotaskfinish, slot4 <= slot3)
end

function slot0._onBeginDrag(slot0, slot1, slot2)
	gohelper.setActive(slot0._goLine, true)
	slot0:_calcLineAngleAndLen(slot2)
	PinballController.instance:dispatchEvent(PinballEvent.OnWaitDragEnd)
end

function slot0._onDrag(slot0, slot1, slot2)
	slot0:_calcLineAngleAndLen(slot2)
end

function slot0._calcLineAngleAndLen(slot0, slot1)
	slot2 = slot1.position - slot1.pressPosition
	slot3 = Mathf.Clamp(math.sqrt(slot2.x * slot2.x + slot2.y * slot2.y), 40, 150)

	recthelper.setWidth(slot0._transLine2, slot3 * 2)

	slot0._value = (slot3 - 40) / 110
	slot4 = Mathf.Clamp(math.abs(math.atan2(slot2.y, slot2.x) / math.pi) - 0.5, -0.5, 0.5)
	slot0._force = slot4

	transformhelper.setLocalRotation(slot0._transLine, 0, 0, slot4 * 180)
end

function slot0._onEndDrag(slot0)
	gohelper.setActive(slot0._goLine, false)

	slot1 = slot0._curPlaceList[1]

	if isDebugBuild and PinballModel.instance._gmball > 0 then
		slot1 = PinballModel.instance._gmball
	end

	slot2 = PinballEntityMgr.instance:addEntity(slot1)
	slot2.x = slot0._defaultPos.x
	slot2.y = slot0._defaultPos.y
	slot4, slot5 = PinballHelper.rotateAngle(0, -(slot0._value * (PinballConst.Const24 - PinballConst.Const23) + PinballConst.Const23), slot0._force * 180)
	slot2.vx = slot4 * slot2.speedScale
	slot2.vy = slot5 * slot2.speedScale

	slot2:tick(0)

	if not isDebugBuild or PinballModel.instance._gmball == 0 then
		slot0:onBallUse()
	end
end

function slot0._checkDrag(slot0)
	return not slot0._curPlaceList[1] or slot0._curPlaceList[1] <= 0 or slot0._isPlaying
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._frameAddRes, slot0)
	PinballEntityMgr.instance:clear()
	UIBlockMgr.instance:endBlock("PinballGameView_Move_Swap")
end

return slot0
