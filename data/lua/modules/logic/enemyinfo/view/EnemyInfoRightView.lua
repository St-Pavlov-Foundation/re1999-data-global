module("modules.logic.enemyinfo.view.EnemyInfoRightView", package.seeall)

local var_0_0 = class("EnemyInfoRightView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_right_container/#go_header/head/#simage_icon")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_0.viewGO, "#go_right_container/#go_header/head/#image_career")
	arg_1_0._gobosstag = gohelper.findChild(arg_1_0.viewGO, "#go_right_container/#go_header/head/#go_bosstag")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_right_container/#go_header/#txt_name")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "#go_right_container/#go_header/#txt_level")
	arg_1_0._txthp = gohelper.findChildText(arg_1_0.viewGO, "#go_right_container/#go_header/hp/hp_label/image_HPFrame/#txt_hp")
	arg_1_0._gomultihp = gohelper.findChild(arg_1_0.viewGO, "#go_right_container/#go_header/hp/hp_label/image_HPFrame/#go_multihp")
	arg_1_0._gomultihpitem = gohelper.findChild(arg_1_0.viewGO, "#go_right_container/#go_header/hp/hp_label/image_HPFrame/#go_multihp/#go_hpitem")
	arg_1_0._btnshowAttribute = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_right_container/#go_line1/#btn_showAttribute")
	arg_1_0._gonormalIcon = gohelper.findChild(arg_1_0.viewGO, "#go_right_container/#go_line1/#btn_showAttribute/#go_normalIcon")
	arg_1_0._goselectIcon = gohelper.findChild(arg_1_0.viewGO, "#go_right_container/#go_line1/#btn_showAttribute/#go_selectIcon")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#txt_desc")
	arg_1_0._goattribute = gohelper.findChild(arg_1_0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_attribute")
	arg_1_0._gobossspecialskill = gohelper.findChild(arg_1_0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_bossspecialskill")
	arg_1_0._goresistance = gohelper.findChild(arg_1_0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_resistance")
	arg_1_0._gopassiveskill = gohelper.findChild(arg_1_0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_passiveskill")
	arg_1_0._gopassiveskillitem = gohelper.findChild(arg_1_0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_passiveskill/#go_passiveskillitem")
	arg_1_0._gonoskill = gohelper.findChild(arg_1_0.viewGO, "#go_right_container/#go_skill_container/#go_noskill")
	arg_1_0._goskill = gohelper.findChild(arg_1_0.viewGO, "#go_right_container/#go_skill_container/#go_skill")
	arg_1_0._gosuperitem = gohelper.findChild(arg_1_0.viewGO, "#go_right_container/#go_skill_container/#go_skill/card/scrollview/viewport/content/supers/#go_superitem")
	arg_1_0._goskillitem = gohelper.findChild(arg_1_0.viewGO, "#go_right_container/#go_skill_container/#go_skill/card/scrollview/viewport/content/skills/#go_skillitem")
	arg_1_0._gopassivedescitempool = gohelper.findChild(arg_1_0.viewGO, "#go_right_container/#go_passivedescitem_pool")
	arg_1_0._gopassivedescitem = gohelper.findChild(arg_1_0.viewGO, "#go_right_container/#go_passivedescitem_pool/#go_descitem")
	arg_1_0._gobufftipitem = gohelper.findChild(arg_1_0.viewGO, "#go_tip_container/#go_bufftip/#scroll_buff/viewport/content/#go_buffitem")
	arg_1_0._gomultistage = gohelper.findChild(arg_1_0.viewGO, "#go_right_container/#go_header/#go_multi_stage")
	arg_1_0._gostageitem = gohelper.findChild(arg_1_0.viewGO, "#go_right_container/#go_header/#go_multi_stage/#go_stage_item")
	arg_1_0._btnstress = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#go_right_container/#go_header/#btn_stress")
	arg_1_0._gostress = arg_1_0._btnstress.gameObject

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnshowAttribute:AddClickListener(arg_2_0._btnshowAttributeOnClick, arg_2_0)
	arg_2_0._btnstress:AddClickListener(arg_2_0.onClickStress, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnshowAttribute:RemoveClickListener()
	arg_3_0._btnstress:RemoveClickListener()
end

var_0_0.AttrIdList = {
	CharacterEnum.AttrId.Attack,
	CharacterEnum.AttrId.Technic,
	CharacterEnum.AttrId.Defense,
	CharacterEnum.AttrId.Mdefense
}

function var_0_0.onClickStress(arg_4_0)
	StressTipController.instance:openMonsterStressTip(arg_4_0.monsterConfig)
end

function var_0_0._btnshowAttributeOnClick(arg_5_0)
	arg_5_0.isShowAttributeInfo = not arg_5_0.isShowAttributeInfo

	arg_5_0:refreshAttributeAndDescVisible()
end

function var_0_0.onClickBossSpecialSkill(arg_6_0)
	if not arg_6_0.isBoss then
		return
	end

	local var_6_0 = arg_6_0.specialSkillItemList[arg_6_0.useBossSpecialSkillCount].go:GetComponent(gohelper.Type_Transform)
	local var_6_1 = CameraMgr.instance:getUICamera()
	local var_6_2, var_6_3 = recthelper.worldPosToAnchorPos2(var_6_0.position, arg_6_0.tipContainerRectTr, var_6_1, var_6_1)

	recthelper.setAnchor(arg_6_0.buffTipRectTr, var_6_2 + EnemyInfoEnum.BuffTipOffset.x, var_6_3 + EnemyInfoEnum.BuffTipOffset.y)
	EnemyInfoController.instance:dispatchEvent(EnemyInfoEvent.ShowTip, EnemyInfoEnum.Tip.BuffTip)
end

function var_0_0.onClickSkillItem(arg_7_0, arg_7_1)
	arg_7_0.tipViewParam = arg_7_0.tipViewParam or {}
	arg_7_0.tipViewParam.super = arg_7_1.super
	arg_7_0.tipViewParam.skillIdList = arg_7_1.skillIdList
	arg_7_0.tipViewParam.monsterName = FightConfig.instance:getMonsterName(arg_7_0.monsterConfig)

	ViewMgr.instance:openView(ViewName.SkillTipView3, arg_7_0.tipViewParam)
end

function var_0_0.onClickStageItem(arg_8_0, arg_8_1)
	if arg_8_0.monsterId == arg_8_1.monsterId then
		return
	end

	arg_8_0.monsterId = arg_8_1.monsterId
	arg_8_0.monsterConfig = lua_monster.configDict[arg_8_0.monsterId]
	arg_8_0.skinConfig = FightConfig.instance:getSkinCO(arg_8_0.monsterConfig.skinId)

	arg_8_0:refreshUI()
end

function var_0_0.initAttributeItemList(arg_9_0)
	arg_9_0.attributeItemList = {}

	for iter_9_0 = 1, 4 do
		local var_9_0 = arg_9_0:getUserDataTb_()

		var_9_0.go = gohelper.findChild(arg_9_0._goattribute, "attribute" .. iter_9_0)
		var_9_0.icon = gohelper.findChildImage(var_9_0.go, "icon")
		var_9_0.name = gohelper.findChildText(var_9_0.go, "name")
		var_9_0.rate = gohelper.findChildImage(var_9_0.go, "rate")

		table.insert(arg_9_0.attributeItemList, var_9_0)
	end
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0.rectTrRight = gohelper.findChild(arg_10_0.viewGO, "#go_right_container"):GetComponent(gohelper.Type_RectTransform)
	arg_10_0.rectTrViewGo = arg_10_0.viewGO:GetComponent(gohelper.Type_RectTransform)
	arg_10_0._gEnemyDesc = arg_10_0._txtdesc.gameObject
	arg_10_0.isShowAttributeInfo = false
	arg_10_0.tipContainerRectTr = gohelper.findChildComponent(arg_10_0.viewGO, "#go_tip_container", gohelper.Type_RectTransform)
	arg_10_0.buffTipRectTr = gohelper.findChildComponent(arg_10_0.viewGO, "#go_tip_container/#go_bufftip", gohelper.Type_RectTransform)
	arg_10_0.specialSkillItemList = {}
	arg_10_0.goBossSpecialSkillItem = gohelper.findChild(arg_10_0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_bossspecialskill/item")
	arg_10_0.scrollEnemyInfo = gohelper.findChildScrollRect(arg_10_0.viewGO, "#go_right_container/#scroll_enemyinfo")

	gohelper.setActive(arg_10_0.goBossSpecialSkillItem, false)
	gohelper.setActive(arg_10_0._gosuperitem, false)
	gohelper.setActive(arg_10_0._goskillitem, false)
	gohelper.setActive(arg_10_0._gopassiveskillitem, false)
	gohelper.setActive(arg_10_0._gobufftipitem, false)
	gohelper.setActive(arg_10_0._gostageitem, false)

	arg_10_0.bossSpecialClick = gohelper.getClickWithDefaultAudio(arg_10_0._gobossspecialskill)

	arg_10_0.bossSpecialClick:AddClickListener(arg_10_0.onClickBossSpecialSkill, arg_10_0)

	arg_10_0.passiveSkillItemList = {}
	arg_10_0.passiveDescItemPool = {}
	arg_10_0.passiveDescItemList = {}
	arg_10_0.trPassiveDescItemPool = arg_10_0._gopassivedescitempool:GetComponent(gohelper.Type_Transform)

	gohelper.setActive(arg_10_0._gopassivedescitempool, false)

	arg_10_0.smallSkillItemList = {}
	arg_10_0.superSkillItemList = {}
	arg_10_0.buffTipItemList = {}
	arg_10_0.stageItemList = {}
	arg_10_0.multiHpGoList = arg_10_0:getUserDataTb_()

	table.insert(arg_10_0.multiHpGoList, arg_10_0._gomultihpitem)
	arg_10_0:initAttributeItemList()
	arg_10_0:addEventCb(EnemyInfoController.instance, EnemyInfoEvent.SelectMonsterChange, arg_10_0.onSelectMonsterChange, arg_10_0)

	local var_10_0 = DungeonModel.instance.curSendChapterId

	if var_10_0 then
		local var_10_1 = DungeonConfig.instance:getChapterCO(var_10_0)

		arg_10_0.isSimple = var_10_1 and var_10_1.type == DungeonEnum.ChapterType.Simple
	end

	arg_10_0.resistanceComp = FightEntityResistanceComp.New(arg_10_0._goresistance, arg_10_0.viewContainer)

	arg_10_0.resistanceComp:onInitView()
	arg_10_0.resistanceComp:setParent(arg_10_0.scrollEnemyInfo.gameObject)

	arg_10_0.anim = arg_10_0.viewGO:GetComponent(gohelper.Type_Animator)
end

function var_0_0.onSelectMonsterChange(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return
	end

	local var_11_0 = false
	local var_11_1 = arg_11_1.enemyIndex

	if arg_11_0.enemyIndex ~= var_11_1 then
		if arg_11_0.enemyIndex then
			var_11_0 = true

			arg_11_0.anim:Play("switch", 0, 0)
		end

		arg_11_0.enemyIndex = var_11_1
	end

	local var_11_2 = arg_11_1.monsterId

	if arg_11_0.monsterId == var_11_2 then
		return
	end

	arg_11_0.monsterId = var_11_2
	arg_11_0.isBoss = arg_11_1.isBoss
	arg_11_0.monsterConfig = lua_monster.configDict[arg_11_0.monsterId]
	arg_11_0.skinConfig = FightConfig.instance:getSkinCO(arg_11_0.monsterConfig.skinId)

	if var_11_0 then
		TaskDispatcher.runDelay(arg_11_0.refreshUI, arg_11_0, 0.16)
	else
		arg_11_0:refreshUI()
	end
end

function var_0_0.refreshUI(arg_12_0)
	arg_12_0:refreshAttributeAndDescVisible()
	arg_12_0:refreshHeader()
	arg_12_0:refreshDesc()
	arg_12_0:refreshAttribute()
	arg_12_0:refreshBossSpecialSkill()
	arg_12_0:refreshResistance()
	arg_12_0:refreshPassiveSkill()
	arg_12_0:refreshSkill()
end

function var_0_0.refreshAttributeAndDescVisible(arg_13_0)
	gohelper.setActive(arg_13_0._gonormalIcon, not arg_13_0.isShowAttributeInfo)
	gohelper.setActive(arg_13_0._gEnemyDesc, not arg_13_0.isShowAttributeInfo)
	gohelper.setActive(arg_13_0._goselectIcon, arg_13_0.isShowAttributeInfo)
	gohelper.setActive(arg_13_0._goattribute, arg_13_0.isShowAttributeInfo)

	arg_13_0.scrollEnemyInfo.verticalNormalizedPosition = 1
end

function var_0_0.refreshHeader(arg_14_0)
	local var_14_0 = arg_14_0.monsterConfig
	local var_14_1 = arg_14_0.skinConfig

	gohelper.getSingleImage(arg_14_0._imageicon.gameObject):LoadImage(ResUrl.monsterHeadIcon(var_14_1.headIcon))
	IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(var_14_0.heartVariantId), arg_14_0._imageicon)
	gohelper.setActive(arg_14_0._gobosstag, arg_14_0.isBoss)
	UISpriteSetMgr.instance:setEnemyInfoSprite(arg_14_0._imagecareer, "sxy_" .. var_14_0.career)

	local var_14_2 = arg_14_0.isSimple and "levelEasy" or "level"

	arg_14_0._txtlevel.text = HeroConfig.instance:getLevelDisplayVariant(var_14_0[var_14_2])

	gohelper.setActive(arg_14_0._txtlevel, arg_14_0.viewParam.tabEnum ~= EnemyInfoEnum.TabEnum.Act191)

	arg_14_0._txtname.text = FightConfig.instance:getMonsterName(var_14_0)

	if arg_14_0.viewParam.tabEnum == EnemyInfoEnum.TabEnum.Rouge then
		local var_14_3 = arg_14_0.viewParam.hpFixRate
		local var_14_4 = CharacterDataConfig.instance:getMonsterHp(var_14_0.id, arg_14_0.isSimple)
		local var_14_5 = tonumber(var_14_4)

		arg_14_0._txthp.text = var_14_5 and math.floor(var_14_5 * var_14_3) or var_14_4
	elseif arg_14_0.viewParam.tabEnum == EnemyInfoEnum.TabEnum.Survival then
		local var_14_6 = arg_14_0.viewParam.hpFixRate
		local var_14_7 = CharacterDataConfig.instance:getMonsterHp(var_14_0.id, arg_14_0.isSimple)
		local var_14_8 = tonumber(var_14_7)

		arg_14_0._txthp.text = var_14_8 and math.floor(var_14_8 * (1 + var_14_6)) or var_14_7
	else
		arg_14_0._txthp.text = CharacterDataConfig.instance:getMonsterHp(var_14_0.id, arg_14_0.isSimple)
	end

	arg_14_0:refreshMultiHp()
	arg_14_0:refreshMultiStage()
	arg_14_0:refreshStress()
end

function var_0_0.refreshMultiHp(arg_15_0)
	local var_15_0 = FightConfig.instance:getMultiHpListByMonsterId(arg_15_0.monsterConfig.id, arg_15_0.isSimple)

	if not var_15_0 then
		gohelper.setActive(arg_15_0._gomultihp, false)

		return
	end

	gohelper.setActive(arg_15_0._gomultihp, true)

	local var_15_1 = #var_15_0

	for iter_15_0 = 1, var_15_1 do
		local var_15_2 = arg_15_0.multiHpGoList[iter_15_0]

		if not var_15_2 then
			var_15_2 = gohelper.cloneInPlace(arg_15_0._gomultihpitem)

			table.insert(arg_15_0.multiHpGoList, var_15_2)
		end

		gohelper.setActive(var_15_2, true)
	end

	for iter_15_1 = var_15_1 + 1, #arg_15_0.multiHpGoList do
		gohelper.setActive(arg_15_0.multiHpGoList[iter_15_1], false)
	end
end

function var_0_0.refreshMultiStage(arg_16_0)
	if arg_16_0.viewParam.tabEnum ~= EnemyInfoEnum.TabEnum.BossRush then
		gohelper.setActive(arg_16_0._gomultistage, false)

		return
	end

	local var_16_0 = arg_16_0.enemyInfoMo.battleId
	local var_16_1 = lua_activity128_countboss.configDict[var_16_0]

	if not var_16_1 then
		logError("activity128_countboss config not found battle id : " .. tostring(var_16_0))
		gohelper.setActive(arg_16_0._gomultistage, false)

		return
	end

	local var_16_2 = string.splitToNumber(var_16_1.monsterId, "#")
	local var_16_3 = #var_16_2

	if var_16_3 <= 1 then
		gohelper.setActive(arg_16_0._gomultistage, false)

		return
	end

	if not tabletool.indexOf(var_16_2, arg_16_0.monsterId) then
		gohelper.setActive(arg_16_0._gomultistage, false)

		return
	end

	gohelper.setActive(arg_16_0._gomultistage, true)

	for iter_16_0, iter_16_1 in ipairs(var_16_2) do
		local var_16_4 = arg_16_0.stageItemList[iter_16_0]

		if not var_16_4 then
			var_16_4 = arg_16_0:getStageItem()

			table.insert(arg_16_0.stageItemList, var_16_4)
		end

		gohelper.setActive(var_16_4.go, true)

		var_16_4.txt.text = GameUtil.getRomanNums(iter_16_0)
		var_16_4.monsterId = iter_16_1

		local var_16_5 = iter_16_1 == arg_16_0.monsterId

		var_16_4.txt.color = var_16_5 and EnemyInfoEnum.StageColor.Select or EnemyInfoEnum.StageColor.Normal

		gohelper.setActive(var_16_4.goSelect, var_16_5)

		if var_16_5 then
			if iter_16_0 == var_16_3 then
				UISpriteSetMgr.instance:setEnemyInfoSprite(var_16_4.imageSelect, "fight_btn_grip2")
			else
				UISpriteSetMgr.instance:setEnemyInfoSprite(var_16_4.imageSelect, "fight_btn_grip1")
			end
		end
	end

	for iter_16_2 = var_16_3 + 1, #arg_16_0.stageItemList do
		gohelper.setActive(arg_16_0.stageItemList[iter_16_2].go, false)
	end
end

function var_0_0.refreshStress(arg_17_0)
	if arg_17_0.viewParam.tabEnum == EnemyInfoEnum.TabEnum.Rouge then
		local var_17_0 = RougeModel.instance:getRougeInfo()

		if not (var_17_0 and var_17_0:checkMountDlc()) then
			gohelper.setActive(arg_17_0._gostress, false)

			return
		end
	end

	local var_17_1 = lua_monster_skill_template.configDict[arg_17_0.monsterConfig.skillTemplate]
	local var_17_2 = var_17_1 and var_17_1.maxStress

	gohelper.setActive(arg_17_0._gostress, var_17_2 and var_17_2 > 0)
end

function var_0_0.getStageItem(arg_18_0)
	local var_18_0 = arg_18_0:getUserDataTb_()

	var_18_0.go = gohelper.cloneInPlace(arg_18_0._gostageitem)
	var_18_0.txt = gohelper.findChildText(var_18_0.go, "#txt_stage")
	var_18_0.imageSelect = gohelper.findChildImage(var_18_0.go, "#image_select")
	var_18_0.goSelect = gohelper.findChild(var_18_0.go, "#image_select")
	var_18_0.click = gohelper.getClickWithDefaultAudio(var_18_0.go)

	var_18_0.click:AddClickListener(arg_18_0.onClickStageItem, arg_18_0, var_18_0)

	return var_18_0
end

function var_0_0.refreshDesc(arg_19_0)
	local var_19_0 = FightConfig.instance:getNewMonsterConfig(arg_19_0.monsterConfig)

	arg_19_0._txtdesc.text = var_19_0 and arg_19_0.monsterConfig.highPriorityDes or arg_19_0.monsterConfig.des
end

function var_0_0.refreshAttribute(arg_20_0)
	local var_20_0 = lua_monster_skill_template.configDict[arg_20_0.monsterConfig.skillTemplate]
	local var_20_1 = var_20_0.template

	if string.nilorempty(var_20_1) then
		logError(string.format("怪物模板表, id ： %s, 没有配置属性倾向。", var_20_0.id))

		return
	end

	local var_20_2 = string.splitToNumber(var_20_1, "#")

	table.insert(var_20_2, 2, table.remove(var_20_2, 4))

	for iter_20_0, iter_20_1 in ipairs(var_0_0.AttrIdList) do
		local var_20_3 = arg_20_0.attributeItemList[iter_20_0]
		local var_20_4 = HeroConfig.instance:getHeroAttributeCO(iter_20_1)

		var_20_3.name.text = var_20_4.name

		UISpriteSetMgr.instance:setCommonSprite(var_20_3.icon, "icon_att_" .. var_20_4.id)
		UISpriteSetMgr.instance:setCommonSprite(var_20_3.rate, "sx_" .. var_20_2[iter_20_0], true)
	end
end

function var_0_0.recycleAllBossSpecialSkillItem(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.specialSkillItemList) do
		gohelper.setActive(iter_21_1.go, false)
	end

	arg_21_0.useBossSpecialSkillCount = 0
end

function var_0_0.getBossSpecialSkillItem(arg_22_0)
	if arg_22_0.useBossSpecialSkillCount < #arg_22_0.specialSkillItemList then
		arg_22_0.useBossSpecialSkillCount = arg_22_0.useBossSpecialSkillCount + 1

		local var_22_0 = arg_22_0.specialSkillItemList[arg_22_0.useBossSpecialSkillCount]

		gohelper.setActive(var_22_0.go, true)

		return var_22_0
	end

	arg_22_0.useBossSpecialSkillCount = arg_22_0.useBossSpecialSkillCount + 1

	local var_22_1 = arg_22_0:getUserDataTb_()

	var_22_1.go = gohelper.cloneInPlace(arg_22_0.goBossSpecialSkillItem)
	var_22_1.gotag = gohelper.findChild(var_22_1.go, "tag")
	var_22_1.txttag = gohelper.findChildText(var_22_1.go, "tag/#txt_tag")
	var_22_1.imageicon = gohelper.findChildImage(var_22_1.go, "icon")

	gohelper.setActive(var_22_1.go, true)
	table.insert(arg_22_0.specialSkillItemList, var_22_1)

	return var_22_1
end

function var_0_0.refreshBossSpecialSkill(arg_23_0)
	gohelper.setActive(arg_23_0._gobossspecialskill, arg_23_0.isBoss)

	if arg_23_0.isBoss then
		arg_23_0:recycleAllBossSpecialSkillItem()
		arg_23_0:recycleBuffTipItem()

		local var_23_0 = FightConfig.instance:getPassiveSkillsAfterUIFilter(arg_23_0.monsterConfig.id)

		for iter_23_0, iter_23_1 in ipairs(var_23_0) do
			local var_23_1 = lua_skill_specialbuff.configDict[iter_23_1]

			if var_23_1 and var_23_1.isSpecial == 1 then
				local var_23_2 = arg_23_0:getBossSpecialSkillItem()

				if string.nilorempty(var_23_1.lv) then
					gohelper.setActive(var_23_2.gotag, false)
				else
					gohelper.setActive(var_23_2.gotag, true)

					var_23_2.txttag.text = var_23_1.lv
				end

				UISpriteSetMgr.instance:setFightPassiveSprite(var_23_2.imageicon, var_23_1.icon)

				local var_23_3 = arg_23_0:getBuffTipItem()
				local var_23_4 = lua_skill.configDict[iter_23_1]

				var_23_3.name.text = var_23_4.name

				local var_23_5 = FightConfig.instance:getMonsterName(arg_23_0.monsterConfig)

				var_23_3.desc.text = SkillHelper.getSkillDesc(var_23_5, var_23_4, "#CC492F", "#485E92")

				gohelper.setActive(var_23_3.goline, true)
				UISpriteSetMgr.instance:setFightPassiveSprite(var_23_3.bufficon, var_23_1.icon)
			end
		end

		if arg_23_0.useBuffTipCount > 0 then
			local var_23_6 = arg_23_0.buffTipItemList[arg_23_0.useBuffTipCount]

			gohelper.setActive(var_23_6.goline, false)
		else
			gohelper.setActive(arg_23_0._gobossspecialskill, false)
		end
	end
end

function var_0_0.refreshResistance(arg_24_0)
	local var_24_0 = arg_24_0.monsterConfig.skillTemplate
	local var_24_1 = var_24_0 and lua_monster_skill_template.configDict[var_24_0]
	local var_24_2 = var_24_1 and var_24_1.resistance
	local var_24_3 = var_24_2 and lua_resistances_attribute.configDict[var_24_2]

	if var_24_3 then
		arg_24_0.resistanceDict = arg_24_0.resistanceDict or {}

		tabletool.clear(arg_24_0.resistanceDict)

		for iter_24_0, iter_24_1 in pairs(FightEnum.Resistance) do
			local var_24_4 = var_24_3[iter_24_0]

			if var_24_4 > 0 then
				arg_24_0.resistanceDict[iter_24_0] = var_24_4
			end
		end

		arg_24_0.resistanceComp:refresh(arg_24_0.resistanceDict)
	else
		arg_24_0.resistanceComp:refresh(nil)
	end
end

function var_0_0.refreshPassiveSkill(arg_25_0)
	arg_25_0:recycleAllPassiveSkillItem()
	arg_25_0:recycleAllPassiveDescItem()

	arg_25_0.exitsTagNameDict = arg_25_0.exitsTagNameDict or {}

	tabletool.clear(arg_25_0.exitsTagNameDict)

	local var_25_0 = FightConfig.instance:getPassiveSkillsAfterUIFilter(arg_25_0.monsterConfig.id)

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if arg_25_0.isBoss then
			local var_25_1 = lua_skill_specialbuff.configDict[iter_25_1]

			if not var_25_1 or var_25_1.isSpecial ~= 1 then
				arg_25_0:refreshOnePassiveSkill(iter_25_1)
			end
		else
			arg_25_0:refreshOnePassiveSkill(iter_25_1)
		end
	end
end

function var_0_0.refreshOnePassiveSkill(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getPassiveSkillItem()
	local var_26_1 = lua_skill.configDict[arg_26_1]

	var_26_0.name.text = var_26_1.name

	local var_26_2 = FightConfig.instance:getMonsterName(arg_26_0.monsterConfig)
	local var_26_3 = FightConfig.instance:getSkillEffectDesc(var_26_2, var_26_1)
	local var_26_4 = arg_26_0:getPassiveDescItem()

	var_26_4.tr:SetParent(var_26_0.tr)

	var_26_4.txt.text = SkillHelper.buildDesc(var_26_3)
end

function var_0_0.getPassiveSkillItem(arg_27_0)
	if arg_27_0.usePassiveSkillItemCount < #arg_27_0.passiveSkillItemList then
		arg_27_0.usePassiveSkillItemCount = arg_27_0.usePassiveSkillItemCount + 1

		local var_27_0 = arg_27_0.passiveSkillItemList[arg_27_0.usePassiveSkillItemCount]

		recthelper.setWidth(var_27_0.rectTr, arg_27_0.layoutMo.enemyInfoWidth)
		gohelper.setActive(var_27_0.go, true)

		return var_27_0
	end

	arg_27_0.usePassiveSkillItemCount = arg_27_0.usePassiveSkillItemCount + 1

	local var_27_1 = arg_27_0:getUserDataTb_()

	var_27_1.go = gohelper.cloneInPlace(arg_27_0._gopassiveskillitem)
	var_27_1.tr = var_27_1.go:GetComponent(gohelper.Type_Transform)
	var_27_1.rectTr = var_27_1.go:GetComponent(gohelper.Type_RectTransform)

	recthelper.setWidth(var_27_1.rectTr, arg_27_0.layoutMo.enemyInfoWidth)

	var_27_1.name = gohelper.findChildText(var_27_1.go, "bg/name")

	gohelper.setActive(var_27_1.go, true)
	table.insert(arg_27_0.passiveSkillItemList, var_27_1)

	return var_27_1
end

function var_0_0.recycleAllPassiveSkillItem(arg_28_0)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0.passiveSkillItemList) do
		gohelper.setActive(iter_28_1.go, false)
	end

	arg_28_0.usePassiveSkillItemCount = 0
end

function var_0_0.getPassiveDescItem(arg_29_0)
	if #arg_29_0.passiveDescItemPool > 0 then
		local var_29_0 = table.remove(arg_29_0.passiveDescItemPool)

		gohelper.setActive(var_29_0.go, true)
		recthelper.setWidth(var_29_0.rectTrTxt, arg_29_0.layoutMo.enemyInfoWidth - EnemyInfoEnum.SkillDescLeftMargin)
		table.insert(arg_29_0.passiveDescItemList, var_29_0)

		return var_29_0
	end

	local var_29_1 = arg_29_0:getUserDataTb_()

	var_29_1.go = gohelper.cloneInPlace(arg_29_0._gopassivedescitem)
	var_29_1.tr = var_29_1.go:GetComponent(gohelper.Type_Transform)
	var_29_1.txt = gohelper.findChildText(var_29_1.go, "#txt_desc")
	var_29_1.rectTrTxt = var_29_1.txt:GetComponent(gohelper.Type_RectTransform)

	recthelper.setWidth(var_29_1.rectTrTxt, arg_29_0.layoutMo.enemyInfoWidth - EnemyInfoEnum.SkillDescLeftMargin)
	gohelper.setActive(var_29_1.go, true)
	SkillHelper.addHyperLinkClick(var_29_1.txt, arg_29_0.onClickPassiveHyper, arg_29_0)
	table.insert(arg_29_0.passiveDescItemList, var_29_1)

	return var_29_1
end

var_0_0.Interval = 80

function var_0_0.onClickPassiveHyper(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = recthelper.getWidth(arg_30_0.rectTrViewGo) / 2
	local var_30_1 = recthelper.getAnchorX(arg_30_0.rectTrRight)

	arg_30_0.commonBuffTipAnchorPos = arg_30_0.commonBuffTipAnchorPos or Vector2()

	arg_30_0.commonBuffTipAnchorPos:Set(-(var_30_0 - var_30_1) + var_0_0.Interval, 269.28)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(arg_30_1), arg_30_0.commonBuffTipAnchorPos, CommonBuffTipEnum.Pivot.Right)
end

function var_0_0.recycleAllPassiveDescItem(arg_31_0)
	for iter_31_0, iter_31_1 in ipairs(arg_31_0.passiveDescItemList) do
		gohelper.setActive(iter_31_1.go, false)
		iter_31_1.tr:SetParent(arg_31_0.trPassiveDescItemPool)
		table.insert(arg_31_0.passiveDescItemPool, iter_31_1)
	end

	tabletool.clear(arg_31_0.passiveDescItemList)
end

function var_0_0.refreshSkill(arg_32_0)
	arg_32_0:refreshSmallSkill()
	arg_32_0:refreshSuperSkill()

	local var_32_0 = not string.nilorempty(arg_32_0.monsterConfig.activeSkill) or #arg_32_0.monsterConfig.uniqueSkill > 0

	gohelper.setActive(arg_32_0._gonoskill, not var_32_0)
	gohelper.setActive(arg_32_0._goskill, var_32_0)
end

function var_0_0.refreshSmallSkill(arg_33_0)
	arg_33_0:recycleAllSmallSkill()

	if string.nilorempty(arg_33_0.monsterConfig.activeSkill) then
		return
	end

	local var_33_0 = GameUtil.splitString2(arg_33_0.monsterConfig.activeSkill, true)

	for iter_33_0, iter_33_1 in ipairs(var_33_0) do
		table.remove(iter_33_1, 1)

		local var_33_1 = iter_33_1[1]
		local var_33_2 = lua_skill.configDict[var_33_1]
		local var_33_3 = arg_33_0:getSmallSkillItem()

		var_33_3.icon:LoadImage(ResUrl.getSkillIcon(var_33_2.icon))
		var_33_3.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_33_2.showTag))

		var_33_3.super = false
		var_33_3.skillIdList = iter_33_1
	end
end

function var_0_0.refreshSuperSkill(arg_34_0)
	arg_34_0:recycleAllSuperSkill()

	local var_34_0 = arg_34_0.monsterConfig.uniqueSkill

	for iter_34_0, iter_34_1 in ipairs(var_34_0) do
		local var_34_1 = arg_34_0:getSuperSkillItem()
		local var_34_2 = lua_skill.configDict[iter_34_1]

		var_34_1.icon:LoadImage(ResUrl.getSkillIcon(var_34_2.icon))
		var_34_1.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_34_2.showTag))

		var_34_1.super = true

		table.insert(var_34_1.skillIdList, iter_34_1)
	end
end

function var_0_0.recycleAllSmallSkill(arg_35_0)
	for iter_35_0, iter_35_1 in ipairs(arg_35_0.smallSkillItemList) do
		gohelper.setActive(iter_35_1.go, false)
	end

	arg_35_0.useSmallSkillItemCount = 0
end

function var_0_0.getSmallSkillItem(arg_36_0)
	if arg_36_0.useSmallSkillItemCount < #arg_36_0.smallSkillItemList then
		arg_36_0.useSmallSkillItemCount = arg_36_0.useSmallSkillItemCount + 1

		local var_36_0 = arg_36_0.smallSkillItemList[arg_36_0.useSmallSkillItemCount]

		gohelper.setActive(var_36_0.go, true)

		return var_36_0
	end

	arg_36_0.useSmallSkillItemCount = arg_36_0.useSmallSkillItemCount + 1

	local var_36_1 = arg_36_0:getUserDataTb_()

	var_36_1.go = gohelper.cloneInPlace(arg_36_0._goskillitem)
	var_36_1.icon = gohelper.findChildSingleImage(var_36_1.go, "imgIcon")
	var_36_1.tag = gohelper.findChildSingleImage(var_36_1.go, "tag/tagIcon")
	var_36_1.btn = gohelper.findChildButtonWithAudio(var_36_1.go, "bg", AudioEnum.UI.Play_UI_Activity_tips)

	var_36_1.btn:AddClickListener(arg_36_0.onClickSkillItem, arg_36_0, var_36_1)
	gohelper.setActive(var_36_1.go, true)
	table.insert(arg_36_0.smallSkillItemList, var_36_1)

	return var_36_1
end

function var_0_0.recycleAllSuperSkill(arg_37_0)
	for iter_37_0, iter_37_1 in ipairs(arg_37_0.superSkillItemList) do
		gohelper.setActive(iter_37_1.go, false)

		iter_37_1.super = nil

		tabletool.clear(iter_37_1.skillIdList)
	end

	arg_37_0.useSuperSkillItemCount = 0
end

function var_0_0.getSuperSkillItem(arg_38_0)
	if arg_38_0.useSuperSkillItemCount < #arg_38_0.superSkillItemList then
		arg_38_0.useSuperSkillItemCount = arg_38_0.useSuperSkillItemCount + 1

		local var_38_0 = arg_38_0.superSkillItemList[arg_38_0.useSuperSkillItemCount]

		gohelper.setActive(var_38_0.go, true)

		return var_38_0
	end

	arg_38_0.useSuperSkillItemCount = arg_38_0.useSuperSkillItemCount + 1

	local var_38_1 = arg_38_0:getUserDataTb_()

	var_38_1.go = gohelper.cloneInPlace(arg_38_0._gosuperitem)
	var_38_1.icon = gohelper.findChildSingleImage(var_38_1.go, "imgIcon")
	var_38_1.tag = gohelper.findChildSingleImage(var_38_1.go, "tag/tagIcon")
	var_38_1.btn = gohelper.findChildButtonWithAudio(var_38_1.go, "bg", AudioEnum.UI.Play_UI_Activity_tips)

	var_38_1.btn:AddClickListener(arg_38_0.onClickSkillItem, arg_38_0, var_38_1)

	var_38_1.skillIdList = {}

	gohelper.setActive(var_38_1.go, true)
	table.insert(arg_38_0.superSkillItemList, var_38_1)

	return var_38_1
end

function var_0_0.recycleBuffTipItem(arg_39_0)
	for iter_39_0, iter_39_1 in ipairs(arg_39_0.buffTipItemList) do
		gohelper.setActive(iter_39_1.go, false)
	end

	arg_39_0.useBuffTipCount = 0
end

function var_0_0.getBuffTipItem(arg_40_0)
	if arg_40_0.useBuffTipCount < #arg_40_0.buffTipItemList then
		arg_40_0.useBuffTipCount = arg_40_0.useBuffTipCount + 1

		local var_40_0 = arg_40_0.buffTipItemList[arg_40_0.useBuffTipCount]

		gohelper.setActive(var_40_0.go, true)
		gohelper.setActive(var_40_0.goline, true)

		return var_40_0
	end

	arg_40_0.useBuffTipCount = arg_40_0.useBuffTipCount + 1

	local var_40_1 = arg_40_0:getUserDataTb_()

	var_40_1.go = gohelper.cloneInPlace(arg_40_0._gobufftipitem)
	var_40_1.bufficon = gohelper.findChildImage(var_40_1.go, "title/simage_icon")
	var_40_1.goline = gohelper.findChild(var_40_1.go, "txt_desc/image_line")
	var_40_1.name = gohelper.findChildText(var_40_1.go, "title/txt_name")
	var_40_1.desc = gohelper.findChildText(var_40_1.go, "txt_desc")

	SkillHelper.addHyperLinkClick(var_40_1.desc, arg_40_0.onClickHyperLink, arg_40_0)
	gohelper.setActive(var_40_1.go, true)
	gohelper.setActive(var_40_1.goline, true)
	table.insert(arg_40_0.buffTipItemList, var_40_1)

	return var_40_1
end

function var_0_0.onClickHyperLink(arg_41_0, arg_41_1, arg_41_2)
	CommonBuffTipController:openCommonTipViewWithCustomPosCallback(tonumber(arg_41_1), arg_41_0.onSetScrollCallback, arg_41_0)
end

function var_0_0.onSetScrollCallback(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = recthelper.getWidth(arg_42_2)

	arg_42_2.pivot = CommonBuffTipEnum.Pivot.Left

	local var_42_1 = recthelper.getAnchorX(arg_42_0.buffTipRectTr)
	local var_42_2 = recthelper.getAnchorY(arg_42_0.buffTipRectTr)
	local var_42_3 = 10
	local var_42_4 = var_42_1 - var_42_0 - var_42_3

	recthelper.setAnchor(arg_42_2, var_42_4, var_42_2)
end

function var_0_0.onClose(arg_43_0)
	return
end

function var_0_0.onDestroyView(arg_44_0)
	arg_44_0.bossSpecialClick:RemoveClickListener()

	for iter_44_0, iter_44_1 in ipairs(arg_44_0.smallSkillItemList) do
		iter_44_1.btn:RemoveClickListener()
		iter_44_1.icon:UnLoadImage()
		iter_44_1.tag:UnLoadImage()
	end

	arg_44_0.smallSkillItemList = nil

	for iter_44_2, iter_44_3 in ipairs(arg_44_0.superSkillItemList) do
		iter_44_3.btn:RemoveClickListener()
		iter_44_3.icon:UnLoadImage()
		iter_44_3.tag:UnLoadImage()
	end

	arg_44_0.superSkillItemList = nil

	for iter_44_4, iter_44_5 in ipairs(arg_44_0.stageItemList) do
		iter_44_5.click:RemoveClickListener()
	end

	arg_44_0.resistanceComp:destroy()

	arg_44_0.resistanceComp = nil
	arg_44_0.stageItemList = nil

	TaskDispatcher.cancelTask(arg_44_0.refreshUI, arg_44_0)
end

return var_0_0
