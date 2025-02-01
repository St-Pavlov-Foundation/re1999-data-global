module("modules.logic.versionactivity2_2.eliminate.model.EliminateTeamSelectionModel", package.seeall)

slot0 = class("EliminateTeamSelectionModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._selectedEpisodeId = nil
	slot0._selectedCharacterId = nil
	slot0._episodeConfig = nil
	slot0._warEpisodeConfig = nil
	slot0._isPreset = nil
	slot0._presetCharacter = nil
	slot0._presetSoldierList = nil
	slot0._isRestart = false
end

function slot0.setRestart(slot0, slot1)
	slot0._isRestart = slot1
end

function slot0.getRestart(slot0)
	return slot0._isRestart
end

function slot0.setSelectedEpisodeId(slot0, slot1)
	slot0:setRestart(false)

	slot0._selectedEpisodeId = slot1
	slot0._episodeConfig = lua_eliminate_episode.configDict[slot1]
	slot0._warEpisodeConfig = lua_war_chess_episode.configDict[slot0._episodeConfig.warChessId]
	slot0._presetCharacter = nil
	slot0._presetSoldierList = nil
	slot0._isPreset = slot0._warEpisodeConfig.preset == 1

	if not slot0._isPreset then
		return
	end

	slot0._presetCharacter = slot0._warEpisodeConfig.presetCharacter
	slot0._rawPresetSoldier = slot0._warEpisodeConfig.presetSoldier
	slot0._presetSoldierList = {}

	for slot6, slot7 in ipairs(slot0._rawPresetSoldier) do
		slot0._presetSoldierList[slot7] = slot7
	end
end

function slot0.isPreset(slot0)
	return slot0._isPreset
end

function slot0.getPresetSoldier(slot0)
	return slot0._rawPresetSoldier
end

function slot0.getPresetCharacter(slot0)
	return slot0._presetCharacter
end

function slot0.isPresetCharacter(slot0, slot1)
	return slot0._isPreset and slot0._presetCharacter == slot1
end

function slot0.isPresetSoldier(slot0, slot1)
	return slot0._isPreset and slot0._presetSoldierList[slot1] ~= nil
end

function slot0.hasCharacterOrPreset(slot0, slot1)
	return slot0:isPresetCharacter(slot1) or EliminateOutsideModel.instance:hasCharacter(slot1)
end

function slot0.hasChessPieceOrPreset(slot0, slot1)
	return slot0:isPresetSoldier(slot1) or EliminateOutsideModel.instance:hasChessPiece(slot1)
end

function slot0.getSelectedEpisodeId(slot0)
	return slot0._selectedEpisodeId
end

function slot0.setSelectedCharacterId(slot0, slot1)
	slot0._selectedCharacterId = slot1
end

function slot0.getSelectedCharacterId(slot0)
	return slot0._selectedCharacterId
end

function slot0.getCharacterList(slot0)
	slot1 = tabletool.copy(lua_teamchess_character.configList)

	table.sort(slot1, function (slot0, slot1)
		if uv0.instance:hasCharacterOrPreset(slot0.id) == uv0.instance:hasCharacterOrPreset(slot1.id) then
			return slot0.id < slot1.id
		else
			return slot2
		end
	end)

	return slot1
end

slot0.instance = slot0.New()

return slot0
