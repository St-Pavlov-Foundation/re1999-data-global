module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotHeroSingleGroupModel", package.seeall)

slot0 = class("V1a6_CachotHeroSingleGroupModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:_buildMOList()
end

function slot0.reInit(slot0)
	slot0:_buildMOList()
end

function slot0._buildMOList(slot0)
	slot1 = {}

	for slot5 = 1, V1a6_CachotEnum.MaxHeroCountInGroup do
		table.insert(slot1, HeroSingleGroupMO.New())
	end

	slot0:setList(slot1)
end

function slot0.isTemp(slot0)
	return slot0.temp
end

function slot0.getCurGroupMO(slot0)
	return slot0._heroGroupMO
end

function slot0.setMaxHeroCount(slot0, slot1)
	slot2 = {}

	for slot6 = 1, slot1 do
		table.insert(slot2, HeroSingleGroupMO.New())
	end

	slot0:setList(slot2)
end

function slot0.setSingleGroup(slot0, slot1, slot2)
	slot0._heroGroupMO = slot1

	for slot7 = 1, #slot0:getList() do
		slot3[slot7]:init(slot7, slot1 and slot1.heroList[slot7])
	end

	slot0.temp = slot1 and slot1.temp

	slot0:setList(slot3)

	if slot2 and slot1 then
		for slot8 = 1, #slot0:getList() do
			slot4[slot8]:setAid(slot1.aidDict and slot1.aidDict[slot8])

			if slot1.trialDict and slot1.trialDict[slot8] then
				slot4[slot8]:setTrial(unpack(slot1.trialDict[slot8]))
			else
				slot4[slot8]:setTrial()
			end
		end
	end
end

function slot0.addToEmpty(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7:isEmpty() then
			slot7:setHeroUid(slot1)

			break
		end
	end
end

function slot0.addTo(slot0, slot1, slot2)
	if slot0:getById(slot2) then
		slot3:setHeroUid(slot1)
	end
end

function slot0.remove(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7:isEqual(slot1) then
			slot7:setEmpty()

			break
		end
	end
end

function slot0.removeFrom(slot0, slot1)
	if slot0:getById(slot1) then
		slot2:setEmpty()
	end
end

function slot0.swap(slot0, slot1, slot2)
	slot4 = slot0:getById(slot2)

	if slot0:getById(slot1) and slot4 then
		if slot3.aid == -1 or slot4.aid == -1 then
			return
		end

		slot3:setHeroUid(slot4.heroUid)
		slot4:setHeroUid(slot3.heroUid)
		slot3:setAid(slot4.aid)
		slot4:setAid(slot3.aid)
		slot3:setTrial(slot4.trial, slot4.trialTemplate, slot4.trialPos, true)
		slot4:setTrial(slot3.trial, slot3.trialTemplate, slot3.trialPos, true)
	end
end

function slot0.move(slot0, slot1, slot2)
	slot4 = {}

	for slot8, slot9 in ipairs(slot0:getList()) do
		slot10 = slot8

		if slot8 ~= slot1 then
			if slot8 < slot1 and slot2 <= slot8 then
				slot10 = slot8 + 1
			elseif slot1 < slot8 and slot8 <= slot2 then
				slot10 = slot8 - 1
			end
		else
			slot10 = slot2
		end

		slot4[slot10] = slot9
		slot9.id = slot10
	end

	slot0:setList(slot4)
end

function slot0.isInGroup(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7:isEqual(slot1) then
			return true
		end
	end
end

function slot0.isEmptyById(slot0, slot1)
	return slot0:getById(slot1) and slot2:isEmpty()
end

function slot0.isEmptyExcept(slot0, slot1)
	for slot6 = 1, V1a6_CachotEnum.HeroCountInGroup do
		if slot6 ~= slot1 and not slot0:getList()[slot6]:isEmpty() then
			return false
		end
	end

	return true
end

function slot0.isFull(slot0)
	for slot5, slot6 in ipairs(slot0:getList()) do
		if slot6:canAddHero() and V1a6_CachotHeroGroupModel.instance:isPositionOpen(slot6.id) then
			return false
		end
	end

	return true
end

function slot0.getHeroUids(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(slot0:getList()) do
		table.insert(slot1, slot7.heroUid)
	end

	return slot1
end

function slot0.getHeroUid(slot0, slot1)
	slot2 = "0"

	if slot0:getById(slot1) then
		slot2 = slot3.heroUid
	end

	return slot2
end

function slot0.hasHeroUids(slot0, slot1, slot2)
	if slot1 == "0" then
		return false
	end

	for slot7, slot8 in ipairs(slot0:getList()) do
		if slot8.heroUid == slot1 and slot8.id ~= slot2 then
			return true, slot7
		end
	end

	return false
end

function slot0.hasHero(slot0)
	if HeroModel.instance:getList() and #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			if not slot0:hasHeroUids(slot6.uid) then
				return true
			end
		end
	end

	return false
end

function slot0.isAidConflict(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7:isAidConflict(slot1) then
			return true
		end
	end

	return false
end

slot0.instance = slot0.New()

return slot0
