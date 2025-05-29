module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightData", package.seeall)

local var_0_0 = class("DiceHeroFightData")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:init(arg_1_1)
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.round = arg_2_1.round
	arg_2_0.status = arg_2_1.status
	arg_2_0.allyHero = DiceHeroFightEntityMo.New()

	arg_2_0.allyHero:init(arg_2_1.allyHero)

	if arg_2_0.allyHero.id ~= 0 then
		arg_2_0.allyHero.co = lua_dice_character.configDict[arg_2_0.allyHero.id]
	end

	arg_2_0.enemyHeros = {}
	arg_2_0.enemyHerosByUid = arg_2_0.enemyHerosByUid or {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.enemyHeros) do
		arg_2_0.enemyHeros[iter_2_0] = arg_2_0.enemyHerosByUid[iter_2_1.uid] or DiceHeroFightEntityMo.New()

		arg_2_0.enemyHeros[iter_2_0]:init(iter_2_1)

		arg_2_0.enemyHerosByUid[iter_2_1.uid] = arg_2_0.enemyHeros[iter_2_0]

		arg_2_0.enemyHeros[iter_2_0]:clearBehavior()

		if arg_2_0.enemyHeros[iter_2_0].id ~= 0 then
			arg_2_0.enemyHeros[iter_2_0].co = lua_dice_enemy.configDict[arg_2_0.enemyHeros[iter_2_0].id]
		end
	end

	arg_2_0.enemyHerosByUid = {}

	for iter_2_2, iter_2_3 in pairs(arg_2_0.enemyHeros) do
		arg_2_0.enemyHerosByUid[iter_2_3.uid] = iter_2_3
	end

	arg_2_0.skillCards = {}
	arg_2_0.heroSkillCards = {}
	arg_2_0.skillCardsBySkillId = arg_2_0.skillCardsBySkillId or {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.skillCards) do
		local var_2_0 = arg_2_0.skillCardsBySkillId[iter_2_5.skillId] or DiceHeroFightSkillCardMo.New()

		var_2_0:init(iter_2_5, arg_2_0.round)

		arg_2_0.skillCardsBySkillId[iter_2_5.skillId] = var_2_0

		if var_2_0.co.type == DiceHeroEnum.CardType.Hero then
			table.insert(arg_2_0.heroSkillCards, var_2_0)
		else
			table.insert(arg_2_0.skillCards, var_2_0)
		end
	end

	arg_2_0.skillCardsBySkillId = {}

	for iter_2_6, iter_2_7 in pairs(arg_2_0.skillCards) do
		arg_2_0.skillCardsBySkillId[iter_2_7.skillId] = iter_2_7
	end

	for iter_2_8, iter_2_9 in pairs(arg_2_0.heroSkillCards) do
		arg_2_0.skillCardsBySkillId[iter_2_9.skillId] = iter_2_9
	end

	arg_2_0.allyHero:setSkills(arg_2_0.heroSkillCards)

	arg_2_0.diceBox = DiceHeroFightDiceBoxMo.New()

	arg_2_0.diceBox:init(arg_2_1.diceBox)

	arg_2_0.confirmed = arg_2_1.confirmed

	for iter_2_10, iter_2_11 in ipairs(arg_2_1.behaviors) do
		if arg_2_0.enemyHerosByUid[iter_2_11.fromId] then
			arg_2_0.enemyHerosByUid[iter_2_11.fromId]:addBehavior(iter_2_11, arg_2_0.allyHero.uid)
		end
	end

	arg_2_0.curSelectCardMo = nil
	arg_2_0.curSelectEnemyMo = nil

	for iter_2_12, iter_2_13 in ipairs(arg_2_0.skillCards) do
		iter_2_13:initMatchDices(arg_2_0.diceBox.dices, arg_2_0.allyHero:isMixDice())
	end

	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.SkillCardSelectChange)

	arg_2_0._autoSelectEnemyUid = arg_2_0._autoSelectEnemyUid
end

function var_0_0.setCurSelectCard(arg_3_0, arg_3_1)
	if arg_3_0.curSelectCardMo then
		arg_3_0.curSelectCardMo:clearSelects()
	end

	arg_3_0.curSelectEnemyMo = nil
	arg_3_0.curSelectCardMo = arg_3_1

	if arg_3_0.curSelectCardMo and arg_3_0.curSelectCardMo.co.aim1 == DiceHeroEnum.SkillCardTargetType.SingleEnemy then
		local var_3_0 = arg_3_0.enemyHerosByUid[arg_3_0._autoSelectEnemyUid]

		if not var_3_0 or var_3_0.hp <= 0 then
			arg_3_0._autoSelectEnemyUid = nil
			var_3_0 = nil
		else
			arg_3_0.curSelectEnemyMo = var_3_0
		end

		if not var_3_0 then
			for iter_3_0, iter_3_1 in ipairs(arg_3_0.enemyHeros) do
				if iter_3_1.hp > 0 then
					arg_3_0.curSelectEnemyMo = iter_3_1
					arg_3_0._autoSelectEnemyUid = iter_3_1.uid

					break
				end
			end
		end
	end

	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.SkillCardSelectChange)
end

function var_0_0.getCardMoBySkillId(arg_4_0, arg_4_1)
	return arg_4_0.skillCardsBySkillId[arg_4_1]
end

function var_0_0.onStepEnd(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.skillCards) do
		iter_5_1:initMatchDices(arg_5_0.diceBox.dices, arg_5_0.allyHero:isMixDice())
	end

	arg_5_0:setCurSelectCard(nil)
end

function var_0_0.setCurEnemy(arg_6_0, arg_6_1)
	if not arg_6_0.curSelectCardMo or arg_6_0.curSelectCardMo.co.aim1 ~= DiceHeroEnum.SkillCardTargetType.SingleEnemy then
		return
	end

	if arg_6_1 and arg_6_1.hp == 0 then
		return
	end

	arg_6_0.curSelectEnemyMo = arg_6_1
	arg_6_0._autoSelectEnemyUid = arg_6_1.uid

	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.EnemySelectChange)
end

return var_0_0
