module("modules.logic.weekwalk.view.WeekWalkTarotItem", package.seeall)

slot0 = class("WeekWalkTarotItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg/#simage_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#simage_bg/#txt_name")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#simage_bg/#txt_desc")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#simage_bg/#btn_click")
	slot0._gotip = gohelper.findChild(slot0.viewGO, "#go_tip")
	slot0._btnclosetip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tip/#btn_closetip")
	slot0._txtheronamecn = gohelper.findChildText(slot0.viewGO, "#go_tip/#txt_heronamecn")
	slot0._txtheronameen = gohelper.findChildText(slot0.viewGO, "#go_tip/#txt_heronamecn/#txt_heronameen")
	slot0._txteffect = gohelper.findChildText(slot0.viewGO, "#go_tip/#scroll_effects/Viewport/Content/#txt_effect")
	slot0._goattreffect = gohelper.findChild(slot0.viewGO, "#go_tip/#go_attreffect")
	slot0._goattritem = gohelper.findChild(slot0.viewGO, "#go_tip/#go_attreffect/#go_attritem")
	slot0._scrolleffects = gohelper.findChildScrollRect(slot0.viewGO, "#go_tip/#scroll_effects")
	slot0._txtdesitem = gohelper.findChildText(slot0.viewGO, "#go_tip/#scroll_effects/Viewport/Content/#txt_desitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)

	if slot0._btnclosetip then
		slot0._btnclosetip:AddClickListener(slot0._btnclosetipOnClick, slot0)
	end
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()

	if slot0._btnclosetip then
		slot0._btnclosetip:RemoveClickListener()
	end
end

function slot0._btnclosetipOnClick(slot0)
	gohelper.setActive(slot0._gotip, false)
end

function slot0._btnclickOnClick(slot0)
	if slot0._isSelectTarotView then
		slot0._callback(slot0._callbackObj, slot0)
		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_fight_choosecard)
	elseif slot0._config.type == WeekWalkEnum.BuffType.Pray then
		slot0:_showPrayInfo()
	end
end

function slot0._showPrayInfo(slot0)
	if not WeekWalkModel.instance:getInfo():getPrayInfo() then
		return
	end

	gohelper.setActive(slot0._gotip, true)

	slot2 = HeroConfig.instance:getHeroCO(slot1.blessingHeroId)
	slot0._txtheronamecn.text = slot2.name
	slot0._txtheronameen.text = slot2.nameEng

	slot0:_initParams()
	slot0:_showEffect(slot1.sacrificeHeroId)
end

function slot0._editableInitView(slot0)
	slot0._callback = nil
	slot0._callbackObj = nil
	slot0._callbackParam = nil
	slot0._uimeshGo = gohelper.findChild(slot0.viewGO, "#simage_bg/mesh")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._canvasgroup = slot0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.removeUIClickAudio(slot0._btnclick.gameObject)
end

function slot0._editableAddEvents(slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnClickTarot, slot0._playAnimWhenClick, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._playAnimWhenEnter, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0:removeEventCb(WeekWalkController.instance, WeekWalkEvent.OnClickTarot, slot0._playAnimWhenClick, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._playAnimWhenEnter, slot0)
end

function slot0.onUpdateMO(slot0, slot1, slot2)
	slot0.info = slot1
	slot0._isSelectTarotView = slot2

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot1 = lua_weekwalk_buff.configDict[slot0.info.tarotId]
	slot0._config = slot1
	slot0._txtname.text = slot1.name
	slot0._txtdesc.text = HeroSkillModel.instance:skillDesToSpot(slot1.desc, "#924840", "#30466A")
	slot0._tarotItemBgUrl = slot0._tarotItemBgUrl or ResUrl.getWeekWalkTarotIcon("k" .. slot1.rare)

	if slot0._isSelectTarotView and slot0._isSelectTarotView == true then
		slot0:_loadTarotItemBg()
	else
		slot0._simagebg:LoadImage(slot0._tarotItemBgUrl)
	end

	slot0._simageicon:LoadImage(ResUrl.getWeekWalkTarotIcon(tostring(slot1.icon)))

	slot0._canvasgroup.interactable = true
end

function slot0._loadTarotItemBg(slot0)
	if not slot0._textureLoader then
		slot0._textureLoader = MultiAbLoader.New()

		slot0._textureLoader:addPath(slot0._tarotItemBgUrl)
		slot0._textureLoader:startLoad(slot0._loadTarotItemBgCB, slot0)
	end
end

function slot0._loadTarotItemBgCB(slot0)
	slot0._uimeshGo:GetComponent(typeof(UIMesh)).texture = slot0._textureLoader:getAssetItem(slot0._tarotItemBgUrl):GetResource(slot0._tarotItemBgUrl)
	slot0._uimeshGo.gameObject:GetComponent(typeof(UnityEngine.Animation)).enabled = true
end

function slot0.setClickCallback(slot0, slot1, slot2)
	slot0._callback = slot1
	slot0._callbackObj = slot2
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageicon:UnLoadImage()

	if slot0._textureLoader then
		slot0._textureLoader:dispose()

		slot0._textureLoader = nil
	end
end

function slot0._initParams(slot0)
	if slot0.info.tarotId == slot0._buffId then
		return
	end

	slot0._buffId = slot1
	slot0._buffConfig = lua_weekwalk_buff.configDict[slot0._buffId]
	slot0._prayId = tonumber(slot0._buffConfig.param)
	slot0._prayConfig = lua_weekwalk_pray.configDict[slot0._prayId]
	slot0._sacrificeLimitLevel = 0
	slot0._sacrificeLimitCareer = 0
	slot0._sacrificeLimitHeroId = 0

	if GameUtil.splitString2(slot0._prayConfig.sacrificeLimit, true, "|", "#") then
		for slot6, slot7 in ipairs(slot2) do
			if slot7[1] == 1 then
				slot0._sacrificeLimitCareer = slot7[2]
			elseif slot8 == 2 then
				slot0._sacrificeLimitLevel = slot9
			elseif slot8 == 3 then
				slot0._sacrificeLimitHeroId = slot9
			end
		end
	end

	slot0._blessingLimit = slot0._prayConfig.blessingLimit == "1"
	slot0._effectMap = {}
	slot7 = "#"

	for slot7, slot8 in ipairs(GameUtil.splitString2(slot0._prayConfig.effect, true, "|", slot7)) do
		slot11 = slot8[3]

		if slot8[1] == WeekWalkEnum.SacrificeEffectType.BaseAttr then
			slot0._effectMap[slot9] = slot8[2] / 1000
		elseif slot9 == WeekWalkEnum.SacrificeEffectType.ExAttr then
			slot0._effectMap[slot9] = {
				slot10,
				slot11 / 1000
			}
		elseif slot9 == WeekWalkEnum.SacrificeEffectType.PassiveSkill then
			slot0._effectMap[slot9] = slot10
		end
	end
end

function slot0._showEffect(slot0, slot1)
	if slot1 == slot0._sacrificeHeroId then
		return
	end

	slot0._sacrificeHeroId = slot1
	slot2 = HeroModel.instance:getByHeroId(slot1)

	for slot6, slot7 in pairs(slot0._effectMap) do
		if slot2 and slot6 == WeekWalkEnum.SacrificeEffectType.BaseAttr then
			slot9 = slot2.baseAttr

			for slot14, slot15 in ipairs({
				102,
				101,
				103,
				104,
				105
			}) do
				if math.floor(slot2:getAttrValueWithoutTalentByID(slot15) * slot7) > 0 then
					slot18 = slot0:_getAttributeItem(slot14)

					gohelper.setActive(slot18.go, true)
					slot0:_showAttribute(slot18, HeroConfig.instance:getHeroAttributeCO(slot15).name, "icon_att_" .. tostring(slot15), slot16)
				end
			end
		elseif slot2 and slot6 == WeekWalkEnum.SacrificeEffectType.ExAttr then
			slot14 = slot0:_getAttributeItem(1)

			gohelper.setActive(slot14.go, true)
			slot0:_showAttribute(slot14, slot10.name, "icon_att_" .. tostring(slot10.id), HeroConfig.instance:talentGainTab2IDTab(slot2:getTalentGain())[HeroConfig.instance:getHeroAttributeCO(slot7[1]).id] and slot12.value * slot7[2] / 10 or 0, true)
		elseif slot6 == WeekWalkEnum.SacrificeEffectType.PassiveSkill then
			slot9 = lua_skill.configDict[tonumber(slot7)].desc
			slot0._txteffect.text = HeroSkillModel.instance:skillDesToSpot(slot9, "#B64F44", "#3C5784")

			if slot0:_getEffectDesc(slot9) and #slot10 > 0 then
				for slot14, slot15 in ipairs(slot10) do
					slot16 = gohelper.cloneInPlace(slot0._txtdesitem.gameObject, "des_" .. slot14)

					gohelper.setActive(slot16, true)

					slot16:GetComponent(gohelper.Type_TextMesh).text = slot15
				end
			end
		end

		gohelper.setActive(slot0._scrolleffects.gameObject, slot2 and slot6 == WeekWalkEnum.SacrificeEffectType.PassiveSkill)
		gohelper.setActive(slot0._goattreffect, slot2 and slot6 ~= WeekWalkEnum.SacrificeEffectType.PassiveSkill)
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

function slot0._playAnimWhenClick(slot0, slot1)
	if slot0.viewGO == slot1 then
		slot0._anim:Play(UIAnimationName.Selected, 0, 0)
	else
		slot0._anim:Play("out", 0, 0)
	end

	slot0._canvasgroup.interactable = false
end

function slot0._playAnimWhenEnter(slot0, slot1)
	if slot1 == ViewName.WeekWalkBuffBindingView then
		slot0._anim:Play("in", 0, 0)

		slot0._canvasgroup.interactable = true
	end
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

return slot0
