module("modules.logic.versionactivity2_2.eliminate.model.EliminateTeamSelectionModel", package.seeall)

local var_0_0 = class("EliminateTeamSelectionModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._selectedEpisodeId = nil
	arg_2_0._selectedCharacterId = nil
	arg_2_0._episodeConfig = nil
	arg_2_0._warEpisodeConfig = nil
	arg_2_0._isPreset = nil
	arg_2_0._presetCharacter = nil
	arg_2_0._presetSoldierList = nil
	arg_2_0._isRestart = false
end

function var_0_0.setRestart(arg_3_0, arg_3_1)
	arg_3_0._isRestart = arg_3_1
end

function var_0_0.getRestart(arg_4_0)
	return arg_4_0._isRestart
end

function var_0_0.setSelectedEpisodeId(arg_5_0, arg_5_1)
	arg_5_0:setRestart(false)

	arg_5_0._selectedEpisodeId = arg_5_1
	arg_5_0._episodeConfig = lua_eliminate_episode.configDict[arg_5_1]

	local var_5_0 = arg_5_0._episodeConfig.warChessId

	arg_5_0._warEpisodeConfig = lua_war_chess_episode.configDict[var_5_0]
	arg_5_0._presetCharacter = nil
	arg_5_0._presetSoldierList = nil
	arg_5_0._isPreset = arg_5_0._warEpisodeConfig.preset == 1

	if not arg_5_0._isPreset then
		return
	end

	arg_5_0._presetCharacter = arg_5_0._warEpisodeConfig.presetCharacter
	arg_5_0._rawPresetSoldier = arg_5_0._warEpisodeConfig.presetSoldier
	arg_5_0._presetSoldierList = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._rawPresetSoldier) do
		arg_5_0._presetSoldierList[iter_5_1] = iter_5_1
	end
end

function var_0_0.isPreset(arg_6_0)
	return arg_6_0._isPreset
end

function var_0_0.getPresetSoldier(arg_7_0)
	return arg_7_0._rawPresetSoldier
end

function var_0_0.getPresetCharacter(arg_8_0)
	return arg_8_0._presetCharacter
end

function var_0_0.isPresetCharacter(arg_9_0, arg_9_1)
	return arg_9_0._isPreset and arg_9_0._presetCharacter == arg_9_1
end

function var_0_0.isPresetSoldier(arg_10_0, arg_10_1)
	return arg_10_0._isPreset and arg_10_0._presetSoldierList[arg_10_1] ~= nil
end

function var_0_0.hasCharacterOrPreset(arg_11_0, arg_11_1)
	return arg_11_0:isPresetCharacter(arg_11_1) or EliminateOutsideModel.instance:hasCharacter(arg_11_1)
end

function var_0_0.hasChessPieceOrPreset(arg_12_0, arg_12_1)
	return arg_12_0:isPresetSoldier(arg_12_1) or EliminateOutsideModel.instance:hasChessPiece(arg_12_1)
end

function var_0_0.getSelectedEpisodeId(arg_13_0)
	return arg_13_0._selectedEpisodeId
end

function var_0_0.setSelectedCharacterId(arg_14_0, arg_14_1)
	arg_14_0._selectedCharacterId = arg_14_1
end

function var_0_0.getSelectedCharacterId(arg_15_0)
	return arg_15_0._selectedCharacterId
end

function var_0_0.getCharacterList(arg_16_0)
	local var_16_0 = tabletool.copy(lua_teamchess_character.configList)

	table.sort(var_16_0, function(arg_17_0, arg_17_1)
		local var_17_0 = var_0_0.instance:hasCharacterOrPreset(arg_17_0.id)

		if var_17_0 == var_0_0.instance:hasCharacterOrPreset(arg_17_1.id) then
			return arg_17_0.id < arg_17_1.id
		else
			return var_17_0
		end
	end)

	return var_16_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
