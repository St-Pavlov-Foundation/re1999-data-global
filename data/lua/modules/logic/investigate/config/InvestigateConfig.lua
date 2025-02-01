module("modules.logic.investigate.config.InvestigateConfig", package.seeall)

slot0 = class("InvestigateConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"investigate_info",
		"investigate_clue",
		"investigate_reward"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "investigate_info" then
		slot0:_initInvestigateInfo()
	elseif slot1 == "investigate_clue" then
		slot0:_initInvestigateClue()
	end
end

function slot0._initInvestigateClue(slot0)
	slot0._investigateAllClueInfos = {}
	slot0._investigateRelatedClueInfos = {}
	slot0._investigateMapElementInfos = {}

	for slot4, slot5 in ipairs(lua_investigate_clue.configList) do
		slot0._investigateAllClueInfos[slot5.infoID] = slot0._investigateAllClueInfos[slot5.infoID] or {}

		table.insert(slot0._investigateAllClueInfos[slot5.infoID], slot5)

		slot0._investigateRelatedClueInfos[slot5.infoID] = slot0._investigateRelatedClueInfos[slot5.infoID] or {}

		table.insert(slot0._investigateRelatedClueInfos[slot5.infoID], slot5)

		if slot5.mapElement > 0 then
			slot0._investigateMapElementInfos[slot5.mapElement] = slot5
		end
	end
end

function slot0.getInvestigateClueInfoByElement(slot0, slot1)
	return slot0._investigateMapElementInfos[slot1]
end

function slot0.getInvestigateAllClueInfos(slot0, slot1)
	return slot0._investigateAllClueInfos[slot1]
end

function slot0.getInvestigateRelatedClueInfos(slot0, slot1)
	return slot0._investigateRelatedClueInfos[slot1]
end

function slot0._initInvestigateInfo(slot0)
	slot0._roleEntranceInfos = {}
	slot0._roleGroupInfos = {}

	for slot4, slot5 in ipairs(lua_investigate_info.configList) do
		if not slot0._roleEntranceInfos[slot5.entrance] then
			slot0._roleEntranceInfos[slot5.entrance] = slot5
		end

		slot6 = slot0._roleGroupInfos[slot5.group] or {}

		table.insert(slot6, slot5)

		slot0._roleGroupInfos[slot5.group] = slot6
	end
end

function slot0.getRoleEntranceInfos(slot0)
	return slot0._roleEntranceInfos
end

function slot0.getRoleGroupInfoList(slot0, slot1)
	return slot0._roleGroupInfos[slot1]
end

slot0.instance = slot0.New()

return slot0
