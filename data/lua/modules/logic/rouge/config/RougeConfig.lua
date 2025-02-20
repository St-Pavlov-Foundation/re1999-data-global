module("modules.logic.rouge.config.RougeConfig", package.seeall)

slot0 = class("RougeConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"rouge_season",
		"rouge_const",
		"rouge_outside_const",
		"rouge_difficulty",
		"rouge_result",
		"rouge_badge",
		"rouge_ending",
		"rouge_last_reward",
		"rouge_style",
		"rouge_style_talent",
		"rouge_level",
		"rouge_active_skill",
		"rouge_map_skill",
		"rogue_collection_backpack",
		"rouge_genius_branch"
	}
end

function slot1(slot0)
	return lua_rouge_season.configDict[slot0]
end

function slot0._openList(slot0)
	slot2 = {
		0
	}

	for slot6, slot7 in ipairs(lua_rouge_season.configList) do
		table.insert(slot2, slot7.id)
	end

	return slot2
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "rouge_season" then
		slot0._openDict = {}

		slot0:_getOrCreateOpenDict()
	elseif slot1 == "rouge_difficulty" then
		slot0._difficultyDlcDict = {}
		slot0._difficultBaseDict = {}
		slot0._difficultyStartViewInfoDict = {}

		slot0:_getOrCreateDifficultyDict()
	elseif slot1 == "rouge_style" then
		slot0._styleBaseDict = {}
		slot0._styleDlcDict = {}

		slot0:_getOrCreateRougeStyleDict()
	elseif slot1 == "rouge_const" then
		slot0:_initConst()
	elseif slot1 == "rouge_genius_branch" then
		slot0._geniusBranchStartViewInfoDict = {}
		slot0._geniusBranchIdListWithStartView = {}
	end
end

function slot0._initConst(slot0)
	slot0._roleCapacity = slot0:_initRoleCapacity(RougeEnum.Const.RoleCapacity)
	slot0._roleHalfCapacity = slot0:_initRoleCapacity(RougeEnum.Const.RoleHalfCapacity)
end

function slot0._initRoleCapacity(slot0, slot1)
	slot8 = "#"

	for slot8, slot9 in ipairs(GameUtil.splitString2(slot0:getConstValueByID(slot1), true, "|", slot8)) do
		-- Nothing
	end

	return {
		[slot9[1]] = slot9[2]
	}
end

function slot0.getRoleCapacity(slot0, slot1)
	return slot0._roleCapacity[slot1] or 1
end

function slot0.getRoleHalfCapacity(slot0, slot1)
	return slot0._roleHalfCapacity[slot1] or 1
end

function slot0.getSeasonAndVersion(slot0, slot1)
	slot2 = uv0(slot1)

	return slot2.season, slot2.version
end

function slot0.getConstValueByID(slot0, slot1)
	return lua_rouge_const.configDict[slot1].value
end

function slot0.getConstNumValue(slot0, slot1)
	return tonumber(slot0:getConstValueByID(slot1))
end

function slot0.getOutSideConstValueByID(slot0, slot1)
	return lua_rouge_outside_const.configList[slot1].value
end

function slot0._getOrCreateDifficultyDict(slot0)
	if slot0._difficultBaseDict[slot0:season()] then
		return slot0._difficultBaseDict[slot1], slot0._difficultyDlcDict[slot1]
	end

	slot0._difficultyDlcDict[slot1] = {}
	slot0._difficultBaseDict[slot1] = {}

	if lua_rouge_difficulty.configDict[slot1] then
		for slot7, slot8 in pairs(lua_rouge_difficulty.configDict[slot1]) do
			if string.nilorempty(slot8.version) then
				table.insert(slot3, slot8)
			else
				for slot13, slot14 in ipairs(RougeDLCHelper.versionStrToList(slot8.version)) do
					slot2[slot14] = slot2[slot14] or {}

					if slot0:isRougeSeasonIdOpen(slot14) then
						table.insert(slot2[slot14], slot8)
					end
				end
			end
		end
	end

	for slot7, slot8 in pairs(slot2) do
		table.sort(slot8, function (slot0, slot1)
			if slot0.difficulty ~= slot1.difficulty then
				return slot0.difficulty < slot1.difficulty
			end

			return false
		end)
	end

	return slot3, slot2
end

function slot0._getOrCreateOpenDict(slot0)
	if slot0._openDict[slot0:season()] then
		return slot0._openDict[slot1]
	end

	slot0._openDict[slot1] = {}

	for slot7, slot8 in ipairs(slot0:_openList()) do
		slot2[slot8] = true
	end

	return slot2
end

function slot0._getOrCreateRougeStyleDict(slot0)
	if slot0._styleBaseDict[slot0:season()] then
		return slot0._styleBaseDict[slot1], slot0._styleDlcDict[slot1]
	end

	slot0._styleBaseDict[slot1] = {}
	slot0._styleDlcDict[slot1] = {}

	if lua_rouge_style.configDict[slot1] then
		for slot7, slot8 in pairs(lua_rouge_style.configDict[slot1]) do
			if string.nilorempty(slot8.version) then
				table.insert(slot3, slot8)
			else
				for slot13, slot14 in ipairs(RougeDLCHelper.versionStrToList(slot8.version)) do
					slot2[slot14] = slot2[slot14] or {}

					if slot0:isRougeSeasonIdOpen(slot14) then
						table.insert(slot2[slot14], slot8)
					end
				end
			end
		end
	end

	for slot7, slot8 in pairs(slot2) do
		table.sort(slot8, function (slot0, slot1)
			return slot0.id < slot1.id
		end)
	end

	return slot3, slot2
end

function slot0.isRougeSeasonIdOpen(slot0, slot1)
	return slot0:_getOrCreateOpenDict()[slot1] and true or false
end

function slot0.getDifficultyCOList(slot0, slot1, slot2)
	if not slot2 or #slot2 <= 0 then
		return
	end

	slot3 = {}

	for slot7, slot8 in ipairs(slot2) do
		slot9, slot10 = slot0:_getOrCreateDifficultyDict()

		if slot10 and slot10[slot8] then
			for slot15, slot16 in ipairs(slot11) do
				if RougeDLCHelper.isCurrentUsingContent(slot16.version) and not slot3[slot16.difficulty] then
					table.insert(slot1, slot16)

					slot3[slot16.difficulty] = true
				end
			end
		end
	end
end

function slot0.getStylesCOList(slot0, slot1, slot2)
	if not slot2 or #slot2 <= 0 then
		return
	end

	slot3, slot4 = slot0:_getOrCreateRougeStyleDict()
	slot5 = {}

	for slot9, slot10 in ipairs(slot2) do
		if slot4 and slot4[slot10] then
			for slot15, slot16 in ipairs(slot11) do
				if RougeDLCHelper.isCurrentUsingContent(slot16.version) and not slot5[slot16.id] then
					table.insert(slot1, slot16)

					slot5[slot16.id] = true
				end
			end
		end
	end
end

function slot0.getStyleConfig(slot0, slot1)
	return lua_rouge_style.configDict[slot0:season()][slot1]
end

function slot0.getSeasonStyleConfigs(slot0)
	return lua_rouge_style.configDict[slot0:season()]
end

function slot0.getCollectionBackpackCO(slot0, slot1)
	return lua_rogue_collection_backpack.configDict[slot0:getStyleConfig(slot1).layoutId]
end

function slot0.getDifficultyCO(slot0, slot1)
	return lua_rouge_difficulty.configDict[slot0:season()][slot1]
end

function slot0.getDifficultyCOStartViewInfo(slot0, slot1)
	if not slot1 then
		return {}
	end

	if slot0._difficultyStartViewInfoDict[slot0:season()] and slot3[slot1] then
		return slot3[slot1]
	end

	slot0._difficultyStartViewInfoDict[slot2] = slot0._difficultyStartViewInfoDict[slot2] or {}
	slot0._difficultyStartViewInfoDict[slot2][slot1] = {}

	if not GameUtil.splitString2(slot0:getDifficultyCO(slot1).startView, false, "|", "#") then
		return slot4
	end

	for slot11, slot12 in ipairs(slot7) do
		slot13 = slot12[1]

		assert(RougeEnum.StartViewEnum[slot13], "unsupported error excel:R肉鸽表.xlsx export_难度表.sheet difficulty=" .. slot1 .. " 列'startView'=" .. slot6 .. " 配了代码未支持的类型:" .. slot13)

		slot4[slot13] = (slot4[slot13] or 0) + (tonumber(slot12[2]) or 0)
	end

	return slot4
end

function slot0.getDifficultyCOStartViewDeltaValue(slot0, slot1, slot2)
	return slot0:getDifficultyCOStartViewInfo(slot1)[slot2] or 0
end

function slot0.getDifficultyCOTitle(slot0, slot1)
	return slot0:getDifficultyCO(slot1).title
end

function slot0.getActiveSkillCO(slot0, slot1)
	if not lua_rouge_active_skill.configDict[slot1] then
		logError("缺少肉鸽激活技能配置, 技能id :" .. tostring(slot1))
	end

	return slot2
end

function slot0.getMapSkillCo(slot0, slot1)
	if not lua_rouge_map_skill.configDict[slot1] then
		logError("缺少肉鸽地图技能配置, 地图技能id :" .. tostring(slot1))
	end

	return slot2
end

function slot0.getRougeBadgeCO(slot0, slot1, slot2)
	return lua_rouge_badge.configDict[slot1][slot2]
end

function slot0.getEndingCO(slot0, slot1)
	if not lua_rouge_ending.configDict[slot1] then
		logError("rouge end config not exist, endId : " .. tostring(slot1))

		return
	end

	return slot2
end

function slot0.getLastRewardCO(slot0, slot1)
	return lua_rouge_last_reward.configDict[slot0:season()][slot1]
end

function slot0.getStyleLockDesc(slot0, slot1)
	if not slot0:getStyleConfig(slot1).unlockType or slot3 == 0 then
		return ""
	end

	return RougeMapUnlockHelper.getLockTips(slot3, slot2.unlockParam)
end

function slot0.getAbortCDDuration(slot0)
	return math.max(0, slot0:getConstNumValue(44) or 0)
end

function slot0.getDifficultyCOListByVersions(slot0, slot1)
	slot2 = {}

	tabletool.addValues(slot2, slot0:_getOrCreateDifficultyDict())
	slot0:getDifficultyCOList(slot2, slot1)
	table.sort(slot2, function (slot0, slot1)
		if slot0.difficulty ~= slot1.difficulty then
			return slot0.difficulty < slot1.difficulty
		end

		if slot0.version ~= slot1.version then
			return slot0.version < slot1.version
		end

		return false
	end)

	return slot2
end

function slot0.getStyleCOListByVersions(slot0, slot1)
	slot2 = {}

	tabletool.addValues(slot2, slot0:_getOrCreateRougeStyleDict())
	slot0:getStylesCOList(slot2, slot1)
	table.sort(slot2, function (slot0, slot1)
		return slot0.id < slot1.id
	end)

	return slot2
end

function slot0.getGeniusBranchCO(slot0, slot1)
	return lua_rouge_genius_branch.configDict[slot0:season()][slot1]
end

function slot0.getGeniusBranchStartViewInfo(slot0, slot1)
	if not slot1 then
		return {}
	end

	if slot0._geniusBranchStartViewInfoDict[slot0:season()] and slot3[slot1] then
		return slot3[slot1]
	end

	slot0._geniusBranchStartViewInfoDict[slot2] = slot0._geniusBranchStartViewInfoDict[slot2] or {}
	slot0._geniusBranchStartViewInfoDict[slot2][slot1] = {}

	if not GameUtil.splitString2(slot0:getGeniusBranchCO(slot1).startView, false, "|", "#") then
		return slot4
	end

	for slot11, slot12 in ipairs(slot7) do
		slot13 = slot12[1]

		assert(RougeEnum.StartViewEnum[slot13], "unsupported error R肉鸽局外表.xlsx export_天赋分支表.sheet id=" .. slot1 .. " 列'startView'=" .. slot6 .. " 配了代码未支持的类型:" .. slot13)

		slot4[slot13] = (slot4[slot13] or 0) + (tonumber(slot12[2]) or 0)
	end

	return slot4
end

function slot0.getGeniusBranchStartViewDeltaValue(slot0, slot1, slot2)
	return slot0:getGeniusBranchStartViewInfo(slot1)[slot2] or 0
end

function slot0.getGeniusBranchIdListWithStartView(slot0)
	if slot0._geniusBranchIdListWithStartView[slot0:season()] then
		return slot2
	end

	slot0._geniusBranchIdListWithStartView[slot1] = {}

	for slot8, slot9 in pairs(lua_rouge_genius_branch.configDict[slot1]) do
		if not string.nilorempty(slot9.startView) then
			table.insert(slot3, slot9.id)
		end
	end

	return slot3
end

function slot0.getSkillCo(slot0, slot1, slot2)
	if slot1 == RougeEnum.SkillType.Map then
		return slot0:getMapSkillCo(slot2)
	elseif slot1 == RougeEnum.SkillType.Style then
		return slot0:getActiveSkillCO(slot2)
	else
		logError("未定义的技能类型:" .. tostring(slot1))
	end
end

function slot0.season(slot0)
	assert(false, "please override this function")
end

function slot0.openUnlockId(slot0)
	assert(false, "please override this function")
end

function slot0.achievementJumpId(slot0)
	assert(false, "please override this function")
end

slot0.instance = slot0.New()

return slot0
