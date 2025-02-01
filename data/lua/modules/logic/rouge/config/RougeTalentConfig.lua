module("modules.logic.rouge.config.RougeTalentConfig", package.seeall)

slot0 = class("RougeTalentConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"rouge_genius",
		"rouge_genius_branch",
		"rouge_genius_overview",
		"rouge_genius_branchlight"
	}
end

function slot0.onInit(slot0)
	slot0._talentDict = nil
	slot0._talentBranchDict = {}
	slot0._talentBranchList = nil
	slot0._talentoverList = nil
	slot0._talentBranchLightList = {}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "rouge_genius" then
		slot0._talentDict = slot2.configDict
	end

	if slot1 == "rouge_genius_branch" then
		for slot6, slot7 in ipairs(slot2.configList) do
			if slot7.talent then
				if slot0._talentBranchDict[slot7.talent] == nil then
					slot0._talentBranchDict[slot7.talent] = {}
				end

				table.insert(slot0._talentBranchDict[slot7.talent], slot7)
			end
		end

		slot0._talentBranchList = slot2.configDict
	end

	if slot1 == "rouge_genius_overview" then
		slot0._talentoverList = slot2.configDict
	end

	if slot1 == "rouge_genius_branchlight" then
		for slot6, slot7 in ipairs(slot2.configList) do
			if slot7.talent then
				if slot0._talentBranchLightList[slot7.talent] == nil then
					slot0._talentBranchLightList[slot7.talent] = {}
				end

				table.insert(slot0._talentBranchLightList[slot7.talent], slot7)
			end
		end
	end
end

function slot0.getTalentOverConfigById(slot0, slot1)
	return slot0._talentoverList[slot1]
end

function slot0.getRougeTalentDict(slot0, slot1)
	return slot0._talentDict[slot1]
end

function slot0.getConfigByTalent(slot0, slot1, slot2)
	return slot0._talentDict[slot1][slot2]
end

function slot0.getTalentNum(slot0, slot1)
	return #slot0._talentDict[slot1]
end

function slot0.getTalentBranchConfig(slot0)
	return slot0._talentBranchDict
end

function slot0.getBranchConfigListByTalent(slot0, slot1)
	return slot0._talentBranchDict[slot1]
end

function slot0.getBranchConfigByTalent(slot0, slot1, slot2)
	return slot0._talentBranchDict[slot1][slot2]
end

function slot0.getBranchNumByTalent(slot0, slot1)
	return #slot0._talentBranchDict[slot1]
end

function slot0.getBranchConfigByID(slot0, slot1, slot2)
	return slot0._talentBranchList[slot1][slot2]
end

function slot0.getBranchLightConfigByTalent(slot0, slot1)
	return slot0._talentBranchLightList[slot1]
end

slot0.instance = slot0.New()

return slot0
