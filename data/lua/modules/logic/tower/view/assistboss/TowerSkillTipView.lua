module("modules.logic.tower.view.assistboss.TowerSkillTipView", package.seeall)

local var_0_0 = class("TowerSkillTipView", SkillTipView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonewskilltip = gohelper.findChild(arg_1_0.viewGO, "#go_newskilltip")
	arg_1_0._gospecialitem = gohelper.findChild(arg_1_0.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content/name/special/#go_specialitem")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content/#go_line")
	arg_1_0._goskillspecialitem = gohelper.findChild(arg_1_0.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content/skillspecial/#go_skillspecialitem")
	arg_1_0._goskilltipScrollviewContent = gohelper.findChild(arg_1_0.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content")
	arg_1_0._scrollskilltipScrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_newskilltip/skilltipScrollview")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_newskilltip/bottombg/#go_arrow")
	arg_1_0._gostoryDesc = gohelper.findChild(arg_1_0.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content/#go_storyDesc")
	arg_1_0._txtstory = gohelper.findChildText(arg_1_0.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content/#go_storyDesc/#txt_story")
	arg_1_0._goSuperContent = gohelper.findChild(arg_1_0.viewGO, "#go_newskilltip/#scroll_super/Viewport/#go_superContent")
	arg_1_0._goSuperItem = gohelper.findChild(arg_1_0.viewGO, "#go_newskilltip/#scroll_super/Viewport/#go_superContent/super")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._goBuffContainer, false)
	arg_4_0._scrollskilltipScrollview:AddOnValueChanged(arg_4_0._refreshArrow, arg_4_0)

	arg_4_0.superSkillItemList = arg_4_0:getUserDataTb_()

	gohelper.setActive(arg_4_0._goSuperItem, false)

	arg_4_0._newskilltips = arg_4_0:getUserDataTb_()
	arg_4_0._newskilltips[1] = gohelper.findChild(arg_4_0._gonewskilltip, "normal")
	arg_4_0._newskilltips[2] = gohelper.findChild(arg_4_0._goSuperContent, "super")
	arg_4_0._newskillname = gohelper.findChildText(arg_4_0._goskilltipScrollviewContent, "name")
	arg_4_0._newskilldesc = gohelper.findChildText(arg_4_0._goskilltipScrollviewContent, "desc")
	arg_4_0._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._newskilldesc.gameObject, FixTmpBreakLine)

	SkillHelper.addHyperLinkClick(arg_4_0._newskilldesc, arg_4_0._onHyperLinkClick, arg_4_0)

	arg_4_0._skillTagGOs = arg_4_0:getUserDataTb_()
	arg_4_0._skillEffectGOs = arg_4_0:getUserDataTb_()

	gohelper.setActive(arg_4_0._gospecialitem, false)
	gohelper.setActive(arg_4_0._goskillspecialitem, false)

	arg_4_0._viewInitialized = true
	arg_4_0._upgradeSelectShow = false
	arg_4_0._canShowUpgradeBtn = true
end

function var_0_0._setNewSkills(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._curSkillLevel = arg_5_0._curSkillLevel or nil
	arg_5_1 = arg_5_0:_checkDestinyEffect(arg_5_1)
	arg_5_0._skillIdList = arg_5_1
	arg_5_0._super = arg_5_2

	gohelper.setActive(arg_5_0._newskilltips[1], not arg_5_2)

	if not arg_5_2 then
		local var_5_0 = #arg_5_1

		for iter_5_0 = 1, var_5_0 do
			local var_5_1 = lua_skill.configDict[arg_5_1[iter_5_0]]

			if var_5_1 then
				arg_5_0._newskillitems[iter_5_0].icon:LoadImage(ResUrl.getSkillIcon(var_5_1.icon))
				arg_5_0._newskillitems[iter_5_0].tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_5_1.showTag))
			else
				logError("找不到技能: " .. arg_5_1[iter_5_0])
			end

			gohelper.setActive(arg_5_0._newskillitems[iter_5_0].selectframe, false)
			gohelper.setActive(arg_5_0._newskillitems[iter_5_0].selectarrow, false)
			gohelper.setActive(arg_5_0._newskillitems[iter_5_0].go, true)
			gohelper.setActive(arg_5_0._newskillitems[iter_5_0].aggrandizement, arg_5_0._upgradeSelectShow)
		end

		for iter_5_1 = var_5_0 + 1, 3 do
			gohelper.setActive(arg_5_0._newskillitems[iter_5_1].go, false)
		end

		gohelper.setActive(arg_5_0._goarrow1, var_5_0 > 1)
		gohelper.setActive(arg_5_0._goarrow2, var_5_0 > 2)
		arg_5_0:_refreshSkill(arg_5_0._curSkillLevel or 1)
	else
		local var_5_2 = arg_5_0.viewParam.userSkillId

		if var_5_2 then
			arg_5_0.curSuperSkillItemId = var_5_2
		end

		arg_5_0:createAndRefreshSuperSkillItem()
	end

	if arg_5_0.viewName == ViewName.FightFocusView then
		if ViewMgr.instance:isOpen(ViewName.FightFocusView) then
			transformhelper.setLocalPosXY(arg_5_0._gonewskilltip.transform, 270, -24.3)
		else
			transformhelper.setLocalPosXY(arg_5_0._gonewskilltip.transform, 185.12, 49.85)
		end
	else
		transformhelper.setLocalPosXY(arg_5_0._gonewskilltip.transform, 0.69, -0.54)
	end
end

function var_0_0.createAndRefreshSuperSkillItem(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._skillIdList) do
		local var_6_0 = arg_6_0.superSkillItemList[iter_6_0]

		if not var_6_0 then
			var_6_0 = {
				id = iter_6_1,
				index = iter_6_0,
				go = gohelper.clone(arg_6_0._goSuperItem, arg_6_0._goSuperContent, iter_6_1)
			}
			var_6_0.icon = gohelper.findChildSingleImage(var_6_0.go, "imgIcon")
			var_6_0.tag = gohelper.findChildSingleImage(var_6_0.go, "tag/tagIcon")
			var_6_0.aggrandizement = gohelper.findChild(var_6_0.go, "aggrandizement")
			var_6_0.backbg = gohelper.findChild(var_6_0.go, "backbg")
			var_6_0.goSelect = gohelper.findChild(var_6_0.go, "go_select")
			var_6_0.btnClick = gohelper.findChildButtonWithAudio(var_6_0.go, "btn_click")

			var_6_0.btnClick:AddClickListener(arg_6_0.onSuperItemClick, arg_6_0, var_6_0)

			arg_6_0.superSkillItemList[iter_6_0] = var_6_0

			gohelper.setActive(var_6_0.tag, false)
			gohelper.setActive(var_6_0.backbg, false)
			gohelper.setActive(var_6_0.go, true)

			if not arg_6_0.curSuperSkillItemId then
				arg_6_0.curSuperSkillItemId = var_6_0.id
			end
		end

		local var_6_1 = lua_skill.configDict[iter_6_1]

		var_6_0.icon:LoadImage(ResUrl.getSkillIcon(var_6_1.icon))
		var_6_0.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_6_1.showTag))
		gohelper.setActive(var_6_0.aggrandizement, arg_6_0._upgradeSelectShow)
		gohelper.setActive(var_6_0.goSelect, arg_6_0.curSuperSkillItemId == var_6_0.id)
	end

	for iter_6_2 = #arg_6_0._skillIdList + 1, #arg_6_0.superSkillItemList do
		gohelper.setActive(arg_6_0.superSkillItemList[iter_6_2].go, false)
	end

	arg_6_0:refreshDesc()
end

function var_0_0.onSuperItemClick(arg_7_0, arg_7_1)
	if arg_7_1 and arg_7_1.id == arg_7_0.curSuperSkillItemId then
		return
	end

	arg_7_0.curSuperSkillItemId = arg_7_1.id

	for iter_7_0, iter_7_1 in pairs(arg_7_0.superSkillItemList) do
		gohelper.setActive(iter_7_1.goSelect, iter_7_1.id == arg_7_0.curSuperSkillItemId)
	end

	arg_7_0:refreshDesc()
end

function var_0_0.refreshDesc(arg_8_0)
	local var_8_0 = lua_skill.configDict[arg_8_0.curSuperSkillItemId]

	if var_8_0 then
		gohelper.setActive(arg_8_0._gostoryDesc, not string.nilorempty(var_8_0.desc_art))

		arg_8_0._newskillname.text = var_8_0.name

		local var_8_1 = SkillHelper.getSkillDesc(arg_8_0.monsterName, var_8_0)

		arg_8_0._newskilldesc.text = var_8_1

		arg_8_0._fixTmpBreakLine:refreshTmpContent(arg_8_0._newskilldesc)

		arg_8_0._scrollskilltipScrollview.verticalNormalizedPosition = 1

		arg_8_0:_refreshSkillSpecial(var_8_0)
	else
		logError("找不到技能: " .. tostring(arg_8_0.curSuperSkillItemId))
	end
end

function var_0_0.onDestroyView(arg_9_0)
	var_0_0.super.onDestroyView(arg_9_0)

	for iter_9_0, iter_9_1 in pairs(arg_9_0.superSkillItemList) do
		iter_9_1.icon:UnLoadImage()
		iter_9_1.tag:UnLoadImage()
		iter_9_1.btnClick:RemoveClickListener()
	end
end

return var_0_0
