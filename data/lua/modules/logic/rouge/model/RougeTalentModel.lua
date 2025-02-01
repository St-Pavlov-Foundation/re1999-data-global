module("modules.logic.rouge.model.RougeTalentModel", package.seeall)

slot0 = class("RougeTalentModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.setOutsideInfo(slot0, slot1)
	slot0.season = slot1.season
	slot0.talentponint = slot1.geniusPoint
	slot0._isNewStage = slot1.isGeniusNewStage

	if slot1.geniusIds then
		slot0.hadUnlockTalent = slot1.geniusIds
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeTalentTreeInfo)
end

function slot0.updateGeniusIDs(slot0, slot1)
	slot2 = nil

	if slot0.season == slot1.season then
		if slot1.geniusIds then
			slot0.hadUnlockTalent = slot1.geniusIds
		end

		if slot1.geniusId then
			slot2 = slot1.geniusId
		end
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeTalentTreeInfo, slot2)
end

function slot0.calculateTalent(slot0)
	if not slot0.hadUnlockTalent or #slot0.hadUnlockTalent == 0 then
		return
	end

	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot4 = {}

	for slot8, slot9 in ipairs(slot0.hadUnlockTalent) do
		if RougeTalentConfig.instance:getBranchConfigByID(RougeOutsideModel.instance:season(), slot9).show == 1 then
			if not slot2[slot11.talent] then
				slot2[slot12] = {}
			end

			table.insert(slot2[slot12], slot9)
		elseif not string.nilorempty(slot11.attribute) then
			for slot16, slot17 in ipairs(string.split(slot11.attribute, "|")) do
				slot19 = string.split(slot17, "#")
				slot20 = slot19[1]

				if ({
					rate = nil,
					id = tonumber(slot20),
					name = HeroConfig.instance:getHeroAttributeCO(tonumber(slot20)).name,
					rate = tonumber(slot19[2]),
					ismul = true
				}).id == 215 then
					slot18.icon = "icon_att_205"
				elseif slot18.id == 216 then
					slot18.icon = "icon_att_206"
				else
					slot18.icon = "icon_att_" .. slot20
				end

				slot18.isattribute = true

				if #slot3 > 0 then
					slot22 = false

					for slot26, slot27 in ipairs(slot3) do
						if slot18.id == slot27.id then
							slot27.rate = slot27.rate + slot18.rate
							slot22 = true
						end
					end

					if not slot22 then
						table.insert(slot3, slot18)
					end
				else
					table.insert(slot3, slot18)
				end
			end
		elseif not string.nilorempty(slot11.openDesc) then
			slot12 = RougeTalentConfig.instance:getTalentOverConfigById(tonumber(slot11.openDesc))
			slot13 = {
				id = slot12.id,
				name = slot12.name,
				rate = tonumber(slot12.value),
				ismul = slot12.ismul == 1,
				icon = slot12.icon,
				isattribute = false
			}

			if #slot4 > 0 then
				slot14 = false

				for slot18, slot19 in ipairs(slot4) do
					if slot13.id == slot19.id then
						slot19.rate = slot19.rate + slot13.rate
						slot14 = true
					end
				end

				if not slot14 then
					table.insert(slot4, slot13)
				end
			else
				table.insert(slot4, slot13)
			end
		end
	end

	table.sort(slot3, uv0.sortattributeList)
	table.sort(slot4, uv0.sortattributeList)
	tabletool.addValues(slot1, slot3)
	tabletool.addValues(slot1, slot4)

	return slot1, slot2
end

function slot0.sortattributeList(slot0, slot1)
	return slot0.id < slot1.id
end

function slot0.isTalentUnlock(slot0, slot1)
	for slot5, slot6 in pairs(slot0.hadUnlockTalent) do
		if slot6 == slot1 then
			return true
		end
	end

	return false
end

function slot0.getHadConsumeTalentPoint(slot0)
	if not slot0.hadUnlockTalent or #slot0.hadUnlockTalent == 0 then
		return 0
	end

	for slot6, slot7 in ipairs(slot0.hadUnlockTalent) do
		slot1 = 0 + RougeTalentConfig.instance:getBranchConfigByID(RougeOutsideModel.instance:season(), slot7).cost
	end

	return slot1
end

function slot0.getHadAllTalentPoint(slot0)
	slot2 = slot0:getHadConsumeTalentPoint()
	slot3 = tonumber(RougeConfig.instance:getOutSideConstValueByID(RougeEnum.OutsideConst.SkillPointLimit))

	if slot0.talentponint then
		slot2 = slot3 < slot1 + slot0.talentponint and slot3 or slot4
	end

	return slot2
end

function slot0.getTalentPoint(slot0)
	return slot0.talentponint
end

function slot0.getUnlockNumByTalent(slot0, slot1)
	if not slot0.hadUnlockTalent or #slot0.hadUnlockTalent == 0 then
		return 0
	end

	for slot6, slot7 in ipairs(slot0.hadUnlockTalent) do
		if RougeTalentConfig.instance:getBranchConfigByID(RougeOutsideModel.instance:season(), slot7).talent == slot1 then
			slot2 = 0 + 1
		end
	end

	return slot2
end

function slot0.checkNodeLock(slot0, slot1)
	slot2 = slot1.id

	if slot1.talent == 1 and slot1.isOrigin == 1 then
		return false
	end

	if not slot0.hadUnlockTalent or #slot0.hadUnlockTalent == 0 then
		return true
	end

	if RougeTalentConfig.instance:getBranchConfigByID(RougeOutsideModel.instance:season(), slot2).isOrigin == 1 then
		return slot0:checkBigNodeLock(slot4.talent)
	else
		return slot0:checkBeforeNodeLock(slot2)
	end

	return true
end

function slot0.checkBeforeNodeLock(slot0, slot1)
	if RougeTalentConfig.instance:getBranchConfigByID(RougeOutsideModel.instance:season(), slot1).isOrigin == 1 then
		return false
	end

	if string.split(slot3.before, "|") then
		for slot8, slot9 in ipairs(slot0.hadUnlockTalent) do
			for slot13, slot14 in ipairs(slot4) do
				if slot9 == tonumber(slot14) then
					return false
				end
			end
		end
	end

	return true
end

function slot0.checkBigNodeLock(slot0, slot1)
	if slot1 == 1 then
		return false
	end

	if RougeTalentConfig.instance:getConfigByTalent(RougeOutsideModel.instance:season(), slot1).cost <= slot0:getHadConsumeTalentPoint() then
		return false
	end

	return true
end

function slot0.checkNodeCanLevelUp(slot0, slot1)
	if slot0:checkNodeLock(slot1) then
		return
	end

	if slot0:checkNodeLight(slot1.id) then
		if slot1.talent == 1 and slot1.isOrigin == 1 then
			return false
		end
	elseif not slot0.talentponint or slot0.talentponint <= 0 then
		return false
	elseif slot1.cost <= slot0.talentponint then
		return true
	end
end

function slot0.checkBigNodeShowUp(slot0, slot1)
	slot3 = false

	for slot7, slot8 in ipairs(RougeTalentConfig.instance:getBranchConfigListByTalent(slot1)) do
		slot3 = slot0:checkNodeCanLevelUp(slot8)

		if slot8.talent == 1 and slot0:getUnlockNumByTalent(1) == RougeTalentConfig.instance:getBranchNumByTalent(1) then
			return false
		end

		if slot3 then
			return slot3
		end
	end
end

function slot0.checkAnyNodeCanUp(slot0)
	slot3 = false

	for slot7, slot8 in ipairs(RougeTalentConfig.instance:getRougeTalentDict(RougeOutsideModel.instance:season())) do
		if slot0:checkBigNodeShowUp(slot8.id) then
			slot3 = true

			break
		end
	end

	return slot3
end

function slot0.setCurrentSelectIndex(slot0, slot1)
	slot0._currentSelectIndex = slot1
end

function slot0.checkIsCurrentSelectView(slot0, slot1)
	if not slot0._currentSelectIndex or not slot1 then
		return false
	end

	return slot0._currentSelectIndex == slot1
end

function slot0.setNewStage(slot0, slot1)
	slot0._isNewStage = slot1
end

function slot0.checkIsNewStage(slot0)
	return slot0._isNewStage
end

function slot0.checkNodeLight(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.hadUnlockTalent) do
		if slot6 == slot1 then
			return true
		end
	end

	return false
end

function slot0.getUnlockTalent(slot0)
	return slot0.hadUnlockTalent
end

function slot0.getAllUnlockPoint(slot0)
	if not slot0.hadUnlockTalent or #slot0.hadUnlockTalent == 0 then
		return 0
	end

	return #slot0.hadUnlockTalent
end

function slot0.getNextNeedUnlockTalent(slot0)
	slot3 = {}

	for slot7, slot8 in ipairs(RougeTalentConfig.instance:getRougeTalentDict(RougeOutsideModel.instance:season())) do
		if not slot3[slot8.cost] then
			slot3[slot8.cost] = {}
		end

		table.insert(slot3[slot8.cost], slot8.id)
	end

	slot4 = nil

	for slot8, slot9 in ipairs(slot2) do
		if slot0:checkBigNodeLock(slot8) then
			slot4 = slot9.cost

			break
		end
	end

	if slot3[slot4] then
		return slot3[slot4]
	end
end

function slot0.calcTalentUnlockIds(slot0, slot1)
	for slot5, slot6 in pairs(slot0.hadUnlockTalent) do
		if slot1[slot6] ~= nil then
			slot1[slot6] = true
		end
	end
end

slot0.instance = slot0.New()

return slot0
