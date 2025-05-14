module("modules.logic.resonance.controller.HeroResonanceController", package.seeall)

local var_0_0 = class("HeroResonanceController", BaseController)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.statShareCode(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = {}

	if arg_2_1 and arg_2_1.talentCubeInfos and arg_2_1.talentCubeInfos.data_list then
		for iter_2_0, iter_2_1 in ipairs(arg_2_1.talentCubeInfos.data_list) do
			local var_2_1 = iter_2_1.cubeId
			local var_2_2 = arg_2_1.talentCubeInfos.own_main_cube_id

			if iter_2_1.cubeId == var_2_2 then
				var_2_1 = arg_2_1:getHeroUseStyleCubeId()
			end

			table.insert(var_2_0, var_2_1)
		end
	end

	arg_2_3 = arg_2_3 or HeroResonaceModel.instance:getShareCode() or ""

	local var_2_3 = arg_2_2 and StatEnum.EventName.TalentUseRuenCode or StatEnum.EventName.TalentCopyRuenCode

	StatController.instance:track(var_2_3, {
		[StatEnum.EventProperties.TalentShareCode] = arg_2_3,
		[StatEnum.EventProperties.HeroId] = arg_2_1.heroId,
		[StatEnum.EventProperties.HeroName] = arg_2_1.config.name,
		[StatEnum.EventProperties.TalentRuensStateGroup] = var_2_0
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
