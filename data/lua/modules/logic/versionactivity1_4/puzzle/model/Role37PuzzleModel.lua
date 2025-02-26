module("modules.logic.versionactivity1_4.puzzle.model.Role37PuzzleModel", package.seeall)

slot0 = class("Role37PuzzleModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.clear(slot0)
	slot0.puzzleCfg = nil
	slot0.maxStep = nil
	slot0.maxOper = nil
	slot0.operGroupId = nil
	slot0.operGroupCfg = nil
	slot0.operGroupList = nil
	slot0.matchList = nil
	slot0.operList = nil
	slot0.recordList = nil
	slot0.controllRecords = nil
	slot0.isSucess = nil
end

function slot0.setPuzzleId(slot0, slot1)
	slot0.puzzleId = slot1

	slot0:initCfg()
	slot0:initParam()
end

function slot0.initCfg(slot0)
	slot0.puzzleCfg = Activity130Config.instance:getActivity130DecryptCo(Activity130Enum.ActivityId.Act130, slot0.puzzleId)
	slot0.maxStep = slot0.puzzleCfg.maxStep
	slot0.maxOper = slot0.puzzleCfg.maxOper
	slot0.operGroupId = slot0.puzzleCfg.operGroupId
	slot0.operGroupCfg = Activity130Config.instance:getOperGroup(Activity130Enum.ActivityId.Act130, slot0.operGroupId)
	slot0.operGroupList = {}

	for slot5, slot6 in pairs(Activity130Config.instance:getOperGroup(Activity130Enum.ActivityId.Act130, slot0.operGroupId)) do
		table.insert(slot0.operGroupList, slot6)
	end

	table.sort(slot0.operGroupList, function (slot0, slot1)
		return slot0.operType < slot1.operType
	end)

	slot0.matchList = string.splitToNumber(slot0.puzzleCfg.answer, "|")
end

function slot0.initParam(slot0)
	slot0.operList = {}
	slot0.recordList = {}

	PuzzleRecordListModel.instance:clearRecord()

	slot0.controllRecords = {}

	slot0:initVariable()
	slot0:setCurErrorIndex(0)

	slot0.isSucess = false
end

function slot0.initVariable(slot0)
	slot0.maxDis = 8
	slot0.remainDis = slot0.maxDis
	slot0.passDay = 1
	slot0.handleBa = 0
	slot0.maxHandle = 6
	slot0.curPos = 1
	slot0.maxPos = 7
	slot0.routeBaList = {
		12,
		0,
		0,
		0,
		0,
		0,
		0
	}
	slot0.leftBank = {
		1,
		2,
		3
	}
	slot0.rightBank = {}
	slot0.boat = {}
	slot0.curBank = slot0.leftBank
	slot0.moveCnt = 0
end

function slot0._addRecord(slot0, slot1, slot2)
	table.insert(slot0.recordList, slot0:getResultDesc(slot1, slot2))
end

function slot0._directAddRecord(slot0, slot1, slot2)
	table.insert(slot0.recordList, slot1)

	if slot2 or false then
		slot0:_updateRecord()
	end
end

function slot0._repelaceRecord(slot0, slot1)
	slot0.recordList[#slot0.recordList] = slot1

	slot0:_updateRecord()
end

function slot0._updateRecord(slot0)
	PuzzleRecordListModel.instance:setRecordList(slot0.recordList)
end

function slot0.getRecordMo(slot0, slot1)
	slot2 = PuzzleRecordMO.New()
	slot3 = slot0.recordList[slot1]

	if slot1 < 10 then
		slot1 = "0" .. slot1
	end

	slot2:init(slot1, slot3)

	return slot2
end

function slot0.addOption(slot0, slot1, slot2, slot3)
	if slot0.curErrorIndex ~= 0 and not slot3 then
		if slot0.curErrorIndex == 999 then
			GameFacade.showToastString(luaLang("v1a4_role37_puzzle_monkeybanana_not_enough"))
		else
			GameFacade.showToastString(luaLang("v1a4_role37_puzzle_error_tip"))
		end

		return
	end

	if slot0.operList[slot2] then
		slot0:repleaceOption(slot1, slot2)

		return
	end

	if slot0.maxOper <= tabletool.len(slot0.operList) then
		GameFacade.showToastString(luaLang("v1a4_role37_puzzle_oper_full"))

		return
	end

	slot0.operList[slot2] = slot1

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.AddOption, slot2)
	slot0:recalculate()

	if not slot3 then
		table.insert(slot0.controllRecords, {
			Role37PuzzleEnum.ControlType.Add,
			slot2
		})
	end

	slot0:checkReply()
end

function slot0.exchangeOption(slot0, slot1, slot2, slot3)
	if not slot0.operList[slot2] then
		slot0:moveOption(slot1, slot2)

		return
	end

	slot0.operList[slot1] = slot0.operList[slot2]
	slot0.operList[slot2] = slot0.operList[slot1]

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ExchangeOption, slot1, slot2)
	slot0:recalculate()

	if not slot3 then
		table.insert(slot0.controllRecords, {
			Role37PuzzleEnum.ControlType.Exchange,
			slot2,
			slot1
		})
	end

	slot0:checkReply()
end

function slot0.removeOption(slot0, slot1, slot2)
	slot0.operList[slot1] = nil

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.RemoveOption, slot1)
	slot0:recalculate()

	if not slot2 then
		table.insert(slot0.controllRecords, {
			Role37PuzzleEnum.ControlType.Remove,
			slot0.operList[slot1],
			slot1
		})
	end

	slot0:checkReply()
end

function slot0.repleaceOption(slot0, slot1, slot2, slot3)
	slot0.operList[slot2] = slot1

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.RepleaceOption, slot1, slot2)
	slot0:recalculate()

	if not slot3 then
		table.insert(slot0.controllRecords, {
			Role37PuzzleEnum.ControlType.Repleace,
			slot0.operList[slot2],
			slot2
		})
	end

	slot0:checkReply()
end

function slot0.moveOption(slot0, slot1, slot2, slot3)
	slot0.operList[slot2] = slot0.operList[slot1]
	slot0.operList[slot1] = nil

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.MoveOption, slot1, slot2)
	slot0:recalculate()

	if not slot3 then
		table.insert(slot0.controllRecords, {
			Role37PuzzleEnum.ControlType.Move,
			slot2,
			slot1
		})
	end

	slot0:checkReply()
end

function slot0.rollBack(slot0)
	if #slot0.controllRecords == 0 then
		return
	end

	slot0.controllRecords[#slot0.controllRecords] = nil

	if slot0.controllRecords[#slot0.controllRecords][1] == Role37PuzzleEnum.ControlType.Add then
		slot0:removeOption(slot1[2], true)
	elseif slot2 == Role37PuzzleEnum.ControlType.Exchange then
		slot0:exchangeOption(slot1[2], slot1[3], true)
	elseif slot2 == Role37PuzzleEnum.ControlType.Remove then
		slot0:addOption(slot1[2], slot1[3], true)
	elseif slot2 == Role37PuzzleEnum.ControlType.Repleace then
		slot0:repleaceOption(slot1[2], slot1[3], true)
	elseif slot2 == Role37PuzzleEnum.ControlType.Move then
		slot0:moveOption(slot1[2], slot1[3], true)
	end
end

function slot0.reset(slot0)
	slot0:initParam()
	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.Reset)
end

function slot0.recalculate(slot0)
	slot0:initVariable()

	slot0.recordList = {}

	if tabletool.len(slot0.operList) == 0 then
		if slot0.curErrorIndex ~= 0 then
			slot0:setCurErrorIndex(0)
			Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, slot0.curErrorIndex)
		end
	else
		slot2 = 0

		for slot6 = 1, slot1 do
			while slot0.operList[slot6 + slot2] == nil do
				slot7 = slot0.operList[slot6 + slot2 + 1]
			end

			if slot0:RunLogic(slot7, slot2 + slot6) then
				slot0:_addRecord(slot7, slot2 + slot6)
			else
				break
			end
		end
	end

	slot0:_updateRecord()
end

function slot0.getOperList(slot0)
	return slot0.operList
end

function slot0.getFirstGapIndex(slot0)
	for slot5 = 1, tabletool.len(slot0.operList) do
		if not slot0.operList[slot5] then
			return slot5
		end
	end

	return slot1 + 1
end

function slot0.RunLogic(slot0, slot1, slot2)
	if slot0.puzzleId == Role37PuzzleEnum.PuzzleId.SnailMove then
		slot0:_snailMove(slot1, slot2)

		return true
	elseif slot0.puzzleId == Role37PuzzleEnum.PuzzleId.MonkeyBanana then
		return slot0:_monkeyBanana(slot1, slot2)
	elseif slot0.puzzleId == Role37PuzzleEnum.PuzzleId.WolfSheepDish then
		return slot0:_wolfSheepDish(slot1, slot2)
	else
		return true
	end
end

function slot0._snailMove(slot0, slot1)
	if slot1 == Role37PuzzleEnum.OperType.One then
		slot0.remainDis = slot0.remainDis - 3

		if slot0.remainDis < 0 then
			slot0.remainDis = 0
		end
	elseif slot1 == Role37PuzzleEnum.OperType.Two then
		slot0.remainDis = slot0.remainDis + 2

		if slot0.maxDis < slot0.remainDis then
			slot0.remainDis = slot0.maxDis
		end
	elseif slot1 == Role37PuzzleEnum.OperType.Three then
		slot0.passDay = slot0.passDay + 1
	end
end

function slot0._monkeyBanana(slot0, slot1, slot2)
	slot3 = 0

	if slot1 == Role37PuzzleEnum.OperType.One then
		if slot0.routeBaList[slot0.curPos] - (slot0.maxHandle - slot0.handleBa) < 0 then
			slot0.handleBa = slot0.handleBa + slot0.routeBaList[slot0.curPos]
			slot0.routeBaList[slot0.curPos] = 0
		else
			slot0.handleBa = slot0.maxHandle
			slot0.routeBaList[slot0.curPos] = slot5
		end
	elseif slot1 == Role37PuzzleEnum.OperType.Two then
		if slot0.curPos + 3 <= slot0.maxPos then
			slot0.curPos = slot0.curPos + 3

			if slot0.handleBa - 3 >= 0 then
				slot0.handleBa = slot4
			else
				slot0.handleBa = 0
			end
		else
			slot3 = slot2

			slot0:_directAddRecord(luaLang("v1a4_role37_puzzle_monkeybanana_arrive_destination"))
		end
	elseif slot1 == Role37PuzzleEnum.OperType.Four then
		slot0.curPos = 1
		slot0.handleBa = slot0.handleBa - (slot0.curPos - 1)

		if slot0.handleBa < 0 then
			slot0.handleBa = 0
		end
	elseif slot1 == Role37PuzzleEnum.OperType.Five then
		slot0.routeBaList[slot0.curPos] = slot0.routeBaList[slot0.curPos] + slot0.handleBa
		slot0.handleBa = 0
	end

	if slot0.curErrorIndex ~= slot3 then
		slot0:setCurErrorIndex(slot3)
		Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, slot0.curErrorIndex)
	end

	return slot0.curErrorIndex == 0
end

function slot0._wolfSheepDish(slot0, slot1, slot2)
	slot3 = 0

	if slot1 == Role37PuzzleEnum.OperType.One or slot1 == Role37PuzzleEnum.OperType.Two or slot1 == Role37PuzzleEnum.OperType.Three then
		if tabletool.indexOf(slot0.curBank, Role37PuzzleEnum.AnimalRules[slot1]) and #slot0.boat == 0 then
			table.remove(slot0.curBank, slot4)

			slot0.boat[1] = Role37PuzzleEnum.AnimalRules[slot1]
			slot0.lastPick = slot0.curBank
		else
			slot3 = slot2

			if not slot4 then
				slot0:_directAddRecord(luaLang("v1a4_role37_puzzle_animal_pick_fault"))
			else
				slot0:_directAddRecord(luaLang("v1a4_role37_puzzle_animal_boat_full"), false)
			end
		end
	elseif slot1 == Role37PuzzleEnum.OperType.Four then
		slot0.curBank = slot0.leftBank

		if #slot0.rightBank == 2 and math.abs(slot0.rightBank[2] - slot0.rightBank[1]) == 1 then
			slot3 = slot2

			slot0:_directAddRecord(luaLang("v1a4_role37_puzzle_animal_eat"), false)
		end
	elseif slot1 == Role37PuzzleEnum.OperType.Five then
		slot0.curBank = slot0.rightBank

		if #slot0.leftBank == 2 and math.abs(slot0.leftBank[2] - slot0.leftBank[1]) == 1 then
			slot3 = slot2

			slot0:_directAddRecord(luaLang("v1a4_role37_puzzle_animal_eat"), false)
		end
	elseif slot1 == Role37PuzzleEnum.OperType.Six and slot0.boat[1] then
		table.insert(slot0.curBank, slot0.boat[1])

		slot0.boat[1] = nil

		if slot0.lastPick and slot0.lastPick ~= slot0.curBank then
			slot0.lastPick = nil
			slot0.moveCnt = slot0.moveCnt + 1
		end
	end

	if slot0.curErrorIndex ~= slot3 then
		slot0:setCurErrorIndex(slot3)
		Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, slot0.curErrorIndex)
	end

	return slot0.curErrorIndex == 0
end

function slot0.getBankDesc(slot0, slot1)
	slot2 = ""

	for slot6, slot7 in ipairs(slot1) do
		slot8 = luaLang(Role37PuzzleEnum.AnimalStr[slot7])

		if slot2 ~= "" then
			slot2 = slot2 .. " "
		end

		slot2 = slot2 .. slot8
	end

	if slot1 == slot0.leftBank then
		if not string.nilorempty(slot2) then
			slot2 = formatLuaLang("v1a4_role37_puzzle_leftbank_leave", slot2) .. slot0:getSentenceSep()
		end
	elseif slot1 == slot0.rightBank then
		if not string.nilorempty(slot2) then
			slot2 = formatLuaLang("v1a4_role37_puzzle_rightbank_leave", slot2) .. slot3
		end
	elseif not string.nilorempty(slot2) then
		slot2 = formatLuaLang("v1a4_role37_puzzle_boat_leave", slot2) .. slot3
	end

	return slot2
end

function slot0.getSentenceSep(slot0)
	if LangSettings.instance:isJp() then
		return " "
	elseif LangSettings.instance:isEn() or LangSettings.instance:isKr() then
		return ""
	else
		return ","
	end
end

function slot0.getSortError5(slot0)
	slot4 = tabletool.indexOf(slot0.operList, 2)
	slot5 = tabletool.indexOf(slot0.operList, 4)
	slot6 = tabletool.indexOf(slot0.operList, 5)
	slot7 = tabletool.indexOf(slot0.operList, 6)

	if tabletool.indexOf(slot0.operList, 1) ~= 5 then
		slot2 = "" .. slot0:getErrorSep() .. slot0.operGroupCfg[1].name
	end

	if slot4 > 3 then
		slot2 = slot2 .. slot1 .. slot0.operGroupCfg[2].name
	end

	if slot5 == 1 or slot5 == 5 or math.abs(slot5 - slot3) == 1 then
		slot2 = slot2 .. slot1 .. slot0.operGroupCfg[4].name
	end

	if not slot0.operList[slot6 - 1] or slot0.operList[slot6 - 1] ~= 2 then
		slot2 = slot2 .. slot1 .. slot0.operGroupCfg[5].name
	end

	if slot7 == 1 or slot7 == 5 then
		slot2 = slot2 .. slot1 .. slot0.operGroupCfg[6].name
	end

	return slot2
end

function slot0.getSortError7(slot0)
	slot5 = tabletool.indexOf(slot0.operList, 3)
	slot6 = tabletool.indexOf(slot0.operList, 4)
	slot7 = tabletool.indexOf(slot0.operList, 5)
	slot8 = tabletool.indexOf(slot0.operList, 6)
	slot9 = tabletool.indexOf(slot0.operList, 7)

	if math.abs(tabletool.indexOf(slot0.operList, 1) - tabletool.indexOf(slot0.operList, 2)) == 1 then
		slot2 = "" .. slot0:getErrorSep() .. slot0.operGroupCfg[1].name
	end

	if math.abs(slot4 - slot3) ~= math.abs(slot5 - slot7) then
		slot2 = slot2 .. slot1 .. slot0.operGroupCfg[2].name
	end

	if math.abs(slot7 - slot5) < 4 then
		slot2 = slot2 .. slot1 .. slot0.operGroupCfg[3].name
	end

	if slot6 == 1 or slot6 > 3 then
		slot2 = slot2 .. slot1 .. slot0.operGroupCfg[4].name
	end

	if math.abs(slot7 - slot5) == 1 then
		slot2 = slot2 .. slot1 .. slot0.operGroupCfg[5].name
	end

	if math.abs(slot8 - slot9) ~= 1 then
		slot2 = slot2 .. slot1 .. slot0.operGroupCfg[6].name
	end

	if slot8 < slot9 then
		slot2 = slot2 .. slot1 .. slot0.operGroupCfg[7].name
	end

	return slot2
end

function slot0.getErrorSep(slot0)
	if LangSettings.instance:isEn() then
		return ", "
	end

	return " "
end

function slot0.getResultDesc(slot0, slot1, slot2)
	slot4 = slot0.operGroupCfg[slot1].operDesc .. slot0:getSentenceSep()

	if slot0.puzzleId == Role37PuzzleEnum.PuzzleId.SnailMove then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_snailmove_result"), {
			slot0.remainDis,
			slot0.passDay
		})
	elseif slot0.puzzleId == Role37PuzzleEnum.PuzzleId.SortByRules5 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_sortbyrules_result"), {
			slot0.operGroupCfg[slot1].name,
			slot2
		})
	elseif slot0.puzzleId == Role37PuzzleEnum.PuzzleId.MonkeyBanana then
		slot5 = nil
		slot7 = slot0.routeBaList[4]
		slot8 = slot0.maxPos - slot0.curPos

		return slot4 .. ((slot0.routeBaList[1] <= 0 or slot7 <= 0 or GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_monkeybanana_result1"), {
			slot8,
			slot0.handleBa,
			slot6,
			slot7
		})) and (slot6 <= 0 or slot7 ~= 0 or GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_monkeybanana_result2"), {
			slot8,
			slot0.handleBa,
			slot6
		})) and (slot6 ~= 0 or slot7 <= 0 or GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_monkeybanana_result3"), {
			slot8,
			slot0.handleBa,
			slot7
		})) and GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_monkeybanana_result4"), {
			slot8,
			slot0.handleBa
		}))
	elseif slot0.puzzleId == Role37PuzzleEnum.PuzzleId.SortByRules7 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_sortbyrules_result"), {
			slot0.operGroupCfg[slot1].name,
			slot2
		})
	elseif slot0.puzzleId == Role37PuzzleEnum.PuzzleId.WolfSheepDish then
		slot5 = nil

		return slot4 .. (slot0.curBank == slot0.leftBank and luaLang("v1a4_role37_puzzle_animal_leftbank") .. slot3 or luaLang("v1a4_role37_puzzle_animal_rightbank") .. slot3) .. slot0:getBankDesc(slot0.leftBank) .. slot0:getBankDesc(slot0.boat) .. slot0:getBankDesc(slot0.rightBank) .. string.format(luaLang("v1a4_role37_puzzle_animal_movecnt"), slot0.moveCnt)
	elseif slot0.puzzleId == Role37PuzzleEnum.PuzzleId.Final then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_sortbyrules_result"), {
			slot0.operGroupCfg[slot1].name,
			slot2
		})
	end

	return ""
end

function slot0.checkReply(slot0)
	slot1 = tabletool.len(slot0.operList)

	if slot0.puzzleId == Role37PuzzleEnum.PuzzleId.SnailMove then
		slot3 = 3
		slot4 = 0

		for slot8 = 1, slot1 do
			while slot0.operList[slot8 + 0] == nil do
				slot9 = slot0.operList[slot8 + slot2 + 1]
			end

			if slot9 - slot3 == 0 then
				if slot9 == 3 then
					slot0:_repelaceRecord(luaLang("v1a4_role37_puzzle_snailmove_updown"))
				else
					slot0:_repelaceRecord(luaLang("v1a4_role37_puzzle_snailmove_single"))
				end

				slot4 = slot8 + slot2

				break
			elseif slot10 == 2 then
				slot0:_repelaceRecord(luaLang("v1a4_role37_puzzle_snailmove_down"))

				slot4 = slot8 + slot2

				break
			elseif slot10 == -1 then
				if slot9 == 1 then
					slot0:_repelaceRecord(luaLang("v1a4_role37_puzzle_snailmove_single"))
				elseif slot9 == 2 then
					slot0:_repelaceRecord(luaLang("v1a4_role37_puzzle_snailmove_up"))
				end

				slot4 = slot8 + slot2

				break
			else
				slot4 = 0
			end

			slot3 = slot9
		end

		if slot0.curErrorIndex ~= slot4 then
			slot0:setCurErrorIndex(slot4)
			Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, slot0.curErrorIndex)
		end

		if slot0.remainDis == 0 and slot0.passDay == 6 then
			slot0:Finish(true)

			return
		end
	elseif slot0.puzzleId == Role37PuzzleEnum.PuzzleId.SortByRules5 then
		slot3 = 0

		for slot7, slot8 in pairs(slot0.operList) do
			if ({})[slot8] then
				slot0:_repelaceRecord(luaLang("v1a4_role37_puzzle_sortbyrules_only"))

				slot3 = slot7

				break
			else
				slot2[slot8] = 1
				slot3 = 0
			end
		end

		if slot0.curErrorIndex ~= slot3 then
			slot0:setCurErrorIndex(slot3)
			Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, slot0.curErrorIndex)
		end

		if slot1 == 5 and slot0.curErrorIndex == 0 then
			if string.nilorempty(slot0:getSortError5()) then
				slot0:Finish(true)

				return
			else
				slot0:_directAddRecord(string.format(luaLang("v1a4_role37_puzzle_sortbyrules_error"), slot4), true)
			end
		end
	elseif slot0.puzzleId == Role37PuzzleEnum.PuzzleId.MonkeyBanana then
		if slot0.curPos == 7 then
			if slot0.handleBa >= 3 then
				slot0:Finish(true)

				return
			else
				slot0:setCurErrorIndex(999)
				slot0:_directAddRecord(luaLang("v1a4_role37_puzzle_monkeybanana_not_enough"), true)
			end
		end
	elseif slot0.puzzleId == Role37PuzzleEnum.PuzzleId.SortByRules7 then
		slot3 = 0

		for slot7, slot8 in pairs(slot0.operList) do
			if ({})[slot8] then
				slot0:_repelaceRecord(luaLang("v1a4_role37_puzzle_sortbyrules_only"))

				slot3 = slot7

				break
			else
				slot2[slot8] = 1
				slot3 = 0
			end
		end

		if slot0.curErrorIndex ~= slot3 then
			slot0:setCurErrorIndex(slot3)
			Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, slot0.curErrorIndex)
		end

		if slot1 == 7 and slot0.curErrorIndex == 0 then
			if string.nilorempty(slot0:getSortError7()) then
				slot0:Finish(true)

				return
			else
				slot0:_directAddRecord(string.format(luaLang("v1a4_role37_puzzle_sortbyrules_error"), slot4), true)
			end
		end
	elseif slot0.puzzleId == Role37PuzzleEnum.PuzzleId.WolfSheepDish then
		if #slot0.rightBank == 3 then
			if slot0.moveCnt > 5 then
				GameFacade.showToastString(luaLang("v1a4_role37_puzzle_animal_movecnt_notenough"))

				return
			end

			slot0:Finish(true)

			return
		end
	elseif slot0.puzzleId == Role37PuzzleEnum.PuzzleId.Final and slot1 == 10 and slot0:matchOperList() then
		slot0:Finish(true)

		return
	end

	if slot0.puzzleCfg.puzzleType == Role37PuzzleEnum.PuzzleType.Logic and slot0:isOperateFull() then
		slot0:Finish(false)

		return
	end
end

function slot0.matchOperList(slot0)
	slot1 = true

	for slot5, slot6 in ipairs(slot0.matchList) do
		if slot0.operList[slot5] ~= slot6 then
			slot1 = false

			break
		end
	end

	return slot1
end

function slot0.Finish(slot0, slot1)
	slot0.isSucess = slot1

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.PuzzleResult, slot1)
end

function slot0.isOperateFull(slot0)
	return slot0.maxStep <= tabletool.len(slot0.operList)
end

function slot0.getResult(slot0)
	return slot0.isSucess
end

function slot0.getPuzzleCfg(slot0)
	return slot0.puzzleCfg
end

function slot0.getOperGroupCfg(slot0)
	return slot0.operGroupCfg
end

function slot0.getOperGroupList(slot0)
	return slot0.operGroupList
end

function slot0.getShapeImage(slot0, slot1)
	return slot0.operGroupCfg[slot1].shapeImg
end

function slot0.getMaxOper(slot0)
	return slot0.maxOper
end

function slot0.setCurErrorIndex(slot0, slot1)
	slot0.curErrorIndex = slot1

	if slot1 ~= 0 then
		slot0.errorCnt = slot0.errorCnt + 1
	end
end

function slot0.getCurErrorIndex(slot0)
	return slot0.curErrorIndex
end

function slot0.setErrorCnt(slot0, slot1)
	slot0.errorCnt = slot1
end

function slot0.getErrorCnt(slot0)
	return slot0.errorCnt
end

function slot0.getOperAudioId(slot0, slot1)
	return slot0.operGroupCfg[slot1].audioId
end

slot0.instance = slot0.New()

return slot0
