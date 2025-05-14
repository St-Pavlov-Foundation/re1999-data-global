module("modules.logic.seasonver.act123.view2_1.Season123_2_1EnemyView", package.seeall)

local var_0_0 = class("Season123_2_1EnemyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_rightbg")
	arg_1_0._goenemygroupitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_enemy/viewport/content/#go_enemygroupitem")
	arg_1_0._simageicon = gohelper.findChildImage(arg_1_0.viewGO, "enemyinfo/#simage_icon")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_0.viewGO, "enemyinfo/#image_career")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "enemyinfo/#txt_level")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "enemyinfo/#txt_name")
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
	arg_1_0.bossSkillInfos = {}
	arg_1_0.isopenpassiveview = false

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnshowattribute:AddClickListener(arg_2_0._onClickShowAttribute, arg_2_0)
	arg_2_0._btnclosepassiveview:AddClickListener(arg_2_0._onClickClosePassiveView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnshowattribute:RemoveClickListener()
	arg_3_0._btnpassiveskill:RemoveClickListener()
	arg_3_0._btnclosepassiveview:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.addUIClickAudio(arg_4_0._btnshowattribute.gameObject, AudioEnum.UI.play_ui_screenplay_photo_click)

	arg_4_0._imageSelectEnemy = gohelper.findChildImage(arg_4_0.viewGO, "enemyinfo/#simage_icon")
	arg_4_0._gosupers = gohelper.findChild(arg_4_0.viewGO, "enemyinfo/skill/card/scrollview/viewport/content/supers")

	arg_4_0._simagerightbg:LoadImage(ResUrl.getDungeonIcon("bg_battledetail"))

	arg_4_0._enemyGroupItemGOs = {}
	arg_4_0._passiveSkillGOs = {}
	arg_4_0._skillGOs = {}
	arg_4_0._superItemList = {}
	arg_4_0._specialskillIconGOs = arg_4_0:getUserDataTb_()
	arg_4_0._enemybuffpassiveGOs = arg_4_0:getUserDataTb_()
	arg_4_0._passiveSkillImgs = arg_4_0:getUserDataTb_()
	arg_4_0._passiveiconImgs = arg_4_0:getUserDataTb_()
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

function var_0_0.onDestroyView(arg_5_0)
	arg_5_0._simagerightbg:UnLoadImage()

	arg_5_0._simagerightbg = nil

	if arg_5_0._enemyGroupItemGOs then
		for iter_5_0 = 1, #arg_5_0._enemyGroupItemGOs do
			local var_5_0 = arg_5_0._enemyGroupItemGOs[iter_5_0]

			if var_5_0.enemyItems then
				for iter_5_1 = 1, #var_5_0.enemyItems do
					var_5_0.enemyItems[iter_5_1].btn:RemoveClickListener()
				end
			end
		end
	end

	if arg_5_0._skillGOs then
		for iter_5_2 = 1, #arg_5_0._skillGOs do
			local var_5_1 = arg_5_0._skillGOs[iter_5_2]

			var_5_1.tag:UnLoadImage()
			var_5_1.icon:UnLoadImage()
			var_5_1.btn:RemoveClickListener()
		end
	end

	for iter_5_3, iter_5_4 in ipairs(arg_5_0._superItemList) do
		iter_5_4.btn:RemoveClickListener()
	end

	Season123EnemyController.instance:onCloseView()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.EnemyDetailSwitchTab, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.EnemyDetailSelectEnemy, arg_6_0.handleClickMonster, arg_6_0)
	Season123EnemyController.instance:onOpenView(arg_6_0.viewParam.actId, arg_6_0.viewParam.stage, arg_6_0.viewParam.layer)
	arg_6_0:refreshUI()
end

function var_0_0.onClose(arg_7_0)
	arg_7_0:removeEventCb(Season123Controller.instance, Season123Event.EnemyDetailSwitchTab, arg_7_0.refreshUI, arg_7_0)
	arg_7_0:removeEventCb(Season123Controller.instance, Season123Event.EnemyDetailSelectEnemy, arg_7_0.handleClickMonster, arg_7_0)
end

function var_0_0.handleClickMonster(arg_8_0)
	arg_8_0:refreshMonsterSelect()
	arg_8_0:refreshEnemyInfo()
end

function var_0_0._onClickClosePassiveView(arg_9_0)
	gohelper.setActive(arg_9_0._gobuffpassiveview, false)

	arg_9_0.isopenpassiveview = false
end

function var_0_0.refreshUI(arg_10_0)
	local var_10_0 = Season123EnemyModel.instance:getCurrentBattleGroupIds()

	arg_10_0._enemyItemIndex = 1

	local var_10_1 = #var_10_0

	for iter_10_0 = 1, var_10_1 do
		local var_10_2 = arg_10_0:getOrCreateGroupItem(iter_10_0)

		arg_10_0:refreshEnemyGroup(iter_10_0, var_10_0, var_10_2)
		gohelper.setActive(var_10_2.go, true)
	end

	for iter_10_1 = var_10_1 + 1, #arg_10_0._enemyGroupItemGOs do
		gohelper.setActive(arg_10_0._enemyGroupItemGOs[iter_10_1].go, false)
	end
end

function var_0_0.getOrCreateGroupItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._enemyGroupItemGOs[arg_11_1]

	if not var_11_0 then
		local var_11_1 = gohelper.cloneInPlace(arg_11_0._goenemygroupitem, "item" .. arg_11_1)

		var_11_0 = arg_11_0:getUserDataTb_()
		var_11_0.go = var_11_1
		var_11_0.txttitlenum = gohelper.findChildText(var_11_1, "#txt_titlenum")
		var_11_0.goenemyitem = gohelper.findChild(var_11_1, "content/enemyitem")
		var_11_0.enemyItems = {}

		gohelper.setActive(var_11_0.goenemyitem, false)

		arg_11_0._enemyGroupItemGOs[arg_11_1] = var_11_0
		var_11_0.txttitlenum.text = tostring(arg_11_1)
	end

	return var_11_0
end

function var_0_0.refreshEnemyGroup(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = false
	local var_12_1 = arg_12_2[arg_12_1]
	local var_12_2 = Season123EnemyModel.instance:getMonsterIds(var_12_1)
	local var_12_3 = #var_12_2

	for iter_12_0 = 1, var_12_3 do
		local var_12_4 = tonumber(var_12_2[iter_12_0])
		local var_12_5 = arg_12_0:getOrCreateEnemyItem(arg_12_3, arg_12_1, iter_12_0)

		var_12_5.monsterId = var_12_4

		local var_12_6 = lua_monster.configDict[var_12_4]
		local var_12_7 = FightConfig.instance:getSkinCO(var_12_6.skinId)

		arg_12_0:refreshEnemyItem(var_12_5, var_12_4, arg_12_1, iter_12_0)
		gohelper.setActive(var_12_5.go, true)

		local var_12_8 = lua_monster_group.configDict[var_12_1]

		if not var_12_0 and var_12_8 and FightHelper.isBossId(var_12_8.bossId, var_12_4) then
			var_12_0 = true

			gohelper.setActive(var_12_5.bosstag, true)
		else
			gohelper.setActive(var_12_5.bosstag, false)
		end

		arg_12_0._enemyItemIndex = arg_12_0._enemyItemIndex + 1
	end

	for iter_12_1 = var_12_3 + 1, #arg_12_3.enemyItems do
		gohelper.setActive(arg_12_3.enemyItems[iter_12_1].go, false)
	end
end

function var_0_0.getOrCreateEnemyItem(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1.enemyItems[arg_13_3]

	if not var_13_0 then
		local var_13_1 = gohelper.cloneInPlace(arg_13_1.goenemyitem, "item" .. tostring(arg_13_3))

		var_13_0 = arg_13_0:getUserDataTb_()
		var_13_0.go = var_13_1
		var_13_0.iconframe = gohelper.findChildImage(var_13_1, "iconframe")
		var_13_0.icon = gohelper.findChildImage(var_13_1, "icon")
		var_13_0.career = gohelper.findChildImage(var_13_1, "career")
		var_13_0.selectframe = gohelper.findChild(var_13_1, "selectframe")
		var_13_0.bosstag = gohelper.findChild(var_13_1, "bosstag")
		var_13_0.btn = gohelper.findChildButtonWithAudio(var_13_1, "btn_click", AudioEnum.UI.Play_UI_Tags)

		local var_13_2 = {
			index = arg_13_3,
			groupIndex = arg_13_2
		}

		var_13_0.btn:AddClickListener(arg_13_0.onClickMonsterIcon, arg_13_0, var_13_2)

		arg_13_1.enemyItems[arg_13_3] = var_13_0
	end

	return var_13_0
end

function var_0_0.onClickMonsterIcon(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.groupIndex
	local var_14_1 = arg_14_1.index

	Season123EnemyController.instance:selectMonster(var_14_0, var_14_1)
end

function var_0_0.refreshEnemyItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = lua_monster.configDict[arg_15_2]
	local var_15_1 = FightConfig.instance:getSkinCO(var_15_0.skinId)

	gohelper.setActive(arg_15_1.selectframe, arg_15_2 == Season123EnemyModel.instance.selectMonsterId)

	arg_15_1.index = arg_15_0._enemyItemIndex
	arg_15_1.groupIndex = arg_15_3
	arg_15_1.monsterId = arg_15_2

	gohelper.getSingleImage(arg_15_1.icon.gameObject):LoadImage(ResUrl.monsterHeadIcon(var_15_1.headIcon))
	UISpriteSetMgr.instance:setEnemyInfoSprite(arg_15_1.career, "sxy_" .. tostring(var_15_0.career))

	if var_15_0.heartVariantId ~= 0 then
		IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(var_15_0.heartVariantId), arg_15_1.icon)
	end
end

function var_0_0.refreshMonsterSelect(arg_16_0)
	local var_16_0 = Season123EnemyModel.instance:getCurrentBattleGroupIds()
	local var_16_1 = Season123EnemyModel.instance.selectMonsterId

	for iter_16_0, iter_16_1 in pairs(arg_16_0._enemyGroupItemGOs) do
		local var_16_2 = var_16_0[iter_16_0]

		if var_16_2 then
			local var_16_3 = Season123EnemyModel.instance:getMonsterIds(var_16_2)

			for iter_16_2, iter_16_3 in pairs(iter_16_1.enemyItems) do
				local var_16_4 = var_16_3[iter_16_2]

				if var_16_4 then
					gohelper.setActive(iter_16_3.selectframe, var_16_1 == var_16_4)
				end
			end
		end
	end
end

function var_0_0.refreshEnemyInfo(arg_17_0)
	local var_17_0 = Season123EnemyModel.instance.selectMonsterId
	local var_17_1 = Season123EnemyModel.instance.selectMonsterGroupIndex
	local var_17_2 = lua_monster.configDict[var_17_0]
	local var_17_3 = FightConfig.instance:getSkinCO(var_17_2.skinId)

	gohelper.getSingleImage(arg_17_0._simageicon.gameObject):LoadImage(ResUrl.monsterHeadIcon(var_17_3.headIcon))

	if var_17_2.heartVariantId ~= 0 then
		IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(var_17_2.heartVariantId), arg_17_0._imageSelectEnemy)
	end

	UISpriteSetMgr.instance:setEnemyInfoSprite(arg_17_0._imagecareer, "sxy_" .. tostring(var_17_2.career))

	arg_17_0._txtlevel.text = HeroConfig.instance:getCommonLevelDisplay(var_17_2.level)

	local var_17_4 = FightConfig.instance:getNewMonsterConfig(var_17_2)

	arg_17_0._txtname.text = var_17_4 and var_17_2.highPriorityName or var_17_2.name
	arg_17_0._txtnameen.text = var_17_4 and var_17_2.highPriorityNameEng or var_17_2.nameEng
	arg_17_0._txthp.text = string.format(luaLang("maxhp"), CharacterDataConfig.instance:getMonsterHp(var_17_0))
	arg_17_0._txtdesc.text = var_17_4 and var_17_2.highPriorityDes or var_17_2.des
	arg_17_0.bossSkillInfos = {}

	local var_17_5 = Season123EnemyModel.instance:getBossId(var_17_1)

	if var_17_5 and FightHelper.isBossId(var_17_5, var_17_2.id) then
		arg_17_0:_refreshSpeicalSkillIcon(var_17_2)
	else
		gohelper.setActive(arg_17_0._gopassiveskill, false)
	end

	arg_17_0:_refreshPassiveSkill(var_17_2, var_17_1)
	arg_17_0:_refreshSkill(var_17_2)
	arg_17_0:_refreshSuper(var_17_2)
	arg_17_0:_refreshAttribute(var_17_2)

	arg_17_0._scrollskill.horizontalNormalizedPosition = 0

	local var_17_6 = string.nilorempty(var_17_2.activeSkill)
	local var_17_7 = #var_17_2.uniqueSkill < 1
	local var_17_8 = var_17_6 and var_17_7

	gohelper.setActive(arg_17_0._gonoskill, var_17_8)
	gohelper.setActive(arg_17_0._goskill, not var_17_8)
end

function var_0_0._refreshSpeicalSkillIcon(arg_18_0, arg_18_1)
	local var_18_0 = FightConfig.instance:getPassiveSkillsAfterUIFilter(arg_18_1.id)
	local var_18_1 = FightConfig.instance:_filterSpeicalSkillIds(var_18_0, true)

	for iter_18_0 = 1, #var_18_1 do
		local var_18_2 = var_18_1[iter_18_0]
		local var_18_3 = lua_skill_specialbuff.configDict[var_18_2]

		if var_18_3 then
			local var_18_4 = arg_18_0._specialskillIconGOs[iter_18_0]

			if not var_18_4 then
				var_18_4 = arg_18_0:getUserDataTb_()
				var_18_4.go = gohelper.cloneInPlace(arg_18_0._gopassiveskillitem, "item" .. iter_18_0)
				var_18_4._gotag = gohelper.findChild(var_18_4.go, "tag")
				var_18_4._txttag = gohelper.findChildText(var_18_4.go, "tag/#txt_tag")

				table.insert(arg_18_0._specialskillIconGOs, var_18_4)

				local var_18_5 = gohelper.findChildImage(var_18_4.go, "icon")

				table.insert(arg_18_0._passiveiconImgs, var_18_5)
				gohelper.setActive(var_18_4.go, true)
			else
				gohelper.setActive(var_18_4.go, true)
			end

			if not string.nilorempty(var_18_3.lv) then
				gohelper.setActive(var_18_4._gotag, true)

				var_18_4._txttag.text = var_18_3.lv
			else
				gohelper.setActive(var_18_4._gotag, false)
			end

			if arg_18_0.bossSkillInfos[iter_18_0] == nil then
				arg_18_0.bossSkillInfos[iter_18_0] = {
					skillId = var_18_2,
					icon = var_18_3.icon
				}
			end

			if string.nilorempty(var_18_3.icon) then
				logError("boss抗性表的icon字段没有配置,技能ID:" .. var_18_3.id)
			end

			UISpriteSetMgr.instance:setFightPassiveSprite(arg_18_0._passiveiconImgs[iter_18_0], var_18_3.icon)
		end
	end

	if #var_18_1 < #arg_18_0._specialskillIconGOs then
		for iter_18_1 = #var_18_1 + 1, #arg_18_0._specialskillIconGOs do
			gohelper.setActive(arg_18_0._specialskillIconGOs[iter_18_1].go, false)
		end
	end

	if #arg_18_0._specialskillIconGOs > 0 then
		gohelper.setActive(arg_18_0._gopassiveskill, true)
	end

	gohelper.setAsLastSibling(arg_18_0._btnpassiveskill.gameObject)
	arg_18_0._btnpassiveskill:AddClickListener(arg_18_0._onBuffPassiveSkillClick, arg_18_0)
end

function var_0_0._onBuffPassiveSkillClick(arg_19_0)
	if arg_19_0.bossSkillInfos then
		local var_19_0

		for iter_19_0, iter_19_1 in pairs(arg_19_0.bossSkillInfos) do
			local var_19_1 = iter_19_1.skillId
			local var_19_2 = arg_19_0._enemybuffpassiveGOs[iter_19_0]

			if not var_19_2 then
				var_19_2 = gohelper.cloneInPlace(arg_19_0._gobuffpassiveitem, "item" .. iter_19_0)

				table.insert(arg_19_0._enemybuffpassiveGOs, var_19_2)

				local var_19_3 = gohelper.findChildImage(var_19_2, "title/simage_icon")

				table.insert(arg_19_0._passiveSkillImgs, var_19_3)
				gohelper.setActive(var_19_2, true)
			else
				gohelper.setActive(var_19_2, true)
			end

			local var_19_4 = gohelper.findChild(var_19_2, "txt_desc/image_line")

			gohelper.setActive(var_19_4, true)
			arg_19_0:_setPassiveSkillTip(var_19_2, iter_19_1)
			UISpriteSetMgr.instance:setFightPassiveSprite(arg_19_0._passiveSkillImgs[iter_19_0], iter_19_1.icon)
		end

		if #arg_19_0.bossSkillInfos < #arg_19_0._enemybuffpassiveGOs then
			for iter_19_2 = #arg_19_0.bossSkillInfos + 1, #arg_19_0._enemybuffpassiveGOs do
				gohelper.setActive(arg_19_0._enemybuffpassiveGOs[iter_19_2], false)
			end
		end

		local var_19_5 = gohelper.findChild(arg_19_0._enemybuffpassiveGOs[#arg_19_0.bossSkillInfos], "txt_desc/image_line")

		gohelper.setActive(var_19_5, false)
		gohelper.setActive(arg_19_0._gobuffpassiveview, true)

		arg_19_0.isopenpassiveview = false
	end
end

function var_0_0._setPassiveSkillTip(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = gohelper.findChildText(arg_20_1, "title/txt_name")
	local var_20_1 = gohelper.findChildText(arg_20_1, "txt_desc")
	local var_20_2 = lua_skill.configDict[arg_20_2.skillId]

	var_20_0.text = var_20_2.name
	var_20_1.text = HeroSkillModel.instance:skillDesToSpot(var_20_2.desc, "#CC492F", "#485E92")
end

function var_0_0._refreshPassiveSkill(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = FightConfig.instance:getPassiveSkillsAfterUIFilter(arg_21_1.id)

	if FightHelper.isBossId(Season123EnemyModel.instance:getBossId(arg_21_2), arg_21_1.id) then
		var_21_0 = FightConfig.instance:_filterSpeicalSkillIds(var_21_0, false)
	end

	if var_21_0 and #var_21_0 > 0 then
		local var_21_1 = {}

		for iter_21_0 = 1, #var_21_0 do
			local var_21_2 = arg_21_0._passiveSkillGOs[iter_21_0]

			if not var_21_2 then
				local var_21_3 = gohelper.cloneInPlace(arg_21_0._goenemypassiveitem, "item" .. iter_21_0)

				var_21_2 = arg_21_0:getUserDataTb_()
				var_21_2.go = var_21_3
				var_21_2.name = gohelper.findChildText(var_21_3, "bg/bg/name")
				var_21_2.desc = gohelper.findChildText(var_21_3, "desc")
				var_21_2.descicon = gohelper.findChild(var_21_3, "desc/icon")
				var_21_2.detailPassiveStateTables = arg_21_0:getUserDataTb_()

				table.insert(arg_21_0._passiveSkillGOs, var_21_2)
			end

			local var_21_4 = tonumber(var_21_0[iter_21_0])
			local var_21_5 = lua_skill.configDict[var_21_4]

			if not var_21_5 then
				logError("找不到技能配置, id: " .. tostring(var_21_4))
			end

			var_21_2.name.text = var_21_5.name

			local var_21_6 = var_21_5.desc
			local var_21_7 = HeroSkillModel.instance:getEffectTagIDsFromDescRecursion(var_21_6)
			local var_21_8 = 0

			for iter_21_1 = 1, #var_21_7 do
				local var_21_9 = SkillConfig.instance:getSkillEffectDescCo(var_21_7[iter_21_1]).name

				if HeroSkillModel.instance:canShowSkillTag(var_21_9) and not var_21_1[var_21_9] then
					var_21_8 = var_21_8 + 1
					var_21_1[var_21_9] = true

					local var_21_10 = SkillConfig.instance:getSkillEffectDescCo(var_21_7[iter_21_1]).desc
					local var_21_11 = var_21_2.detailPassiveStateTables[var_21_8]

					if not var_21_11 then
						local var_21_12 = gohelper.cloneInPlace(var_21_2.desc.gameObject, "state")

						var_21_11 = arg_21_0:getUserDataTb_()
						var_21_11.go = var_21_12
						var_21_11.desc = var_21_12:GetComponent(gohelper.Type_TextMesh)

						gohelper.setActive(var_21_11.go, false)

						var_21_11.desc.text = ""
						var_21_2.detailPassiveStateTables[var_21_8] = var_21_11
					end

					gohelper.setActive(var_21_11.go, true)

					var_21_11.desc.text = HeroSkillModel.instance:skillDesToSpot(string.format("[%s]:%s", SkillConfig.instance:processSkillDesKeyWords(var_21_9), SkillConfig.instance:processSkillDesKeyWords(var_21_10)))
				end
			end

			for iter_21_2 = var_21_8 + 1, #var_21_2.detailPassiveStateTables do
				if var_21_2.detailPassiveStateTables[iter_21_2] then
					gohelper.setActive(var_21_2.detailPassiveStateTables[iter_21_2].go, false)
				end
			end

			var_21_2.desc.text = HeroSkillModel.instance:skillDesToSpot(var_21_6)

			gohelper.setActive(var_21_2.descicon, not string.nilorempty(var_21_2.desc.text))
			gohelper.setActive(var_21_2.go, true)
		end
	end

	for iter_21_3 = #var_21_0 + 1, #arg_21_0._passiveSkillGOs do
		gohelper.setActive(arg_21_0._passiveSkillGOs[iter_21_3].go, false)
	end
end

function var_0_0._refreshSkill(arg_22_0, arg_22_1)
	local var_22_0 = {}

	if not string.nilorempty(arg_22_1.activeSkill) then
		var_22_0 = string.split(arg_22_1.activeSkill, "|")

		for iter_22_0 = 1, #var_22_0 do
			local var_22_1 = arg_22_0._skillGOs[iter_22_0]

			if not var_22_1 then
				local var_22_2 = gohelper.cloneInPlace(arg_22_0._goskillitem, "item" .. iter_22_0)

				var_22_1 = arg_22_0:getUserDataTb_()
				var_22_1.go = var_22_2
				var_22_1.icon = gohelper.findChildSingleImage(var_22_2, "imgIcon")
				var_22_1.btn = gohelper.findChildButtonWithAudio(var_22_2, "bg", AudioEnum.UI.Play_UI_Activity_tips)

				var_22_1.btn:AddClickListener(function(arg_23_0)
					ViewMgr.instance:openView(ViewName.SkillTipView3, arg_23_0.info)
				end, var_22_1)

				var_22_1.tag = gohelper.findChildSingleImage(var_22_2, "tag/tagIcon")

				table.insert(arg_22_0._skillGOs, var_22_1)
			end

			local var_22_3 = string.splitToNumber(var_22_0[iter_22_0], "#")
			local var_22_4 = var_22_3[2]
			local var_22_5 = lua_skill.configDict[var_22_4]

			var_22_1.icon:LoadImage(ResUrl.getSkillIcon(var_22_5.icon))
			var_22_1.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_22_5.showTag))

			local var_22_6 = {}

			var_22_6.super = false

			table.remove(var_22_3, 1)

			var_22_6.skillIdList = var_22_3
			var_22_1.info = var_22_6

			gohelper.setActive(var_22_1.go, true)
		end
	end

	for iter_22_1 = #var_22_0 + 1, #arg_22_0._skillGOs do
		gohelper.setActive(arg_22_0._skillGOs[iter_22_1].go, false)
	end
end

function var_0_0._refreshSuper(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1.uniqueSkill
	local var_24_1
	local var_24_2
	local var_24_3
	local var_24_4

	for iter_24_0 = 1, #var_24_0 do
		local var_24_5 = arg_24_0._superItemList[iter_24_0]

		if not var_24_5 then
			var_24_5 = arg_24_0:createSuperItem()

			table.insert(arg_24_0._superItemList, var_24_5)
		end

		local var_24_6 = var_24_0[iter_24_0]
		local var_24_7 = lua_skill.configDict[var_24_6]

		var_24_5.icon:LoadImage(ResUrl.getSkillIcon(var_24_7.icon))
		var_24_5.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_24_7.showTag))

		local var_24_8 = {}

		var_24_8.super = true
		var_24_8.skillIdList = {
			var_24_6
		}
		var_24_5.info = var_24_8

		gohelper.setActive(var_24_5.go, true)
	end

	gohelper.setActive(arg_24_0._gosupers, #var_24_0 > 0)

	for iter_24_1 = #var_24_0 + 1, #arg_24_0._superItemList do
		gohelper.setActive(arg_24_0._superItemList[iter_24_1].go, false)
	end
end

function var_0_0.createSuperItem(arg_25_0)
	local var_25_0 = arg_25_0:getUserDataTb_()

	var_25_0.go = gohelper.cloneInPlace(arg_25_0._gosuperitem)
	var_25_0.icon = gohelper.findChildSingleImage(var_25_0.go, "imgIcon")
	var_25_0.tag = gohelper.findChildSingleImage(var_25_0.go, "tag/tagIcon")
	var_25_0.btn = gohelper.findChildButtonWithAudio(var_25_0.go, "bg", AudioEnum.UI.Play_UI_Activity_tips)

	var_25_0.btn:AddClickListener(function(arg_26_0)
		ViewMgr.instance:openView(ViewName.SkillTipView3, arg_26_0.info)
	end, var_25_0)

	return var_25_0
end

function var_0_0._refreshAttribute(arg_27_0, arg_27_1)
	local var_27_0 = lua_monster_skill_template.configDict[arg_27_1.skillTemplate]
	local var_27_1 = CharacterDataConfig.instance:getMonsterAttributeScoreList(arg_27_1.id)

	table.insert(var_27_1, 2, table.remove(var_27_1, 4))

	local var_27_2 = {
		"atk",
		"technic",
		"def",
		"mdef"
	}
	local var_27_3 = {}

	for iter_27_0, iter_27_1 in ipairs(var_27_1) do
		table.insert(var_27_3, {
			id = HeroConfig.instance:getIDByAttrType(var_27_2[iter_27_0]),
			value = iter_27_1
		})
	end

	gohelper.CreateObjList(arg_27_0, arg_27_0._onMonsterAttrItemShow, var_27_3, arg_27_0._goattribute)
end

function var_0_0._onMonsterAttrItemShow(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = arg_28_1.transform
	local var_28_1 = var_28_0:Find("icon"):GetComponent(gohelper.Type_Image)
	local var_28_2 = var_28_0:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local var_28_3 = var_28_0:Find("rate"):GetComponent(gohelper.Type_Image)
	local var_28_4 = HeroConfig.instance:getHeroAttributeCO(arg_28_2.id)

	var_28_2.text = var_28_4.name

	UISpriteSetMgr.instance:setCommonSprite(var_28_1, "icon_att_" .. var_28_4.id)
	UISpriteSetMgr.instance:setCommonSprite(var_28_3, "sx_" .. arg_28_2.value, true)
end

function var_0_0._onClickShowAttribute(arg_29_0)
	arg_29_0._isShowAttributeInfo = not arg_29_0._isShowAttributeInfo

	gohelper.setActive(arg_29_0._gonormalicon, not arg_29_0._isShowAttributeInfo)
	gohelper.setActive(arg_29_0._godescscrollview, not arg_29_0._isShowAttributeInfo)
	gohelper.setActive(arg_29_0._goselecticon, arg_29_0._isShowAttributeInfo)
	gohelper.setActive(arg_29_0._goattribute, arg_29_0._isShowAttributeInfo)

	arg_29_0.scrollDescContainer.verticalNormalizedPosition = 1
end

return var_0_0
