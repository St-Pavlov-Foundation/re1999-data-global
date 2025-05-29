module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroGameView", package.seeall)

local var_0_0 = class("DiceHeroGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._anim = gohelper.findChildAnim(arg_1_0.viewGO, "")
	arg_1_0._godice = gohelper.findChild(arg_1_0.viewGO, "#go_dice")
	arg_1_0._maskAnim = gohelper.findChildAnim(arg_1_0.viewGO, "#simage_mask")
	arg_1_0._gocard = gohelper.findChild(arg_1_0.viewGO, "#go_card/item")
	arg_1_0._goenemy = gohelper.findChild(arg_1_0.viewGO, "#go_enemy/#go_item")
	arg_1_0._gohero = gohelper.findChild(arg_1_0.viewGO, "#go_hero")
	arg_1_0._curRound = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_target/roundbg/anim/curround/#txt_curround")
	arg_1_0._txttarget = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_target/#go_tasklist/#go_taskitem/txt_desc")
	arg_1_0._damageEffectHero = gohelper.findChild(arg_1_0.viewGO, "#screeneff_attack/hero")
	arg_1_0._damageEffectEnemy = gohelper.findChild(arg_1_0.viewGO, "#screeneff_attack/enemy")

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "#go_texture_ref")

	if var_1_0 then
		local var_1_1 = var_1_0.transform

		for iter_1_0 = 0, var_1_1.childCount - 1 do
			local var_1_2 = var_1_1:GetChild(iter_1_0)
			local var_1_3 = var_1_2.gameObject:GetComponent(gohelper.Type_RawImage)

			if var_1_3 then
				DiceHeroHelper.instance:setDiceTexture(var_1_2.name, var_1_3.texture)
			end
		end
	end
end

function var_0_0.addEvents(arg_2_0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.RoundEnd, arg_2_0.beginRound, arg_2_0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.ConfirmDice, arg_2_0.confirmDice, arg_2_0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.OnDamage, arg_2_0.onDamageEffect, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.RoundEnd, arg_3_0.beginRound, arg_3_0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.ConfirmDice, arg_3_0.confirmDice, arg_3_0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.OnDamage, arg_3_0.onDamageEffect, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	gohelper.setActive(arg_4_0._maskAnim, true)

	local var_4_0 = arg_4_0.viewContainer._viewSetting.otherRes.roleinfoitem
	local var_4_1 = arg_4_0.viewContainer._viewSetting.otherRes.effect
	local var_4_2 = arg_4_0:getResInst(var_4_1, arg_4_0.viewGO)

	gohelper.setActive(var_4_2, false)
	DiceHeroHelper.instance:setEffectItem(var_4_2)

	arg_4_0._diceBox = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._godice, DiceHeroDiceBoxItem, arg_4_0)

	local var_4_3 = arg_4_0:getResInst(var_4_0, arg_4_0._gohero)

	arg_4_0._hero = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_3, DiceHeroHeroItem)
	arg_4_0._txttarget.text = luaLang("dicehero_target")

	arg_4_0:refreshCards()
	arg_4_0:refreshEnemys()
	arg_4_0:beginRound()
end

function var_0_0.onUpdateParam(arg_5_0)
	if not arg_5_0._diceBox then
		return
	end

	arg_5_0._anim:Play("open", 0, 0)
	arg_5_0._diceBox:onStepEnd(true)
	arg_5_0._hero:refreshAll()
	arg_5_0:refreshCards()
	arg_5_0:refreshEnemys()
	arg_5_0:beginRound()
end

function var_0_0.beginRound(arg_6_0)
	arg_6_0._maskAnim:Play("out", 0, 1)

	local var_6_0 = DiceHeroFightModel.instance:getGameData()

	arg_6_0._curRound.text = var_6_0.round
	arg_6_0._roundFlow = FlowSequence.New()

	arg_6_0._roundFlow:addWork(FunctionWork.New(arg_6_0._hideDiceAndShowEnemyBehavior, arg_6_0))
	arg_6_0._roundFlow:addWork(DelayDoFuncWork.New(arg_6_0._showMask, arg_6_0, 1))
	arg_6_0._roundFlow:addWork(DelayDoFuncWork.New(arg_6_0._showDiceAndHideEnemyBehavior, arg_6_0, 0.1))
	arg_6_0._roundFlow:registerDoneListener(arg_6_0.flowDone, arg_6_0)
	arg_6_0._roundFlow:start()
end

function var_0_0._hideDiceAndShowEnemyBehavior(arg_7_0)
	UIBlockHelper.instance:startBlock("DiceHeroGameView_RoundStart", 1)
	gohelper.setActive(arg_7_0._godice, false)

	for iter_7_0, iter_7_1 in pairs(arg_7_0._enemys) do
		iter_7_1:refreshAll()
		iter_7_1:showBehavior()
	end

	arg_7_0._hero:refreshAll()
end

function var_0_0._showMask(arg_8_0)
	arg_8_0._anim:Play("camerain", 0, 0)
	arg_8_0._maskAnim:Play("in", 0, 0)
end

function var_0_0.onDamageEffect(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._damageEffectHero, arg_9_1)
	gohelper.setActive(arg_9_0._damageEffectEnemy, not arg_9_1)

	if DiceHeroFightModel.instance:getGameData().confirmed then
		arg_9_0._anim:Play("damage", 0, 0)
	else
		arg_9_0._anim:Play("damage1", 0, 0)
	end
end

function var_0_0._showDiceAndHideEnemyBehavior(arg_10_0)
	gohelper.setActive(arg_10_0._godice, true)
	arg_10_0._diceBox:startRoll()

	for iter_10_0, iter_10_1 in pairs(arg_10_0._enemys) do
		iter_10_1:hideBehavior()
	end
end

function var_0_0.flowDone(arg_11_0)
	local var_11_0 = DiceHeroFightModel.instance:getGameData()

	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.DiceHeroGuideRoundInfo, string.format("%s_%s", DiceHeroModel.instance.lastEnterLevelId, var_11_0.round))

	arg_11_0._roundFlow = nil

	if DiceHeroHelper.instance.afterFlow then
		local var_11_1 = DiceHeroHelper.instance.afterFlow

		DiceHeroHelper.instance.afterFlow = nil

		DiceHeroHelper.instance:startFlow(var_11_1)
	end
end

function var_0_0.confirmDice(arg_12_0)
	arg_12_0._anim:Play("cameraout", 0, 0)
	arg_12_0._maskAnim:Play("out", 0, 0)
end

function var_0_0.refreshCards(arg_13_0)
	local var_13_0 = DiceHeroFightModel.instance:getGameData().skillCards

	arg_13_0._cards = arg_13_0._cards or {}

	gohelper.CreateObjList(arg_13_0, arg_13_0._createCard, var_13_0, nil, arg_13_0._gocard, DiceHeroCardItem)
end

function var_0_0._createCard(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_1:initData(arg_14_2)

	arg_14_0._cards[arg_14_2.skillId] = arg_14_1
end

function var_0_0.refreshEnemys(arg_15_0)
	local var_15_0 = DiceHeroFightModel.instance:getGameData().enemyHeros

	arg_15_0._enemys = arg_15_0._enemys or {}

	gohelper.CreateObjList(arg_15_0, arg_15_0._createEnemy, var_15_0, nil, arg_15_0._goenemy, DiceHeroEnemyItem, nil, nil, 1)
end

function var_0_0._createEnemy(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_1:initData(arg_16_2)

	arg_16_0._enemys[arg_16_2.uid] = arg_16_1
end

function var_0_0.onDestroyView(arg_17_0)
	if arg_17_0._roundFlow then
		arg_17_0._roundFlow:onDestroyInternal()

		arg_17_0._roundFlow = nil
	end

	DiceHeroHelper.instance:clear()
end

return var_0_0
