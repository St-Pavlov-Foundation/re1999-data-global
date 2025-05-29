module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroEnemyItem", package.seeall)

local var_0_0 = class("DiceHeroEnemyItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._buffItem = gohelper.findChild(arg_1_1, "root/#go_statelist/#go_list/#go_item")
	arg_1_0._hpSlider = gohelper.findChildImage(arg_1_1, "root/#simage_hpbg/#simage_hp")
	arg_1_0._shieldSlider = gohelper.findChildImage(arg_1_1, "root/#simage_shieldbg/#simage_shield")
	arg_1_0._hpNum = gohelper.findChildTextMesh(arg_1_1, "root/#simage_hpbg/#txt_hpnum")
	arg_1_0._shieldNum = gohelper.findChildTextMesh(arg_1_1, "root/#simage_shieldbg/#txt_shieldnum")
	arg_1_0._goselect = gohelper.findChild(arg_1_1, "root/#go_select")
	arg_1_0._gobuffmore = gohelper.findChild(arg_1_1, "root/#go_statelist/#go_more")
	arg_1_0._gobehaviormask = gohelper.findChild(arg_1_1, "root/mask")
	arg_1_0._iconbehavior = gohelper.findChildImage(arg_1_1, "root/#icon_begavior")
	arg_1_0._txtbehavior = gohelper.findChildTextMesh(arg_1_1, "root/#icon_begavior/#txt_num")
	arg_1_0._behaviortitle = gohelper.findChildTextMesh(arg_1_1, "tips/#go_fighttip/title/#txt_title")
	arg_1_0._behavioricon = gohelper.findChildImage(arg_1_1, "tips/#go_fighttip/title/#simage_icon")
	arg_1_0._behaviordesc = gohelper.findChildTextMesh(arg_1_1, "tips/#go_fighttip/#txt_desc")
	arg_1_0._headicon = gohelper.findChildSingleImage(arg_1_1, "root/headbg/headicon")
	arg_1_0._headbgAnim = gohelper.findChildAnim(arg_1_1, "root/headbg")
	arg_1_0._headbgTrans = arg_1_0._headbgAnim.transform
	arg_1_0._btnClickSelect = gohelper.findChildButtonWithAudio(arg_1_1, "root/#btn_select")
	arg_1_0._btnClickBuff = gohelper.findChildButtonWithAudio(arg_1_1, "root/#btn_buff")
	arg_1_0._btnClickBehavior = gohelper.findChildButtonWithAudio(arg_1_1, "root/#btn_behavior")
	arg_1_0._gofighttips = gohelper.findChild(arg_1_1, "tips/#go_fighttip")
	arg_1_0._gozaowutip = gohelper.findChild(arg_1_1, "tips/#go_fightbufftips")
	arg_1_0._gozaowuitem = gohelper.findChild(arg_1_1, "tips/#go_fightbufftips/viewport/content/item")
	arg_1_0._gobuffeffect = gohelper.findChild(arg_1_1, "root/#go_buff")
	arg_1_0._godebuffeffect = gohelper.findChild(arg_1_1, "root/#go_debuff")
	arg_1_0._goshieldeffect = gohelper.findChild(arg_1_1, "root/#go_shield")
	arg_1_0._godamageeffect = gohelper.findChild(arg_1_1, "root/#go_damage")
	arg_1_0._godeadeffect = gohelper.findChild(arg_1_1, "root/#go_died")
	arg_1_0._gobehaviorbuff = gohelper.findChild(arg_1_1, "tips/#go_fighttip/#go_buff")
	arg_1_0._behaviorbufftitle = gohelper.findChildTextMesh(arg_1_0._gobehaviorbuff, "name/#txt_name")
	arg_1_0._behaviorbuffimage = gohelper.findChildImage(arg_1_0._gobehaviorbuff, "name/#simage_icon")
	arg_1_0._behaviorbuffdesc = gohelper.findChildTextMesh(arg_1_0._gobehaviorbuff, "#txt_desc")
	arg_1_0._behaviorbufftag = gohelper.findChild(arg_1_0._gobehaviorbuff, "name/#txt_name/#go_tag")
	arg_1_0._behaviorbufftagName = gohelper.findChildTextMesh(arg_1_0._gobehaviorbuff, "name/#txt_name/#go_tag/#txt_name")

	gohelper.setActive(arg_1_0._goselect, false)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnClickSelect:AddClickListener(arg_2_0._onClickEnemy, arg_2_0)
	arg_2_0._btnClickBehavior:AddClickListener(arg_2_0.showBehavior, arg_2_0)
	arg_2_0._btnClickBuff:AddClickListener(arg_2_0._showBuff, arg_2_0)
	arg_2_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_2_0.onTouchScreen, arg_2_0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardSelectChange, arg_2_0._onSkillCardSelectChange, arg_2_0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.EnemySelectChange, arg_2_0._onSkillCardSelectChange, arg_2_0)
	gohelper.onceAddComponent(arg_2_0._behaviordesc.gameObject, typeof(ZProj.TMPHyperLinkClick)):SetClickListener(arg_2_0._onLinkClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnClickSelect:RemoveClickListener()
	arg_3_0._btnClickBehavior:RemoveClickListener()
	arg_3_0._btnClickBuff:RemoveClickListener()
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardSelectChange, arg_3_0._onSkillCardSelectChange, arg_3_0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.EnemySelectChange, arg_3_0._onSkillCardSelectChange, arg_3_0)
end

function var_0_0.initData(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0._godeadeffect, arg_4_1.hp <= 0)

	arg_4_0.data = arg_4_1

	DiceHeroHelper.instance:registerEntity(arg_4_1.uid, arg_4_0)
	arg_4_0._headicon:LoadImage(ResUrl.monsterHeadIcon(arg_4_0:getHeroMo().co.icon))
	arg_4_0:refreshAll()
end

function var_0_0.refreshAll(arg_5_0)
	arg_5_0:refreshBuff()
	arg_5_0:refreshInfo()
	arg_5_0:updateBehavior()
end

function var_0_0.updateBehavior(arg_6_0)
	local var_6_0 = arg_6_0:getHeroMo().behaviors

	gohelper.setActive(arg_6_0._iconbehavior, true)
	gohelper.setActive(arg_6_0._gobehaviormask, true)

	if var_6_0.type == 1 then
		local var_6_1 = var_6_0.value[1] or 0
		local var_6_2 = #var_6_0.value

		arg_6_0._txtbehavior.text = var_6_1 * var_6_2
		arg_6_0._behaviortitle.text = luaLang("dicehero_behavior_atk_title")

		if not var_6_0.exList then
			arg_6_0._behaviordesc.text = arg_6_0:getBehaviorText(var_6_0)
		else
			local var_6_3 = {
				arg_6_0:getBehaviorText(var_6_0)
			}

			for iter_6_0, iter_6_1 in ipairs(var_6_0.exList) do
				table.insert(var_6_3, arg_6_0:getBehaviorText(iter_6_1))
			end

			arg_6_0._behaviordesc.text = table.concat(var_6_3, "\n")
		end

		UISpriteSetMgr.instance:setFightSprite(arg_6_0._iconbehavior, "jnk_gj1")
		UISpriteSetMgr.instance:setFightSprite(arg_6_0._behavioricon, "jnk_gj1")
	elseif var_6_0.type == 2 then
		arg_6_0._txtbehavior.text = ""

		if var_6_0.isToAll then
			arg_6_0._behaviortitle.text = luaLang("dicehero_behavior_buff_title")

			UISpriteSetMgr.instance:setFightSprite(arg_6_0._iconbehavior, "jnk_gj4")
			UISpriteSetMgr.instance:setFightSprite(arg_6_0._behavioricon, "jnk_gj4")
		elseif var_6_0.isToFriend then
			arg_6_0._behaviortitle.text = luaLang("dicehero_behavior_buff_title")

			UISpriteSetMgr.instance:setFightSprite(arg_6_0._iconbehavior, "jnk_gj4")
			UISpriteSetMgr.instance:setFightSprite(arg_6_0._behavioricon, "jnk_gj4")
		else
			UISpriteSetMgr.instance:setFightSprite(arg_6_0._iconbehavior, "jnk_gj5")
			UISpriteSetMgr.instance:setFightSprite(arg_6_0._behavioricon, "jnk_gj5")

			arg_6_0._behaviortitle.text = luaLang("dicehero_behavior_def_title")
		end

		if not var_6_0.exList then
			arg_6_0._behaviordesc.text = arg_6_0:getBehaviorText(var_6_0)
		else
			local var_6_4 = {
				arg_6_0:getBehaviorText(var_6_0)
			}

			for iter_6_2, iter_6_3 in ipairs(var_6_0.exList) do
				table.insert(var_6_4, arg_6_0:getBehaviorText(iter_6_3))
			end

			arg_6_0._behaviordesc.text = table.concat(var_6_4, "\n")
		end
	elseif var_6_0.type == 3 then
		arg_6_0._txtbehavior.text = ""

		if not var_6_0.exList then
			arg_6_0._behaviordesc.text = arg_6_0:getBehaviorText(var_6_0)
		else
			local var_6_5 = {
				arg_6_0:getBehaviorText(var_6_0)
			}

			for iter_6_4, iter_6_5 in ipairs(var_6_0.exList) do
				table.insert(var_6_5, arg_6_0:getBehaviorText(iter_6_5))
			end

			arg_6_0._behaviordesc.text = table.concat(var_6_5, "\n")
		end

		if var_6_0.isToSelf or var_6_0.isToAll then
			arg_6_0._behaviortitle.text = luaLang("dicehero_behavior_buff_title")

			UISpriteSetMgr.instance:setFightSprite(arg_6_0._iconbehavior, "jnk_gj4")
			UISpriteSetMgr.instance:setFightSprite(arg_6_0._behavioricon, "jnk_gj4")
		else
			arg_6_0._behaviortitle.text = luaLang("dicehero_behavior_debuff_title")

			UISpriteSetMgr.instance:setFightSprite(arg_6_0._iconbehavior, "jnk_gj3")
			UISpriteSetMgr.instance:setFightSprite(arg_6_0._behavioricon, "jnk_gj3")
		end
	else
		gohelper.setActive(arg_6_0._iconbehavior, false)
		gohelper.setActive(arg_6_0._gobehaviormask, false)
	end
end

function var_0_0.getBehaviorText(arg_7_0, arg_7_1)
	if arg_7_1.type == 1 then
		local var_7_0 = arg_7_1.value[1] or 0
		local var_7_1 = #arg_7_1.value

		if var_7_1 > 1 then
			local var_7_2 = luaLang("multiple")

			var_7_0 = string.format("%s%s%s", var_7_1, var_7_2, var_7_0)
		end

		return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_atk"), var_7_0)
	elseif arg_7_1.type == 2 then
		local var_7_3 = arg_7_1.value[1] or 0

		if arg_7_1.isToAll then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_def_all"), var_7_3)
		elseif arg_7_1.isToFriend then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_def_friend"), var_7_3)
		else
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_def"), var_7_3)
		end
	elseif arg_7_1.type == 3 then
		local var_7_4 = tonumber(arg_7_1.value[1]) or 0
		local var_7_5 = lua_dice_buff.configDict[var_7_4]

		if var_7_5 then
			var_7_4 = string.format("<u><color=#4e6698><link=\"%s\">%s</link></color></u>", var_7_4, var_7_5.name)
		end

		if arg_7_1.isToSelf then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_buff"), var_7_4)
		elseif arg_7_1.isToAll then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_buff_all"), var_7_4)
		else
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_debuff"), var_7_4)
		end
	end
end

function var_0_0._onLinkClick(arg_8_0, arg_8_1)
	local var_8_0 = lua_dice_buff.configDict[tonumber(arg_8_1)]

	if not var_8_0 then
		return
	end

	gohelper.setActive(arg_8_0._gobehaviorbuff, true)
	UISpriteSetMgr.instance:setBuffSprite(arg_8_0._behaviorbuffimage, var_8_0.icon)

	arg_8_0._behaviorbufftitle.text = var_8_0.name
	arg_8_0._behaviorbuffdesc.text = var_8_0.desc

	if var_8_0.tag == 1 then
		gohelper.setActive(arg_8_0._behaviorbufftag, true)

		arg_8_0._behaviorbufftagName.text = luaLang("dicehero_buff")
	elseif var_8_0.tag == 2 then
		gohelper.setActive(arg_8_0._behaviorbufftag, true)

		arg_8_0._behaviorbufftagName.text = luaLang("dicehero_debuff")
	else
		gohelper.setActive(arg_8_0._behaviorbufftag, false)
	end
end

function var_0_0.refreshBuff(arg_9_0)
	local var_9_0 = arg_9_0:getHeroMo().buffs

	if #var_9_0 > 7 then
		gohelper.setActive(arg_9_0._gobuffmore, true)

		var_9_0 = {
			unpack(var_9_0, 1, 7)
		}
	else
		gohelper.setActive(arg_9_0._gobuffmore, false)
	end

	gohelper.CreateObjList(arg_9_0, arg_9_0._createBuff, var_9_0, nil, arg_9_0._buffItem)

	if arg_9_0._gozaowutip.activeSelf then
		if #var_9_0 > 0 then
			gohelper.CreateObjList(arg_9_0, arg_9_0._createSkillItem, var_9_0, nil, arg_9_0._gozaowuitem)
		else
			gohelper.setActive(arg_9_0._gozaowutip, false)
		end
	end
end

function var_0_0._createBuff(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = gohelper.findChildImage(arg_10_1, "")

	UISpriteSetMgr.instance:setBuffSprite(var_10_0, arg_10_2.co.icon)
end

function var_0_0.getHeroMo(arg_11_0)
	return arg_11_0.data
end

function var_0_0.addHp(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getHeroMo()

	var_12_0:setHp(var_12_0.hp + arg_12_1)
	arg_12_0:refreshInfo()
	gohelper.setActive(arg_12_0._godeadeffect, var_12_0.hp <= 0)

	if var_12_0.hp <= 0 then
		gohelper.setActive(arg_12_0._iconbehavior, false)
		gohelper.setActive(arg_12_0._gobehaviormask, false)
		arg_12_0:refreshBuff()
	end
end

function var_0_0.addShield(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getHeroMo()

	var_13_0.shield = var_13_0.shield + arg_13_1

	arg_13_0:refreshInfo()
end

function var_0_0.addOrUpdateBuff(arg_14_0, arg_14_1)
	arg_14_0:getHeroMo():addOrUpdateBuff(arg_14_1)
	arg_14_0:refreshBuff()
end

function var_0_0.removeBuff(arg_15_0, arg_15_1)
	arg_15_0:getHeroMo():removeBuff(arg_15_1)
	arg_15_0:refreshBuff()
end

function var_0_0.refreshInfo(arg_16_0)
	local var_16_0 = arg_16_0:getHeroMo()
	local var_16_1 = var_16_0.hp
	local var_16_2 = var_16_0.maxHp
	local var_16_3 = var_16_0.shield
	local var_16_4 = var_16_0.maxShield

	ZProj.TweenHelper.DOFillAmount(arg_16_0._hpSlider, var_16_2 > 0 and var_16_1 / var_16_2 or 0, 0.2)
	ZProj.TweenHelper.DOFillAmount(arg_16_0._shieldSlider, var_16_4 > 0 and var_16_3 / var_16_4 or 0, 0.2)

	arg_16_0._hpNum.text = var_16_1
	arg_16_0._shieldNum.text = var_16_3
end

function var_0_0._onClickEnemy(arg_17_0)
	DiceHeroFightModel.instance:getGameData():setCurEnemy(arg_17_0.data)
end

function var_0_0._onSkillCardSelectChange(arg_18_0)
	local var_18_0 = DiceHeroFightModel.instance:getGameData()

	gohelper.setActive(arg_18_0._goselect, var_18_0.curSelectEnemyMo == arg_18_0.data)
end

function var_0_0._showBuff(arg_19_0)
	if arg_19_0._gozaowutip.activeSelf then
		gohelper.setActive(arg_19_0._gozaowutip, false)

		return
	end

	gohelper.setActive(arg_19_0._gofighttips, false)

	local var_19_0 = arg_19_0:getHeroMo().buffs

	if not var_19_0[1] then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	gohelper.setActive(arg_19_0._gozaowutip, true)
	gohelper.CreateObjList(arg_19_0, arg_19_0._createSkillItem, var_19_0, nil, arg_19_0._gozaowuitem)
end

function var_0_0.showBehavior(arg_20_0)
	if arg_20_0._gofighttips.activeSelf then
		gohelper.setActive(arg_20_0._gofighttips, false)

		return
	end

	gohelper.setActive(arg_20_0._gozaowutip, false)

	if not arg_20_0:getHeroMo().behaviors.type then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	gohelper.setActive(arg_20_0._gofighttips, true)
	gohelper.setActive(arg_20_0._gobehaviorbuff, false)
end

function var_0_0.hideBehavior(arg_21_0)
	gohelper.setActive(arg_21_0._gozaowutip, false)
	gohelper.setActive(arg_21_0._gofighttips, false)
end

function var_0_0._createSkillItem(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = gohelper.findChildTextMesh(arg_22_1, "name/#txt_name")
	local var_22_1 = gohelper.findChildImage(arg_22_1, "name/#simage_icon")
	local var_22_2 = gohelper.findChildTextMesh(arg_22_1, "#txt_desc")
	local var_22_3 = gohelper.findChildTextMesh(arg_22_1, "name/#txt_layer")
	local var_22_4 = gohelper.findChild(arg_22_1, "name/#txt_name/#go_tag")
	local var_22_5 = gohelper.findChildTextMesh(arg_22_1, "name/#txt_name/#go_tag/#txt_name")

	if arg_22_2.co.damp >= 0 and arg_22_2.co.damp <= 4 then
		var_22_3.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_buff_" .. arg_22_2.co.damp), arg_22_2.layer)
	else
		var_22_3.text = ""
	end

	UISpriteSetMgr.instance:setBuffSprite(var_22_1, arg_22_2.co.icon)

	var_22_0.text = arg_22_2.co.name
	var_22_2.text = arg_22_2.co.desc

	if arg_22_2.co.tag == 1 then
		gohelper.setActive(var_22_4, true)

		var_22_5.text = luaLang("dicehero_buff")
	elseif arg_22_2.co.tag == 2 then
		gohelper.setActive(var_22_4, true)

		var_22_5.text = luaLang("dicehero_debuff")
	else
		gohelper.setActive(var_22_4, false)
	end
end

function var_0_0.onTouchScreen(arg_23_0)
	if arg_23_0._gozaowutip.activeSelf then
		if gohelper.isMouseOverGo(arg_23_0._gozaowutip) and gohelper.isMouseOverGo(arg_23_0._gozaowuitem.transform.parent) or gohelper.isMouseOverGo(arg_23_0._btnClickBuff) then
			return
		end

		gohelper.setActive(arg_23_0._gozaowutip, false)
	elseif arg_23_0._gofighttips.activeSelf then
		if gohelper.isMouseOverGo(arg_23_0._gofighttips) or gohelper.isMouseOverGo(arg_23_0._btnClickBehavior) then
			return
		end

		gohelper.setActive(arg_23_0._gofighttips, false)
	end
end

function var_0_0.getPos(arg_24_0, arg_24_1)
	if arg_24_1 == 1 then
		return arg_24_0._shieldSlider.transform.position
	end

	return arg_24_0._headbgTrans.position
end

function var_0_0.playHitAnim(arg_25_0)
	arg_25_0._headbgAnim:Play("hit", 0, 0)
end

function var_0_0.showEffect(arg_26_0, arg_26_1)
	gohelper.setActive(arg_26_0._gobuffeffect, false)
	gohelper.setActive(arg_26_0._godebuffeffect, false)
	gohelper.setActive(arg_26_0._goshieldeffect, false)
	gohelper.setActive(arg_26_0._godamageeffect, false)
	gohelper.setActive(arg_26_0._gobuffeffect, arg_26_1 == 1)
	gohelper.setActive(arg_26_0._godebuffeffect, arg_26_1 == 2)
	gohelper.setActive(arg_26_0._goshieldeffect, arg_26_1 == 3)
	gohelper.setActive(arg_26_0._godamageeffect, arg_26_1 == 4)
end

function var_0_0.onDestroy(arg_27_0)
	DiceHeroHelper.instance:unregisterEntity(arg_27_0.data.uid)
end

return var_0_0
