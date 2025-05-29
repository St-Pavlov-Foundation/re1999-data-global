module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroHeroItem", package.seeall)

local var_0_0 = class("DiceHeroHeroItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._emptyRelicItem = gohelper.findChild(arg_1_1, "root/zaowu/#go_nulllayout/#go_item")
	arg_1_0._relicItem = gohelper.findChild(arg_1_1, "root/zaowu/#go_iconlayout/#simage_iconitem")
	arg_1_0._buffItem = gohelper.findChild(arg_1_1, "root/#go_statelist/#simage_icon")
	arg_1_0._powerItem = gohelper.findChild(arg_1_1, "root/headbg/energylayout/#go_item")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_1, "root/#txt_name")
	arg_1_0._hpSlider = gohelper.findChildImage(arg_1_1, "root/#simage_hpbg/#simage_hp")
	arg_1_0._shieldSlider = gohelper.findChildImage(arg_1_1, "root/#simage_shieldbg/#simage_shield")
	arg_1_0._hpNum = gohelper.findChildTextMesh(arg_1_1, "root/#simage_hpbg/#txt_hpnum")
	arg_1_0._shieldNum = gohelper.findChildTextMesh(arg_1_1, "root/#simage_shieldbg/#txt_shieldnum")
	arg_1_0._click = gohelper.findChildButtonWithAudio(arg_1_1, "root/#btn_clickhead")
	arg_1_0._headicon = gohelper.findChildSingleImage(arg_1_1, "root/headbg/headicon")
	arg_1_0._headbgAnim = gohelper.findChildAnim(arg_1_1, "root/headbg")
	arg_1_0._headbgTrans = arg_1_0._headbgAnim.transform
	arg_1_0._btnClickHead = gohelper.findChildButtonWithAudio(arg_1_1, "root/#btn_clickhead")
	arg_1_0._btnClickRelic = gohelper.findChildButtonWithAudio(arg_1_1, "root/#btn_clickrelic")
	arg_1_0._btnClickBuff = gohelper.findChildButtonWithAudio(arg_1_1, "root/#btn_clickbuff")
	arg_1_0._goskilltips = gohelper.findChild(arg_1_1, "tips/#go_skilltip")
	arg_1_0._gozaowutip = gohelper.findChild(arg_1_1, "tips/#go_zaowutip")
	arg_1_0._gobufftip = gohelper.findChild(arg_1_1, "tips/#go_fightbufftips")
	arg_1_0._goskillitem = gohelper.findChild(arg_1_1, "tips/#go_skilltip/viewport/content/item")
	arg_1_0._gozaowuitem = gohelper.findChild(arg_1_1, "tips/#go_zaowutip/viewport/content/item")
	arg_1_0._gobuffitem = gohelper.findChild(arg_1_1, "tips/#go_fightbufftips/viewport/content/item")
	arg_1_0._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(arg_1_0._click.gameObject)

	arg_1_0._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})

	arg_1_0._txtname.text = ""

	gohelper.setActive(gohelper.findChild(arg_1_1, "root/dice"), false)

	arg_1_0._gobuffeffect = gohelper.findChild(arg_1_1, "root/#go_buff")
	arg_1_0._godebuffeffect = gohelper.findChild(arg_1_1, "root/#go_debuff")
	arg_1_0._goshieldeffect = gohelper.findChild(arg_1_1, "root/#go_shield")
	arg_1_0._godamageeffect = gohelper.findChild(arg_1_1, "root/#go_damage")
	arg_1_0._godeadeffect = gohelper.findChild(arg_1_1, "root/#go_died")
	arg_1_0._shieldEffectAnim = gohelper.findChildAnim(arg_1_1, "root/#simage_shieldbg")
	arg_1_0._gobigskilleffect = gohelper.findChild(arg_1_1, "root/headbg/#go_bigskilltip")
	arg_1_0._gopassiveeffect = gohelper.findChild(arg_1_1, "root/headbg/#go_passivetip")

	recthelper.setHeight(arg_1_0._gobufftip.transform, 275)
	recthelper.setHeight(arg_1_0._goskilltips.transform, 300)
	recthelper.setHeight(arg_1_0._gozaowutip.transform, 300)
	arg_1_0:refreshRelic()
	arg_1_0:refreshAll()
	arg_1_0._headicon:LoadImage(ResUrl.getHeadIconSmall(arg_1_0:getHeroMo().co.icon))
	DiceHeroHelper.instance:registerEntity(arg_1_0:getHeroMo().uid, arg_1_0)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnLongPress:AddLongPressListener(arg_2_0._onLongClickHero, arg_2_0)
	arg_2_0._btnClickHead:AddClickListener(arg_2_0._onClickHero, arg_2_0)
	arg_2_0._btnClickRelic:AddClickListener(arg_2_0._showRelic, arg_2_0)
	arg_2_0._btnClickBuff:AddClickListener(arg_2_0._showBuff, arg_2_0)
	arg_2_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_2_0.onTouchScreen, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnLongPress:RemoveLongPressListener()
	arg_3_0._btnClickHead:RemoveClickListener()
	arg_3_0._btnClickRelic:RemoveClickListener()
	arg_3_0._btnClickBuff:RemoveClickListener()
end

function var_0_0.setActiveTips(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0._gozaowutip, arg_4_1 == arg_4_0._gozaowutip)
	gohelper.setActive(arg_4_0._gobufftip, arg_4_1 == arg_4_0._gobufftip)
	gohelper.setActive(arg_4_0._goskilltips, arg_4_1 == arg_4_0._goskilltips)
end

function var_0_0._onClickHero(arg_5_0)
	if not arg_5_0:getHeroMo():canUseHeroSkill() then
		if arg_5_0._goskilltips.activeSelf then
			gohelper.setActive(arg_5_0._goskilltips, false)

			return
		end

		local var_5_0 = DiceHeroFightModel.instance:getGameData().heroSkillCards

		if not var_5_0[1] then
			return
		end

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
		arg_5_0:setActiveTips(arg_5_0._goskilltips)
		gohelper.CreateObjList(arg_5_0, arg_5_0._createSkillItem, var_5_0, nil, arg_5_0._goskillitem)
	else
		gohelper.setActive(arg_5_0._goskilltips, false)

		if not DiceHeroFightModel.instance:getGameData().confirmed then
			return
		end

		if DiceHeroHelper.instance:isInFlow() then
			return
		end

		DiceHeroRpc.instance:sendDiceHeroUseSkill(DiceHeroEnum.SkillType.Hero, 0, "", {}, 0)
	end
end

function var_0_0._onLongClickHero(arg_6_0)
	if not arg_6_0:getHeroMo():canUseHeroSkill() then
		return
	end

	local var_6_0 = DiceHeroFightModel.instance:getGameData().heroSkillCards

	if not var_6_0[1] then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	arg_6_0:setActiveTips(arg_6_0._goskilltips)
	gohelper.CreateObjList(arg_6_0, arg_6_0._createSkillItem, var_6_0, nil, arg_6_0._goskillitem)
end

function var_0_0._createSkillItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = gohelper.findChildTextMesh(arg_7_1, "#txt_title/#txt_title")
	local var_7_1 = gohelper.findChildTextMesh(arg_7_1, "#txt_desc")

	var_7_0.text = arg_7_2.co.name
	var_7_1.text = arg_7_2.co.desc
end

function var_0_0._showBuff(arg_8_0)
	if arg_8_0._gobufftip.activeSelf then
		gohelper.setActive(arg_8_0._gobufftip, false)

		return
	end

	local var_8_0 = DiceHeroFightModel.instance:getGameData().allyHero.buffs

	if not var_8_0[1] then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	arg_8_0:setActiveTips(arg_8_0._gobufftip)
	gohelper.CreateObjList(arg_8_0, arg_8_0._createBuffItem, var_8_0, nil, arg_8_0._gobuffitem)
end

function var_0_0._createBuffItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = gohelper.findChildTextMesh(arg_9_1, "name/#txt_name")
	local var_9_1 = gohelper.findChildTextMesh(arg_9_1, "name/#txt_layer")
	local var_9_2 = gohelper.findChildTextMesh(arg_9_1, "#txt_desc")
	local var_9_3 = gohelper.findChildImage(arg_9_1, "name/#simage_icon")
	local var_9_4 = gohelper.findChild(arg_9_1, "name/#txt_name/#go_tag")
	local var_9_5 = gohelper.findChildTextMesh(arg_9_1, "name/#txt_name/#go_tag/#txt_name")

	if arg_9_2.co.tag == 1 then
		gohelper.setActive(var_9_4, true)

		var_9_5.text = luaLang("dicehero_buff")
	elseif arg_9_2.co.tag == 2 then
		gohelper.setActive(var_9_4, true)

		var_9_5.text = luaLang("dicehero_debuff")
	else
		gohelper.setActive(var_9_4, false)
	end

	UISpriteSetMgr.instance:setBuffSprite(var_9_3, arg_9_2.co.icon)

	var_9_0.text = arg_9_2.co.name
	var_9_2.text = arg_9_2.co.desc

	if arg_9_2.co.damp >= 0 and arg_9_2.co.damp <= 4 then
		var_9_1.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_buff_" .. arg_9_2.co.damp), arg_9_2.layer)
	else
		var_9_1.text = ""
	end
end

function var_0_0._showRelic(arg_10_0)
	if arg_10_0._gozaowutip.activeSelf then
		gohelper.setActive(arg_10_0._gozaowutip, false)

		return
	end

	local var_10_0 = DiceHeroFightModel.instance:getGameData().allyHero.relicIds
	local var_10_1 = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		table.insert(var_10_1, lua_dice_relic.configDict[iter_10_1])
	end

	if #var_10_1 <= 0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	arg_10_0:setActiveTips(arg_10_0._gozaowutip)
	gohelper.CreateObjList(arg_10_0, arg_10_0._createZaowuItem, var_10_1, nil, arg_10_0._gozaowuitem)
end

function var_0_0._createZaowuItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = gohelper.findChildTextMesh(arg_11_1, "name/#txt_name")
	local var_11_1 = gohelper.findChildTextMesh(arg_11_1, "#txt_desc")

	gohelper.findChildSingleImage(arg_11_1, "name/#simage_icon"):LoadImage("singlebg/v2a6_dicehero_singlebg/collection/" .. arg_11_2.icon .. ".png")

	var_11_0.text = arg_11_2.name
	var_11_1.text = arg_11_2.desc
end

function var_0_0.onTouchScreen(arg_12_0)
	if arg_12_0._goskilltips.activeSelf then
		if gohelper.isMouseOverGo(arg_12_0._goskilltips) and gohelper.isMouseOverGo(arg_12_0._goskillitem.transform.parent) or gohelper.isMouseOverGo(arg_12_0._btnClickHead) then
			return
		end

		gohelper.setActive(arg_12_0._goskilltips, false)
	elseif arg_12_0._gozaowutip.activeSelf then
		if gohelper.isMouseOverGo(arg_12_0._gozaowutip) and gohelper.isMouseOverGo(arg_12_0._gozaowuitem.transform.parent) or gohelper.isMouseOverGo(arg_12_0._btnClickRelic) then
			return
		end

		gohelper.setActive(arg_12_0._gozaowutip, false)
	elseif arg_12_0._gobufftip.activeSelf then
		if gohelper.isMouseOverGo(arg_12_0._gobufftip) and gohelper.isMouseOverGo(arg_12_0._gobuffitem.transform.parent) or gohelper.isMouseOverGo(arg_12_0._btnClickBuff) then
			return
		end

		gohelper.setActive(arg_12_0._gobufftip, false)
	end
end

function var_0_0.refreshAll(arg_13_0)
	gohelper.setActive(arg_13_0._godeadeffect, false)
	arg_13_0:refreshBuff()
	arg_13_0:refreshPower()
	arg_13_0:refreshInfo()
end

function var_0_0.refreshRelic(arg_14_0)
	local var_14_0 = arg_14_0:getHeroMo()
	local var_14_1 = {}
	local var_14_2 = {}

	for iter_14_0 = 1, 5 do
		if var_14_0.relicIds[iter_14_0] then
			table.insert(var_14_1, var_14_0.relicIds[iter_14_0])
		else
			table.insert(var_14_2, 1)
		end
	end

	gohelper.CreateObjList(arg_14_0, arg_14_0._createRelicItem, var_14_1, nil, arg_14_0._relicItem)
	gohelper.CreateObjList(nil, nil, var_14_2, nil, arg_14_0._emptyRelicItem)
end

function var_0_0._createRelicItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = gohelper.findChildSingleImage(arg_15_1, "")
	local var_15_1 = lua_dice_relic.configDict[arg_15_2]

	if var_15_1 then
		var_15_0:LoadImage("singlebg/v2a6_dicehero_singlebg/collection/" .. var_15_1.icon .. ".png")
	end
end

function var_0_0.refreshBuff(arg_16_0)
	local var_16_0 = arg_16_0:getHeroMo().buffs

	gohelper.CreateObjList(arg_16_0, arg_16_0._createBuff, var_16_0, nil, arg_16_0._buffItem)
	arg_16_0:refreshCanUseHeroSkill()

	if arg_16_0._gobufftip.activeSelf then
		if #var_16_0 > 0 then
			gohelper.CreateObjList(arg_16_0, arg_16_0._createBuffItem, var_16_0, nil, arg_16_0._gobuffitem)
		else
			gohelper.setActive(arg_16_0._gobufftip, false)
		end
	end
end

function var_0_0._createBuff(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = gohelper.findChildImage(arg_17_1, "")

	UISpriteSetMgr.instance:setBuffSprite(var_17_0, arg_17_2.co.icon)
end

function var_0_0.refreshPower(arg_18_0)
	local var_18_0 = arg_18_0:getHeroMo().power
	local var_18_1 = arg_18_0:getHeroMo().maxPower
	local var_18_2 = {}

	for iter_18_0 = 1, var_18_1 do
		var_18_2[iter_18_0] = iter_18_0 <= var_18_0 and 1 or 0
	end

	arg_18_0._powerItemAnims = arg_18_0._powerItemAnims or arg_18_0:getUserDataTb_()

	gohelper.CreateObjList(arg_18_0, arg_18_0._createPower, var_18_2, nil, arg_18_0._powerItem)
	arg_18_0:refreshCanUseHeroSkill()
end

function var_0_0._createPower(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = gohelper.findChild(arg_19_1, "light")

	arg_19_0._powerItemAnims[arg_19_3] = gohelper.findChildAnim(arg_19_1, "")

	arg_19_0._powerItemAnims[arg_19_3]:Play("idle", 0, 0)
	gohelper.setActive(var_19_0, arg_19_2 == 1)
end

function var_0_0.getHeroMo(arg_20_0)
	return DiceHeroFightModel.instance:getGameData().allyHero
end

function var_0_0.addHp(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getHeroMo()

	var_21_0.hp = var_21_0.hp + arg_21_1

	arg_21_0:refreshInfo()
	gohelper.setActive(arg_21_0._godeadeffect, var_21_0.hp <= 0)
end

function var_0_0.addShield(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getHeroMo()

	var_22_0.shield = var_22_0.shield + arg_22_1

	arg_22_0:refreshInfo()
end

function var_0_0.addPower(arg_23_0, arg_23_1)
	if arg_23_1 ~= 0 then
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_ideachange)
	end

	local var_23_0 = arg_23_0:getHeroMo()

	var_23_0.power = var_23_0.power + arg_23_1

	arg_23_0:refreshPower()

	if var_23_0.maxPower <= var_23_0.power then
		for iter_23_0 = 1, var_23_0.maxPower do
			arg_23_0._powerItemAnims[iter_23_0]:Play("full", 0, 0)
		end
	elseif arg_23_1 > 0 then
		for iter_23_1 = var_23_0.power - arg_23_1 + 1, var_23_0.power do
			arg_23_0._powerItemAnims[iter_23_1]:Play("open", 0, 0)
		end
	else
		for iter_23_2 = var_23_0.power + 1, var_23_0.power - arg_23_1 do
			arg_23_0._powerItemAnims[iter_23_2]:Play("close", 0, 0)
		end
	end
end

function var_0_0.addMaxPower(arg_24_0, arg_24_1)
	if arg_24_1 ~= 0 then
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_ideachange)
	end

	local var_24_0 = arg_24_0:getHeroMo()

	var_24_0.maxPower = var_24_0.maxPower + arg_24_1

	arg_24_0:refreshPower()

	if var_24_0.maxPower <= var_24_0.power then
		for iter_24_0 = 1, var_24_0.maxPower do
			arg_24_0._powerItemAnims[iter_24_0]:Play("full", 0, 0)
		end
	end
end

function var_0_0.addOrUpdateBuff(arg_25_0, arg_25_1)
	arg_25_0:getHeroMo():addOrUpdateBuff(arg_25_1)
	arg_25_0:refreshBuff()
end

function var_0_0.removeBuff(arg_26_0, arg_26_1)
	arg_26_0:getHeroMo():removeBuff(arg_26_1)
	arg_26_0:refreshBuff()
end

function var_0_0.refreshInfo(arg_27_0)
	local var_27_0 = arg_27_0:getHeroMo()
	local var_27_1 = var_27_0.hp
	local var_27_2 = var_27_0.maxHp
	local var_27_3 = var_27_0.shield
	local var_27_4 = var_27_0.maxShield

	ZProj.TweenHelper.DOFillAmount(arg_27_0._hpSlider, var_27_2 > 0 and var_27_1 / var_27_2 or 0, 0.2)
	ZProj.TweenHelper.DOFillAmount(arg_27_0._shieldSlider, var_27_4 > 0 and var_27_3 / var_27_4 or 0, 0.2)

	arg_27_0._hpNum.text = var_27_1
	arg_27_0._shieldNum.text = var_27_3
end

function var_0_0.refreshCanUseHeroSkill(arg_28_0)
	local var_28_0 = arg_28_0:getHeroMo()

	gohelper.setActive(arg_28_0._gobigskilleffect, var_28_0:canUseHeroSkill())
	gohelper.setActive(arg_28_0._gopassiveeffect, var_28_0:canUsePassiveSkill())
end

function var_0_0.getPos(arg_29_0, arg_29_1)
	if arg_29_1 == 1 then
		return arg_29_0._shieldSlider.transform.position
	elseif arg_29_1 == 2 then
		return arg_29_0._powerItem.transform.parent.position
	end

	return arg_29_0._headbgTrans.position
end

function var_0_0.playHitAnim(arg_30_0)
	arg_30_0._headbgAnim:Play("hit", 0, 0)
end

function var_0_0.showEffect(arg_31_0, arg_31_1)
	gohelper.setActive(arg_31_0._gobuffeffect, false)
	gohelper.setActive(arg_31_0._godebuffeffect, false)
	gohelper.setActive(arg_31_0._goshieldeffect, false)
	gohelper.setActive(arg_31_0._godamageeffect, false)
	gohelper.setActive(arg_31_0._gobuffeffect, arg_31_1 == 1)
	gohelper.setActive(arg_31_0._godebuffeffect, arg_31_1 == 2)
	gohelper.setActive(arg_31_0._goshieldeffect, arg_31_1 == 3)
	gohelper.setActive(arg_31_0._godamageeffect, arg_31_1 == 4)

	if arg_31_1 == 3 then
		arg_31_0._shieldEffectAnim:Play("light", 0, 0)
	end
end

function var_0_0.onDestroy(arg_32_0)
	DiceHeroHelper.instance:unregisterEntity(arg_32_0:getHeroMo().uid)
end

return var_0_0
