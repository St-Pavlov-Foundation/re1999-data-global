module("modules.logic.explore.model.mo.ExploreChapterSimpleMo", package.seeall)

local var_0_0 = pureTable("ExploreChapterSimpleMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.archiveIds = {}
	arg_1_0.bonusScene = {}
	arg_1_0.isFinish = false
end

function var_0_0.init(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.archiveIds) do
		arg_2_0.archiveIds[iter_2_1] = true
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.bonusScene) do
		arg_2_0.bonusScene[iter_2_3.bonusSceneId] = iter_2_3.options
	end

	arg_2_0.isFinish = arg_2_1.isFinish
end

function var_0_0.onGetArchive(arg_3_0, arg_3_1)
	arg_3_0.archiveIds[arg_3_1] = true
end

function var_0_0.onGetBonus(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.bonusScene[arg_4_1] = arg_4_2
end

function var_0_0.haveBonusScene(arg_5_0)
	return next(arg_5_0.bonusScene) and true or false
end

return var_0_0
