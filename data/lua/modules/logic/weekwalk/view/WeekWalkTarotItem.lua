module("modules.logic.weekwalk.view.WeekWalkTarotItem", package.seeall)

local var_0_0 = class("WeekWalkTarotItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg/#simage_icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#simage_bg/#txt_name")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#simage_bg/#txt_desc")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#simage_bg/#btn_click")
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "#go_tip")
	arg_1_0._btnclosetip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_tip/#btn_closetip")
	arg_1_0._txtheronamecn = gohelper.findChildText(arg_1_0.viewGO, "#go_tip/#txt_heronamecn")
	arg_1_0._txtheronameen = gohelper.findChildText(arg_1_0.viewGO, "#go_tip/#txt_heronamecn/#txt_heronameen")
	arg_1_0._txteffect = gohelper.findChildText(arg_1_0.viewGO, "#go_tip/#scroll_effects/Viewport/Content/#txt_effect")
	arg_1_0._goattreffect = gohelper.findChild(arg_1_0.viewGO, "#go_tip/#go_attreffect")
	arg_1_0._goattritem = gohelper.findChild(arg_1_0.viewGO, "#go_tip/#go_attreffect/#go_attritem")
	arg_1_0._scrolleffects = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_tip/#scroll_effects")
	arg_1_0._txtdesitem = gohelper.findChildText(arg_1_0.viewGO, "#go_tip/#scroll_effects/Viewport/Content/#txt_desitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)

	if arg_2_0._btnclosetip then
		arg_2_0._btnclosetip:AddClickListener(arg_2_0._btnclosetipOnClick, arg_2_0)
	end
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()

	if arg_3_0._btnclosetip then
		arg_3_0._btnclosetip:RemoveClickListener()
	end
end

function var_0_0._btnclosetipOnClick(arg_4_0)
	gohelper.setActive(arg_4_0._gotip, false)
end

function var_0_0._btnclickOnClick(arg_5_0)
	if arg_5_0._isSelectTarotView then
		arg_5_0._callback(arg_5_0._callbackObj, arg_5_0)
		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_fight_choosecard)
	elseif arg_5_0._config.type == WeekWalkEnum.BuffType.Pray then
		arg_5_0:_showPrayInfo()
	end
end

function var_0_0._showPrayInfo(arg_6_0)
	local var_6_0 = WeekWalkModel.instance:getInfo():getPrayInfo()

	if not var_6_0 then
		return
	end

	gohelper.setActive(arg_6_0._gotip, true)

	local var_6_1 = HeroConfig.instance:getHeroCO(var_6_0.blessingHeroId)

	arg_6_0._txtheronamecn.text = var_6_1.name
	arg_6_0._txtheronameen.text = var_6_1.nameEng

	arg_6_0:_initParams()
	arg_6_0:_showEffect(var_6_0.sacrificeHeroId)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._callback = nil
	arg_7_0._callbackObj = nil
	arg_7_0._callbackParam = nil
	arg_7_0._uimeshGo = gohelper.findChild(arg_7_0.viewGO, "#simage_bg/mesh")
	arg_7_0._anim = arg_7_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_7_0._canvasgroup = arg_7_0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.removeUIClickAudio(arg_7_0._btnclick.gameObject)
end

function var_0_0._editableAddEvents(arg_8_0)
	arg_8_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnClickTarot, arg_8_0._playAnimWhenClick, arg_8_0)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_8_0._playAnimWhenEnter, arg_8_0)
end

function var_0_0._editableRemoveEvents(arg_9_0)
	arg_9_0:removeEventCb(WeekWalkController.instance, WeekWalkEvent.OnClickTarot, arg_9_0._playAnimWhenClick, arg_9_0)
	arg_9_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_9_0._playAnimWhenEnter, arg_9_0)
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.info = arg_10_1
	arg_10_0._isSelectTarotView = arg_10_2

	arg_10_0:_refreshUI()
end

function var_0_0._refreshUI(arg_11_0)
	local var_11_0 = lua_weekwalk_buff.configDict[arg_11_0.info.tarotId]

	arg_11_0._config = var_11_0
	arg_11_0._txtname.text = var_11_0.name
	arg_11_0._txtdesc.text = HeroSkillModel.instance:skillDesToSpot(var_11_0.desc, "#924840", "#30466A")
	arg_11_0._tarotItemBgUrl = arg_11_0._tarotItemBgUrl or ResUrl.getWeekWalkTarotIcon("k" .. var_11_0.rare)

	if arg_11_0._isSelectTarotView and arg_11_0._isSelectTarotView == true then
		arg_11_0:_loadTarotItemBg()
	else
		arg_11_0._simagebg:LoadImage(arg_11_0._tarotItemBgUrl)
	end

	arg_11_0._simageicon:LoadImage(ResUrl.getWeekWalkTarotIcon(tostring(var_11_0.icon)))

	arg_11_0._canvasgroup.interactable = true
end

function var_0_0._loadTarotItemBg(arg_12_0)
	if not arg_12_0._textureLoader then
		arg_12_0._textureLoader = MultiAbLoader.New()

		arg_12_0._textureLoader:addPath(arg_12_0._tarotItemBgUrl)
		arg_12_0._textureLoader:startLoad(arg_12_0._loadTarotItemBgCB, arg_12_0)
	end
end

function var_0_0._loadTarotItemBgCB(arg_13_0)
	local var_13_0 = arg_13_0._textureLoader:getAssetItem(arg_13_0._tarotItemBgUrl):GetResource(arg_13_0._tarotItemBgUrl)

	arg_13_0._uimeshGo:GetComponent(typeof(UIMesh)).texture = var_13_0
	arg_13_0._uimeshGo.gameObject:GetComponent(typeof(UnityEngine.Animation)).enabled = true
end

function var_0_0.setClickCallback(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._callback = arg_14_1
	arg_14_0._callbackObj = arg_14_2
end

function var_0_0.onDestroyView(arg_15_0)
	arg_15_0._simagebg:UnLoadImage()
	arg_15_0._simageicon:UnLoadImage()

	if arg_15_0._textureLoader then
		arg_15_0._textureLoader:dispose()

		arg_15_0._textureLoader = nil
	end
end

function var_0_0._initParams(arg_16_0)
	local var_16_0 = arg_16_0.info.tarotId

	if var_16_0 == arg_16_0._buffId then
		return
	end

	arg_16_0._buffId = var_16_0
	arg_16_0._buffConfig = lua_weekwalk_buff.configDict[arg_16_0._buffId]
	arg_16_0._prayId = tonumber(arg_16_0._buffConfig.param)
	arg_16_0._prayConfig = lua_weekwalk_pray.configDict[arg_16_0._prayId]
	arg_16_0._sacrificeLimitLevel = 0
	arg_16_0._sacrificeLimitCareer = 0
	arg_16_0._sacrificeLimitHeroId = 0

	local var_16_1 = GameUtil.splitString2(arg_16_0._prayConfig.sacrificeLimit, true, "|", "#")

	if var_16_1 then
		for iter_16_0, iter_16_1 in ipairs(var_16_1) do
			local var_16_2 = iter_16_1[1]
			local var_16_3 = iter_16_1[2]

			if var_16_2 == 1 then
				arg_16_0._sacrificeLimitCareer = var_16_3
			elseif var_16_2 == 2 then
				arg_16_0._sacrificeLimitLevel = var_16_3
			elseif var_16_2 == 3 then
				arg_16_0._sacrificeLimitHeroId = var_16_3
			end
		end
	end

	arg_16_0._blessingLimit = arg_16_0._prayConfig.blessingLimit == "1"
	arg_16_0._effectMap = {}

	local var_16_4 = GameUtil.splitString2(arg_16_0._prayConfig.effect, true, "|", "#")

	for iter_16_2, iter_16_3 in ipairs(var_16_4) do
		local var_16_5 = iter_16_3[1]
		local var_16_6 = iter_16_3[2]
		local var_16_7 = iter_16_3[3]

		if var_16_5 == WeekWalkEnum.SacrificeEffectType.BaseAttr then
			arg_16_0._effectMap[var_16_5] = var_16_6 / 1000
		elseif var_16_5 == WeekWalkEnum.SacrificeEffectType.ExAttr then
			arg_16_0._effectMap[var_16_5] = {
				var_16_6,
				var_16_7 / 1000
			}
		elseif var_16_5 == WeekWalkEnum.SacrificeEffectType.PassiveSkill then
			arg_16_0._effectMap[var_16_5] = var_16_6
		end
	end
end

function var_0_0._showEffect(arg_17_0, arg_17_1)
	if arg_17_1 == arg_17_0._sacrificeHeroId then
		return
	end

	arg_17_0._sacrificeHeroId = arg_17_1

	local var_17_0 = HeroModel.instance:getByHeroId(arg_17_1)

	for iter_17_0, iter_17_1 in pairs(arg_17_0._effectMap) do
		if var_17_0 and iter_17_0 == WeekWalkEnum.SacrificeEffectType.BaseAttr then
			local var_17_1 = iter_17_1
			local var_17_2 = var_17_0.baseAttr
			local var_17_3 = {
				102,
				101,
				103,
				104,
				105
			}

			for iter_17_2, iter_17_3 in ipairs(var_17_3) do
				local var_17_4 = var_17_0:getAttrValueWithoutTalentByID(iter_17_3) * var_17_1
				local var_17_5 = math.floor(var_17_4)

				if var_17_5 > 0 then
					local var_17_6 = HeroConfig.instance:getHeroAttributeCO(iter_17_3)
					local var_17_7 = arg_17_0:_getAttributeItem(iter_17_2)

					gohelper.setActive(var_17_7.go, true)

					local var_17_8 = "icon_att_" .. tostring(iter_17_3)

					arg_17_0:_showAttribute(var_17_7, var_17_6.name, var_17_8, var_17_5)
				end
			end
		elseif var_17_0 and iter_17_0 == WeekWalkEnum.SacrificeEffectType.ExAttr then
			local var_17_9 = iter_17_1[1]
			local var_17_10 = iter_17_1[2]
			local var_17_11 = HeroConfig.instance:getHeroAttributeCO(var_17_9)
			local var_17_12 = var_17_0:getTalentGain()
			local var_17_13 = HeroConfig.instance:talentGainTab2IDTab(var_17_12)[var_17_11.id]
			local var_17_14 = var_17_13 and var_17_13.value * var_17_10 / 10 or 0
			local var_17_15 = arg_17_0:_getAttributeItem(1)

			gohelper.setActive(var_17_15.go, true)

			local var_17_16 = "icon_att_" .. tostring(var_17_11.id)

			arg_17_0:_showAttribute(var_17_15, var_17_11.name, var_17_16, var_17_14, true)
		elseif iter_17_0 == WeekWalkEnum.SacrificeEffectType.PassiveSkill then
			local var_17_17 = tonumber(iter_17_1)
			local var_17_18 = lua_skill.configDict[var_17_17].desc

			arg_17_0._txteffect.text = HeroSkillModel.instance:skillDesToSpot(var_17_18, "#B64F44", "#3C5784")

			local var_17_19 = arg_17_0:_getEffectDesc(var_17_18)

			if var_17_19 and #var_17_19 > 0 then
				for iter_17_4, iter_17_5 in ipairs(var_17_19) do
					local var_17_20 = gohelper.cloneInPlace(arg_17_0._txtdesitem.gameObject, "des_" .. iter_17_4)

					gohelper.setActive(var_17_20, true)

					var_17_20:GetComponent(gohelper.Type_TextMesh).text = iter_17_5
				end
			end
		end

		gohelper.setActive(arg_17_0._scrolleffects.gameObject, var_17_0 and iter_17_0 == WeekWalkEnum.SacrificeEffectType.PassiveSkill)
		gohelper.setActive(arg_17_0._goattreffect, var_17_0 and iter_17_0 ~= WeekWalkEnum.SacrificeEffectType.PassiveSkill)
	end
end

function var_0_0._getAttributeItem(arg_18_0, arg_18_1)
	arg_18_0._attributeItems = arg_18_0._attributeItems or {}

	local var_18_0 = arg_18_0._attributeItems[arg_18_1]

	if not var_18_0 then
		local var_18_1 = arg_18_0:getUserDataTb_()

		var_18_1.go = gohelper.cloneInPlace(arg_18_0._goattritem, "attribute" .. arg_18_1)
		var_18_1.iconImg = gohelper.findChildImage(var_18_1.go, "icon")
		var_18_1.nameTxt = gohelper.findChildText(var_18_1.go, "name")
		var_18_1.valueTxt = gohelper.findChildText(var_18_1.go, "value")

		table.insert(arg_18_0._attributeItems, var_18_1)

		var_18_0 = var_18_1
	end

	return var_18_0
end

function var_0_0._showAttribute(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	if not arg_19_1 then
		return
	end

	arg_19_1.nameTxt.text = arg_19_2

	UISpriteSetMgr.instance:setCommonSprite(arg_19_1.iconImg, arg_19_3)

	arg_19_1.valueTxt.text = arg_19_4

	if arg_19_5 then
		arg_19_1.valueTxt.text = string.format("%s%%", math.floor(arg_19_4))
	end
end

function var_0_0._playAnimWhenClick(arg_20_0, arg_20_1)
	if arg_20_0.viewGO == arg_20_1 then
		arg_20_0._anim:Play(UIAnimationName.Selected, 0, 0)
	else
		arg_20_0._anim:Play("out", 0, 0)
	end

	arg_20_0._canvasgroup.interactable = false
end

function var_0_0._playAnimWhenEnter(arg_21_0, arg_21_1)
	if arg_21_1 == ViewName.WeekWalkBuffBindingView then
		arg_21_0._anim:Play("in", 0, 0)

		arg_21_0._canvasgroup.interactable = true
	end
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

return var_0_0
