module("modules.logic.rouge.map.model.rpcmo.RougeFightResultMO", package.seeall)

local var_0_0 = pureTable("RougeFightResultMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.addCoin = arg_1_1.addCoin
	arg_1_0.dropCollectionNum = arg_1_1.dropCollectionNum
	arg_1_0.dropSelectNum = arg_1_1.dropSelectNum
	arg_1_0.addExp = arg_1_1.addExp
	arg_1_0.isWin = arg_1_1.isWin
	arg_1_0.retryNum = arg_1_1.retryNum
	arg_1_0.season = arg_1_1.season

	RougeModel.instance:updateRetryNum(arg_1_0.retryNum)

	arg_1_0.battleHeroList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.teamInfo.battleHeroList) do
		table.insert(arg_1_0.battleHeroList, {
			index = iter_1_1.index,
			heroId = iter_1_1.heroId,
			equipUid = iter_1_1.equipUid,
			supportHeroId = iter_1_1.supportHeroId,
			supportHeroSkill = iter_1_1.supportHeroSkill
		})
	end

	arg_1_0.heroLifeMap = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.teamInfo.heroLifeList) do
		arg_1_0.heroLifeMap[iter_1_3.heroId] = iter_1_3.life
	end
end

function var_0_0.getLife(arg_2_0, arg_2_1)
	return arg_2_0.heroLifeMap[arg_2_1]
end

return var_0_0
