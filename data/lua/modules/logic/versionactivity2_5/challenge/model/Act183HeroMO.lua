module("modules.logic.versionactivity2_5.challenge.model.Act183HeroMO", package.seeall)

local var_0_0 = pureTable("Act183HeroMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._heroId = tonumber(arg_1_1.heroId)
	arg_1_0._trialId = tonumber(arg_1_1.trialId)

	if arg_1_0._heroId and arg_1_0._heroId ~= 0 then
		arg_1_0._heroType = Act183Enum.HeroType.Normal
		arg_1_0._heroMo = HeroModel.instance:getByHeroId(arg_1_0._heroId)
	elseif arg_1_0._trialId and arg_1_0._trialId ~= 0 then
		arg_1_0._heroType = Act183Enum.HeroType.Trial
		arg_1_0._heroMo = HeroMo.New()

		arg_1_0._heroMo:initFromTrial(arg_1_0._trialId)
	else
		logError("角色唯一id和试用id都为0")
	end

	if not arg_1_0._heroMo then
		logError(string.format("角色数据不存在 heroId = %s, trialId = %s", arg_1_0._heroId, arg_1_0._trialId))
	end

	arg_1_0._config = arg_1_0._heroMo and arg_1_0._heroMo.config
	arg_1_0._type = arg_1_1.type
end

function var_0_0.getHeroMo(arg_2_0)
	return arg_2_0._heroMo
end

function var_0_0.getHeroType(arg_3_0)
	return arg_3_0._heroType
end

function var_0_0.getHeroIconUrl(arg_4_0)
	if arg_4_0._heroType == Act183Enum.HeroType.Normal then
		return ResUrl.getHeadIconSmall(arg_4_0._heroMo.skin)
	elseif arg_4_0._heroType == Act183Enum.HeroType.Trial then
		return ResUrl.getHeadIconSmall(arg_4_0._heroMo.skin)
	else
		logError("GetHeroIconUrl error")
	end
end

function var_0_0.getHeroCarrer(arg_5_0)
	return arg_5_0._config.career
end

function var_0_0.getHeroId(arg_6_0)
	return arg_6_0._heroMo and arg_6_0._heroMo.heroId
end

function var_0_0.isTeamLeader(arg_7_0)
	return arg_7_0._type == 1
end

return var_0_0
