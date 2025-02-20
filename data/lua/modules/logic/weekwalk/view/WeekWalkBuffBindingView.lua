module("modules.logic.weekwalk.view.WeekWalkBuffBindingView", package.seeall)

slot0 = class("WeekWalkBuffBindingView", BaseView)

function slot0.onInitView(slot0)
	slot0._gorolecontainer = gohelper.findChild(slot0.viewGO, "#go_rolecontainer")
	slot0._scrollcard = gohelper.findChildScrollRect(slot0.viewGO, "#go_rolecontainer/#scroll_card")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")
	slot0._goadventuretarotitem = gohelper.findChild(slot0.viewGO, "#go_adventuretarotitem")
	slot0._goselectheroitem1 = gohelper.findChild(slot0.viewGO, "#go_selectheroitem1")
	slot0._goselectheroitem2 = gohelper.findChild(slot0.viewGO, "#go_selectheroitem2")
	slot0._txteffect = gohelper.findChildText(slot0.viewGO, "#scroll_effects/Viewport/Content/#txt_effect")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_cancel")
	slot0._goattreffect = gohelper.findChild(slot0.viewGO, "#go_attreffect")
	slot0._goattritem = gohelper.findChild(slot0.viewGO, "#go_attreffect/#go_attritem")
	slot0._scrolleffects = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_effects")
	slot0._txtdesitem = gohelper.findChildText(slot0.viewGO, "#scroll_effects/Viewport/Content/#txt_desitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
end

function slot0._btncancelOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnconfirmOnClick(slot0)
	if not slot0._hero1Info then
		GameFacade.showToast(ToastEnum.WeekWalkBuffBinding1)

		return
	end

	if not slot0._hero2Info then
		GameFacade.showToast(ToastEnum.WeekWalkBuffBinding2)

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.WeekWalkPray, MsgBoxEnum.BoxType.Yes_No, function ()
		WeekwalkRpc.instance:sendWeekwalkBuffRequest(uv0._buffId, uv0._hero1Info.heroId, uv0._hero2Info.heroId)
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnConfirmBindingBuff)
	end, nil, , , , , slot0._hero1Info.config.name, slot0._hero2Info.config.name)
end

function slot0._editableInitView(slot0)
	slot0._imgBg = gohelper.findChildSingleImage(slot0.viewGO, "bg/bgimg")

	slot0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/juesebeibao_005"))
	HeroGroupEditListModel.instance:setParam(nil, WeekWalkModel.instance:getInfo())
	gohelper.addUIClickAudio(slot0._btnconfirm.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	gohelper.addUIClickAudio(slot0._btncancel.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
end

function slot0.onUpdateParam(slot0)
end

function slot0._initHeroItems(slot0)
	slot0._heroItem1 = IconMgr.instance:getCommonHeroItem(slot0._goselectheroitem1)

	gohelper.setActive(slot0._heroItem1.go, false)
	slot0._heroItem1:setLevelContentShow(false)
	slot0._heroItem1:setNameContentShow(false)
	slot0._heroItem1:addEventListeners()
	slot0._heroItem1:addClickListener(slot0._onHeroItem1Click, slot0)

	slot0._hero1Info = nil
	slot0._heroItem2 = IconMgr.instance:getCommonHeroItem(slot0._goselectheroitem2)

	gohelper.setActive(slot0._heroItem2.go, false)
	slot0._heroItem2:setLevelContentShow(false)
	slot0._heroItem2:setNameContentShow(false)
	slot0._heroItem2:addEventListeners()
	slot0._heroItem2:addClickListener(slot0._onHeroItem2Click, slot0)

	slot0._hero2Info = nil
end

function slot0._onHeroItem1Click(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)

	slot0._hero1Info = nil

	slot0:_selectHeroitem()
	slot0:_showEffect()
end

function slot0._onHeroItem2Click(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)

	slot0._hero2Info = nil

	slot0:_selectHeroitem()
end

function slot0._initParams(slot0)
	slot0._buffId = slot0.viewParam.tarotId
	slot0._buffConfig = lua_weekwalk_buff.configDict[slot0._buffId]
	slot0._prayId = tonumber(slot0._buffConfig.param)
	slot0._prayConfig = lua_weekwalk_pray.configDict[slot0._prayId]
	slot0._sacrificeLimitLevel = 0
	slot0._sacrificeLimitCareer = 0
	slot0._sacrificeLimitHeroId = 0

	if GameUtil.splitString2(slot0._prayConfig.sacrificeLimit, true, "|", "#") then
		for slot5, slot6 in ipairs(slot1) do
			if slot6[1] == 1 then
				slot0._sacrificeLimitCareer = slot6[2]
			elseif slot7 == 2 then
				slot0._sacrificeLimitLevel = slot8
			elseif slot7 == 3 then
				slot0._sacrificeLimitHeroId = slot8
			end
		end
	end

	slot0._blessingLimit = slot0._prayConfig.blessingLimit == "1"
	slot0._effectMap = {}
	slot6 = "|"
	slot7 = "#"

	for slot6, slot7 in ipairs(GameUtil.splitString2(slot0._prayConfig.effect, true, slot6, slot7)) do
		slot10 = slot7[3]

		if slot7[1] == WeekWalkEnum.SacrificeEffectType.BaseAttr then
			slot0._effectMap[slot8] = slot7[2] / 1000
		elseif slot8 == WeekWalkEnum.SacrificeEffectType.ExAttr then
			slot0._effectMap[slot8] = {
				slot9,
				slot10 / 1000
			}
		elseif slot8 == WeekWalkEnum.SacrificeEffectType.PassiveSkill then
			slot0._effectMap[slot8] = slot9
		end
	end
end

function slot0.onOpen(slot0)
	slot0:_initParams()
	slot0:_initHeroItems()
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, slot0._onHeroItemClick, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.TarotReply, slot0._onTarotReply, slot0)
	slot0:_onHeroItemClick(nil)
end

function slot0._updateCardList(slot0)
	if not slot0._hero1Info or slot0._hero2Info and slot0._lastSetHeroInfo == slot0._hero1Info then
		slot0._selectHero1 = true

		WeekWalkCardListModel.instance:setCardList(slot0._sacrificeLimitCareer, slot0._sacrificeLimitLevel, slot0._hero1Info, slot0._hero2Info, slot0._sacrificeLimitHeroId)

		return
	end

	if not slot0._hero2Info or slot0._lastSetHeroInfo == slot0._hero2Info then
		slot0._selectHero1 = false

		WeekWalkCardListModel.instance:setCardList(slot0._blessingLimit and slot0._hero1Info.config.career or 0, 0, slot0._hero1Info, slot0._hero2Info, 0)
	end
end

function slot0._verifyHero2(slot0)
	if not slot0._hero1Info or not slot0._hero2Info then
		return
	end

	slot8 = 0
	slot9 = slot0._hero1Info

	for slot8, slot9 in ipairs(WeekWalkCardListModel.instance:getCardList(slot0._blessingLimit and slot0._hero1Info.config.career or 0, slot8, slot9, nil, 0)) do
		if slot9 == slot0._hero2Info then
			return
		end
	end

	slot0._hero2Info = nil
end

function slot0._showEffect(slot0)
	slot1 = slot0._hero1Info

	for slot5, slot6 in pairs(slot0._effectMap) do
		if slot1 and slot5 == WeekWalkEnum.SacrificeEffectType.BaseAttr then
			slot8 = slot1.baseAttr

			for slot13, slot14 in ipairs({
				102,
				101,
				103,
				104,
				105
			}) do
				if math.floor(slot1:getAttrValueWithoutTalentByID(slot14) * slot6) > 0 then
					slot17 = slot0:_getAttributeItem(slot13)

					gohelper.setActive(slot17.go, true)
					slot0:_showAttribute(slot17, HeroConfig.instance:getHeroAttributeCO(slot9[slot13]).name, "icon_att_" .. tostring(slot9[slot13]), slot15)
				end
			end
		elseif slot1 and slot5 == WeekWalkEnum.SacrificeEffectType.ExAttr then
			slot13 = slot0:_getAttributeItem(1)

			gohelper.setActive(slot13.go, true)
			slot0:_showAttribute(slot13, slot9.name, "icon_att_" .. tostring(slot9.id), HeroConfig.instance:talentGainTab2IDTab(slot1:getTalentGain())[HeroConfig.instance:getHeroAttributeCO(slot6[1]).id] and slot11.value * slot6[2] / 10 or 0, true)
		elseif slot5 == WeekWalkEnum.SacrificeEffectType.PassiveSkill then
			slot8 = lua_skill.configDict[tonumber(slot6)].desc
			slot0._txteffect.text = HeroSkillModel.instance:skillDesToSpot(slot8, "#B64F44", "#3C5784")

			if slot0:_getEffectDesc(slot8) and #slot9 > 0 then
				slot0._effectDesItems = slot0._effectDesItems or slot0:getUserDataTb_()

				for slot13, slot14 in ipairs(slot9) do
					if not slot0._effectDesItems[slot13] then
						slot16 = gohelper.cloneInPlace(slot0._txtdesitem.gameObject, "des_" .. slot13)

						table.insert(slot0._effectDesItems, slot16)

						slot15 = slot16
					end

					gohelper.setActive(slot15, true)

					slot15:GetComponent(gohelper.Type_TextMesh).text = slot14
				end
			end

			slot10 = slot9 and #slot9 + 1 or 1

			if slot0._effectDesItems then
				for slot14 = slot10, #slot0._effectDesItems do
					gohelper.setActive(slot0._effectDesItems[slot14], false)
				end
			end
		end

		gohelper.setActive(slot0._scrolleffects.gameObject, slot1 and slot5 == WeekWalkEnum.SacrificeEffectType.PassiveSkill)
		gohelper.setActive(slot0._goattreffect, slot1 and slot5 ~= WeekWalkEnum.SacrificeEffectType.PassiveSkill)
	end

	if slot1 and (type == WeekWalkEnum.SacrificeEffectType.ExAttr or type == WeekWalkEnum.SacrificeEffectType.BaseAttr) then
		for slot5 = #slot0._effectMap + 1, #slot0._attributeItems do
			gohelper.setActive(slot0._attributeItems[slot5], false)
		end
	end
end

function slot0._getAttributeItem(slot0, slot1)
	slot0._attributeItems = slot0._attributeItems or {}

	if not slot0._attributeItems[slot1] then
		slot3 = slot0:getUserDataTb_()
		slot3.go = gohelper.cloneInPlace(slot0._goattritem, "attribute" .. slot1)
		slot3.iconImg = gohelper.findChildImage(slot3.go, "icon")
		slot3.nameTxt = gohelper.findChildText(slot3.go, "name")
		slot3.valueTxt = gohelper.findChildText(slot3.go, "value")

		table.insert(slot0._attributeItems, slot3)

		slot2 = slot3
	end

	return slot2
end

function slot0._showAttribute(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot1 then
		return
	end

	slot1.nameTxt.text = slot2

	UISpriteSetMgr.instance:setCommonSprite(slot1.iconImg, slot3)

	slot1.valueTxt.text = slot4

	if slot5 then
		slot1.valueTxt.text = string.format("%s%%", math.floor(slot4))
	end
end

function slot0._selectHeroitem(slot0)
	if slot0._hero1Info then
		slot0._heroItem1:onUpdateMO(slot0._hero1Info)
	end

	if slot0._hero2Info then
		slot0._heroItem2:onUpdateMO(slot0._hero2Info)
	end

	gohelper.setActive(slot0._heroItem1.go, slot0._hero1Info)
	gohelper.setActive(slot0._heroItem2.go, slot0._hero2Info)
	slot0:_updateCardList()
end

function slot0._onTarotReply(slot0)
	slot0:closeThis()
end

function slot0._onHeroItemClick(slot0, slot1)
	if slot1 then
		if WeekWalkModel.instance:getInfo():getHeroHp(slot1.heroId) <= 0 then
			return
		end

		if slot0._hero1Info and slot0._hero2Info then
			-- Nothing
		end

		if not slot0._hero1Info or slot0._selectHero1 then
			slot0._hero1Info = slot1

			slot0:_verifyHero2()
		elseif not slot0._hero2Info or not slot0._selectHero1 then
			slot0._hero2Info = slot1
		end

		slot0._lastSetHeroInfo = slot1
	end

	slot0:_showEffect()
	slot0:_selectHeroitem()
end

function slot0._getEffectDesc(slot0, slot1)
	if string.nilorempty(slot1) then
		return nil
	end

	slot3 = {}

	for slot7, slot8 in ipairs(HeroSkillModel.instance:getEffectTagIDsFromDescRecursion(slot1)) do
		table.insert(slot3, HeroSkillModel.instance:skillDesToSpot(string.format("[%s]:%s", SkillConfig.instance:processSkillDesKeyWords(SkillConfig.instance:getSkillEffectDescCo(slot8).name), SkillConfig.instance:processSkillDesKeyWords(SkillConfig.instance:getSkillEffectDescCo(slot8).desc)), "#B64F44", "#3C5784"))
	end

	return slot3
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._imgBg:UnLoadImage()

	slot0._attributeItems = nil
end

return slot0
