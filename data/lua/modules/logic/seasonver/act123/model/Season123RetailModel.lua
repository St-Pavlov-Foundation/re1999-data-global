module("modules.logic.seasonver.act123.model.Season123RetailModel", package.seeall)

local var_0_0 = class("Season123RetailModel", BaseModel)

function var_0_0.release(arg_1_0)
	arg_1_0.lastSendEpisodeCfg = nil
	arg_1_0.rewardIconCfgs = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.activityId = arg_2_1

	arg_2_0:initDatas()
	arg_2_0:initRewards()
end

function var_0_0.initDatas(arg_3_0)
	local var_3_0 = Season123Model.instance:getActInfo(arg_3_0.activityId)

	if not var_3_0 then
		return
	end

	arg_3_0.retailId = var_3_0.retailId

	if not arg_3_0.retailId then
		return
	end

	arg_3_0.retailCO = Season123Config.instance:getRetailCO(arg_3_0.activityId, arg_3_0.retailId)

	if not arg_3_0.retailCO then
		return
	end

	arg_3_0.episodeCO = DungeonConfig.instance:getEpisodeCO(arg_3_0.retailCO.episodeId)
end

function var_0_0.initRewards(arg_4_0)
	arg_4_0.rewardIcons = {}
	arg_4_0.rewardIconCfgs = {}

	if not arg_4_0.retailCO then
		return
	end

	local var_4_0 = GameUtil.splitString2(arg_4_0.retailCO.bonus, true, "|", "#")

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_1 = iter_4_1[1]
		local var_4_2 = iter_4_1[2]
		local var_4_3, var_4_4 = ItemModel.instance:getItemConfigAndIcon(var_4_1, var_4_2)

		table.insert(arg_4_0.rewardIconCfgs, iter_4_1)
		table.insert(arg_4_0.rewardIcons, var_4_4)
	end
end

function var_0_0.getRecommentLevel(arg_5_0)
	if not arg_5_0.episodeCO then
		return nil
	end

	local var_5_0 = arg_5_0.episodeCO.id
	local var_5_1 = DungeonConfig.instance:getEpisodeCO(var_5_0)
	local var_5_2 = FightHelper.getBattleRecommendLevel(var_5_1.battleId)

	if var_5_2 >= 0 then
		return var_5_2
	else
		return nil
	end
end

function var_0_0.getEpisodeId(arg_6_0)
	if not arg_6_0.episodeCO then
		return nil
	end

	return arg_6_0.episodeCO.id
end

function var_0_0.getRewards(arg_7_0)
	local var_7_0 = {}

	if not arg_7_0.episodeCO then
		return var_7_0
	end
end

function var_0_0.getUTTUTicketNum(arg_8_0)
	local var_8_0 = arg_8_0.activityId
	local var_8_1 = Season123Config.instance:getEquipItemCoin(var_8_0, Activity123Enum.Const.UttuTicketsCoin)

	if var_8_1 then
		local var_8_2 = CurrencyModel.instance:getCurrency(var_8_1)

		return var_8_2 and var_8_2.quantity or 0
	end

	return 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
