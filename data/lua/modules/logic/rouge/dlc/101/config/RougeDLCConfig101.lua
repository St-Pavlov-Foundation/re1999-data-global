module("modules.logic.rouge.dlc.101.config.RougeDLCConfig101", package.seeall)

slot0 = class("RougeDLCConfig101", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"rouge_limit",
		"rouge_limit_group",
		"rouge_risk",
		"rouge_limit_buff",
		"rouge_dlc_const",
		"rouge_surprise_attack",
		"rouge_unlock_skills"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "rouge_limit" then
		slot0:_buildRougeLimitMap(slot2)
	elseif slot1 == "rouge_limit_group" then
		slot0:_buildLimiterGroupMap(slot2)
	elseif slot1 == "rouge_risk" then
		slot0._rougeRiskTab = slot2
	elseif slot1 == "rouge_limit_buff" then
		slot0:_buildLimiterBuffMap(slot2)
	elseif slot1 == "rouge_unlock_skills" then
		slot0:_buildRougeUnlockSkillsMap(slot2)
	end
end

function slot0._buildRougeLimitMap(slot0, slot1)
	slot0._limitConfigTab = slot1
	slot0._limiterCoGroupMap = {}
	slot0._limiterCoMap = {}

	for slot5, slot6 in ipairs(slot1.configList) do
		slot0._limiterCoGroupMap[slot7] = slot0._limiterCoGroupMap[slot6.group] or {}

		table.insert(slot0._limiterCoGroupMap[slot7], slot6)

		slot0._limiterCoMap[slot6.id] = slot6
	end

	for slot5, slot6 in pairs(slot0._limiterCoGroupMap) do
		table.sort(slot6, uv0.limiterCoGroupSortFunc)
	end
end

function slot0.limiterCoGroupSortFunc(slot0, slot1)
	if slot0.level ~= slot1.level then
		return slot2 < slot3
	end

	return slot0.id < slot1.id
end

function slot0.getVersionLimiterCos(slot0, slot1)
	return slot0._limitConfigTab.configDict[slot1]
end

function slot0.getLimiterCo(slot0, slot1)
	return slot0._limiterCoMap and slot0._limiterCoMap[slot1]
end

function slot0._buildLimiterGroupMap(slot0, slot1)
	slot0._limitGroupConfigTab = slot1
	slot0._limiterGroupVersionMap = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1.configList) do
			for slot11, slot12 in ipairs(RougeDLCHelper.versionStrToList(slot6.version)) do
				slot0._limiterGroupVersionMap[slot12] = slot0._limiterGroupVersionMap[slot12] or {}

				table.insert(slot0._limiterGroupVersionMap[slot12], slot6)
			end
		end
	end
end

function slot0.getLimiterGroupCo(slot0, slot1)
	return slot0._limitGroupConfigTab and slot0._limitGroupConfigTab.configDict[slot1]
end

function slot0.getAllLimiterGroupCos(slot0)
	return slot0._limitGroupConfigTab.configList
end

function slot0.getAllVersionLimiterGroupCos(slot0, slot1)
	slot2 = {}
	slot3 = {}

	if slot1 then
		for slot7, slot8 in ipairs(slot1) do
			if slot0._limiterGroupVersionMap and slot0._limiterGroupVersionMap[slot8] then
				for slot13, slot14 in ipairs(slot9) do
					if not slot3[slot14.id] then
						table.insert(slot2, slot14)

						slot3[slot14.id] = true
					end
				end
			end
		end
	end

	table.sort(slot2, uv0._limiterGroupSortFunc)

	return slot2
end

function slot0._limiterGroupSortFunc(slot0, slot1)
	return slot0.id < slot1.id
end

function slot0.getAllLimiterCosInGroup(slot0, slot1)
	return slot0._limiterCoGroupMap and slot0._limiterCoGroupMap[slot1]
end

function slot0.getLimiterCoByGroupIdAndLv(slot0, slot1, slot2)
	return slot0:getAllLimiterCosInGroup(slot1) and slot3[slot2]
end

function slot0.getLimiterGroupMaxLevel(slot0, slot1)
	return slot0:getAllLimiterCosInGroup(slot1) and #slot2 or 0
end

function slot0.getRougeRiskCo(slot0, slot1)
	return slot0._rougeRiskTab and slot0._rougeRiskTab[slot1]
end

function slot0.getRougeRiskCoByRiskValue(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in ipairs(slot0._rougeRiskTab.configList) do
		if (string.splitToNumber(slot7.range, "#")[1] or 0) <= slot1 and slot1 <= (slot8[2] or 0) then
			slot2 = slot7

			break
		end
	end

	return slot2
end

function slot0._buildLimiterBuffMap(slot0, slot1)
	slot0._buffTab = slot1
	slot0._buffTypeMap = {}

	for slot5, slot6 in ipairs(slot1.configList) do
		if not string.nilorempty(slot6.buffType) then
			for slot12, slot13 in ipairs(RougeDLCHelper.versionStrToList(slot6.version)) do
				slot0._buffTypeMap[slot7] = slot0._buffTypeMap[slot7] or {}
				slot0._buffTypeMap[slot7][slot13] = slot0._buffTypeMap[slot7][slot13] or {}

				table.insert(slot0._buffTypeMap[slot7][slot13], slot6)
			end
		else
			logError("肉鸽限制器Buff词条类型为空, buffId = " .. tostring(slot6.id))
		end
	end
end

function slot0.getAllLimiterBuffCosByType(slot0, slot1, slot2)
	slot3 = {}
	slot4 = {}

	if slot0._buffTypeMap and slot0._buffTypeMap[slot2] and slot1 then
		for slot9, slot10 in ipairs(slot1) do
			if slot5[slot10] then
				for slot15, slot16 in ipairs(slot11) do
					if not slot4[slot16.id] then
						slot4[slot16.id] = true

						table.insert(slot3, slot16)
					end
				end
			end
		end
	end

	return slot3
end

function slot0.getLimiterBuffCo(slot0, slot1)
	return slot0._buffTab and slot0._buffTab.configDict[slot1]
end

function slot0.getAllLimiterBuffCos(slot0)
	return slot0._buffTab and slot0._buffTab.configList
end

function slot0._buildRougeUnlockSkillsMap(slot0, slot1)
	slot0._unlockSkillConfigTab = slot1
	slot0._unlockSkillMap = {}

	for slot5, slot6 in ipairs(slot1.configList) do
		slot0._unlockSkillMap[slot7] = slot0._unlockSkillMap[slot6.style] or {}

		table.insert(slot0._unlockSkillMap[slot7], slot6)
	end
end

function slot0.getStyleUnlockSkills(slot0, slot1)
	return slot0._unlockSkillMap and slot0._unlockSkillMap[slot1]
end

function slot0.getUnlockSkills(slot0, slot1)
	return slot0._unlockSkillConfigTab.configDict[slot1]
end

function slot0.getMaxLevlRiskCo(slot0)
	return lua_rouge_risk.configList[#lua_rouge_risk.configList]
end

slot0.instance = slot0.New()

return slot0
