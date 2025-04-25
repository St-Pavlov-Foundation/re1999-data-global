module("modules.logic.enemyinfo.view.EnemyInfoRightView", package.seeall)

slot0 = class("EnemyInfoRightView", BaseView)

function slot0.onInitView(slot0)
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#go_right_container/#go_header/head/#simage_icon")
	slot0._imagecareer = gohelper.findChildImage(slot0.viewGO, "#go_right_container/#go_header/head/#image_career")
	slot0._gobosstag = gohelper.findChild(slot0.viewGO, "#go_right_container/#go_header/head/#go_bosstag")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_right_container/#go_header/#txt_name")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "#go_right_container/#go_header/#txt_level")
	slot0._txthp = gohelper.findChildText(slot0.viewGO, "#go_right_container/#go_header/hp/hp_label/image_HPFrame/#txt_hp")
	slot0._gomultihp = gohelper.findChild(slot0.viewGO, "#go_right_container/#go_header/hp/hp_label/image_HPFrame/#go_multihp")
	slot0._gomultihpitem = gohelper.findChild(slot0.viewGO, "#go_right_container/#go_header/hp/hp_label/image_HPFrame/#go_multihp/#go_hpitem")
	slot0._btnshowAttribute = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_right_container/#go_line1/#btn_showAttribute")
	slot0._gonormalIcon = gohelper.findChild(slot0.viewGO, "#go_right_container/#go_line1/#btn_showAttribute/#go_normalIcon")
	slot0._goselectIcon = gohelper.findChild(slot0.viewGO, "#go_right_container/#go_line1/#btn_showAttribute/#go_selectIcon")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#txt_desc")
	slot0._goattribute = gohelper.findChild(slot0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_attribute")
	slot0._gobossspecialskill = gohelper.findChild(slot0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_bossspecialskill")
	slot0._goresistance = gohelper.findChild(slot0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_resistance")
	slot0._gopassiveskill = gohelper.findChild(slot0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_passiveskill")
	slot0._gopassiveskillitem = gohelper.findChild(slot0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_passiveskill/#go_passiveskillitem")
	slot0._gonoskill = gohelper.findChild(slot0.viewGO, "#go_right_container/#go_skill_container/#go_noskill")
	slot0._goskill = gohelper.findChild(slot0.viewGO, "#go_right_container/#go_skill_container/#go_skill")
	slot0._gosuperitem = gohelper.findChild(slot0.viewGO, "#go_right_container/#go_skill_container/#go_skill/card/scrollview/viewport/content/supers/#go_superitem")
	slot0._goskillitem = gohelper.findChild(slot0.viewGO, "#go_right_container/#go_skill_container/#go_skill/card/scrollview/viewport/content/skills/#go_skillitem")
	slot0._gopassivedescitempool = gohelper.findChild(slot0.viewGO, "#go_right_container/#go_passivedescitem_pool")
	slot0._gopassivedescitem = gohelper.findChild(slot0.viewGO, "#go_right_container/#go_passivedescitem_pool/#go_descitem")
	slot0._gobufftipitem = gohelper.findChild(slot0.viewGO, "#go_tip_container/#go_bufftip/#scroll_buff/viewport/content/#go_buffitem")
	slot0._gomultistage = gohelper.findChild(slot0.viewGO, "#go_right_container/#go_header/#go_multi_stage")
	slot0._gostageitem = gohelper.findChild(slot0.viewGO, "#go_right_container/#go_header/#go_multi_stage/#go_stage_item")
	slot0._btnstress = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#go_right_container/#go_header/#btn_stress")
	slot0._gostress = slot0._btnstress.gameObject

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnshowAttribute:AddClickListener(slot0._btnshowAttributeOnClick, slot0)
	slot0._btnstress:AddClickListener(slot0.onClickStress, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnshowAttribute:RemoveClickListener()
	slot0._btnstress:RemoveClickListener()
end

slot0.AttrIdList = {
	CharacterEnum.AttrId.Attack,
	CharacterEnum.AttrId.Technic,
	CharacterEnum.AttrId.Defense,
	CharacterEnum.AttrId.Mdefense
}

function slot0.onClickStress(slot0)
	StressTipController.instance:openMonsterStressTip(slot0.monsterConfig)
end

function slot0._btnshowAttributeOnClick(slot0)
	slot0.isShowAttributeInfo = not slot0.isShowAttributeInfo

	slot0:refreshAttributeAndDescVisible()
end

function slot0.onClickBossSpecialSkill(slot0)
	if not slot0.isBoss then
		return
	end

	slot3 = CameraMgr.instance:getUICamera()
	slot4, slot5 = recthelper.worldPosToAnchorPos2(slot0.specialSkillItemList[slot0.useBossSpecialSkillCount].go:GetComponent(gohelper.Type_Transform).position, slot0.tipContainerRectTr, slot3, slot3)

	recthelper.setAnchor(slot0.buffTipRectTr, slot4 + EnemyInfoEnum.BuffTipOffset.x, slot5 + EnemyInfoEnum.BuffTipOffset.y)
	EnemyInfoController.instance:dispatchEvent(EnemyInfoEvent.ShowTip, EnemyInfoEnum.Tip.BuffTip)
end

function slot0.onClickSkillItem(slot0, slot1)
	slot0.tipViewParam = slot0.tipViewParam or {}
	slot0.tipViewParam.super = slot1.super
	slot0.tipViewParam.skillIdList = slot1.skillIdList
	slot0.tipViewParam.monsterName = FightConfig.instance:getMonsterName(slot0.monsterConfig)

	ViewMgr.instance:openView(ViewName.SkillTipView3, slot0.tipViewParam)
end

function slot0.onClickStageItem(slot0, slot1)
	if slot0.monsterId == slot1.monsterId then
		return
	end

	slot0.monsterId = slot1.monsterId
	slot0.monsterConfig = lua_monster.configDict[slot0.monsterId]
	slot0.skinConfig = FightConfig.instance:getSkinCO(slot0.monsterConfig.skinId)

	slot0:refreshUI()
end

function slot0.initAttributeItemList(slot0)
	slot0.attributeItemList = {}

	for slot4 = 1, 4 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0._goattribute, "attribute" .. slot4)
		slot5.icon = gohelper.findChildImage(slot5.go, "icon")
		slot5.name = gohelper.findChildText(slot5.go, "name")
		slot5.rate = gohelper.findChildImage(slot5.go, "rate")

		table.insert(slot0.attributeItemList, slot5)
	end
end

function slot0._editableInitView(slot0)
	slot0.rectTrRight = gohelper.findChild(slot0.viewGO, "#go_right_container"):GetComponent(gohelper.Type_RectTransform)
	slot0.rectTrViewGo = slot0.viewGO:GetComponent(gohelper.Type_RectTransform)
	slot0._gEnemyDesc = slot0._txtdesc.gameObject
	slot0.isShowAttributeInfo = false
	slot0.tipContainerRectTr = gohelper.findChildComponent(slot0.viewGO, "#go_tip_container", gohelper.Type_RectTransform)
	slot0.buffTipRectTr = gohelper.findChildComponent(slot0.viewGO, "#go_tip_container/#go_bufftip", gohelper.Type_RectTransform)
	slot0.specialSkillItemList = {}
	slot0.goBossSpecialSkillItem = gohelper.findChild(slot0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_bossspecialskill/item")
	slot0.scrollEnemyInfo = gohelper.findChildScrollRect(slot0.viewGO, "#go_right_container/#scroll_enemyinfo")

	gohelper.setActive(slot0.goBossSpecialSkillItem, false)
	gohelper.setActive(slot0._gosuperitem, false)
	gohelper.setActive(slot0._goskillitem, false)
	gohelper.setActive(slot0._gopassiveskillitem, false)
	gohelper.setActive(slot0._gobufftipitem, false)
	gohelper.setActive(slot0._gostageitem, false)

	slot0.bossSpecialClick = gohelper.getClickWithDefaultAudio(slot0._gobossspecialskill)

	slot0.bossSpecialClick:AddClickListener(slot0.onClickBossSpecialSkill, slot0)

	slot0.passiveSkillItemList = {}
	slot0.passiveDescItemPool = {}
	slot0.passiveDescItemList = {}
	slot0.trPassiveDescItemPool = slot0._gopassivedescitempool:GetComponent(gohelper.Type_Transform)

	gohelper.setActive(slot0._gopassivedescitempool, false)

	slot0.smallSkillItemList = {}
	slot0.superSkillItemList = {}
	slot0.buffTipItemList = {}
	slot0.stageItemList = {}
	slot0.multiHpGoList = slot0:getUserDataTb_()

	table.insert(slot0.multiHpGoList, slot0._gomultihpitem)
	slot0:initAttributeItemList()
	slot0:addEventCb(EnemyInfoController.instance, EnemyInfoEvent.SelectMonsterChange, slot0.onSelectMonsterChange, slot0)

	if DungeonModel.instance.curSendChapterId then
		slot0.isSimple = DungeonConfig.instance:getChapterCO(slot2) and slot3.type == DungeonEnum.ChapterType.Simple
	end

	slot0.resistanceComp = FightEntityResistanceComp.New(slot0._goresistance, slot0.viewContainer)

	slot0.resistanceComp:onInitView()
	slot0.resistanceComp:setParent(slot0.scrollEnemyInfo.gameObject)
end

function slot0.onSelectMonsterChange(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0.monsterId == slot1.monsterId then
		return
	end

	slot0.monsterId = slot2
	slot0.isBoss = slot1.isBoss
	slot0.monsterConfig = lua_monster.configDict[slot0.monsterId]
	slot0.skinConfig = FightConfig.instance:getSkinCO(slot0.monsterConfig.skinId)

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshAttributeAndDescVisible()
	slot0:refreshHeader()
	slot0:refreshDesc()
	slot0:refreshAttribute()
	slot0:refreshBossSpecialSkill()
	slot0:refreshResistance()
	slot0:refreshPassiveSkill()
	slot0:refreshSkill()
end

function slot0.refreshAttributeAndDescVisible(slot0)
	gohelper.setActive(slot0._gonormalIcon, not slot0.isShowAttributeInfo)
	gohelper.setActive(slot0._gEnemyDesc, not slot0.isShowAttributeInfo)
	gohelper.setActive(slot0._goselectIcon, slot0.isShowAttributeInfo)
	gohelper.setActive(slot0._goattribute, slot0.isShowAttributeInfo)

	slot0.scrollEnemyInfo.verticalNormalizedPosition = 1
end

function slot0.refreshHeader(slot0)
	slot1 = slot0.monsterConfig

	gohelper.getSingleImage(slot0._imageicon.gameObject):LoadImage(ResUrl.monsterHeadIcon(slot0.skinConfig.headIcon))
	IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(slot1.heartVariantId), slot0._imageicon)
	gohelper.setActive(slot0._gobosstag, slot0.isBoss)
	UISpriteSetMgr.instance:setEnemyInfoSprite(slot0._imagecareer, "sxy_" .. slot1.career)

	slot0._txtlevel.text = HeroConfig.instance:getLevelDisplayVariant(slot1[slot0.isSimple and "levelEasy" or "level"])
	slot0._txtname.text = FightConfig.instance:getMonsterName(slot1)

	if slot0.viewParam.tabEnum == EnemyInfoEnum.TabEnum.Rouge then
		slot0._txthp.text = tonumber(CharacterDataConfig.instance:getMonsterHp(slot1.id, slot0.isSimple)) and math.floor(slot6 * slot0.viewParam.hpFixRate) or slot5
	else
		slot0._txthp.text = CharacterDataConfig.instance:getMonsterHp(slot1.id, slot0.isSimple)
	end

	slot0:refreshMultiHp()
	slot0:refreshMultiStage()
	slot0:refreshStress()
end

function slot0.refreshMultiHp(slot0)
	if not FightConfig.instance:getMultiHpListByMonsterId(slot0.monsterConfig.id, slot0.isSimple) then
		gohelper.setActive(slot0._gomultihp, false)

		return
	end

	gohelper.setActive(slot0._gomultihp, true)

	for slot6 = 1, #slot1 do
		if not slot0.multiHpGoList[slot6] then
			table.insert(slot0.multiHpGoList, gohelper.cloneInPlace(slot0._gomultihpitem))
		end

		gohelper.setActive(slot7, true)
	end

	for slot6 = slot2 + 1, #slot0.multiHpGoList do
		gohelper.setActive(slot0.multiHpGoList[slot6], false)
	end
end

function slot0.refreshMultiStage(slot0)
	if slot0.viewParam.tabEnum ~= EnemyInfoEnum.TabEnum.BossRush then
		gohelper.setActive(slot0._gomultistage, false)

		return
	end

	if not lua_activity128_countboss.configDict[slot0.enemyInfoMo.battleId] then
		logError("activity128_countboss config not found battle id : " .. tostring(slot1))
		gohelper.setActive(slot0._gomultistage, false)

		return
	end

	if #string.splitToNumber(slot2.monsterId, "#") <= 1 then
		gohelper.setActive(slot0._gomultistage, false)

		return
	end

	if not tabletool.indexOf(slot3, slot0.monsterId) then
		gohelper.setActive(slot0._gomultistage, false)

		return
	end

	gohelper.setActive(slot0._gomultistage, true)

	for slot8, slot9 in ipairs(slot3) do
		if not slot0.stageItemList[slot8] then
			table.insert(slot0.stageItemList, slot0:getStageItem())
		end

		gohelper.setActive(slot10.go, true)

		slot10.txt.text = GameUtil.getRomanNums(slot8)
		slot10.monsterId = slot9
		slot11 = slot9 == slot0.monsterId
		slot10.txt.color = slot11 and EnemyInfoEnum.StageColor.Select or EnemyInfoEnum.StageColor.Normal

		gohelper.setActive(slot10.goSelect, slot11)

		if slot11 then
			if slot8 == slot4 then
				UISpriteSetMgr.instance:setEnemyInfoSprite(slot10.imageSelect, "fight_btn_grip2")
			else
				UISpriteSetMgr.instance:setEnemyInfoSprite(slot10.imageSelect, "fight_btn_grip1")
			end
		end
	end

	for slot8 = slot4 + 1, #slot0.stageItemList do
		gohelper.setActive(slot0.stageItemList[slot8].go, false)
	end
end

function slot0.refreshStress(slot0)
	if slot0.viewParam.tabEnum == EnemyInfoEnum.TabEnum.Rouge and not (RougeModel.instance:getRougeInfo() and slot1:checkMountDlc()) then
		gohelper.setActive(slot0._gostress, false)

		return
	end

	slot2 = lua_monster_skill_template.configDict[slot0.monsterConfig.skillTemplate] and slot1.maxStress

	gohelper.setActive(slot0._gostress, slot2 and slot2 > 0)
end

function slot0.getStageItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0._gostageitem)
	slot1.txt = gohelper.findChildText(slot1.go, "#txt_stage")
	slot1.imageSelect = gohelper.findChildImage(slot1.go, "#image_select")
	slot1.goSelect = gohelper.findChild(slot1.go, "#image_select")
	slot1.click = gohelper.getClickWithDefaultAudio(slot1.go)

	slot1.click:AddClickListener(slot0.onClickStageItem, slot0, slot1)

	return slot1
end

function slot0.refreshDesc(slot0)
	slot0._txtdesc.text = FightConfig.instance:getNewMonsterConfig(slot0.monsterConfig) and slot0.monsterConfig.highPriorityDes or slot0.monsterConfig.des
end

function slot0.refreshAttribute(slot0)
	if string.nilorempty(lua_monster_skill_template.configDict[slot0.monsterConfig.skillTemplate].template) then
		logError(string.format("怪物模板表, id ： %s, 没有配置属性倾向。", slot1.id))

		return
	end

	slot3 = string.splitToNumber(slot2, "#")
	slot7 = table.remove
	slot8 = slot3

	table.insert(slot3, 2, slot7(slot8, 4))

	for slot7, slot8 in ipairs(uv0.AttrIdList) do
		slot9 = slot0.attributeItemList[slot7]
		slot10 = HeroConfig.instance:getHeroAttributeCO(slot8)
		slot9.name.text = slot10.name

		UISpriteSetMgr.instance:setCommonSprite(slot9.icon, "icon_att_" .. slot10.id)
		UISpriteSetMgr.instance:setCommonSprite(slot9.rate, "sx_" .. slot3[slot7], true)
	end
end

function slot0.recycleAllBossSpecialSkillItem(slot0)
	for slot4, slot5 in ipairs(slot0.specialSkillItemList) do
		gohelper.setActive(slot5.go, false)
	end

	slot0.useBossSpecialSkillCount = 0
end

function slot0.getBossSpecialSkillItem(slot0)
	if slot0.useBossSpecialSkillCount < #slot0.specialSkillItemList then
		slot0.useBossSpecialSkillCount = slot0.useBossSpecialSkillCount + 1
		slot1 = slot0.specialSkillItemList[slot0.useBossSpecialSkillCount]

		gohelper.setActive(slot1.go, true)

		return slot1
	end

	slot0.useBossSpecialSkillCount = slot0.useBossSpecialSkillCount + 1
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0.goBossSpecialSkillItem)
	slot1.gotag = gohelper.findChild(slot1.go, "tag")
	slot1.txttag = gohelper.findChildText(slot1.go, "tag/#txt_tag")
	slot1.imageicon = gohelper.findChildImage(slot1.go, "icon")

	gohelper.setActive(slot1.go, true)
	table.insert(slot0.specialSkillItemList, slot1)

	return slot1
end

function slot0.refreshBossSpecialSkill(slot0)
	gohelper.setActive(slot0._gobossspecialskill, slot0.isBoss)

	if slot0.isBoss then
		slot0:recycleAllBossSpecialSkillItem()
		slot0:recycleBuffTipItem()

		for slot5, slot6 in ipairs(FightConfig.instance:getPassiveSkillsAfterUIFilter(slot0.monsterConfig.id)) do
			if lua_skill_specialbuff.configDict[slot6] and slot7.isSpecial == 1 then
				if string.nilorempty(slot7.lv) then
					gohelper.setActive(slot0:getBossSpecialSkillItem().gotag, false)
				else
					gohelper.setActive(slot8.gotag, true)

					slot8.txttag.text = slot7.lv
				end

				UISpriteSetMgr.instance:setFightPassiveSprite(slot8.imageicon, slot7.icon)

				slot9 = slot0:getBuffTipItem()
				slot10 = lua_skill.configDict[slot6]
				slot9.name.text = slot10.name
				slot9.desc.text = SkillHelper.getSkillDesc(FightConfig.instance:getMonsterName(slot0.monsterConfig), slot10, "#CC492F", "#485E92")

				gohelper.setActive(slot9.goline, true)
				UISpriteSetMgr.instance:setFightPassiveSprite(slot9.bufficon, slot7.icon)
			end
		end

		if slot0.useBuffTipCount > 0 then
			gohelper.setActive(slot0.buffTipItemList[slot0.useBuffTipCount].goline, false)
		else
			gohelper.setActive(slot0._gobossspecialskill, false)
		end
	end
end

function slot0.refreshResistance(slot0)
	slot2 = slot0.monsterConfig.skillTemplate and lua_monster_skill_template.configDict[slot1]
	slot3 = slot2 and slot2.resistance

	if slot3 and lua_resistances_attribute.configDict[slot3] then
		slot0.resistanceDict = slot0.resistanceDict or {}

		tabletool.clear(slot0.resistanceDict)

		for slot8, slot9 in pairs(FightEnum.Resistance) do
			if slot4[slot8] > 0 then
				slot0.resistanceDict[slot8] = slot10
			end
		end

		slot0.resistanceComp:refresh(slot0.resistanceDict)
	else
		slot0.resistanceComp:refresh(nil)
	end
end

function slot0.refreshPassiveSkill(slot0)
	slot0:recycleAllPassiveSkillItem()
	slot0:recycleAllPassiveDescItem()

	slot0.exitsTagNameDict = slot0.exitsTagNameDict or {}

	tabletool.clear(slot0.exitsTagNameDict)

	for slot5, slot6 in ipairs(FightConfig.instance:getPassiveSkillsAfterUIFilter(slot0.monsterConfig.id)) do
		if slot0.isBoss then
			if not lua_skill_specialbuff.configDict[slot6] or slot7.isSpecial ~= 1 then
				slot0:refreshOnePassiveSkill(slot6)
			end
		else
			slot0:refreshOnePassiveSkill(slot6)
		end
	end
end

function slot0.refreshOnePassiveSkill(slot0, slot1)
	slot2 = slot0:getPassiveSkillItem()
	slot3 = lua_skill.configDict[slot1]
	slot2.name.text = slot3.name
	slot6 = slot0:getPassiveDescItem()

	slot6.tr:SetParent(slot2.tr)

	slot6.txt.text = SkillHelper.buildDesc(FightConfig.instance:getSkillEffectDesc(FightConfig.instance:getMonsterName(slot0.monsterConfig), slot3))
end

function slot0.getPassiveSkillItem(slot0)
	if slot0.usePassiveSkillItemCount < #slot0.passiveSkillItemList then
		slot0.usePassiveSkillItemCount = slot0.usePassiveSkillItemCount + 1
		slot1 = slot0.passiveSkillItemList[slot0.usePassiveSkillItemCount]

		recthelper.setWidth(slot1.rectTr, slot0.layoutMo.enemyInfoWidth)
		gohelper.setActive(slot1.go, true)

		return slot1
	end

	slot0.usePassiveSkillItemCount = slot0.usePassiveSkillItemCount + 1
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0._gopassiveskillitem)
	slot1.tr = slot1.go:GetComponent(gohelper.Type_Transform)
	slot1.rectTr = slot1.go:GetComponent(gohelper.Type_RectTransform)

	recthelper.setWidth(slot1.rectTr, slot0.layoutMo.enemyInfoWidth)

	slot1.name = gohelper.findChildText(slot1.go, "bg/name")

	gohelper.setActive(slot1.go, true)
	table.insert(slot0.passiveSkillItemList, slot1)

	return slot1
end

function slot0.recycleAllPassiveSkillItem(slot0)
	for slot4, slot5 in ipairs(slot0.passiveSkillItemList) do
		gohelper.setActive(slot5.go, false)
	end

	slot0.usePassiveSkillItemCount = 0
end

function slot0.getPassiveDescItem(slot0)
	if #slot0.passiveDescItemPool > 0 then
		slot1 = table.remove(slot0.passiveDescItemPool)

		gohelper.setActive(slot1.go, true)
		recthelper.setWidth(slot1.rectTrTxt, slot0.layoutMo.enemyInfoWidth - EnemyInfoEnum.SkillDescLeftMargin)
		table.insert(slot0.passiveDescItemList, slot1)

		return slot1
	end

	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0._gopassivedescitem)
	slot1.tr = slot1.go:GetComponent(gohelper.Type_Transform)
	slot1.txt = gohelper.findChildText(slot1.go, "#txt_desc")
	slot1.rectTrTxt = slot1.txt:GetComponent(gohelper.Type_RectTransform)

	recthelper.setWidth(slot1.rectTrTxt, slot0.layoutMo.enemyInfoWidth - EnemyInfoEnum.SkillDescLeftMargin)
	gohelper.setActive(slot1.go, true)
	SkillHelper.addHyperLinkClick(slot1.txt, slot0.onClickPassiveHyper, slot0)
	table.insert(slot0.passiveDescItemList, slot1)

	return slot1
end

slot0.Interval = 80

function slot0.onClickPassiveHyper(slot0, slot1, slot2)
	slot0.commonBuffTipAnchorPos = slot0.commonBuffTipAnchorPos or Vector2()

	slot0.commonBuffTipAnchorPos:Set(-(recthelper.getWidth(slot0.rectTrViewGo) / 2 - recthelper.getAnchorX(slot0.rectTrRight)) + uv0.Interval, 269.28)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(slot1), slot0.commonBuffTipAnchorPos, CommonBuffTipEnum.Pivot.Right)
end

function slot0.recycleAllPassiveDescItem(slot0)
	for slot4, slot5 in ipairs(slot0.passiveDescItemList) do
		gohelper.setActive(slot5.go, false)
		slot5.tr:SetParent(slot0.trPassiveDescItemPool)
		table.insert(slot0.passiveDescItemPool, slot5)
	end

	tabletool.clear(slot0.passiveDescItemList)
end

function slot0.refreshSkill(slot0)
	slot0:refreshSmallSkill()
	slot0:refreshSuperSkill()

	slot1 = not string.nilorempty(slot0.monsterConfig.activeSkill) or #slot0.monsterConfig.uniqueSkill > 0

	gohelper.setActive(slot0._gonoskill, not slot1)
	gohelper.setActive(slot0._goskill, slot1)
end

function slot0.refreshSmallSkill(slot0)
	slot0:recycleAllSmallSkill()

	if string.nilorempty(slot0.monsterConfig.activeSkill) then
		return
	end

	for slot5, slot6 in ipairs(GameUtil.splitString2(slot0.monsterConfig.activeSkill, true)) do
		table.remove(slot6, 1)

		slot8 = lua_skill.configDict[slot6[1]]
		slot9 = slot0:getSmallSkillItem()

		slot9.icon:LoadImage(ResUrl.getSkillIcon(slot8.icon))
		slot9.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. slot8.showTag))

		slot9.super = false
		slot9.skillIdList = slot6
	end
end

function slot0.refreshSuperSkill(slot0)
	slot0:recycleAllSuperSkill()

	for slot5, slot6 in ipairs(slot0.monsterConfig.uniqueSkill) do
		slot7 = slot0:getSuperSkillItem()
		slot8 = lua_skill.configDict[slot6]

		slot7.icon:LoadImage(ResUrl.getSkillIcon(slot8.icon))
		slot7.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. slot8.showTag))

		slot7.super = true

		table.insert(slot7.skillIdList, slot6)
	end
end

function slot0.recycleAllSmallSkill(slot0)
	for slot4, slot5 in ipairs(slot0.smallSkillItemList) do
		gohelper.setActive(slot5.go, false)
	end

	slot0.useSmallSkillItemCount = 0
end

function slot0.getSmallSkillItem(slot0)
	if slot0.useSmallSkillItemCount < #slot0.smallSkillItemList then
		slot0.useSmallSkillItemCount = slot0.useSmallSkillItemCount + 1
		slot1 = slot0.smallSkillItemList[slot0.useSmallSkillItemCount]

		gohelper.setActive(slot1.go, true)

		return slot1
	end

	slot0.useSmallSkillItemCount = slot0.useSmallSkillItemCount + 1
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0._goskillitem)
	slot1.icon = gohelper.findChildSingleImage(slot1.go, "imgIcon")
	slot1.tag = gohelper.findChildSingleImage(slot1.go, "tag/tagIcon")
	slot1.btn = gohelper.findChildButtonWithAudio(slot1.go, "bg", AudioEnum.UI.Play_UI_Activity_tips)

	slot1.btn:AddClickListener(slot0.onClickSkillItem, slot0, slot1)
	gohelper.setActive(slot1.go, true)
	table.insert(slot0.smallSkillItemList, slot1)

	return slot1
end

function slot0.recycleAllSuperSkill(slot0)
	for slot4, slot5 in ipairs(slot0.superSkillItemList) do
		gohelper.setActive(slot5.go, false)

		slot5.super = nil

		tabletool.clear(slot5.skillIdList)
	end

	slot0.useSuperSkillItemCount = 0
end

function slot0.getSuperSkillItem(slot0)
	if slot0.useSuperSkillItemCount < #slot0.superSkillItemList then
		slot0.useSuperSkillItemCount = slot0.useSuperSkillItemCount + 1
		slot1 = slot0.superSkillItemList[slot0.useSuperSkillItemCount]

		gohelper.setActive(slot1.go, true)

		return slot1
	end

	slot0.useSuperSkillItemCount = slot0.useSuperSkillItemCount + 1
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0._gosuperitem)
	slot1.icon = gohelper.findChildSingleImage(slot1.go, "imgIcon")
	slot1.tag = gohelper.findChildSingleImage(slot1.go, "tag/tagIcon")
	slot1.btn = gohelper.findChildButtonWithAudio(slot1.go, "bg", AudioEnum.UI.Play_UI_Activity_tips)

	slot1.btn:AddClickListener(slot0.onClickSkillItem, slot0, slot1)

	slot1.skillIdList = {}

	gohelper.setActive(slot1.go, true)
	table.insert(slot0.superSkillItemList, slot1)

	return slot1
end

function slot0.recycleBuffTipItem(slot0)
	for slot4, slot5 in ipairs(slot0.buffTipItemList) do
		gohelper.setActive(slot5.go, false)
	end

	slot0.useBuffTipCount = 0
end

function slot0.getBuffTipItem(slot0)
	if slot0.useBuffTipCount < #slot0.buffTipItemList then
		slot0.useBuffTipCount = slot0.useBuffTipCount + 1
		slot1 = slot0.buffTipItemList[slot0.useBuffTipCount]

		gohelper.setActive(slot1.go, true)
		gohelper.setActive(slot1.goline, true)

		return slot1
	end

	slot0.useBuffTipCount = slot0.useBuffTipCount + 1
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0._gobufftipitem)
	slot1.bufficon = gohelper.findChildImage(slot1.go, "title/simage_icon")
	slot1.goline = gohelper.findChild(slot1.go, "txt_desc/image_line")
	slot1.name = gohelper.findChildText(slot1.go, "title/txt_name")
	slot1.desc = gohelper.findChildText(slot1.go, "txt_desc")

	SkillHelper.addHyperLinkClick(slot1.desc, slot0.onClickHyperLink, slot0)
	gohelper.setActive(slot1.go, true)
	gohelper.setActive(slot1.goline, true)
	table.insert(slot0.buffTipItemList, slot1)

	return slot1
end

function slot0.onClickHyperLink(slot0, slot1, slot2)
	CommonBuffTipController:openCommonTipViewWithCustomPosCallback(tonumber(slot1), slot0.onSetScrollCallback, slot0)
end

function slot0.onSetScrollCallback(slot0, slot1, slot2)
	slot2.pivot = CommonBuffTipEnum.Pivot.Left

	recthelper.setAnchor(slot2, recthelper.getAnchorX(slot0.buffTipRectTr) - recthelper.getWidth(slot2) - 10, recthelper.getAnchorY(slot0.buffTipRectTr))
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0.bossSpecialClick:RemoveClickListener()

	for slot4, slot5 in ipairs(slot0.smallSkillItemList) do
		slot5.btn:RemoveClickListener()
		slot5.icon:UnLoadImage()
		slot5.tag:UnLoadImage()
	end

	slot0.smallSkillItemList = nil

	for slot4, slot5 in ipairs(slot0.superSkillItemList) do
		slot5.btn:RemoveClickListener()
		slot5.icon:UnLoadImage()
		slot5.tag:UnLoadImage()
	end

	slot0.superSkillItemList = nil

	for slot4, slot5 in ipairs(slot0.stageItemList) do
		slot5.click:RemoveClickListener()
	end

	slot0.resistanceComp:destroy()

	slot0.resistanceComp = nil
	slot0.stageItemList = nil
end

return slot0
