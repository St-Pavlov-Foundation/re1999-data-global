module("modules.logic.versionactivity2_7.lengzhou6.model.LocalEliminateChessModel", package.seeall)

local var_0_0 = class("LocalEliminateChessModel")
local var_0_1 = {
	{
		x = 1,
		y = 0
	},
	{
		x = -1,
		y = 0
	}
}
local var_0_2 = {
	{
		x = 0,
		y = 1
	},
	{
		x = 0,
		y = -1
	}
}

function var_0_0.ctor(arg_1_0)
	arg_1_0._changePoints = {}
	arg_1_0._tempEliminateCheckResults = {}
	arg_1_0._weights = {
		1,
		1,
		1,
		1
	}
end

function var_0_0.initByData(arg_2_0, arg_2_1)
	math.randomseed(os.time())

	if arg_2_0.cells == nil then
		arg_2_0.cells = {}
	end

	arg_2_0._row = #arg_2_1

	for iter_2_0 = 1, #arg_2_1 do
		if arg_2_0.cells[iter_2_0] == nil then
			arg_2_0.cells[iter_2_0] = {}
		end

		local var_2_0 = arg_2_1[iter_2_0]

		arg_2_0._col = #var_2_0

		for iter_2_1 = 1, #var_2_0 do
			local var_2_1 = arg_2_0.cells[iter_2_0][iter_2_1]
			local var_2_2 = var_2_0[iter_2_1]

			if var_2_1 == nil then
				var_2_1 = arg_2_0:createNewCell(iter_2_0, iter_2_1, EliminateEnum_2_7.ChessState.Normal, var_2_2)
			else
				arg_2_0:initCell(var_2_1, iter_2_0, iter_2_1, EliminateEnum_2_7.ChessState.Normal, var_2_2)
			end

			var_2_1:setStartXY(iter_2_0, arg_2_0._col + 1)
			var_2_1:setXY(iter_2_0, iter_2_1)
		end
	end

	arg_2_0._initData = arg_2_1
end

function var_0_0.getInitData(arg_3_0)
	return arg_3_0._initData
end

function var_0_0.getAllCell(arg_4_0)
	return arg_4_0.cells
end

function var_0_0.getCell(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.cells == nil or arg_5_0.cells[arg_5_1] == nil then
		return nil
	end

	return arg_5_0.cells[arg_5_1][arg_5_2]
end

function var_0_0.getCellRowAndCol(arg_6_0)
	return arg_6_0._row, arg_6_0._col
end

function var_0_0.setEliminateDieEffect(arg_7_0, arg_7_1)
	arg_7_0._dieEffect = arg_7_1
end

function var_0_0.getEliminateDieEffect(arg_8_0)
	return arg_8_0._dieEffect
end

function var_0_0.randomCell(arg_9_0)
	if isDebugBuild then
		arg_9_0:printInfo("打乱棋盘前:")
	end

	local var_9_0 = {}
	local var_9_1 = {}

	for iter_9_0 = 1, arg_9_0._col do
		for iter_9_1 = 1, arg_9_0._row do
			if arg_9_0:_canEx(iter_9_0, iter_9_1) then
				table.insert(var_9_1, iter_9_0)
				table.insert(var_9_1, iter_9_1)
			end
		end
	end

	local var_9_2 = math.floor(#var_9_1 / 2)
	local var_9_3 = {}
	local var_9_4
	local var_9_5

	while var_9_2 > #var_9_3 do
		local var_9_6 = math.random(1, var_9_2)
		local var_9_7 = false

		for iter_9_2 = 1, #var_9_3 do
			if var_9_3[iter_9_2] == var_9_6 then
				var_9_7 = true

				break
			end
		end

		if not var_9_7 then
			table.insert(var_9_3, var_9_6)

			if var_9_4 == nil then
				var_9_4 = var_9_6
			elseif var_9_5 == nil then
				var_9_5 = var_9_6
			end

			if var_9_5 ~= nil and var_9_4 ~= nil then
				local var_9_8 = var_9_1[var_9_4 * 2 - 1]
				local var_9_9 = var_9_1[var_9_4 * 2]
				local var_9_10 = var_9_1[var_9_5 * 2 - 1]
				local var_9_11 = var_9_1[var_9_5 * 2]

				table.insert(var_9_0, var_9_8)
				table.insert(var_9_0, var_9_9)
				table.insert(var_9_0, var_9_10)
				table.insert(var_9_0, var_9_11)
				arg_9_0:addChangePoints(var_9_8, var_9_9)
				arg_9_0:addChangePoints(var_9_10, var_9_11)
				arg_9_0:_exchangeCell(var_9_8, var_9_9, var_9_10, var_9_11)

				var_9_4 = nil
				var_9_5 = nil
			end
		end
	end

	if isDebugBuild then
		arg_9_0:printInfo("打乱棋盘后:")
	end

	return var_9_0
end

function var_0_0._canEx(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.cells[arg_10_1][arg_10_2]

	if var_10_0 == nil then
		return false
	end

	return var_10_0.id ~= -1 and not var_10_0:haveStatus(EliminateEnum_2_7.ChessState.Frost) and var_10_0.id ~= EliminateEnum_2_7.ChessTypeToIndex.stone
end

function var_0_0.resetCreateWeight(arg_11_0)
	arg_11_0._weights = {
		1,
		1,
		1,
		1
	}
end

function var_0_0.changeCreateWeight(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0

	for iter_12_0 = 1, #EliminateEnum_2_7.AllChessType do
		if EliminateEnum_2_7.AllChessType[iter_12_0] == arg_12_1 then
			var_12_0 = iter_12_0
		end
	end

	if var_12_0 ~= nil then
		arg_12_0._weights[var_12_0] = arg_12_0._weights[var_12_0] * arg_12_2
	end
end

function var_0_0.changeCellState(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_0.cells == nil or arg_13_0.cells[arg_13_1] == nil or arg_13_0.cells[arg_13_1][arg_13_2] == nil then
		return
	end

	arg_13_0.cells[arg_13_1][arg_13_2]:addStatus(arg_13_3)

	if isDebugBuild then
		arg_13_0:printInfo("改变状态: ")
	end
end

function var_0_0.changeCellId(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_0.cells == nil or arg_14_0.cells[arg_14_1][arg_14_2] == nil then
		return nil
	end

	local var_14_0 = arg_14_0.cells[arg_14_1][arg_14_2]

	var_14_0:setChessId(arg_14_3)
	var_14_0:setStatus(EliminateEnum_2_7.ChessState.Normal)

	if isDebugBuild then
		arg_14_0:printInfo("改变棋子类型：")
	end

	return var_14_0
end

function var_0_0.exchangeCell(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	if isDebugBuild then
		arg_15_0:printInfo("交换前: ")
	end

	if arg_15_5 then
		arg_15_0:_exchangeCell(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	end

	arg_15_0:addChangePoints(arg_15_1, arg_15_2)
	arg_15_0:addChangePoints(arg_15_3, arg_15_4)

	if isDebugBuild then
		arg_15_0:printInfo("交换后")
	end

	if not arg_15_0:check(false, true) then
		if arg_15_5 then
			arg_15_0:_exchangeCell(arg_15_3, arg_15_4, arg_15_1, arg_15_2)
		end

		if isDebugBuild then
			arg_15_0:printInfo("还原")
		end

		return false
	end

	return true
end

function var_0_0.eliminateCross(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = {}
	local var_16_1 = true

	local function var_16_2(arg_17_0, arg_17_1)
		var_16_1 = true

		local var_17_0 = #var_16_0 / 2

		for iter_17_0 = 1, var_17_0 do
			local var_17_1 = var_16_0[iter_17_0 * 2 - 1]
			local var_17_2 = var_16_0[iter_17_0 * 2]

			if var_17_1 == arg_17_0 and var_17_2 == arg_17_1 then
				var_16_1 = false

				break
			end
		end

		if var_16_1 then
			table.insert(var_16_0, arg_17_0)
			table.insert(var_16_0, arg_17_1)
		end
	end

	for iter_16_0 = 1, arg_16_0._row do
		local var_16_3 = arg_16_0.cells[iter_16_0][arg_16_2]

		if var_16_3.id ~= EliminateEnum_2_7.InvalidId and var_16_3:getEliminateID() ~= EliminateEnum_2_7.ChessType.stone then
			var_16_2(iter_16_0, arg_16_2)
		end
	end

	for iter_16_1 = 1, arg_16_0._col do
		local var_16_4 = arg_16_0.cells[arg_16_1][iter_16_1]

		if var_16_4.id ~= EliminateEnum_2_7.InvalidId and var_16_4:getEliminateID() ~= EliminateEnum_2_7.ChessType.stone then
			var_16_2(arg_16_1, iter_16_1)
		end
	end

	local var_16_5 = #var_16_0 / 2

	for iter_16_2 = 1, var_16_5 do
		local var_16_6 = var_16_0[iter_16_2 * 2 - 1]
		local var_16_7 = var_16_0[iter_16_2 * 2]
		local var_16_8 = {}

		table.insert(var_16_8, {
			x = var_16_6,
			y = var_16_7
		})

		local var_16_9 = {
			eliminatePoints = var_16_8,
			eliminateType = EliminateEnum_2_7.eliminateType.base,
			eliminateX = arg_16_1,
			eliminateY = arg_16_2,
			skillEffect = LengZhou6Enum.SkillEffect.EliminationCross
		}

		table.insert(arg_16_0._tempEliminateCheckResults, var_16_9)
	end

	arg_16_0:setEliminateDieEffect(LengZhou6Enum.SkillEffect.EliminationCross)
end

function var_0_0.eliminateRange(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_3 = (arg_18_3 - 1) / 2

	for iter_18_0 = -arg_18_3, arg_18_3 do
		for iter_18_1 = -arg_18_3, arg_18_3 do
			local var_18_0 = arg_18_1 + iter_18_0
			local var_18_1 = arg_18_2 + iter_18_1

			if var_18_0 > 0 and var_18_0 <= arg_18_0._row and var_18_1 > 0 and var_18_1 <= arg_18_0._col and arg_18_0.cells[var_18_0][var_18_1].id ~= EliminateEnum_2_7.InvalidId then
				local var_18_2 = {}

				table.insert(var_18_2, {
					x = var_18_0,
					y = var_18_1
				})

				local var_18_3 = {
					eliminatePoints = var_18_2,
					eliminateType = EliminateEnum_2_7.eliminateType.base,
					eliminateX = arg_18_1,
					eliminateY = arg_18_2,
					skillEffect = LengZhou6Enum.SkillEffect.EliminationRange
				}

				table.insert(arg_18_0._tempEliminateCheckResults, var_18_3)
			end
		end
	end

	arg_18_0:setEliminateDieEffect(LengZhou6Enum.SkillEffect.EliminationRange)
end

function var_0_0.checkEliminate(arg_19_0)
	if arg_19_0._eliminateCount == nil then
		arg_19_0:setEliminateCount(1)
	else
		arg_19_0:setEliminateCount(arg_19_0._eliminateCount + 1)
	end

	arg_19_0:AddEliminateRecord()
	arg_19_0:eliminate()

	if isDebugBuild then
		arg_19_0:printInfo("消除处理后")
	end

	arg_19_0:tidyUp()

	if isDebugBuild then
		arg_19_0:printInfo("整理处理后")
	end

	arg_19_0:fill()

	if isDebugBuild then
		arg_19_0:printInfo("填充处理后")
		arg_19_0:printInfo("消除次数：" .. arg_19_0._eliminateCount .. "次")
	end
end

function var_0_0.eliminate(arg_20_0)
	if #arg_20_0._tempEliminateCheckResults <= 0 then
		return
	end

	local var_20_0 = arg_20_0:getCurEliminateRecordData()
	local var_20_1 = arg_20_0:getEliminateRecordShowData()

	for iter_20_0 = 1, #arg_20_0._tempEliminateCheckResults do
		local var_20_2 = arg_20_0._tempEliminateCheckResults[iter_20_0]
		local var_20_3 = var_20_2.newCellStatus
		local var_20_4 = var_20_2.eliminateX
		local var_20_5 = var_20_2.eliminateY
		local var_20_6 = var_20_2.eliminatePoints
		local var_20_7 = var_20_2.eliminateType
		local var_20_8 = var_20_2.skillEffect
		local var_20_9 = false
		local var_20_10 = arg_20_0.cells[var_20_4][var_20_5]:haveStatus(EliminateEnum_2_7.ChessState.SpecialSkill)

		if var_20_6 ~= nil then
			local var_20_11
			local var_20_12 = 0
			local var_20_13 = 0

			for iter_20_1 = 1, #var_20_2.eliminatePoints do
				local var_20_14 = var_20_2.eliminatePoints[iter_20_1].x
				local var_20_15 = var_20_2.eliminatePoints[iter_20_1].y
				local var_20_16 = arg_20_0.cells[var_20_14][var_20_15]

				var_20_11 = var_20_16:getEliminateID()

				if var_20_16:haveStatus(EliminateEnum_2_7.ChessState.SpecialSkill) then
					var_20_13 = var_20_13 + 1
				end

				var_20_12 = var_20_12 + 1

				if not var_20_16:haveStatus(EliminateEnum_2_7.ChessState.Frost) then
					local var_20_17 = true
					local var_20_18 = false

					if var_20_3 ~= nil and var_20_3 == EliminateEnum_2_7.ChessState.SpecialSkill and (not var_20_10 or var_20_4 ~= var_20_14 or var_20_15 ~= var_20_5) and not var_20_9 then
						var_20_18 = true
						var_20_17 = false
					end

					if var_20_18 and not var_20_9 then
						var_20_16:addStatus(EliminateEnum_2_7.ChessState.SpecialSkill)
						var_20_1:addChangeType(var_20_14, var_20_15, EliminateEnum_2_7.ChessState.Normal)
						arg_20_0:addChangePoints(var_20_14, var_20_15)

						var_20_9 = true
					end

					if var_20_17 then
						var_20_16:setStatus(EliminateEnum_2_7.ChessState.Die)
						var_20_16:setChessId(EliminateEnum_2_7.InvalidId)
						var_20_1:addEliminate(var_20_14, var_20_15, var_20_8)
					end
				else
					var_20_16:setStatus(EliminateEnum_2_7.ChessState.Normal)
					var_20_1:addChangeType(var_20_14, var_20_15, EliminateEnum_2_7.ChessState.Frost)
				end
			end

			if var_20_11 ~= nil then
				var_20_0:setEliminateType(var_20_11, var_20_7, var_20_12, var_20_13)
			end
		end
	end

	tabletool.clear(arg_20_0._tempEliminateCheckResults)
end

function var_0_0.tidyUp(arg_21_0)
	local var_21_0 = arg_21_0:getEliminateRecordShowData()

	for iter_21_0 = 1, arg_21_0._row do
		for iter_21_1 = 1, arg_21_0._col do
			if arg_21_0.cells[iter_21_0][iter_21_1]:haveStatus(EliminateEnum_2_7.ChessState.Die) then
				local var_21_1 = arg_21_0:findNextStartIndex(iter_21_1 + 1, iter_21_0, arg_21_0._row)

				if var_21_1 ~= -1 then
					arg_21_0:_exchangeCell(iter_21_0, iter_21_1, iter_21_0, var_21_1)
					arg_21_0:addChangePoints(iter_21_0, iter_21_1)
					arg_21_0:addChangePoints(iter_21_0, var_21_1)
					var_21_0:addMove(iter_21_0, var_21_1, iter_21_0, iter_21_1)
				end
			end
		end
	end
end

function var_0_0.findNextStartIndex(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	for iter_22_0 = arg_22_1, arg_22_3 do
		local var_22_0 = arg_22_0.cells[arg_22_2][iter_22_0]
		local var_22_1 = var_22_0 and var_22_0:getStatus()

		if var_22_1 and var_22_0:haveStatus(EliminateEnum_2_7.ChessState.Frost) then
			break
		end

		if var_22_1 and not var_22_0:haveStatus(EliminateEnum_2_7.ChessState.Frost) and not var_22_0:haveStatus(EliminateEnum_2_7.ChessState.Die) then
			return iter_22_0
		end
	end

	return -1
end

function var_0_0.fill(arg_23_0)
	local var_23_0 = arg_23_0:getEliminateRecordShowData()

	for iter_23_0 = 1, arg_23_0._row do
		for iter_23_1 = 1, arg_23_0._col do
			local var_23_1 = arg_23_0.cells[iter_23_0][iter_23_1]
			local var_23_2

			var_23_2 = var_23_1 and var_23_1:getStatus()

			if var_23_1:haveStatus(EliminateEnum_2_7.ChessState.Die) and arg_23_0:findNextSpecialIndex(iter_23_1 + 1, iter_23_0, arg_23_0._row) == -1 then
				arg_23_0:createNewCell(iter_23_0, iter_23_1, EliminateEnum_2_7.ChessState.Normal):setStartXY(iter_23_0, arg_23_0._row + 1)
				arg_23_0:addChangePoints(iter_23_0, iter_23_1)
				var_23_0:addNew(iter_23_0, iter_23_1)
			end
		end
	end
end

function var_0_0.findNextSpecialIndex(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	for iter_24_0 = arg_24_1, arg_24_3 do
		local var_24_0 = arg_24_0.cells[arg_24_2][iter_24_0]

		if var_24_0 and var_24_0:getStatus() and var_24_0:haveStatus(EliminateEnum_2_7.ChessState.Frost) then
			return iter_24_0
		end
	end

	return -1
end

function var_0_0.check(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_0._changePoints ~= nil and #arg_25_0._changePoints > 0 then
		local var_25_0 = {}

		for iter_25_0 = 1, #arg_25_0._changePoints / 2 do
			local var_25_1 = arg_25_0._changePoints[iter_25_0 * 2 - 1]
			local var_25_2 = arg_25_0._changePoints[iter_25_0 * 2]
			local var_25_3 = arg_25_0:checkPoint(var_25_1, var_25_2)

			if var_25_3 and #var_25_3.eliminatePoints >= 3 then
				var_25_0[var_25_1 .. "_" .. var_25_2] = var_25_3
			end
		end

		local var_25_4 = {}

		for iter_25_1, iter_25_2 in pairs(var_25_0) do
			for iter_25_3 = 1, #iter_25_2.eliminatePoints do
				local var_25_5 = iter_25_2.eliminatePoints[iter_25_3].x
				local var_25_6 = iter_25_2.eliminatePoints[iter_25_3].y

				if var_25_5 ~= iter_25_2.eliminateX or var_25_6 ~= iter_25_2.eliminateY then
					local var_25_7 = var_25_5 .. "_" .. var_25_6
					local var_25_8 = false

					for iter_25_4 = 1, #var_25_4 do
						local var_25_9 = var_25_4[iter_25_4]

						if var_25_7 == var_25_9 or iter_25_1 == var_25_9 then
							var_25_8 = true

							break
						end
					end

					if not var_25_8 then
						local var_25_10 = var_25_0[var_25_7]

						if var_25_10 ~= nil and #var_25_10.eliminatePoints <= #iter_25_2.eliminatePoints then
							table.insert(var_25_4, var_25_7)
						end
					end
				end
			end
		end

		for iter_25_5, iter_25_6 in pairs(var_25_4) do
			var_25_0[iter_25_6] = nil
		end

		for iter_25_7, iter_25_8 in pairs(var_25_0) do
			if arg_25_0:canAddResult(iter_25_8) then
				table.insert(arg_25_0._tempEliminateCheckResults, iter_25_8)
			end
		end
	end

	if arg_25_1 then
		tabletool.clear(arg_25_0._changePoints)
	end

	if #arg_25_0._tempEliminateCheckResults > 0 then
		if arg_25_2 then
			tabletool.clear(arg_25_0._tempEliminateCheckResults)
		end

		return true
	end

	return false
end

function var_0_0.canAddResult(arg_26_0, arg_26_1)
	local var_26_0 = true

	for iter_26_0 = 1, #arg_26_0._tempEliminateCheckResults do
		local var_26_1 = arg_26_0._tempEliminateCheckResults[iter_26_0].eliminatePoints
		local var_26_2 = arg_26_1.eliminatePoints

		if #var_26_1 == #var_26_2 then
			local var_26_3 = true

			for iter_26_1 = 1, #var_26_1 do
				local var_26_4 = var_26_1[iter_26_1]
				local var_26_5 = var_26_2[iter_26_1]

				if var_26_4.x ~= var_26_5.x or var_26_4.y ~= var_26_5.y then
					var_26_3 = false

					break
				end
			end

			if var_26_3 then
				var_26_0 = false

				break
			end
		end
	end

	return var_26_0
end

function var_0_0.createNewCell(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = EliminateChessCellMO.New()

	arg_27_0:initCell(var_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)

	return var_27_0
end

function var_0_0.initCell(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5)
	if arg_28_5 == nil then
		arg_28_1:setChessId(arg_28_0:getRandomId())
	else
		arg_28_1:setChessId(arg_28_5)
	end

	arg_28_1:setXY(arg_28_2, arg_28_3)
	arg_28_1:setStatus(arg_28_4 and arg_28_4 or EliminateEnum_2_7.ChessState.Normal)

	arg_28_0.cells[arg_28_2][arg_28_3] = arg_28_1
end

function var_0_0.getRandomId(arg_29_0)
	local var_29_0 = LocalEliminateChessUtils.getFixDropId()

	if var_29_0 ~= nil then
		return var_29_0
	end

	arg_29_0._weights = arg_29_0._weights or {
		1,
		1,
		1,
		1
	}

	local var_29_1 = EliminateModelUtils.getRandomNumberByWeight(arg_29_0._weights)

	return EliminateEnum_2_7.AllChessID[var_29_1]
end

function var_0_0._exchangeCell(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	if arg_30_0.cells == nil or arg_30_0.cells[arg_30_1] == nil or arg_30_0.cells[arg_30_3] == nil then
		return
	end

	local var_30_0 = arg_30_0.cells[arg_30_1][arg_30_2]

	arg_30_0.cells[arg_30_1][arg_30_2] = arg_30_0.cells[arg_30_3][arg_30_4]

	arg_30_0.cells[arg_30_1][arg_30_2]:setXY(arg_30_1, arg_30_2)
	arg_30_0.cells[arg_30_1][arg_30_2]:setStartXY(arg_30_3, arg_30_4)

	arg_30_0.cells[arg_30_3][arg_30_4] = var_30_0

	arg_30_0.cells[arg_30_3][arg_30_4]:setXY(arg_30_3, arg_30_4)
	arg_30_0.cells[arg_30_3][arg_30_4]:setStartXY(arg_30_1, arg_30_2)
end

function var_0_0.checkPoint(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0:checkWithDirection(arg_31_1, arg_31_2, var_0_1, arg_31_0._row, arg_31_0._col)
	local var_31_1 = arg_31_0:checkWithDirection(arg_31_1, arg_31_2, var_0_2, arg_31_0._row, arg_31_0._col)
	local var_31_2 = {}
	local var_31_3
	local var_31_4 = EliminateEnum_2_7.eliminateType.three

	if #var_31_0 >= 5 or #var_31_1 >= 5 then
		var_31_3 = EliminateEnum_2_7.ChessState.SpecialSkill
		var_31_4 = EliminateEnum_2_7.eliminateType.five
	elseif #var_31_0 >= 3 and #var_31_1 >= 3 then
		var_31_3 = EliminateEnum_2_7.ChessState.SpecialSkill
		var_31_4 = EliminateEnum_2_7.eliminateType.cross
	elseif #var_31_0 >= 4 then
		var_31_3 = EliminateEnum_2_7.ChessState.SpecialSkill
		var_31_4 = EliminateEnum_2_7.eliminateType.four
	elseif #var_31_1 >= 4 then
		var_31_3 = EliminateEnum_2_7.ChessState.SpecialSkill
		var_31_4 = EliminateEnum_2_7.eliminateType.four
	end

	if #var_31_0 >= 3 then
		var_31_2 = var_31_0
	end

	if #var_31_1 >= 3 then
		var_31_2 = EliminateModelUtils.mergePointArray(var_31_2, var_31_1)
	end

	return {
		eliminatePoints = var_31_2,
		newCellStatus = var_31_3,
		oldCellStatus = arg_31_0.cells[arg_31_1][arg_31_2]:getStatus(),
		eliminateX = arg_31_1,
		eliminateY = arg_31_2,
		eliminateType = var_31_4,
		skillEffect = LengZhou6Enum.NormalEliminateEffect
	}
end

function var_0_0.checkWithDirection(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
	local var_32_0 = {}
	local var_32_1 = {
		[arg_32_1 + arg_32_2 * arg_32_5] = true
	}

	table.insert(var_32_0, {
		x = arg_32_1,
		y = arg_32_2
	})

	local var_32_2 = 1

	while var_32_2 <= #var_32_0 do
		local var_32_3 = var_32_0[var_32_2]

		arg_32_1 = var_32_3.x
		arg_32_2 = var_32_3.y

		local var_32_4 = arg_32_0.cells[arg_32_1][arg_32_2]

		var_32_2 = var_32_2 + 1

		if not var_32_4 then
			-- block empty
		else
			for iter_32_0 = 1, #arg_32_3 do
				local var_32_5 = arg_32_1 + arg_32_3[iter_32_0].x
				local var_32_6 = arg_32_2 + arg_32_3[iter_32_0].y

				if var_32_5 < 1 or arg_32_4 < var_32_5 or var_32_6 < 1 or arg_32_5 < var_32_6 or var_32_1[var_32_5 + var_32_6 * arg_32_5] or arg_32_0.cells[var_32_5] == nil or arg_32_0.cells[var_32_5][var_32_6] == nil then
					-- block empty
				elseif var_32_4.id == arg_32_0.cells[var_32_5][var_32_6].id and var_32_4.id ~= EliminateEnum_2_7.InvalidId and var_32_4.id ~= EliminateEnum_2_7.ChessTypeToIndex.stone then
					var_32_1[var_32_5 + var_32_6 * arg_32_5] = true

					table.insert(var_32_0, {
						x = var_32_5,
						y = var_32_6
					})
				end
			end
		end
	end

	return var_32_0
end

function var_0_0.getAllEliminateIdPos(arg_33_0, arg_33_1)
	local var_33_0 = {}

	for iter_33_0 = 1, arg_33_0._row do
		for iter_33_1 = 1, arg_33_0._col do
			if arg_33_0:getCell(iter_33_0, iter_33_1).id == arg_33_1 then
				table.insert(var_33_0, {
					x = iter_33_0,
					y = iter_33_1
				})
			end
		end
	end

	return var_33_0
end

function var_0_0.canEliminate(arg_34_0)
	if arg_34_0.cells == nil then
		return nil
	end

	return LocalEliminateChessUtils.instance.canEliminate(arg_34_0.cells, arg_34_0._row, arg_34_0._col)
end

function var_0_0.createInitMoveState(arg_35_0)
	local var_35_0 = LocalEliminateChessUtils.instance.generateUnsolvableBoard(EliminateEnum_2_7.MaxRow, EliminateEnum_2_7.MaxCol)

	arg_35_0:initByData(var_35_0)
end

function var_0_0.addChangePoints(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_0._changePoints == nil then
		arg_36_0._changePoints = {}
	end

	table.insert(arg_36_0._changePoints, arg_36_1)
	table.insert(arg_36_0._changePoints, arg_36_2)
end

function var_0_0.printInfo(arg_37_0, arg_37_1)
	if isDebugBuild then
		local var_37_0 = "\n"

		for iter_37_0 = arg_37_0._row, 1, -1 do
			local var_37_1 = ""

			for iter_37_1 = 1, arg_37_0._col do
				local var_37_2 = arg_37_0.cells[iter_37_1][iter_37_0]
				local var_37_3 = var_37_2:getStatus()
				local var_37_4 = 0

				for iter_37_2 = 1, #var_37_3 do
					var_37_4 = var_37_4 + var_37_3[iter_37_2]
				end

				var_37_1 = var_37_1 .. var_37_2.id .. "[" .. var_37_4 .. "]" .. " "
			end

			var_37_0 = var_37_0 .. var_37_1 .. "\n"
		end

		logNormal((arg_37_1 and arg_37_1 or "") .. var_37_0)
	end
end

function var_0_0.recordSpEffect(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	if arg_38_0._chessEffect == nil then
		arg_38_0._chessEffect = {}
	end

	arg_38_0._chessEffect[arg_38_1 .. "_" .. arg_38_2] = arg_38_3

	arg_38_0:addSpEffectCd(arg_38_1, arg_38_2, arg_38_3)
end

function var_0_0.getSpEffect(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_0._chessEffect == nil then
		return nil
	end

	return arg_39_0._chessEffect[arg_39_1 .. "_" .. arg_39_2]
end

function var_0_0.clearAllEffect(arg_40_0)
	if arg_40_0._chessEffect ~= nil then
		tabletool.clear(arg_40_0._chessEffect)
	end

	if arg_40_0._needChessCdEffect ~= nil then
		tabletool.clear(arg_40_0._needChessCdEffect)
	end
end

function var_0_0.addSpEffectCd(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	if arg_41_0._needChessCdEffect == nil then
		arg_41_0._needChessCdEffect = {}
	end

	if arg_41_3 and arg_41_3 == EliminateEnum_2_7.ChessEffect.pollution then
		local var_41_0 = LengZhou6Config.instance:getEliminateBattleCost(32)

		table.insert(arg_41_0._needChessCdEffect, {
			x = arg_41_1,
			y = arg_41_2,
			cd = var_41_0,
			effect = arg_41_3
		})
	end
end

function var_0_0.updateSpEffectCd(arg_42_0)
	if arg_42_0._needChessCdEffect == nil then
		return
	end

	local var_42_0 = {}

	for iter_42_0 = 1, #arg_42_0._needChessCdEffect do
		local var_42_1 = arg_42_0._needChessCdEffect[iter_42_0]

		if var_42_1.cd <= 0 then
			local var_42_2 = var_42_1.x
			local var_42_3 = var_42_1.y
			local var_42_4 = var_42_1.effect

			LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.HideEffect, var_42_2, var_42_3, var_42_4)

			var_42_0[iter_42_0] = true
		else
			var_42_1.cd = var_42_1.cd - 1
			arg_42_0._needChessCdEffect[iter_42_0] = var_42_1
		end
	end

	for iter_42_1 = #arg_42_0._needChessCdEffect, 1, -1 do
		if var_42_0[iter_42_1] then
			table.remove(arg_42_0._needChessCdEffect, iter_42_1)
		end
	end
end

function var_0_0.setEliminateCount(arg_43_0, arg_43_1)
	arg_43_0._eliminateCount = arg_43_1
end

function var_0_0.roundDataClear(arg_44_0)
	arg_44_0:setEliminateCount(nil)

	if arg_44_0._allEliminateRecordData ~= nil then
		tabletool.clear(arg_44_0._allEliminateRecordData)
	end
end

function var_0_0.AddEliminateRecord(arg_45_0)
	if arg_45_0._allEliminateRecordData == nil then
		arg_45_0._allEliminateRecordData = {}
	end

	local var_45_0 = EliminateRecordDataMO.New()

	table.insert(arg_45_0._allEliminateRecordData, var_45_0)
end

function var_0_0.getCurEliminateRecordData(arg_46_0)
	if arg_46_0._allEliminateRecordData == nil then
		arg_46_0:AddEliminateRecord()
	end

	return arg_46_0._allEliminateRecordData[#arg_46_0._allEliminateRecordData]
end

function var_0_0.getAllEliminateRecordData(arg_47_0)
	return arg_47_0._allEliminateRecordData
end

function var_0_0.getEliminateRecordShowData(arg_48_0)
	if arg_48_0._eliminateRecordShowMo == nil then
		arg_48_0._eliminateRecordShowMo = EliminateRecordShowMO.New()
	end

	return arg_48_0._eliminateRecordShowMo
end

function var_0_0.clear(arg_49_0)
	arg_49_0._eliminateRecordShowMo = nil
	arg_49_0._allEliminateRecordData = nil
	arg_49_0.cells = nil
	arg_49_0._weights = nil
	arg_49_0._needChessCdEffect = nil
	arg_49_0._chessEffect = nil
end

function var_0_0.testRound(arg_50_0)
	local var_50_0 = {}

	for iter_50_0 = 1, 10000 do
		local var_50_1 = arg_50_0:getRandomId()
		local var_50_2 = EliminateEnum_2_7.ChessIndexToType[var_50_1]

		table.insert(var_50_0, var_50_2)
	end

	local var_50_3 = {}

	for iter_50_1 = 1, #var_50_0 do
		local var_50_4 = var_50_0[iter_50_1]

		if var_50_3[var_50_4] == nil then
			var_50_3[var_50_4] = 1
		else
			var_50_3[var_50_4] = var_50_3[var_50_4] + 1
		end
	end

	local var_50_5 = ""

	for iter_50_2, iter_50_3 in pairs(var_50_3) do
		var_50_5 = var_50_5 .. iter_50_2 .. " : " .. iter_50_3 / 10000 * 100 .. "%\n"
	end

	logNormal(var_50_5)
end

var_0_0.instance = var_0_0.New()

return var_0_0
