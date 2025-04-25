module("modules.logic.weekwalk.view.WeekWalkOriginalEnemyInfoView", package.seeall)

slot0 = class("WeekWalkOriginalEnemyInfoView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_rightbg")
	slot0._goenemygroupitem = gohelper.findChild(slot0.viewGO, "#scroll_enemy/viewport/content/#go_enemygroupitem")
	slot0._simageicon = gohelper.findChildImage(slot0.viewGO, "enemyinfo/#simage_icon")
	slot0._imagecareer = gohelper.findChildImage(slot0.viewGO, "enemyinfo/#image_career")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "enemyinfo/#txt_level")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "enemyinfo/#txt_name")
	slot0._imagedmgtype = gohelper.findChildImage(slot0.viewGO, "enemyinfo/#txt_name/#image_dmgtype")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "enemyinfo/#txt_nameen")
	slot0._txthp = gohelper.findChildText(slot0.viewGO, "enemyinfo/#txt_hp")
	slot0._godescscrollview = gohelper.findChild(slot0.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_descscrollview")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_descscrollview/#txt_desc")
	slot0._goattribute = gohelper.findChild(slot0.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_attribute")
	slot0._gopassiveskill = gohelper.findChild(slot0.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_passiveskill")
	slot0._gopassiveskillitem = gohelper.findChild(slot0.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_passiveskill/passiveSkills/item")
	slot0._btnpassiveskill = gohelper.findChildButtonWithAudio(slot0.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_passiveskill/passiveSkills/btn_passiveclick")
	slot0._btnshowattribute = gohelper.findChildButton(slot0.viewGO, "enemyinfo/#btn_showAttribute")
	slot0._gonormalicon = gohelper.findChild(slot0.viewGO, "enemyinfo/#btn_showAttribute/#go_normalIcon")
	slot0._goselecticon = gohelper.findChild(slot0.viewGO, "enemyinfo/#btn_showAttribute/#go_selectIcon")
	slot0._goenemypassiveitem = gohelper.findChild(slot0.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_monster_desccontainer/#go_enemypassiveitem")
	slot0._gonoskill = gohelper.findChild(slot0.viewGO, "enemyinfo/noskill")
	slot0._goskill = gohelper.findChild(slot0.viewGO, "enemyinfo/skill")
	slot0._goskillitem = gohelper.findChild(slot0.viewGO, "enemyinfo/skill/card/scrollview/viewport/content/skills/#go_skillitem")
	slot0._gosuperitem = gohelper.findChild(slot0.viewGO, "enemyinfo/skill/card/scrollview/viewport/content/supers/#go_superitem")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._scrollskill = gohelper.findChildScrollRect(slot0.viewGO, "enemyinfo/skill/card/scrollview")
	slot0._gocareercontent = gohelper.findChild(slot0.viewGO, "careerContent/#go_careercontent")
	slot0._gobuffpassiveview = gohelper.findChild(slot0.viewGO, "enemyinfo/#go_buffpassiveview")
	slot0._btnclosepassiveview = gohelper.findChildButton(slot0.viewGO, "enemyinfo/#go_buffpassiveview/#btn_closeview")
	slot0._gobuffpassiveitem = gohelper.findChild(slot0.viewGO, "enemyinfo/#go_buffpassiveview/#scroll_buff/viewport/content/#go_buffitem")
	slot0._specialskillIconGOs = slot0:getUserDataTb_()
	slot0._enemybuffpassiveGOs = slot0:getUserDataTb_()
	slot0._passiveSkillImgs = slot0:getUserDataTb_()
	slot0._passiveiconImgs = slot0:getUserDataTb_()
	slot0.bossSkillInfos = {}
	slot0.isopenpassiveview = false

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnshowattribute:AddClickListener(slot0._setInfoShowState, slot0)
	slot0._btnclosepassiveview:AddClickListener(slot0._onClosePassiveView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnshowattribute:RemoveClickListener()
	slot0._btnpassiveskill:RemoveClickListener()
	slot0._btnclosepassiveview:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	gohelper.addUIClickAudio(slot0._btnshowattribute.gameObject, AudioEnum.UI.play_ui_screenplay_photo_click)

	slot0._imageSelectEnemy = gohelper.findChildImage(slot0.viewGO, "enemyinfo/#simage_icon")
	slot0._contentHorizontal = gohelper.findChild(slot0.viewGO, "enemyinfo/skill/card/scrollview/viewport/content"):GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	slot0._skillHorizontal = gohelper.findChild(slot0.viewGO, "enemyinfo/skill/card/scrollview/viewport/content/skills"):GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	slot0._gosupers = gohelper.findChild(slot0.viewGO, "enemyinfo/skill/card/scrollview/viewport/content/supers")
	slot4 = "bg_battledetail"

	slot0._simagerightbg:LoadImage(ResUrl.getDungeonIcon(slot4))

	slot0._enemyGroupItemGOs = {}
	slot0._passiveSkillGOs = {}
	slot0._skillGOs = {}
	slot0._superItemList = {}
	slot0._isShowAttributeInfo = false

	gohelper.setActive(slot0._goenemygroupitem, false)
	gohelper.setActive(slot0._goenemypassiveitem, false)
	gohelper.setActive(slot0._goskillitem, false)
	gohelper.setActive(slot0._gosuperitem, false)
	gohelper.setActive(slot0._gonormalicon, not slot0._isShowAttributeInfo)
	gohelper.setActive(slot0._godescscrollview, not slot0._isShowAttributeInfo)
	gohelper.setActive(slot0._goselecticon, slot0._isShowAttributeInfo)
	gohelper.setActive(slot0._goattribute, slot0._isShowAttributeInfo)

	for slot4 = 1, 6 do
		UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot0._gocareercontent, "career" .. slot4), "lssx_" .. slot4)
	end

	slot0.scrollDescContainer = gohelper.findChildScrollRect(slot0.viewGO, "enemyinfo/#go_desccontainer")
end

function slot0._onClosePassiveView(slot0)
	gohelper.setActive(slot0._gobuffpassiveview, false)

	slot0.isopenpassiveview = false
end

function slot0._refreshUI(slot0)
	if not slot0._battleId then
		logError("地方信息界面缺少战斗Id")

		return
	end

	slot2 = {}

	if not lua_battle.configDict[slot0._battleId].monsterGroupIds or slot1.monsterGroupIds == "" then
		return
	end

	slot0._enemyItemIndex = 1

	for slot6 = 1, #string.split(slot1.monsterGroupIds, "#") do
		if not slot0._enemyGroupItemGOs[slot6] then
			slot8 = gohelper.cloneInPlace(slot0._goenemygroupitem, "item" .. slot6)
			slot7 = slot0:getUserDataTb_()
			slot7.go = slot8
			slot7.txttitlenum = gohelper.findChildText(slot8, "#txt_titlenum")
			slot7.goenemyitem = gohelper.findChild(slot8, "content/enemyitem")
			slot7.enemyItemGOs = {}

			gohelper.setActive(slot7.goenemyitem, false)
			table.insert(slot0._enemyGroupItemGOs, slot7)

			slot7.txttitlenum.text = slot6
		end

		slot0:_refreshEnemyItem(slot6, slot2, slot7)
		gohelper.setActive(slot7.go, true)
	end

	for slot6 = #slot2 + 1, #slot0._enemyGroupItemGOs do
		gohelper.setActive(slot0._enemyGroupItemGOs[slot6].go, false)
	end
end

function slot0._refreshEnemyItem(slot0, slot1, slot2, slot3)
	slot4 = false
	slot0.selectMonsterIndex = nil
	slot5 = lua_monster_group.configDict[tonumber(slot2[slot1])]
	slot6 = {}
	slot8 = string.nilorempty(slot5.spMonster)

	if string.nilorempty(slot5.monster) and slot8 then
		return
	end

	slot6 = slot7 and {} or string.split(slot5.monster, "#")

	for slot13, slot14 in ipairs(slot8 and {} or string.split(slot5.spMonster, "#")) do
		table.insert(slot6, slot14)
	end

	for slot13 = 1, #slot6 do
		slot14 = tonumber(slot6[slot13])

		if not slot3.enemyItemGOs[slot13] then
			table.insert(slot3.enemyItemGOs, slot0:_initEnemyItem(gohelper.cloneInPlace(slot3.goenemyitem, "item" .. slot13), slot14, slot1))
		end

		slot15.monsterId = slot14
		slot16 = lua_monster.configDict[slot14]

		slot0:_setEnemyItem(slot15, slot16, FightConfig.instance:getSkinCO(slot16.skinId), slot1, slot13)
		gohelper.setActive(slot15.go, true)
		gohelper.setActive(slot15.bosstag, false)

		if not slot4 and FightHelper.isBossId(slot5.bossId, slot14) then
			gohelper.setActive(slot15.bosstag, true)

			slot4 = true
		end

		slot0._enemyItemIndex = slot0._enemyItemIndex + 1
	end

	for slot13 = #slot6 + 1, #slot3.enemyItemGOs do
		gohelper.setActive(slot3.enemyItemGOs[slot13].go, false)
	end
end

function slot0._initEnemyItem(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot4.go = slot1
	slot4.monsterId = slot2
	slot4.iconframe = gohelper.findChildImage(slot1, "iconframe")
	slot4.icon = gohelper.findChildImage(slot1, "icon")
	slot4.career = gohelper.findChildImage(slot1, "career")
	slot4.selectframe = gohelper.findChild(slot1, "selectframe")
	slot4.bosstag = gohelper.findChild(slot1, "bosstag")
	slot4.btn = gohelper.findChildButtonWithAudio(slot1, "btn_click", AudioEnum.UI.Play_UI_Tags)

	slot4.btn:AddClickListener(function (slot0)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickEnemyItem, {
			index = slot0.index,
			monsterId = slot0.monsterId,
			groupIndex = uv0
		})

		uv1.scrollDescContainer.verticalNormalizedPosition = 1
	end, slot4)

	function slot4.onClickEnemyItem(slot0, slot1, slot2)
		slot3 = slot0._isSelected
		slot0._isSelected = slot0.index == slot1.index

		gohelper.setActive(slot0.selectframe, slot0._isSelected)
	end

	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnClickEnemyItem, slot4.onClickEnemyItem, slot4)

	return slot4
end

function slot0._setEnemyItem(slot0, slot1, slot2, slot3, slot4, slot5)
	gohelper.setActive(slot1.selectframe, false)

	slot1.index = slot0._enemyItemIndex
	slot1.groupIndex = slot4

	gohelper.getSingleImage(slot1.icon.gameObject):LoadImage(ResUrl.monsterHeadIcon(slot3.headIcon))
	UISpriteSetMgr.instance:setEnemyInfoSprite(slot1.career, "sxy_" .. tostring(slot2.career))

	if slot2.heartVariantId ~= 0 then
		IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(slot2.heartVariantId), slot1.icon)
	end

	if slot0._adventure then
		ZProj.UGUIHelper.SetGrayscale(slot1.iconframe.gameObject, 1 <= 0)
		ZProj.UGUIHelper.SetGrayscale(slot1.icon.gameObject, slot6 <= 0)
		SLFramework.UGUI.GuiHelper.SetColor(slot1.icon, slot6 <= 0 and "#999999" or "#FFFFFF")
	end

	if slot0._enemyItemIndex == 1 then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickEnemyItem, {
			index = 1,
			monsterId = slot1.monsterId,
			groupIndex = slot1.groupIndex
		}, true)
	end
end

function slot0._refreshInfo(slot0, slot1)
	if slot1.index ~= slot0.selectMonsterIndex then
		slot0.selectMonsterIndex = slot1.index
		slot3 = slot1.groupIndex
		slot4 = lua_monster.configDict[slot1.monsterId]

		gohelper.getSingleImage(slot0._simageicon.gameObject):LoadImage(ResUrl.monsterHeadIcon(FightConfig.instance:getSkinCO(slot4.skinId).headIcon))

		if slot4.heartVariantId ~= 0 then
			IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(slot4.heartVariantId), slot0._imageSelectEnemy)
		end

		UISpriteSetMgr.instance:setEnemyInfoSprite(slot0._imagecareer, "sxy_" .. tostring(slot4.career))

		slot0._txtlevel.text = HeroConfig.instance:getCommonLevelDisplay(slot4.level)
		slot0._txtname.text = FightConfig.instance:getNewMonsterConfig(slot4) and slot4.highPriorityName or slot4.name
		slot0._txtnameen.text = slot6 and slot4.highPriorityNameEng or slot4.nameEng

		UISpriteSetMgr.instance:setCommonSprite(slot0._imagedmgtype, "dmgtype" .. tostring(slot4.dmgType))

		slot0._txthp.text = string.format(luaLang("maxhp"), CharacterDataConfig.instance:getMonsterHp(slot2))
		slot0._txtdesc.text = slot6 and slot4.highPriorityDes or slot4.des
		slot0.bossSkillInfos = {}

		if FightHelper.isBossId(slot0:_getBossId(slot3), slot4.id) then
			slot0:_refreshSpeicalSkillIcon(slot4)
		else
			gohelper.setActive(slot0._gopassiveskill, false)
		end

		slot0:_refreshPassiveSkill(slot4, slot3)
		slot0:_refreshSkill(slot4)
		slot0:_refreshSuper(slot4)
		slot0:_refreshAttribute(slot4)

		slot0._scrollskill.horizontalNormalizedPosition = 0
		slot9 = string.nilorempty(slot4.activeSkill) and #slot4.uniqueSkill < 1

		gohelper.setActive(slot0._gonoskill, slot9)
		gohelper.setActive(slot0._goskill, not slot9)
	end
end

function slot0._getBossId(slot0, slot1)
	slot3 = FightModel.instance:getSelectMonsterGroupId(slot1, slot0._battleId) and lua_monster_group.configDict[slot2]

	return slot3 and not string.nilorempty(slot3.bossId) and slot3.bossId or nil
end

function slot0._refreshSpeicalSkillIcon(slot0, slot1)
	slot6 = true

	for slot6 = 1, #FightConfig.instance:_filterSpeicalSkillIds(FightConfig.instance:getPassiveSkillsAfterUIFilter(slot1.id), slot6) do
		if lua_skill_specialbuff.configDict[slot2[slot6]] then
			if not slot0._specialskillIconGOs[slot6] then
				slot9 = slot0:getUserDataTb_()
				slot9.go = gohelper.cloneInPlace(slot0._gopassiveskillitem, "item" .. slot6)
				slot9._gotag = gohelper.findChild(slot9.go, "tag")
				slot9._txttag = gohelper.findChildText(slot9.go, "tag/#txt_tag")

				table.insert(slot0._specialskillIconGOs, slot9)
				table.insert(slot0._passiveiconImgs, gohelper.findChildImage(slot9.go, "icon"))
				gohelper.setActive(slot9.go, true)
			else
				gohelper.setActive(slot9.go, true)
			end

			if not string.nilorempty(slot8.lv) then
				gohelper.setActive(slot9._gotag, true)

				slot9._txttag.text = slot8.lv
			else
				gohelper.setActive(slot9._gotag, false)
			end

			if slot0.bossSkillInfos[slot6] == nil then
				slot0.bossSkillInfos[slot6] = {
					skillId = slot7,
					icon = slot8.icon
				}
			end

			if string.nilorempty(slot8.icon) then
				logError("boss抗性表的icon字段没有配置,技能ID:" .. slot8.id)
			end

			UISpriteSetMgr.instance:setFightPassiveSprite(slot0._passiveiconImgs[slot6], slot8.icon)
		end
	end

	if #slot2 < #slot0._specialskillIconGOs then
		for slot6 = #slot2 + 1, #slot0._specialskillIconGOs do
			gohelper.setActive(slot0._specialskillIconGOs[slot6].go, false)
		end
	end

	if #slot0._specialskillIconGOs > 0 then
		gohelper.setActive(slot0._gopassiveskill, true)
	end

	gohelper.setAsLastSibling(slot0._btnpassiveskill.gameObject)
	slot0._btnpassiveskill:AddClickListener(slot0._onBuffPassiveSkillClick, slot0)
end

function slot0._onBuffPassiveSkillClick(slot0)
	if slot0.bossSkillInfos then
		slot1 = nil

		for slot5, slot6 in pairs(slot0.bossSkillInfos) do
			slot1 = slot6.skillId

			if not slot0._enemybuffpassiveGOs[slot5] then
				slot7 = gohelper.cloneInPlace(slot0._gobuffpassiveitem, "item" .. slot5)

				table.insert(slot0._enemybuffpassiveGOs, slot7)
				table.insert(slot0._passiveSkillImgs, gohelper.findChildImage(slot7, "title/simage_icon"))
				gohelper.setActive(slot7, true)
			else
				gohelper.setActive(slot7, true)
			end

			gohelper.setActive(gohelper.findChild(slot7, "txt_desc/image_line"), true)
			slot0:_setPassiveSkillTip(slot7, slot6)
			UISpriteSetMgr.instance:setFightPassiveSprite(slot0._passiveSkillImgs[slot5], slot6.icon)
		end

		if #slot0.bossSkillInfos < #slot0._enemybuffpassiveGOs then
			for slot5 = #slot0.bossSkillInfos + 1, #slot0._enemybuffpassiveGOs do
				gohelper.setActive(slot0._enemybuffpassiveGOs[slot5], false)
			end
		end

		gohelper.setActive(gohelper.findChild(slot0._enemybuffpassiveGOs[#slot0.bossSkillInfos], "txt_desc/image_line"), false)
		gohelper.setActive(slot0._gobuffpassiveview, true)

		slot0.isopenpassiveview = false
	end
end

function slot0._setPassiveSkillTip(slot0, slot1, slot2)
	slot5 = lua_skill.configDict[slot2.skillId]
	gohelper.findChildText(slot1, "title/txt_name").text = slot5.name
	gohelper.findChildText(slot1, "txt_desc").text = HeroSkillModel.instance:skillDesToSpot(slot5.desc, "#CC492F", "#485E92")
end

function slot0._refreshPassiveSkill(slot0, slot1, slot2)
	if FightHelper.isBossId(slot0:_getBossId(slot2), slot1.id) then
		slot3 = FightConfig.instance:_filterSpeicalSkillIds(FightConfig.instance:getPassiveSkillsAfterUIFilter(slot1.id), false)
	end

	if slot3 and #slot3 > 0 then
		slot4 = {}

		for slot8 = 1, #slot3 do
			if not slot0._passiveSkillGOs[slot8] then
				slot10 = gohelper.cloneInPlace(slot0._goenemypassiveitem, "item" .. slot8)
				slot9 = slot0:getUserDataTb_()
				slot9.go = slot10
				slot9.name = gohelper.findChildText(slot10, "bg/bg/name")
				slot9.desc = gohelper.findChildText(slot10, "desc")
				slot9.descicon = gohelper.findChild(slot10, "desc/icon")
				slot9.detailPassiveStateTables = slot0:getUserDataTb_()

				table.insert(slot0._passiveSkillGOs, slot9)
			end

			if not lua_skill.configDict[tonumber(slot3[slot8])] then
				logError("找不到技能配置, id: " .. tostring(slot10))
			end

			slot9.name.text = slot11.name
			slot14 = 0

			for slot18 = 1, #HeroSkillModel.instance:getEffectTagIDsFromDescRecursion(slot11.desc) do
				if HeroSkillModel.instance:canShowSkillTag(SkillConfig.instance:getSkillEffectDescCo(slot13[slot18]).name) and not slot4[slot19] then
					slot4[slot19] = true
					slot21 = SkillConfig.instance:getSkillEffectDescCo(slot13[slot18]).desc

					if not slot9.detailPassiveStateTables[slot14 + 1] then
						slot23 = gohelper.cloneInPlace(slot9.desc.gameObject, "state")
						slot22 = slot0:getUserDataTb_()
						slot22.go = slot23
						slot22.desc = slot23:GetComponent(gohelper.Type_TextMesh)

						gohelper.setActive(slot22.go, false)

						slot22.desc.text = ""
						slot9.detailPassiveStateTables[slot14] = slot22
					end

					gohelper.setActive(slot22.go, true)

					slot22.desc.text = HeroSkillModel.instance:skillDesToSpot(string.format("[%s]:%s", SkillConfig.instance:processSkillDesKeyWords(slot19), SkillConfig.instance:processSkillDesKeyWords(slot21)))
				end
			end

			for slot18 = slot14 + 1, #slot9.detailPassiveStateTables do
				if slot9.detailPassiveStateTables[slot18] then
					gohelper.setActive(slot9.detailPassiveStateTables[slot18].go, false)
				end
			end

			slot9.desc.text = HeroSkillModel.instance:skillDesToSpot(slot12)

			gohelper.setActive(slot9.descicon, not string.nilorempty(slot9.desc.text))
			gohelper.setActive(slot9.go, true)
		end
	end

	for slot7 = #slot3 + 1, #slot0._passiveSkillGOs do
		gohelper.setActive(slot0._passiveSkillGOs[slot7].go, false)
	end
end

function slot0._refreshSkill(slot0, slot1)
	slot2 = {}

	if not string.nilorempty(slot1.activeSkill) then
		for slot6 = 1, #string.split(slot1.activeSkill, "|") do
			if not slot0._skillGOs[slot6] then
				slot8 = gohelper.cloneInPlace(slot0._goskillitem, "item" .. slot6)
				slot7 = slot0:getUserDataTb_()
				slot7.go = slot8
				slot7.icon = gohelper.findChildSingleImage(slot8, "imgIcon")
				slot7.btn = gohelper.findChildButtonWithAudio(slot8, "bg", AudioEnum.UI.Play_UI_Activity_tips)

				slot7.btn:AddClickListener(function (slot0)
					ViewMgr.instance:openView(ViewName.SkillTipView3, slot0.info)
				end, slot7)

				slot7.tag = gohelper.findChildSingleImage(slot8, "tag/tagIcon")

				table.insert(slot0._skillGOs, slot7)
			end

			slot8 = string.splitToNumber(slot2[slot6], "#")
			slot10 = lua_skill.configDict[slot8[2]]

			slot7.icon:LoadImage(ResUrl.getSkillIcon(slot10.icon))
			slot7.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. slot10.showTag))
			table.remove(slot8, 1)

			slot7.info = {
				super = false,
				skillIdList = slot8
			}

			gohelper.setActive(slot7.go, true)
		end
	end

	for slot6 = #slot2 + 1, #slot0._skillGOs do
		gohelper.setActive(slot0._skillGOs[slot6].go, false)
	end
end

function slot0._refreshSuper(slot0, slot1)
	slot3, slot4, slot5, slot6 = nil

	for slot10 = 1, #slot1.uniqueSkill do
		if not slot0._superItemList[slot10] then
			table.insert(slot0._superItemList, slot0:createSuperItem())
		end

		slot4 = slot2[slot10]
		slot5 = lua_skill.configDict[slot4]

		slot3.icon:LoadImage(ResUrl.getSkillIcon(slot5.icon))
		slot3.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. slot5.showTag))

		slot3.info = {
			super = true,
			skillIdList = {
				slot4
			}
		}

		gohelper.setActive(slot3.go, true)
	end

	gohelper.setActive(slot0._gosupers, #slot2 > 0)

	for slot10 = #slot2 + 1, #slot0._superItemList do
		gohelper.setActive(slot0._superItemList[slot10].go, false)
	end
end

function slot0.createSuperItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0._gosuperitem)
	slot1.icon = gohelper.findChildSingleImage(slot1.go, "imgIcon")
	slot1.tag = gohelper.findChildSingleImage(slot1.go, "tag/tagIcon")
	slot1.btn = gohelper.findChildButtonWithAudio(slot1.go, "bg", AudioEnum.UI.Play_UI_Activity_tips)

	slot1.btn:AddClickListener(function (slot0)
		ViewMgr.instance:openView(ViewName.SkillTipView3, slot0.info)
	end, slot1)

	return slot1
end

function slot0._refreshAttribute(slot0, slot1)
	slot2 = lua_monster_skill_template.configDict[slot1.skillTemplate]
	slot3 = CharacterDataConfig.instance:getMonsterAttributeScoreList(slot1.id)
	slot9 = 4

	table.insert(slot3, 2, table.remove(slot3, slot9))

	slot5 = {}

	for slot9, slot10 in ipairs(slot3) do
		table.insert(slot5, {
			id = HeroConfig.instance:getIDByAttrType(({
				"atk",
				"technic",
				"def",
				"mdef"
			})[slot9]),
			value = slot10
		})
	end

	gohelper.CreateObjList(slot0, slot0._onMonsterAttrItemShow, slot5, slot0._goattribute)
end

function slot0._onMonsterAttrItemShow(slot0, slot1, slot2, slot3)
	slot4 = slot1.transform
	slot8 = HeroConfig.instance:getHeroAttributeCO(slot2.id)
	slot4:Find("name"):GetComponent(gohelper.Type_TextMesh).text = slot8.name

	UISpriteSetMgr.instance:setCommonSprite(slot4:Find("icon"):GetComponent(gohelper.Type_Image), "icon_att_" .. slot8.id)
	UISpriteSetMgr.instance:setCommonSprite(slot4:Find("rate"):GetComponent(gohelper.Type_Image), "sx_" .. slot2.value, true)
end

function slot0._setInfoShowState(slot0)
	slot0._isShowAttributeInfo = not slot0._isShowAttributeInfo

	gohelper.setActive(slot0._gonormalicon, not slot0._isShowAttributeInfo)
	gohelper.setActive(slot0._godescscrollview, not slot0._isShowAttributeInfo)
	gohelper.setActive(slot0._goselecticon, slot0._isShowAttributeInfo)
	gohelper.setActive(slot0._goattribute, slot0._isShowAttributeInfo)

	slot0.scrollDescContainer.verticalNormalizedPosition = 1
end

function slot0.onUpdateParam(slot0)
	slot0._battleId = slot0.viewParam.battleId
	slot0._battleInfo = slot0.viewParam.battleInfo

	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickEnemyItem, slot0._refreshInfo, slot0)

	slot0._battleId = slot0.viewParam.battleId
	slot0._battleInfo = slot0.viewParam.battleInfo
	slot0._adventure = slot0.viewParam.adventure

	slot0:_refreshUI()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickEnemyItem, slot0._refreshInfo, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagerightbg:UnLoadImage()

	slot0._simagerightbg = nil

	if slot0._enemyGroupItemGOs then
		for slot4 = 1, #slot0._enemyGroupItemGOs do
			if slot0._enemyGroupItemGOs[slot4].enemyItemGOs then
				for slot8 = 1, #slot0._enemyGroupItemGOs[slot4].enemyItemGOs do
					slot9 = slot0._enemyGroupItemGOs[slot4].enemyItemGOs[slot8]

					slot9.btn:RemoveClickListener()
					HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnClickEnemyItem, slot9.onClickEnemyItem, slot9)
				end
			end
		end
	end

	if slot0._skillGOs then
		for slot4 = 1, #slot0._skillGOs do
			slot5 = slot0._skillGOs[slot4]

			slot5.tag:UnLoadImage()
			slot5.icon:UnLoadImage()
			slot5.btn:RemoveClickListener()
		end
	end

	for slot4, slot5 in ipairs(slot0._superItemList) do
		slot5.btn:RemoveClickListener()
	end

	slot0:__onDispose()
end

return slot0
