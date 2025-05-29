module("modules.logic.versionactivity2_6.dicehero.controller.DiceHeroHelper", package.seeall)

local var_0_0 = class("DiceHeroHelper")

function var_0_0.ctor(arg_1_0)
	arg_1_0._entityDict = {}
	arg_1_0._cardDict = {}
	arg_1_0._diceDict = {}
	arg_1_0._diceTextureDict = {}
	arg_1_0._effectItem = nil
	arg_1_0._effectPool = {}
	arg_1_0.flow = nil
	arg_1_0.afterFlow = nil
end

function var_0_0.buildFlow(arg_2_0, arg_2_1)
	local var_2_0 = FlowSequence.New()

	var_2_0:addWork(DiceHeroFirstStepWork.New())

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_1 = DiceHeroFightStepMo.New()

		var_2_1:init(iter_2_1)

		local var_2_2 = FlowParallel.New()

		var_2_2:addWork(DiceHeroActionWork.New(var_2_1))

		local var_2_3 = FlowSequence.New()

		for iter_2_2, iter_2_3 in ipairs(var_2_1.effect) do
			local var_2_4 = iter_2_3.effectType
			local var_2_5 = DiceHeroEnum.FightEffectTypeToName[var_2_4] or ""
			local var_2_6 = _G[string.format("DiceHero%sWork", var_2_5)]

			if var_2_6 then
				var_2_3:addWork(var_2_6.New(iter_2_3))
			end
		end

		var_2_2:addWork(var_2_3)
		var_2_0:addWork(var_2_2)
	end

	return var_2_0
end

function var_0_0.startFlow(arg_3_0, arg_3_1)
	if arg_3_0.flow then
		logError("已有Flow执行中")
	end

	arg_3_0.flow = arg_3_1

	arg_3_0.flow:registerDoneListener(arg_3_0.flowDone, arg_3_0)
	arg_3_0.flow:start()
end

function var_0_0.flowDone(arg_4_0)
	arg_4_0.flow = nil

	DiceHeroFightModel.instance:getGameData():onStepEnd()
	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.StepEnd)

	if DiceHeroFightModel.instance.finishResult ~= DiceHeroEnum.GameStatu.None then
		ViewMgr.instance:openView(ViewName.DiceHeroResultView, {
			status = DiceHeroFightModel.instance.finishResult
		})
		DiceHeroStatHelper.instance:sendFightEnd(DiceHeroFightModel.instance.finishResult, DiceHeroFightModel.instance.isFirstWin)

		DiceHeroFightModel.instance.finishResult = DiceHeroEnum.GameStatu.None
	end
end

function var_0_0.isInFlow(arg_5_0)
	return arg_5_0.flow ~= nil
end

function var_0_0.isNotInFlow(arg_6_0)
	return not arg_6_0:isInFlow()
end

function var_0_0.isShowCarNum(arg_7_0, arg_7_1)
	return arg_7_1 == DiceHeroEnum.SkillEffectType.Damage1 or arg_7_1 == DiceHeroEnum.SkillEffectType.Damage2 or arg_7_1 == DiceHeroEnum.SkillEffectType.ChangeShield1 or arg_7_1 == DiceHeroEnum.SkillEffectType.ChangeShield2 or arg_7_1 == DiceHeroEnum.SkillEffectType.ChangePower1 or arg_7_1 == DiceHeroEnum.SkillEffectType.ChangePower2
end

function var_0_0.setEffectItem(arg_8_0, arg_8_1)
	arg_8_0._effectItem = arg_8_1
end

function var_0_0.doEffect(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = table.remove(arg_9_0._effectPool)

	if not var_9_0 then
		local var_9_1 = gohelper.cloneInPlace(arg_9_0._effectItem)

		var_9_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_1, DiceHeroEffectItem)
	end

	gohelper.setActive(var_9_0.go, true)
	var_9_0:initData(arg_9_1, arg_9_2, arg_9_3, arg_9_4)

	return var_9_0
end

function var_0_0.returnEffectItemToPool(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_1.go, false)
	table.insert(arg_10_0._effectPool, arg_10_1)
end

function var_0_0.registerEntity(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._entityDict[arg_11_1] = arg_11_2
end

function var_0_0.unregisterEntity(arg_12_0, arg_12_1)
	arg_12_0._entityDict[arg_12_1] = nil
end

function var_0_0.getEntity(arg_13_0, arg_13_1)
	return arg_13_0._entityDict[arg_13_1]
end

function var_0_0.registerCard(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._cardDict[arg_14_1] = arg_14_2
end

function var_0_0.unregisterCard(arg_15_0, arg_15_1)
	arg_15_0._cardDict[arg_15_1] = nil
end

function var_0_0.getCard(arg_16_0, arg_16_1)
	return arg_16_0._cardDict[arg_16_1]
end

function var_0_0.registerDice(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._diceDict[arg_17_1] = arg_17_2
end

function var_0_0.unregisterDice(arg_18_0, arg_18_1)
	arg_18_0._diceDict[arg_18_1] = nil
end

function var_0_0.getDice(arg_19_0, arg_19_1)
	return arg_19_0._diceDict[arg_19_1]
end

function var_0_0.checkChapter(arg_20_0, arg_20_1)
	return tostring(arg_20_1) == tostring(DiceHeroModel.instance.guideChapter)
end

function var_0_0.checkLevel(arg_21_0, arg_21_1)
	return tostring(arg_21_1) == tostring(DiceHeroModel.instance.guideLevel)
end

function var_0_0.setDiceTexture(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0._diceTextureDict[arg_22_1] = arg_22_2
end

function var_0_0.getDiceTexture(arg_23_0, arg_23_1)
	return arg_23_0._diceTextureDict[arg_23_1]
end

function var_0_0.clear(arg_24_0)
	if arg_24_0.flow then
		arg_24_0.flow:onDestroyInternal()

		arg_24_0.flow = nil
	end

	if arg_24_0.afterFlow then
		arg_24_0.afterFlow:onDestroyInternal()

		arg_24_0.afterFlow = nil
	end

	arg_24_0._entityDict = {}
	arg_24_0._cardDict = {}
	arg_24_0._diceDict = {}
	arg_24_0._diceTextureDict = {}
	arg_24_0._effectItem = nil
	arg_24_0._effectPool = {}
end

var_0_0.instance = var_0_0.New()

return var_0_0
