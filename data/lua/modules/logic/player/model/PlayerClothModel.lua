module("modules.logic.player.model.PlayerClothModel", package.seeall)

local var_0_0 = class("PlayerClothModel", ListScrollModel)

function var_0_0.onGetInfo(arg_1_0, arg_1_1)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(lua_cloth.configList) do
		local var_1_1 = PlayerClothMO.New()

		var_1_1:initFromConfig(iter_1_1)
		table.insert(var_1_0, var_1_1)
	end

	arg_1_0:setList(var_1_0)
	arg_1_0:updateInfo(arg_1_1)
end

function var_0_0.onPushInfo(arg_2_0, arg_2_1)
	arg_2_0:updateInfo(arg_2_1)
end

function var_0_0.updateInfo(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = arg_3_0:getById(iter_3_1.clothId)

		if var_3_0 then
			var_3_0:init(iter_3_1)
		else
			logError("服装配置不存在：" .. iter_3_1.clothId)
		end
	end
end

function var_0_0.hasCloth(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getById(arg_4_1)

	return var_4_0 and var_4_0.has
end

function var_0_0.isSatisfy(arg_5_0)
	local var_5_0 = string.splitToNumber(arg_5_0, "#")
	local var_5_1 = var_5_0[1]
	local var_5_2 = var_5_0[2]

	if var_5_1 and var_5_1 > 0 and var_5_1 > PlayerModel.instance:getPlayinfo().level then
		return false
	end

	if var_5_2 and var_5_2 > 0 then
		local var_5_3 = DungeonModel.instance:getEpisodeInfo(var_5_2)

		if not var_5_3 or var_5_3.star <= DungeonEnum.StarType.None then
			return false
		end
	end

	return true
end

function var_0_0.canUse(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:hasCloth(arg_6_1)
	local var_6_1 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill)

	return var_6_0 and var_6_1
end

function var_0_0.getSpEpisodeClothID(arg_7_0)
	local var_7_0 = HeroGroupModel.instance.episodeId or FightModel.instance:getFightParam() and FightModel.instance:getFightParam().episodeId

	if not var_7_0 then
		return nil
	end

	local var_7_1 = DungeonConfig.instance:getEpisodeCO(var_7_0)
	local var_7_2 = var_7_1 and lua_battle.configDict[var_7_1.battleId]

	if var_7_1.type == DungeonEnum.EpisodeType.Sp and var_7_2 and not string.nilorempty(var_7_2.clothSkill) then
		return string.splitToNumber(var_7_2.clothSkill, "#")[1]
	end

	return nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
