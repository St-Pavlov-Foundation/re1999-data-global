module("modules.logic.summon.model.SummonPoolDetailCategoryListModel", package.seeall)

slot0 = class("SummonPoolDetailCategoryListModel", ListScrollModel)

function slot0.initCategory(slot0)
	slot1 = {}

	for slot5 = 1, 2 do
		table.insert(slot1, slot0:packMo(uv0.getName(slot5), uv0.getNameEn(slot5), slot5))
	end

	slot0:setList(slot1)
end

function slot0.packMo(slot0, slot1, slot2, slot3)
	slot0._moList = slot0._moList or {}

	if not slot0._moList[slot3] then
		slot4 = {}
		slot0._moList[slot3] = slot4
		slot4.enName = slot2
		slot4.resIndex = slot3
	end

	slot4.cnName = slot1

	return slot4
end

function slot0.setJumpLuckyBag(slot0, slot1)
	slot0._jumpLuckyBagId = slot1
end

function slot0.getJumpLuckyBag(slot0)
	return slot0._jumpLuckyBagId
end

function slot0.getName(slot0)
	if not uv0.nameDict then
		uv0.nameDict = {
			[1.0] = "p_summon_pool_detail",
			[2.0] = "p_summon_pool_probability"
		}
	end

	return luaLang(uv0.nameDict[slot0])
end

function slot0.getNameEn(slot0)
	if not uv0.nameEnDict then
		uv0.nameEnDict = {
			[1.0] = "p_summon_pool_detailEn",
			[2.0] = "p_summon_pool_probabilityEn"
		}
	end

	return luaLang(uv0.nameEnDict[slot0])
end

function slot0.buildProbUpDict(slot0)
	slot2 = {
		5,
		4
	}
	slot3 = {}
	slot4 = {}
	slot5 = false

	if not string.nilorempty(SummonConfig.instance:getSummonPool(slot0).upWeight) then
		for slot10, slot11 in ipairs(string.split(slot1.upWeight, "|")) do
			slot13 = string.splitToNumber(slot11, "#")
			slot3[slot2[slot10]] = slot13

			tabletool.addValues(slot4, slot13)

			slot5 = true
		end
	end

	return slot3, slot4, slot5
end

function slot0.buildLuckyBagDict(slot0)
	slot1 = SummonConfig.instance:getSummonPool(slot0)
	slot3 = {}
	slot4 = {}

	for slot8, slot9 in ipairs(SummonConfig.instance:getSummonLuckyBag(slot0)) do
		table.insert(slot3, slot9)
		table.insert(slot4, SummonConfig.instance:getLuckyBagHeroIds(slot0, slot9))
	end

	return slot3, slot4
end

function slot0.buildCustomPickDict(slot0)
	slot1 = {}

	if SummonMainModel.instance:getPoolServerMO(slot0) and slot2.customPickMO and slot2.customPickMO.pickHeroIds then
		for slot7 = 1, #slot2.customPickMO.pickHeroIds do
			table.insert(slot1, slot2.customPickMO.pickHeroIds[slot7])
		end
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
