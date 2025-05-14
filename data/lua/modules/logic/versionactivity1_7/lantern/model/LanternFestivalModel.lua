module("modules.logic.versionactivity1_7.lantern.model.LanternFestivalModel", package.seeall)

local var_0_0 = class("LanternFestivalModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._loginCount = 0
	arg_2_0._puzzleInfos = {}
end

function var_0_0.setActivity154Infos(arg_3_0, arg_3_1)
	arg_3_0._loginCount = arg_3_1.loginCount
	arg_3_0._puzzleInfos = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.infos) do
		local var_3_0 = LanternFestivalPuzzleMo.New()

		var_3_0:init(iter_3_1)

		arg_3_0._puzzleInfos[iter_3_1.puzzleId] = var_3_0
	end
end

function var_0_0.getLoginCount(arg_4_0)
	return arg_4_0._loginCount
end

function var_0_0.getPuzzleInfo(arg_5_0, arg_5_1)
	return arg_5_0._puzzleInfos[arg_5_1]
end

function var_0_0.updatePuzzleInfo(arg_6_0, arg_6_1)
	if arg_6_0._puzzleInfos[arg_6_1.puzzleId] then
		arg_6_0._puzzleInfos[arg_6_1.puzzleId]:reset(arg_6_1)
	else
		local var_6_0 = LanternFestivalPuzzleMo.New()

		var_6_0:init(arg_6_1)

		arg_6_0._puzzleInfos[arg_6_1.puzzleId] = var_6_0
	end
end

function var_0_0.isPuzzleUnlock(arg_7_0, arg_7_1)
	return arg_7_0._puzzleInfos[arg_7_1].state ~= LanternFestivalEnum.PuzzleState.Lock
end

function var_0_0.isPuzzleGiftGet(arg_8_0, arg_8_1)
	return arg_8_0._puzzleInfos[arg_8_1].state == LanternFestivalEnum.PuzzleState.RewardGet
end

function var_0_0.getPuzzleState(arg_9_0, arg_9_1)
	return arg_9_0._puzzleInfos[arg_9_1].state
end

function var_0_0.getPuzzleOptionState(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._puzzleInfos[arg_10_1].answerRecords) do
		if iter_10_1 == arg_10_2 then
			if LanternFestivalConfig.instance:getPuzzleCo(arg_10_1).answerId == arg_10_2 then
				return LanternFestivalEnum.OptionState.Right
			else
				return LanternFestivalEnum.OptionState.Wrong
			end
		end
	end

	return LanternFestivalEnum.OptionState.UnAnswer
end

function var_0_0.getCurPuzzleId(arg_11_0)
	if not arg_11_0._curPuzzleId or arg_11_0._curPuzzleId == 0 then
		local var_11_0 = arg_11_0._loginCount > 5 and 5 or arg_11_0._loginCount

		arg_11_0._curPuzzleId = LanternFestivalConfig.instance:getAct154Co(nil, var_11_0).puzzleId

		local var_11_1 = 0

		for iter_11_0, iter_11_1 in pairs(arg_11_0._puzzleInfos) do
			if iter_11_1.state == LanternFestivalEnum.PuzzleState.Solved or iter_11_1.state == LanternFestivalEnum.PuzzleState.RewardGet then
				var_11_1 = var_11_1 > iter_11_1.puzzleId and var_11_1 or iter_11_1.puzzleId
			end
		end

		if var_11_1 > 0 then
			arg_11_0._curPuzzleId = var_11_1
		end
	end

	return arg_11_0._curPuzzleId
end

function var_0_0.setCurPuzzleId(arg_12_0, arg_12_1)
	arg_12_0._curPuzzleId = arg_12_1
end

function var_0_0.hasPuzzleCouldGetReward(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0._puzzleInfos) do
		if iter_13_1.state ~= LanternFestivalEnum.PuzzleState.Lock and iter_13_1.state ~= LanternFestivalEnum.PuzzleState.RewardGet then
			return true
		end
	end

	return false
end

function var_0_0.isAllPuzzleFinished(arg_14_0)
	local var_14_0 = LanternFestivalConfig.instance:getAct154Cos()

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		if not arg_14_0:isPuzzleGiftGet(iter_14_1.puzzleId) then
			return false
		end
	end

	return true
end

function var_0_0.isAllPuzzleUnSolved(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0._puzzleInfos) do
		if iter_15_1.state == LanternFestivalEnum.PuzzleState.Solved or iter_15_1.state == LanternFestivalEnum.PuzzleState.RewardGet then
			return false
		end
	end

	return true
end

var_0_0.instance = var_0_0.New()

return var_0_0
