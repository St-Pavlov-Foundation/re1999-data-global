module("modules.logic.versionactivity2_2.eliminate.model.EliminateOutsideModel", package.seeall)

local var_0_0 = class("EliminateOutsideModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._selectedEpisodeId = nil
	arg_2_0._selectedCharacterId = nil
	arg_2_0._selectedPieceId = nil
	arg_2_0._totalStar = 0
	arg_2_0._gainedTaskId = {}
	arg_2_0._chapterList = {}
	arg_2_0._ownedWarChessCharacterId = {}
	arg_2_0._ownedWarChessPieceId = {}
	arg_2_0._episodeInfo = {}
end

function var_0_0.initTaskInfo(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._totalStar = arg_3_1
	arg_3_0._gainedTaskId = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		arg_3_0._gainedTaskId[iter_3_1] = iter_3_1
	end
end

function var_0_0.initMapInfo(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0._ownedWarChessCharacterId = {}
	arg_4_0._ownedWarChessPieceId = {}
	arg_4_0._episodeInfo = {}
	arg_4_0._unlockSlotNum = #arg_4_4

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0._ownedWarChessCharacterId[iter_4_1] = iter_4_1
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_2) do
		arg_4_0._ownedWarChessPieceId[iter_4_3] = iter_4_3
	end

	for iter_4_4, iter_4_5 in ipairs(arg_4_3) do
		local var_4_0 = arg_4_0._episodeInfo[iter_4_5.id] or WarEpisodeInfo.New()

		var_4_0:init(iter_4_5)

		arg_4_0._episodeInfo[iter_4_5.id] = var_4_0
	end

	arg_4_0:_initChapterList()
	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.OnUpdateEpisodeInfo)
end

function var_0_0._initChapterList(arg_5_0)
	arg_5_0._chapterList = {}

	for iter_5_0, iter_5_1 in ipairs(lua_eliminate_episode.configList) do
		local var_5_0 = arg_5_0._chapterList[iter_5_1.chapterId] or {}

		arg_5_0._chapterList[iter_5_1.chapterId] = var_5_0

		local var_5_1 = arg_5_0._episodeInfo[iter_5_1.id] or WarEpisodeInfo.New()

		var_5_1:initFromParam(iter_5_1.id, var_5_1.star or 0)

		arg_5_0._episodeInfo[var_5_1.id] = var_5_1

		table.insert(var_5_0, var_5_1)
	end
end

function var_0_0.getChapterList(arg_6_0)
	return arg_6_0._chapterList
end

function var_0_0.getUnlockSlotNum(arg_7_0)
	return arg_7_0._unlockSlotNum
end

function var_0_0.getTotalStar(arg_8_0)
	return arg_8_0._totalStar
end

function var_0_0.addGainedTask(arg_9_0, arg_9_1)
	if arg_9_1 == 0 then
		for iter_9_0, iter_9_1 in ipairs(lua_eliminate_reward.configList) do
			if arg_9_0._totalStar >= iter_9_1.star then
				arg_9_0._gainedTaskId[iter_9_1.id] = iter_9_1.id
			end
		end

		return
	end

	arg_9_0._gainedTaskId[arg_9_1] = arg_9_1
end

function var_0_0.gainedTask(arg_10_0, arg_10_1)
	return arg_10_0._gainedTaskId[arg_10_1] ~= nil
end

function var_0_0.hasCharacter(arg_11_0, arg_11_1)
	return arg_11_0._ownedWarChessCharacterId[arg_11_1] ~= nil
end

function var_0_0.hasChessPiece(arg_12_0, arg_12_1)
	return arg_12_0._ownedWarChessPieceId[arg_12_1] ~= nil
end

function var_0_0.hasPassedEpisode(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._episodeInfo[arg_13_1]

	return var_13_0 and var_13_0.star > 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
