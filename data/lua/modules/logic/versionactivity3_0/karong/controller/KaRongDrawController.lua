module("modules.logic.versionactivity3_0.karong.controller.KaRongDrawController", package.seeall)

local var_0_0 = class("KaRongDrawController", BaseController)
local var_0_1 = KaRongDrawEnum.dir.left
local var_0_2 = KaRongDrawEnum.dir.right
local var_0_3 = KaRongDrawEnum.dir.down
local var_0_4 = KaRongDrawEnum.dir.up

function var_0_0.reInit(arg_1_0)
	arg_1_0:release()
end

function var_0_0.openGame(arg_2_0, arg_2_1)
	arg_2_0:startGame(arg_2_1)
	ViewMgr.instance:openView(ViewName.KaRongDrawView)
end

function var_0_0.startGame(arg_3_0, arg_3_1)
	arg_3_0:release()
	KaRongDrawModel.instance:startGame(arg_3_1)

	arg_3_0._passedPosX = {}
	arg_3_0._passedPosY = {}
	arg_3_0._avatarPassedPos = {}
	arg_3_0._passedCheckPoint = {}
	arg_3_0._passedCheckPoint1 = {}
	arg_3_0._alertMoMap = {}

	arg_3_0:goStartPoint()

	if arg_3_0.usingSkill then
		arg_3_0:setUsingSkill(false)
	end
end

function var_0_0.goStartPoint(arg_4_0)
	local var_4_0, var_4_1 = KaRongDrawModel.instance:getStartPoint()

	arg_4_0._curPosX = var_4_0
	arg_4_0._curPosY = var_4_1

	table.insert(arg_4_0._passedPosX, var_4_0)
	table.insert(arg_4_0._passedPosY, var_4_1)

	local var_4_2 = KaRongDrawModel.instance:getAvatarStartPos()

	if var_4_2 then
		arg_4_0._curAvatarPos = Vector2.New(var_4_2.x, var_4_2.y)

		table.insert(arg_4_0._avatarPassedPos, Vector2.New(var_4_2.x, var_4_2.y))
	end
end

function var_0_0.restartGame(arg_5_0)
	local var_5_0 = KaRongDrawModel.instance:getElementCo()

	if var_5_0 then
		arg_5_0:startGame(var_5_0)
	end
end

function var_0_0.interactSwitchObj(arg_6_0, arg_6_1, arg_6_2)
	KaRongDrawModel.instance:switchLine(KaRongDrawEnum.LineState.Switch_On, arg_6_1, arg_6_2)
end

function var_0_0.goPassLine(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
	local var_7_0 = arg_7_0._curPosX ~= arg_7_1 or arg_7_0._curPosX ~= arg_7_3
	local var_7_1 = arg_7_0._curPosY ~= arg_7_2 or arg_7_0._curPosY ~= arg_7_4

	if var_7_0 and var_7_1 then
		arg_7_0._nextForwardX = nil
		arg_7_0._nextForwardY = nil

		return
	end

	local var_7_2
	local var_7_3 = {}

	arg_7_0._nextForwardX = arg_7_0._curPosX ~= arg_7_1 and arg_7_1 or arg_7_3
	arg_7_0._nextForwardY = arg_7_0._curPosY ~= arg_7_2 and arg_7_2 or arg_7_4

	if var_7_0 then
		var_7_2 = arg_7_3 > arg_7_0._curPosX and var_0_1 or var_0_2

		if var_7_2 == var_0_1 then
			for iter_7_0 = arg_7_0._curPosX + 1, arg_7_1 do
				table.insert(var_7_3, {
					var_0_2,
					iter_7_0,
					arg_7_2
				})
			end

			arg_7_0._nextForwardX = arg_7_3
		else
			for iter_7_1 = arg_7_0._curPosX - 1, arg_7_3, -1 do
				table.insert(var_7_3, {
					var_0_1,
					iter_7_1,
					arg_7_2
				})
			end

			arg_7_0._nextForwardX = arg_7_1
		end

		arg_7_6 = nil
	else
		var_7_2 = arg_7_4 > arg_7_0._curPosY and var_0_3 or var_0_4

		if var_7_2 == var_0_3 then
			for iter_7_2 = arg_7_0._curPosY + 1, arg_7_2 do
				table.insert(var_7_3, {
					var_0_4,
					arg_7_1,
					iter_7_2
				})
			end

			arg_7_0._nextForwardY = arg_7_4
		else
			for iter_7_3 = arg_7_0._curPosY - 1, arg_7_4, -1 do
				table.insert(var_7_3, {
					var_0_3,
					arg_7_1,
					iter_7_3
				})
			end

			arg_7_0._nextForwardY = arg_7_2
		end

		arg_7_5 = nil
	end

	arg_7_0._nextDir = var_7_2
	arg_7_0._nextProgressX = arg_7_5
	arg_7_0._nextProgressY = arg_7_6

	if #var_7_3 > 0 then
		arg_7_0:processPath(var_7_3)
	end
end

function var_0_0.goPassPos(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._curPosX == arg_8_1 and arg_8_0._curPosY == arg_8_2 or arg_8_0._curPosX ~= arg_8_1 and arg_8_0._curPosY ~= arg_8_2 then
		arg_8_0._nextDir = nil
		arg_8_0._nextForwardX = nil
		arg_8_0._nextForwardY = nil

		return
	end

	local var_8_0
	local var_8_1 = {}

	if arg_8_0._curPosX ~= arg_8_1 then
		if (arg_8_1 > arg_8_0._curPosX and var_0_1 or var_0_2) == var_0_1 then
			for iter_8_0 = arg_8_0._curPosX + 1, arg_8_1 do
				table.insert(var_8_1, {
					var_0_2,
					iter_8_0,
					arg_8_2
				})
			end
		else
			for iter_8_1 = arg_8_0._curPosX - 1, arg_8_1, -1 do
				table.insert(var_8_1, {
					var_0_1,
					iter_8_1,
					arg_8_2
				})
			end
		end
	elseif arg_8_0._curPosY ~= arg_8_2 then
		if (arg_8_2 > arg_8_0._curPosY and var_0_3 or var_0_4) == var_0_3 then
			for iter_8_2 = arg_8_0._curPosY + 1, arg_8_2 do
				table.insert(var_8_1, {
					var_0_4,
					arg_8_1,
					iter_8_2
				})
			end
		else
			for iter_8_3 = arg_8_0._curPosY - 1, arg_8_2, -1 do
				table.insert(var_8_1, {
					var_0_3,
					arg_8_1,
					iter_8_3
				})
			end
		end
	end

	arg_8_0._nextProgressX = nil
	arg_8_0._nextProgressY = nil

	if #var_8_1 > 0 then
		return arg_8_0:processPath(var_8_1)
	end
end

function var_0_0.processPath(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_0 = false
		local var_9_1 = iter_9_1[1]
		local var_9_2 = iter_9_1[2]
		local var_9_3 = iter_9_1[3]
		local var_9_4 = arg_9_0:isBackward(var_9_2, var_9_3)

		if not var_9_4 and next(arg_9_0._alertMoMap) then
			return
		end

		local var_9_5 = KaRongDrawModel.instance:getObjAtLine(arg_9_0._curPosX, arg_9_0._curPosY, var_9_2, var_9_3)

		if var_9_5 ~= nil and var_9_5.obstacle then
			arg_9_0._alertMoMap[var_9_5.key] = KaRongDrawEnum.MazeAlertType.VisitBlock
		end

		local var_9_6 = false
		local var_9_7 = KaRongDrawHelper.getPosKey(var_9_2, var_9_3)
		local var_9_8 = KaRongDrawHelper.getLineKey(arg_9_0._curPosX, arg_9_0._curPosY, var_9_2, var_9_3)

		if var_9_4 then
			arg_9_0._alertMoMap[var_9_8] = nil

			local var_9_9 = KaRongDrawHelper.getPosKey(arg_9_0._curPosX, arg_9_0._curPosY)

			arg_9_0._alertMoMap[var_9_9] = nil

			local var_9_10 = KaRongDrawModel.instance:getObjAtPos(arg_9_0._curPosX, arg_9_0._curPosY)

			if var_9_10 and var_9_10.objType == KaRongDrawEnum.MazeObjType.CheckPoint and not arg_9_0:alreadyPassed(var_9_10.x, var_9_10.y, true) then
				arg_9_0._passedCheckPoint[var_9_10.key] = nil
			end
		else
			if not arg_9_0:canPassLine(var_9_2, var_9_3) then
				arg_9_0._alertMoMap[var_9_8] = KaRongDrawEnum.MazeAlertType.DisconnectLine
			elseif arg_9_0:alreadyPassed(var_9_2, var_9_3) then
				arg_9_0._alertMoMap[var_9_7] = KaRongDrawEnum.MazeAlertType.VisitRepeat
			end

			local var_9_11 = KaRongDrawModel.instance:getObjAtPos(var_9_2, var_9_3)

			if var_9_11 ~= nil then
				if var_9_11.objType == KaRongDrawEnum.MazeObjType.CheckPoint then
					arg_9_0._passedCheckPoint[var_9_11.key] = 1
					var_9_0 = true
				elseif var_9_11.objType == KaRongDrawEnum.MazeObjType.End then
					var_9_6 = true
				end
			end
		end

		if var_9_4 then
			arg_9_0._passedPosX[#arg_9_0._passedPosX] = nil
			arg_9_0._passedPosY[#arg_9_0._passedPosY] = nil
		else
			table.insert(arg_9_0._passedPosX, var_9_2)
			table.insert(arg_9_0._passedPosY, var_9_3)
		end

		arg_9_0._curPosX = var_9_2
		arg_9_0._curPosY = var_9_3
		arg_9_0._nextDir = var_9_1
		arg_9_0._lineDirty = true

		if arg_9_0._curAvatarPos then
			arg_9_0:processAvatarPos(var_9_1, var_9_4)
		end

		if var_9_6 and not arg_9_0:passAllCheckPoint() then
			arg_9_0._alertMoMap[var_9_7] = KaRongDrawEnum.MazeAlertType.VisitRepeat
		end

		if var_9_0 and not next(arg_9_0._alertMoMap) then
			return true
		end
	end
end

function var_0_0.canPassLine(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = KaRongDrawModel.instance:getMapLineState(arg_10_0._curPosX, arg_10_0._curPosY, arg_10_1, arg_10_2)

	return var_10_0 ~= KaRongDrawEnum.LineState.Disconnect and var_10_0 ~= KaRongDrawEnum.LineState.Switch_Off
end

function var_0_0.goBackPos(arg_11_0)
	local var_11_0 = #arg_11_0._passedPosX

	if var_11_0 >= 2 then
		arg_11_0:goPassPos(arg_11_0._passedPosX[var_11_0 - 1], arg_11_0._passedPosY[var_11_0 - 1])

		for iter_11_0 = var_11_0 - 1, 2, -1 do
			local var_11_1 = arg_11_0._passedPosX[iter_11_0]
			local var_11_2 = arg_11_0._passedPosY[iter_11_0]

			if KaRongDrawModel.instance:getObjAtPos(var_11_1, var_11_2) then
				break
			end

			arg_11_0:goPassPos(arg_11_0._passedPosX[iter_11_0 - 1], arg_11_0._passedPosY[iter_11_0 - 1])
		end
	end
end

function var_0_0.isBackward(arg_12_0, arg_12_1, arg_12_2)
	return #arg_12_0._passedPosX > 1 and arg_12_0._passedPosX[#arg_12_0._passedPosX - 1] == arg_12_1 and arg_12_0._passedPosY[#arg_12_0._passedPosY - 1] == arg_12_2
end

function var_0_0.alreadyPassed(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0._passedPosX and #arg_13_0._passedPosX or 0
	local var_13_1 = arg_13_3 and var_13_0 - 1 or var_13_0

	for iter_13_0 = 1, var_13_1 do
		local var_13_2 = arg_13_0._passedPosX[iter_13_0]
		local var_13_3 = arg_13_0._passedPosY[iter_13_0]

		if var_13_2 == arg_13_1 and var_13_3 == arg_13_2 then
			return true
		end
	end

	return false
end

function var_0_0.alreadyAvatarPassed(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = #arg_14_0._avatarPassedPos
	local var_14_1 = arg_14_3 and var_14_0 - 1 or var_14_0

	for iter_14_0 = 1, var_14_1 do
		local var_14_2 = arg_14_0._avatarPassedPos[iter_14_0]

		if var_14_2.x == arg_14_1 and var_14_2.y == arg_14_2 then
			return true
		end
	end

	return false
end

function var_0_0.alreadyCheckPoint(arg_15_0, arg_15_1)
	if arg_15_0._passedCheckPoint[arg_15_1] or arg_15_0._passedCheckPoint1[arg_15_1] then
		return true
	end

	return false
end

function var_0_0.getLastPos(arg_16_0)
	return arg_16_0._curPosX, arg_16_0._curPosY
end

function var_0_0.getAvatarPos(arg_17_0)
	return arg_17_0._curAvatarPos
end

function var_0_0.getPassedPoints(arg_18_0)
	return arg_18_0._passedPosX, arg_18_0._passedPosY
end

function var_0_0.getAvatarPassPoints(arg_19_0)
	return arg_19_0._avatarPassedPos
end

function var_0_0.getProgressLine(arg_20_0)
	return arg_20_0._nextForwardX, arg_20_0._nextForwardY, arg_20_0._nextProgressX, arg_20_0._nextProgressY
end

function var_0_0.getAlertMap(arg_21_0)
	return arg_21_0._alertMoMap
end

function var_0_0.hasAlertObj(arg_22_0)
	if next(arg_22_0._alertMoMap) then
		return true
	end

	local var_22_0 = arg_22_0._passedPosX and #arg_22_0._passedPosX or 0

	if var_22_0 >= 2 then
		local var_22_1 = arg_22_0._passedPosX and arg_22_0._passedPosX[var_22_0]
		local var_22_2 = arg_22_0._passedPosY and arg_22_0._passedPosY[var_22_0]

		if not KaRongDrawModel.instance:getObjAtPos(var_22_1, var_22_2) then
			return true
		end
	end

	return false
end

function var_0_0.isLineDirty(arg_23_0)
	return arg_23_0._lineDirty
end

function var_0_0.resetLineDirty(arg_24_0)
	arg_24_0._lineDirty = false
end

function var_0_0.isGameClear(arg_25_0)
	if arg_25_0:hasAlertObj() then
		return false
	end

	local var_25_0, var_25_1 = KaRongDrawModel.instance:getEndPoint()

	if arg_25_0._curPosX ~= var_25_0 or arg_25_0._curPosY ~= var_25_1 then
		return false
	end

	local var_25_2 = KaRongDrawModel.instance:getAvatarEndPos()

	if var_25_2 and (arg_25_0._curAvatarPos.x ~= var_25_2.x or arg_25_0._curAvatarPos.y ~= var_25_2.y) then
		return false
	end

	if not arg_25_0:passAllCheckPoint() then
		return false
	end

	return true
end

function var_0_0.release(arg_26_0)
	arg_26_0._curPosX = nil
	arg_26_0._curPosY = nil
	arg_26_0._curAvatarPos = nil
	arg_26_0._passedPosX = nil
	arg_26_0._passedPosY = nil
	arg_26_0._passedCheckPoint = nil
	arg_26_0._passedCheckPoint1 = nil
	arg_26_0._alertMoMap = nil
	arg_26_0._nextDir = nil
	arg_26_0._nextForwardX = nil
	arg_26_0._nextForwardY = nil
	arg_26_0._nextProgressX = nil
	arg_26_0._nextProgressY = nil
	arg_26_0._lineDirty = nil
	arg_26_0.skillCnt = 0
end

function var_0_0.processAvatarPos(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0._curAvatarPos.x
	local var_27_1 = arg_27_0._curAvatarPos.y
	local var_27_2
	local var_27_3

	if arg_27_1 == var_0_4 and var_27_1 ~= KaRongDrawEnum.mazeDrawHeight then
		var_27_2 = var_27_0
		var_27_3 = var_27_1 + 1
	elseif arg_27_1 == var_0_3 and var_27_1 ~= 1 then
		var_27_2 = var_27_0
		var_27_3 = var_27_1 - 1
	elseif arg_27_1 == var_0_2 and var_27_0 ~= 1 then
		var_27_2 = var_27_0 - 1
		var_27_3 = var_27_1
	elseif arg_27_1 == var_0_1 and var_27_0 ~= KaRongDrawEnum.mazeDrawWidth then
		var_27_2 = var_27_0 + 1
		var_27_3 = var_27_1
	end

	if arg_27_2 then
		local var_27_4 = KaRongDrawModel.instance:getObjAtPos(var_27_0, var_27_1)

		if var_27_4 and var_27_4.objType == KaRongDrawEnum.MazeObjType.CheckPoint then
			arg_27_0._passedCheckPoint1[var_27_4.key] = nil
		end

		if var_27_2 then
			local var_27_5 = KaRongDrawHelper.getLineKey(var_27_0, var_27_1, var_27_2, var_27_3)

			arg_27_0._alertMoMap[var_27_5] = nil
			arg_27_0._avatarPassedPos[#arg_27_0._avatarPassedPos] = nil
			arg_27_0._curAvatarPos.x = var_27_2
			arg_27_0._curAvatarPos.y = var_27_3
		end
	elseif var_27_2 then
		local var_27_6 = KaRongDrawHelper.getLineKey(var_27_0, var_27_1, var_27_2, var_27_3)
		local var_27_7 = KaRongDrawModel.instance:getMapLineState(var_27_0, var_27_1, var_27_2, var_27_3)

		if not (var_27_7 ~= KaRongDrawEnum.LineState.Disconnect and var_27_7 ~= KaRongDrawEnum.LineState.Switch_Off) then
			arg_27_0._alertMoMap[var_27_6] = KaRongDrawEnum.MazeAlertType.DisconnectLine
		end

		local var_27_8 = KaRongDrawModel.instance:getObjAtLine(var_27_0, var_27_1, var_27_2, var_27_3)

		if var_27_8 and var_27_8.obstacle then
			arg_27_0._alertMoMap[var_27_6] = KaRongDrawEnum.MazeAlertType.VisitBlock
		end

		local var_27_9 = KaRongDrawModel.instance:getObjAtPos(var_27_2, var_27_3)

		if var_27_9 ~= nil and var_27_9.objType == KaRongDrawEnum.MazeObjType.CheckPoint then
			arg_27_0._passedCheckPoint1[var_27_9.key] = 1
		end

		arg_27_0._avatarPassedPos[#arg_27_0._avatarPassedPos + 1] = Vector2.New(var_27_2, var_27_3)
	end

	if var_27_2 then
		arg_27_0._curAvatarPos.x = var_27_2
		arg_27_0._curAvatarPos.y = var_27_3

		arg_27_0:dispatchEvent(KaRongDrawEvent.UpdateAvatarPos)
	end
end

function var_0_0.addSkillCnt(arg_28_0)
	AudioMgr.instance:trigger(AudioEnum3_0.ActKaRong.play_ui_lushang_skill_get)

	arg_28_0.skillCnt = arg_28_0.skillCnt + 1

	arg_28_0:dispatchEvent(KaRongDrawEvent.SkillCntChange, true)
end

function var_0_0.setUsingSkill(arg_29_0, arg_29_1)
	arg_29_0.usingSkill = arg_29_1

	arg_29_0:dispatchEvent(KaRongDrawEvent.UsingSkill, arg_29_1)
end

function var_0_0.useSkill(arg_30_0, arg_30_1)
	arg_30_1.obstacle = false

	KaRongDrawModel.instance:setMapLineState(arg_30_1.x1, arg_30_1.y1, arg_30_1.x2, arg_30_1.y2, KaRongDrawEnum.LineState.Switch_On)

	arg_30_0.skillCnt = arg_30_0.skillCnt - 1

	arg_30_0:setUsingSkill(false)
	arg_30_0:dispatchEvent(KaRongDrawEvent.SkillCntChange)
end

function var_0_0.passAllCheckPoint(arg_31_0)
	if #KaRongDrawModel.instance:getCheckPointMoList() <= tabletool.len(arg_31_0._passedCheckPoint) + tabletool.len(arg_31_0._passedCheckPoint1) then
		return true
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
