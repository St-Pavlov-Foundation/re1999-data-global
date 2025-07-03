module("modules.logic.fight.model.mo.FightCardInfoMO", package.seeall)

local var_0_0 = pureTable("FightCardInfoMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.custom_lock = nil
	arg_1_0.custom_enemyCardIndex = nil
	arg_1_0.custom_playedCard = nil
	arg_1_0.custom_handCardIndex = nil
	arg_1_0.custom_color = FightEnum.CardColor.None
	arg_1_0.custom_fromSkillId = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.uid = arg_2_1.uid
	arg_2_0.skillId = arg_2_1.skillId
	arg_2_0.cardEffect = arg_2_1.cardEffect or 0
	arg_2_0.tempCard = arg_2_1.tempCard or false
	arg_2_0.enchants = {}

	if arg_2_1.enchants then
		for iter_2_0, iter_2_1 in ipairs(arg_2_1.enchants) do
			local var_2_0 = {
				enchantId = iter_2_1.enchantId,
				duration = iter_2_1.duration,
				exInfo = {}
			}

			for iter_2_2, iter_2_3 in ipairs(iter_2_1.exInfo) do
				table.insert(var_2_0.exInfo, iter_2_3)
			end

			table.insert(arg_2_0.enchants, var_2_0)
		end
	end

	arg_2_0.cardType = arg_2_1.cardType or FightEnum.CardType.NONE
	arg_2_0.heroId = arg_2_1.heroId or 0
	arg_2_0.status = arg_2_1.status or FightEnum.CardInfoStatus.STATUS_NONE
	arg_2_0.targetUid = arg_2_1.targetUid or "0"
	arg_2_0.energy = arg_2_1.energy or 0
	arg_2_0.areaRedOrBlue = arg_2_1.areaRedOrBlue
	arg_2_0.heatId = arg_2_1.heatId or 0
end

function var_0_0.isBigSkill(arg_3_0)
	return FightCardDataHelper.isBigSkill(arg_3_0.skillId)
end

function var_0_0.clone(arg_4_0)
	local var_4_0 = var_0_0.New()

	var_4_0:init(arg_4_0)

	return var_4_0
end

return var_0_0
