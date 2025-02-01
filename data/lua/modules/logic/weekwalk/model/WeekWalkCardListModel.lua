module("modules.logic.weekwalk.model.WeekWalkCardListModel", package.seeall)

slot0 = class("WeekWalkCardListModel", ListScrollModel)

function slot0.verifyCondition(slot0, slot1)
	slot6 = 0
	slot7 = 0
	slot8 = 0

	if GameUtil.splitString2(lua_weekwalk_pray.configDict[tonumber(lua_weekwalk_buff.configDict[slot1].param)].sacrificeLimit, true, "|", "#") then
		for slot13, slot14 in ipairs(slot9) do
			if slot14[1] == 1 then
				slot7 = slot14[2]
			elseif slot15 == 2 then
				slot6 = slot16
			elseif slot15 == 3 then
				slot8 = slot16
			end
		end
	end

	slot10 = slot5.blessingLimit == "1"

	if not slot0:_verify(slot7, slot6, nil, , slot8) then
		GameFacade.showToast(ToastEnum.WeekWalkCardNoHero)

		return false
	end

	slot12 = slot7

	if slot8 ~= 0 then
		slot12 = HeroConfig.instance:getHeroCO(slot8).career
	end

	if not slot0:_verify(slot10 and slot12 or 0, 0, slot11, nil, 0) then
		GameFacade.showToast(ToastEnum.WeekWalkCardNoHero)

		return false
	end

	return true
end

function slot0._verify(slot0, slot1, slot2, slot3, slot4, slot5)
	for slot11, slot12 in ipairs(HeroModel.instance:getList()) do
		if slot2 <= slot12.level and (slot5 == 0 or slot12.heroId == slot5) and WeekWalkModel.instance:getInfo():getHeroHp(slot12.heroId) > 0 and (slot1 == 0 or slot1 == slot12.config.career) and slot12 ~= slot3 and slot12 ~= slot4 then
			return slot12
		end
	end
end

function slot0.setCardList(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = WeekWalkModel.instance:getInfo()
	slot7 = slot0:getCardList(slot1, slot2, slot3, slot4, slot5)

	table.sort(slot7, function (slot0, slot1)
		if (uv0:getHeroHp(slot0.heroId) <= 0 and 0 or 1) ~= (uv0:getHeroHp(slot1.heroId) <= 0 and 0 or 1) then
			return slot3 < slot2
		elseif slot0.level ~= slot1.level then
			return slot1.level < slot0.level
		elseif slot0.config.rare ~= slot1.config.rare then
			return slot1.config.rare < slot0.config.rare
		elseif slot0.createTime ~= slot1.createTime then
			return slot0.createTime <= slot1.createTime
		end

		return slot1.heroId < slot0.heroId
	end)
	slot0:setList(slot7)
end

function slot0.getCardList(slot0, slot1, slot2, slot3, slot4, slot5)
	slot8 = {}

	for slot12, slot13 in ipairs(HeroModel.instance:getList()) do
		if slot2 <= slot13.level and (slot5 == 0 or slot13.heroId == slot5) and WeekWalkModel.instance:getInfo():getHeroHp(slot13.heroId) > 0 and (slot1 == 0 or slot1 == slot13.config.career) and slot13 ~= slot3 and slot13 ~= slot4 then
			table.insert(slot8, slot13)
		end
	end

	return slot8
end

function slot0.setCharacterList(slot0, slot1)
	slot3 = {}
	slot4 = {}

	for slot8, slot9 in ipairs(slot1) do
		if WeekWalkModel.instance:getInfo():getHeroHp(slot9.heroId) <= 0 then
			table.insert(slot4, slot9)
		else
			table.insert(slot3, slot9)
		end
	end

	tabletool.addValues(slot3, slot4)
	slot0:setList(slot3)
end

slot0.instance = slot0.New()

return slot0
