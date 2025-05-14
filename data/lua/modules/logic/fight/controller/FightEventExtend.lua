module("modules.logic.fight.controller.FightEventExtend", package.seeall)

local var_0_0 = class("FightEventExtend")

function var_0_0.addConstEvents(arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnStageChange, arg_1_0._onStageChange, arg_1_0)
end

function var_0_0._onStageChange(arg_2_0, arg_2_1)
	if arg_2_1 ~= FightEnum.Stage.Card then
		return
	end

	local var_2_0 = FightCardModel.instance:getHandCards()

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_1 = FightDataHelper.entityMgr:getById(iter_2_1.uid)

		if var_2_1 and FightConfig:isUniqueSkill(iter_2_1.skillId, var_2_1.modelId) then
			FightController.instance:dispatchEvent(FightEvent.OnGuideGetUniqueCard)

			return
		end
	end
end

return var_0_0
