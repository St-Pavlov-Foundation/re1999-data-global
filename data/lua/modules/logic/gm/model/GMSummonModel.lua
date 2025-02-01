module("modules.logic.gm.model.GMSummonModel", package.seeall)

slot0 = class("GMSummonModel", BaseModel)
slot0._index2Star = {
	6,
	5,
	4,
	3,
	2
}

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._allSummonHeroList = {}
	slot0._upSummonHeroList = {}
	slot0._diffRaritySummonHeroList = {}
	slot0._poolId = nil
	slot0._totalCount = nil
	slot0._star6TotalCount = nil
	slot0._star5TotalCount = nil
end

function slot0.getAllInfo(slot0)
	return slot0._poolId, slot0._totalCount, slot0._star6TotalCount, slot0._star5TotalCount
end

function slot0.getDiffRaritySummonHeroInfo(slot0)
	return slot0._diffRaritySummonHeroList
end

function slot0.getUpSummonHeroInfo(slot0)
	return slot0._upSummonHeroList
end

function slot0.getAllSummonHeroInfo(slot0)
	return slot0._allSummonHeroList
end

function slot0.getAllUpSummonName(slot0)
	slot1 = nil

	for slot5, slot6 in ipairs(slot0._upSummonHeroList) do
		slot7 = slot0:getTargetName(slot6.id)
		slot1 = slot5 == 1 and slot7 or slot7 .. "、" .. slot7
	end

	return slot1
end

function slot0.setInfo(slot0, slot1)
	slot0:reInit()

	slot0._poolId = slot1.poolId
	slot0._totalCount = slot1.totalCount
	slot0._star6TotalCount = slot1.star6TotalCount
	slot0._star5TotalCount = slot1.star5TotalCount

	slot0:_setDiffRaritySummonHeroInfo(cjson.decode(slot1.resJs1))
	slot0:_setUpSummonHeroInfo(cjson.decode(slot1.resJs2))
	slot0:_setAllSummonHeroInfo(cjson.decode(slot1.resJs3))
end

function slot0._setDiffRaritySummonHeroInfo(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		slot8 = string.split(slot6, "#")

		table.insert(slot0._diffRaritySummonHeroList, {
			star = tonumber(slot5 + 1),
			num = slot8[1],
			per = slot8[2]
		})
	end

	table.sort(slot0._diffRaritySummonHeroList, function (slot0, slot1)
		return slot1.star < slot0.star
	end)
end

function slot0._setUpSummonHeroInfo(slot0, slot1)
	slot0:_setHeroInfo(slot0._upSummonHeroList, slot1, function (slot0, slot1)
		if slot0.star ~= slot1.star then
			return slot1.star < slot0.star
		else
			return slot1.id < slot0.id
		end
	end)
end

function slot0._setAllSummonHeroInfo(slot0, slot1)
	slot0:_setHeroInfo(slot0._allSummonHeroList, slot1, function (slot0, slot1)
		if slot0.per ~= slot1.per then
			return slot1.per < slot0.per
		else
			return slot1.id < slot0.id
		end
	end)
	logNormal()
end

function slot0._setHeroInfo(slot0, slot1, slot2, slot3)
	for slot7, slot8 in ipairs(slot2) do
		slot9 = {}

		for slot13, slot14 in pairs(slot8) do
			slot16 = string.split(slot14, "#")

			table.insert(slot9, {
				id = tonumber(slot13),
				star = uv0._index2Star[slot7],
				num = slot16[1],
				per = tonumber(slot16[2])
			})
		end

		if #slot9 >= 2 then
			table.sort(slot9, slot3)
		end

		tabletool.addValues(slot1, slot9)
	end

	if #slot1 >= 2 then
		table.sort(slot1, slot3)
	end
end

function slot0.getTargetName(slot0, slot1)
	return HeroConfig.instance:getHeroCO(slot1).name
end

function slot0.getUpHeroInfo(slot0)
	slot2 = {}
	slot3 = {}
	slot4 = {}

	if not string.nilorempty(SummonConfig.instance:getSummonPool(slot0._poolId).upWeight) then
		for slot9, slot10 in ipairs(string.split(slot1.upWeight, "|")) do
			tabletool.addValues(slot2, string.splitToNumber(slot10, "#"))
		end
	end

	for slot8, slot9 in ipairs(slot0._upSummonHeroList) do
		if not tabletool.indexOf(slot2, slot9.id) then
			table.insert(slot3, slot9)
		else
			table.insert(slot4, slot9)
		end
	end

	return slot4, slot3
end

slot0.instance = slot0.New()

return slot0
