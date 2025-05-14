module("modules.logic.weekwalk.view.WeekWalkOriginalEnemyInfoView", package.seeall)

local var_0_0 = class("WeekWalkOriginalEnemyInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_rightbg")
	arg_1_0._goenemygroupitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_enemy/viewport/content/#go_enemygroupitem")
	arg_1_0._simageicon = gohelper.findChildImage(arg_1_0.viewGO, "enemyinfo/#simage_icon")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_0.viewGO, "enemyinfo/#image_career")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "enemyinfo/#txt_level")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "enemyinfo/#txt_name")
	arg_1_0._imagedmgtype = gohelper.findChildImage(arg_1_0.viewGO, "enemyinfo/#txt_name/#image_dmgtype")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "enemyinfo/#txt_nameen")
	arg_1_0._txthp = gohelper.findChildText(arg_1_0.viewGO, "enemyinfo/#txt_hp")
	arg_1_0._godescscrollview = gohelper.findChild(arg_1_0.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_descscrollview")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_descscrollview/#txt_desc")
	arg_1_0._goattribute = gohelper.findChild(arg_1_0.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_attribute")
	arg_1_0._gopassiveskill = gohelper.findChild(arg_1_0.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_passiveskill")
	arg_1_0._gopassiveskillitem = gohelper.findChild(arg_1_0.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_passiveskill/passiveSkills/item")
	arg_1_0._btnpassiveskill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_passiveskill/passiveSkills/btn_passiveclick")
	arg_1_0._btnshowattribute = gohelper.findChildButton(arg_1_0.viewGO, "enemyinfo/#btn_showAttribute")
	arg_1_0._gonormalicon = gohelper.findChild(arg_1_0.viewGO, "enemyinfo/#btn_showAttribute/#go_normalIcon")
	arg_1_0._goselecticon = gohelper.findChild(arg_1_0.viewGO, "enemyinfo/#btn_showAttribute/#go_selectIcon")
	arg_1_0._goenemypassiveitem = gohelper.findChild(arg_1_0.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_monster_desccontainer/#go_enemypassiveitem")
	arg_1_0._gonoskill = gohelper.findChild(arg_1_0.viewGO, "enemyinfo/noskill")
	arg_1_0._goskill = gohelper.findChild(arg_1_0.viewGO, "enemyinfo/skill")
	arg_1_0._goskillitem = gohelper.findChild(arg_1_0.viewGO, "enemyinfo/skill/card/scrollview/viewport/content/skills/#go_skillitem")
	arg_1_0._gosuperitem = gohelper.findChild(arg_1_0.viewGO, "enemyinfo/skill/card/scrollview/viewport/content/supers/#go_superitem")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._scrollskill = gohelper.findChildScrollRect(arg_1_0.viewGO, "enemyinfo/skill/card/scrollview")
	arg_1_0._gocareercontent = gohelper.findChild(arg_1_0.viewGO, "careerContent/#go_careercontent")
	arg_1_0._gobuffpassiveview = gohelper.findChild(arg_1_0.viewGO, "enemyinfo/#go_buffpassiveview")
	arg_1_0._btnclosepassiveview = gohelper.findChildButton(arg_1_0.viewGO, "enemyinfo/#go_buffpassiveview/#btn_closeview")
	arg_1_0._gobuffpassiveitem = gohelper.findChild(arg_1_0.viewGO, "enemyinfo/#go_buffpassiveview/#scroll_buff/viewport/content/#go_buffitem")
	arg_1_0._specialskillIconGOs = arg_1_0:getUserDataTb_()
	arg_1_0._enemybuffpassiveGOs = arg_1_0:getUserDataTb_()
	arg_1_0._passiveSkillImgs = arg_1_0:getUserDataTb_()
	arg_1_0._passiveiconImgs = arg_1_0:getUserDataTb_()
	arg_1_0.bossSkillInfos = {}
	arg_1_0.isopenpassiveview = false

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnshowattribute:AddClickListener(arg_2_0._setInfoShowState, arg_2_0)
	arg_2_0._btnclosepassiveview:AddClickListener(arg_2_0._onClosePassiveView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnshowattribute:RemoveClickListener()
	arg_3_0._btnpassiveskill:RemoveClickListener()
	arg_3_0._btnclosepassiveview:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.addUIClickAudio(arg_4_0._btnshowattribute.gameObject, AudioEnum.UI.play_ui_screenplay_photo_click)

	arg_4_0._imageSelectEnemy = gohelper.findChildImage(arg_4_0.viewGO, "enemyinfo/#simage_icon")
	arg_4_0._contentHorizontal = gohelper.findChild(arg_4_0.viewGO, "enemyinfo/skill/card/scrollview/viewport/content"):GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	arg_4_0._skillHorizontal = gohelper.findChild(arg_4_0.viewGO, "enemyinfo/skill/card/scrollview/viewport/content/skills"):GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	arg_4_0._gosupers = gohelper.findChild(arg_4_0.viewGO, "enemyinfo/skill/card/scrollview/viewport/content/supers")

	arg_4_0._simagerightbg:LoadImage(ResUrl.getDungeonIcon("bg_battledetail"))

	arg_4_0._enemyGroupItemGOs = {}
	arg_4_0._passiveSkillGOs = {}
	arg_4_0._skillGOs = {}
	arg_4_0._superItemList = {}
	arg_4_0._isShowAttributeInfo = false

	gohelper.setActive(arg_4_0._goenemygroupitem, false)
	gohelper.setActive(arg_4_0._goenemypassiveitem, false)
	gohelper.setActive(arg_4_0._goskillitem, false)
	gohelper.setActive(arg_4_0._gosuperitem, false)
	gohelper.setActive(arg_4_0._gonormalicon, not arg_4_0._isShowAttributeInfo)
	gohelper.setActive(arg_4_0._godescscrollview, not arg_4_0._isShowAttributeInfo)
	gohelper.setActive(arg_4_0._goselecticon, arg_4_0._isShowAttributeInfo)
	gohelper.setActive(arg_4_0._goattribute, arg_4_0._isShowAttributeInfo)

	for iter_4_0 = 1, 6 do
		local var_4_0 = gohelper.findChildImage(arg_4_0._gocareercontent, "career" .. iter_4_0)

		UISpriteSetMgr.instance:setCommonSprite(var_4_0, "lssx_" .. iter_4_0)
	end

	arg_4_0.scrollDescContainer = gohelper.findChildScrollRect(arg_4_0.viewGO, "enemyinfo/#go_desccontainer")
end

function var_0_0._onClosePassiveView(arg_5_0)
	gohelper.setActive(arg_5_0._gobuffpassiveview, false)

	arg_5_0.isopenpassiveview = false
end

function var_0_0._refreshUI(arg_6_0)
	if not arg_6_0._battleId then
		logError("地方信息界面缺少战斗Id")

		return
	end

	local var_6_0 = lua_battle.configDict[arg_6_0._battleId]
	local var_6_1 = {}

	if not var_6_0.monsterGroupIds or var_6_0.monsterGroupIds == "" then
		return
	end

	local var_6_2 = string.split(var_6_0.monsterGroupIds, "#")

	arg_6_0._enemyItemIndex = 1

	for iter_6_0 = 1, #var_6_2 do
		local var_6_3 = arg_6_0._enemyGroupItemGOs[iter_6_0]

		if not var_6_3 then
			local var_6_4 = gohelper.cloneInPlace(arg_6_0._goenemygroupitem, "item" .. iter_6_0)

			var_6_3 = arg_6_0:getUserDataTb_()
			var_6_3.go = var_6_4
			var_6_3.txttitlenum = gohelper.findChildText(var_6_4, "#txt_titlenum")
			var_6_3.goenemyitem = gohelper.findChild(var_6_4, "content/enemyitem")
			var_6_3.enemyItemGOs = {}

			gohelper.setActive(var_6_3.goenemyitem, false)
			table.insert(arg_6_0._enemyGroupItemGOs, var_6_3)

			var_6_3.txttitlenum.text = iter_6_0
		end

		arg_6_0:_refreshEnemyItem(iter_6_0, var_6_2, var_6_3)
		gohelper.setActive(var_6_3.go, true)
	end

	for iter_6_1 = #var_6_2 + 1, #arg_6_0._enemyGroupItemGOs do
		gohelper.setActive(arg_6_0._enemyGroupItemGOs[iter_6_1].go, false)
	end
end

function var_0_0._refreshEnemyItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = false

	arg_7_0.selectMonsterIndex = nil

	local var_7_1 = lua_monster_group.configDict[tonumber(arg_7_2[arg_7_1])]
	local var_7_2 = {}
	local var_7_3 = string.nilorempty(var_7_1.monster)
	local var_7_4 = string.nilorempty(var_7_1.spMonster)

	if var_7_3 and var_7_4 then
		return
	end

	local var_7_5 = var_7_3 and {} or string.split(var_7_1.monster, "#")
	local var_7_6 = var_7_4 and {} or string.split(var_7_1.spMonster, "#")

	for iter_7_0, iter_7_1 in ipairs(var_7_6) do
		table.insert(var_7_5, iter_7_1)
	end

	for iter_7_2 = 1, #var_7_5 do
		local var_7_7 = tonumber(var_7_5[iter_7_2])
		local var_7_8 = arg_7_3.enemyItemGOs[iter_7_2]

		if not var_7_8 then
			local var_7_9 = gohelper.cloneInPlace(arg_7_3.goenemyitem, "item" .. iter_7_2)

			var_7_8 = arg_7_0:_initEnemyItem(var_7_9, var_7_7, arg_7_1)

			table.insert(arg_7_3.enemyItemGOs, var_7_8)
		end

		var_7_8.monsterId = var_7_7

		local var_7_10 = lua_monster.configDict[var_7_7]
		local var_7_11 = FightConfig.instance:getSkinCO(var_7_10.skinId)

		arg_7_0:_setEnemyItem(var_7_8, var_7_10, var_7_11, arg_7_1, iter_7_2)
		gohelper.setActive(var_7_8.go, true)
		gohelper.setActive(var_7_8.bosstag, false)

		if not var_7_0 and FightHelper.isBossId(var_7_1.bossId, var_7_7) then
			gohelper.setActive(var_7_8.bosstag, true)

			var_7_0 = true
		end

		arg_7_0._enemyItemIndex = arg_7_0._enemyItemIndex + 1
	end

	for iter_7_3 = #var_7_5 + 1, #arg_7_3.enemyItemGOs do
		gohelper.setActive(arg_7_3.enemyItemGOs[iter_7_3].go, false)
	end
end

function var_0_0._initEnemyItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_0:getUserDataTb_()

	var_8_0.go = arg_8_1
	var_8_0.monsterId = arg_8_2
	var_8_0.iconframe = gohelper.findChildImage(arg_8_1, "iconframe")
	var_8_0.icon = gohelper.findChildImage(arg_8_1, "icon")
	var_8_0.career = gohelper.findChildImage(arg_8_1, "career")
	var_8_0.selectframe = gohelper.findChild(arg_8_1, "selectframe")
	var_8_0.bosstag = gohelper.findChild(arg_8_1, "bosstag")
	var_8_0.btn = gohelper.findChildButtonWithAudio(arg_8_1, "btn_click", AudioEnum.UI.Play_UI_Tags)

	var_8_0.btn:AddClickListener(function(arg_9_0)
		local var_9_0 = {
			index = arg_9_0.index,
			monsterId = arg_9_0.monsterId,
			groupIndex = arg_8_3
		}

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickEnemyItem, var_9_0)

		arg_8_0.scrollDescContainer.verticalNormalizedPosition = 1
	end, var_8_0)

	function var_8_0.onClickEnemyItem(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_10_0._isSelected

		arg_10_0._isSelected = arg_10_0.index == arg_10_1.index

		gohelper.setActive(arg_10_0.selectframe, arg_10_0._isSelected)
	end

	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnClickEnemyItem, var_8_0.onClickEnemyItem, var_8_0)

	return var_8_0
end

function var_0_0._setEnemyItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	gohelper.setActive(arg_11_1.selectframe, false)

	arg_11_1.index = arg_11_0._enemyItemIndex
	arg_11_1.groupIndex = arg_11_4

	gohelper.getSingleImage(arg_11_1.icon.gameObject):LoadImage(ResUrl.monsterHeadIcon(arg_11_3.headIcon))
	UISpriteSetMgr.instance:setEnemyInfoSprite(arg_11_1.career, "sxy_" .. tostring(arg_11_2.career))

	if arg_11_2.heartVariantId ~= 0 then
		IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(arg_11_2.heartVariantId), arg_11_1.icon)
	end

	if arg_11_0._adventure then
		local var_11_0 = 1

		ZProj.UGUIHelper.SetGrayscale(arg_11_1.iconframe.gameObject, var_11_0 <= 0)
		ZProj.UGUIHelper.SetGrayscale(arg_11_1.icon.gameObject, var_11_0 <= 0)
		SLFramework.UGUI.GuiHelper.SetColor(arg_11_1.icon, var_11_0 <= 0 and "#999999" or "#FFFFFF")
	end

	if arg_11_0._enemyItemIndex == 1 then
		local var_11_1 = {}

		var_11_1.index = 1
		var_11_1.monsterId = arg_11_1.monsterId
		var_11_1.groupIndex = arg_11_1.groupIndex

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickEnemyItem, var_11_1, true)
	end
end

function var_0_0._refreshInfo(arg_12_0, arg_12_1)
	if arg_12_1.index ~= arg_12_0.selectMonsterIndex then
		arg_12_0.selectMonsterIndex = arg_12_1.index

		local var_12_0 = arg_12_1.monsterId
		local var_12_1 = arg_12_1.groupIndex
		local var_12_2 = lua_monster.configDict[var_12_0]
		local var_12_3 = FightConfig.instance:getSkinCO(var_12_2.skinId)

		gohelper.getSingleImage(arg_12_0._simageicon.gameObject):LoadImage(ResUrl.monsterHeadIcon(var_12_3.headIcon))

		if var_12_2.heartVariantId ~= 0 then
			IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(var_12_2.heartVariantId), arg_12_0._imageSelectEnemy)
		end

		UISpriteSetMgr.instance:setEnemyInfoSprite(arg_12_0._imagecareer, "sxy_" .. tostring(var_12_2.career))

		arg_12_0._txtlevel.text = HeroConfig.instance:getCommonLevelDisplay(var_12_2.level)

		local var_12_4 = FightConfig.instance:getNewMonsterConfig(var_12_2)

		arg_12_0._txtname.text = var_12_4 and var_12_2.highPriorityName or var_12_2.name
		arg_12_0._txtnameen.text = var_12_4 and var_12_2.highPriorityNameEng or var_12_2.nameEng

		UISpriteSetMgr.instance:setCommonSprite(arg_12_0._imagedmgtype, "dmgtype" .. tostring(var_12_2.dmgType))

		arg_12_0._txthp.text = string.format(luaLang("maxhp"), CharacterDataConfig.instance:getMonsterHp(var_12_0))
		arg_12_0._txtdesc.text = var_12_4 and var_12_2.highPriorityDes or var_12_2.des
		arg_12_0.bossSkillInfos = {}

		if FightHelper.isBossId(arg_12_0:_getBossId(var_12_1), var_12_2.id) then
			arg_12_0:_refreshSpeicalSkillIcon(var_12_2)
		else
			gohelper.setActive(arg_12_0._gopassiveskill, false)
		end

		arg_12_0:_refreshPassiveSkill(var_12_2, var_12_1)
		arg_12_0:_refreshSkill(var_12_2)
		arg_12_0:_refreshSuper(var_12_2)
		arg_12_0:_refreshAttribute(var_12_2)

		arg_12_0._scrollskill.horizontalNormalizedPosition = 0

		local var_12_5 = string.nilorempty(var_12_2.activeSkill)
		local var_12_6 = #var_12_2.uniqueSkill < 1
		local var_12_7 = var_12_5 and var_12_6

		gohelper.setActive(arg_12_0._gonoskill, var_12_7)
		gohelper.setActive(arg_12_0._goskill, not var_12_7)
	end
end

function var_0_0._getBossId(arg_13_0, arg_13_1)
	local var_13_0 = FightModel.instance:getSelectMonsterGroupId(arg_13_1, arg_13_0._battleId)
	local var_13_1 = var_13_0 and lua_monster_group.configDict[var_13_0]

	return var_13_1 and not string.nilorempty(var_13_1.bossId) and var_13_1.bossId or nil
end

function var_0_0._refreshSpeicalSkillIcon(arg_14_0, arg_14_1)
	local var_14_0 = FightConfig.instance:getPassiveSkillsAfterUIFilter(arg_14_1.id)
	local var_14_1 = FightConfig.instance:_filterSpeicalSkillIds(var_14_0, true)

	for iter_14_0 = 1, #var_14_1 do
		local var_14_2 = var_14_1[iter_14_0]
		local var_14_3 = lua_skill_specialbuff.configDict[var_14_2]

		if var_14_3 then
			local var_14_4 = arg_14_0._specialskillIconGOs[iter_14_0]

			if not var_14_4 then
				var_14_4 = arg_14_0:getUserDataTb_()
				var_14_4.go = gohelper.cloneInPlace(arg_14_0._gopassiveskillitem, "item" .. iter_14_0)
				var_14_4._gotag = gohelper.findChild(var_14_4.go, "tag")
				var_14_4._txttag = gohelper.findChildText(var_14_4.go, "tag/#txt_tag")

				table.insert(arg_14_0._specialskillIconGOs, var_14_4)

				local var_14_5 = gohelper.findChildImage(var_14_4.go, "icon")

				table.insert(arg_14_0._passiveiconImgs, var_14_5)
				gohelper.setActive(var_14_4.go, true)
			else
				gohelper.setActive(var_14_4.go, true)
			end

			if not string.nilorempty(var_14_3.lv) then
				gohelper.setActive(var_14_4._gotag, true)

				var_14_4._txttag.text = var_14_3.lv
			else
				gohelper.setActive(var_14_4._gotag, false)
			end

			if arg_14_0.bossSkillInfos[iter_14_0] == nil then
				arg_14_0.bossSkillInfos[iter_14_0] = {
					skillId = var_14_2,
					icon = var_14_3.icon
				}
			end

			if string.nilorempty(var_14_3.icon) then
				logError("boss抗性表的icon字段没有配置,技能ID:" .. var_14_3.id)
			end

			UISpriteSetMgr.instance:setFightPassiveSprite(arg_14_0._passiveiconImgs[iter_14_0], var_14_3.icon)
		end
	end

	if #var_14_1 < #arg_14_0._specialskillIconGOs then
		for iter_14_1 = #var_14_1 + 1, #arg_14_0._specialskillIconGOs do
			gohelper.setActive(arg_14_0._specialskillIconGOs[iter_14_1].go, false)
		end
	end

	if #arg_14_0._specialskillIconGOs > 0 then
		gohelper.setActive(arg_14_0._gopassiveskill, true)
	end

	gohelper.setAsLastSibling(arg_14_0._btnpassiveskill.gameObject)
	arg_14_0._btnpassiveskill:AddClickListener(arg_14_0._onBuffPassiveSkillClick, arg_14_0)
end

function var_0_0._onBuffPassiveSkillClick(arg_15_0)
	if arg_15_0.bossSkillInfos then
		local var_15_0

		for iter_15_0, iter_15_1 in pairs(arg_15_0.bossSkillInfos) do
			local var_15_1 = iter_15_1.skillId
			local var_15_2 = arg_15_0._enemybuffpassiveGOs[iter_15_0]

			if not var_15_2 then
				var_15_2 = gohelper.cloneInPlace(arg_15_0._gobuffpassiveitem, "item" .. iter_15_0)

				table.insert(arg_15_0._enemybuffpassiveGOs, var_15_2)

				local var_15_3 = gohelper.findChildImage(var_15_2, "title/simage_icon")

				table.insert(arg_15_0._passiveSkillImgs, var_15_3)
				gohelper.setActive(var_15_2, true)
			else
				gohelper.setActive(var_15_2, true)
			end

			local var_15_4 = gohelper.findChild(var_15_2, "txt_desc/image_line")

			gohelper.setActive(var_15_4, true)
			arg_15_0:_setPassiveSkillTip(var_15_2, iter_15_1)
			UISpriteSetMgr.instance:setFightPassiveSprite(arg_15_0._passiveSkillImgs[iter_15_0], iter_15_1.icon)
		end

		if #arg_15_0.bossSkillInfos < #arg_15_0._enemybuffpassiveGOs then
			for iter_15_2 = #arg_15_0.bossSkillInfos + 1, #arg_15_0._enemybuffpassiveGOs do
				gohelper.setActive(arg_15_0._enemybuffpassiveGOs[iter_15_2], false)
			end
		end

		local var_15_5 = gohelper.findChild(arg_15_0._enemybuffpassiveGOs[#arg_15_0.bossSkillInfos], "txt_desc/image_line")

		gohelper.setActive(var_15_5, false)
		gohelper.setActive(arg_15_0._gobuffpassiveview, true)

		arg_15_0.isopenpassiveview = false
	end
end

function var_0_0._setPassiveSkillTip(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = gohelper.findChildText(arg_16_1, "title/txt_name")
	local var_16_1 = gohelper.findChildText(arg_16_1, "txt_desc")
	local var_16_2 = lua_skill.configDict[arg_16_2.skillId]

	var_16_0.text = var_16_2.name
	var_16_1.text = HeroSkillModel.instance:skillDesToSpot(var_16_2.desc, "#CC492F", "#485E92")
end

function var_0_0._refreshPassiveSkill(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = FightConfig.instance:getPassiveSkillsAfterUIFilter(arg_17_1.id)

	if FightHelper.isBossId(arg_17_0:_getBossId(arg_17_2), arg_17_1.id) then
		var_17_0 = FightConfig.instance:_filterSpeicalSkillIds(var_17_0, false)
	end

	if var_17_0 and #var_17_0 > 0 then
		local var_17_1 = {}

		for iter_17_0 = 1, #var_17_0 do
			local var_17_2 = arg_17_0._passiveSkillGOs[iter_17_0]

			if not var_17_2 then
				local var_17_3 = gohelper.cloneInPlace(arg_17_0._goenemypassiveitem, "item" .. iter_17_0)

				var_17_2 = arg_17_0:getUserDataTb_()
				var_17_2.go = var_17_3
				var_17_2.name = gohelper.findChildText(var_17_3, "bg/bg/name")
				var_17_2.desc = gohelper.findChildText(var_17_3, "desc")
				var_17_2.descicon = gohelper.findChild(var_17_3, "desc/icon")
				var_17_2.detailPassiveStateTables = arg_17_0:getUserDataTb_()

				table.insert(arg_17_0._passiveSkillGOs, var_17_2)
			end

			local var_17_4 = tonumber(var_17_0[iter_17_0])
			local var_17_5 = lua_skill.configDict[var_17_4]

			if not var_17_5 then
				logError("找不到技能配置, id: " .. tostring(var_17_4))
			end

			var_17_2.name.text = var_17_5.name

			local var_17_6 = var_17_5.desc
			local var_17_7 = HeroSkillModel.instance:getEffectTagIDsFromDescRecursion(var_17_6)
			local var_17_8 = 0

			for iter_17_1 = 1, #var_17_7 do
				local var_17_9 = SkillConfig.instance:getSkillEffectDescCo(var_17_7[iter_17_1]).name

				if HeroSkillModel.instance:canShowSkillTag(var_17_9) and not var_17_1[var_17_9] then
					var_17_8 = var_17_8 + 1
					var_17_1[var_17_9] = true

					local var_17_10 = SkillConfig.instance:getSkillEffectDescCo(var_17_7[iter_17_1]).desc
					local var_17_11 = var_17_2.detailPassiveStateTables[var_17_8]

					if not var_17_11 then
						local var_17_12 = gohelper.cloneInPlace(var_17_2.desc.gameObject, "state")

						var_17_11 = arg_17_0:getUserDataTb_()
						var_17_11.go = var_17_12
						var_17_11.desc = var_17_12:GetComponent(gohelper.Type_TextMesh)

						gohelper.setActive(var_17_11.go, false)

						var_17_11.desc.text = ""
						var_17_2.detailPassiveStateTables[var_17_8] = var_17_11
					end

					gohelper.setActive(var_17_11.go, true)

					var_17_11.desc.text = HeroSkillModel.instance:skillDesToSpot(string.format("[%s]:%s", SkillConfig.instance:processSkillDesKeyWords(var_17_9), SkillConfig.instance:processSkillDesKeyWords(var_17_10)))
				end
			end

			for iter_17_2 = var_17_8 + 1, #var_17_2.detailPassiveStateTables do
				if var_17_2.detailPassiveStateTables[iter_17_2] then
					gohelper.setActive(var_17_2.detailPassiveStateTables[iter_17_2].go, false)
				end
			end

			var_17_2.desc.text = HeroSkillModel.instance:skillDesToSpot(var_17_6)

			gohelper.setActive(var_17_2.descicon, not string.nilorempty(var_17_2.desc.text))
			gohelper.setActive(var_17_2.go, true)
		end
	end

	for iter_17_3 = #var_17_0 + 1, #arg_17_0._passiveSkillGOs do
		gohelper.setActive(arg_17_0._passiveSkillGOs[iter_17_3].go, false)
	end
end

function var_0_0._refreshSkill(arg_18_0, arg_18_1)
	local var_18_0 = {}

	if not string.nilorempty(arg_18_1.activeSkill) then
		var_18_0 = string.split(arg_18_1.activeSkill, "|")

		for iter_18_0 = 1, #var_18_0 do
			local var_18_1 = arg_18_0._skillGOs[iter_18_0]

			if not var_18_1 then
				local var_18_2 = gohelper.cloneInPlace(arg_18_0._goskillitem, "item" .. iter_18_0)

				var_18_1 = arg_18_0:getUserDataTb_()
				var_18_1.go = var_18_2
				var_18_1.icon = gohelper.findChildSingleImage(var_18_2, "imgIcon")
				var_18_1.btn = gohelper.findChildButtonWithAudio(var_18_2, "bg", AudioEnum.UI.Play_UI_Activity_tips)

				var_18_1.btn:AddClickListener(function(arg_19_0)
					ViewMgr.instance:openView(ViewName.SkillTipView3, arg_19_0.info)
				end, var_18_1)

				var_18_1.tag = gohelper.findChildSingleImage(var_18_2, "tag/tagIcon")

				table.insert(arg_18_0._skillGOs, var_18_1)
			end

			local var_18_3 = string.splitToNumber(var_18_0[iter_18_0], "#")
			local var_18_4 = var_18_3[2]
			local var_18_5 = lua_skill.configDict[var_18_4]

			var_18_1.icon:LoadImage(ResUrl.getSkillIcon(var_18_5.icon))
			var_18_1.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_18_5.showTag))

			local var_18_6 = {}

			var_18_6.super = false

			table.remove(var_18_3, 1)

			var_18_6.skillIdList = var_18_3
			var_18_1.info = var_18_6

			gohelper.setActive(var_18_1.go, true)
		end
	end

	for iter_18_1 = #var_18_0 + 1, #arg_18_0._skillGOs do
		gohelper.setActive(arg_18_0._skillGOs[iter_18_1].go, false)
	end
end

function var_0_0._refreshSuper(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.uniqueSkill
	local var_20_1
	local var_20_2
	local var_20_3
	local var_20_4

	for iter_20_0 = 1, #var_20_0 do
		local var_20_5 = arg_20_0._superItemList[iter_20_0]

		if not var_20_5 then
			var_20_5 = arg_20_0:createSuperItem()

			table.insert(arg_20_0._superItemList, var_20_5)
		end

		local var_20_6 = var_20_0[iter_20_0]
		local var_20_7 = lua_skill.configDict[var_20_6]

		var_20_5.icon:LoadImage(ResUrl.getSkillIcon(var_20_7.icon))
		var_20_5.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_20_7.showTag))

		local var_20_8 = {}

		var_20_8.super = true
		var_20_8.skillIdList = {
			var_20_6
		}
		var_20_5.info = var_20_8

		gohelper.setActive(var_20_5.go, true)
	end

	gohelper.setActive(arg_20_0._gosupers, #var_20_0 > 0)

	for iter_20_1 = #var_20_0 + 1, #arg_20_0._superItemList do
		gohelper.setActive(arg_20_0._superItemList[iter_20_1].go, false)
	end
end

function var_0_0.createSuperItem(arg_21_0)
	local var_21_0 = arg_21_0:getUserDataTb_()

	var_21_0.go = gohelper.cloneInPlace(arg_21_0._gosuperitem)
	var_21_0.icon = gohelper.findChildSingleImage(var_21_0.go, "imgIcon")
	var_21_0.tag = gohelper.findChildSingleImage(var_21_0.go, "tag/tagIcon")
	var_21_0.btn = gohelper.findChildButtonWithAudio(var_21_0.go, "bg", AudioEnum.UI.Play_UI_Activity_tips)

	var_21_0.btn:AddClickListener(function(arg_22_0)
		ViewMgr.instance:openView(ViewName.SkillTipView3, arg_22_0.info)
	end, var_21_0)

	return var_21_0
end

function var_0_0._refreshAttribute(arg_23_0, arg_23_1)
	local var_23_0 = lua_monster_skill_template.configDict[arg_23_1.skillTemplate]
	local var_23_1 = CharacterDataConfig.instance:getMonsterAttributeScoreList(arg_23_1.id)

	table.insert(var_23_1, 2, table.remove(var_23_1, 4))

	local var_23_2 = {
		"atk",
		"technic",
		"def",
		"mdef"
	}
	local var_23_3 = {}

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		table.insert(var_23_3, {
			id = HeroConfig.instance:getIDByAttrType(var_23_2[iter_23_0]),
			value = iter_23_1
		})
	end

	gohelper.CreateObjList(arg_23_0, arg_23_0._onMonsterAttrItemShow, var_23_3, arg_23_0._goattribute)
end

function var_0_0._onMonsterAttrItemShow(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_1.transform
	local var_24_1 = var_24_0:Find("icon"):GetComponent(gohelper.Type_Image)
	local var_24_2 = var_24_0:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local var_24_3 = var_24_0:Find("rate"):GetComponent(gohelper.Type_Image)
	local var_24_4 = HeroConfig.instance:getHeroAttributeCO(arg_24_2.id)

	var_24_2.text = var_24_4.name

	UISpriteSetMgr.instance:setCommonSprite(var_24_1, "icon_att_" .. var_24_4.id)
	UISpriteSetMgr.instance:setCommonSprite(var_24_3, "sx_" .. arg_24_2.value, true)
end

function var_0_0._setInfoShowState(arg_25_0)
	arg_25_0._isShowAttributeInfo = not arg_25_0._isShowAttributeInfo

	gohelper.setActive(arg_25_0._gonormalicon, not arg_25_0._isShowAttributeInfo)
	gohelper.setActive(arg_25_0._godescscrollview, not arg_25_0._isShowAttributeInfo)
	gohelper.setActive(arg_25_0._goselecticon, arg_25_0._isShowAttributeInfo)
	gohelper.setActive(arg_25_0._goattribute, arg_25_0._isShowAttributeInfo)

	arg_25_0.scrollDescContainer.verticalNormalizedPosition = 1
end

function var_0_0.onUpdateParam(arg_26_0)
	arg_26_0._battleId = arg_26_0.viewParam.battleId
	arg_26_0._battleInfo = arg_26_0.viewParam.battleInfo

	arg_26_0:_refreshUI()
end

function var_0_0.onOpen(arg_27_0)
	arg_27_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickEnemyItem, arg_27_0._refreshInfo, arg_27_0)

	arg_27_0._battleId = arg_27_0.viewParam.battleId
	arg_27_0._battleInfo = arg_27_0.viewParam.battleInfo
	arg_27_0._adventure = arg_27_0.viewParam.adventure

	arg_27_0:_refreshUI()
end

function var_0_0.onClose(arg_28_0)
	arg_28_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickEnemyItem, arg_28_0._refreshInfo, arg_28_0)
end

function var_0_0.onDestroyView(arg_29_0)
	arg_29_0._simagerightbg:UnLoadImage()

	arg_29_0._simagerightbg = nil

	if arg_29_0._enemyGroupItemGOs then
		for iter_29_0 = 1, #arg_29_0._enemyGroupItemGOs do
			if arg_29_0._enemyGroupItemGOs[iter_29_0].enemyItemGOs then
				for iter_29_1 = 1, #arg_29_0._enemyGroupItemGOs[iter_29_0].enemyItemGOs do
					local var_29_0 = arg_29_0._enemyGroupItemGOs[iter_29_0].enemyItemGOs[iter_29_1]

					var_29_0.btn:RemoveClickListener()
					HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnClickEnemyItem, var_29_0.onClickEnemyItem, var_29_0)
				end
			end
		end
	end

	if arg_29_0._skillGOs then
		for iter_29_2 = 1, #arg_29_0._skillGOs do
			local var_29_1 = arg_29_0._skillGOs[iter_29_2]

			var_29_1.tag:UnLoadImage()
			var_29_1.icon:UnLoadImage()
			var_29_1.btn:RemoveClickListener()
		end
	end

	for iter_29_3, iter_29_4 in ipairs(arg_29_0._superItemList) do
		iter_29_4.btn:RemoveClickListener()
	end

	arg_29_0:__onDispose()
end

return var_0_0
