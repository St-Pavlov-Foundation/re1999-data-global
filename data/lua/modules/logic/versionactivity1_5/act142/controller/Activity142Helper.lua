module("modules.logic.versionactivity1_5.act142.controller.Activity142Helper", package.seeall)

slot1 = {
	[Va3ChessEnum.Direction.Up] = 1,
	[Va3ChessEnum.Direction.Down] = -1,
	[Va3ChessEnum.Direction.Left] = 1,
	[Va3ChessEnum.Direction.Right] = -1
}

return {
	showToastByEpisodeId = function (slot0)
		if not Activity142Config.instance:getEpisodeCo(Activity142Model.instance:getActivityId(), slot0, true) then
			return
		end

		if not Activity142Model.instance:isOpenDay(slot1, slot0) then
			GameFacade.showToast(ToastEnum.Activity142EpisodeNotInOpenDay)

			return
		end

		if not Activity142Model.instance:isPreEpisodeClear(slot1, slot0) then
			GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)
		end
	end,
	setAct142UIBlock = function (slot0, slot1)
		if slot0 then
			UIBlockMgr.instance:startBlock(slot1 or Activity142Enum.UI_BlOCK_KEY)
		else
			UIBlockMgr.instance:endBlock(slot1 or Activity142Enum.UI_BlOCK_KEY)
		end
	end,
	openWinResult = function ()
		slot1 = "OnChessWinPause" .. Va3ChessModel.instance:getEpisodeId()

		GuideController.instance:GuideFlowPauseAndContinue(slot1, GuideEvent[slot1], GuideEvent.OnChessWinContinue, uv0._openSuccessView, nil)
	end,
	_openSuccessView = function ()
		AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)
		ViewMgr.instance:openView(ViewName.Activity142ResultView)
	end,
	checkConditionIsFinish = function (slot0, slot1)
		if not GameUtil.splitString2(slot0, true, "|", "#") then
			return true
		end

		for slot7, slot8 in ipairs(slot3) do
			if not Va3ChessMapUtils.isClearConditionFinish(slot8, slot1) then
				slot2 = false

				break
			end
		end

		return slot2
	end,
	filterInteractType = function (slot0, slot1)
		slot2 = false

		if slot1 and slot0 and slot0.config then
			slot2 = slot1[slot0.config.interactType] or false
		end

		return slot2
	end,
	filterCanBlockFireBall = function (slot0)
		return uv0.filterInteractType(slot0, Activity142Enum.CanBlockFireBallInteractType)
	end,
	filterCanMoveKill = function (slot0)
		return uv0.filterInteractType(slot0, Activity142Enum.CanMoveKillInteractType)
	end,
	filterCanFireKill = function (slot0)
		return uv0.filterInteractType(slot0, Activity142Enum.CanFireKillInteractType)
	end,
	getBaffleDataList = function (slot0, slot1)
		slot2 = {}

		for slot6, slot7 in pairs(Va3ChessEnum.Direction) do
			if uv0.isHasBaffleInDir(slot0, slot7) then
				slot9 = slot7 - 1
				slot2[#slot2 + 1] = {
					direction = slot7,
					type = bit.rshift(bit.band(slot1, bit.lshift(3, slot9)), slot9)
				}
			end
		end

		return slot2
	end,
	isHasBaffleInDir = function (slot0, slot1)
		slot2 = false

		return bit.band(slot0, bit.lshift(1, slot1)) ~= 0
	end,
	calBafflePosInScene = function (slot0, slot1, slot2)
		slot4, slot5, slot6 = Va3ChessGameController.instance:calcTilePosInScene(slot0, slot1, uv0[slot2], true)

		if slot2 == Va3ChessEnum.Direction.Left then
			slot4 = slot4 - Activity142Enum.BaffleOffset.baffleOffsetX
			slot5 = slot5 + Activity142Enum.BaffleOffset.baffleOffsetY
		elseif slot2 == Va3ChessEnum.Direction.Up then
			slot4 = slot4 + Activity142Enum.BaffleOffset.baffleOffsetX
			slot5 = slot5 + Activity142Enum.BaffleOffset.baffleOffsetY
		elseif slot2 == Va3ChessEnum.Direction.Right then
			slot4 = slot4 + Activity142Enum.BaffleOffset.baffleOffsetX
			slot5 = slot5 - Activity142Enum.BaffleOffset.baffleOffsetY
		elseif slot2 == Va3ChessEnum.Direction.Down then
			slot4 = slot4 - Activity142Enum.BaffleOffset.baffleOffsetX
			slot5 = slot5 - Activity142Enum.BaffleOffset.baffleOffsetY
		else
			logError("un support direction, please check ... " .. slot2)
		end

		return slot4, slot5, slot6
	end,
	getBaffleResPath = function (slot0)
		if not slot0 then
			return
		end

		if not slot0.direction or not slot0.type then
			return
		end

		if slot1 == Va3ChessEnum.Direction.Left or slot1 == Va3ChessEnum.Direction.Right then
			return Activity142Enum.VerBaffleResPath[slot2] or Activity142Enum.VerBaffleResPath[1]
		else
			return Activity142Enum.HorBaffleResPath[slot2] or Activity142Enum.HorBaffleResPath[1]
		end
	end,
	isSurroundPlayer = function (slot0, slot1)
		if not (Va3ChessGameController.instance.interacts and slot3:getMainPlayer(true)) then
			return false
		end

		slot6 = slot4.originData.posY

		return slot4.originData.posX == slot0 and math.abs(slot6 - slot1) == 1 or slot6 == slot1 and math.abs(slot5 - slot0) == 1
	end,
	isCanMoveKill = function (slot0)
		if not slot0 then
			return false
		end

		if uv0.isSurroundPlayer(slot0.originData.posX, slot0.originData.posY) and (Va3ChessGameController.instance.interacts and slot5:getMainPlayer(true) or nil) then
			slot1 = Va3ChessGameController.instance:posCanWalk(slot2, slot3, Va3ChessMapUtils.ToDirection(slot6.originData.posX, slot6.originData.posY, slot2, slot3), slot6.objType) and (Activity142Enum.CanMoveKillInteractType[slot0:getObjType()] or false)
		end

		return slot1
	end,
	isCanFireKill = function (slot0)
		slot4 = Va3ChessGameController.instance.interacts and slot3:getMainPlayer(true)

		if not slot0 or not slot4 then
			return false, nil
		end

		slot9 = slot4.originData.posX == slot0.originData.posX

		if not slot9 and not slot10 or slot9 and slot4.originData.posY == slot0.originData.posY then
			return slot1, slot2
		end

		if uv0.isCanMoveKill(slot0) then
			return slot1, slot2
		end

		if Va3ChessGameModel.instance:getFireBallCount() <= 0 then
			return slot1, slot2
		end

		if uv0.isBlockFireBall(slot5, slot6, slot7, slot8) then
			return slot1, slot2
		end

		return Activity142Enum.CanFireKillInteractType[slot0:getObjType()]
	end,
	isBlockFireBall = function (slot0, slot1, slot2, slot3)
		slot5 = slot0 == slot2

		if not slot5 and not slot6 or slot5 and slot1 == slot3 or uv0.isSurroundPlayer(slot2, slot3) then
			return false
		end

		if slot5 then
			slot9 = slot1 < slot3

			for slot15 = slot9 and slot1 + 1 or slot3 + 1, slot9 and math.max(slot3 - 1, 0) or math.max(slot1 - 1, 0) do
				slot16, slot17 = Va3ChessGameController.instance:searchInteractByPos(slot0, slot15, uv0.filterCanBlockFireBall)

				if slot16 > 0 then
					slot4 = true

					break
				end
			end
		else
			slot9 = slot0 < slot2

			for slot15 = slot9 and slot0 + 1 or slot2 + 1, slot9 and math.max(slot2 - 1, 0) or math.max(slot0 - 1, 0) do
				slot16, slot17 = Va3ChessGameController.instance:searchInteractByPos(slot15, slot1, uv0.filterCanBlockFireBall)

				if slot16 > 0 then
					slot4 = true

					break
				end
			end
		end

		return slot4
	end,
	getPosHashKey = function (slot0, slot1)
		return slot0 .. "." .. slot1
	end
}
