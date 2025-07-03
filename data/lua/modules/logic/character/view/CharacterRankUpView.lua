module("modules.logic.character.view.CharacterRankUpView", package.seeall)

local var_0_0 = class("CharacterRankUpView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebgimg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bgimg")
	arg_1_0._simagecenterbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_centerbg")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gospineContainer = gohelper.findChild(arg_1_0.viewGO, "spineContainer")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "spineContainer/#go_spine")
	arg_1_0._goitems = gohelper.findChild(arg_1_0.viewGO, "#go_items")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#go_items/#go_item")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "#go_items/level/#txt_level")
	arg_1_0._txtcount = gohelper.findChildText(arg_1_0.viewGO, "#go_items/level/#txt_count")
	arg_1_0._goranknormal = gohelper.findChild(arg_1_0.viewGO, "rank/#go_ranknormal")
	arg_1_0._goranklarge = gohelper.findChild(arg_1_0.viewGO, "rank/#go_ranklarge")
	arg_1_0._goeffect = gohelper.findChild(arg_1_0.viewGO, "#go_effect")
	arg_1_0._btnupgrade = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_upgrade")
	arg_1_0._goupgradeeffect = gohelper.findChild(arg_1_0.viewGO, "#btn_upgrade/#go_levelupbeffect")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnupgrade:AddClickListener(arg_2_0._btnupgradeOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnupgrade:RemoveClickListener()
end

var_0_0.characterTalentLevel = {
	[2] = 10,
	[3] = 15
}

function var_0_0._btnupgradeOnClick(arg_4_0)
	if not CharacterModel.instance:isHeroRankReachCeil(arg_4_0.viewParam.heroId) then
		local var_4_0 = SkillConfig.instance:getherorankCO(arg_4_0.viewParam.heroId, arg_4_0.viewParam.rank + 1)
		local var_4_1 = string.split(var_4_0.consume, "|")
		local var_4_2 = {}

		for iter_4_0 = 1, #var_4_1 do
			local var_4_3 = string.splitToNumber(var_4_1[iter_4_0], "#")
			local var_4_4 = {
				type = var_4_3[1],
				id = var_4_3[2],
				quantity = var_4_3[3]
			}

			table.insert(var_4_2, var_4_4)
		end

		local var_4_5 = 0
		local var_4_6 = string.split(var_4_0.requirement, "|")

		for iter_4_1, iter_4_2 in pairs(var_4_6) do
			local var_4_7 = string.split(iter_4_2, "#")

			if var_4_7[1] == "1" then
				var_4_5 = tonumber(var_4_7[2])
			end
		end

		if var_4_5 > arg_4_0.viewParam.level then
			GameFacade.showToast(ToastEnum.CharacterRankUp)

			return
		end

		local var_4_8, var_4_9, var_4_10 = ItemModel.instance:hasEnoughItems(var_4_2)

		if not var_4_9 then
			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_4_10, var_4_8)

			return
		end

		local var_4_11 = HeroConfig.instance:getHeroCO(arg_4_0.viewParam.heroId).name

		GameFacade.showMessageBox(MessageBoxIdDefine.CharacterRankup, MsgBoxEnum.BoxType.Yes_No, function()
			arg_4_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_4_0._refreshItems, arg_4_0)
			arg_4_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_4_0._refreshItems, arg_4_0)
			arg_4_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_4_0._refreshItems, arg_4_0)
			HeroRpc.instance:sendHeroRankUpRequest(arg_4_0.viewParam.heroId, arg_4_0._onReceiveHeroRankUp, arg_4_0)
		end, nil, nil, nil, nil, nil, var_4_11)
	end
end

function var_0_0._onReceiveHeroRankUp(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2 ~= 0 then
		arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_6_0._refreshItems, arg_6_0)
		arg_6_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_6_0._refreshItems, arg_6_0)
		arg_6_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_6_0._refreshItems, arg_6_0)
	end
end

function var_0_0.selfViewIsTop(arg_7_0)
	arg_7_0.ignoreViewList = arg_7_0.ignoreViewList or {
		ViewName.CharacterTipView,
		ViewName.CommonBuffTipView
	}

	return ViewHelper.instance:checkViewOnTheTop(arg_7_0.viewName, arg_7_0.ignoreViewList)
end

function var_0_0._onCloseView(arg_8_0)
	local var_8_0 = arg_8_0:selfViewIsTop()

	gohelper.setActive(arg_8_0._gospineContainer, var_8_0)

	if arg_8_0.needReloadSpine and var_8_0 and arg_8_0._uiSpine and arg_8_0._uiSpine:isSpine() then
		arg_8_0.needReloadSpine = false

		gohelper.onceAddComponent(arg_8_0._uiSpine:_getSpine()._rawImageGo, typeof(ZProj.UISpineImage)):RefreshLayer()
	end
end

function var_0_0._onOpenView(arg_9_0)
	gohelper.setActive(arg_9_0._gospineContainer, arg_9_0:selfViewIsTop())
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_10_0._onCloseView, arg_10_0, LuaEventSystem.Low)
	arg_10_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_10_0._onOpenView, arg_10_0, LuaEventSystem.High)
	arg_10_0._simagecenterbg:LoadImage(ResUrl.getCharacterIcon("guang_005"))

	arg_10_0._uiSpine = GuiModelAgent.Create(arg_10_0._gospine, true)

	arg_10_0._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, CharacterVoiceEnum.NormalPriority.CharacterRankUpView)
	arg_10_0._uiSpine:useRT()

	arg_10_0._items = {}
	arg_10_0._norrank = {}
	arg_10_0._norrank.insights = {}

	for iter_10_0 = 1, 3 do
		local var_10_0 = arg_10_0:getUserDataTb_()

		var_10_0.go = gohelper.findChild(arg_10_0._goranknormal, "insightlight" .. tostring(iter_10_0))
		var_10_0.lights = {}

		for iter_10_1 = 1, iter_10_0 do
			table.insert(var_10_0.lights, gohelper.findChild(var_10_0.go, "star" .. iter_10_1))
		end

		arg_10_0._norrank.insights[iter_10_0] = var_10_0
	end

	arg_10_0._norrank.eyes = arg_10_0:getUserDataTb_()

	for iter_10_2 = 1, 2 do
		table.insert(arg_10_0._norrank.eyes, gohelper.findChild(arg_10_0._goranknormal, "eyes/eye" .. tostring(iter_10_2)))
	end

	arg_10_0._uprank = {}
	arg_10_0._uprank.insights = {}

	for iter_10_3 = 1, 3 do
		local var_10_1 = arg_10_0:getUserDataTb_()

		var_10_1.go = gohelper.findChild(arg_10_0._goranklarge, "insightlight" .. tostring(iter_10_3))
		var_10_1.lights = {}

		for iter_10_4 = 1, iter_10_3 do
			table.insert(var_10_1.lights, gohelper.findChild(var_10_1.go, "star" .. iter_10_4))
		end

		arg_10_0._uprank.insights[iter_10_3] = var_10_1
	end

	arg_10_0._uprank.eyes = arg_10_0:getUserDataTb_()

	for iter_10_5 = 1, 2 do
		table.insert(arg_10_0._uprank.eyes, gohelper.findChild(arg_10_0._goranklarge, "eyes/eye" .. tostring(iter_10_5)))
	end

	arg_10_0._effects = {}

	for iter_10_6 = 1, 5 do
		local var_10_2 = arg_10_0:getUserDataTb_()

		var_10_2.go = gohelper.findChild(arg_10_0._goeffect, "effect/effect" .. tostring(iter_10_6))
		var_10_2.txt = gohelper.findChildText(arg_10_0._goeffect, "effect/effect" .. tostring(iter_10_6))
		arg_10_0._effects[iter_10_6] = var_10_2
	end

	arg_10_0._hyperLinkClick = arg_10_0._effects[2].txt.gameObject:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	arg_10_0._hyperLinkClick:SetClickListener(arg_10_0._onHyperLinkClick, arg_10_0)

	arg_10_0._viewAnim = arg_10_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_10_0._viewAnim:Play(UIAnimationName.Open)
	arg_10_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_10_0._onOpenViewFinish, arg_10_0)
end

function var_0_0._onHyperLinkClick(arg_11_0, arg_11_1)
	local var_11_0 = {}

	var_11_0.tag = "passiveskill"
	var_11_0.heroid = arg_11_0.viewParam.heroId
	var_11_0.tipPos = Vector2.New(-292, -51.1)
	var_11_0.anchorParams = {
		Vector2.New(1, 0.5),
		Vector2.New(1, 0.5)
	}
	var_11_0.buffTipsX = -776

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	CharacterController.instance:openCharacterTipView(var_11_0)
end

function var_0_0._onSpineLoaded(arg_12_0)
	if arg_12_0._uiSpine:isSpine() and arg_12_0.viewGO.transform.parent.name == "POPUPBlur" then
		arg_12_0.needReloadSpine = true
	end

	arg_12_0._uiSpine:setUIMask(true)
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_13_0._refreshItems, arg_13_0)
	arg_13_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_13_0._refreshItems, arg_13_0)
	arg_13_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_13_0._refreshItems, arg_13_0)
	arg_13_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_13_0.viewContainer.refreshHelp, arg_13_0.viewContainer)
	arg_13_0:_initItems()
	arg_13_0:_refreshView()
end

function var_0_0._initItems(arg_14_0)
	local var_14_0 = SkillConfig.instance:getherorankCO(arg_14_0.viewParam.heroId, arg_14_0.viewParam.rank + 1)

	if not var_14_0 then
		return
	end

	local var_14_1 = string.split(var_14_0.consume, "|")

	for iter_14_0 = 1, #var_14_1 do
		local var_14_2 = arg_14_0.viewContainer:getSetting().otherRes[1]
		local var_14_3 = arg_14_0:getResInst(var_14_2, arg_14_0._goitem)
		local var_14_4 = arg_14_0:getUserDataTb_()

		var_14_4.go = var_14_3
		var_14_4.rare = var_14_3:GetComponent(typeof(UnityEngine.UI.Image))
		var_14_4.icon = gohelper.findChild(var_14_4.go, "icon")
		arg_14_0._items[iter_14_0] = var_14_4
	end
end

function var_0_0.onOpenFinish(arg_15_0)
	if arg_15_0.viewParam.level == 30 then
		CharacterController.instance:dispatchEvent(CharacterEvent.OnGuideInsight)
	end
end

function var_0_0.onUpdateParam(arg_16_0)
	arg_16_0:_refreshView()
end

function var_0_0._onOpenViewFinish(arg_17_0, arg_17_1)
	if arg_17_1 == ViewName.CharacterGetView then
		arg_17_0:closeThis()
	end
end

function var_0_0._refreshView(arg_18_0)
	arg_18_0:_refreshSpine()
	arg_18_0:_refreshItems()
	arg_18_0:_refreshRank()
	arg_18_0:_refreshEffect()
	arg_18_0:_refreshButton()
end

function var_0_0._refreshSpine(arg_19_0)
	local var_19_0 = SkinConfig.instance:getSkinCo(arg_19_0.viewParam.skin)

	arg_19_0._uiSpine:setResPath(var_19_0, arg_19_0._onSpineLoaded, arg_19_0)

	local var_19_1 = var_19_0.characterRankUpViewOffset
	local var_19_2

	if string.nilorempty(var_19_1) then
		var_19_2 = SkinConfig.instance:getSkinOffset(var_19_0.characterViewOffset)
		var_19_2 = SkinConfig.instance:getAfterRelativeOffset(503, var_19_2)
	else
		var_19_2 = SkinConfig.instance:getSkinOffset(var_19_1)
	end

	recthelper.setAnchor(arg_19_0._gospine.transform, tonumber(var_19_2[1]), tonumber(var_19_2[2]))
	transformhelper.setLocalScale(arg_19_0._gospine.transform, tonumber(var_19_2[3]), tonumber(var_19_2[3]), tonumber(var_19_2[3]))
end

function var_0_0._refreshItems(arg_20_0)
	local var_20_0 = SkillConfig.instance:getherorankCO(arg_20_0.viewParam.heroId, arg_20_0.viewParam.rank + 1)

	if not var_20_0 then
		gohelper.setActive(arg_20_0._goitems, false)

		return
	end

	gohelper.setActive(arg_20_0._goitems, true)

	local var_20_1 = string.split(var_20_0.requirement, "|")

	for iter_20_0, iter_20_1 in pairs(var_20_1) do
		local var_20_2 = string.split(iter_20_1, "#")

		if var_20_2[1] == "1" then
			local var_20_3 = HeroConfig.instance:getShowLevel(arg_20_0.viewParam.level)
			local var_20_4 = HeroConfig.instance:getShowLevel(tonumber(var_20_2[2]))

			arg_20_0._txtlevel.text = var_20_4

			if var_20_3 < var_20_4 then
				arg_20_0._txtcount.text = "<color=#cd5353>" .. tostring(var_20_3) .. "</color>" .. "/" .. var_20_4
			else
				arg_20_0._txtcount.text = tostring(var_20_3) .. "/" .. var_20_4
			end
		end
	end

	local var_20_5 = string.split(var_20_0.consume, "|")
	local var_20_6 = {}

	for iter_20_2 = 1, #var_20_5 do
		local var_20_7 = string.splitToNumber(var_20_5[iter_20_2], "#")
		local var_20_8 = {
			type = tonumber(var_20_7[1]),
			id = tonumber(var_20_7[2]),
			quantity = tonumber(var_20_7[3])
		}

		var_20_8.rare = ItemModel.instance:getItemConfig(var_20_8.type, var_20_8.id).rare

		table.insert(var_20_6, var_20_8)
	end

	for iter_20_3 = 1, #var_20_6 do
		gohelper.setActive(arg_20_0._items[iter_20_3].go, iter_20_3 <= #var_20_6)
	end

	for iter_20_4 = 1, #var_20_6 do
		local var_20_9, var_20_10 = ItemModel.instance:getItemConfigAndIcon(var_20_6[iter_20_4].type, var_20_6[iter_20_4].id)

		if not arg_20_0._items[iter_20_4].item then
			arg_20_0._items[iter_20_4].item = IconMgr.instance:getCommonItemIcon(arg_20_0._items[iter_20_4].icon)
		end

		arg_20_0._items[iter_20_4].item:setMOValue(var_20_6[iter_20_4].type, var_20_6[iter_20_4].id, var_20_6[iter_20_4].quantity)
		arg_20_0._items[iter_20_4].item:setConsume(true)
		arg_20_0._items[iter_20_4].item:setCountFontSize(38)

		local var_20_11 = arg_20_0._items[iter_20_4].item:getCount()

		arg_20_0._items[iter_20_4].item:setRecordFarmItem({
			type = var_20_6[iter_20_4].type,
			id = var_20_6[iter_20_4].id,
			quantity = var_20_6[iter_20_4].quantity
		})
		arg_20_0._items[iter_20_4].item:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, arg_20_0)

		local var_20_12 = ItemModel.instance:getItemQuantity(var_20_6[iter_20_4].type, var_20_6[iter_20_4].id)

		if var_20_12 >= var_20_6[iter_20_4].quantity then
			if var_20_6[iter_20_4].type == MaterialEnum.MaterialType.Currency then
				var_20_11.text = tostring(GameUtil.numberDisplay(var_20_6[iter_20_4].quantity))
			else
				var_20_11.text = tostring(GameUtil.numberDisplay(var_20_12)) .. "/" .. tostring(GameUtil.numberDisplay(var_20_6[iter_20_4].quantity))
			end
		elseif var_20_6[iter_20_4].type == MaterialEnum.MaterialType.Currency then
			var_20_11.text = "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(var_20_6[iter_20_4].quantity)) .. "</color>"
		else
			var_20_11.text = "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(var_20_12)) .. "</color>" .. "/" .. tostring(GameUtil.numberDisplay(var_20_6[iter_20_4].quantity))
		end
	end
end

function var_0_0._refreshRank(arg_21_0)
	local var_21_0 = arg_21_0:_hasEffect()

	gohelper.setActive(arg_21_0._goranknormal, var_21_0)
	gohelper.setActive(arg_21_0._goranklarge, not var_21_0)

	local var_21_1 = var_21_0 and arg_21_0._norrank or arg_21_0._uprank
	local var_21_2 = arg_21_0.viewParam.config.rare
	local var_21_3 = HeroModel.instance:getByHeroId(arg_21_0.viewParam.heroId).rank
	local var_21_4 = HeroConfig.instance:getMaxRank(var_21_2)

	for iter_21_0 = 1, 3 do
		gohelper.setActive(var_21_1.insights[iter_21_0].go, var_21_4 == iter_21_0)

		for iter_21_1 = 1, iter_21_0 do
			if iter_21_1 <= var_21_3 - 1 then
				SLFramework.UGUI.GuiHelper.SetColor(var_21_1.insights[iter_21_0].lights[iter_21_1]:GetComponent("Image"), "#f59d3d")
			else
				SLFramework.UGUI.GuiHelper.SetColor(var_21_1.insights[iter_21_0].lights[iter_21_1]:GetComponent("Image"), "#646161")
			end
		end
	end

	gohelper.setActive(var_21_1.eyes[1], var_21_4 ~= var_21_3 - 1)
	gohelper.setActive(var_21_1.eyes[2], var_21_4 == var_21_3 - 1)
end

function var_0_0._refreshEffect(arg_22_0)
	if not arg_22_0:_hasEffect() then
		gohelper.setActive(arg_22_0._goeffect, false)

		return
	end

	gohelper.setActive(arg_22_0._goeffect, true)

	local var_22_0 = string.split(SkillConfig.instance:getherorankCO(arg_22_0.viewParam.heroId, arg_22_0.viewParam.rank + 1).effect, "|")

	for iter_22_0 = 1, 5 do
		gohelper.setActive(arg_22_0._effects[iter_22_0].go, iter_22_0 <= #var_22_0)
	end

	for iter_22_1 = 1, #var_22_0 do
		local var_22_1 = string.split(var_22_0[iter_22_1], "#")
		local var_22_2 = arg_22_0:_getEffectTxt(var_22_1[1], var_22_1[2])

		if var_22_2 then
			arg_22_0._effects[iter_22_1].txt.text = var_22_2
		else
			gohelper.setActive(arg_22_0._effects[iter_22_1].go, false)
		end
	end

	local var_22_3 = HeroModel.instance:getByHeroId(arg_22_0.viewParam.heroId)
	local var_22_4 = var_22_3.rank

	if var_22_4 > 1 then
		local var_22_5 = luaLang("talent_characterrankup_talentlevellimit" .. CharacterEnum.TalentTxtByHeroType[var_22_3.config.heroType])

		arg_22_0._effects[5].txt.text = string.format(var_22_5, var_0_0.characterTalentLevel[var_22_4])
	end

	gohelper.setActive(arg_22_0._effects[5].go, var_22_4 > 1)
end

function var_0_0._getEffectTxt(arg_23_0, arg_23_1, arg_23_2)
	arg_23_1 = tonumber(arg_23_1)

	local var_23_0

	if arg_23_1 == 1 then
		local var_23_1 = {
			arg_23_0.viewParam.config.name,
			tostring(HeroConfig.instance:getShowLevel(tonumber(arg_23_2)))
		}

		var_23_0 = GameUtil.getSubPlaceholderLuaLang(luaLang("character_rankup_levellimit"), var_23_1)
	elseif arg_23_1 == 2 then
		local var_23_2 = SkillConfig.instance:getpassiveskillCO(arg_23_0.viewParam.heroId, 1).skillPassive
		local var_23_3 = string.format("<u><link=%s>%s</link></u>", lua_skill.configDict[var_23_2].name, lua_skill.configDict[var_23_2].name)

		var_23_0 = string.format(luaLang("character_rankup_skill"), var_23_3)
	elseif arg_23_1 == 3 then
		if not CharacterEnum.SkinOpen then
			return nil
		end

		local var_23_4 = SkinConfig.instance:getSkinCo(tonumber(arg_23_2))

		var_23_0 = string.format(luaLang("character_rankup_skinunlock"), tostring(var_23_4.name))
	elseif arg_23_1 == 4 then
		var_23_0 = luaLang("character_rankup_attribute")
	end

	return var_23_0
end

function var_0_0._hasEffect(arg_24_0)
	local var_24_0 = SkillConfig.instance:getherorankCO(arg_24_0.viewParam.heroId, arg_24_0.viewParam.rank + 1)

	if var_24_0 and var_24_0.effects ~= "" then
		return true
	end

	return false
end

function var_0_0._refreshButton(arg_25_0)
	gohelper.setActive(arg_25_0._btnupgrade.gameObject, not arg_25_0:_hasfull())

	if arg_25_0:_hasfull() then
		return
	end

	local var_25_0 = SkillConfig.instance:getherorankCO(arg_25_0.viewParam.heroId, arg_25_0.viewParam.rank + 1)
	local var_25_1 = string.split(var_25_0.consume, "|")
	local var_25_2 = {}

	for iter_25_0 = 1, #var_25_1 do
		local var_25_3 = string.splitToNumber(var_25_1[iter_25_0], "#")
		local var_25_4 = {
			type = var_25_3[1],
			id = var_25_3[2],
			quantity = var_25_3[3]
		}

		table.insert(var_25_2, var_25_4)
	end

	local var_25_5, var_25_6, var_25_7 = ItemModel.instance:hasEnoughItems(var_25_2)
	local var_25_8 = string.split(var_25_0.requirement, "|")
	local var_25_9 = 0

	for iter_25_1, iter_25_2 in pairs(var_25_8) do
		local var_25_10 = string.splitToNumber(iter_25_2, "#")

		if var_25_10[1] == 1 then
			var_25_9 = var_25_10[2]
		end
	end

	gohelper.setActive(arg_25_0._goupgradeeffect, var_25_6 and var_25_9 <= arg_25_0.viewParam.level)
end

function var_0_0._hasfull(arg_26_0)
	return arg_26_0.viewParam.rank == CharacterModel.instance:getMaxRank(arg_26_0.viewParam.heroId)
end

function var_0_0.onClose(arg_27_0)
	if not arg_27_0._uiSpine then
		return
	end

	arg_27_0._uiSpine:setModelVisible(false)
end

function var_0_0.onDestroyView(arg_28_0)
	if arg_28_0._uiSpine then
		arg_28_0._uiSpine:onDestroy()

		arg_28_0._uiSpine = nil
	end

	arg_28_0._simagecenterbg:UnLoadImage()

	if arg_28_0._items then
		arg_28_0._items = nil
	end
end

return var_0_0
