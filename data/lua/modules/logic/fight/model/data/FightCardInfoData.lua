module("modules.logic.fight.model.data.FightCardInfoData", package.seeall)

local var_0_0 = FightDataClass("FightCardInfoData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.skillId = arg_1_1.skillId
	arg_1_0.cardEffect = arg_1_1.cardEffect or 0
	arg_1_0.tempCard = arg_1_1.tempCard or false
	arg_1_0.enchants = {}

	if arg_1_1.enchants then
		for iter_1_0, iter_1_1 in ipairs(arg_1_1.enchants) do
			local var_1_0 = {
				enchantId = iter_1_1.enchantId,
				duration = iter_1_1.duration,
				exInfo = {}
			}

			for iter_1_2, iter_1_3 in ipairs(iter_1_1.exInfo) do
				table.insert(var_1_0.exInfo, iter_1_3)
			end

			table.insert(arg_1_0.enchants, var_1_0)
		end
	end

	arg_1_0.cardType = arg_1_1.cardType or FightEnum.CardType.NONE
	arg_1_0.heroId = arg_1_1.heroId or 0
	arg_1_0.status = arg_1_1.status or FightEnum.CardInfoStatus.STATUS_NONE
	arg_1_0.targetUid = arg_1_1.targetUid or "0"
	arg_1_0.energy = arg_1_1.energy or 0
	arg_1_0.areaRedOrBlue = arg_1_1.areaRedOrBlue
	arg_1_0.heatId = arg_1_1.heatId
end

function var_0_0.isUniqueSkill(arg_2_0)
	return FightCardModel.instance:isUniqueSkill(arg_2_0.targetUid, arg_2_0.skillId)
end

return var_0_0
