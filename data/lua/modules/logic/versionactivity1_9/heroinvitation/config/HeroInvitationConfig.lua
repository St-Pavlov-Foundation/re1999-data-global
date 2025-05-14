module("modules.logic.versionactivity1_9.heroinvitation.config.HeroInvitationConfig", package.seeall)

local var_0_0 = class("HeroInvitationConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"hero_invitation"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "hero_invitation" then
		arg_3_0._roleStoryConfig = arg_3_2

		arg_3_0:initHeroInvitation()
	end
end

function var_0_0.initHeroInvitation(arg_4_0)
	arg_4_0._elementDict = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._roleStoryConfig.configList) do
		arg_4_0._elementDict[iter_4_1.elementId] = iter_4_1
	end
end

function var_0_0.getInvitationConfig(arg_5_0, arg_5_1)
	return arg_5_0._roleStoryConfig.configDict[arg_5_1]
end

function var_0_0.getInvitationList(arg_6_0)
	return arg_6_0._roleStoryConfig.configList
end

function var_0_0.getInvitationConfigByElementId(arg_7_0, arg_7_1)
	return arg_7_0._elementDict[arg_7_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
