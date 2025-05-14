module("modules.logic.versionactivity2_2.lopera.model.Activity168Model", package.seeall)

local var_0_0 = class("Activity168Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._passEpisodes = {}
	arg_1_0._unlockEpisodes = {}
	arg_1_0._episodeDatas = {}
	arg_1_0._itemDatas = {}
	arg_1_0._unLockCount = 0
	arg_1_0._finishedCount = 0
	arg_1_0._curActionPoint = 0
	arg_1_0._curGameState = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._passEpisodes = {}
	arg_2_0._unlockEpisodes = {}
	arg_2_0._episodeDatas = {}
	arg_2_0._itemDatas = {}
	arg_2_0._unLockCount = 0
	arg_2_0._finishedCount = 0
	arg_2_0._curActionPoint = 0
	arg_2_0._curGameState = nil
end

function var_0_0.setCurActId(arg_3_0, arg_3_1)
	arg_3_0._curActId = arg_3_1
end

function var_0_0.getCurActId(arg_4_0)
	return arg_4_0._curActId
end

function var_0_0.setCurEpisodeId(arg_5_0, arg_5_1)
	arg_5_0._curEpisodeId = arg_5_1
end

function var_0_0.getCurEpisodeId(arg_6_0)
	return arg_6_0._curEpisodeId
end

function var_0_0.setCurBattleEpisodeId(arg_7_0, arg_7_1)
	arg_7_0._curBattleEpisodeId = arg_7_1
end

function var_0_0.getCurBattleEpisodeId(arg_8_0)
	return arg_8_0._curBattleEpisodeId
end

function var_0_0.setCurActionPoint(arg_9_0, arg_9_1)
	arg_9_0._curActionPoint = arg_9_1
end

function var_0_0.getCurActionPoint(arg_10_0)
	return arg_10_0._curActionPoint
end

function var_0_0.setCurGameState(arg_11_0, arg_11_1)
	arg_11_0._curGameState = arg_11_1
end

function var_0_0.getCurGameState(arg_12_0)
	return arg_12_0._curGameState
end

function var_0_0.isEpisodeFinish(arg_13_0, arg_13_1)
	return arg_13_0._passEpisodes[arg_13_1]
end

function var_0_0.onGetActInfoReply(arg_14_0, arg_14_1)
	arg_14_0._unLockCount = 0
	arg_14_0._finishedCount = 0

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		local var_14_0 = iter_14_1.episodeId

		arg_14_0._episodeDatas[var_14_0] = iter_14_1
		arg_14_0._unlockEpisodes[var_14_0] = true
		arg_14_0._unLockCount = arg_14_0._unLockCount + 1

		if iter_14_1.isFinished then
			arg_14_0._passEpisodes[var_14_0] = true
			arg_14_0._finishedCount = arg_14_0._finishedCount + 1
		end

		if iter_14_1.act168Game then
			arg_14_0:onItemInfoUpdate(var_14_0, iter_14_1.act168Game.act168Items)
		end
	end
end

function var_0_0.onEpisodeInfoUpdate(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.episodeId

	arg_15_0._episodeDatas[var_15_0] = arg_15_1

	if not arg_15_0._passEpisodes[var_15_0] and arg_15_1.isFinished then
		arg_15_0._passEpisodes[var_15_0] = true
		arg_15_0._finishedCount = arg_15_0._finishedCount + 1
	end

	if not arg_15_0._unlockEpisodes[var_15_0] then
		arg_15_0._unlockEpisodes[var_15_0] = true
		arg_15_0._unLockCount = arg_15_0._unLockCount + 1
	end

	if arg_15_1.act168Game then
		arg_15_0:onItemInfoUpdate(var_15_0, arg_15_1.act168Game.act168Items)
	end
end

function var_0_0.getUnlockCount(arg_16_0)
	return arg_16_0._unLockCount and arg_16_0._unLockCount or 10
end

function var_0_0.getFinishedCount(arg_17_0)
	return arg_17_0._finishedCount
end

function var_0_0.isEpisodeUnlock(arg_18_0, arg_18_1)
	return arg_18_0._unlockEpisodes[arg_18_1]
end

function var_0_0.isEpisodeFinished(arg_19_0, arg_19_1)
	return arg_19_0._passEpisodes[arg_19_1]
end

function var_0_0.getEpisodeData(arg_20_0, arg_20_1)
	return arg_20_0._episodeDatas[arg_20_1]
end

function var_0_0.getCurMoveCost(arg_21_0, arg_21_1)
	arg_21_1 = arg_21_1 or 1

	local var_21_0 = arg_21_0:getCurGameState()
	local var_21_1 = var_21_0 and var_21_0.buffs

	if var_21_1 then
		for iter_21_0, iter_21_1 in ipairs(var_21_1) do
			arg_21_1 = iter_21_1.ext + arg_21_1
		end
	end

	return arg_21_1
end

function var_0_0.clearEpisodeItemInfo(arg_22_0, arg_22_1)
	arg_22_0._itemDatas[arg_22_1] = {}
end

function var_0_0.onItemInfoUpdate(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	arg_23_0._itemChanged = arg_23_0._itemChanged or {}
	arg_23_0._itemDatas[arg_23_1] = arg_23_0._itemDatas[arg_23_1] or {}

	local var_23_0 = arg_23_0._itemDatas[arg_23_1]

	if arg_23_2 then
		for iter_23_0, iter_23_1 in ipairs(arg_23_2) do
			local var_23_1 = iter_23_1.itemId
			local var_23_2 = iter_23_1.count
			local var_23_3 = var_23_0[var_23_1] or 0

			var_23_0[var_23_1] = var_23_2

			if arg_23_4 then
				arg_23_0._itemChanged[var_23_1] = var_23_2 - var_23_3
			end
		end
	end

	if arg_23_3 then
		for iter_23_2, iter_23_3 in ipairs(arg_23_3) do
			local var_23_4 = iter_23_3.itemId

			if arg_23_4 then
				arg_23_0._itemChanged[var_23_4] = -iter_23_3.count
			end

			var_23_0[var_23_4] = 0
		end
	end
end

function var_0_0.getItemCount(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getCurEpisodeId()

	return arg_24_0._itemDatas[var_24_0] and arg_24_0._itemDatas[var_24_0][arg_24_1] or 0
end

function var_0_0.clearItemChangeDict(arg_25_0)
	arg_25_0._itemChanged = {}
end

function var_0_0.getItemChangeDict(arg_26_0)
	return arg_26_0._itemChanged
end

function var_0_0.getCurEpisodeItems(arg_27_0)
	local var_27_0 = arg_27_0:getCurEpisodeId()

	return arg_27_0._itemDatas[var_27_0]
end

var_0_0.instance = var_0_0.New()

return var_0_0
