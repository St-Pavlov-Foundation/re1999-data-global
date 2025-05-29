module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroCardItem", package.seeall)

local var_0_0 = class("DiceHeroCardItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.trans = arg_1_1.transform
	arg_1_0._anim = gohelper.findChildAnim(arg_1_1, "")
	arg_1_0._frame2 = gohelper.findChild(arg_1_1, "#frame_level2")
	arg_1_0._frame3 = gohelper.findChild(arg_1_1, "#frame_level3")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_1, "layout/#txt_name")
	arg_1_0._gosmallselect = gohelper.findChild(arg_1_1, "#go_smallselect")
	arg_1_0._gobigselect = gohelper.findChild(arg_1_1, "#go_bigselect")
	arg_1_0._imagelimitmask = gohelper.findChildImage(arg_1_1, "#go_limitmask")
	arg_1_0._goredtips = gohelper.findChild(arg_1_1, "#go_redtips")
	arg_1_0._txtredtips = gohelper.findChildTextMesh(arg_1_1, "#go_redtips/#txt_tip")
	arg_1_0._golock = gohelper.findChild(arg_1_1, "#go_limitmask/icon")
	arg_1_0._iconbg = gohelper.findChildImage(arg_1_1, "#simage_bg")
	arg_1_0._iconframe = gohelper.findChildImage(arg_1_1, "#simage_frame")
	arg_1_0._fighticon = gohelper.findChildImage(arg_1_1, "layout/#go_fightnum/iconpos/#simage_icon")
	arg_1_0._useNum = gohelper.findChildTextMesh(arg_1_1, "#go_usenum/#txt_usenum")
	arg_1_0._godiceitem = gohelper.findChild(arg_1_1, "bottom/dicelist/#go_item")
	arg_1_0._godicelist = gohelper.findChild(arg_1_1, "bottom/dicelist")
	arg_1_0._carddes = gohelper.findChildTextMesh(arg_1_1, "layout/#scroll_skilldesc/viewport/#txt_skilldesc")
	arg_1_0._txtnum = gohelper.findChildTextMesh(arg_1_1, "layout/#go_fightnum/#txt_num")
	arg_1_0._gonum = gohelper.findChild(arg_1_1, "layout/#go_fightnum")
	arg_1_0._buffeffect = gohelper.findChild(arg_1_1, "#go_buffhit")
	arg_1_0._click = gohelper.getClick(arg_1_1)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickSkill, arg_2_0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardSelectChange, arg_2_0._onSkillCardSelect, arg_2_0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardDiceChange, arg_2_0._onSkillCardSelect, arg_2_0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.StepEnd, arg_2_0.updateStatu, arg_2_0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.ConfirmDice, arg_2_0.updateStatu, arg_2_0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.RerollDice, arg_2_0.updateStatu, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardSelectChange, arg_3_0._onSkillCardSelect, arg_3_0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardDiceChange, arg_3_0._onSkillCardSelect, arg_3_0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.StepEnd, arg_3_0.updateStatu, arg_3_0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.ConfirmDice, arg_3_0.updateStatu, arg_3_0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.RerollDice, arg_3_0.updateStatu, arg_3_0)
end

local var_0_1 = {
	[DiceHeroEnum.CardType.Atk] = "4",
	[DiceHeroEnum.CardType.Def] = "5",
	[DiceHeroEnum.CardType.Power] = "2"
}
local var_0_2 = {
	[DiceHeroEnum.CardType.Atk] = "1",
	[DiceHeroEnum.CardType.Def] = "5",
	[DiceHeroEnum.CardType.Power] = "4"
}

function var_0_0.initData(arg_4_0, arg_4_1)
	DiceHeroHelper.instance:registerCard(arg_4_1.skillId, arg_4_0)

	arg_4_0.data = arg_4_1
	arg_4_0._txtname.text = arg_4_1.co.name
	arg_4_0._canUse = false

	gohelper.setActive(arg_4_0._gosmallselect, false)
	gohelper.setActive(arg_4_0._gobigselect, false)

	arg_4_0._carddes.text = arg_4_1.co.desc

	gohelper.setActive(arg_4_0._gonum, DiceHeroHelper.instance:isShowCarNum(arg_4_1.co.effect1))
	UISpriteSetMgr.instance:setDiceHeroSprite(arg_4_0._iconbg, "v2a6_dicehero_game_skillcardquality" .. (var_0_1[arg_4_1.co.type] or arg_4_1.co.type))
	UISpriteSetMgr.instance:setDiceHeroSprite(arg_4_0._iconframe, "v2a6_dicehero_game_skillcardbg" .. arg_4_1.co.quality)
	UISpriteSetMgr.instance:setFightSprite(arg_4_0._fighticon, "jnk_gj" .. (var_0_2[arg_4_1.co.type] or 0))
	gohelper.setActive(arg_4_0._frame2, arg_4_1.co.quality == "2")
	gohelper.setActive(arg_4_0._frame3, arg_4_1.co.quality == "3")
	arg_4_0:updateStatu()
	gohelper.CreateObjList(arg_4_0, arg_4_0._createDiceItem, arg_4_0.data.matchDiceRules, nil, arg_4_0._godiceitem, DiceHeroCardDiceItem)

	if #arg_4_0.data.matchDiceRules >= 5 then
		transformhelper.setLocalScale(arg_4_0._godicelist.transform, 0.74, 0.74, 1)
	else
		transformhelper.setLocalScale(arg_4_0._godicelist.transform, 1, 1, 1)
	end
end

function var_0_0.updateStatu(arg_5_0)
	local var_5_0 = false
	local var_5_1
	local var_5_2 = DiceHeroFightModel.instance:getGameData()

	if not DiceHeroHelper.instance:isInFlow() then
		var_5_0, var_5_1 = arg_5_0.data:canSelect()

		gohelper.setActive(arg_5_0._buffeffect, arg_5_0.data.co.type == DiceHeroEnum.CardType.Atk and var_5_2.allyHero:haveBuff2())

		if arg_5_0._isGray == nil then
			arg_5_0._isGray = false
			arg_5_0._isBlack = false
		end

		local var_5_3 = not var_5_0
		local var_5_4 = var_5_0 and not var_5_2.confirmed

		if (var_5_3 ~= arg_5_0._isGray or var_5_4 ~= arg_5_0._isBlack) and not DiceHeroHelper.instance:isInFlow() then
			if var_5_3 and arg_5_0._isBlack then
				arg_5_0._anim:Play("togray", 0, 0)
			elseif var_5_4 and arg_5_0._isGray then
				arg_5_0._anim:Play("toblack", 0, 0)
			elseif var_5_3 and not arg_5_0._isGray then
				arg_5_0._anim:Play("gray", 0, 0)
			elseif not var_5_3 and arg_5_0._isGray then
				arg_5_0._anim:Play("ungray", 0, 0)
			elseif var_5_4 and not arg_5_0._isBlack then
				arg_5_0._anim:Play("black", 0, 0)
			elseif not var_5_4 and arg_5_0._isBlack then
				arg_5_0._anim:Play("unblack", 0, 0)
			end

			arg_5_0._isGray = var_5_3
			arg_5_0._isBlack = var_5_4
		end
	end

	gohelper.setActive(arg_5_0._goredtips, not var_5_0)

	if not var_5_0 then
		arg_5_0._canUse = false

		gohelper.setActive(arg_5_0._gosmallselect, false)
		gohelper.setActive(arg_5_0._gobigselect, false)

		if var_5_1 == DiceHeroEnum.CantUseReason.NoDice then
			arg_5_0._txtredtips.text = luaLang("dicehero_card_nodice")

			gohelper.setActive(arg_5_0._golock, false)
		elseif var_5_1 == DiceHeroEnum.CantUseReason.NoUseCount then
			arg_5_0._txtredtips.text = luaLang("dicehero_card_nocount")

			gohelper.setActive(arg_5_0._golock, false)
		elseif var_5_1 == DiceHeroEnum.CantUseReason.BanSkill then
			arg_5_0._txtredtips.text = luaLang("dicehero_card_banskill")

			gohelper.setActive(arg_5_0._golock, true)
		end
	else
		gohelper.setActive(arg_5_0._golock, false)
	end

	if arg_5_0.data.co.roundLimitCount == 0 then
		arg_5_0._useNum.text = "∞"
	else
		arg_5_0._useNum.text = arg_5_0.data.co.roundLimitCount - arg_5_0.data.curRoundUse
	end

	arg_5_0:updateNumShow()
end

function var_0_0._createDiceItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_1:initData(arg_6_2, arg_6_0.data, arg_6_3)
end

function var_0_0._onSkillCardSelect(arg_7_0)
	local var_7_0 = DiceHeroFightModel.instance:getGameData().curSelectCardMo == arg_7_0.data

	if var_7_0 then
		local var_7_1 = arg_7_0.data:canUse()

		if not arg_7_0._canUse then
			arg_7_0._canUse = false
		end

		gohelper.setActive(arg_7_0._gosmallselect, not var_7_1)
		gohelper.setActive(arg_7_0._gobigselect, var_7_1)
	else
		gohelper.setActive(arg_7_0._gosmallselect, false)
		gohelper.setActive(arg_7_0._gobigselect, false)
	end

	if not arg_7_0._isSelect then
		arg_7_0._isSelect = false
	end

	if arg_7_0._isSelect ~= var_7_0 then
		arg_7_0._isSelect = var_7_0

		if var_7_0 then
			arg_7_0._anim:Play("select", 0, 0)
		elseif not arg_7_0._isGray and not arg_7_0._isBlack then
			arg_7_0._anim:Play("unselect", 0, 0)
		end
	end

	arg_7_0:updateNumShow()
end

function var_0_0.updateNumShow(arg_8_0)
	if not DiceHeroHelper.instance:isShowCarNum(arg_8_0.data.co.effect1) then
		return
	end

	if arg_8_0.data.co.effect1 == DiceHeroEnum.SkillEffectType.Damage1 or arg_8_0.data.co.effect1 == DiceHeroEnum.SkillEffectType.ChangeShield1 or arg_8_0.data.co.effect1 == DiceHeroEnum.SkillEffectType.ChangePower1 then
		local var_8_0 = arg_8_0.data:canUse()
		local var_8_1 = string.split(arg_8_0.data.co.params1, ",")

		for iter_8_0 = 1, #var_8_1 do
			var_8_1[iter_8_0] = string.format("<color=#%s>%s</color>", var_8_0 ~= iter_8_0 and "A28D8D" or "FFFFFF", var_8_1[iter_8_0])
		end

		arg_8_0._txtnum.text = table.concat(var_8_1, "/")
	elseif arg_8_0.data.co.effect1 == DiceHeroEnum.SkillEffectType.Damage2 or arg_8_0.data.co.effect1 == DiceHeroEnum.SkillEffectType.ChangeShield2 then
		local var_8_2 = 0

		if arg_8_0.data:isMatchMin() then
			local var_8_3 = DiceHeroFightModel.instance:getGameData().diceBox

			for iter_8_1, iter_8_2 in pairs(arg_8_0.data.curSelectUids) do
				local var_8_4 = var_8_3:getDiceMoByUid(iter_8_2)

				if var_8_4 then
					var_8_2 = var_8_2 + var_8_4.num
				end
			end
		end

		arg_8_0._txtnum.text = var_8_2
	elseif arg_8_0.data.co.effect1 == DiceHeroEnum.SkillEffectType.ChangePower2 then
		local var_8_5 = 0

		if arg_8_0.data:isMatchMin() then
			var_8_5 = DiceHeroFightModel.instance:getGameData().allyHero.power
		end

		arg_8_0._txtnum.text = "+" .. var_8_5
	end
end

function var_0_0._onClickSkill(arg_9_0)
	local var_9_0 = DiceHeroFightModel.instance:getGameData()

	if not var_9_0.confirmed then
		return
	end

	if DiceHeroHelper.instance:isInFlow() then
		return
	end

	if var_9_0.curSelectCardMo == arg_9_0.data then
		local var_9_1, var_9_2 = arg_9_0.data:canUse()

		if not var_9_1 then
			GameFacade.showToast(ToastEnum.DiceHeroDiceNoEnoughDice)

			return
		end

		local var_9_3 = var_9_0.curSelectEnemyMo and var_9_0.curSelectEnemyMo.uid or ""

		DiceHeroRpc.instance:sendDiceHeroUseSkill(DiceHeroEnum.SkillType.Normal, arg_9_0.data.skillId, var_9_3, var_9_2, var_9_1 > 0 and var_9_1 - 1 or var_9_1)
	elseif arg_9_0.data:canSelect() then
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_cardrelease)
		var_9_0:setCurSelectCard(arg_9_0.data)
	end
end

function var_0_0.doHitAnim(arg_10_0)
	arg_10_0._anim:Play("hit", 0, 0)
end

function var_0_0.playRefreshAnim(arg_11_0)
	arg_11_0._anim:Play("refresh", 0, 0)

	arg_11_0._isGray = false
	arg_11_0._isBlack = false
end

function var_0_0.getPos(arg_12_0)
	return arg_12_0._txtname.transform.position
end

function var_0_0.onDestroy(arg_13_0)
	DiceHeroHelper.instance:unregisterCard(arg_13_0.data.skillId)
end

return var_0_0
