module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroUpdateSkillCardWork", package.seeall)

local var_0_0 = class("DiceHeroUpdateSkillCardWork", DiceHeroBaseEffectWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in pairs(DiceHeroHelper.instance._cardDict) do
		iter_1_1:playRefreshAnim()
	end

	TaskDispatcher.runDelay(arg_1_0._delayRefreshCard, arg_1_0, 0.167)
end

function var_0_0._delayRefreshCard(arg_2_0)
	local var_2_0 = DiceHeroFightModel.instance:getGameData()

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._effectMo.skillCards) do
		local var_2_1 = var_2_0:getCardMoBySkillId(iter_2_1.skillId)

		if var_2_1 then
			var_2_1:init(iter_2_1)
		end
	end

	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._delayRefreshCard, arg_3_0)
end

return var_0_0
