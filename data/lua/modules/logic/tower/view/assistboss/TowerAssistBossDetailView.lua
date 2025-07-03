module("modules.logic.tower.view.assistboss.TowerAssistBossDetailView", package.seeall)

local var_0_0 = class("TowerAssistBossDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.txtLev = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/left/boss/lev")
	arg_1_0.imgCareer = gohelper.findChildImage(arg_1_0.viewGO, "root/right/info/career")
	arg_1_0.txtName = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/right/info/name")
	arg_1_0.btnTalent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/btnTalent")
	arg_1_0.btnBossTower = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/btnBossTower")
	arg_1_0.simageBoss = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/left/boss/icon")
	arg_1_0.txtPassiveName = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/right/info/passiveskill/bg/#txt_passivename")
	arg_1_0.passiveSkillItems = {}

	for iter_1_0 = 1, 3 do
		local var_1_0 = arg_1_0:getUserDataTb_()

		var_1_0.go = gohelper.findChild(arg_1_0.viewGO, string.format("root/right/info/passiveskill/#go_passiveskills/passiveskill%s", iter_1_0))
		var_1_0.goOff = gohelper.findChild(var_1_0.go, "off")
		var_1_0.goOn = gohelper.findChild(var_1_0.go, "on")
		arg_1_0.passiveSkillItems[iter_1_0] = var_1_0
	end

	arg_1_0.goTeachSkills = gohelper.findChild(arg_1_0.viewGO, "root/right/info/passiveskill/#go_teachskills")
	arg_1_0.canvasGroupTeachSkills = arg_1_0.goTeachSkills:GetComponent(gohelper.Type_CanvasGroup)
	arg_1_0.btnSkill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/info/#go_skill/line/go_skills/skillicon")
	arg_1_0.skillIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/right/info/#go_skill/line/go_skills/skillicon/imgIcon")
	arg_1_0.skillTagIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/right/info/#go_skill/line/go_skills/skillicon/tagIcon")
	arg_1_0.goTagIcon = gohelper.findChild(arg_1_0.viewGO, "root/right/info/#go_skill/line/go_skills/skillicon/tagIcon")
	arg_1_0.txtNum = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/right/btnTalent/#txt_num")
	arg_1_0.goCanLight = gohelper.findChild(arg_1_0.viewGO, "root/right/tag")
	arg_1_0.btnPassiveskill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/info/passiveskill/#btn_passiveskill")
	arg_1_0.btnBase = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/info/base/#btn_base")
	arg_1_0.goTagItem = gohelper.findChild(arg_1_0.viewGO, "root/right/info/base/scroll_tag/Viewport/Content/#txt_tag")
	arg_1_0.tagItems = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnSkill, arg_2_0.onBtnActiveSkillClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnBase, arg_2_0.onBtnBaseClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnTalent, arg_2_0.onBtnTalentClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnBossTower, arg_2_0.onBtnBossTowerClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnPassiveskill, arg_2_0.onBtnPassiveskillClick, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.ResetTalent, arg_2_0._onResetTalent, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.ActiveTalent, arg_2_0._onActiveTalent, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerUpdate, arg_2_0._onTowerUpdate, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.RefreshTalent, arg_2_0.refreshTalent, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnSkill)
	arg_3_0:removeClickCb(arg_3_0.btnBase)
	arg_3_0:removeClickCb(arg_3_0.btnTalent)
	arg_3_0:removeClickCb(arg_3_0.btnBossTower)
	arg_3_0:removeClickCb(arg_3_0.btnPassiveskill)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.ResetTalent, arg_3_0._onResetTalent, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.ActiveTalent, arg_3_0._onActiveTalent, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerUpdate, arg_3_0._onTowerUpdate, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.RefreshTalent, arg_3_0.refreshTalent, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onBtnActiveSkillClick(arg_5_0)
	if not arg_5_0.skillIdList then
		return
	end

	local var_5_0 = {
		skillIdList = arg_5_0.skillIdList,
		monsterName = arg_5_0.config.name
	}

	var_5_0.super = true

	ViewMgr.instance:openView(ViewName.TowerSkillTipView, var_5_0)
end

function var_0_0.onBtnBaseClick(arg_6_0)
	if not arg_6_0.bossId then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossAttributeTipsView, {
		bossId = arg_6_0.bossId,
		isFromHeroGroup = arg_6_0.isFromHeroGroup
	})
end

function var_0_0.onBtnPassiveskillClick(arg_7_0)
	if not arg_7_0.bossId then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossSkillTipsView, {
		bossId = arg_7_0.bossId
	})
end

function var_0_0.onBtnTalentClick(arg_8_0)
	if not arg_8_0.bossId then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerAssistBossTalentView, {
		bossId = arg_8_0.bossId,
		isFromHeroGroup = arg_8_0.isFromHeroGroup
	})
end

function var_0_0.onBtnBossTowerClick(arg_9_0)
	TowerController.instance:openBossTowerEpisodeView(TowerEnum.TowerType.Boss, arg_9_0.config.towerId)
end

function var_0_0._onTowerUpdate(arg_10_0)
	arg_10_0:refreshView()
end

function var_0_0._onResetTalent(arg_11_0, arg_11_1)
	arg_11_0:refreshTalent()
end

function var_0_0._onActiveTalent(arg_12_0, arg_12_1)
	arg_12_0:refreshTalent()
end

function var_0_0.onUpdateParam(arg_13_0)
	arg_13_0:refreshParam()
	arg_13_0:refreshView()
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:refreshParam()
	arg_14_0:refreshView()
end

function var_0_0.refreshParam(arg_15_0)
	arg_15_0.bossId = arg_15_0.viewParam.bossId
	arg_15_0.bossMo = TowerAssistBossModel.instance:getById(arg_15_0.bossId)
	arg_15_0.config = TowerConfig.instance:getAssistBossConfig(arg_15_0.bossId)
	arg_15_0.isFromHeroGroup = arg_15_0.viewParam.isFromHeroGroup and true or false

	local var_15_0 = TowerModel.instance:getCurTowerType()
	local var_15_1 = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))

	arg_15_0.isBlanced = var_15_0 == TowerEnum.TowerType.Limited and var_15_1 > arg_15_0.bossMo.level

	if arg_15_0.isFromHeroGroup then
		local var_15_2 = TowerModel.instance:getRecordFightParam()

		if tabletool.len(var_15_2) > 0 then
			arg_15_0.isTeach = var_15_2.towerType == TowerEnum.TowerType.Boss and var_15_2.layerId == 0

			if arg_15_0.isTeach then
				local var_15_3 = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TeachBossLevel))
				local var_15_4 = TowerConfig.instance:getBossTeachConfig(var_15_2.towerId, var_15_2.difficulty)

				arg_15_0.bossMo:setTrialInfo(var_15_3, var_15_4.planId)
				arg_15_0.bossMo:refreshTalent()
			elseif arg_15_0.isBlanced then
				TowerAssistBossModel.instance:setLimitedTrialBossInfo(arg_15_0.bossMo)
			else
				arg_15_0.bossMo:setTrialInfo(0, 0)
				arg_15_0.bossMo:refreshTalent()
			end
		end
	elseif var_15_0 and var_15_0 == TowerEnum.TowerType.Limited and arg_15_0.isBlanced then
		TowerAssistBossModel.instance:setLimitedTrialBossInfo(arg_15_0.bossMo)
	else
		arg_15_0.bossMo:setTrialInfo(0, 0)
		arg_15_0.bossMo:refreshTalent()
	end
end

function var_0_0.refreshView(arg_16_0)
	local var_16_0 = arg_16_0.bossMo and arg_16_0.bossMo.trialLevel > 0 and arg_16_0.bossMo.trialLevel or arg_16_0.bossMo and arg_16_0.bossMo.level > 0 and arg_16_0.bossMo.level or 1

	arg_16_0.txtLev.text = tostring(var_16_0)
	arg_16_0.txtName.text = arg_16_0.config.name

	UISpriteSetMgr.instance:setCommonSprite(arg_16_0.imgCareer, string.format("lssx_%s", arg_16_0.config.career))
	arg_16_0.simageBoss:LoadImage(arg_16_0.config.bossPic)

	local var_16_1 = TowerModel.instance:getTowerOpenInfo(TowerEnum.TowerType.Boss, arg_16_0.config.towerId) ~= nil

	gohelper.setActive(arg_16_0.btnBossTower, var_16_1 and not arg_16_0.isFromHeroGroup)

	local var_16_2 = TowerConfig.instance:getHeroGroupAddAttr(arg_16_0.bossId, 0, var_16_0)

	gohelper.setActive(arg_16_0.btnBase, #var_16_2 > 0)
	arg_16_0:refreshPassiveSkill()
	arg_16_0:refreshActiveSkill()
	arg_16_0:refreshTeachSkill()
	arg_16_0:refreshTalent()
	arg_16_0:refreshTags()
end

function var_0_0.refreshTalent(arg_17_0)
	if arg_17_0.bossMo then
		local var_17_0, var_17_1 = arg_17_0.bossMo:getTalentActiveCount()
		local var_17_2 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towertalent_already_light"), var_17_0, var_17_0 + var_17_1)

		arg_17_0.txtNum.text = var_17_2

		gohelper.setActive(arg_17_0.goCanLight, arg_17_0.bossMo:hasTalentCanActive() and not arg_17_0.isBlanced and not arg_17_0.isTeach)
	else
		arg_17_0.txtNum.text = ""

		gohelper.setActive(arg_17_0.goCanLight, false)
	end
end

function var_0_0.refreshPassiveSkill(arg_18_0)
	local var_18_0 = TowerConfig.instance:getPassiveSKills(arg_18_0.bossId)

	arg_18_0.txtPassiveName.text = arg_18_0.config.passiveSkillName

	local var_18_1 = arg_18_0.bossMo and arg_18_0.bossMo.trialLevel > 0 and arg_18_0.bossMo.trialLevel or arg_18_0.bossMo and arg_18_0.bossMo.level or 1

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.passiveSkillItems) do
		local var_18_2 = var_18_0[iter_18_0]

		if var_18_2 then
			gohelper.setActive(iter_18_1.go, true)
			gohelper.setActive(iter_18_1.goOn, TowerConfig.instance:isSkillActive(arg_18_0.bossId, var_18_2[1], var_18_1))
		else
			gohelper.setActive(iter_18_1.go, false)
		end
	end
end

function var_0_0.refreshActiveSkill(arg_19_0)
	local var_19_0 = GameUtil.splitString2(arg_19_0.config.activeSkills, true) or {}
	local var_19_1 = var_19_0[1]

	arg_19_0.skillIdList = {}

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		table.insert(arg_19_0.skillIdList, iter_19_1[1])
	end

	local var_19_2 = lua_skill.configDict[var_19_1[1]]

	if not var_19_2 then
		return
	end

	arg_19_0.skillIcon:LoadImage(ResUrl.getSkillIcon(var_19_2.icon))
	arg_19_0.skillTagIcon:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_19_2.showTag))
	gohelper.setActive(arg_19_0.goTagIcon, false)
end

function var_0_0.refreshTags(arg_20_0)
	local var_20_0 = string.split(arg_20_0.config.tag, "#") or {}
	local var_20_1 = #var_20_0
	local var_20_2 = math.max(#arg_20_0.tagItems, var_20_1)

	for iter_20_0 = 1, var_20_2 do
		local var_20_3 = arg_20_0.tagItems[iter_20_0]

		if not var_20_3 then
			var_20_3 = arg_20_0:getUserDataTb_()
			var_20_3.go = gohelper.cloneInPlace(arg_20_0.goTagItem)
			var_20_3.txt = var_20_3.go:GetComponent(gohelper.Type_TextMesh)
			arg_20_0.tagItems[iter_20_0] = var_20_3
		end

		if var_20_0[iter_20_0] then
			var_20_3.txt.text = var_20_0[iter_20_0]
		end

		gohelper.setActive(var_20_3.go, var_20_0[iter_20_0] ~= nil)
	end
end

function var_0_0.refreshTeachSkill(arg_21_0)
	local var_21_0 = string.splitToNumber(arg_21_0.config.teachSkills, "#") or {}

	gohelper.setActive(arg_21_0.goTeachSkills, #var_21_0 > 0)

	local var_21_1 = TowerBossTeachModel.instance:isAllEpisodeFinish(arg_21_0.bossId)

	arg_21_0.canvasGroupTeachSkills.alpha = var_21_1 and 1 or 0.5
end

function var_0_0.onClose(arg_22_0)
	return
end

function var_0_0.onDestroyView(arg_23_0)
	arg_23_0.skillIcon:UnLoadImage()
	arg_23_0.skillTagIcon:UnLoadImage()
	arg_23_0.simageBoss:UnLoadImage()
end

return var_0_0
