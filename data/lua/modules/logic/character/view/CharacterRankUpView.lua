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
	arg_1_0._gocaneasycombinetip = gohelper.findChild(arg_1_0.viewGO, "txt_onceCombine")

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

function var_0_0._btnupgradeOnClick(arg_4_0, arg_4_1)
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
			if arg_4_0._canEasyCombine then
				PopupCacheModel.instance:setViewIgnoreGetPropView(arg_4_0.viewName, true, MaterialEnum.GetApproach.RoomProductChange)
				RoomProductionHelper.openRoomFormulaMsgBoxView(arg_4_0._easyCombineTable, arg_4_0._lackedItemDataList, RoomProductLineEnum.Line.Spring, nil, nil, arg_4_0._onEasyCombineFinished, arg_4_0)

				return
			else
				GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_4_10, var_4_8)

				return
			end
		end

		if arg_4_1 then
			arg_4_0:_confirmRankUp()
		else
			local var_4_11 = HeroConfig.instance:getHeroCO(arg_4_0.viewParam.heroId).name

			GameFacade.showMessageBox(MessageBoxIdDefine.CharacterRankup, MsgBoxEnum.BoxType.Yes_No, arg_4_0._confirmRankUp, nil, nil, arg_4_0, nil, nil, var_4_11)
		end
	end
end

function var_0_0._confirmRankUp(arg_5_0)
	arg_5_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_5_0._refreshItems, arg_5_0)
	arg_5_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_5_0._refreshItems, arg_5_0)
	arg_5_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_5_0._refreshItems, arg_5_0)
	HeroRpc.instance:sendHeroRankUpRequest(arg_5_0.viewParam.heroId, arg_5_0._onReceiveHeroRankUp, arg_5_0)
end

function var_0_0._onEasyCombineFinished(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	PopupCacheModel.instance:setViewIgnoreGetPropView(arg_6_0.viewName, false)

	if arg_6_2 ~= 0 then
		return
	end

	arg_6_0:_btnupgradeOnClick(true)
end

function var_0_0._onReceiveHeroRankUp(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 ~= 0 then
		arg_7_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_7_0._refreshItems, arg_7_0)
		arg_7_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_7_0._refreshItems, arg_7_0)
		arg_7_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_7_0._refreshItems, arg_7_0)
	end
end

function var_0_0.selfViewIsTop(arg_8_0)
	arg_8_0.ignoreViewList = arg_8_0.ignoreViewList or {
		ViewName.CharacterTipView,
		ViewName.CommonBuffTipView,
		ViewName.ShareTipView
	}

	return ViewHelper.instance:checkViewOnTheTop(arg_8_0.viewName, arg_8_0.ignoreViewList)
end

function var_0_0._onCloseView(arg_9_0)
	local var_9_0 = arg_9_0:selfViewIsTop()

	gohelper.setActive(arg_9_0._gospineContainer, var_9_0)

	if arg_9_0.needReloadSpine and var_9_0 and arg_9_0._uiSpine and arg_9_0._uiSpine:isSpine() then
		arg_9_0.needReloadSpine = false

		gohelper.onceAddComponent(arg_9_0._uiSpine:_getSpine()._rawImageGo, typeof(ZProj.UISpineImage)):RefreshLayer()
	end
end

function var_0_0._onOpenView(arg_10_0)
	gohelper.setActive(arg_10_0._gospineContainer, arg_10_0:selfViewIsTop())
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_11_0._onCloseView, arg_11_0, LuaEventSystem.Low)
	arg_11_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_11_0._onOpenView, arg_11_0, LuaEventSystem.High)
	arg_11_0._simagecenterbg:LoadImage(ResUrl.getCharacterIcon("guang_005"))

	arg_11_0._uiSpine = GuiModelAgent.Create(arg_11_0._gospine, true)

	arg_11_0._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, arg_11_0.viewName)
	arg_11_0._uiSpine:useRT()

	arg_11_0._items = {}
	arg_11_0._norrank = {}
	arg_11_0._norrank.insights = {}
	arg_11_0._effect = gohelper.findChild(arg_11_0._goeffect, "#scroll_info/viewport/effect")

	for iter_11_0 = 1, 3 do
		local var_11_0 = arg_11_0:getUserDataTb_()

		var_11_0.go = gohelper.findChild(arg_11_0._goranknormal, "insightlight" .. tostring(iter_11_0))
		var_11_0.lights = {}

		for iter_11_1 = 1, iter_11_0 do
			table.insert(var_11_0.lights, gohelper.findChild(var_11_0.go, "star" .. iter_11_1))
		end

		arg_11_0._norrank.insights[iter_11_0] = var_11_0
	end

	arg_11_0._norrank.eyes = arg_11_0:getUserDataTb_()

	for iter_11_2 = 1, 2 do
		table.insert(arg_11_0._norrank.eyes, gohelper.findChild(arg_11_0._goranknormal, "eyes/eye" .. tostring(iter_11_2)))
	end

	arg_11_0._uprank = {}
	arg_11_0._uprank.insights = {}

	for iter_11_3 = 1, 3 do
		local var_11_1 = arg_11_0:getUserDataTb_()

		var_11_1.go = gohelper.findChild(arg_11_0._goranklarge, "insightlight" .. tostring(iter_11_3))
		var_11_1.lights = {}

		for iter_11_4 = 1, iter_11_3 do
			table.insert(var_11_1.lights, gohelper.findChild(var_11_1.go, "star" .. iter_11_4))
		end

		arg_11_0._uprank.insights[iter_11_3] = var_11_1
	end

	arg_11_0._uprank.eyes = arg_11_0:getUserDataTb_()

	for iter_11_5 = 1, 2 do
		table.insert(arg_11_0._uprank.eyes, gohelper.findChild(arg_11_0._goranklarge, "eyes/eye" .. tostring(iter_11_5)))
	end

	arg_11_0._effects = {}

	for iter_11_6 = 1, 5 do
		local var_11_2 = arg_11_0:getUserDataTb_()

		var_11_2.go = gohelper.findChild(arg_11_0._effect, "effect" .. tostring(iter_11_6))
		var_11_2.txt = gohelper.findChildText(arg_11_0._effect, "effect" .. tostring(iter_11_6))
		arg_11_0._effects[iter_11_6] = var_11_2
	end

	arg_11_0:_initSpecialEffectItem()

	arg_11_0._hyperLinkClick = arg_11_0._effects[2].txt.gameObject:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	arg_11_0._hyperLinkClick:SetClickListener(arg_11_0._onHyperLinkClick, arg_11_0)

	arg_11_0._viewAnim = arg_11_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_11_0._viewAnim:Play(UIAnimationName.Open)
	arg_11_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_11_0._onOpenViewFinish, arg_11_0)
end

function var_0_0._initSpecialEffectItem(arg_12_0)
	arg_12_0._specialEffectItem = arg_12_0:getUserDataTb_()

	local var_12_0 = gohelper.findChild(arg_12_0._effect, "SpecialEffect")
	local var_12_1 = arg_12_0:getUserDataTb_()

	var_12_1.go = var_12_0
	var_12_1.txt = gohelper.findChildText(var_12_0, "#txt_SpecialEffect")
	arg_12_0._specialEffectItem[1] = var_12_1

	gohelper.setSibling(var_12_1.go, 0)

	local var_12_2 = arg_12_0:getUserDataTb_()

	var_12_2.go = gohelper.cloneInPlace(var_12_0)
	var_12_2.txt = gohelper.findChildText(var_12_2.go, "#txt_SpecialEffect")

	gohelper.setSibling(var_12_2.go, 1)

	arg_12_0._specialEffectItem[2] = var_12_2
end

function var_0_0._onHyperLinkClick(arg_13_0, arg_13_1)
	local var_13_0 = {}

	var_13_0.tag = "passiveskill"
	var_13_0.heroid = arg_13_0.viewParam.heroId
	var_13_0.tipPos = Vector2.New(-292, -51.1)
	var_13_0.anchorParams = {
		Vector2.New(1, 0.5),
		Vector2.New(1, 0.5)
	}
	var_13_0.buffTipsX = -776

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	CharacterController.instance:openCharacterTipView(var_13_0)
end

function var_0_0._onSpineLoaded(arg_14_0)
	if arg_14_0._uiSpine:isSpine() and arg_14_0.viewGO.transform.parent.name == "POPUPBlur" then
		arg_14_0.needReloadSpine = true
	end

	arg_14_0._uiSpine:setUIMask(true)
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_15_0._refreshItems, arg_15_0)
	arg_15_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_15_0._refreshItems, arg_15_0)
	arg_15_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_15_0._refreshItems, arg_15_0)
	arg_15_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_15_0.viewContainer.refreshHelp, arg_15_0.viewContainer)
	arg_15_0:_initItems()
	arg_15_0:_refreshView()
end

function var_0_0._initItems(arg_16_0)
	local var_16_0 = SkillConfig.instance:getherorankCO(arg_16_0.viewParam.heroId, arg_16_0.viewParam.rank + 1)

	if not var_16_0 then
		return
	end

	local var_16_1 = string.split(var_16_0.consume, "|")

	for iter_16_0 = 1, #var_16_1 do
		local var_16_2 = arg_16_0.viewContainer:getSetting().otherRes[1]
		local var_16_3 = arg_16_0:getResInst(var_16_2, arg_16_0._goitem)
		local var_16_4 = arg_16_0:getUserDataTb_()

		var_16_4.go = var_16_3
		var_16_4.rare = var_16_3:GetComponent(typeof(UnityEngine.UI.Image))
		var_16_4.icon = gohelper.findChild(var_16_4.go, "icon")
		arg_16_0._items[iter_16_0] = var_16_4
	end
end

function var_0_0.onOpenFinish(arg_17_0)
	if arg_17_0.viewParam.level == 30 then
		CharacterController.instance:dispatchEvent(CharacterEvent.OnGuideInsight)
	end
end

function var_0_0.onUpdateParam(arg_18_0)
	arg_18_0:_refreshView()
end

function var_0_0._onOpenViewFinish(arg_19_0, arg_19_1)
	if arg_19_1 == ViewName.CharacterGetView then
		arg_19_0:closeThis()
	end
end

function var_0_0._refreshView(arg_20_0)
	arg_20_0:_refreshSpine()
	arg_20_0:_refreshItems()
	arg_20_0:_refreshRank()
	arg_20_0:_refreshEffect()
	arg_20_0:_refreshButton()
end

function var_0_0._refreshSpine(arg_21_0)
	local var_21_0 = SkinConfig.instance:getSkinCo(arg_21_0.viewParam.skin)

	arg_21_0._uiSpine:setResPath(var_21_0, arg_21_0._onSpineLoaded, arg_21_0)

	local var_21_1 = var_21_0.characterRankUpViewOffset
	local var_21_2

	if string.nilorempty(var_21_1) then
		var_21_2 = SkinConfig.instance:getSkinOffset(var_21_0.characterViewOffset)
		var_21_2 = SkinConfig.instance:getAfterRelativeOffset(503, var_21_2)
	else
		var_21_2 = SkinConfig.instance:getSkinOffset(var_21_1)
	end

	recthelper.setAnchor(arg_21_0._gospine.transform, tonumber(var_21_2[1]), tonumber(var_21_2[2]))
	transformhelper.setLocalScale(arg_21_0._gospine.transform, tonumber(var_21_2[3]), tonumber(var_21_2[3]), tonumber(var_21_2[3]))
end

function var_0_0._refreshItems(arg_22_0)
	local var_22_0 = SkillConfig.instance:getherorankCO(arg_22_0.viewParam.heroId, arg_22_0.viewParam.rank + 1)

	if not var_22_0 then
		gohelper.setActive(arg_22_0._goitems, false)
		gohelper.setActive(arg_22_0._gocaneasycombinetip, false)

		return
	end

	gohelper.setActive(arg_22_0._goitems, true)

	local var_22_1 = string.split(var_22_0.requirement, "|")

	for iter_22_0, iter_22_1 in pairs(var_22_1) do
		local var_22_2 = string.split(iter_22_1, "#")

		if var_22_2[1] == "1" then
			local var_22_3 = HeroConfig.instance:getShowLevel(arg_22_0.viewParam.level)
			local var_22_4 = HeroConfig.instance:getShowLevel(tonumber(var_22_2[2]))

			arg_22_0._txtlevel.text = var_22_4

			if var_22_3 < var_22_4 then
				arg_22_0._txtcount.text = "<color=#cd5353>" .. tostring(var_22_3) .. "</color>" .. "/" .. var_22_4
			else
				arg_22_0._txtcount.text = tostring(var_22_3) .. "/" .. var_22_4
			end
		end
	end

	local var_22_5 = string.split(var_22_0.consume, "|")
	local var_22_6 = {}

	for iter_22_2 = 1, #var_22_5 do
		local var_22_7 = string.splitToNumber(var_22_5[iter_22_2], "#")
		local var_22_8 = {
			type = tonumber(var_22_7[1]),
			id = tonumber(var_22_7[2]),
			quantity = tonumber(var_22_7[3])
		}

		var_22_8.rare = ItemModel.instance:getItemConfig(var_22_8.type, var_22_8.id).rare

		table.insert(var_22_6, var_22_8)
	end

	for iter_22_3 = 1, #var_22_6 do
		gohelper.setActive(arg_22_0._items[iter_22_3].go, iter_22_3 <= #var_22_6)
	end

	arg_22_0._lackedItemDataList = {}
	arg_22_0._occupyItemDic = {}

	for iter_22_4 = 1, #var_22_6 do
		local var_22_9 = var_22_6[iter_22_4].type
		local var_22_10 = var_22_6[iter_22_4].id
		local var_22_11 = var_22_6[iter_22_4].quantity

		if not arg_22_0._items[iter_22_4].item then
			arg_22_0._items[iter_22_4].item = IconMgr.instance:getCommonItemIcon(arg_22_0._items[iter_22_4].icon)
		end

		arg_22_0._items[iter_22_4].item:setMOValue(var_22_9, var_22_10, var_22_11)
		arg_22_0._items[iter_22_4].item:setConsume(true)
		arg_22_0._items[iter_22_4].item:setCountFontSize(38)

		local var_22_12 = arg_22_0._items[iter_22_4].item:getCount()

		arg_22_0._items[iter_22_4].item:setRecordFarmItem({
			type = var_22_9,
			id = var_22_10,
			quantity = var_22_11
		})
		arg_22_0._items[iter_22_4].item:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, arg_22_0)

		local var_22_13 = ItemModel.instance:getItemQuantity(var_22_9, var_22_10)

		if var_22_11 <= var_22_13 then
			if var_22_9 == MaterialEnum.MaterialType.Currency then
				var_22_12.text = tostring(GameUtil.numberDisplay(var_22_11))
			else
				var_22_12.text = tostring(GameUtil.numberDisplay(var_22_13)) .. "/" .. tostring(GameUtil.numberDisplay(var_22_11))
			end

			if not arg_22_0._occupyItemDic[var_22_9] then
				arg_22_0._occupyItemDic[var_22_9] = {}
			end

			arg_22_0._occupyItemDic[var_22_9][var_22_10] = (arg_22_0._occupyItemDic[var_22_9][var_22_10] or 0) + var_22_11
		else
			if var_22_9 == MaterialEnum.MaterialType.Currency then
				var_22_12.text = "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(var_22_11)) .. "</color>"
			else
				var_22_12.text = "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(var_22_13)) .. "</color>" .. "/" .. tostring(GameUtil.numberDisplay(var_22_11))
			end

			local var_22_14 = var_22_11 - var_22_13

			table.insert(arg_22_0._lackedItemDataList, {
				type = var_22_9,
				id = var_22_10,
				quantity = var_22_14
			})
		end
	end

	arg_22_0._canEasyCombine, arg_22_0._easyCombineTable = RoomProductionHelper.canEasyCombineItems(arg_22_0._lackedItemDataList, arg_22_0._occupyItemDic)
	arg_22_0._occupyItemDic = nil

	gohelper.setActive(arg_22_0._gocaneasycombinetip, arg_22_0._canEasyCombine)
end

function var_0_0._refreshRank(arg_23_0)
	local var_23_0 = arg_23_0:_hasEffect()

	gohelper.setActive(arg_23_0._goranknormal, var_23_0)
	gohelper.setActive(arg_23_0._goranklarge, not var_23_0)

	local var_23_1 = var_23_0 and arg_23_0._norrank or arg_23_0._uprank
	local var_23_2 = arg_23_0.viewParam.config.rare
	local var_23_3 = HeroModel.instance:getByHeroId(arg_23_0.viewParam.heroId).rank
	local var_23_4 = HeroConfig.instance:getMaxRank(var_23_2)

	for iter_23_0 = 1, 3 do
		gohelper.setActive(var_23_1.insights[iter_23_0].go, var_23_4 == iter_23_0)

		for iter_23_1 = 1, iter_23_0 do
			if iter_23_1 <= var_23_3 - 1 then
				SLFramework.UGUI.GuiHelper.SetColor(var_23_1.insights[iter_23_0].lights[iter_23_1]:GetComponent("Image"), "#f59d3d")
			else
				SLFramework.UGUI.GuiHelper.SetColor(var_23_1.insights[iter_23_0].lights[iter_23_1]:GetComponent("Image"), "#646161")
			end
		end
	end

	gohelper.setActive(var_23_1.eyes[1], var_23_4 ~= var_23_3 - 1)
	gohelper.setActive(var_23_1.eyes[2], var_23_4 == var_23_3 - 1)
end

function var_0_0._refreshEffect(arg_24_0)
	if not arg_24_0:_hasEffect() then
		gohelper.setActive(arg_24_0._goeffect, false)

		return
	end

	gohelper.setActive(arg_24_0._goeffect, true)
	arg_24_0:_refreshSpecialEffect()

	local var_24_0 = string.split(SkillConfig.instance:getherorankCO(arg_24_0.viewParam.heroId, arg_24_0.viewParam.rank + 1).effect, "|")

	for iter_24_0 = 1, 5 do
		gohelper.setActive(arg_24_0._effects[iter_24_0].go, iter_24_0 <= #var_24_0)
	end

	for iter_24_1 = 1, #var_24_0 do
		local var_24_1 = string.split(var_24_0[iter_24_1], "#")
		local var_24_2 = arg_24_0:_getEffectTxt(var_24_1[1], var_24_1[2])

		if var_24_2 then
			arg_24_0._effects[iter_24_1].txt.text = var_24_2
		else
			gohelper.setActive(arg_24_0._effects[iter_24_1].go, false)
		end
	end

	local var_24_3 = HeroModel.instance:getByHeroId(arg_24_0.viewParam.heroId)
	local var_24_4 = var_24_3.rank

	if var_24_4 > 1 then
		local var_24_5 = luaLang("talent_characterrankup_talentlevellimit" .. var_24_3:getTalentTxtByHeroType())

		arg_24_0._effects[5].txt.text = string.format(var_24_5, var_0_0.characterTalentLevel[var_24_4])
	end

	gohelper.setActive(arg_24_0._effects[5].go, var_24_4 > 1)
	arg_24_0:_checkExtra(var_24_3)
end

function var_0_0._checkExtra(arg_25_0, arg_25_1)
	if arg_25_1.extraMo then
		local var_25_0
		local var_25_1 = arg_25_0.viewParam.rank + 1
		local var_25_2 = arg_25_1.extraMo:getSkillTalentMo()

		if var_25_2 then
			var_25_0 = var_25_2:getUnlockRankStr(var_25_1)
		end

		if arg_25_1.extraMo:hasWeapon() then
			local var_25_3 = arg_25_1.extraMo:getWeaponMo()

			if var_25_3 then
				var_25_0 = var_25_3:getUnlockRankStr(var_25_1)
			end
		end

		if var_25_0 then
			local var_25_4 = 6

			for iter_25_0, iter_25_1 in ipairs(var_25_0) do
				arg_25_0:_getEffectItem(var_25_4).txt.text = iter_25_1
				var_25_4 = var_25_4 + 1
			end
		end
	end
end

function var_0_0._getEffectItem(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0._effects[arg_26_1]

	if not var_26_0 then
		var_26_0 = arg_26_0:getUserDataTb_()

		local var_26_1 = gohelper.cloneInPlace(arg_26_0._effects[1].go, "effect" .. arg_26_1)

		var_26_0.go = var_26_1
		var_26_0.txt = var_26_1:GetComponent(typeof(TMPro.TMP_Text))
		arg_26_0._effects[arg_26_1] = var_26_0
	end

	return var_26_0
end

function var_0_0._getEffectTxt(arg_27_0, arg_27_1, arg_27_2)
	arg_27_1 = tonumber(arg_27_1)

	local var_27_0

	if arg_27_1 == 1 then
		local var_27_1 = {
			arg_27_0.viewParam.config.name,
			HeroConfig.instance:getShowLevel(tonumber(arg_27_2))
		}

		var_27_0 = GameUtil.getSubPlaceholderLuaLang(luaLang("character_rankup_levellimit"), var_27_1)
	elseif arg_27_1 == 2 then
		local var_27_2 = SkillConfig.instance:getpassiveskillCO(arg_27_0.viewParam.heroId, 1).skillPassive
		local var_27_3 = lua_skill.configDict[var_27_2]

		if var_27_3 then
			local var_27_4 = string.format("<u><link=%s>%s</link></u>", var_27_3.name, var_27_3.name)

			var_27_0 = string.format(luaLang("character_rankup_skill"), var_27_4)
		end
	elseif arg_27_1 == 3 then
		if not CharacterEnum.SkinOpen then
			return nil
		end

		local var_27_5 = SkinConfig.instance:getSkinCo(tonumber(arg_27_2))

		var_27_0 = string.format(luaLang("character_rankup_skinunlock"), tostring(var_27_5.name))
	elseif arg_27_1 == 4 then
		var_27_0 = luaLang("character_rankup_attribute")
	end

	return var_27_0
end

function var_0_0._refreshSpecialEffect(arg_28_0)
	local var_28_0 = CharacterModel.instance:getSpecialEffectDesc(arg_28_0.viewParam.skin, arg_28_0.viewParam.rank)
	local var_28_1 = 0

	if var_28_0 then
		for iter_28_0, iter_28_1 in ipairs(var_28_0) do
			arg_28_0._specialEffectItem[iter_28_0].txt.text = iter_28_1
			var_28_1 = var_28_1 + 1
		end
	end

	for iter_28_2 = 1, #arg_28_0._specialEffectItem do
		gohelper.setActive(arg_28_0._specialEffectItem[iter_28_2].go, iter_28_2 <= var_28_1)
	end
end

function var_0_0._hasEffect(arg_29_0)
	local var_29_0 = SkillConfig.instance:getherorankCO(arg_29_0.viewParam.heroId, arg_29_0.viewParam.rank + 1)

	if var_29_0 and var_29_0.effects ~= "" then
		return true
	end

	return false
end

function var_0_0._refreshButton(arg_30_0)
	gohelper.setActive(arg_30_0._btnupgrade.gameObject, not arg_30_0:_hasfull())

	if arg_30_0:_hasfull() then
		return
	end

	local var_30_0 = SkillConfig.instance:getherorankCO(arg_30_0.viewParam.heroId, arg_30_0.viewParam.rank + 1)
	local var_30_1 = string.split(var_30_0.consume, "|")
	local var_30_2 = {}

	for iter_30_0 = 1, #var_30_1 do
		local var_30_3 = string.splitToNumber(var_30_1[iter_30_0], "#")
		local var_30_4 = {
			type = var_30_3[1],
			id = var_30_3[2],
			quantity = var_30_3[3]
		}

		table.insert(var_30_2, var_30_4)
	end

	local var_30_5, var_30_6, var_30_7 = ItemModel.instance:hasEnoughItems(var_30_2)
	local var_30_8 = string.split(var_30_0.requirement, "|")
	local var_30_9 = 0

	for iter_30_1, iter_30_2 in pairs(var_30_8) do
		local var_30_10 = string.splitToNumber(iter_30_2, "#")

		if var_30_10[1] == 1 then
			var_30_9 = var_30_10[2]
		end
	end

	gohelper.setActive(arg_30_0._goupgradeeffect, var_30_6 and var_30_9 <= arg_30_0.viewParam.level)
end

function var_0_0._hasfull(arg_31_0)
	return arg_31_0.viewParam.rank == CharacterModel.instance:getMaxRank(arg_31_0.viewParam.heroId)
end

function var_0_0.onClose(arg_32_0)
	if not arg_32_0._uiSpine then
		return
	end

	arg_32_0._uiSpine:setModelVisible(false)
end

function var_0_0.onDestroyView(arg_33_0)
	if arg_33_0._uiSpine then
		arg_33_0._uiSpine:onDestroy()

		arg_33_0._uiSpine = nil
	end

	arg_33_0._simagecenterbg:UnLoadImage()

	if arg_33_0._items then
		arg_33_0._items = nil
	end
end

return var_0_0
