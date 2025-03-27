module("modules.logic.playercard.model.PlayerCardCritterPlaceListModel", package.seeall)

slot0 = class("PlayerCardCritterPlaceListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:clear()
	slot0:clearData()
end

function slot0.reInit(slot0)
	slot0:clearData()
end

function slot0.clearData(slot0)
	slot0:setIsSortByRareAscend(false)
	slot0:setMatureFilterType(CritterEnum.MatureFilterType.All)
end

function slot1(slot0, slot1)
	slot6 = CritterConfig.instance:getCritterRare(slot0:getDefineId())
	slot7 = CritterConfig.instance:getCritterRare(slot1:getDefineId())

	if tonumber(slot0:getId()) == PlayerCardModel.instance:getSelectCritterUid() ~= (tonumber(slot1:getId()) == PlayerCardModel.instance:getSelectCritterUid()) then
		return slot8
	end

	if slot6 ~= slot7 then
		if uv0.instance:getIsSortByRareAscend() then
			return slot6 < slot7
		else
			return slot7 < slot6
		end
	end

	if slot0:isMutate() ~= slot1:isMutate() then
		return slot10
	end

	if slot0:isMaturity() ~= slot1:isMaturity() then
		return slot12
	end

	if slot4 ~= slot5 then
		return slot4 < slot5
	end

	return slot2 < slot3
end

function slot0.setPlayerCardCritterList(slot0, slot1)
	slot3 = {}
	slot4 = not slot0.matureFilterType or slot0.matureFilterType == CritterEnum.MatureFilterType.All
	slot5 = slot0.matureFilterType == CritterEnum.MatureFilterType.Mature

	for slot9, slot10 in ipairs(CritterModel.instance:getAllCritters()) do
		slot11 = true

		if slot1 then
			slot11 = slot1:isPassedFilter(slot10)
		end

		if slot11 then
			if slot4 then
				slot3[#slot3 + 1] = slot10
			else
				slot12 = slot10:isMaturity()

				if slot5 and slot12 or not slot5 and not slot12 then
					slot3[#slot3 + 1] = slot10
				end
			end
		end
	end

	table.sort(slot3, uv0)
	slot0:setList(slot3)
end

function slot0.setIsSortByRareAscend(slot0, slot1)
	slot0._rareAscend = slot1
end

function slot0.setMatureFilterType(slot0, slot1)
	slot0.matureFilterType = slot1
end

function slot0.getIsSortByRareAscend(slot0)
	return slot0._rareAscend
end

function slot0.getMatureFilterType(slot0)
	return slot0.matureFilterType
end

function slot0.selectMatureFilterType(slot0, slot1, slot2)
	if slot0:getMatureFilterType() and slot3 == slot1 then
		return
	end

	slot0:setMatureFilterType(slot1)
	slot0:setPlayerCardCritterList(slot2)
end

slot0.instance = slot0.New()

return slot0
