module("modules.logic.versionactivity1_4.puzzle.model.Role37PuzzleModel", package.seeall)

local var_0_0 = class("Role37PuzzleModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.clear(arg_2_0)
	arg_2_0.puzzleCfg = nil
	arg_2_0.maxStep = nil
	arg_2_0.maxOper = nil
	arg_2_0.operGroupId = nil
	arg_2_0.operGroupCfg = nil
	arg_2_0.operGroupList = nil
	arg_2_0.matchList = nil
	arg_2_0.operList = nil
	arg_2_0.recordList = nil
	arg_2_0.controllRecords = nil
	arg_2_0.isSucess = nil
end

function var_0_0.setPuzzleId(arg_3_0, arg_3_1)
	arg_3_0.puzzleId = arg_3_1

	arg_3_0:initCfg()
	arg_3_0:initParam()
end

function var_0_0.initCfg(arg_4_0)
	arg_4_0.puzzleCfg = Activity130Config.instance:getActivity130DecryptCo(Activity130Enum.ActivityId.Act130, arg_4_0.puzzleId)
	arg_4_0.maxStep = arg_4_0.puzzleCfg.maxStep
	arg_4_0.maxOper = arg_4_0.puzzleCfg.maxOper
	arg_4_0.operGroupId = arg_4_0.puzzleCfg.operGroupId
	arg_4_0.operGroupCfg = Activity130Config.instance:getOperGroup(Activity130Enum.ActivityId.Act130, arg_4_0.operGroupId)
	arg_4_0.operGroupList = {}

	local var_4_0 = Activity130Config.instance:getOperGroup(Activity130Enum.ActivityId.Act130, arg_4_0.operGroupId)

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		table.insert(arg_4_0.operGroupList, iter_4_1)
	end

	table.sort(arg_4_0.operGroupList, function(arg_5_0, arg_5_1)
		return arg_5_0.operType < arg_5_1.operType
	end)

	arg_4_0.matchList = string.splitToNumber(arg_4_0.puzzleCfg.answer, "|")
end

function var_0_0.initParam(arg_6_0)
	arg_6_0.operList = {}
	arg_6_0.recordList = {}

	PuzzleRecordListModel.instance:clearRecord()

	arg_6_0.controllRecords = {}

	arg_6_0:initVariable()
	arg_6_0:setCurErrorIndex(0)

	arg_6_0.isSucess = false
end

function var_0_0.initVariable(arg_7_0)
	arg_7_0.maxDis = 8
	arg_7_0.remainDis = arg_7_0.maxDis
	arg_7_0.passDay = 1
	arg_7_0.handleBa = 0
	arg_7_0.maxHandle = 6
	arg_7_0.curPos = 1
	arg_7_0.maxPos = 7
	arg_7_0.routeBaList = {
		12,
		0,
		0,
		0,
		0,
		0,
		0
	}
	arg_7_0.leftBank = {
		1,
		2,
		3
	}
	arg_7_0.rightBank = {}
	arg_7_0.boat = {}
	arg_7_0.curBank = arg_7_0.leftBank
	arg_7_0.moveCnt = 0
end

function var_0_0._addRecord(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:getResultDesc(arg_8_1, arg_8_2)

	table.insert(arg_8_0.recordList, var_8_0)
end

function var_0_0._directAddRecord(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2 = arg_9_2 or false

	table.insert(arg_9_0.recordList, arg_9_1)

	if arg_9_2 then
		arg_9_0:_updateRecord()
	end
end

function var_0_0._repelaceRecord(arg_10_0, arg_10_1)
	arg_10_0.recordList[#arg_10_0.recordList] = arg_10_1

	arg_10_0:_updateRecord()
end

function var_0_0._updateRecord(arg_11_0)
	PuzzleRecordListModel.instance:setRecordList(arg_11_0.recordList)
end

function var_0_0.getRecordMo(arg_12_0, arg_12_1)
	local var_12_0 = PuzzleRecordMO.New()
	local var_12_1 = arg_12_0.recordList[arg_12_1]

	if arg_12_1 < 10 then
		arg_12_1 = "0" .. arg_12_1
	end

	var_12_0:init(arg_12_1, var_12_1)

	return var_12_0
end

function var_0_0.addOption(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_0.curErrorIndex ~= 0 and not arg_13_3 then
		if arg_13_0.curErrorIndex == 999 then
			GameFacade.showToastString(luaLang("v1a4_role37_puzzle_monkeybanana_not_enough"))
		else
			GameFacade.showToastString(luaLang("v1a4_role37_puzzle_error_tip"))
		end

		return
	end

	if arg_13_0.operList[arg_13_2] then
		arg_13_0:repleaceOption(arg_13_1, arg_13_2)

		return
	end

	if tabletool.len(arg_13_0.operList) >= arg_13_0.maxOper then
		GameFacade.showToastString(luaLang("v1a4_role37_puzzle_oper_full"))

		return
	end

	arg_13_0.operList[arg_13_2] = arg_13_1

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.AddOption, arg_13_2)
	arg_13_0:recalculate()

	if not arg_13_3 then
		table.insert(arg_13_0.controllRecords, {
			Role37PuzzleEnum.ControlType.Add,
			arg_13_2
		})
	end

	arg_13_0:checkReply()
end

function var_0_0.exchangeOption(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if not arg_14_0.operList[arg_14_2] then
		arg_14_0:moveOption(arg_14_1, arg_14_2)

		return
	end

	local var_14_0 = arg_14_0.operList[arg_14_1]

	arg_14_0.operList[arg_14_1] = arg_14_0.operList[arg_14_2]
	arg_14_0.operList[arg_14_2] = var_14_0

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ExchangeOption, arg_14_1, arg_14_2)
	arg_14_0:recalculate()

	if not arg_14_3 then
		table.insert(arg_14_0.controllRecords, {
			Role37PuzzleEnum.ControlType.Exchange,
			arg_14_2,
			arg_14_1
		})
	end

	arg_14_0:checkReply()
end

function var_0_0.removeOption(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.operList[arg_15_1]

	arg_15_0.operList[arg_15_1] = nil

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.RemoveOption, arg_15_1)
	arg_15_0:recalculate()

	if not arg_15_2 then
		table.insert(arg_15_0.controllRecords, {
			Role37PuzzleEnum.ControlType.Remove,
			var_15_0,
			arg_15_1
		})
	end

	arg_15_0:checkReply()
end

function var_0_0.repleaceOption(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0.operList[arg_16_2]

	arg_16_0.operList[arg_16_2] = arg_16_1

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.RepleaceOption, arg_16_1, arg_16_2)
	arg_16_0:recalculate()

	if not arg_16_3 then
		table.insert(arg_16_0.controllRecords, {
			Role37PuzzleEnum.ControlType.Repleace,
			var_16_0,
			arg_16_2
		})
	end

	arg_16_0:checkReply()
end

function var_0_0.moveOption(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0.operList[arg_17_2] = arg_17_0.operList[arg_17_1]
	arg_17_0.operList[arg_17_1] = nil

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.MoveOption, arg_17_1, arg_17_2)
	arg_17_0:recalculate()

	if not arg_17_3 then
		table.insert(arg_17_0.controllRecords, {
			Role37PuzzleEnum.ControlType.Move,
			arg_17_2,
			arg_17_1
		})
	end

	arg_17_0:checkReply()
end

function var_0_0.rollBack(arg_18_0)
	if #arg_18_0.controllRecords == 0 then
		return
	end

	local var_18_0 = arg_18_0.controllRecords[#arg_18_0.controllRecords]
	local var_18_1 = var_18_0[1]

	arg_18_0.controllRecords[#arg_18_0.controllRecords] = nil

	if var_18_1 == Role37PuzzleEnum.ControlType.Add then
		arg_18_0:removeOption(var_18_0[2], true)
	elseif var_18_1 == Role37PuzzleEnum.ControlType.Exchange then
		arg_18_0:exchangeOption(var_18_0[2], var_18_0[3], true)
	elseif var_18_1 == Role37PuzzleEnum.ControlType.Remove then
		arg_18_0:addOption(var_18_0[2], var_18_0[3], true)
	elseif var_18_1 == Role37PuzzleEnum.ControlType.Repleace then
		arg_18_0:repleaceOption(var_18_0[2], var_18_0[3], true)
	elseif var_18_1 == Role37PuzzleEnum.ControlType.Move then
		arg_18_0:moveOption(var_18_0[2], var_18_0[3], true)
	end
end

function var_0_0.reset(arg_19_0)
	arg_19_0:initParam()
	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.Reset)
end

function var_0_0.recalculate(arg_20_0)
	arg_20_0:initVariable()

	arg_20_0.recordList = {}

	local var_20_0 = tabletool.len(arg_20_0.operList)

	if var_20_0 == 0 then
		if arg_20_0.curErrorIndex ~= 0 then
			arg_20_0:setCurErrorIndex(0)
			Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, arg_20_0.curErrorIndex)
		end
	else
		local var_20_1 = 0

		for iter_20_0 = 1, var_20_0 do
			local var_20_2 = arg_20_0.operList[iter_20_0 + var_20_1]

			while var_20_2 == nil do
				var_20_1 = var_20_1 + 1
				var_20_2 = arg_20_0.operList[iter_20_0 + var_20_1]
			end

			if arg_20_0:RunLogic(var_20_2, var_20_1 + iter_20_0) then
				arg_20_0:_addRecord(var_20_2, var_20_1 + iter_20_0)
			else
				break
			end
		end
	end

	arg_20_0:_updateRecord()
end

function var_0_0.getOperList(arg_21_0)
	return arg_21_0.operList
end

function var_0_0.getFirstGapIndex(arg_22_0)
	local var_22_0 = tabletool.len(arg_22_0.operList)

	for iter_22_0 = 1, var_22_0 do
		if not arg_22_0.operList[iter_22_0] then
			return iter_22_0
		end
	end

	return var_22_0 + 1
end

function var_0_0.RunLogic(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0.puzzleId == Role37PuzzleEnum.PuzzleId.SnailMove then
		arg_23_0:_snailMove(arg_23_1, arg_23_2)

		return true
	elseif arg_23_0.puzzleId == Role37PuzzleEnum.PuzzleId.MonkeyBanana then
		return arg_23_0:_monkeyBanana(arg_23_1, arg_23_2)
	elseif arg_23_0.puzzleId == Role37PuzzleEnum.PuzzleId.WolfSheepDish then
		return arg_23_0:_wolfSheepDish(arg_23_1, arg_23_2)
	else
		return true
	end
end

function var_0_0._snailMove(arg_24_0, arg_24_1)
	if arg_24_1 == Role37PuzzleEnum.OperType.One then
		arg_24_0.remainDis = arg_24_0.remainDis - 3

		if arg_24_0.remainDis < 0 then
			arg_24_0.remainDis = 0
		end
	elseif arg_24_1 == Role37PuzzleEnum.OperType.Two then
		arg_24_0.remainDis = arg_24_0.remainDis + 2

		if arg_24_0.remainDis > arg_24_0.maxDis then
			arg_24_0.remainDis = arg_24_0.maxDis
		end
	elseif arg_24_1 == Role37PuzzleEnum.OperType.Three then
		arg_24_0.passDay = arg_24_0.passDay + 1
	end
end

function var_0_0._monkeyBanana(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = 0

	if arg_25_1 == Role37PuzzleEnum.OperType.One then
		local var_25_1 = arg_25_0.maxHandle - arg_25_0.handleBa
		local var_25_2 = arg_25_0.routeBaList[arg_25_0.curPos] - var_25_1

		if var_25_2 < 0 then
			arg_25_0.handleBa = arg_25_0.handleBa + arg_25_0.routeBaList[arg_25_0.curPos]
			arg_25_0.routeBaList[arg_25_0.curPos] = 0
		else
			arg_25_0.handleBa = arg_25_0.maxHandle
			arg_25_0.routeBaList[arg_25_0.curPos] = var_25_2
		end
	elseif arg_25_1 == Role37PuzzleEnum.OperType.Two then
		if arg_25_0.curPos + 3 <= arg_25_0.maxPos then
			arg_25_0.curPos = arg_25_0.curPos + 3

			local var_25_3 = arg_25_0.handleBa - 3

			if var_25_3 >= 0 then
				arg_25_0.handleBa = var_25_3
			else
				arg_25_0.handleBa = 0
			end
		else
			var_25_0 = arg_25_2

			arg_25_0:_directAddRecord(luaLang("v1a4_role37_puzzle_monkeybanana_arrive_destination"))
		end
	elseif arg_25_1 == Role37PuzzleEnum.OperType.Four then
		local var_25_4 = arg_25_0.curPos - 1

		arg_25_0.curPos = 1
		arg_25_0.handleBa = arg_25_0.handleBa - var_25_4

		if arg_25_0.handleBa < 0 then
			arg_25_0.handleBa = 0
		end
	elseif arg_25_1 == Role37PuzzleEnum.OperType.Five then
		arg_25_0.routeBaList[arg_25_0.curPos] = arg_25_0.routeBaList[arg_25_0.curPos] + arg_25_0.handleBa
		arg_25_0.handleBa = 0
	end

	if arg_25_0.curErrorIndex ~= var_25_0 then
		arg_25_0:setCurErrorIndex(var_25_0)
		Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, arg_25_0.curErrorIndex)
	end

	return arg_25_0.curErrorIndex == 0
end

function var_0_0._wolfSheepDish(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = 0

	if arg_26_1 == Role37PuzzleEnum.OperType.One or arg_26_1 == Role37PuzzleEnum.OperType.Two or arg_26_1 == Role37PuzzleEnum.OperType.Three then
		local var_26_1 = tabletool.indexOf(arg_26_0.curBank, Role37PuzzleEnum.AnimalRules[arg_26_1])

		if var_26_1 and #arg_26_0.boat == 0 then
			table.remove(arg_26_0.curBank, var_26_1)

			arg_26_0.boat[1] = Role37PuzzleEnum.AnimalRules[arg_26_1]
			arg_26_0.lastPick = arg_26_0.curBank
		else
			var_26_0 = arg_26_2

			if not var_26_1 then
				arg_26_0:_directAddRecord(luaLang("v1a4_role37_puzzle_animal_pick_fault"))
			else
				arg_26_0:_directAddRecord(luaLang("v1a4_role37_puzzle_animal_boat_full"), false)
			end
		end
	elseif arg_26_1 == Role37PuzzleEnum.OperType.Four then
		arg_26_0.curBank = arg_26_0.leftBank

		if #arg_26_0.rightBank == 2 and math.abs(arg_26_0.rightBank[2] - arg_26_0.rightBank[1]) == 1 then
			var_26_0 = arg_26_2

			arg_26_0:_directAddRecord(luaLang("v1a4_role37_puzzle_animal_eat"), false)
		end
	elseif arg_26_1 == Role37PuzzleEnum.OperType.Five then
		arg_26_0.curBank = arg_26_0.rightBank

		if #arg_26_0.leftBank == 2 and math.abs(arg_26_0.leftBank[2] - arg_26_0.leftBank[1]) == 1 then
			var_26_0 = arg_26_2

			arg_26_0:_directAddRecord(luaLang("v1a4_role37_puzzle_animal_eat"), false)
		end
	elseif arg_26_1 == Role37PuzzleEnum.OperType.Six and arg_26_0.boat[1] then
		table.insert(arg_26_0.curBank, arg_26_0.boat[1])

		arg_26_0.boat[1] = nil

		if arg_26_0.lastPick and arg_26_0.lastPick ~= arg_26_0.curBank then
			arg_26_0.lastPick = nil
			arg_26_0.moveCnt = arg_26_0.moveCnt + 1
		end
	end

	if arg_26_0.curErrorIndex ~= var_26_0 then
		arg_26_0:setCurErrorIndex(var_26_0)
		Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, arg_26_0.curErrorIndex)
	end

	return arg_26_0.curErrorIndex == 0
end

function var_0_0.getBankDesc(arg_27_0, arg_27_1)
	local var_27_0 = ""

	for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
		local var_27_1 = luaLang(Role37PuzzleEnum.AnimalStr[iter_27_1])

		if var_27_0 ~= "" then
			var_27_0 = var_27_0 .. " "
		end

		var_27_0 = var_27_0 .. var_27_1
	end

	local var_27_2 = arg_27_0:getSentenceSep()

	if arg_27_1 == arg_27_0.leftBank then
		if not string.nilorempty(var_27_0) then
			var_27_0 = formatLuaLang("v1a4_role37_puzzle_leftbank_leave", var_27_0) .. var_27_2
		end
	elseif arg_27_1 == arg_27_0.rightBank then
		if not string.nilorempty(var_27_0) then
			var_27_0 = formatLuaLang("v1a4_role37_puzzle_rightbank_leave", var_27_0) .. var_27_2
		end
	elseif not string.nilorempty(var_27_0) then
		var_27_0 = formatLuaLang("v1a4_role37_puzzle_boat_leave", var_27_0) .. var_27_2
	end

	return var_27_0
end

function var_0_0.getSentenceSep(arg_28_0)
	if LangSettings.instance:isJp() then
		return " "
	elseif LangSettings.instance:isEn() or LangSettings.instance:isKr() then
		return ""
	else
		return ","
	end
end

function var_0_0.getSortError5(arg_29_0)
	local var_29_0 = arg_29_0:getErrorSep()
	local var_29_1 = ""
	local var_29_2 = tabletool.indexOf(arg_29_0.operList, 1)
	local var_29_3 = tabletool.indexOf(arg_29_0.operList, 2)
	local var_29_4 = tabletool.indexOf(arg_29_0.operList, 4)
	local var_29_5 = tabletool.indexOf(arg_29_0.operList, 5)
	local var_29_6 = tabletool.indexOf(arg_29_0.operList, 6)

	if var_29_2 ~= 5 then
		var_29_1 = var_29_1 .. var_29_0 .. arg_29_0.operGroupCfg[1].name
	end

	if var_29_3 > 3 then
		var_29_1 = var_29_1 .. var_29_0 .. arg_29_0.operGroupCfg[2].name
	end

	if var_29_4 == 1 or var_29_4 == 5 or math.abs(var_29_4 - var_29_2) == 1 then
		var_29_1 = var_29_1 .. var_29_0 .. arg_29_0.operGroupCfg[4].name
	end

	if not arg_29_0.operList[var_29_5 - 1] or arg_29_0.operList[var_29_5 - 1] ~= 2 then
		var_29_1 = var_29_1 .. var_29_0 .. arg_29_0.operGroupCfg[5].name
	end

	if var_29_6 == 1 or var_29_6 == 5 then
		var_29_1 = var_29_1 .. var_29_0 .. arg_29_0.operGroupCfg[6].name
	end

	return var_29_1
end

function var_0_0.getSortError7(arg_30_0)
	local var_30_0 = arg_30_0:getErrorSep()
	local var_30_1 = ""
	local var_30_2 = tabletool.indexOf(arg_30_0.operList, 1)
	local var_30_3 = tabletool.indexOf(arg_30_0.operList, 2)
	local var_30_4 = tabletool.indexOf(arg_30_0.operList, 3)
	local var_30_5 = tabletool.indexOf(arg_30_0.operList, 4)
	local var_30_6 = tabletool.indexOf(arg_30_0.operList, 5)
	local var_30_7 = tabletool.indexOf(arg_30_0.operList, 6)
	local var_30_8 = tabletool.indexOf(arg_30_0.operList, 7)

	if math.abs(var_30_2 - var_30_3) == 1 then
		var_30_1 = var_30_1 .. var_30_0 .. arg_30_0.operGroupCfg[1].name
	end

	if math.abs(var_30_3 - var_30_2) ~= math.abs(var_30_4 - var_30_6) then
		var_30_1 = var_30_1 .. var_30_0 .. arg_30_0.operGroupCfg[2].name
	end

	if math.abs(var_30_6 - var_30_4) < 4 then
		var_30_1 = var_30_1 .. var_30_0 .. arg_30_0.operGroupCfg[3].name
	end

	if var_30_5 == 1 or var_30_5 > 3 then
		var_30_1 = var_30_1 .. var_30_0 .. arg_30_0.operGroupCfg[4].name
	end

	if math.abs(var_30_6 - var_30_4) == 1 then
		var_30_1 = var_30_1 .. var_30_0 .. arg_30_0.operGroupCfg[5].name
	end

	if math.abs(var_30_7 - var_30_8) ~= 1 then
		var_30_1 = var_30_1 .. var_30_0 .. arg_30_0.operGroupCfg[6].name
	end

	if var_30_7 < var_30_8 then
		var_30_1 = var_30_1 .. var_30_0 .. arg_30_0.operGroupCfg[7].name
	end

	return var_30_1
end

function var_0_0.getErrorSep(arg_31_0)
	if LangSettings.instance:isEn() then
		return ", "
	end

	return " "
end

function var_0_0.getResultDesc(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0:getSentenceSep()
	local var_32_1 = arg_32_0.operGroupCfg[arg_32_1].operDesc .. var_32_0

	if arg_32_0.puzzleId == Role37PuzzleEnum.PuzzleId.SnailMove then
		local var_32_2 = {
			arg_32_0.remainDis,
			arg_32_0.passDay
		}

		return GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_snailmove_result"), var_32_2)
	elseif arg_32_0.puzzleId == Role37PuzzleEnum.PuzzleId.SortByRules5 then
		local var_32_3 = arg_32_0.operGroupCfg[arg_32_1].name
		local var_32_4 = {
			var_32_3,
			arg_32_2
		}

		return GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_sortbyrules_result"), var_32_4)
	elseif arg_32_0.puzzleId == Role37PuzzleEnum.PuzzleId.MonkeyBanana then
		local var_32_5
		local var_32_6 = arg_32_0.routeBaList[1]
		local var_32_7 = arg_32_0.routeBaList[4]
		local var_32_8 = arg_32_0.maxPos - arg_32_0.curPos

		if var_32_6 > 0 and var_32_7 > 0 then
			local var_32_9 = {
				var_32_8,
				arg_32_0.handleBa,
				var_32_6,
				var_32_7
			}

			var_32_5 = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_monkeybanana_result1"), var_32_9)
		elseif var_32_6 > 0 and var_32_7 == 0 then
			local var_32_10 = {
				var_32_8,
				arg_32_0.handleBa,
				var_32_6
			}

			var_32_5 = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_monkeybanana_result2"), var_32_10)
		elseif var_32_6 == 0 and var_32_7 > 0 then
			local var_32_11 = {
				var_32_8,
				arg_32_0.handleBa,
				var_32_7
			}

			var_32_5 = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_monkeybanana_result3"), var_32_11)
		else
			local var_32_12 = {
				var_32_8,
				arg_32_0.handleBa
			}

			var_32_5 = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_monkeybanana_result4"), var_32_12)
		end

		return var_32_1 .. var_32_5
	elseif arg_32_0.puzzleId == Role37PuzzleEnum.PuzzleId.SortByRules7 then
		local var_32_13 = arg_32_0.operGroupCfg[arg_32_1].name
		local var_32_14 = {
			var_32_13,
			arg_32_2
		}

		return GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_sortbyrules_result"), var_32_14)
	elseif arg_32_0.puzzleId == Role37PuzzleEnum.PuzzleId.WolfSheepDish then
		local var_32_15

		if arg_32_0.curBank == arg_32_0.leftBank then
			var_32_15 = luaLang("v1a4_role37_puzzle_animal_leftbank") .. var_32_0
		else
			var_32_15 = luaLang("v1a4_role37_puzzle_animal_rightbank") .. var_32_0
		end

		local var_32_16 = arg_32_0:getBankDesc(arg_32_0.leftBank)
		local var_32_17 = arg_32_0:getBankDesc(arg_32_0.rightBank)
		local var_32_18 = arg_32_0:getBankDesc(arg_32_0.boat)
		local var_32_19 = string.format(luaLang("v1a4_role37_puzzle_animal_movecnt"), arg_32_0.moveCnt)

		return var_32_1 .. var_32_15 .. var_32_16 .. var_32_18 .. var_32_17 .. var_32_19
	elseif arg_32_0.puzzleId == Role37PuzzleEnum.PuzzleId.Final then
		local var_32_20 = arg_32_0.operGroupCfg[arg_32_1].name
		local var_32_21 = {
			var_32_20,
			arg_32_2
		}

		return GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_sortbyrules_result"), var_32_21)
	end

	return ""
end

function var_0_0.checkReply(arg_33_0)
	local var_33_0 = tabletool.len(arg_33_0.operList)

	if arg_33_0.puzzleId == Role37PuzzleEnum.PuzzleId.SnailMove then
		local var_33_1 = 0
		local var_33_2 = 3
		local var_33_3 = 0

		for iter_33_0 = 1, var_33_0 do
			local var_33_4 = arg_33_0.operList[iter_33_0 + var_33_1]

			while var_33_4 == nil do
				var_33_1 = var_33_1 + 1
				var_33_4 = arg_33_0.operList[iter_33_0 + var_33_1]
			end

			local var_33_5 = var_33_4 - var_33_2

			if var_33_5 == 0 then
				if var_33_4 == 3 then
					arg_33_0:_repelaceRecord(luaLang("v1a4_role37_puzzle_snailmove_updown"))
				else
					arg_33_0:_repelaceRecord(luaLang("v1a4_role37_puzzle_snailmove_single"))
				end

				var_33_3 = iter_33_0 + var_33_1

				break
			elseif var_33_5 == 2 then
				arg_33_0:_repelaceRecord(luaLang("v1a4_role37_puzzle_snailmove_down"))

				var_33_3 = iter_33_0 + var_33_1

				break
			elseif var_33_5 == -1 then
				if var_33_4 == 1 then
					arg_33_0:_repelaceRecord(luaLang("v1a4_role37_puzzle_snailmove_single"))
				elseif var_33_4 == 2 then
					arg_33_0:_repelaceRecord(luaLang("v1a4_role37_puzzle_snailmove_up"))
				end

				var_33_3 = iter_33_0 + var_33_1

				break
			else
				var_33_3 = 0
			end

			var_33_2 = var_33_4
		end

		if arg_33_0.curErrorIndex ~= var_33_3 then
			arg_33_0:setCurErrorIndex(var_33_3)
			Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, arg_33_0.curErrorIndex)
		end

		if arg_33_0.remainDis == 0 and arg_33_0.passDay == 6 then
			arg_33_0:Finish(true)

			return
		end
	elseif arg_33_0.puzzleId == Role37PuzzleEnum.PuzzleId.SortByRules5 then
		local var_33_6 = {}
		local var_33_7 = 0

		for iter_33_1, iter_33_2 in pairs(arg_33_0.operList) do
			if var_33_6[iter_33_2] then
				arg_33_0:_repelaceRecord(luaLang("v1a4_role37_puzzle_sortbyrules_only"))

				var_33_7 = iter_33_1

				break
			else
				var_33_6[iter_33_2] = 1
				var_33_7 = 0
			end
		end

		if arg_33_0.curErrorIndex ~= var_33_7 then
			arg_33_0:setCurErrorIndex(var_33_7)
			Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, arg_33_0.curErrorIndex)
		end

		if var_33_0 == 5 and arg_33_0.curErrorIndex == 0 then
			local var_33_8 = arg_33_0:getSortError5()

			if string.nilorempty(var_33_8) then
				arg_33_0:Finish(true)

				return
			else
				local var_33_9 = string.format(luaLang("v1a4_role37_puzzle_sortbyrules_error"), var_33_8)

				arg_33_0:_directAddRecord(var_33_9, true)
			end
		end
	elseif arg_33_0.puzzleId == Role37PuzzleEnum.PuzzleId.MonkeyBanana then
		if arg_33_0.curPos == 7 then
			if arg_33_0.handleBa >= 3 then
				arg_33_0:Finish(true)

				return
			else
				arg_33_0:setCurErrorIndex(999)
				arg_33_0:_directAddRecord(luaLang("v1a4_role37_puzzle_monkeybanana_not_enough"), true)
			end
		end
	elseif arg_33_0.puzzleId == Role37PuzzleEnum.PuzzleId.SortByRules7 then
		local var_33_10 = {}
		local var_33_11 = 0

		for iter_33_3, iter_33_4 in pairs(arg_33_0.operList) do
			if var_33_10[iter_33_4] then
				arg_33_0:_repelaceRecord(luaLang("v1a4_role37_puzzle_sortbyrules_only"))

				var_33_11 = iter_33_3

				break
			else
				var_33_10[iter_33_4] = 1
				var_33_11 = 0
			end
		end

		if arg_33_0.curErrorIndex ~= var_33_11 then
			arg_33_0:setCurErrorIndex(var_33_11)
			Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, arg_33_0.curErrorIndex)
		end

		if var_33_0 == 7 and arg_33_0.curErrorIndex == 0 then
			local var_33_12 = arg_33_0:getSortError7()

			if string.nilorempty(var_33_12) then
				arg_33_0:Finish(true)

				return
			else
				local var_33_13 = string.format(luaLang("v1a4_role37_puzzle_sortbyrules_error"), var_33_12)

				arg_33_0:_directAddRecord(var_33_13, true)
			end
		end
	elseif arg_33_0.puzzleId == Role37PuzzleEnum.PuzzleId.WolfSheepDish then
		if #arg_33_0.rightBank == 3 then
			if arg_33_0.moveCnt > 5 then
				GameFacade.showToastString(luaLang("v1a4_role37_puzzle_animal_movecnt_notenough"))

				return
			end

			arg_33_0:Finish(true)

			return
		end
	elseif arg_33_0.puzzleId == Role37PuzzleEnum.PuzzleId.Final and var_33_0 == 10 and arg_33_0:matchOperList() then
		arg_33_0:Finish(true)

		return
	end

	if arg_33_0.puzzleCfg.puzzleType == Role37PuzzleEnum.PuzzleType.Logic and arg_33_0:isOperateFull() then
		arg_33_0:Finish(false)

		return
	end
end

function var_0_0.matchOperList(arg_34_0)
	local var_34_0 = true

	for iter_34_0, iter_34_1 in ipairs(arg_34_0.matchList) do
		if arg_34_0.operList[iter_34_0] ~= iter_34_1 then
			var_34_0 = false

			break
		end
	end

	return var_34_0
end

function var_0_0.Finish(arg_35_0, arg_35_1)
	arg_35_0.isSucess = arg_35_1

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.PuzzleResult, arg_35_1)
end

function var_0_0.isOperateFull(arg_36_0)
	return tabletool.len(arg_36_0.operList) >= arg_36_0.maxStep
end

function var_0_0.getResult(arg_37_0)
	return arg_37_0.isSucess
end

function var_0_0.getPuzzleCfg(arg_38_0)
	return arg_38_0.puzzleCfg
end

function var_0_0.getOperGroupCfg(arg_39_0)
	return arg_39_0.operGroupCfg
end

function var_0_0.getOperGroupList(arg_40_0)
	return arg_40_0.operGroupList
end

function var_0_0.getShapeImage(arg_41_0, arg_41_1)
	return arg_41_0.operGroupCfg[arg_41_1].shapeImg
end

function var_0_0.getMaxOper(arg_42_0)
	return arg_42_0.maxOper
end

function var_0_0.setCurErrorIndex(arg_43_0, arg_43_1)
	arg_43_0.curErrorIndex = arg_43_1

	if arg_43_1 ~= 0 then
		arg_43_0.errorCnt = arg_43_0.errorCnt + 1
	end
end

function var_0_0.getCurErrorIndex(arg_44_0)
	return arg_44_0.curErrorIndex
end

function var_0_0.setErrorCnt(arg_45_0, arg_45_1)
	arg_45_0.errorCnt = arg_45_1
end

function var_0_0.getErrorCnt(arg_46_0)
	return arg_46_0.errorCnt
end

function var_0_0.getOperAudioId(arg_47_0, arg_47_1)
	return arg_47_0.operGroupCfg[arg_47_1].audioId
end

var_0_0.instance = var_0_0.New()

return var_0_0
