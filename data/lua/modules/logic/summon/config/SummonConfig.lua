module("modules.logic.summon.config.SummonConfig", package.seeall)

slot0 = class("SummonConfig", BaseConfig)

function slot0.getDurationByPoolType(slot0, slot1)
	if slot1 == SummonEnum.Type.NewPlayer then
		return (CommonConfig.instance:getConstNum(ConstEnum.SummonPoolNewPlayerDuration) or 0) * 86400
	end

	return 0
end

function slot0.reqConfigNames(slot0)
	return {
		"summon_pool",
		"summon",
		"summon_character",
		"summon_pool_detail",
		"summon_equip_detail",
		"lucky_bag_heroes"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "summon_equip_detail" then
		slot0:_initEquipDetails()
	end
end

function slot0._initEquipDetails(slot0)
	slot0._equipPoolDict = {}

	for slot5, slot6 in ipairs(lua_summon_equip_detail.configList) do
		slot0._equipPoolDict[slot6.poolId] = slot0._equipPoolDict[slot6.poolId] or {}
		slot0._equipPoolDict[slot6.poolId][slot6.location] = slot6
	end
end

function slot0.getSummonPoolList(slot0)
	return lua_summon_pool.configList
end

function slot0.getSummon(slot0, slot1)
	return lua_summon.configDict[slot1]
end

function slot0.getCharacterDetailConfig(slot0, slot1)
	return lua_summon_character.configDict[slot1]
end

function slot0.getPoolDetailConfig(slot0, slot1)
	return lua_summon_pool_detail.configDict[slot1]
end

function slot0.getPoolDetailConfigList(slot0)
	return lua_summon_pool_detail.configList
end

function slot0.getEquipDetailByPoolId(slot0, slot1)
	return slot0._equipPoolDict[slot1]
end

function slot0.getSummonPool(slot0, slot1)
	return lua_summon_pool.configDict[slot1]
end

function slot0.getSummonLuckyBag(slot0, slot1)
	if not slot0._pool2luckyBagMap then
		slot0._pool2luckyBagMap = {}
	end

	if not slot0._pool2luckyBagMap[slot1] then
		slot2 = slot2 or {}

		if uv0.instance:getSummon(slot1) then
			for slot7, slot8 in pairs(slot3) do
				if not string.nilorempty(slot8.luckyBagId) then
					tabletool.addValues(slot2, string.splitToNumber(slot8.luckyBagId, "#"))
				end
			end
		end

		slot0._pool2luckyBagMap[slot1] = slot2
	end

	return slot2
end

function slot0.getLuckyBag(slot0, slot1, slot2)
	if lua_lucky_bag_heroes.configDict[slot1] then
		return lua_lucky_bag_heroes.configDict[slot1][slot2]
	end
end

function slot0.getLuckyBagHeroIds(slot0, slot1, slot2)
	if VersionValidator.instance:isInReviewing() then
		if #lua_app_include.configList > 0 then
			return lua_app_include.configList[1].character
		else
			return {}
		end
	end

	if not slot0._luckyBagHerosMap then
		slot0._luckyBagHerosMap = {}
	end

	if not slot0._luckyBagHerosMap[slot1] then
		slot0._luckyBagHerosMap[slot1] = {}
	end

	if not slot0._luckyBagHerosMap[slot1][slot2] then
		if slot0:getLuckyBag(slot1, slot2) then
			slot3 = string.splitToNumber(slot4.heroChoices, "#")
		else
			logError("summon luckyBag config not found, id = " .. tostring(slot2))

			slot3 = {}
		end

		slot0._luckyBagHerosMap[slot1][slot2] = slot3
	end

	return slot3
end

function slot0.getValidPoolList(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0:getSummonPoolList()) do
		if not string.nilorempty(slot7.customClz) and not string.nilorempty(slot7.prefabPath) then
			table.insert(slot2, slot7)
		end
	end

	table.sort(slot2, function (slot0, slot1)
		if slot0.priority == slot1.priority then
			return slot0.id < slot1.id
		end

		return slot1.priority < slot0.priority
	end)

	return slot2
end

function slot0.getSummonSSRTimes(slot0)
	if slot0 then
		uv0.instance.ssrTimesMap = uv0.instance.ssrTimesMap or {}

		if not uv0.instance.ssrTimesMap[slot0.id] and #string.split(slot0.awardTime, "|") >= 2 then
			uv0.instance.ssrTimesMap[slot0.id] = tonumber(slot2[2])
		end

		return slot1
	end

	return nil
end

function slot0.getRewardItems(slot0, slot1, slot2, slot3)
	slot5 = nil

	if slot2 <= 0 then
		slot5 = HeroConfig.instance:getHeroCO(slot1).firstItem

		if slot3 then
			table.insert({}, {
				type = MaterialEnum.MaterialType.Hero,
				id = slot1,
				quantity = 1
			})
		end
	else
		slot5 = (slot2 >= CommonConfig.instance:getConstNum(ConstEnum.HeroDuplicateGetCount) - 1 or slot6.duplicateItem) and slot6.duplicateItem2
	end

	if not string.nilorempty(slot5) then
		for slot11, slot12 in ipairs(string.split(slot5, "|")) do
			slot14 = string.split(slot12, "#")

			table.insert(slot4, {
				type = tonumber(slot14[1]),
				id = tonumber(slot14[2]),
				quantity = tonumber(slot14[3])
			})
		end
	end

	return slot4
end

function slot0.canShowSingleFree(slot0, slot1)
	return slot0:getSummonPool(slot1) ~= nil and slot2.totalFreeCount ~= nil and slot2.totalFreeCount > 0
end

function slot0.isLuckyBagPoolExist(slot0)
	for slot5, slot6 in pairs(slot0:getSummonPoolList()) do
		if slot6.type == SummonEnum.Type.LuckyBag then
			return true
		end
	end

	return false
end

function slot0.poolIsLuckyBag(slot0)
	if uv0.instance:getSummonPool(slot0) then
		return uv0.poolTypeIsLuckyBag(slot1.type)
	end

	return false
end

function slot0.poolTypeIsLuckyBag(slot0)
	return slot0 == SummonEnum.Type.LuckyBag
end

function slot0.getSummonDetailIdByHeroId(slot0, slot1)
	for slot5, slot6 in ipairs(lua_summon_character.configList) do
		if slot6.heroId == slot1 then
			return slot6.id
		end
	end
end

function slot0.isStrongCustomChoice(slot0, slot1)
	if uv0.instance:getSummonPool(slot1) then
		return slot2.type == SummonEnum.Type.StrongCustomOnePick
	end

	return false
end

function slot0.getStrongCustomChoiceIds(slot0, slot1)
	if uv0.instance:getSummonPool(slot1) and slot2.type == SummonEnum.Type.StrongCustomOnePick then
		return string.splitToNumber(slot2.param, "#")
	end

	return nil
end

slot0.instance = slot0.New()

return slot0
