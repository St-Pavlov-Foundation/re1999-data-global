module("modules.logic.versionactivity2_7.act191.view.Act191AssistantView", package.seeall)

local var_0_0 = class("Act191AssistantView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goAssistantItem = gohelper.findChild(arg_1_0.viewGO, "root/left/scroll_enemy/Viewport/Content/#go_AssistantItem")
	arg_1_0._simageBoss = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/left/boss/#simage_Boss")
	arg_1_0._btnEquip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/boss/#btn_Equip")
	arg_1_0._goEquipped = gohelper.findChild(arg_1_0.viewGO, "root/left/boss/#go_Equipped")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "root/right/Info/#txt_Name")
	arg_1_0._imageCareer = gohelper.findChildImage(arg_1_0.viewGO, "root/right/Info/#image_Career")
	arg_1_0._txtTag = gohelper.findChildText(arg_1_0.viewGO, "root/right/Info/base/scroll_tag/Viewport/Content/TagItem/#txt_Tag")
	arg_1_0._imageTag = gohelper.findChildImage(arg_1_0.viewGO, "root/right/Info/base/scroll_tag/Viewport/Content/TagItem/#txt_Tag/#image_Tag")
	arg_1_0._goAttribute1 = gohelper.findChild(arg_1_0.viewGO, "root/right/Info/Attribute/#go_Attribute1")
	arg_1_0._txtAttack = gohelper.findChildText(arg_1_0.viewGO, "root/right/Info/Attribute/#go_Attribute1/#txt_Attack")
	arg_1_0._goAttribute2 = gohelper.findChild(arg_1_0.viewGO, "root/right/Info/Attribute/#go_Attribute2")
	arg_1_0._txtDef = gohelper.findChildText(arg_1_0.viewGO, "root/right/Info/Attribute/#go_Attribute2/#txt_Def")
	arg_1_0._goAttribute3 = gohelper.findChild(arg_1_0.viewGO, "root/right/Info/Attribute/#go_Attribute3")
	arg_1_0._txtTechnic = gohelper.findChildText(arg_1_0.viewGO, "root/right/Info/Attribute/#go_Attribute3/#txt_Technic")
	arg_1_0._goAttribute4 = gohelper.findChild(arg_1_0.viewGO, "root/right/Info/Attribute/#go_Attribute4")
	arg_1_0._txtHp = gohelper.findChildText(arg_1_0.viewGO, "root/right/Info/Attribute/#go_Attribute4/#txt_Hp")
	arg_1_0._goAttribute5 = gohelper.findChild(arg_1_0.viewGO, "root/right/Info/Attribute/#go_Attribute5")
	arg_1_0._txtMDef = gohelper.findChildText(arg_1_0.viewGO, "root/right/Info/Attribute/#go_Attribute5/#txt_MDef")
	arg_1_0._goPassiveSkill = gohelper.findChild(arg_1_0.viewGO, "root/right/Info/#go_PassiveSkill")
	arg_1_0._txtPassiveName = gohelper.findChildText(arg_1_0.viewGO, "root/right/Info/#go_PassiveSkill/bg/#txt_PassiveName")
	arg_1_0._btnPassiveSkill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/Info/#go_PassiveSkill/#btn_PassiveSkill")
	arg_1_0._goSkill = gohelper.findChild(arg_1_0.viewGO, "root/right/Info/#go_Skill")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEquip:AddClickListener(arg_2_0._btnEquipOnClick, arg_2_0)
	arg_2_0._btnPassiveSkill:AddClickListener(arg_2_0._btnPassiveSkillOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEquip:RemoveClickListener()
	arg_3_0._btnPassiveSkill:RemoveClickListener()
end

function var_0_0._btnEquipOnClick(arg_4_0)
	arg_4_0.equippedIndex = arg_4_0.selectIndex

	arg_4_0:refreshTabEquip()
	arg_4_0:refreshEquipStatus()
end

function var_0_0._btnPassiveSkillOnClick(arg_5_0)
	local var_5_0 = arg_5_0.summonCfgList[arg_5_0.selectIndex]
	local var_5_1 = #arg_5_0.passiveSkillIds

	for iter_5_0 = 1, var_5_1 do
		local var_5_2 = tonumber(arg_5_0.passiveSkillIds[iter_5_0])
		local var_5_3 = lua_skill.configDict[var_5_2]

		if var_5_3 then
			local var_5_4 = arg_5_0._detailPassiveTables[iter_5_0]

			if not var_5_4 then
				local var_5_5 = gohelper.cloneInPlace(arg_5_0.goDetailItem, "item" .. iter_5_0)

				var_5_4 = arg_5_0:getUserDataTb_()
				var_5_4.go = var_5_5
				var_5_4.name = gohelper.findChildText(var_5_5, "title/txt_name")
				var_5_4.icon = gohelper.findChildSingleImage(var_5_5, "title/simage_icon")
				var_5_4.desc = gohelper.findChildText(var_5_5, "txt_desc")

				SkillHelper.addHyperLinkClick(var_5_4.desc, arg_5_0.onClickHyperLink, arg_5_0)

				var_5_4.line = gohelper.findChild(var_5_5, "txt_desc/image_line")

				table.insert(arg_5_0._detailPassiveTables, var_5_4)
			end

			var_5_4.name.text = var_5_3.name
			var_5_4.desc.text = SkillHelper.getSkillDesc(var_5_0.name, var_5_3)

			gohelper.setActive(var_5_4.go, true)
			gohelper.setActive(var_5_4.line, iter_5_0 < var_5_1)
		else
			logError(string.format("被动技能配置没找到, id: %d", var_5_2))
		end
	end

	for iter_5_1 = var_5_1 + 1, #arg_5_0._detailPassiveTables do
		gohelper.setActive(arg_5_0._detailPassiveTables[iter_5_1].go, false)
	end

	gohelper.setActive(arg_5_0.goDetail, true)
end

function var_0_0._btnCloseDetailOnClick(arg_6_0)
	gohelper.setActive(arg_6_0.goDetail, false)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.anim = arg_7_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_7_0.assistantItemList = {}
	arg_7_0.attributeTexts = {}

	for iter_7_0 = 1, 5 do
		local var_7_0 = gohelper.findChild(arg_7_0._goAttribute, "attribute" .. iter_7_0)

		arg_7_0.attributeTexts[iter_7_0] = gohelper.findChild(var_7_0, "num")
	end

	arg_7_0._detailPassiveTables = {}
	arg_7_0.goDetail = gohelper.findChild(arg_7_0.viewGO, "root/right/go_DetailView")
	arg_7_0.btnCloseDetail = gohelper.findChildButtonWithAudio(arg_7_0.goDetail, "btn_DetailClose")
	arg_7_0.goDetailItem = gohelper.findChild(arg_7_0.goDetail, "scroll_content/viewport/content/go_detailpassiveitem")

	arg_7_0:addClickCb(arg_7_0.btnCloseDetail, arg_7_0._btnCloseDetailOnClick, arg_7_0)

	arg_7_0.skillName = gohelper.findChild(arg_7_0._goSkill, "skillcn")
	arg_7_0.skillItemList = {}

	local var_7_1 = gohelper.findChild(arg_7_0._goSkill, "line/go_skills")

	for iter_7_1 = 1, 3 do
		local var_7_2 = arg_7_0:getUserDataTb_()
		local var_7_3 = gohelper.findChild(var_7_1, "skillicon" .. tostring(iter_7_1))

		var_7_2.go = var_7_3
		var_7_2.icon = gohelper.findChildSingleImage(var_7_3, "imgIcon")
		var_7_2.tag = gohelper.findChildSingleImage(var_7_3, "tag/tagIcon")

		local var_7_4 = gohelper.findChildButtonWithAudio(var_7_3, "bg", AudioEnum.UI.Play_ui_role_description)

		arg_7_0:addClickCb(var_7_4, arg_7_0._onSkillCardClick, arg_7_0, iter_7_1)

		arg_7_0.skillItemList[iter_7_1] = var_7_2
	end
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.summonCfgList = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.viewParam) do
		arg_8_0.summonCfgList[iter_8_0] = lua_activity191_summon.configDict[iter_8_1]
	end

	arg_8_0:initAssistantItem()
	arg_8_0:_btnTabItemOnClick(1, true)
	arg_8_0:_btnEquipOnClick()
end

function var_0_0.onDestroyView(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.delaySwitch, arg_9_0)
end

function var_0_0.initAssistantItem(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.summonCfgList do
		local var_10_0 = arg_10_0.summonCfgList[iter_10_0]
		local var_10_1 = gohelper.cloneInPlace(arg_10_0._goAssistantItem)
		local var_10_2 = arg_10_0:getUserDataTb_()

		var_10_2.index = iter_10_0
		var_10_2.goNormal = gohelper.findChild(var_10_1, "normal")
		var_10_2.goEquipped = gohelper.findChild(var_10_1, "equipped")
		var_10_2.goSelect = gohelper.findChild(var_10_1, "select")

		gohelper.findChildSingleImage(var_10_1, "icon"):LoadImage(ResUrl.monsterHeadIcon(var_10_0.headIcon))

		local var_10_3 = gohelper.findChildImage(var_10_1, "career")

		UISpriteSetMgr.instance:setEnemyInfoSprite(var_10_3, "sxy_" .. var_10_0.career)

		var_10_2.goNew = gohelper.findChild(var_10_1, "new")

		local var_10_4 = gohelper.findChildButtonWithAudio(var_10_1, "click")

		var_10_2.config = var_10_0

		arg_10_0:addClickCb(var_10_4, arg_10_0._btnTabItemOnClick, arg_10_0, iter_10_0)

		arg_10_0.assistantItemList[iter_10_0] = var_10_2
	end

	gohelper.setActive(arg_10_0._goAssistantItem, false)
end

function var_0_0._btnTabItemOnClick(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.selectIndex == arg_11_1 then
		return
	end

	arg_11_0.selectIndex = arg_11_1

	if arg_11_2 then
		arg_11_0:delaySwitch()
	else
		arg_11_0.anim:Play("switch", 0, 0)
		TaskDispatcher.runDelay(arg_11_0.delaySwitch, arg_11_0, 0.16)
	end
end

function var_0_0.delaySwitch(arg_12_0)
	arg_12_0:refreshTabSelect()
	arg_12_0:refreshEquipStatus()
	arg_12_0:refreshAssistantInfo()
end

function var_0_0.refreshTabSelect(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.assistantItemList) do
		gohelper.setActive(iter_13_1.goNormal, iter_13_0 ~= arg_13_0.selectIndex)
		gohelper.setActive(iter_13_1.goSelect, iter_13_0 == arg_13_0.selectIndex)
	end
end

function var_0_0.refreshTabEquip(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.assistantItemList) do
		gohelper.setActive(iter_14_1.goEquipped, iter_14_0 == arg_14_0.equippedIndex)
	end
end

function var_0_0.refreshEquipStatus(arg_15_0)
	gohelper.setActive(arg_15_0._btnEquip, false)
	gohelper.setActive(arg_15_0._goEquipped, true)
end

function var_0_0.refreshAssistantInfo(arg_16_0)
	local var_16_0 = arg_16_0.summonCfgList[arg_16_0.selectIndex]

	arg_16_0._txtName.text = var_16_0.name

	local var_16_1 = Activity191Config.instance:getRelationCo(var_16_0.relation)

	arg_16_0._txtTag.text = var_16_1.name

	Activity191Helper.setFetterIcon(arg_16_0._imageTag, var_16_1.icon)
	arg_16_0._simageBoss:LoadImage(ResUrl.getAct191SingleBg(string.format("boss/%s", var_16_0.icon)))
	UISpriteSetMgr.instance:setCommonSprite(arg_16_0._imageCareer, "lssx_" .. var_16_0.career)

	if var_16_0.summonType == Activity191Enum.SummonType.Boss then
		local var_16_2 = lua_activity191_assist_boss.configDict[var_16_0.id]

		arg_16_0.passiveSkillIds = string.splitToNumber(var_16_2.passiveSkills, "|")
		arg_16_0.uniqueSkill = var_16_2.uniqueSkill

		local var_16_3, var_16_4 = Activity191Model.instance:getActInfo():getGameInfo():getBossAttr()

		arg_16_0._txtAttack.text = var_16_3
		arg_16_0._txtTechnic.text = var_16_4

		gohelper.setActive(arg_16_0._goAttribute2, false)
		gohelper.setActive(arg_16_0._goAttribute4, false)
		gohelper.setActive(arg_16_0._goAttribute5, false)
	elseif var_16_0.summonType == Activity191Enum.SummonType.Monster then
		local var_16_5 = lua_monster.configDict[var_16_0.monsterId]
		local var_16_6 = lua_monster_template.configDict[var_16_5.template]
		local var_16_7 = lua_monster_skill_template.configDict[var_16_5.skillTemplate]

		arg_16_0.passiveSkillIds = string.splitToNumber(var_16_7.passiveSkill, "|")
		arg_16_0.uniqueSkill = tonumber(var_16_7.uniqueSkill)
		arg_16_0._txtAttack.text = var_16_6.attack
		arg_16_0._txtHp.text = var_16_6.life
		arg_16_0._txtDef.text = var_16_6.defense
		arg_16_0._txtMDef.text = var_16_6.mdefense
		arg_16_0._txtTechnic.text = var_16_6.technic

		gohelper.setActive(arg_16_0._goAttribute2, true)
		gohelper.setActive(arg_16_0._goAttribute4, true)
		gohelper.setActive(arg_16_0._goAttribute5, true)
	end

	if next(arg_16_0.passiveSkillIds) then
		local var_16_8 = lua_skill.configDict[arg_16_0.passiveSkillIds[1]]

		if var_16_8 then
			arg_16_0._txtPassiveName.text = var_16_8.name
		end

		gohelper.setActive(arg_16_0._goPassiveSkill, true)
	else
		gohelper.setActive(arg_16_0._goPassiveSkill, false)
	end

	local var_16_9 = lua_skill.configDict[arg_16_0.uniqueSkill]

	if var_16_9 then
		arg_16_0.skillItemList[3].icon:LoadImage(ResUrl.getSkillIcon(var_16_9.icon))
	else
		logError(string.format("skillId not found : %s", arg_16_0.uniqueSkill))
	end
end

function var_0_0._onSkillCardClick(arg_17_0, arg_17_1)
	if arg_17_1 == 3 then
		local var_17_0 = arg_17_0.summonCfgList[arg_17_0.selectIndex]
		local var_17_1 = {
			super = arg_17_1 == 3,
			skillIdList = {
				arg_17_0.uniqueSkill
			},
			monsterName = var_17_0.name,
			skillIndex = arg_17_1
		}

		ViewMgr.instance:openView(ViewName.SkillTipView, var_17_1)
	end
end

function var_0_0.onClickHyperLink(arg_18_0, arg_18_1)
	local var_18_0 = Vector2.New(40, 0)

	CommonBuffTipController:openCommonTipViewWithCustomPos(arg_18_1, var_18_0)
end

return var_0_0
