module("modules.logic.fight.entity.comp.skill.FightTLEvent500MMonsterRefreshHeadIcon", package.seeall)

local var_0_0 = class("FightTLEvent500MMonsterRefreshHeadIcon", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_1.actEffect

	if not var_1_0 then
		logError("FightTLEvent500MMonsterRefreshHeadIcon:onTrackStart effectList is nil")

		return
	end

	local var_1_1

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if iter_1_1.effectType == FightEnum.EffectType.MONSTERCHANGE then
			local var_1_2 = iter_1_1.entity

			var_1_1 = var_1_2 and var_1_2.modelId

			break
		end
	end

	if not var_1_1 then
		logError("FightTLEvent500MMonsterRefreshHeadIcon:onTrackStart modelId is nil")

		return
	end

	FightController.instance:dispatchEvent(FightEvent.RefreshSpineHeadIcon, var_1_1)
end

function var_0_0.onTrackEnd(arg_2_0)
	return
end

return var_0_0
