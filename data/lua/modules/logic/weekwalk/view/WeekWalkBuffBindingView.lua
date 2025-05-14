module("modules.logic.weekwalk.view.WeekWalkBuffBindingView", package.seeall)

local var_0_0 = class("WeekWalkBuffBindingView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorolecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer")
	arg_1_0._scrollcard = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_rolecontainer/#scroll_card")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._goadventuretarotitem = gohelper.findChild(arg_1_0.viewGO, "#go_adventuretarotitem")
	arg_1_0._goselectheroitem1 = gohelper.findChild(arg_1_0.viewGO, "#go_selectheroitem1")
	arg_1_0._goselectheroitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_selectheroitem2")
	arg_1_0._txteffect = gohelper.findChildText(arg_1_0.viewGO, "#scroll_effects/Viewport/Content/#txt_effect")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_cancel")
	arg_1_0._goattreffect = gohelper.findChild(arg_1_0.viewGO, "#go_attreffect")
	arg_1_0._goattritem = gohelper.findChild(arg_1_0.viewGO, "#go_attreffect/#go_attritem")
	arg_1_0._scrolleffects = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_effects")
	arg_1_0._txtdesitem = gohelper.findChildText(arg_1_0.viewGO, "#scroll_effects/Viewport/Content/#txt_desitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
end

function var_0_0._btncancelOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnconfirmOnClick(arg_5_0)
	if not arg_5_0._hero1Info then
		GameFacade.showToast(ToastEnum.WeekWalkBuffBinding1)

		return
	end

	if not arg_5_0._hero2Info then
		GameFacade.showToast(ToastEnum.WeekWalkBuffBinding2)

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.WeekWalkPray, MsgBoxEnum.BoxType.Yes_No, function()
		WeekwalkRpc.instance:sendWeekwalkBuffRequest(arg_5_0._buffId, arg_5_0._hero1Info.heroId, arg_5_0._hero2Info.heroId)
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnConfirmBindingBuff)
	end, nil, nil, nil, nil, nil, arg_5_0._hero1Info.config.name, arg_5_0._hero2Info.config.name)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._imgBg = gohelper.findChildSingleImage(arg_7_0.viewGO, "bg/bgimg")

	arg_7_0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/juesebeibao_005"))
	HeroGroupEditListModel.instance:setParam(nil, WeekWalkModel.instance:getInfo())
	gohelper.addUIClickAudio(arg_7_0._btnconfirm.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	gohelper.addUIClickAudio(arg_7_0._btncancel.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0._initHeroItems(arg_9_0)
	arg_9_0._heroItem1 = IconMgr.instance:getCommonHeroItem(arg_9_0._goselectheroitem1)

	gohelper.setActive(arg_9_0._heroItem1.go, false)
	arg_9_0._heroItem1:setLevelContentShow(false)
	arg_9_0._heroItem1:setNameContentShow(false)
	arg_9_0._heroItem1:addEventListeners()
	arg_9_0._heroItem1:addClickListener(arg_9_0._onHeroItem1Click, arg_9_0)

	arg_9_0._hero1Info = nil
	arg_9_0._heroItem2 = IconMgr.instance:getCommonHeroItem(arg_9_0._goselectheroitem2)

	gohelper.setActive(arg_9_0._heroItem2.go, false)
	arg_9_0._heroItem2:setLevelContentShow(false)
	arg_9_0._heroItem2:setNameContentShow(false)
	arg_9_0._heroItem2:addEventListeners()
	arg_9_0._heroItem2:addClickListener(arg_9_0._onHeroItem2Click, arg_9_0)

	arg_9_0._hero2Info = nil
end

function var_0_0._onHeroItem1Click(arg_10_0, arg_10_1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)

	arg_10_0._hero1Info = nil

	arg_10_0:_selectHeroitem()
	arg_10_0:_showEffect()
end

function var_0_0._onHeroItem2Click(arg_11_0, arg_11_1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)

	arg_11_0._hero2Info = nil

	arg_11_0:_selectHeroitem()
end

function var_0_0._initParams(arg_12_0)
	arg_12_0._buffId = arg_12_0.viewParam.tarotId
	arg_12_0._buffConfig = lua_weekwalk_buff.configDict[arg_12_0._buffId]
	arg_12_0._prayId = tonumber(arg_12_0._buffConfig.param)
	arg_12_0._prayConfig = lua_weekwalk_pray.configDict[arg_12_0._prayId]
	arg_12_0._sacrificeLimitLevel = 0
	arg_12_0._sacrificeLimitCareer = 0
	arg_12_0._sacrificeLimitHeroId = 0

	local var_12_0 = GameUtil.splitString2(arg_12_0._prayConfig.sacrificeLimit, true, "|", "#")

	if var_12_0 then
		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			local var_12_1 = iter_12_1[1]
			local var_12_2 = iter_12_1[2]

			if var_12_1 == 1 then
				arg_12_0._sacrificeLimitCareer = var_12_2
			elseif var_12_1 == 2 then
				arg_12_0._sacrificeLimitLevel = var_12_2
			elseif var_12_1 == 3 then
				arg_12_0._sacrificeLimitHeroId = var_12_2
			end
		end
	end

	arg_12_0._blessingLimit = arg_12_0._prayConfig.blessingLimit == "1"
	arg_12_0._effectMap = {}

	local var_12_3 = GameUtil.splitString2(arg_12_0._prayConfig.effect, true, "|", "#")

	for iter_12_2, iter_12_3 in ipairs(var_12_3) do
		local var_12_4 = iter_12_3[1]
		local var_12_5 = iter_12_3[2]
		local var_12_6 = iter_12_3[3]

		if var_12_4 == WeekWalkEnum.SacrificeEffectType.BaseAttr then
			arg_12_0._effectMap[var_12_4] = var_12_5 / 1000
		elseif var_12_4 == WeekWalkEnum.SacrificeEffectType.ExAttr then
			arg_12_0._effectMap[var_12_4] = {
				var_12_5,
				var_12_6 / 1000
			}
		elseif var_12_4 == WeekWalkEnum.SacrificeEffectType.PassiveSkill then
			arg_12_0._effectMap[var_12_4] = var_12_5
		end
	end
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0:_initParams()
	arg_13_0:_initHeroItems()
	arg_13_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, arg_13_0._onHeroItemClick, arg_13_0)
	arg_13_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.TarotReply, arg_13_0._onTarotReply, arg_13_0)
	arg_13_0:_onHeroItemClick(nil)
end

function var_0_0._updateCardList(arg_14_0)
	if not arg_14_0._hero1Info or arg_14_0._hero2Info and arg_14_0._lastSetHeroInfo == arg_14_0._hero1Info then
		arg_14_0._selectHero1 = true

		WeekWalkCardListModel.instance:setCardList(arg_14_0._sacrificeLimitCareer, arg_14_0._sacrificeLimitLevel, arg_14_0._hero1Info, arg_14_0._hero2Info, arg_14_0._sacrificeLimitHeroId)

		return
	end

	if not arg_14_0._hero2Info or arg_14_0._lastSetHeroInfo == arg_14_0._hero2Info then
		local var_14_0 = arg_14_0._hero1Info.config.career
		local var_14_1 = arg_14_0._blessingLimit and var_14_0 or 0

		arg_14_0._selectHero1 = false

		WeekWalkCardListModel.instance:setCardList(var_14_1, 0, arg_14_0._hero1Info, arg_14_0._hero2Info, 0)
	end
end

function var_0_0._verifyHero2(arg_15_0)
	if not arg_15_0._hero1Info or not arg_15_0._hero2Info then
		return
	end

	local var_15_0 = arg_15_0._hero1Info.config.career
	local var_15_1 = arg_15_0._blessingLimit and var_15_0 or 0
	local var_15_2 = WeekWalkCardListModel.instance:getCardList(var_15_1, 0, arg_15_0._hero1Info, nil, 0)

	for iter_15_0, iter_15_1 in ipairs(var_15_2) do
		if iter_15_1 == arg_15_0._hero2Info then
			return
		end
	end

	arg_15_0._hero2Info = nil
end

function var_0_0._showEffect(arg_16_0)
	local var_16_0 = arg_16_0._hero1Info

	for iter_16_0, iter_16_1 in pairs(arg_16_0._effectMap) do
		if var_16_0 and iter_16_0 == WeekWalkEnum.SacrificeEffectType.BaseAttr then
			local var_16_1 = iter_16_1
			local var_16_2 = var_16_0.baseAttr
			local var_16_3 = {
				102,
				101,
				103,
				104,
				105
			}

			for iter_16_2, iter_16_3 in ipairs(var_16_3) do
				local var_16_4 = var_16_0:getAttrValueWithoutTalentByID(iter_16_3) * var_16_1
				local var_16_5 = math.floor(var_16_4)

				if var_16_5 > 0 then
					local var_16_6 = HeroConfig.instance:getHeroAttributeCO(var_16_3[iter_16_2])
					local var_16_7 = arg_16_0:_getAttributeItem(iter_16_2)

					gohelper.setActive(var_16_7.go, true)

					local var_16_8 = "icon_att_" .. tostring(var_16_3[iter_16_2])

					arg_16_0:_showAttribute(var_16_7, var_16_6.name, var_16_8, var_16_5)
				end
			end
		elseif var_16_0 and iter_16_0 == WeekWalkEnum.SacrificeEffectType.ExAttr then
			local var_16_9 = iter_16_1[1]
			local var_16_10 = iter_16_1[2]
			local var_16_11 = HeroConfig.instance:getHeroAttributeCO(var_16_9)
			local var_16_12 = var_16_0:getTalentGain()
			local var_16_13 = HeroConfig.instance:talentGainTab2IDTab(var_16_12)[var_16_11.id]
			local var_16_14 = var_16_13 and var_16_13.value * var_16_10 / 10 or 0
			local var_16_15 = arg_16_0:_getAttributeItem(1)

			gohelper.setActive(var_16_15.go, true)

			local var_16_16 = "icon_att_" .. tostring(var_16_11.id)

			arg_16_0:_showAttribute(var_16_15, var_16_11.name, var_16_16, var_16_14, true)
		elseif iter_16_0 == WeekWalkEnum.SacrificeEffectType.PassiveSkill then
			local var_16_17 = tonumber(iter_16_1)
			local var_16_18 = lua_skill.configDict[var_16_17].desc

			arg_16_0._txteffect.text = HeroSkillModel.instance:skillDesToSpot(var_16_18, "#B64F44", "#3C5784")

			local var_16_19 = arg_16_0:_getEffectDesc(var_16_18)

			if var_16_19 and #var_16_19 > 0 then
				arg_16_0._effectDesItems = arg_16_0._effectDesItems or arg_16_0:getUserDataTb_()

				for iter_16_4, iter_16_5 in ipairs(var_16_19) do
					local var_16_20 = arg_16_0._effectDesItems[iter_16_4]

					if not var_16_20 then
						local var_16_21 = gohelper.cloneInPlace(arg_16_0._txtdesitem.gameObject, "des_" .. iter_16_4)

						table.insert(arg_16_0._effectDesItems, var_16_21)

						var_16_20 = var_16_21
					end

					gohelper.setActive(var_16_20, true)

					var_16_20:GetComponent(gohelper.Type_TextMesh).text = iter_16_5
				end
			end

			local var_16_22 = var_16_19 and #var_16_19 + 1 or 1

			if arg_16_0._effectDesItems then
				for iter_16_6 = var_16_22, #arg_16_0._effectDesItems do
					gohelper.setActive(arg_16_0._effectDesItems[iter_16_6], false)
				end
			end
		end

		gohelper.setActive(arg_16_0._scrolleffects.gameObject, var_16_0 and iter_16_0 == WeekWalkEnum.SacrificeEffectType.PassiveSkill)
		gohelper.setActive(arg_16_0._goattreffect, var_16_0 and iter_16_0 ~= WeekWalkEnum.SacrificeEffectType.PassiveSkill)
	end

	if var_16_0 and (type == WeekWalkEnum.SacrificeEffectType.ExAttr or type == WeekWalkEnum.SacrificeEffectType.BaseAttr) then
		for iter_16_7 = #arg_16_0._effectMap + 1, #arg_16_0._attributeItems do
			gohelper.setActive(arg_16_0._attributeItems[iter_16_7], false)
		end
	end
end

function var_0_0._getAttributeItem(arg_17_0, arg_17_1)
	arg_17_0._attributeItems = arg_17_0._attributeItems or {}

	local var_17_0 = arg_17_0._attributeItems[arg_17_1]

	if not var_17_0 then
		local var_17_1 = arg_17_0:getUserDataTb_()

		var_17_1.go = gohelper.cloneInPlace(arg_17_0._goattritem, "attribute" .. arg_17_1)
		var_17_1.iconImg = gohelper.findChildImage(var_17_1.go, "icon")
		var_17_1.nameTxt = gohelper.findChildText(var_17_1.go, "name")
		var_17_1.valueTxt = gohelper.findChildText(var_17_1.go, "value")

		table.insert(arg_17_0._attributeItems, var_17_1)

		var_17_0 = var_17_1
	end

	return var_17_0
end

function var_0_0._showAttribute(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	if not arg_18_1 then
		return
	end

	arg_18_1.nameTxt.text = arg_18_2

	UISpriteSetMgr.instance:setCommonSprite(arg_18_1.iconImg, arg_18_3)

	arg_18_1.valueTxt.text = arg_18_4

	if arg_18_5 then
		arg_18_1.valueTxt.text = string.format("%s%%", math.floor(arg_18_4))
	end
end

function var_0_0._selectHeroitem(arg_19_0)
	if arg_19_0._hero1Info then
		arg_19_0._heroItem1:onUpdateMO(arg_19_0._hero1Info)
	end

	if arg_19_0._hero2Info then
		arg_19_0._heroItem2:onUpdateMO(arg_19_0._hero2Info)
	end

	gohelper.setActive(arg_19_0._heroItem1.go, arg_19_0._hero1Info)
	gohelper.setActive(arg_19_0._heroItem2.go, arg_19_0._hero2Info)
	arg_19_0:_updateCardList()
end

function var_0_0._onTarotReply(arg_20_0)
	arg_20_0:closeThis()
end

function var_0_0._onHeroItemClick(arg_21_0, arg_21_1)
	if arg_21_1 then
		if WeekWalkModel.instance:getInfo():getHeroHp(arg_21_1.heroId) <= 0 then
			return
		end

		if arg_21_0._hero1Info and arg_21_0._hero2Info then
			-- block empty
		end

		if not arg_21_0._hero1Info or arg_21_0._selectHero1 then
			arg_21_0._hero1Info = arg_21_1

			arg_21_0:_verifyHero2()
		elseif not arg_21_0._hero2Info or not arg_21_0._selectHero1 then
			arg_21_0._hero2Info = arg_21_1
		end

		arg_21_0._lastSetHeroInfo = arg_21_1
	end

	arg_21_0:_showEffect()
	arg_21_0:_selectHeroitem()
end

function var_0_0._getEffectDesc(arg_22_0, arg_22_1)
	if string.nilorempty(arg_22_1) then
		return nil
	end

	local var_22_0 = HeroSkillModel.instance:getEffectTagIDsFromDescRecursion(arg_22_1)
	local var_22_1 = {}

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		local var_22_2 = SkillConfig.instance:processSkillDesKeyWords(SkillConfig.instance:getSkillEffectDescCo(iter_22_1).desc)
		local var_22_3 = SkillConfig.instance:processSkillDesKeyWords(SkillConfig.instance:getSkillEffectDescCo(iter_22_1).name)
		local var_22_4 = string.format("[%s]:%s", var_22_3, var_22_2)
		local var_22_5 = HeroSkillModel.instance:skillDesToSpot(var_22_4, "#B64F44", "#3C5784")

		table.insert(var_22_1, var_22_5)
	end

	return var_22_1
end

function var_0_0.onClose(arg_23_0)
	return
end

function var_0_0.onDestroyView(arg_24_0)
	arg_24_0._imgBg:UnLoadImage()

	arg_24_0._attributeItems = nil
end

return var_0_0
