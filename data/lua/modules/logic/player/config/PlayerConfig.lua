module("modules.logic.player.config.PlayerConfig", package.seeall)

slot0 = class("PlayerConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0.playconfig = nil
	slot0._clothSkillDict = nil
	slot0.playerClothConfig = nil
	slot0.playerBgDict = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"player_level",
		"cloth",
		"cloth_level",
		"player_bg"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "player_level" then
		slot0.playconfig = slot2
	elseif slot1 == "cloth_level" then
		slot0._clothSkillDict = {}

		for slot6, slot7 in ipairs(slot2.configList) do
			slot0:_initClothSkill(slot7, 1)
			slot0:_initClothSkill(slot7, 2)
			slot0:_initClothSkill(slot7, 3)
		end
	elseif slot1 == "cloth" then
		slot0.playerClothConfig = slot2

		slot0:buildPlayerConfigRare()
	elseif slot1 == "player_bg" then
		slot0.playerBgDict = {}

		for slot6, slot7 in ipairs(slot2.configList) do
			slot0.playerBgDict[slot7.item] = slot7
		end
	end
end

function slot0.buildPlayerConfigRare(slot0)
	if not slot0.playerClothConfig then
		return
	end

	for slot6, slot7 in ipairs(lua_cloth.configList) do
		setmetatable(slot7, {
			__index = function (slot0, slot1)
				if slot1 == "rare" then
					return 5
				end

				return uv0.__index(slot0, slot1)
			end,
			__newindex = getmetatable(lua_cloth.configList[1]).__newindex
		})
	end
end

function slot0.getBgCo(slot0, slot1)
	return slot0.playerBgDict[slot1]
end

function slot0._initClothSkill(slot0, slot1, slot2)
	slot3 = slot1.id
	slot4 = slot1.level

	if slot1["skill" .. slot2] and slot5 > 0 then
		if not slot0._clothSkillDict[slot3] then
			slot0._clothSkillDict[slot3] = {}
		end

		if not slot0._clothSkillDict[slot3][slot2] then
			slot0._clothSkillDict[slot3][slot2] = {
				slot5,
				slot4
			}
		end
	end
end

function slot0.getPlayerLevelCO(slot0, slot1)
	return slot0.playconfig.configDict[slot1]
end

function slot0.getPlayerClothConfig(slot0, slot1)
	return slot0.playerClothConfig.configDict[slot1]
end

function slot0.getClothSkill(slot0, slot1, slot2)
	if slot0._clothSkillDict and slot0._clothSkillDict[slot1] then
		return slot3[slot2]
	end
end

slot0.instance = slot0.New()

return slot0
