module("modules.logic.playercard.model.PlayerCardMO", package.seeall)

slot0 = pureTable("PlayerCardMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1
	slot0.userId = slot1
end

function slot0.updateInfo(slot0, slot1, slot2)
	slot0.playerInfo = slot2

	slot0:updateShowSetting(slot1.showSettings)
	slot0:updateHeroCover(slot1.heroCover)
	slot0:updateThemeId(slot1.themeId)

	slot0.roomCollection = slot1.roomCollection
	slot0.layerId = slot1.layerId
	slot0.weekwalkDeepLayerId = slot1.weekwalkDeepLayerId
	slot0.exploreCollection = slot1.exploreCollection
	slot0.rougeDifficulty = slot1.rougeDifficulty
	slot0.act128SSSCount = slot1.act128SSSCount
	slot0.achievementCount = slot1.achievementCount
end

function slot0.updateThemeId(slot0, slot1)
	slot0.themeId = slot1
end

function slot0.updateShowSetting(slot0, slot1)
	slot0.showSettings = slot1
	slot0.settingDict = slot0:parseSetting(slot1)
end

function slot0.parseSetting(slot0, slot1)
	slot2 = {}

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			slot8 = string.split(slot7, "|")
			slot2[tonumber(slot8[1])] = slot8[2]
		end
	end

	return slot2
end

function slot0.makeSetting(slot0, slot1)
	slot2 = {}

	if slot1 then
		for slot6, slot7 in pairs(slot1) do
			table.insert(slot2, string.format("%s|%s", slot6, slot7))
		end
	end

	return slot2
end

function slot0.updateHeroCover(slot0, slot1)
	slot0.heroCover = slot1
end

function slot0.getPlayerInfo(slot0)
	if not slot0.playerInfo and slot0:isSelf() then
		slot1 = PlayerModel.instance:getPlayinfo()
	end

	return slot1
end

function slot0.isSelf(slot0)
	return PlayerModel.instance:isPlayerSelf(slot0.userId)
end

function slot0.getLayoutData(slot0)
	slot2 = {}

	if GameUtil.splitString2(slot0.settingDict[PlayerCardEnum.SettingKey.RightLayout], true, "&", "_") then
		for slot7, slot8 in ipairs(slot3) do
			slot2[slot8[1]] = slot8[2]
		end
	end

	return slot2
end

function slot0.getCardData(slot0)
	if string.nilorempty(slot0.settingDict[PlayerCardEnum.SettingKey.CardShow]) then
		slot1 = "1#2#3"
	end

	return string.splitToNumber(slot1, "#")
end

function slot0.getSetting(slot0, slot1)
	slot2 = slot0:parseSetting(slot0.showSettings)

	if slot1 then
		for slot6, slot7 in pairs(slot1) do
			slot2[slot6] = slot7
		end
	end

	return slot0:makeSetting(slot2)
end

function slot0.getMainHero(slot0, slot1)
	slot3 = string.splitToNumber(slot0.heroCover, "#")
	slot5 = slot3[2]
	slot6 = slot3[3] ~= 0

	if slot3[1] == -1 then
		if slot1 or not slot0._tempHeroId or not slot0._tempSkinId then
			slot8 = HeroModel.instance:getList()

			if slot8[math.random(#slot8)] then
				slot10 = {
					slot9.config.skinId
				}

				for slot14, slot15 in ipairs(slot9.skinInfoList) do
					table.insert(slot10, slot15.skin)
				end

				slot0._tempHeroId = slot9.heroId
				slot0._tempSkinId = slot10[math.random(#slot10)]
			end
		end

		return slot0._tempHeroId, slot0._tempSkinId, true, slot6
	else
		if not slot4 or slot4 == 0 or not HeroConfig.instance:getHeroCO(slot4) then
			slot4 = slot0:getDefaultHeroId()
			slot5 = nil
		end

		if (not slot5 or slot5 == 0) and slot4 and slot4 ~= 0 then
			slot5 = HeroConfig.instance:getHeroCO(slot4) and slot8.skinId
		end

		slot0._tempHeroId = slot4
		slot0._tempSkinId = slot5
	end

	return slot4, slot5, slot7, slot6
end

function slot0.getDefaultHeroId(slot0)
	if slot0:isSelf() then
		return CharacterSwitchListModel.instance:getMainHero()
	else
		return 3028
	end
end

function slot0.getThemeId(slot0)
	if not PlayerCardConfig.instance:getCardThemeConfig(slot0.themeId) then
		slot1 = 1
	end

	return slot1
end

return slot0
