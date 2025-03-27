module("modules.logic.rouge.controller.RougeDLCHelper", package.seeall)

slot0 = class("RougeDLCHelper")

function slot0.isUsingDLCs()
	return RougeModel.instance:getVersion() and #slot0 > 0
end

function slot0.isUsingTargetDLC(slot0)
	if RougeModel.instance:getVersion() then
		return tabletool.indexOf(slot1, slot0) and slot2 > 0
	end
end

function slot0.isCurrentUsingContent(slot0)
	return uv0.isCurrentBaseContent(slot0) or uv0.isCurrentUsingVersions(slot0)
end

function slot0.isCurrentUsingVersions(slot0)
	for slot7, slot8 in ipairs(uv0.versionStrToList(slot0)) do
		if uv0.versionListToMap(RougeModel.instance:getVersion())[slot8] then
			return true
		end
	end
end

function slot0.isCurrentBaseContent(slot0)
	return string.nilorempty(slot0)
end

function slot0.versionListToMap(slot0)
	slot1 = {}

	if slot0 then
		for slot5, slot6 in ipairs(slot0) do
			slot1[slot6] = true
		end
	end

	return slot1
end

function slot0.versionStrToList(slot0)
	if string.nilorempty(slot0) then
		return {}
	end

	return string.splitToNumber(slot0, "#")
end

function slot0.getAllCurrentUseStyleSkills(slot0)
	if not RougeOutsideModel.instance:config():getStyleConfig(slot0) then
		return {}
	end

	slot5 = string.splitToNumber(slot2.mapSkills, "#")
	slot6 = RougeDLCConfig101.instance:getStyleUnlockSkills(slot0)

	for slot10, slot11 in ipairs(string.splitToNumber(slot2.activeSkills, "#")) do
		table.insert({}, uv0._createSkillMo(RougeEnum.SkillType.Style, slot11))
	end

	for slot10, slot11 in ipairs(slot5) do
		table.insert(slot3, uv0._createSkillMo(RougeEnum.SkillType.Map, slot11))
	end

	for slot11, slot12 in ipairs(slot6 or {}) do
		if uv0.isCurrentUsingContent(slot12.version) and RougeOutsideModel.instance:getRougeGameRecord():isSkillUnlock(slot12.type, slot12.skillId) then
			table.insert(slot3, uv0._createSkillMo(slot12.type, slot12.skillId))
		end
	end

	table.sort(slot3, uv0._styleSkillSortFunc)

	return slot3
end

function slot0._createSkillMo(slot0, slot1)
	return {
		type = slot0,
		skillId = slot1
	}
end

function slot0._styleSkillSortFunc(slot0, slot1)
	slot3 = RougeOutsideModel.instance:config() and slot2:getSkillCo(slot0.type, slot0.skillId)
	slot4 = slot2 and slot2:getSkillCo(slot1.type, slot1.skillId)

	if uv0.isCurrentBaseContent(slot3 and slot3.version) ~= uv0.isCurrentBaseContent(slot4 and slot4.version) then
		return slot5
	end

	slot8 = RougeEnum.SkillTypeSortEnum[slot1.type]

	if RougeEnum.SkillTypeSortEnum[slot0.type] and slot8 and slot7 ~= slot8 then
		return slot7 < slot8
	end

	return slot0.skillId < slot1.skillId
end

function slot0.getCurrentUseStyleFightSkills(slot0)
	if not RougeOutsideModel.instance:config():getStyleConfig(slot0) then
		return {}
	end

	for slot8, slot9 in ipairs(string.splitToNumber(slot2.activeSkills, "#")) do
		table.insert({}, uv0._createSkillMo(RougeEnum.SkillType.Style, slot9))
	end

	for slot10, slot11 in ipairs(RougeDLCConfig101.instance:getStyleUnlockSkills(slot0) or {}) do
		if uv0.isCurrentUsingContent(slot11.version) and RougeOutsideModel.instance:getRougeGameRecord():isSkillUnlock(slot11.type, slot11.skillId) and slot11.type == RougeEnum.SkillType.Style then
			table.insert(slot3, uv0._createSkillMo(slot11.type, slot11.skillId))
		end
	end

	table.sort(slot3, uv0._styleSkillSortFunc)

	return slot3
end

function slot0.getCurVersionString()
	return uv0.versionListToString(RougeOutsideModel.instance:getRougeGameRecord() and slot0:getVersionIds())
end

function slot0.versionListToString(slot0)
	slot1 = ""

	if slot0 then
		slot1 = table.concat(slot0, "_")
	end

	return slot1
end

return slot0
