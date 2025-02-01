module("modules.logic.character.view.CharacterTipView", package.seeall)

slot0 = class("CharacterTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._goattributetip = gohelper.findChild(slot0.viewGO, "#go_attributetip")
	slot0._btnbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_attributetip/scrollview/viewport/#btn_bg")
	slot0._goattributecontent = gohelper.findChild(slot0.viewGO, "#go_attributetip/scrollview/viewport/content")
	slot0._godetailcontent = gohelper.findChild(slot0.viewGO, "#go_attributetip/#go_detailContent")
	slot0._goattributecontentitem = gohelper.findChild(slot0.viewGO, "#go_attributetip/#go_detailContent/detailscroll/Viewport/#go_attributeContent/#go_attributeItem")
	slot0._gopassiveskilltip = gohelper.findChild(slot0.viewGO, "#go_passiveskilltip")
	slot0._goeffectdesc = gohelper.findChild(slot0.viewGO, "#go_passiveskilltip/mask/root/scrollview/viewport/content/#go_effectdesc")
	slot0._goeffectdescitem = gohelper.findChild(slot0.viewGO, "#go_passiveskilltip/mask/root/scrollview/viewport/content/#go_effectdesc/#go_effectdescitem")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "#go_passiveskilltip/mask/root/scrollview")
	slot0._gomask1 = gohelper.findChild(slot0.viewGO, "#go_passiveskilltip/mask/root/scrollview/#go_mask1")
	slot0._simageshadow = gohelper.findChildSingleImage(slot0.viewGO, "#go_passiveskilltip/mask/root/scrollview/#simage_shadow")
	slot0._btnclosepassivetip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_passiveskilltip/#btn_closepassivetip")
	slot0._goBuffContainer = gohelper.findChild(slot0.viewGO, "#go_buffContainer")
	slot0._btnclosebuff = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buffContainer/buff_bg")
	slot0._goBuffItem = gohelper.findChild(slot0.viewGO, "#go_buffContainer/#go_buffitem")
	slot0._txtBuffName = gohelper.findChildText(slot0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name")
	slot0._goBuffTag = gohelper.findChild(slot0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag")
	slot0._txtBuffTagName = gohelper.findChildText(slot0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag/bg/txt_tagname")
	slot0._txtBuffDesc = gohelper.findChildText(slot0.viewGO, "#go_buffContainer/#go_buffitem/txt_desc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbg:AddClickListener(slot0._btnbgOnClick, slot0)
	slot0._btnclosebuff:AddClickListener(slot0._btnclosebuffOnClick, slot0)
	slot0._scrollview:AddOnValueChanged(slot0._onDragCallHandler, slot0)
	slot0._btnclosepassivetip:AddClickListener(slot0._btnclosepassivetipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbg:RemoveClickListener()
	slot0._btnclosebuff:RemoveClickListener()
	slot0._scrollview:RemoveOnValueChanged()
	slot0._btnclosepassivetip:RemoveClickListener()
end

slot0.DetailOffset = 25
slot0.DetailBottomPos = -133.7
slot0.DetailClickMinPos = -148
slot0.AttrColor = GameUtil.parseColor("#323c34")

function slot0._btnbgOnClick(slot0)
	if not slot0._isOpenAttrDesc then
		return
	end

	slot0._isOpenAttrDesc = false

	gohelper.setActive(slot0._godetailcontent, false)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_role_description)
end

function slot0._btnclosebuffOnClick(slot0)
	gohelper.setActive(slot0._goBuffContainer, false)
end

function slot0._btnclosepassivetipOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

function slot0._onDragCallHandler(slot0)
	gohelper.setActive(slot0._gomask1, slot0._couldScroll and gohelper.getRemindFourNumberFloat(slot0._scrollview.verticalNormalizedPosition) > 0)

	slot0._passiveskilltipmask.enabled = slot0._couldScroll and gohelper.getRemindFourNumberFloat(slot0._scrollview.verticalNormalizedPosition) < 1
end

function slot0._editableInitView(slot0)
	slot0._isOpenAttrDesc = false

	gohelper.setActive(slot0._goBuffContainer, false)

	slot0.gocontent = gohelper.findChild(slot0._goattributetip, "scrollview/viewport/content")
	slot0.gotitleitem = gohelper.findChild(slot0._goattributetip, "scrollview/viewport/content/titleitem")
	slot0.godescitem = gohelper.findChild(slot0._goattributetip, "scrollview/viewport/content/descitem")
	slot0.goattrnormalitem = gohelper.findChild(slot0._goattributetip, "scrollview/viewport/content/attrnormalitem")
	slot0.goattrnormalwithdescitem = gohelper.findChild(slot0._goattributetip, "scrollview/viewport/content/attrnormalwithdescitem")
	slot0.goattrupperitem = gohelper.findChild(slot0._goattributetip, "scrollview/viewport/content/attrupperitem")
	slot0._txtDetailItemName = gohelper.findChildText(slot0._goattributecontentitem, "name")
	slot0._txtDetailItemIcon = gohelper.findChildImage(slot0._goattributecontentitem, "name/icon")
	slot0._txtDetailItemDesc = gohelper.findChildText(slot0._goattributecontentitem, "desc")
	slot0._passiveskilltipcontent = gohelper.findChild(slot0._gopassiveskilltip, "mask/root/scrollview/viewport/content")
	slot0._passiveskilltipmask = gohelper.findChild(slot0._gopassiveskilltip, "mask"):GetComponent(typeof(UnityEngine.UI.RectMask2D))

	gohelper.setActive(slot0.gotitleitem, false)
	gohelper.setActive(slot0.godescitem, false)
	gohelper.setActive(slot0.goattrnormalitem, false)
	gohelper.setActive(slot0.goattrnormalwithdescitem, false)
	gohelper.setActive(slot0.goattrupperitem, false)

	slot0.goTotalTitle = gohelper.clone(slot0.gotitleitem, slot0.gocontent, "totaltitle")

	gohelper.setActive(slot0.goTotalTitle, false)
	slot0:_setTitleText(slot0.goTotalTitle, luaLang("character_tip_total_attribute"), "STATS")

	slot4 = "descitem"
	slot0.goDescTitle = gohelper.clone(slot0.godescitem, slot0.gocontent, slot4)

	gohelper.setActive(slot0.goDescTitle, false)

	slot0._attnormalitems = {}

	for slot4 = 1, 4 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.clone(slot0.goattrnormalitem, slot0.gocontent, "attrnormal" .. 1)

		gohelper.setActive(slot5.go, true)

		slot5.value = gohelper.findChildText(slot5.go, "value")
		slot5.addValue = gohelper.findChildText(slot5.go, "addvalue")
		slot5.name = gohelper.findChildText(slot5.go, "name")
		slot5.icon = gohelper.findChildImage(slot5.go, "icon")
		slot5.rate = gohelper.findChildImage(slot5.go, "rate")
		slot5.detail = gohelper.findChild(slot5.go, "btndetail")
		slot5.withDesc = false
		slot0._attnormalitems[slot4] = slot5
	end

	slot1 = slot0:getUserDataTb_()
	slot5 = "attrnormal" .. #slot0._attnormalitems + 1
	slot1.go = gohelper.clone(slot0.goattrnormalwithdescitem, slot0.gocontent, slot5)

	gohelper.setActive(slot1.go, true)

	slot1.value = gohelper.findChildText(slot1.go, "attr/value")
	slot1.addValue = gohelper.findChildText(slot1.go, "attr/addvalue")
	slot1.name = gohelper.findChildText(slot1.go, "attr/namelayout/name")
	slot1.icon = gohelper.findChildImage(slot1.go, "attr/icon")
	slot1.detail = gohelper.findChild(slot1.go, "attr/btndetail")
	slot1.desc = gohelper.findChildText(slot1.go, "desc/#txt_desc")
	slot1.withDesc = true
	slot0._attnormalitems[#slot0._attnormalitems + 1] = slot1
	slot0._attrupperitems = {}

	for slot5 = 1, 12 do
		slot6 = slot0:getUserDataTb_()
		slot6.go = gohelper.clone(slot0.goattrupperitem, slot0.gocontent, "attrupper" .. slot5)

		gohelper.setActive(slot6.go, true)

		slot6.value = gohelper.findChildText(slot6.go, "value")
		slot6.addValue = gohelper.findChildText(slot6.go, "addvalue")
		slot6.name = gohelper.findChildText(slot6.go, "name")
		slot6.icon = gohelper.findChildImage(slot6.go, "icon")
		slot6.detail = gohelper.findChild(slot6.go, "btndetail")
		slot0._attrupperitems[slot5] = slot6
	end

	slot0._passiveskillitems = {}

	for slot5 = 1, 3 do
		slot6 = slot0:getUserDataTb_()
		slot6.go = gohelper.findChild(slot0._gopassiveskilltip, "mask/root/scrollview/viewport/content/talentstar" .. tostring(slot5))
		slot6.desc = gohelper.findChildTextMesh(slot6.go, "desctxt")
		slot6.hyperLinkClick = SkillHelper.addHyperLinkClick(slot6.desc, slot0._onHyperLinkClick, slot0)
		slot6.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(slot6.desc.gameObject, FixTmpBreakLine)
		slot6.on = gohelper.findChild(slot6.go, "#go_passiveskills/passiveskill/on")
		slot6.unlocktxt = gohelper.findChildText(slot6.go, "#go_passiveskills/passiveskill/unlocktxt")
		slot6.canvasgroup = gohelper.onceAddComponent(slot6.go, typeof(UnityEngine.CanvasGroup))
		slot6.connectline = gohelper.findChild(slot6.go, "line")
		slot0._passiveskillitems[slot5] = slot6
	end

	slot0._txtpassivename = gohelper.findChildText(slot0.viewGO, "#go_passiveskilltip/name/bg/#txt_passivename")
	slot0._detailClickItems = {}
	slot0._detailDescTab = slot0:getUserDataTb_()
	slot0._skillEffectDescItems = slot0:getUserDataTb_()

	slot0._simageshadow:LoadImage(ResUrl.getCharacterIcon("bg_shade"))
end

function slot0._setTitleText(slot0, slot1, slot2, slot3)
	if gohelper.findChildText(slot1, "attcn") then
		slot4.text = slot2
	end

	if gohelper.findChildText(slot1, "atten") then
		slot5.text = slot3
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageshadow:UnLoadImage()
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._godetailcontent, false)

	slot1 = slot0.viewParam
	slot0.heroId = slot0.viewParam.heroid
	slot0._level = slot0.viewParam.level
	slot0._rank = slot0.viewParam.rank
	slot0._passiveSkillLevel = slot0.viewParam.passiveSkillLevel
	slot0._setEquipInfo = slot0.viewParam.setEquipInfo
	slot0._talentCubeInfos = slot0.viewParam.talentCubeInfos
	slot0._balanceHelper = slot0.viewParam.balanceHelper or HeroGroupBalanceHelper

	gohelper.setActive(slot0.goDescTitle, true)
	gohelper.setActive(slot0.goTotalTitle, true)
	gohelper.setActive(slot0._goattributetip, slot1.tag == "attribute")
	gohelper.setActive(slot0._gopassiveskilltip, slot1.tag == "passiveskill")

	slot1.showAttributeOption = slot1.showAttributeOption or CharacterEnum.showAttributeOption.ShowCurrent

	if slot1.tag == "attribute" then
		slot0:_setAttribute(slot1.equips, slot1.showAttributeOption)
	elseif slot1.tag == "passiveskill" then
		slot0:_setPassiveSkill(slot1.heroid, slot1.showAttributeOption, slot1.anchorParams, slot1.tipPos)
	end
end

function slot0._setAttribute(slot0, slot1, slot2)
	for slot6 = 7, 11 do
		gohelper.setActive(slot0._attrupperitems[slot6].go, false)
	end

	slot0:refreshBaseAttrItem(slot1, slot2)
	slot0:refreshUpAttrItem(slot1, slot2)
end

function slot0.refreshBaseAttrItem(slot0, slot1, slot2)
	slot5 = slot0:getTalentValues(slot2)

	for slot9, slot10 in ipairs(CharacterEnum.BaseAttrIdList) do
		slot11 = HeroConfig.instance:getHeroAttributeCO(slot10)
		slot0._attnormalitems[slot9].value.text = slot3[slot10]
		slot0._attnormalitems[slot9].addValue.text = slot0:getEquipAddBaseValues(slot1, slot0:getBaseAttrValueList(slot2))[slot10] + (slot5[slot10] and slot5[slot10].value or 0) == 0 and "" or "+" .. slot12
		slot0._attnormalitems[slot9].name.text = slot11.name

		CharacterController.instance:SetAttriIcon(slot0._attnormalitems[slot9].icon, slot10, GameUtil.parseColor("#323c34"))

		if slot11.isShowTips == 1 then
			slot14 = gohelper.getClick(slot0._attnormalitems[slot9].detail)

			slot14:AddClickListener(slot0.showDetail, slot0, {
				attributeId = slot11.id,
				icon = slot10,
				go = slot0._attnormalitems[slot9].go
			})
			table.insert(slot0._detailClickItems, slot14)
			gohelper.setActive(slot0._attnormalitems[slot9].detail, true)
		else
			gohelper.setActive(slot0._attnormalitems[slot9].detail, false)
		end

		if slot0._attnormalitems[slot9].withDesc then
			slot13, slot14 = slot0:calculateTechnic(slot3[CharacterEnum.AttrId.Technic], slot2)
			slot0._attnormalitems[slot9].desc.text = string.gsub(string.gsub(CommonConfig.instance:getConstStr(ConstEnum.CharacterTechnicDesc), "▩1%%s", slot13), "▩2%%s", slot14)
		end
	end
end

function slot0.refreshUpAttrItem(slot0, slot1, slot2)
	slot6 = slot0:getTalentValues(slot2)
	slot7, slot8 = slot0:calculateTechnic(slot0:getBaseAttrValueList(slot2)[CharacterEnum.AttrId.Technic], slot2)

	for slot12, slot13 in ipairs(CharacterEnum.UpAttrIdList) do
		gohelper.setActive(slot0._attrupperitems[slot12].go, true)

		slot14 = HeroConfig.instance:getHeroAttributeCO(slot13)
		slot15 = slot0:getEquipBreakAddAttrValues(slot1)[slot13] + (slot6[slot13] and slot6[slot13].value or 0)

		if slot13 == CharacterEnum.AttrId.Cri then
			slot16 = (slot0:_getTotalUpAttributes(slot2)[slot13] or 0) / 10 + slot7
		end

		if slot13 == CharacterEnum.AttrId.CriDmg then
			slot16 = slot16 + slot8
		end

		slot0._attrupperitems[slot12].value.text = tostring(GameUtil.noMoreThanOneDecimalPlace(slot16)) .. "%"
		slot0._attrupperitems[slot12].addValue.text = slot15 == 0 and "" or "+" .. tostring(GameUtil.noMoreThanOneDecimalPlace(slot15)) .. "%"
		slot0._attrupperitems[slot12].name.text = slot14.name

		CharacterController.instance:SetAttriIcon(slot0._attrupperitems[slot12].icon, slot13, uv0.AttrColor)

		if slot14.isShowTips == 1 then
			slot18 = gohelper.getClick(slot0._attrupperitems[slot12].detail)

			slot18:AddClickListener(slot0.showDetail, slot0, {
				attributeId = slot14.id,
				icon = slot13,
				go = slot0._attrupperitems[slot12].go
			})
			table.insert(slot0._detailClickItems, slot18)
			gohelper.setActive(slot0._attrupperitems[slot12].detail, true)
		else
			gohelper.setActive(slot0._attrupperitems[slot12].detail, false)
		end
	end
end

function slot0.getBaseAttrValueList(slot0, slot1)
	slot2 = {}

	if slot1 == CharacterEnum.showAttributeOption.ShowMax then
		slot2 = slot0:_getMaxNormalAtrributes()
	elseif slot1 == CharacterEnum.showAttributeOption.ShowMin then
		slot2 = slot0:_getMinNormalAttribute()
	else
		slot3 = slot0.viewParam.heroMo or HeroModel.instance:getByHeroId(slot0.heroId)
		slot4 = slot0._level
		slot5 = slot0._rank

		if slot0.viewParam.isBalance then
			_, slot5 = HeroConfig.instance:getShowLevel(slot0._balanceHelper.getHeroBalanceLv(slot3.heroId))
		end

		slot2 = slot3:getHeroBaseAttrDict(slot4, slot5)
	end

	return slot2
end

function slot0.getEquipAddBaseValues(slot0, slot1, slot2)
	slot3 = {
		[slot9] = 0
	}
	slot4 = {
		[slot9] = 0
	}

	for slot8, slot9 in ipairs(CharacterEnum.BaseAttrIdList) do
		-- Nothing
	end

	slot5 = nil

	if slot0.viewParam.isBalance then
		_, _, slot5 = slot0._balanceHelper.getBalanceLv()
	end

	if slot1 then
		if slot0.viewParam.trialEquipMo then
			(slot0.viewParam.heroMo or HeroModel.instance:getByHeroId(slot0.heroId)):_calcEquipAttr(slot0.viewParam.trialEquipMo, slot3, slot4)
		end

		for slot10 = 1, #slot1 do
			slot6:_calcEquipAttr(EquipModel.instance:getEquip(slot1[slot10]) and slot0:_modifyEquipInfo(slot11), slot3, slot4, slot5)
		end
	end

	for slot10, slot11 in ipairs(CharacterEnum.BaseAttrIdList) do
		slot3[slot11] = slot3[slot11] + math.floor(slot4[slot11] / 1000 * slot2[slot11])
	end

	return slot3
end

function slot0._modifyEquipInfo(slot0, slot1)
	if slot0._setEquipInfo then
		if slot0._setEquipInfo[3] and slot4.isCachot then
			return slot0._setEquipInfo[1](slot0._setEquipInfo[2], {
				seatLevel = slot4.seatLevel,
				equipMO = slot1
			})
		end
	end

	return slot1
end

function slot0.getTalentValues(slot0, slot1)
	slot2 = {}

	if slot1 == CharacterEnum.showAttributeOption.ShowCurrent then
		slot3 = slot0.viewParam.heroMo or HeroModel.instance:getByHeroId(slot0.heroId)

		if slot0.viewParam.isBalance then
			slot4, slot5, slot6, slot7 = slot0._balanceHelper.getHeroBalanceInfo(slot3.heroId)
			slot2 = slot3:getTalentGain(slot4, slot5, nil, slot7)
		else
			slot2 = slot3:getTalentGain(slot0._level or slot3.level, slot0._rank, nil, slot0._talentCubeInfos)
		end

		for slot7, slot8 in pairs(HeroConfig.instance:talentGainTab2IDTab(slot2)) do
			if HeroConfig.instance:getHeroAttributeCO(slot7).type ~= 1 then
				slot2[slot7].value = slot2[slot7].value / 10
			else
				slot2[slot7].value = math.floor(slot2[slot7].value)
			end
		end
	end

	return slot2
end

function slot0.getEquipBreakAddAttrValues(slot0, slot1)
	slot2 = {
		[slot7] = 0
	}

	for slot6, slot7 in ipairs(CharacterEnum.BaseAttrIdList) do
		-- Nothing
	end

	for slot6, slot7 in ipairs(CharacterEnum.UpAttrIdList) do
		slot2[slot7] = 0
	end

	if slot1 and slot0.viewParam.heroMo and slot0.viewParam.trialEquipMo then
		slot3 = slot0.viewParam.trialEquipMo
		slot4, slot5 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(slot3.config, slot3.breakLv)

		if slot4 then
			slot2[slot4] = slot2[slot4] + slot5
		end
	end

	if slot1 and #slot1 > 0 then
		for slot6, slot7 in ipairs(slot1) do
			if EquipModel.instance:getEquip(slot7) then
				slot8 = slot0:_modifyEquipInfo(slot8)
				slot9, slot10 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(slot8.config, slot8.breakLv)

				if slot9 then
					slot2[slot9] = slot2[slot9] + slot10
				end
			end
		end
	end

	for slot6, slot7 in pairs(slot2) do
		slot2[slot6] = slot7 / 10
	end

	return slot2
end

function slot0.calculateTechnic(slot0, slot1, slot2)
	slot3, slot4, slot5 = nil

	if slot2 == CharacterEnum.showAttributeOption.ShowMax then
		slot5 = CharacterModel.instance:getMaxLevel(slot0.viewParam.heroid)
	elseif slot2 == CharacterEnum.showAttributeOption.ShowMin then
		slot5 = 1
	else
		slot5 = slot0._level or (slot0.viewParam.heroMo or HeroModel.instance:getByHeroId(slot0.viewParam.heroid)).level

		if slot0.viewParam.isBalance then
			slot5 = slot0._balanceHelper.getHeroBalanceLv(slot6.heroId)
		end
	end

	slot10 = (tonumber(lua_fight_const.configDict[13].value) + slot5 * tonumber(lua_fight_const.configDict[14].value) * 10) * 10

	return string.format("%.1f", slot1 * tonumber(lua_fight_const.configDict[11].value) / slot10), string.format("%.1f", slot1 * tonumber(lua_fight_const.configDict[12].value) / slot10)
end

function slot0._getTotalUpAttributes(slot0, slot1)
	slot2 = nil

	for slot7, slot8 in ipairs(CharacterEnum.UpAttrIdList) do
		-- Nothing
	end

	return {
		[slot8] = ((slot1 ~= CharacterEnum.showAttributeOption.ShowMax or SkillConfig.instance:getherolevelCO(slot0.viewParam.heroid, CharacterModel.instance:getrankEffects(slot0.viewParam.heroid, CharacterModel.instance:getMaxRank(slot0.viewParam.heroid))[1])) and (slot1 ~= CharacterEnum.showAttributeOption.ShowMin or SkillConfig.instance:getherolevelCO(slot0.viewParam.heroid, 1)) and (slot0.viewParam.heroMo or HeroModel.instance:getByHeroId(slot0.viewParam.heroid)):getHeroLevelConfig())[CharacterEnum.AttrIdToAttrName[slot8]] or 0
	}
end

function slot0._getMaxNormalAtrributes(slot0)
	slot3 = SkillConfig.instance:getherolevelCO(slot0.viewParam.heroid, CharacterModel.instance:getMaxLevel(slot0.viewParam.heroid))
	slot4 = SkillConfig.instance:getHeroRankAttribute(slot0.viewParam.heroid, CharacterModel.instance:getMaxRank(slot0.viewParam.heroid))

	return {
		[CharacterEnum.AttrId.Attack] = slot3.atk + slot4.atk,
		[CharacterEnum.AttrId.Hp] = slot3.hp + slot4.hp,
		[CharacterEnum.AttrId.Defense] = slot3.def + slot4.def,
		[CharacterEnum.AttrId.Mdefense] = slot3.mdef + slot4.mdef,
		[CharacterEnum.AttrId.Technic] = slot3.technic + slot4.technic
	}
end

function slot0._getMinNormalAttribute(slot0)
	slot1 = SkillConfig.instance:getherolevelCO(slot0.viewParam.heroid, 1)

	return {
		[CharacterEnum.AttrId.Attack] = slot1.atk,
		[CharacterEnum.AttrId.Hp] = slot1.hp,
		[CharacterEnum.AttrId.Defense] = slot1.def,
		[CharacterEnum.AttrId.Mdefense] = slot1.mdef,
		[CharacterEnum.AttrId.Technic] = slot1.technic
	}
end

function slot0._countRate(slot0, slot1, slot2, slot3)
	for slot7 = 1, slot3 - 1 do
		if slot1 < slot2[slot7 + 1] then
			return slot7
		end
	end

	return slot3
end

function slot0._setPassiveSkill(slot0, slot1, slot2, slot3, slot4)
	slot0._matchSkillNames = {}
	slot5 = nil
	slot6 = SkillConfig.instance:getPassiveSKillsCoByExSkillLevel(slot1, (slot2 ~= CharacterEnum.showAttributeOption.ShowMax or CharacterEnum.MaxSkillExLevel) and (slot2 == CharacterEnum.showAttributeOption.ShowMin and 0 or (slot0.viewParam.heroMo or HeroModel.instance:getByHeroId(slot1)).exSkillLevel))

	if slot0.viewParam.heroMo and slot0.viewParam.heroMo.trialAttrCo then
		slot6 = slot0.viewParam.heroMo:getpassiveskillsCO()
	end

	slot0._txtpassivename.text = lua_skill.configDict[slot6[1].skillPassive].name
	slot9 = {}

	for slot13 = 1, #slot6 do
		table.insert(slot9, FightConfig.instance:getSkillEffectDesc(HeroConfig.instance:getHeroCO(slot1).name, lua_skill.configDict[slot6[slot13].skillPassive]))
	end

	slot10 = HeroSkillModel.instance:getSkillEffectTagIdsFormDescTabRecursion(slot9)
	slot11 = {}
	slot12 = {}
	slot13 = 0

	if slot0.viewParam.isBalance then
		slot13 = SkillConfig.instance:getHeroExSkillLevelByLevel(slot0.viewParam.heroMo.heroId, math.max(slot0._level or slot0.viewParam.heroMo.level, slot0._balanceHelper.getHeroBalanceLv(slot0.viewParam.heroMo.heroId)))
	end

	for slot17 = 1, #slot6 do
		slot18 = slot6[slot17].skillPassive
		slot19 = slot0:_getPassiveUnlock(slot2, slot1, slot17, slot0.viewParam.heroMo)

		if slot0.viewParam.isBalance then
			slot19 = slot17 <= slot13
		end

		for slot26, slot27 in ipairs(slot10[slot17]) do
			if HeroSkillModel.instance:canShowSkillTag(SkillConfig.instance:getSkillEffectDescCo(slot27).name, true) and not slot11[slot29] then
				slot11[slot29] = true

				if slot28.isSpecialCharacter == 1 then
					slot22 = string.format("%s", FightConfig.instance:getSkillEffectDesc(HeroConfig.instance:getHeroCO(slot1).name, lua_skill.configDict[slot18]))

					table.insert(slot12, {
						desc = SkillHelper.buildDesc(slot28.desc),
						title = slot28.name
					})
				end
			end
		end

		slot23 = SkillHelper.buildDesc(slot22)

		if not slot19 then
			slot0._passiveskillitems[slot17].unlocktxt.text = string.format(luaLang("character_passive_get"), GameUtil.getRomanNums(slot0:_getTargetRankByEffect(slot1, slot17)))

			SLFramework.UGUI.GuiHelper.SetColor(slot0._passiveskillitems[slot17].unlocktxt, "#3A3A3A")
		else
			slot0._passiveskillitems[slot17].unlocktxt.text = string.format(luaLang("character_passive_unlock"), GameUtil.getRomanNums(slot24))

			SLFramework.UGUI.GuiHelper.SetColor(slot0._passiveskillitems[slot17].unlocktxt, "#313B33")
		end

		slot0._passiveskillitems[slot17].canvasgroup.alpha = slot19 and 1 or 0.83

		gohelper.setActive(slot0._passiveskillitems[slot17].on, slot19)

		slot0._passiveskillitems[slot17].desc.text = slot23

		slot0._passiveskillitems[slot17].fixTmpBreakLine:refreshTmpContent(slot0._passiveskillitems[slot17].desc)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._passiveskillitems[slot17].desc, slot19 and "#272525" or "#3A3A3A")
		gohelper.setActive(slot0._passiveskillitems[slot17].go, true)
		gohelper.setActive(slot0._passiveskillitems[slot17].connectline, slot17 ~= #slot6)
	end

	for slot17 = #slot6 + 1, #slot0._passiveskillitems do
		gohelper.setActive(slot0._passiveskillitems[slot17].go, false)
	end

	slot0:_showSkillEffectDesc(slot12)
	slot0:_refreshPassiveSkillScroll()
	slot0:_setTipPos(slot0._gopassiveskilltip.transform, slot4, slot3)
end

function slot0._setTipPos(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	slot4 = slot3 and slot3[1] or Vector2.New(0.5, 0.5)
	slot5 = slot3 and slot3[2] or Vector2.New(0.5, 0.5)
	slot6 = slot2 and slot2 or Vector2.New(0, 0)
	slot0._gopassiveskilltip.transform.anchorMin = slot4
	slot0._gopassiveskilltip.transform.anchorMax = slot5
	slot0._goBuffItem.transform.anchorMin = slot4
	slot0._goBuffItem.transform.anchorMax = slot5

	recthelper.setAnchor(slot1, slot6.x, slot6.y)
	recthelper.setAnchorX(slot0._goBuffItem.transform, slot0.viewParam.buffTipsX or 0)
end

function slot0._refreshPassiveSkillScroll(slot0)
	slot0:_setScrollMaskVisible()

	slot1 = gohelper.findChild(slot0._gopassiveskilltip, "mask/root/scrollview/viewport")
	slot3 = gohelper.onceAddComponent(slot1, typeof(UnityEngine.UI.LayoutElement))
	gohelper.onceAddComponent(slot1, gohelper.Type_VerticalLayoutGroup).enabled = false
	slot3.enabled = true
	slot3.preferredHeight = recthelper.getHeight(slot1.transform)
end

function slot0._showSkillEffectDesc(slot0, slot1)
	gohelper.setActive(slot0._goeffectdesc, slot1 and #slot1 > 0)

	for slot5 = 1, #slot1 do
		slot6 = slot1[slot5]
		slot7 = slot0:_getSkillEffectDescItem(slot5)
		slot7.desc.text = slot6.desc
		slot7.title.text = SkillHelper.removeRichTag(slot6.title)

		slot7.fixTmpBreakLine:refreshTmpContent(slot7.desc)
		gohelper.setActive(slot7.go, true)
	end

	for slot5 = #slot1 + 1, #slot0._skillEffectDescItems do
		gohelper.setActive(slot0._passiveskillitems[slot5].go, false)
	end
end

function slot0._getSkillEffectDescItem(slot0, slot1)
	if not slot0._skillEffectDescItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._goeffectdescitem, "descitem" .. slot1)
		slot2.desc = gohelper.findChildText(slot2.go, "effectdesc")
		slot2.title = gohelper.findChildText(slot2.go, "titlebg/bg/name")
		slot2.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(slot2.desc.gameObject, FixTmpBreakLine)
		slot2.hyperLinkClick = SkillHelper.addHyperLinkClick(slot2.desc, slot0._onHyperLinkClick, slot0)

		table.insert(slot0._skillEffectDescItems, slot1, slot2)
	end

	return slot2
end

slot0.LeftWidth = 470
slot0.RightWidth = 190
slot0.TopHeight = 292
slot0.Interval = 10

function slot0._onHyperLinkClick(slot0, slot1, slot2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(tonumber(slot1), slot0.setTipPosCallback, slot0)
end

function slot0.setTipPosCallback(slot0, slot1, slot2)
	slot0.rectTrPassive = slot0.rectTrPassive or slot0._gopassiveskilltip:GetComponent(gohelper.Type_RectTransform)
	slot5, slot6 = recthelper.uiPosToScreenPos2(slot0.rectTrPassive)
	slot7, slot8 = SLFramework.UGUI.RectTrHelper.ScreenPosXYToAnchorPosXY(slot5, slot6, slot1, CameraMgr.instance:getUICamera(), nil, )
	slot2.pivot = CommonBuffTipEnum.Pivot.Right
	slot12 = slot7

	recthelper.setAnchor(slot2, recthelper.getWidth(slot2) <= GameUtil.getViewSize() / 2 + slot7 - uv0.LeftWidth - uv0.Interval and slot12 - uv0.LeftWidth - uv0.Interval or slot12 + uv0.RightWidth + uv0.Interval + slot10, slot8 + uv0.TopHeight)
end

function slot0._setScrollMaskVisible(slot0)
	ZProj.UGUIHelper.RebuildLayout(gohelper.findChild(slot0._gopassiveskilltip, "mask/root").transform)

	slot0._couldScroll = recthelper.getHeight(slot0._scrollview.transform) < recthelper.getHeight(slot0._passiveskilltipcontent.transform)

	gohelper.setActive(slot0._gomask1, slot0._couldScroll and gohelper.getRemindFourNumberFloat(slot0._scrollview.verticalNormalizedPosition) > 0)

	slot0._passiveskilltipmask.enabled = false
end

function slot0._getPassiveUnlock(slot0, slot1, slot2, slot3, slot4)
	if slot1 == CharacterEnum.showAttributeOption.ShowMax then
		return true
	elseif slot1 == CharacterEnum.showAttributeOption.ShowMin then
		return false
	elseif slot4 then
		return CharacterModel.instance:isPassiveUnlockByHeroMo(slot4, slot3, slot0._passiveSkillLevel)
	else
		return CharacterModel.instance:isPassiveUnlock(slot2, slot3)
	end
end

function slot0._getTargetRankByEffect(slot0, slot1, slot2)
	for slot7, slot8 in pairs(SkillConfig.instance:getheroranksCO(slot1)) do
		if CharacterModel.instance:getrankEffects(slot1, slot7)[2] == slot2 then
			return slot7 - 1
		end
	end

	return 0
end

function slot0.showDetail(slot0, slot1)
	slot0._isOpenAttrDesc = not slot0._isOpenAttrDesc

	gohelper.setActive(slot0._godetailcontent, slot0._isOpenAttrDesc)

	if not slot0._isOpenAttrDesc then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_role_description)

	if recthelper.rectToRelativeAnchorPos(slot1.go.transform.position, slot0._goattributetip.transform).y < uv0.DetailClickMinPos then
		recthelper.setAnchorY(slot0._godetailcontent.transform, uv0.DetailBottomPos)
	else
		recthelper.setAnchorY(slot0._godetailcontent.transform, slot2.y + uv0.DetailOffset)
	end

	slot3 = HeroConfig.instance:getHeroAttributeCO(slot1.attributeId)
	slot0._txtDetailItemName.text = slot3.name
	slot8 = GameUtil.parseColor
	slot9 = "#975129"

	CharacterController.instance:SetAttriIcon(slot0._txtDetailItemIcon, slot1.icon, slot8(slot9))

	for slot8, slot9 in ipairs(string.split(slot3.desc, "|")) do
		if not slot0._detailDescTab[slot8] then
			slot10 = gohelper.clone(slot0._txtDetailItemDesc.gameObject, slot0._goattributecontentitem, "descItem")

			gohelper.setActive(slot10, false)
			table.insert(slot0._detailDescTab, slot10)
		end

		gohelper.setActive(slot10, true)

		slot10:GetComponent(gohelper.Type_TextMesh).text = slot9
	end

	for slot8 = #slot4 + 1, #slot0._detailDescTab do
		gohelper.setActive(slot0._detailDescTab[slot8], false)
	end
end

function slot0.onClose(slot0)
	for slot4, slot5 in pairs(slot0._detailClickItems) do
		slot5:RemoveClickListener()
	end
end

return slot0
