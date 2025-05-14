module("modules.logic.activity.controller.chessmap.ActivityChessGameController", package.seeall)

local var_0_0 = class("ActivityChessGameController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.release(arg_3_0)
	if arg_3_0.interacts then
		arg_3_0.interacts:removeAll()
	end

	if arg_3_0.event then
		arg_3_0.event:removeAll()
	end

	arg_3_0._treeComp = nil
	arg_3_0.interacts = nil
	arg_3_0.event = nil
	arg_3_0._hasMap = false
end

function var_0_0.enterChessGame(arg_4_0, arg_4_1, arg_4_2)
	logNormal("ActivityChessGameController : enterChessGame!")

	local var_4_0 = Activity109ChessModel.instance:getEpisodeId()

	GuideController.instance:dispatchEvent(GuideEvent["OnChessEnter" .. var_4_0])
	arg_4_0:initData(arg_4_1, arg_4_2)
	ViewMgr.instance:openView(ViewName.ActivityChessGame, arg_4_0:packViewParam())
	Activity109ChessController.instance:statStart()
end

function var_0_0.packViewParam(arg_5_0)
	return {
		fromRefuseBattle = Activity109ChessController.instance:getFromRefuseBattle()
	}
end

function var_0_0.initData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._treeComp = ActivityChessGameTree.New()

	ActivityChessGameModel.instance:initData(arg_6_1, arg_6_2)

	arg_6_0._tempSelectObjId = nil

	local var_6_0 = Activity109Config.instance:getMapCo(arg_6_1, arg_6_2)

	if var_6_0 and not string.nilorempty(var_6_0.offset) then
		local var_6_1 = string.splitToNumber(var_6_0.offset, ",")

		arg_6_0._cacheOffsetX = var_6_1[1]
		arg_6_0._cacheOffsetY = var_6_1[2]
	else
		arg_6_0._cacheOffsetX = nil
		arg_6_0._cacheOffsetY = nil
	end
end

function var_0_0.initServerMap(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:setClickStatus(ActivityChessEnum.SelectPosStatus.None)
	arg_7_0:setSelectObj(nil)

	arg_7_0.interacts = arg_7_0.interacts or ActivityChessInteractMgr.New()

	arg_7_0.interacts:removeAll()
	ActivityChessGameModel.instance:initObjects(arg_7_1, arg_7_2.interactObjects)
	arg_7_0:initObjects()

	arg_7_0.event = arg_7_0.event or ActivityChessEventMgr.New()

	arg_7_0.event:removeAll()
	arg_7_0.event:setCurEvent(arg_7_2.currentEvent)
	ActivityChessGameModel.instance:setRound(arg_7_2.currentRound)
	ActivityChessGameModel.instance:setResult(nil)
	ActivityChessGameModel.instance:updateFinishInteracts(arg_7_2.finishInteracts)

	arg_7_0._hasMap = true
end

function var_0_0.initObjects(arg_8_0)
	local var_8_0 = ActivityChessGameModel.instance:getInteractDatas()

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1 = ActivityChessInteractObject.New()

		var_8_1:init(iter_8_1)

		if var_8_1.config ~= nil then
			arg_8_0.interacts:add(var_8_1)
		end
	end

	local var_8_2 = arg_8_0.interacts:getList()

	for iter_8_2, iter_8_3 in ipairs(var_8_2) do
		iter_8_3.goToObject:init()
	end

	arg_8_0:dispatchEvent(ActivityChessEvent.AllObjectCreated)
end

function var_0_0.initSceneTree(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._treeSceneComp = ActivityChessGameTree.New()
	arg_9_0._offsetSceneY = arg_9_2

	local var_9_0 = arg_9_0._treeSceneComp:createLeaveNode()
	local var_9_1, var_9_2 = ActivityChessGameModel.instance:getGameSize()

	for iter_9_0 = 1, var_9_1 do
		for iter_9_1 = 1, var_9_2 do
			local var_9_3 = {}
			local var_9_4, var_9_5, var_9_6 = arg_9_0:calcTilePosInScene(iter_9_0 - 1, iter_9_1 - 1)
			local var_9_7 = recthelper.worldPosToAnchorPos(Vector3.New(var_9_4, var_9_5 + arg_9_2, 0), arg_9_1.transform)

			var_9_3.x, var_9_3.y = var_9_7.x, var_9_7.y
			var_9_3.tileX, var_9_3.tileY = iter_9_0 - 1, iter_9_1 - 1

			table.insert(var_9_0.nodes, var_9_3)

			var_9_0.keys = var_9_3
		end
	end

	arg_9_0._treeSceneComp:growToBranch(var_9_0)
	arg_9_0._treeSceneComp:buildTree(var_9_0)
end

function var_0_0.calcTilePosInScene(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = ActivityChessEnum.TileShowSettings
	local var_10_1
	local var_10_2

	if not arg_10_0._cacheOffsetX then
		var_10_1, var_10_2 = arg_10_1 * var_10_0.width + var_10_0.offsetX * arg_10_2 + var_10_0.offsetXY * (arg_10_1 + arg_10_2) + ActivityChessEnum.ChessBoardOffsetX, arg_10_2 * var_10_0.height + var_10_0.offsetY * arg_10_1 + var_10_0.offsetYX * (arg_10_1 + arg_10_2) + ActivityChessEnum.ChessBoardOffsetY
	else
		var_10_1, var_10_2 = arg_10_1 * var_10_0.width + var_10_0.offsetX * arg_10_2 + var_10_0.offsetXY * (arg_10_1 + arg_10_2) + arg_10_0._cacheOffsetX, arg_10_2 * var_10_0.height + var_10_0.offsetY * arg_10_1 + var_10_0.offsetYX * (arg_10_1 + arg_10_2) + arg_10_0._cacheOffsetY
	end

	return var_10_1 * 0.01, var_10_2 * 0.01, var_10_2 * 0.001 + (arg_10_3 or 0) * 1e-06
end

function var_0_0.getOffsetSceneY(arg_11_0)
	return arg_11_0._offsetSceneY
end

function var_0_0.addInteractObj(arg_12_0, arg_12_1)
	local var_12_0 = ActivityChessInteractObject.New()

	var_12_0:init(arg_12_1)
	arg_12_0.interacts:add(var_12_0)
	var_12_0.goToObject:init()
	arg_12_0:dispatchEvent(ActivityChessEvent.InteractObjectCreated, var_12_0)
end

function var_0_0.deleteInteractObj(arg_13_0, arg_13_1)
	arg_13_0.interacts:remove(arg_13_1)
end

function var_0_0.searchInteractByPos(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_0.interacts:getList()
	local var_14_1
	local var_14_2
	local var_14_3 = 0

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if iter_14_1.originData.posX == arg_14_1 and iter_14_1.originData.posY == arg_14_2 and (not arg_14_3 or arg_14_3(iter_14_1)) then
			if var_14_1 ~= nil then
				var_14_2 = var_14_2 or {
					var_14_1
				}

				table.insert(var_14_2, iter_14_1)
			else
				var_14_1 = iter_14_1
			end

			var_14_3 = var_14_3 + 1
		end
	end

	if var_14_3 > 1 then
		table.sort(var_14_2, var_0_0.sortSelectObj)
	end

	return var_14_3, var_14_2 or var_14_1
end

function var_0_0.sortSelectObj(arg_15_0, arg_15_1)
	return arg_15_0:getSelectPriority() < arg_15_1:getSelectPriority()
end

function var_0_0.filterSelectable(arg_16_0)
	return arg_16_0.config and arg_16_0.config.interactType == ActivityChessEnum.InteractType.Player
end

function var_0_0.existGame(arg_17_0)
	return arg_17_0._hasMap
end

function var_0_0.setSelectObj(arg_18_0, arg_18_1)
	if arg_18_0._selectObj == arg_18_1 then
		return
	end

	if arg_18_0._selectObj ~= nil and arg_18_0._selectObj:getHandler() then
		arg_18_0._selectObj:getHandler():onCancelSelect()
	end

	arg_18_0._selectObj = arg_18_1

	if arg_18_1 ~= nil and arg_18_0._selectObj:getHandler() then
		arg_18_1:getHandler():onSelectCall()
	end
end

function var_0_0.saveTempSelectObj(arg_19_0)
	if arg_19_0._selectObj then
		arg_19_0._tempSelectObjId = arg_19_0._selectObj.id
	end
end

function var_0_0.tryResumeSelectObj(arg_20_0)
	if arg_20_0.interacts and arg_20_0._tempSelectObjId then
		local var_20_0 = arg_20_0.interacts:get(arg_20_0._tempSelectObjId)

		if var_20_0 then
			arg_20_0:setSelectObj(var_20_0)

			arg_20_0._tempSelectObjId = nil

			return true
		end
	end

	return false
end

function var_0_0.syncServerMap(arg_21_0)
	local var_21_0 = ActivityChessGameModel.instance:getActId()
	local var_21_1 = ActivityChessGameModel.instance:getMapId()

	arg_21_0._tempInteractMgr = arg_21_0.interacts
	arg_21_0._tempEventMgr = arg_21_0.event

	if var_21_0 and var_21_1 then
		arg_21_0.interacts = nil
		arg_21_0.event = nil

		ActivityChessGameModel.instance:release()
		ActivityChessGameModel.instance:initData(var_21_0, var_21_1)
		Activity109Rpc.instance:sendGetAct109InfoRequest(var_21_0, arg_21_0.onReceiveWhenSync, arg_21_0)
		arg_21_0:dispatchEvent(ActivityChessEvent.ResetMapView)
	end
end

function var_0_0.onReceiveWhenSync(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_2 ~= 0 then
		return
	end

	local var_22_0 = ActivityChessGameModel.instance:getActId()
	local var_22_1 = ActivityChessGameModel.instance:getMapId()

	if var_22_0 and var_22_1 then
		if arg_22_0._tempInteractMgr then
			arg_22_0._tempInteractMgr:dispose()

			arg_22_0._tempInteractMgr = nil
		end

		if arg_22_0._tempEventMgr then
			arg_22_0._tempEventMgr:removeAll()

			arg_22_0._tempEventMgr = nil
		end

		arg_22_0:initData(var_22_0, var_22_1)
		arg_22_0:initObjects()
	end
end

function var_0_0.getSelectObj(arg_23_0)
	return arg_23_0._selectObj
end

function var_0_0.setClickStatus(arg_24_0, arg_24_1)
	arg_24_0._clickStatus = arg_24_1
end

function var_0_0.getClickStatus(arg_25_0)
	return arg_25_0._clickStatus
end

function var_0_0.autoSelectPlayer(arg_26_0)
	if not arg_26_0.interacts then
		return
	end

	local var_26_0 = arg_26_0.interacts:getList()

	if var_26_0 then
		local var_26_1 = {}

		for iter_26_0, iter_26_1 in pairs(var_26_0) do
			if iter_26_1.config and iter_26_1.config.interactType == ActivityChessEnum.InteractType.Player then
				table.insert(var_26_1, iter_26_1)
			end
		end

		table.sort(var_26_1, var_0_0.sortInteractObjById)

		if #var_26_1 > 0 then
			arg_26_0:setSelectObj(var_26_1[1])
		end
	end
end

function var_0_0.sortInteractObjById(arg_27_0, arg_27_1)
	return arg_27_0.id < arg_27_1.id
end

function var_0_0.gameClear(arg_28_0)
	ActivityChessGameModel.instance:setResult(true)
	arg_28_0:dispatchEvent(ActivityChessEvent.SetViewVictory)
	arg_28_0:dispatchEvent(ActivityChessEvent.CurrentConditionUpdate)
end

function var_0_0.gameOver(arg_29_0)
	ActivityChessGameModel.instance:setResult(false)
	arg_29_0:dispatchEvent(ActivityChessEvent.SetViewFail)
	arg_29_0:dispatchEvent(ActivityChessEvent.CurrentConditionUpdate)
end

function var_0_0.checkInActivityDuration(arg_30_0)
	local var_30_0 = ActivityChessGameModel.instance:getActId()
	local var_30_1 = ActivityModel.instance:getActMO(var_30_0)

	if var_30_1 ~= nil and ActivityModel.instance:isActOnLine(var_30_0) and var_30_1:isOpen() and not var_30_1:isExpired() then
		return true
	end

	arg_30_0:closeViewFromActivityExpired()

	return false
end

function var_0_0.closeViewFromActivityExpired(arg_31_0)
	local function var_31_0()
		ViewMgr.instance:closeView(ViewName.ActivityChessGame)
		ViewMgr.instance:closeView(ViewName.Activity109ChessEntry)
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, var_31_0)
end

function var_0_0.posCanWalk(arg_33_0, arg_33_1, arg_33_2)
	if ActivityChessGameModel.instance:isPosInChessBoard(arg_33_1, arg_33_2) and ActivityChessGameModel.instance:getBaseTile(arg_33_1, arg_33_2) ~= ActivityChessEnum.TileBaseType.None then
		return arg_33_0:posObjCanWalk(arg_33_1, arg_33_2)
	end

	return false
end

function var_0_0.posObjCanWalk(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0, var_34_1 = arg_34_0:searchInteractByPos(arg_34_1, arg_34_2)

	if var_34_0 == 1 then
		if var_34_1 and var_34_1:canBlock() then
			return false
		end
	elseif var_34_0 > 1 then
		for iter_34_0 = 1, var_34_0 do
			if var_34_1[iter_34_0] and var_34_1[iter_34_0]:canBlock() then
				return false
			end
		end
	else
		return true
	end

	return true
end

function var_0_0.getNearestScenePos(arg_35_0, arg_35_1, arg_35_2)
	if not arg_35_0._treeSceneComp then
		return nil
	end

	local var_35_0 = arg_35_0._treeSceneComp:search(arg_35_1, arg_35_2)
	local var_35_1 = 99999999
	local var_35_2
	local var_35_3 = ActivityChessEnum.ClickYWeight

	if var_35_0 then
		for iter_35_0 = 1, #var_35_0 do
			local var_35_4 = var_35_0[iter_35_0]
			local var_35_5 = var_35_4.x - arg_35_1
			local var_35_6 = var_35_4.y - arg_35_2

			if math.abs(var_35_5) <= ActivityChessEnum.ClickRangeX and math.abs(var_35_6) <= ActivityChessEnum.ClickRangeY then
				local var_35_7 = var_35_5 * var_35_5 + var_35_6 * var_35_6 * var_35_3

				if var_35_7 < var_35_1 then
					var_35_2 = var_35_4
					var_35_1 = var_35_7
				end
			end
		end
	end

	if var_35_2 then
		return var_35_2.tileX, var_35_2.tileY
	else
		return nil
	end
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
