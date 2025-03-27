module("modules.logic.playercard.model.PlayerCardCharacterSwitchListModel", package.seeall)

slot0 = class("PlayerCardCharacterSwitchListModel", ListScrollModel)

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

	for slot5, slot6 in ipairs(HeroModel.instance:getList()) do
		slot7 = CharacterMainHeroMO.New()

		slot7:init(slot6, slot6.config.skinId, false)
		table.insert(slot0._mainHeroList, slot7)
	end
end

function slot0._isDefaultSkinId(slot0, slot1)
	return slot1.skinId == slot1.heroMO.config.skinId
end

function slot0._commonSort(slot0, slot1, slot2)
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

function slot0.changeMainHero(slot0, slot1, slot2, slot3, slot4)
	slot1 = slot1 and tonumber(slot1)
	slot5 = slot4 and 1 or 0

	if not slot2 or not tonumber(slot2) or slot2 == 0 then
		slot2 = HeroConfig.instance:getHeroCO(slot1).skinId
	end

	if not string.nilorempty(table.concat({
		slot1,
		slot2,
		slot5
	}, "#")) then
		if PlayerCardModel.instance:isCharacterSwitchFlag() == nil then
			ViewMgr.instance:openView(ViewName.PlayerCardCharacterSwitchTipsView, {
				heroParam = slot6
			})
		else
			slot0:changeMainHeroByParam(slot6, slot7)
		end
	end
end

function slot0.changeMainHeroByParam(slot0, slot1, slot2)
	if string.nilorempty(slot1) then
		return
	end

	if slot2 then
		slot3 = string.splitToNumber(slot1, "#")
		slot4 = slot3[1]

		CharacterSwitchListModel.instance:changeMainHero(slot4, slot3[2])
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.RefreshMainHeroSkin)
		CharacterController.instance:dispatchEvent(CharacterEvent.MainThumbnailSignature, slot4)
	end

	PlayerCardRpc.instance:sendSetPlayerCardHeroCoverRequest(slot1)
end

slot0.instance = slot0.New()

return slot0
