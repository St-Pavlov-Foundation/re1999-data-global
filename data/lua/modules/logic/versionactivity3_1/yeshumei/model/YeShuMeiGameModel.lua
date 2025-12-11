module("modules.logic.versionactivity3_1.yeshumei.model.YeShuMeiGameModel", package.seeall)

local var_0_0 = class("YeShuMeiGameModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._curGameIdStr = nil
	arg_2_0._curGameId = nil
	arg_2_0._curLevelIndex = nil

	arg_2_0:_onStart()
end

function var_0_0.initGameData(arg_3_0, arg_3_1)
	arg_3_0:clear()

	arg_3_0._gameConfig = YeShuMeiConfig.instance:getYeShuMeiGameConfigById(arg_3_1)
	arg_3_0._curGameIdStr = arg_3_0._gameConfig and arg_3_0._gameConfig.gameId

	arg_3_0:_initLevel()

	local var_3_0 = arg_3_0._gameIdList[arg_3_0._curLevelIndex]

	arg_3_0:_initGameMo(var_3_0)
	arg_3_0:_onStart()
end

function var_0_0._initLevel(arg_4_0)
	if arg_4_0._curGameIdStr ~= nil then
		arg_4_0._gameIdList = string.splitToNumber(arg_4_0._curGameIdStr, "#")
	end

	arg_4_0._level = {}
	arg_4_0._curLevelIndex = 1

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._gameIdList) do
		arg_4_0._level[iter_4_0] = false
	end
end

function var_0_0._initGameMo(arg_5_0, arg_5_1)
	arg_5_0._gameMo = YeShuMeiGameMo.create(arg_5_1)

	local var_5_0 = YeShuMeiConfig.instance:getYeShuMeiLevelDataByLevelId(arg_5_1)

	arg_5_0._gameMo:init(var_5_0)
	arg_5_0._gameMo:setOrderIndex()
end

function var_0_0._onStart(arg_6_0)
	arg_6_0._isStart = false
	arg_6_0._isShadowVible = false
	arg_6_0._isReView = false
	arg_6_0._isWrong = false
	arg_6_0._curStartPointId = nil
	arg_6_0._curOrder = nil
	arg_6_0._lastLineCount = 0
	arg_6_0._correctLineCount = 0
	arg_6_0._needCheckPointList = nil
	arg_6_0._lines = {}
	arg_6_0._lastProcessedPointId = nil
	arg_6_0._pointInListHash = {}
end

function var_0_0.getStartState(arg_7_0)
	return arg_7_0._isStart
end

function var_0_0.setStartState(arg_8_0, arg_8_1)
	arg_8_0._isStart = arg_8_1
end

function var_0_0.getCurGameId(arg_9_0)
	return arg_9_0._curGameId
end

function var_0_0.getGameMo(arg_10_0)
	return arg_10_0._gameMo
end

function var_0_0.getCurGameConfig(arg_11_0)
	return arg_11_0._gameConfig
end

function var_0_0.getAllPoint(arg_12_0)
	if arg_12_0._gameMo == nil then
		return nil
	end

	return arg_12_0._gameMo:getAllPoint()
end

function var_0_0.getPointById(arg_13_0, arg_13_1)
	if arg_13_0._gameMo == nil then
		return nil
	end

	return arg_13_0._gameMo:getPointById(arg_13_1)
end

function var_0_0.setReview(arg_14_0, arg_14_1)
	arg_14_0._isReView = arg_14_1
end

function var_0_0.getReView(arg_15_0)
	return arg_15_0._isReView
end

function var_0_0.insertPointList(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0._needCheckPointList then
		arg_16_0._needCheckPointList = {}
	end

	local var_16_0 = false

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._needCheckPointList) do
		if iter_16_1 == arg_16_1 then
			var_16_0 = true

			break
		end
	end

	if var_16_0 and not arg_16_2 then
		return false
	end

	if #arg_16_0._needCheckPointList == 0 then
		local var_16_1 = arg_16_0:getStartPointIds()

		for iter_16_2, iter_16_3 in ipairs(var_16_1) do
			if iter_16_3 == arg_16_1 then
				arg_16_0._curOrder = arg_16_0._gameMo:getCurrentStartOrder(arg_16_1)
				arg_16_0._curStartPointId = arg_16_1
			end
		end
	end

	if not arg_16_0._curOrder then
		return
	end

	if not tabletool.indexOf(arg_16_0._needCheckPointList, arg_16_1) then
		table.insert(arg_16_0._needCheckPointList, arg_16_1)

		if #arg_16_0._needCheckPointList == #arg_16_0._curOrder and arg_16_2 and not arg_16_0._isWrong then
			arg_16_0._level[arg_16_0._curLevelIndex] = true
		end

		return true
	end

	local var_16_2 = #arg_16_0._needCheckPointList

	if arg_16_2 and var_16_2 + 1 == #arg_16_0._curOrder and not arg_16_0._isWrong then
		arg_16_0._level[arg_16_0._curLevelIndex] = true

		table.insert(arg_16_0._needCheckPointList, arg_16_1)

		return true
	end

	return false
end

function var_0_0.getNeedCheckPointList(arg_17_0)
	return arg_17_0._needCheckPointList
end

function var_0_0.checkConnectionCorrect(arg_18_0)
	if not arg_18_0._curOrder or #arg_18_0._curOrder < 1 then
		return
	end

	if #arg_18_0._needCheckPointList > #arg_18_0._curOrder then
		arg_18_0._isWrong = true

		return false
	end

	for iter_18_0 = 1, #arg_18_0._needCheckPointList do
		if arg_18_0._needCheckPointList[iter_18_0] ~= arg_18_0._curOrder[iter_18_0] then
			arg_18_0._isWrong = true

			return false
		end
	end

	arg_18_0._curStartPointId = arg_18_0._needCheckPointList[#arg_18_0._needCheckPointList]

	return true
end

function var_0_0.getConfigStartPointIds(arg_19_0)
	if arg_19_0._gameMo then
		return (arg_19_0._gameMo:getStartPointIds())
	end
end

function var_0_0.getStartPointIds(arg_20_0)
	if arg_20_0._curStartPointId then
		return {
			arg_20_0._curStartPointId
		}
	end

	if arg_20_0._gameMo then
		local var_20_0 = arg_20_0._gameMo:getStartPointIds()

		if not arg_20_0._curStartPointId then
			return var_20_0
		end
	end
end

function var_0_0.checkLineExist(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = false

	if arg_21_0._lines and #arg_21_0._lines > 0 then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0._lines) do
			var_21_0 = iter_21_1:havePoint(arg_21_1, arg_21_2)

			if var_21_0 then
				break
			end
		end

		return var_21_0
	end

	return false
end

function var_0_0.getLineMoByPointId(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0._lines and #arg_22_0._lines > 0 then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0._lines) do
			if iter_22_1:havePoint(arg_22_1, arg_22_2) then
				return iter_22_1
			end
		end
	end
end

function var_0_0.getLineMoByErrorId(arg_23_0, arg_23_1)
	if arg_23_0._lines and #arg_23_0._lines > 0 then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0._lines) do
			if iter_23_1:checkHaveErrorId(arg_23_1) then
				return iter_23_1
			end
		end
	end
end

function var_0_0.checkDiffPosAndConnection(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0._pointInListHash = arg_24_0._pointInListHash or {}
	arg_24_0._needCheckPointList = arg_24_0._needCheckPointList or {}
	arg_24_0._lastProcessedPointId = arg_24_0._lastProcessedPointId or nil

	local var_24_0
	local var_24_1 = arg_24_0:getAllPoint()

	for iter_24_0, iter_24_1 in ipairs(var_24_1) do
		if iter_24_1 and iter_24_1:isInCanConnectionRange(arg_24_1, arg_24_2) then
			var_24_0 = iter_24_1

			break
		end
	end

	if not var_24_0 then
		arg_24_0._lastProcessedPointId = nil

		return false
	end

	local var_24_2 = var_24_0:getId()
	local var_24_3 = arg_24_0._curOrder and #arg_24_0._curOrder or 0
	local var_24_4 = var_24_3 > 0 and arg_24_0._curOrder[var_24_3] or nil
	local var_24_5 = arg_24_0._pointInListHash[var_24_2]
	local var_24_6 = arg_24_0._lastProcessedPointId == var_24_2
	local var_24_7 = #arg_24_0._needCheckPointList == 0
	local var_24_8 = var_24_2 == var_24_4
	local var_24_9 = false

	if var_24_7 then
		var_24_9 = not var_24_5
	else
		var_24_9 = not var_24_5 and not var_24_6 or var_24_8 and not var_24_6
	end

	if not var_24_9 then
		return false
	end

	if not arg_24_0:insertPointList(var_24_2, var_24_8) then
		return false
	end

	arg_24_0._pointInListHash[var_24_2] = true
	arg_24_0._lastProcessedPointId = var_24_2

	if arg_24_0:checkConnectionCorrect() then
		var_24_0:setState(YeShuMeiEnum.StateType.Connect)
	else
		var_24_0:setState(YeShuMeiEnum.StateType.Error)

		arg_24_0._isWrong = true
	end

	return true
end

function var_0_0.checkCorrectConnection(arg_25_0)
	if arg_25_0._isWrong then
		arg_25_0:resetToLastConnection()
	elseif not arg_25_0:checkHaveNewConnection() then
		arg_25_0:resetToLastConnection()
	else
		arg_25_0._lastLineCount = arg_25_0._correctLineCount
	end
end

function var_0_0.checkHaveNewConnection(arg_26_0)
	if arg_26_0._correctLineCount > arg_26_0._lastLineCount then
		return true
	end

	return false
end

function var_0_0.resetToLastConnection(arg_27_0)
	arg_27_0._needCheckPointList = arg_27_0._needCheckPointList or {}

	local var_27_0 = #arg_27_0._needCheckPointList

	if var_27_0 > 1 then
		local var_27_1 = {}
		local var_27_2 = false

		for iter_27_0, iter_27_1 in ipairs(arg_27_0._needCheckPointList) do
			table.insert(var_27_1, iter_27_1)

			if iter_27_1 == arg_27_0._curStartPointId then
				var_27_2 = true

				break
			end
		end

		if var_27_2 then
			arg_27_0._needCheckPointList = var_27_1
		else
			arg_27_0._needCheckPointList = {}
		end
	else
		arg_27_0._needCheckPointList = {}
		arg_27_0._curStartPointId = nil
	end

	arg_27_0._pointInListHash = {}

	for iter_27_2, iter_27_3 in ipairs(arg_27_0._needCheckPointList) do
		arg_27_0._pointInListHash[iter_27_3] = true
	end

	arg_27_0._isWrong = false
	arg_27_0._lastProcessedPointId = var_27_0 > 0 and arg_27_0._needCheckPointList[#arg_27_0._needCheckPointList] or nil
end

function var_0_0.clearConnection(arg_28_0)
	if arg_28_0._needCheckPointList and #arg_28_0._needCheckPointList > 0 then
		for iter_28_0, iter_28_1 in ipairs(arg_28_0._needCheckPointList) do
			arg_28_0:getPointById(iter_28_1):clearPoint()
		end
	end

	arg_28_0._isWrong = false
end

function var_0_0.addLines(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = 0

	if arg_29_0._lines == nil then
		arg_29_0._lines = {}
	end

	local var_29_1 = #arg_29_0._lines + 1
	local var_29_2 = YeShuMeiLineMo.New(var_29_1)

	var_29_2:updatePoint(arg_29_1, arg_29_2)

	if arg_29_0._isWrong then
		var_29_2:setState(YeShuMeiEnum.StateType.Error)
	else
		arg_29_0._correctLineCount = (arg_29_0._correctLineCount or 0) + 1
	end

	local var_29_3 = false

	for iter_29_0, iter_29_1 in ipairs(arg_29_0._lines) do
		if iter_29_1:havePoint(arg_29_1, arg_29_2) then
			var_29_3 = true

			break
		end
	end

	if not var_29_3 then
		table.insert(arg_29_0._lines, var_29_2)
	end

	return var_29_2
end

function var_0_0.deleteLines(arg_30_0, arg_30_1)
	if not arg_30_0._lines then
		return
	end

	if not arg_30_1 then
		tabletool.clear(arg_30_0._lines)

		arg_30_0._lines = nil
	else
		for iter_30_0, iter_30_1 in ipairs(arg_30_1) do
			for iter_30_2, iter_30_3 in ipairs(arg_30_0._lines) do
				if iter_30_3.id == iter_30_1 then
					table.remove(arg_30_0._lines, iter_30_2)
				end
			end
		end
	end
end

function var_0_0.getCurStartPointAfter(arg_31_0)
	local var_31_0 = {}

	if not arg_31_0._curStartPointId then
		return arg_31_0._needCheckPointList
	end

	if arg_31_0._curStartPointId and arg_31_0._needCheckPointList and #arg_31_0._needCheckPointList > 0 then
		local var_31_1

		for iter_31_0, iter_31_1 in ipairs(arg_31_0._needCheckPointList) do
			if iter_31_1 == arg_31_0._curStartPointId then
				var_31_1 = iter_31_0
			end

			if var_31_1 and var_31_1 < iter_31_0 then
				table.insert(var_31_0, iter_31_1)
			end
		end
	end

	return var_31_0
end

function var_0_0.getWrong(arg_32_0)
	return arg_32_0._isWrong
end

function var_0_0.getCurStartPointMo(arg_33_0)
	if arg_33_0._curStartPointId then
		return arg_33_0:getPointById(arg_33_0._curStartPointId)
	end
end

function var_0_0.getCurrentLevelIndex(arg_34_0)
	return arg_34_0._curLevelIndex
end

function var_0_0.getCurrentLevelComplete(arg_35_0)
	return arg_35_0._level[arg_35_0._curLevelIndex]
end

function var_0_0.getCompleteLevelNum(arg_36_0)
	local var_36_0 = 0

	for iter_36_0, iter_36_1 in ipairs(arg_36_0._level) do
		if iter_36_1 then
			var_36_0 = var_36_0 + 1
		end
	end

	return var_36_0
end

function var_0_0.checkHaveNextLevel(arg_37_0)
	local var_37_0 = arg_37_0._curLevelIndex + 1
	local var_37_1 = arg_37_0._gameIdList[var_37_0]

	if YeShuMeiConfig.instance:getYeShuMeiLevelDataByLevelId(var_37_1) then
		return true
	else
		return false
	end
end

function var_0_0.checkNeedCheckListEmpty(arg_38_0)
	return arg_38_0._needCheckPointList and #arg_38_0._needCheckPointList == 0 or true
end

function var_0_0.getCurStartPointId(arg_39_0)
	return arg_39_0._curStartPointId
end

function var_0_0.setNextLevelGame(arg_40_0)
	arg_40_0._curLevelIndex = arg_40_0._curLevelIndex + 1

	local var_40_0 = arg_40_0._gameIdList[arg_40_0._curLevelIndex]

	arg_40_0:_initGameMo(var_40_0)
	arg_40_0:_onStart()
end

function var_0_0.destroy(arg_41_0)
	arg_41_0:clear()

	if arg_41_0._gameMo then
		arg_41_0._gameMo:destroy()

		arg_41_0._gameMo = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
