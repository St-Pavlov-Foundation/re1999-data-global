module("modules.logic.character.model.CharacterSwitchListModel", package.seeall)

slot0 = class("CharacterSwitchListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0._tempHeroId = nil
	slot0._tempSkinId = nil
end

function slot0.reInit(slot0)
	slot0._tempHeroId = nil
	slot0._tempSkinId = nil
end

function slot0.initHeroList(slot0)
	slot0._mainHeroList = {}
	slot0.curHeroId = nil
	slot1 = CharacterMainHeroMO.New()
	slot6 = true

	slot1:init(nil, 0, slot6)
	table.insert(slot0._mainHeroList, slot1)

	for slot6, slot7 in ipairs(HeroModel.instance:getList()) do
		slot8 = CharacterMainHeroMO.New()

		slot8:init(slot7, slot7.config.skinId, false)
		table.insert(slot0._mainHeroList, slot8)
	end
end

function slot0._isDefaultSkinId(slot0, slot1)
	return slot1.skinId == slot1.heroMO.config.skinId
end

function slot0._commonSort(slot0, slot1, slot2)
	if slot1.isRandom then
		return true
	end

	if slot2.isRandom then
		return false
	end

	if slot1.heroMO.heroId == slot0.curHeroId then
		return true
	end

	if slot2.heroMO.heroId == slot0.curHeroId then
		return false
	end

	if slot1.heroMO.heroId == slot2.heroMO.heroId then
		return slot0:_isDefaultSkinId(slot1) and not slot0:_isDefaultSkinId(slot2)
	end

	return nil
end

function slot0.sortByTime(slot0, slot1)
	table.sort(slot0._mainHeroList, function (slot0, slot1)
		if uv0:_commonSort(slot0, slot1) ~= nil then
			return slot2
		end

		if slot0.heroMO.createTime ~= slot1.heroMO.createTime then
			if uv1 then
				return slot0.heroMO.createTime < slot1.heroMO.createTime
			else
				return slot1.heroMO.createTime < slot0.heroMO.createTime
			end
		end

		return slot0.heroMO.heroId < slot1.heroMO.heroId
	end)
	slot0:setList(slot0._mainHeroList)
end

function slot0.sortByRare(slot0, slot1)
	table.sort(slot0._mainHeroList, function (slot0, slot1)
		if uv0:_commonSort(slot0, slot1) ~= nil then
			return slot2
		end

		if slot0.heroMO.config.rare == slot1.heroMO.config.rare then
			return slot0.heroMO.config.id < slot1.heroMO.config.id
		end

		if slot0.heroMO.config.rare ~= slot1.heroMO.config.rare then
			if uv1 then
				return slot0.heroMO.config.rare < slot1.heroMO.config.rare
			else
				return slot1.heroMO.config.rare < slot0.heroMO.config.rare
			end
		end

		return slot0.heroMO.heroId < slot1.heroMO.heroId
	end)
	slot0:setList(slot0._mainHeroList)
end

function slot0.getMoByHeroId(slot0, slot1)
	if not slot0._mainHeroList then
		return
	end

	for slot5, slot6 in ipairs(slot0._mainHeroList) do
		if not slot6.heroMO and not slot1 or slot6.heroMO and slot6.heroMO.heroId == slot1 then
			return slot6
		end
	end
end

function slot0.getMoByHero(slot0, slot1, slot2)
	if not slot0._mainHeroList then
		return
	end

	for slot6, slot7 in ipairs(slot0._mainHeroList) do
		if slot2 and slot7.skinId == slot2 then
			return slot7
		end

		if not slot2 and slot7.heroMO.heroId and slot7.skinId == slot7.heroMO.config.skinId then
			return slot7
		end
	end
end

function slot0.getMainHero(slot0, slot1)
	slot3 = string.splitToNumber(PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.MainHero), "#")
	slot5 = slot3[2]

	if slot3[1] == -1 then
		if slot1 or not slot0._tempHeroId or not slot0._tempSkinId then
			slot7 = HeroModel.instance:getList()

			if slot7[math.random(#slot7)] then
				slot9 = {
					slot8.config.skinId
				}

				for slot13, slot14 in ipairs(slot8.skinInfoList) do
					table.insert(slot9, slot14.skin)
				end

				slot0._tempHeroId = slot8.heroId
				slot0._tempSkinId = slot9[math.random(#slot9)]
			end
		else
			return slot0._tempHeroId, slot0._tempSkinId, true
		end
	else
		if not slot4 or slot4 == 0 or not HeroConfig.instance:getHeroCO(slot4) then
			slot4 = slot0:getDefaultHeroId()
			slot5 = nil
		end

		if (not slot5 or slot5 == 0) and slot4 and slot4 ~= 0 then
			slot5 = HeroConfig.instance:getHeroCO(slot4) and slot7.skinId
		end

		slot0._tempHeroId = slot4
		slot0._tempSkinId = slot5
	end

	slot7 = ""

	if slot4 then
		if slot5 then
			slot7 = tostring(slot4) .. "#" .. tostring(slot5)
		end
	end

	if not string.nilorempty(slot7) and slot7 ~= slot2 then
		PlayerModel.instance:forceSetSimpleProperty(PlayerEnum.SimpleProperty.MainHero, slot7)
		PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.MainHero, slot7)
	end

	return slot4, slot5, slot6
end

function slot0.getDefaultHeroId(slot0)
	slot1 = CommonConfig.instance:getConstNum(ConstEnum.MainViewDefaultHeroId)
	slot3 = #HeroModel.instance:getList() > 0 and slot2[1].config.id or nil

	for slot7, slot8 in ipairs(slot2) do
		if slot8.config.id == slot1 then
			return slot1
		end

		if slot9 < slot3 then
			slot3 = slot9
		end
	end

	return slot3
end

function slot0.changeMainHero(slot0, slot1, slot2, slot3)
	slot1 = slot1 and tonumber(slot1)
	slot2 = slot2 and tonumber(slot2)

	if slot3 then
		slot1 = -1
		slot2 = -1
	elseif not slot2 or slot2 == 0 then
		slot2 = HeroConfig.instance:getHeroCO(slot1).skinId
	end

	slot4 = ""

	if slot1 then
		if slot2 then
			slot4 = tostring(slot1) .. "#" .. tostring(slot2)
		end
	end

	if not string.nilorempty(slot4) then
		PlayerModel.instance:forceSetSimpleProperty(PlayerEnum.SimpleProperty.MainHero, slot4)
		PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.MainHero, tostring(slot4))
		CharacterController.instance:dispatchEvent(CharacterEvent.ChangeMainHero)
	end
end

slot0.instance = slot0.New()

return slot0
