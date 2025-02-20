module("modules.logic.character.view.CharacterRankUpView", package.seeall)

slot0 = class("CharacterRankUpView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebgimg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bgimg")
	slot0._simagecenterbg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_centerbg")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._gospineContainer = gohelper.findChild(slot0.viewGO, "spineContainer")
	slot0._gospine = gohelper.findChild(slot0.viewGO, "spineContainer/#go_spine")
	slot0._goitems = gohelper.findChild(slot0.viewGO, "#go_items")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "#go_items/#go_item")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "#go_items/level/#txt_level")
	slot0._txtcount = gohelper.findChildText(slot0.viewGO, "#go_items/level/#txt_count")
	slot0._goranknormal = gohelper.findChild(slot0.viewGO, "rank/#go_ranknormal")
	slot0._goranklarge = gohelper.findChild(slot0.viewGO, "rank/#go_ranklarge")
	slot0._goeffect = gohelper.findChild(slot0.viewGO, "#go_effect")
	slot0._btnupgrade = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_upgrade")
	slot0._goupgradeeffect = gohelper.findChild(slot0.viewGO, "#btn_upgrade/#go_levelupbeffect")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnupgrade:AddClickListener(slot0._btnupgradeOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnupgrade:RemoveClickListener()
end

slot0.characterTalentLevel = {
	[2.0] = 10,
	[3.0] = 15
}

function slot0._btnupgradeOnClick(slot0)
	if not CharacterModel.instance:isHeroRankReachCeil(slot0.viewParam.heroId) then
		for slot7 = 1, #string.split(SkillConfig.instance:getherorankCO(slot0.viewParam.heroId, slot0.viewParam.rank + 1).consume, "|") do
			slot8 = string.splitToNumber(slot2[slot7], "#")

			table.insert({}, {
				type = slot8[1],
				id = slot8[2],
				quantity = slot8[3]
			})
		end

		slot4 = 0

		for slot9, slot10 in pairs(string.split(slot1.requirement, "|")) do
			if string.split(slot10, "#")[1] == "1" then
				slot4 = tonumber(slot11[2])
			end
		end

		if slot0.viewParam.level < slot4 then
			GameFacade.showToast(ToastEnum.CharacterRankUp)

			return
		end

		slot6, slot7, slot8 = ItemModel.instance:hasEnoughItems(slot3)

		if not slot7 then
			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, slot8, slot6)

			return
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.CharacterRankup, MsgBoxEnum.BoxType.Yes_No, function ()
			uv0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, uv0._refreshItems, uv0)
			uv0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, uv0._refreshItems, uv0)
			uv0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, uv0._refreshItems, uv0)
			HeroRpc.instance:sendHeroRankUpRequest(uv0.viewParam.heroId, uv0._onReceiveHeroRankUp, uv0)
		end, nil, , , , , HeroConfig.instance:getHeroCO(slot0.viewParam.heroId).name)
	end
end

function slot0._onReceiveHeroRankUp(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, slot0._refreshItems, slot0)
		slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._refreshItems, slot0)
		slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._refreshItems, slot0)
	end
end

function slot0.selfViewIsTop(slot0)
	slot0.ignoreViewList = slot0.ignoreViewList or {
		ViewName.CharacterTipView,
		ViewName.CommonBuffTipView
	}

	return ViewHelper.instance:checkViewOnTheTop(slot0.viewName, slot0.ignoreViewList)
end

function slot0._onCloseView(slot0)
	gohelper.setActive(slot0._gospineContainer, slot0:selfViewIsTop())

	if slot0.needReloadSpine and slot1 and slot0._uiSpine and slot0._uiSpine:isSpine() then
		slot0.needReloadSpine = false

		gohelper.onceAddComponent(slot0._uiSpine:_getSpine()._rawImageGo, typeof(ZProj.UISpineImage)):RefreshLayer()
	end
end

function slot0._onOpenView(slot0)
	gohelper.setActive(slot0._gospineContainer, slot0:selfViewIsTop())
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseView, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0, LuaEventSystem.High)
	slot0._simagecenterbg:LoadImage(ResUrl.getCharacterIcon("guang_005"))

	slot4 = true
	slot0._uiSpine = GuiModelAgent.Create(slot0._gospine, slot4)

	slot0._uiSpine:useRT()

	slot0._items = {}
	slot0._norrank = {
		insights = {}
	}

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot9 = "insightlight" .. tostring(slot4)
		slot5.go = gohelper.findChild(slot0._goranknormal, slot9)
		slot5.lights = {}

		for slot9 = 1, slot4 do
			table.insert(slot5.lights, gohelper.findChild(slot5.go, "star" .. slot9))
		end

		slot0._norrank.insights[slot4] = slot5
	end

	slot4 = slot0
	slot0._norrank.eyes = slot0.getUserDataTb_(slot4)

	for slot4 = 1, 2 do
		table.insert(slot0._norrank.eyes, gohelper.findChild(slot0._goranknormal, "eyes/eye" .. tostring(slot4)))
	end

	slot0._uprank = {
		insights = {}
	}

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot9 = "insightlight" .. tostring(slot4)
		slot5.go = gohelper.findChild(slot0._goranklarge, slot9)
		slot5.lights = {}

		for slot9 = 1, slot4 do
			table.insert(slot5.lights, gohelper.findChild(slot5.go, "star" .. slot9))
		end

		slot0._uprank.insights[slot4] = slot5
	end

	slot4 = slot0
	slot0._uprank.eyes = slot0.getUserDataTb_(slot4)

	for slot4 = 1, 2 do
		table.insert(slot0._uprank.eyes, gohelper.findChild(slot0._goranklarge, "eyes/eye" .. tostring(slot4)))
	end

	slot0._effects = {}

	for slot4 = 1, 5 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0._goeffect, "effect/effect" .. tostring(slot4))
		slot5.txt = gohelper.findChildText(slot0._goeffect, "effect/effect" .. tostring(slot4))
		slot0._effects[slot4] = slot5
	end

	slot0._hyperLinkClick = slot0._effects[2].txt.gameObject:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	slot0._hyperLinkClick:SetClickListener(slot0._onHyperLinkClick, slot0)

	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	slot0._viewAnim:Play(UIAnimationName.Open)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
end

function slot0._onHyperLinkClick(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	CharacterController.instance:openCharacterTipView({
		tag = "passiveskill",
		heroid = slot0.viewParam.heroId,
		tipPos = Vector2.New(-292, -51.1),
		anchorParams = {
			Vector2.New(1, 0.5),
			Vector2.New(1, 0.5)
		},
		buffTipsX = -776
	})
end

function slot0._onSpineLoaded(slot0)
	if slot0._uiSpine:isSpine() and slot0.viewGO.transform.parent.name == "POPUPBlur" then
		slot0.needReloadSpine = true
	end

	slot0._uiSpine:setUIMask(true)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, slot0._refreshItems, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._refreshItems, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._refreshItems, slot0)
	slot0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, slot0.viewContainer.refreshHelp, slot0.viewContainer)
	slot0:_initItems()
	slot0:_refreshView()
end

function slot0._initItems(slot0)
	if not SkillConfig.instance:getherorankCO(slot0.viewParam.heroId, slot0.viewParam.rank + 1) then
		return
	end

	for slot6 = 1, #string.split(slot1.consume, "|") do
		slot8 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goitem)
		slot9 = slot0:getUserDataTb_()
		slot9.go = slot8
		slot9.rare = slot8:GetComponent(typeof(UnityEngine.UI.Image))
		slot9.icon = gohelper.findChild(slot9.go, "icon")
		slot0._items[slot6] = slot9
	end
end

function slot0.onOpenFinish(slot0)
	if slot0.viewParam.level == 30 then
		CharacterController.instance:dispatchEvent(CharacterEvent.OnGuideInsight)
	end
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshView()
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.CharacterGetView then
		slot0:closeThis()
	end
end

function slot0._refreshView(slot0)
	slot0:_refreshSpine()
	slot0:_refreshItems()
	slot0:_refreshRank()
	slot0:_refreshEffect()
	slot0:_refreshButton()
end

function slot0._refreshSpine(slot0)
	slot1 = SkinConfig.instance:getSkinCo(slot0.viewParam.skin)

	slot0._uiSpine:setResPath(slot1, slot0._onSpineLoaded, slot0)

	slot3 = nil
	slot3 = (not string.nilorempty(slot1.characterRankUpViewOffset) or SkinConfig.instance:getAfterRelativeOffset(503, SkinConfig.instance:getSkinOffset(slot1.characterViewOffset))) and SkinConfig.instance:getSkinOffset(slot2)

	recthelper.setAnchor(slot0._gospine.transform, tonumber(slot3[1]), tonumber(slot3[2]))
	transformhelper.setLocalScale(slot0._gospine.transform, tonumber(slot3[3]), tonumber(slot3[3]), tonumber(slot3[3]))
end

function slot0._refreshItems(slot0)
	if not SkillConfig.instance:getherorankCO(slot0.viewParam.heroId, slot0.viewParam.rank + 1) then
		gohelper.setActive(slot0._goitems, false)

		return
	end

	gohelper.setActive(slot0._goitems, true)

	for slot6, slot7 in pairs(string.split(slot1.requirement, "|")) do
		if string.split(slot7, "#")[1] == "1" then
			slot10 = HeroConfig.instance:getShowLevel(tonumber(slot8[2]))
			slot0._txtlevel.text = slot10

			if HeroConfig.instance:getShowLevel(slot0.viewParam.level) < slot10 then
				slot0._txtcount.text = "<color=#cd5353>" .. tostring(slot9) .. "</color>" .. "/" .. slot10
			else
				slot0._txtcount.text = tostring(slot9) .. "/" .. slot10
			end
		end
	end

	slot4 = {}

	for slot8 = 1, #string.split(slot1.consume, "|") do
		slot9 = string.splitToNumber(slot3[slot8], "#")
		slot10 = {
			type = tonumber(slot9[1]),
			id = tonumber(slot9[2]),
			quantity = tonumber(slot9[3])
		}
		slot10.rare = ItemModel.instance:getItemConfig(slot10.type, slot10.id).rare

		table.insert(slot4, slot10)
	end

	for slot8 = 1, #slot4 do
		gohelper.setActive(slot0._items[slot8].go, slot8 <= #slot4)
	end

	for slot8 = 1, #slot4 do
		slot9, slot10 = ItemModel.instance:getItemConfigAndIcon(slot4[slot8].type, slot4[slot8].id)

		if not slot0._items[slot8].item then
			slot0._items[slot8].item = IconMgr.instance:getCommonItemIcon(slot0._items[slot8].icon)
		end

		slot0._items[slot8].item:setMOValue(slot4[slot8].type, slot4[slot8].id, slot4[slot8].quantity)
		slot0._items[slot8].item:setConsume(true)
		slot0._items[slot8].item:setCountFontSize(38)
		slot0._items[slot8].item:setRecordFarmItem({
			type = slot4[slot8].type,
			id = slot4[slot8].id,
			quantity = slot4[slot8].quantity
		})
		slot0._items[slot8].item:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, slot0)

		if slot4[slot8].quantity <= ItemModel.instance:getItemQuantity(slot4[slot8].type, slot4[slot8].id) then
			if slot4[slot8].type == MaterialEnum.MaterialType.Currency then
				slot0._items[slot8].item:getCount().text = tostring(GameUtil.numberDisplay(slot4[slot8].quantity))
			else
				slot11.text = tostring(GameUtil.numberDisplay(slot12)) .. "/" .. tostring(GameUtil.numberDisplay(slot4[slot8].quantity))
			end
		elseif slot4[slot8].type == MaterialEnum.MaterialType.Currency then
			slot11.text = "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(slot4[slot8].quantity)) .. "</color>"
		else
			slot11.text = "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(slot12)) .. "</color>" .. "/" .. tostring(GameUtil.numberDisplay(slot4[slot8].quantity))
		end
	end
end

function slot0._refreshRank(slot0)
	slot1 = slot0:_hasEffect()

	gohelper.setActive(slot0._goranknormal, slot1)
	gohelper.setActive(slot0._goranklarge, not slot1)

	slot2 = slot1 and slot0._norrank or slot0._uprank
	slot4 = HeroModel.instance:getByHeroId(slot0.viewParam.heroId).rank
	slot5 = HeroConfig.instance:getMaxRank(slot0.viewParam.config.rare)

	for slot9 = 1, 3 do
		gohelper.setActive(slot2.insights[slot9].go, slot5 == slot9)

		for slot13 = 1, slot9 do
			if slot13 <= slot4 - 1 then
				SLFramework.UGUI.GuiHelper.SetColor(slot2.insights[slot9].lights[slot13]:GetComponent("Image"), "#f59d3d")
			else
				SLFramework.UGUI.GuiHelper.SetColor(slot2.insights[slot9].lights[slot13]:GetComponent("Image"), "#646161")
			end
		end
	end

	gohelper.setActive(slot2.eyes[1], slot5 ~= slot4 - 1)
	gohelper.setActive(slot2.eyes[2], slot5 == slot4 - 1)
end

function slot0._refreshEffect(slot0)
	if not slot0:_hasEffect() then
		gohelper.setActive(slot0._goeffect, false)

		return
	end

	gohelper.setActive(slot0._goeffect, true)

	slot4 = SkillConfig.instance
	slot6 = slot4
	slot2 = string.split(slot4.getherorankCO(slot6, slot0.viewParam.heroId, slot0.viewParam.rank + 1).effect, "|")

	for slot6 = 1, 5 do
		gohelper.setActive(slot0._effects[slot6].go, slot6 <= #slot2)
	end

	for slot6 = 1, #slot2 do
		slot7 = string.split(slot2[slot6], "#")

		if slot0:_getEffectTxt(slot7[1], slot7[2]) then
			slot0._effects[slot6].txt.text = slot8
		else
			gohelper.setActive(slot0._effects[slot6].go, false)
		end
	end

	if HeroModel.instance:getByHeroId(slot0.viewParam.heroId).rank > 1 then
		slot0._effects[5].txt.text = string.format(luaLang("talent_characterrankup_talentlevellimit" .. CharacterEnum.TalentTxtByHeroType[slot3.config.heroType]), uv0.characterTalentLevel[slot4])
	end

	gohelper.setActive(slot0._effects[5].go, slot4 > 1)
end

function slot0._getEffectTxt(slot0, slot1, slot2)
	slot3 = nil

	if tonumber(slot1) == 1 then
		slot3 = GameUtil.getSubPlaceholderLuaLang(luaLang("character_rankup_levellimit"), {
			slot0.viewParam.config.name,
			tostring(HeroConfig.instance:getShowLevel(tonumber(slot2)))
		})
	elseif slot1 == 2 then
		slot4 = SkillConfig.instance:getpassiveskillCO(slot0.viewParam.heroId, 1).skillPassive
		slot3 = string.format(luaLang("character_rankup_skill"), string.format("<u><link=%s>%s</link></u>", lua_skill.configDict[slot4].name, lua_skill.configDict[slot4].name))
	elseif slot1 == 3 then
		if not CharacterEnum.SkinOpen then
			return nil
		end

		slot3 = string.format(luaLang("character_rankup_skinunlock"), tostring(SkinConfig.instance:getSkinCo(tonumber(slot2)).name))
	elseif slot1 == 4 then
		slot3 = luaLang("character_rankup_attribute")
	end

	return slot3
end

function slot0._hasEffect(slot0)
	if SkillConfig.instance:getherorankCO(slot0.viewParam.heroId, slot0.viewParam.rank + 1) and slot1.effects ~= "" then
		return true
	end

	return false
end

function slot0._refreshButton(slot0)
	gohelper.setActive(slot0._btnupgrade.gameObject, not slot0:_hasfull())

	if slot0:_hasfull() then
		return
	end

	slot3 = {}

	for slot7 = 1, #string.split(SkillConfig.instance:getherorankCO(slot0.viewParam.heroId, slot0.viewParam.rank + 1).consume, "|") do
		slot8 = string.splitToNumber(slot2[slot7], "#")

		table.insert(slot3, {
			type = slot8[1],
			id = slot8[2],
			quantity = slot8[3]
		})
	end

	slot4, slot5, slot6 = ItemModel.instance:hasEnoughItems(slot3)
	slot8 = 0

	for slot12, slot13 in pairs(string.split(slot1.requirement, "|")) do
		if string.splitToNumber(slot13, "#")[1] == 1 then
			slot8 = slot14[2]
		end
	end

	gohelper.setActive(slot0._goupgradeeffect, slot5 and slot8 <= slot0.viewParam.level)
end

function slot0._hasfull(slot0)
	return slot0.viewParam.rank == CharacterModel.instance:getMaxRank(slot0.viewParam.heroId)
end

function slot0.onClose(slot0)
	if not slot0._uiSpine then
		return
	end

	slot0._uiSpine:setModelVisible(false)
end

function slot0.onDestroyView(slot0)
	if slot0._uiSpine then
		slot0._uiSpine:onDestroy()

		slot0._uiSpine = nil
	end

	slot0._simagecenterbg:UnLoadImage()

	if slot0._items then
		slot0._items = nil
	end
end

return slot0
