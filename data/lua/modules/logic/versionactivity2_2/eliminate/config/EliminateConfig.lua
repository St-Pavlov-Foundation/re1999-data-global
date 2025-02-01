module("modules.logic.versionactivity2_2.eliminate.config.EliminateConfig", package.seeall)

slot0 = class("EliminateConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"eliminate_episode",
		"eliminate_chapter",
		"eliminate_reward",
		"teamchess_character",
		"eliminate_slot",
		"soldier_chess",
		"strong_hold",
		"teamchess_enemy",
		"war_chess_episode",
		"character_skill",
		"soldier_skill",
		"eliminate_cost",
		"strong_hold_rule",
		"eliminate_dialog"
	}
end

function slot0.onInit(slot0)
	slot0:_initEliminateChessConfig()
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "eliminate_chapter" then
		slot0:_initChapter()
	elseif slot1 == "soldier_chess" then
		slot0:_initSoldierChess()
	elseif slot1 == "eliminate_cost" then
		slot0:_initEvaluateGear()
		slot0:_initCharacterDamageGear()
	end
end

function slot0._initSoldierChess(slot0)
	slot0._soldierChessList = {}
	slot0._soldierChessShowList = {}
	slot0._soldierChessShowMap = {}

	for slot4, slot5 in ipairs(lua_soldier_chess.configList) do
		slot6 = 0

		if GameUtil.splitString2(slot5.cost, false, "#", "_") then
			for slot11, slot12 in ipairs(slot7) do
				if tonumber(slot12[2]) then
					slot6 = slot6 + slot13
				else
					logError("eliminate_cost error:" .. tostring(slot5.id) .. " cost:" .. tostring(slot5.cost))
				end
			end
		end

		table.insert(slot0._soldierChessList, {
			id = slot5.id,
			config = slot5,
			costList = slot7,
			costValue = slot6
		})

		if slot5.formationDisplays == 1 then
			table.insert(slot0._soldierChessShowList, slot8)

			slot0._soldierChessShowMap[slot5.id] = slot8
		end
	end
end

function slot0.getSoldierChessList(slot0)
	return slot0._soldierChessShowList
end

function slot0.getSoldierChessById(slot0, slot1)
	return slot0._soldierChessShowMap[slot1]
end

function slot0.getSoldierChessConfig(slot0, slot1)
	return lua_soldier_chess.configDict[slot1]
end

function slot0.getSoldierSkillConfig(slot0, slot1)
	return lua_soldier_skill.configDict[slot1]
end

function slot0.getSoldierChessQualityImageName(slot0, slot1)
	return EliminateTeamChessEnum.SoliderChessQualityImage[slot1] or EliminateTeamChessEnum.SoliderChessQualityImage[1]
end

function slot0.getSoldierChessDesc(slot0, slot1)
	for slot8, slot9 in ipairs(string.splitToNumber(slot0:getSoldierChessConfig(slot1).skillId, "#")) do
		if lua_soldier_skill.configDict[slot9] then
			slot4 = "" .. slot10.skillDes .. "\n"
		end
	end

	return slot4
end

function slot0.getUnLockMainCharacterSkillConst(slot0)
	return slot0:getConstValue(4)
end

function slot0.getUnLockChessSellConst(slot0)
	return slot0:getConstValue(5)
end

function slot0.getUnLockSelectSoliderConst(slot0)
	return slot0:getConstValue(6)
end

function slot0.getSellSoliderPermillage(slot0)
	return lua_eliminate_cost.configDict[12] and tonumber(slot1.value) or 1
end

function slot0.getConstValue(slot0, slot1)
	return lua_eliminate_cost.configDict[slot1] and tonumber(slot2.value) or 0
end

function slot0.getSoldierChessConfigConst(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._soldierChessList) do
		if slot6.config and slot7.id == slot1 then
			return slot6.costList, slot6.costValue
		end
	end

	return nil
end

function slot0.getTeamChessCharacterConfig(slot0, slot1)
	return lua_teamchess_character.configDict[slot1]
end

function slot0.getTeamChessEnemyConfig(slot0, slot1)
	return lua_teamchess_enemy.configDict[slot1]
end

function slot0.getStrongHoldConfig(slot0, slot1)
	return lua_strong_hold.configDict[slot1]
end

function slot0.getSoldierChessModelPath(slot0, slot1)
	return slot0:getSoldierChessConfig(slot1) and slot2.resModel or ""
end

function slot0._initChapter(slot0)
	slot0._normalChapterList = {}

	for slot4, slot5 in ipairs(lua_eliminate_chapter.configList) do
		table.insert(slot0._normalChapterList, slot5)
	end
end

function slot0._initEliminateChessConfig(slot0)
	slot0._chessBoardConfig = {}
	slot0._chessConfig = {}

	for slot4 = 1, #T_lua_eliminate_chessBoard do
		slot5 = T_lua_eliminate_chessBoard[slot4]
		slot0._chessBoardConfig[slot5.type] = slot5
	end

	for slot4 = 1, #T_lua_eliminate_chess do
		slot5 = T_lua_eliminate_chess[slot4]
		slot0._chessConfig[slot5.id] = slot5
	end
end

function slot0.getChessIconPath(slot0, slot1)
	return slot0._chessConfig[slot1] and slot0._chessConfig[slot1].iconPath or ""
end

function slot0.getChessSourceID(slot0, slot1)
	return slot0._chessConfig[slot1] and slot0._chessConfig[slot1].colorId or ""
end

function slot0.getChessBoardIconPath(slot0, slot1)
	return slot0._chessBoardConfig[slot1] and slot0._chessBoardConfig[slot1].iconPath or ""
end

function slot0.getNormalChapterList(slot0)
	return slot0._normalChapterList
end

function slot0.getEliminateEpisodeConfig(slot0, slot1)
	return lua_eliminate_episode.configDict[slot1]
end

function slot0.getWarChessEpisodeConfig(slot0, slot1)
	return lua_war_chess_episode.configDict[slot1]
end

function slot0.getMainCharacterSkillConfig(slot0, slot1)
	if slot1 then
		return lua_character_skill.configDict[string.splitToNumber(slot1, "#")[1]]
	end

	return nil
end

function slot0.getStrongHoldRuleRuleConfig(slot0, slot1)
	return lua_strong_hold_rule.configDict[slot1]
end

function slot0.getEliminateDialogConfig(slot0, slot1)
	if lua_eliminate_dialog.configDict[slot1] == nil then
		slot2 = {}
	end

	if lua_eliminate_dialog.configDict[999999] ~= nil then
		tabletool.addValues(slot2, slot3)
	end

	return slot2
end

function slot0._initEvaluateGear(slot0)
	slot0._evaluateGear = string.splitToNumber(lua_eliminate_cost.configDict[36].value, "#")
end

function slot0.getEvaluateGear(slot0)
	return slot0._evaluateGear
end

function slot0._initCharacterDamageGear(slot0)
	slot0._characterDamageGear = string.splitToNumber(lua_eliminate_cost.configDict[38].value, "#")
end

function slot0.getCharacterDamageGear(slot0)
	return slot0._characterDamageGear
end

function slot0.getSoliderSkillConfig(slot0, slot1)
	return lua_soldier_skill.configDict[slot1] or {}
end

slot0.instance = slot0.New()

return slot0
