module("modules.logic.versionactivity2_3.act174.config.Activity174Config", package.seeall)

slot0 = class("Activity174Config", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"activity174_const",
		"activity174_turn",
		"activity174_shop",
		"activity174_bag",
		"activity174_role",
		"activity174_collection",
		"activity174_enhance",
		"activity174_bet",
		"activity174_season",
		"activity174_badge",
		"activity174_template",
		"activity174_effect"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity174_turn" then
		slot0.turnConfig = slot2
	elseif slot1 == "activity174_shop" then
		slot0.shopConfig = slot2
	elseif slot1 == "activity174_role" then
		slot0.roleConfig = slot2
	elseif slot1 == "activity174_collection" then
		slot0.collectionConfig = slot2
	end
end

function slot0.initUnlockNewTeamTurnData(slot0)
	slot0.unlockNewTeamTurn = {}

	for slot4, slot5 in ipairs(slot0.turnConfig.configList) do
		slot6 = slot5.turn

		if not slot0.unlockNewTeamTurn[slot5.groupNum] or slot6 < slot8 then
			slot0.unlockNewTeamTurn[slot7] = slot6
		end
	end
end

function slot0.isUnlockNewTeamTurn(slot0, slot1)
	slot2 = false

	if not slot0.unlockNewTeamTurn then
		slot0:initUnlockNewTeamTurnData()
	end

	for slot6, slot7 in ipairs(slot0.unlockNewTeamTurn) do
		if slot7 == slot1 then
			slot2 = true

			break
		end
	end

	return slot2
end

function slot0.getTurnCo(slot0, slot1, slot2)
	if not slot0.turnConfig.configDict[slot1][slot2] then
		logError("dont exist turnCo" .. tostring(slot1) .. "#" .. tostring(slot2))
	end

	return slot3
end

function slot0.getMaxRound(slot0, slot1, slot2)
	slot3 = 0

	for slot7, slot8 in ipairs(slot0.turnConfig.configDict[slot1]) do
		if slot8.endless == 1 then
			slot3 = slot8.turn
		end
	end

	if slot3 < slot2 then
		return #slot0.turnConfig.configDict[slot1], true
	end

	return slot3, false
end

function slot0.getUnlockLevel(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0.turnConfig.configDict[slot1]) do
		if slot7.groupNum == slot2 then
			return slot7.turn
		end
	end
end

function slot0.getShopCo(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0.shopConfig.configList) do
		if slot7.activityId == slot1 and slot7.level == slot2 then
			return slot7
		end
	end

	logError("dont exist shopCo" .. tostring(slot1) .. "#" .. tostring(slot2))
end

function slot0.getHeroPassiveSkillIdList(slot0, slot1, slot2)
	slot3 = slot0:getRoleCo(slot1)
	slot4 = {}

	return (not slot2 or string.splitToNumber(slot3.replacePassiveSkill, "|")) and string.splitToNumber(slot3.passiveSkill, "|")
end

function slot0.getHeroSkillIdDic(slot0, slot1, slot2)
	slot5 = string.splitToNumber(slot0:getRoleCo(slot1).activeSkill1, "#")

	if slot2 then
		-- Nothing
	else
		slot4[1] = slot5
		slot4[2] = slot6
		slot4[3] = {
			slot3.uniqueSkill
		}
	end

	return {
		slot5[#slot5],
		string.splitToNumber(slot3.activeSkill2, "#")[#slot5],
		slot3.uniqueSkill
	}
end

function slot0.getRoleCo(slot0, slot1)
	if not slot0.roleConfig.configDict[slot1] then
		logError("dont exist role" .. tostring(slot1))
	end

	return slot2
end

function slot0.getRoleCoByHeroId(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.roleConfig.configList) do
		if slot6.heroId == slot1 then
			return slot6
		end
	end

	logError("dont exist role with heroId" .. tostring(slot1))
end

function slot0.getCollectionCo(slot0, slot1)
	if not slot0.collectionConfig.configDict[slot1] then
		logError("dont exist collection" .. tostring(slot1))
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
