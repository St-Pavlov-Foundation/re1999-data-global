module("modules.logic.versionactivity1_5.act142.controller.Activity142Helper", package.seeall)

local var_0_0 = {
	showToastByEpisodeId = function(arg_1_0)
		local var_1_0 = Activity142Model.instance:getActivityId()

		if not Activity142Config.instance:getEpisodeCo(var_1_0, arg_1_0, true) then
			return
		end

		if not Activity142Model.instance:isOpenDay(var_1_0, arg_1_0) then
			GameFacade.showToast(ToastEnum.Activity142EpisodeNotInOpenDay)

			return
		end

		if not Activity142Model.instance:isPreEpisodeClear(var_1_0, arg_1_0) then
			GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)
		end
	end,
	setAct142UIBlock = function(arg_2_0, arg_2_1)
		if arg_2_0 then
			UIBlockMgr.instance:startBlock(arg_2_1 or Activity142Enum.UI_BlOCK_KEY)
		else
			UIBlockMgr.instance:endBlock(arg_2_1 or Activity142Enum.UI_BlOCK_KEY)
		end
	end
}

function var_0_0.openWinResult()
	local var_3_0 = Va3ChessModel.instance:getEpisodeId()
	local var_3_1 = "OnChessWinPause" .. var_3_0
	local var_3_2 = GuideEvent[var_3_1]
	local var_3_3 = GuideEvent.OnChessWinContinue
	local var_3_4 = var_0_0._openSuccessView
	local var_3_5

	GuideController.instance:GuideFlowPauseAndContinue(var_3_1, var_3_2, var_3_3, var_3_4, var_3_5)
end

function var_0_0._openSuccessView()
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)
	ViewMgr.instance:openView(ViewName.Activity142ResultView)
end

function var_0_0.checkConditionIsFinish(arg_5_0, arg_5_1)
	local var_5_0 = true
	local var_5_1 = GameUtil.splitString2(arg_5_0, true, "|", "#")

	if not var_5_1 then
		return var_5_0
	end

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		if not Va3ChessMapUtils.isClearConditionFinish(iter_5_1, arg_5_1) then
			var_5_0 = false

			break
		end
	end

	return var_5_0
end

function var_0_0.filterInteractType(arg_6_0, arg_6_1)
	local var_6_0 = false

	if arg_6_1 and arg_6_0 and arg_6_0.config then
		var_6_0 = arg_6_1[arg_6_0.config.interactType] or false
	end

	return var_6_0
end

function var_0_0.filterCanBlockFireBall(arg_7_0)
	return (var_0_0.filterInteractType(arg_7_0, Activity142Enum.CanBlockFireBallInteractType))
end

function var_0_0.filterCanMoveKill(arg_8_0)
	return (var_0_0.filterInteractType(arg_8_0, Activity142Enum.CanMoveKillInteractType))
end

function var_0_0.filterCanFireKill(arg_9_0)
	return (var_0_0.filterInteractType(arg_9_0, Activity142Enum.CanFireKillInteractType))
end

function var_0_0.getBaffleDataList(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(Va3ChessEnum.Direction) do
		if var_0_0.isHasBaffleInDir(arg_10_0, iter_10_1) then
			local var_10_1 = iter_10_1 - 1
			local var_10_2 = bit.lshift(3, var_10_1)
			local var_10_3 = bit.band(arg_10_1, var_10_2)
			local var_10_4 = bit.rshift(var_10_3, var_10_1)
			local var_10_5 = {
				direction = iter_10_1,
				type = var_10_4
			}

			var_10_0[#var_10_0 + 1] = var_10_5
		end
	end

	return var_10_0
end

function var_0_0.isHasBaffleInDir(arg_11_0, arg_11_1)
	local var_11_0 = false
	local var_11_1 = bit.lshift(1, arg_11_1)

	return bit.band(arg_11_0, var_11_1) ~= 0
end

local var_0_1 = {
	[Va3ChessEnum.Direction.Up] = 1,
	[Va3ChessEnum.Direction.Down] = -1,
	[Va3ChessEnum.Direction.Left] = 1,
	[Va3ChessEnum.Direction.Right] = -1
}

function var_0_0.calBafflePosInScene(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = var_0_1[arg_12_2]
	local var_12_1, var_12_2, var_12_3 = Va3ChessGameController.instance:calcTilePosInScene(arg_12_0, arg_12_1, var_12_0, true)

	if arg_12_2 == Va3ChessEnum.Direction.Left then
		var_12_1 = var_12_1 - Activity142Enum.BaffleOffset.baffleOffsetX
		var_12_2 = var_12_2 + Activity142Enum.BaffleOffset.baffleOffsetY
	elseif arg_12_2 == Va3ChessEnum.Direction.Up then
		var_12_1 = var_12_1 + Activity142Enum.BaffleOffset.baffleOffsetX
		var_12_2 = var_12_2 + Activity142Enum.BaffleOffset.baffleOffsetY
	elseif arg_12_2 == Va3ChessEnum.Direction.Right then
		var_12_1 = var_12_1 + Activity142Enum.BaffleOffset.baffleOffsetX
		var_12_2 = var_12_2 - Activity142Enum.BaffleOffset.baffleOffsetY
	elseif arg_12_2 == Va3ChessEnum.Direction.Down then
		var_12_1 = var_12_1 - Activity142Enum.BaffleOffset.baffleOffsetX
		var_12_2 = var_12_2 - Activity142Enum.BaffleOffset.baffleOffsetY
	else
		logError("un support direction, please check ... " .. arg_12_2)
	end

	return var_12_1, var_12_2, var_12_3
end

function var_0_0.getBaffleResPath(arg_13_0)
	if not arg_13_0 then
		return
	end

	local var_13_0 = arg_13_0.direction
	local var_13_1 = arg_13_0.type

	if not var_13_0 or not var_13_1 then
		return
	end

	if var_13_0 == Va3ChessEnum.Direction.Left or var_13_0 == Va3ChessEnum.Direction.Right then
		return Activity142Enum.VerBaffleResPath[var_13_1] or Activity142Enum.VerBaffleResPath[1]
	else
		return Activity142Enum.HorBaffleResPath[var_13_1] or Activity142Enum.HorBaffleResPath[1]
	end
end

function var_0_0.isSurroundPlayer(arg_14_0, arg_14_1)
	local var_14_0 = false
	local var_14_1 = Va3ChessGameController.instance.interacts
	local var_14_2 = var_14_1 and var_14_1:getMainPlayer(true)

	if not var_14_2 then
		return var_14_0
	end

	local var_14_3 = var_14_2.originData.posX
	local var_14_4 = var_14_2.originData.posY
	local var_14_5 = var_14_3 == arg_14_0
	local var_14_6 = var_14_4 == arg_14_1
	local var_14_7 = math.abs(var_14_3 - arg_14_0)
	local var_14_8 = math.abs(var_14_4 - arg_14_1)

	return var_14_5 and var_14_8 == 1 or var_14_6 and var_14_7 == 1
end

function var_0_0.isCanMoveKill(arg_15_0)
	local var_15_0 = false

	if not arg_15_0 then
		return var_15_0
	end

	local var_15_1 = arg_15_0.originData.posX
	local var_15_2 = arg_15_0.originData.posY

	if var_0_0.isSurroundPlayer(var_15_1, var_15_2) then
		local var_15_3 = Va3ChessGameController.instance.interacts
		local var_15_4 = var_15_3 and var_15_3:getMainPlayer(true) or nil

		if var_15_4 then
			local var_15_5 = var_15_4.originData.posX
			local var_15_6 = var_15_4.originData.posY
			local var_15_7 = Va3ChessMapUtils.ToDirection(var_15_5, var_15_6, var_15_1, var_15_2)
			local var_15_8 = Va3ChessGameController.instance:posCanWalk(var_15_1, var_15_2, var_15_7, var_15_4.objType)
			local var_15_9 = arg_15_0:getObjType()
			local var_15_10 = Activity142Enum.CanMoveKillInteractType[var_15_9] or false

			var_15_0 = var_15_8 and var_15_10
		end
	end

	return var_15_0
end

function var_0_0.isCanFireKill(arg_16_0)
	local var_16_0 = false
	local var_16_1
	local var_16_2 = Va3ChessGameController.instance.interacts
	local var_16_3 = var_16_2 and var_16_2:getMainPlayer(true)

	if not arg_16_0 or not var_16_3 then
		return var_16_0, var_16_1
	end

	local var_16_4 = var_16_3.originData.posX
	local var_16_5 = var_16_3.originData.posY
	local var_16_6 = arg_16_0.originData.posX
	local var_16_7 = arg_16_0.originData.posY
	local var_16_8 = var_16_4 == var_16_6
	local var_16_9 = var_16_5 == var_16_7
	local var_16_10 = var_16_8 and var_16_9

	if not var_16_8 and not var_16_9 or var_16_10 then
		return var_16_0, var_16_1
	end

	if var_0_0.isCanMoveKill(arg_16_0) then
		return var_16_0, var_16_1
	end

	if Va3ChessGameModel.instance:getFireBallCount() <= 0 then
		return var_16_0, var_16_1
	end

	if var_0_0.isBlockFireBall(var_16_4, var_16_5, var_16_6, var_16_7) then
		return var_16_0, var_16_1
	end

	local var_16_11 = arg_16_0:getObjType()

	return Activity142Enum.CanFireKillInteractType[var_16_11]
end

function var_0_0.isBlockFireBall(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = false
	local var_17_1 = arg_17_0 == arg_17_2
	local var_17_2 = arg_17_1 == arg_17_3
	local var_17_3 = var_17_1 and var_17_2
	local var_17_4 = var_0_0.isSurroundPlayer(arg_17_2, arg_17_3)

	if not var_17_1 and not var_17_2 or var_17_3 or var_17_4 then
		return var_17_0
	end

	if var_17_1 then
		local var_17_5 = arg_17_1 < arg_17_3
		local var_17_6 = var_17_5 and arg_17_1 + 1 or arg_17_3 + 1
		local var_17_7 = var_17_5 and math.max(arg_17_3 - 1, 0) or math.max(arg_17_1 - 1, 0)

		for iter_17_0 = var_17_6, var_17_7 do
			local var_17_8, var_17_9 = Va3ChessGameController.instance:searchInteractByPos(arg_17_0, iter_17_0, var_0_0.filterCanBlockFireBall)

			if var_17_8 > 0 then
				var_17_0 = true

				break
			end
		end
	else
		local var_17_10 = arg_17_0 < arg_17_2
		local var_17_11 = var_17_10 and arg_17_0 + 1 or arg_17_2 + 1
		local var_17_12 = var_17_10 and math.max(arg_17_2 - 1, 0) or math.max(arg_17_0 - 1, 0)

		for iter_17_1 = var_17_11, var_17_12 do
			local var_17_13, var_17_14 = Va3ChessGameController.instance:searchInteractByPos(iter_17_1, arg_17_1, var_0_0.filterCanBlockFireBall)

			if var_17_13 > 0 then
				var_17_0 = true

				break
			end
		end
	end

	return var_17_0
end

function var_0_0.getPosHashKey(arg_18_0, arg_18_1)
	return arg_18_0 .. "." .. arg_18_1
end

return var_0_0
