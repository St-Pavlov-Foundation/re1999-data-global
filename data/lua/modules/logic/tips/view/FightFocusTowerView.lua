module("modules.logic.tips.view.FightFocusTowerView", package.seeall)

local var_0_0 = class("FightFocusTowerView", BaseRoleStoryView)

function var_0_0.onInit(arg_1_0)
	arg_1_0.resPathList = {
		mainRes = "ui/viewres/fight/fightfocustowerview.prefab"
	}
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.anim = arg_2_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_2_0.txtLev = gohelper.findChildTextMesh(arg_2_0.viewGO, "root/left/boss/lev")
	arg_2_0.imgCareer = gohelper.findChildImage(arg_2_0.viewGO, "root/right/info/career")
	arg_2_0.txtName = gohelper.findChildTextMesh(arg_2_0.viewGO, "root/right/info/name")
	arg_2_0.btnTalent = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "root/right/btnTalent")
	arg_2_0.txtPassiveName = gohelper.findChildTextMesh(arg_2_0.viewGO, "root/right/info/passiveskill/bg/#txt_passivename")
	arg_2_0.passiveSkillItems = {}

	for iter_2_0 = 1, 3 do
		local var_2_0 = arg_2_0:getUserDataTb_()

		var_2_0.go = gohelper.findChild(arg_2_0.viewGO, string.format("root/right/info/passiveskill/#go_passiveskills/passiveskill%s", iter_2_0))
		var_2_0.goOff = gohelper.findChild(var_2_0.go, "off")
		var_2_0.goOn = gohelper.findChild(var_2_0.go, "on")
		arg_2_0.passiveSkillItems[iter_2_0] = var_2_0
	end

	arg_2_0.btnSkill = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "root/right/info/#go_skill/line/go_skills/skillicon")
	arg_2_0.skillIcon = gohelper.findChildSingleImage(arg_2_0.viewGO, "root/right/info/#go_skill/line/go_skills/skillicon/imgIcon")
	arg_2_0.skillTagIcon = gohelper.findChildSingleImage(arg_2_0.viewGO, "root/right/info/#go_skill/line/go_skills/skillicon/tagIcon")
	arg_2_0.goTagIcon = gohelper.findChild(arg_2_0.viewGO, "root/right/info/#go_skill/line/go_skills/skillicon/tagIcon")
	arg_2_0.btnPassiveskill = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "root/right/info/passiveskill/#btn_passiveskill")
	arg_2_0.goTagItem = gohelper.findChild(arg_2_0.viewGO, "root/right/info/base/scroll_tag/Viewport/Content/#txt_tag")
	arg_2_0.tagItems = {}
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:addClickCb(arg_3_0.btnSkill, arg_3_0.onBtnActiveSkillClick, arg_3_0)
	arg_3_0:addClickCb(arg_3_0.btnTalent, arg_3_0.onBtnTalentClick, arg_3_0)
	arg_3_0:addClickCb(arg_3_0.btnPassiveskill, arg_3_0.onBtnPassiveskillClick, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0:removeClickCb(arg_4_0.btnSkill)
	arg_4_0:removeClickCb(arg_4_0.btnTalent)
	arg_4_0:removeClickCb(arg_4_0.btnPassiveskill)
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

function var_0_0.onBtnPassiveskillClick(arg_6_0)
	if not arg_6_0.bossId then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossSkillTipsView, {
		bossId = arg_6_0.bossId
	})
end

function var_0_0.onBtnTalentClick(arg_7_0)
	if not arg_7_0.bossId then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerAssistBossTalentTallView, {
		bossId = arg_7_0.bossId
	})
end

function var_0_0.onShow(arg_8_0)
	arg_8_0.bossMo = TowerAssistBossModel.instance:getById(arg_8_0.bossId)
	arg_8_0.config = TowerConfig.instance:getAssistBossConfig(arg_8_0.bossId)

	arg_8_0:refreshView()
end

function var_0_0.refreshView(arg_9_0)
	local var_9_0 = arg_9_0.bossMo and arg_9_0.bossMo.trialLevel > 0 and arg_9_0.bossMo.trialLevel or arg_9_0.bossMo and arg_9_0.bossMo.level > 0 and arg_9_0.bossMo.level or 1

	arg_9_0.txtLev.text = tostring(var_9_0)
	arg_9_0.txtName.text = arg_9_0.config.name

	UISpriteSetMgr.instance:setCommonSprite(arg_9_0.imgCareer, string.format("lssx_%s", arg_9_0.config.career))

	local var_9_1 = TowerConfig.instance:getHeroGroupAddAttr(arg_9_0.bossId, 0, var_9_0)

	gohelper.setActive(arg_9_0.btnBase, #var_9_1 > 0)
	arg_9_0:refreshPassiveSkill()
	arg_9_0:refreshActiveSkill()
	arg_9_0:refreshTags()
end

function var_0_0.refreshPassiveSkill(arg_10_0)
	local var_10_0 = TowerConfig.instance:getPassiveSKills(arg_10_0.bossId)

	arg_10_0.txtPassiveName.text = arg_10_0.config.passiveSkillName

	local var_10_1 = arg_10_0.bossMo and arg_10_0.bossMo.trialLevel > 0 and arg_10_0.bossMo.trialLevel or arg_10_0.bossMo and arg_10_0.bossMo.level > 0 and arg_10_0.bossMo.level or 1

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.passiveSkillItems) do
		local var_10_2 = var_10_0[iter_10_0]

		if var_10_2 then
			gohelper.setActive(iter_10_1.go, true)
			gohelper.setActive(iter_10_1.goOn, TowerConfig.instance:isSkillActive(arg_10_0.bossId, var_10_2[1], var_10_1))
		else
			gohelper.setActive(iter_10_1.go, false)
		end
	end
end

function var_0_0.refreshActiveSkill(arg_11_0)
	local var_11_0 = GameUtil.splitString2(arg_11_0.config.activeSkills, true) or {}
	local var_11_1 = var_11_0[1]

	arg_11_0.skillIdList = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		table.insert(arg_11_0.skillIdList, iter_11_1[1])
	end

	local var_11_2 = lua_skill.configDict[var_11_1[1]]

	if not var_11_2 then
		return
	end

	arg_11_0.skillIcon:LoadImage(ResUrl.getSkillIcon(var_11_2.icon))
	arg_11_0.skillTagIcon:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_11_2.showTag))
	gohelper.setActive(arg_11_0.goTagIcon, false)
end

function var_0_0.refreshTags(arg_12_0)
	local var_12_0 = string.split(arg_12_0.config.tag, "#") or {}
	local var_12_1 = #var_12_0
	local var_12_2 = math.max(#arg_12_0.tagItems, var_12_1)

	for iter_12_0 = 1, var_12_2 do
		local var_12_3 = arg_12_0.tagItems[iter_12_0]

		if not var_12_3 then
			var_12_3 = arg_12_0:getUserDataTb_()
			var_12_3.go = gohelper.cloneInPlace(arg_12_0.goTagItem)
			var_12_3.txt = var_12_3.go:GetComponent(gohelper.Type_TextMesh)
			arg_12_0.tagItems[iter_12_0] = var_12_3
		end

		if var_12_0[iter_12_0] then
			var_12_3.txt.text = var_12_0[iter_12_0]
		end

		gohelper.setActive(var_12_3.go, var_12_0[iter_12_0] ~= nil)
	end
end

function var_0_0.onHide(arg_13_0)
	return
end

function var_0_0.show(arg_14_0, arg_14_1)
	if arg_14_0.isShow and not arg_14_1 then
		return
	end

	arg_14_0.isShow = true

	if not arg_14_0.viewGO then
		arg_14_0:_loadPrefab()

		return
	end

	gohelper.setActive(arg_14_0.viewGO, true)

	if arg_14_1 then
		arg_14_0.anim:Play("open")
	else
		arg_14_0.anim:Play("switch")
	end

	arg_14_0:onShow()
end

function var_0_0.hide(arg_15_0, arg_15_1)
	if not arg_15_0.isShow and not arg_15_1 then
		return
	end

	arg_15_0.isShow = false

	if not arg_15_0.viewGO then
		return
	end

	if arg_15_1 then
		arg_15_0.anim:Play("close")
	else
		gohelper.setActive(arg_15_0.viewGO, false)
	end

	arg_15_0:onHide()
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0.skillIcon:UnLoadImage()
	arg_16_0.skillTagIcon:UnLoadImage()
end

return var_0_0
