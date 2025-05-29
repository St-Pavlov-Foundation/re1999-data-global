module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroDiceBoxItem", package.seeall)

local var_0_0 = class("DiceHeroDiceBoxItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._parentView = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._goreroll = gohelper.findChild(arg_2_1, "#go_reroll")
	arg_2_0._goend = gohelper.findChild(arg_2_1, "#go_end")
	arg_2_0._godices = gohelper.findChild(arg_2_1, "dices")
	arg_2_0._btnreroll = gohelper.findChildButtonWithAudio(arg_2_1, "#go_reroll/#btn_reroll")
	arg_2_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_2_1, "#go_reroll/#btn_confirm")
	arg_2_0._goconfirmeffect = gohelper.findChild(arg_2_1, "#go_reroll/#btn_confirm/#hint")
	arg_2_0._btnskip = gohelper.findChildButtonWithAudio(arg_2_1, "#go_reroll/#btn_skip")
	arg_2_0._btnend = gohelper.findChildButtonWithAudio(arg_2_1, "#go_end/#btn_endround")
	arg_2_0._goendeffect = gohelper.findChild(arg_2_1, "#go_end/#btn_endround/#hint")
	arg_2_0._btnusecard = gohelper.findChildButtonWithAudio(arg_2_1, "#go_end/#btn_usecard")
	arg_2_0._txtrollnum = gohelper.findChildTextMesh(arg_2_1, "#go_reroll/#btn_reroll/#txt_rollnum")
	arg_2_0._selectDict = {}
	arg_2_0._dices = {}

	local var_2_0 = arg_2_0._parentView.viewContainer._viewSetting.otherRes.diceitem

	for iter_2_0 = 1, 12 do
		local var_2_1 = gohelper.findChild(arg_2_0._godices, tostring(iter_2_0))
		local var_2_2 = gohelper.findChildButton(var_2_1, "")
		local var_2_3 = arg_2_0._parentView:getResInst(var_2_0, var_2_1)

		arg_2_0._dices[iter_2_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_3, DiceHeroDiceItem, {
			index = iter_2_0
		})

		arg_2_0:addClickCb(var_2_2, arg_2_0._onDiceClick, arg_2_0, iter_2_0)
	end

	local var_2_4 = DiceHeroModel.instance.lastEnterLevelId
	local var_2_5 = lua_dice_level.configDict[var_2_4]

	if var_2_5 then
		local var_2_6 = DiceHeroModel.instance:getGameInfo(var_2_5.chapter)

		if var_2_6.currLevel ~= var_2_4 or var_2_6.allPass then
			gohelper.setActive(arg_2_0._btnskip, true)
		else
			gohelper.setActive(arg_2_0._btnskip, false)
		end
	else
		gohelper.setActive(arg_2_0._btnskip, false)
	end

	arg_2_0:onProgressUpdate()
	arg_2_0:updateRollNum()
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnreroll:AddClickListener(arg_3_0._onClickReroll, arg_3_0)
	arg_3_0._btnconfirm:AddClickListener(arg_3_0._onClickConfirm, arg_3_0)
	arg_3_0._btnend:AddClickListener(arg_3_0._onClickEnd, arg_3_0)
	arg_3_0._btnskip:AddClickListener(arg_3_0._onClickSkip, arg_3_0)
	arg_3_0._btnusecard:AddClickListener(arg_3_0._onClickUseCard, arg_3_0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.ConfirmDice, arg_3_0.onProgressUpdate, arg_3_0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.StepEnd, arg_3_0.onStepEnd, arg_3_0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardSelectChange, arg_3_0.onSkillCardSelectChange, arg_3_0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardDiceChange, arg_3_0.updateUseCardStatu, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnreroll:RemoveClickListener()
	arg_4_0._btnconfirm:RemoveClickListener()
	arg_4_0._btnend:RemoveClickListener()
	arg_4_0._btnskip:RemoveClickListener()
	arg_4_0._btnusecard:RemoveClickListener()
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.ConfirmDice, arg_4_0.onProgressUpdate, arg_4_0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.StepEnd, arg_4_0.onStepEnd, arg_4_0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardSelectChange, arg_4_0.onSkillCardSelectChange, arg_4_0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardDiceChange, arg_4_0.updateUseCardStatu, arg_4_0)
end

function var_0_0.onStepEnd(arg_5_0, arg_5_1)
	for iter_5_0 = 1, 12 do
		arg_5_0._dices[iter_5_0]:onStepEnd(arg_5_1)
	end

	arg_5_0:onProgressUpdate()
	arg_5_0:updateRollNum()
	arg_5_0:checkEndEffect()

	local var_5_0 = DiceHeroFightModel.instance:getGameData()

	if var_5_0.diceBox.resetTimes <= 0 and not var_5_0.confirmed and DiceHeroFightModel.instance.finishResult == DiceHeroEnum.GameStatu.None then
		arg_5_0:_onClickConfirm()
	end
end

function var_0_0.startRoll(arg_6_0)
	arg_6_0._selectDict = {}

	for iter_6_0 = 1, 12 do
		arg_6_0._dices[iter_6_0]:startRoll()
	end
end

function var_0_0.updateRollNum(arg_7_0)
	local var_7_0 = DiceHeroFightModel.instance:getGameData().diceBox

	if var_7_0.resetTimes > 0 then
		arg_7_0._txtrollnum.text = var_7_0.resetTimes .. "/" .. var_7_0.maxResetTimes
	else
		arg_7_0._txtrollnum.text = "<color=#cd5353>" .. var_7_0.resetTimes .. "</color>/" .. var_7_0.maxResetTimes
	end

	gohelper.setActive(arg_7_0._goconfirmeffect, var_7_0.resetTimes <= 0)
end

function var_0_0.onProgressUpdate(arg_8_0)
	local var_8_0 = DiceHeroFightModel.instance:getGameData()

	gohelper.setActive(arg_8_0._goreroll, not var_8_0.confirmed)
	gohelper.setActive(arg_8_0._goend, var_8_0.confirmed)

	if var_8_0.confirmed then
		arg_8_0:checkEndEffect()
	end
end

function var_0_0.checkEndEffect(arg_9_0)
	local var_9_0 = true
	local var_9_1 = DiceHeroFightModel.instance:getGameData()

	for iter_9_0, iter_9_1 in pairs(var_9_1.skillCards) do
		if iter_9_1:canSelect() then
			var_9_0 = false

			break
		end
	end

	gohelper.setActive(arg_9_0._goendeffect, var_9_0)
end

function var_0_0._onDiceClick(arg_10_0, arg_10_1)
	if DiceHeroHelper.instance:isInFlow() then
		return
	end

	local var_10_0 = arg_10_0._dices[arg_10_1].diceMo

	if not var_10_0 or var_10_0.deleted then
		return
	end

	local var_10_1 = DiceHeroFightModel.instance:getGameData()
	local var_10_2 = var_10_1.curSelectCardMo

	if not var_10_1.confirmed then
		if var_10_0.status ~= DiceHeroEnum.DiceStatu.Normal then
			return
		end

		if arg_10_0._selectDict[arg_10_1] then
			arg_10_0._selectDict[arg_10_1] = nil

			arg_10_0._dices[arg_10_1]:setSelect(false)
			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_cardunready)
		else
			arg_10_0._selectDict[arg_10_1] = true

			arg_10_0._dices[arg_10_1]:setSelect(true)
			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_cardready)
		end
	else
		if not var_10_2 then
			return
		end

		if var_10_0.status == DiceHeroEnum.DiceStatu.HardLock then
			return
		end

		if arg_10_0._selectDict[arg_10_1] then
			var_10_2:removeDice(var_10_0.uid)
		elseif not var_10_2:addDice(var_10_0.uid) then
			return
		end

		if arg_10_0._selectDict[arg_10_1] then
			arg_10_0._selectDict[arg_10_1] = nil

			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_cardunready)
		else
			arg_10_0._selectDict[arg_10_1] = true

			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_cardready)
		end

		local var_10_3 = var_10_2:getCanUseDiceUidDict()

		for iter_10_0 = 1, 12 do
			if arg_10_0._dices[iter_10_0].diceMo and not arg_10_0._dices[iter_10_0].diceMo.deleted then
				if arg_10_0._selectDict[iter_10_0] then
					arg_10_0._dices[iter_10_0]:setSelect(true)
				else
					arg_10_0._dices[iter_10_0]:setSelect(false, var_10_3[arg_10_0._dices[iter_10_0].diceMo.uid] and true or false)
				end
			end
		end
	end
end

function var_0_0._onClickUseCard(arg_11_0)
	local var_11_0 = DiceHeroFightModel.instance:getGameData()
	local var_11_1 = var_11_0.curSelectCardMo

	if not var_11_1 then
		return
	end

	local var_11_2, var_11_3 = var_11_1:canUse()

	if not var_11_2 then
		return
	end

	local var_11_4 = var_11_0.curSelectEnemyMo and var_11_0.curSelectEnemyMo.uid or ""

	DiceHeroRpc.instance:sendDiceHeroUseSkill(DiceHeroEnum.SkillType.Normal, var_11_1.skillId, var_11_4, var_11_3, var_11_2 > 0 and var_11_2 - 1 or var_11_2)
end

function var_0_0.onSkillCardSelectChange(arg_12_0)
	local var_12_0 = DiceHeroFightModel.instance:getGameData()

	if not var_12_0.confirmed then
		return
	end

	arg_12_0._selectDict = {}

	local var_12_1 = var_12_0.curSelectCardMo

	if var_12_1 then
		local var_12_2, var_12_3 = var_12_1:isMatchMin(true)

		if var_12_2 then
			for iter_12_0, iter_12_1 in ipairs(var_12_3) do
				for iter_12_2 = 1, 12 do
					if arg_12_0._dices[iter_12_2].diceMo and arg_12_0._dices[iter_12_2].diceMo.uid == iter_12_1 and var_12_1:addDice(iter_12_1) then
						arg_12_0._selectDict[iter_12_2] = true

						break
					end
				end
			end
		end
	end

	local var_12_4 = var_12_1 and var_12_1:getCanUseDiceUidDict()

	for iter_12_3 = 1, 12 do
		if arg_12_0._dices[iter_12_3].diceMo and not arg_12_0._dices[iter_12_3].diceMo.deleted then
			local var_12_5

			if var_12_4 then
				var_12_5 = var_12_4[arg_12_0._dices[iter_12_3].diceMo.uid] and true or false
			end

			if arg_12_0._selectDict[iter_12_3] then
				arg_12_0._dices[iter_12_3]:setSelect(true)
			else
				arg_12_0._dices[iter_12_3]:setSelect(false, var_12_5)
			end
		end
	end

	arg_12_0:updateUseCardStatu()
end

function var_0_0.updateUseCardStatu(arg_13_0)
	gohelper.setActive(arg_13_0._btnusecard, false)

	do return end

	local var_13_0 = DiceHeroFightModel.instance:getGameData().curSelectCardMo

	if not var_13_0 then
		gohelper.setActive(arg_13_0._btnusecard, false)

		return
	end

	gohelper.setActive(arg_13_0._btnusecard, true)

	local var_13_1 = var_13_0:canUse() and true or false

	ZProj.UGUIHelper.SetGrayscale(arg_13_0._btnusecard.gameObject, not var_13_1)
end

function var_0_0._onClickReroll(arg_14_0)
	if DiceHeroHelper.instance:isInFlow() then
		return
	end

	if DiceHeroFightModel.instance:getGameData().diceBox.resetTimes <= 0 then
		GameFacade.showToast(ToastEnum.DiceHeroDiceNoResetCount)

		return
	end

	local var_14_0 = {}

	for iter_14_0 in pairs(arg_14_0._selectDict) do
		local var_14_1 = DiceHeroFightModel.instance:getGameData().diceBox.dices[iter_14_0]

		table.insert(var_14_0, var_14_1.uid)
	end

	if not var_14_0[1] then
		GameFacade.showToast(ToastEnum.DiceHeroNoSelectDice)

		return
	end

	DiceHeroRpc.instance:sendDiceHeroResetDice(var_14_0, arg_14_0._onReroll, arg_14_0)
end

function var_0_0._onClickConfirm(arg_15_0)
	if DiceHeroHelper.instance:isInFlow() then
		return
	end

	DiceHeroRpc.instance:sendDiceHeroConfirmDice(arg_15_0._onConfirmEnd, arg_15_0)
end

function var_0_0._onConfirmEnd(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_2 ~= 0 then
		return
	end

	arg_16_0:onSkillCardSelectChange()
end

function var_0_0._onClickEnd(arg_17_0)
	if DiceHeroHelper.instance:isInFlow() then
		return
	end

	DiceHeroRpc.instance:sendDiceHeroEndRound()
	gohelper.setActive(arg_17_0._goend, false)
end

function var_0_0._onClickSkip(arg_18_0)
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.DiceHeroSkipFight, MsgBoxEnum.BoxType.Yes_No, arg_18_0._closeGameView, nil, nil, arg_18_0)
end

function var_0_0._closeGameView(arg_19_0)
	ViewMgr.instance:closeView(ViewName.DiceHeroGameView)
end

function var_0_0._onReroll(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_2 ~= 0 then
		return
	end

	DiceHeroFightModel.instance:getGameData().diceBox:init(arg_20_3.diceBox)
	DiceHeroFightModel.instance:getGameData():onStepEnd()
	arg_20_0:updateRollNum()
	UIBlockHelper.instance:startBlock("DiceHeroDiceBoxItem_reroll", 0.6)

	for iter_20_0 = 1, 12 do
		arg_20_0._dices[iter_20_0]:setSelect(false)

		if arg_20_0._selectDict[iter_20_0] then
			local var_20_0 = DiceHeroFightModel.instance:getGameData().diceBox.dices[iter_20_0]

			arg_20_0._dices[iter_20_0]:playRefresh(var_20_0)
		end
	end

	arg_20_0._selectDict = {}

	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.RerollDice)
end

function var_0_0.onDestroy(arg_21_0)
	return
end

return var_0_0
