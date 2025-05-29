module("modules.logic.versionactivity2_6.dicehero.model.DiceHeroModel", package.seeall)

local var_0_0 = class("DiceHeroModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.unlockChapterIds = {}
	arg_1_0.gameInfos = {}
	arg_1_0.guideChapter = 0
	arg_1_0.guideLevel = 0
	arg_1_0.isUnlockNewChapter = false
	arg_1_0.talkId = 0
	arg_1_0.stepId = 0
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.initInfo(arg_3_0, arg_3_1)
	arg_3_0.gameInfos = {}

	local var_3_0 = arg_3_0.unlockChapterIds

	arg_3_0.unlockChapterIds = {
		[1] = true
	}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.gameInfo) do
		arg_3_0.gameInfos[iter_3_1.chapter] = DiceHeroGameInfoMo.New()

		arg_3_0.gameInfos[iter_3_1.chapter]:init(iter_3_1)

		if arg_3_0.gameInfos[iter_3_1.chapter].allPass then
			arg_3_0.unlockChapterIds[iter_3_1.chapter + 1] = true
		end
	end

	arg_3_0.isUnlockNewChapter = #var_3_0 ~= #arg_3_0.unlockChapterIds

	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.InfoUpdate)
end

function var_0_0.getGameInfo(arg_4_0, arg_4_1)
	return arg_4_0.gameInfos[arg_4_1 or 1]
end

function var_0_0.hasReward(arg_5_0, arg_5_1)
	arg_5_1 = arg_5_1 or 1

	if not arg_5_0.gameInfos[arg_5_1] then
		return false
	end

	return arg_5_0.gameInfos[arg_5_1]:hasReward()
end

var_0_0.instance = var_0_0.New()

return var_0_0
