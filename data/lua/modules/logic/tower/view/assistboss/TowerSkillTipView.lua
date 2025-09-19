module("modules.logic.tower.view.assistboss.TowerSkillTipView", package.seeall)

local var_0_0 = class("TowerSkillTipView", BaseView)

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
end

function var_0_0._refreshArrow(arg_5_0)
	if recthelper.getHeight(arg_5_0._goskilltipScrollviewContent.transform) > recthelper.getHeight(arg_5_0._scrollskilltipScrollview.transform) and arg_5_0._scrollskilltipScrollview.verticalNormalizedPosition > 0.01 then
		gohelper.setActive(arg_5_0._goarrow, true)
	else
		gohelper.setActive(arg_5_0._goarrow, false)
	end
end

function var_0_0._setNewSkills(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._curSkillLevel = arg_6_0._curSkillLevel or nil
	arg_6_0._skillIdList = arg_6_1
	arg_6_0._super = arg_6_2

	gohelper.setActive(arg_6_0._newskilltips[1], not arg_6_2)

	if not arg_6_2 then
		-- block empty
	else
		local var_6_0 = arg_6_0.viewParam.userSkillId

		if var_6_0 then
			arg_6_0.curSuperSkillItemId = var_6_0
		end

		arg_6_0:createAndRefreshSuperSkillItem()
	end

	if arg_6_0.viewName == ViewName.FightFocusView then
		if ViewMgr.instance:isOpen(ViewName.FightFocusView) then
			transformhelper.setLocalPosXY(arg_6_0._gonewskilltip.transform, 270, -24.3)
		else
			transformhelper.setLocalPosXY(arg_6_0._gonewskilltip.transform, 185.12, 49.85)
		end
	else
		transformhelper.setLocalPosXY(arg_6_0._gonewskilltip.transform, 0.69, -0.54)
	end
end

function var_0_0._refreshSkill(arg_7_0, arg_7_1)
	if not arg_7_0._skillIdList[arg_7_1] then
		arg_7_1 = 1
	end

	arg_7_0._curSkillLevel = arg_7_1

	for iter_7_0 = 1, 3 do
		gohelper.setActive(arg_7_0._newskillitems[iter_7_0].selectframe, iter_7_0 == arg_7_1)
		gohelper.setActive(arg_7_0._newskillitems[iter_7_0].selectarrow, iter_7_0 == arg_7_1)
	end

	local var_7_0 = lua_skill.configDict[tonumber(arg_7_0._skillIdList[arg_7_1])]

	if var_7_0 then
		arg_7_0._newskillname.text = var_7_0.name
		arg_7_0._newskilldesc.text = SkillHelper.getSkillDesc(arg_7_0.monsterName, var_7_0)

		arg_7_0._fixTmpBreakLine:refreshTmpContent(arg_7_0._newskilldesc)
		gohelper.setActive(arg_7_0._gostoryDesc, not string.nilorempty(var_7_0.desc_art))

		arg_7_0._txtstory.text = var_7_0.desc_art
		arg_7_0._scrollskilltipScrollview.verticalNormalizedPosition = 1

		arg_7_0:_refreshSkillSpecial(var_7_0)
	else
		logError("找不到技能: " .. tostring(arg_7_0._skillIdList[arg_7_1]))
	end
end

function var_0_0._refreshSkillSpecial(arg_8_0, arg_8_1)
	local var_8_0 = {}

	if arg_8_1.battleTag and arg_8_1.battleTag ~= "" then
		var_8_0 = string.split(arg_8_1.battleTag, "#")

		for iter_8_0 = 1, #var_8_0 do
			local var_8_1 = arg_8_0._skillTagGOs[iter_8_0]

			if not var_8_1 then
				var_8_1 = gohelper.cloneInPlace(arg_8_0._gospecialitem, "item" .. iter_8_0)

				table.insert(arg_8_0._skillTagGOs, var_8_1)
			end

			local var_8_2 = gohelper.findChildText(var_8_1, "name")
			local var_8_3 = HeroConfig.instance:getBattleTagConfigCO(var_8_0[iter_8_0])

			if var_8_3 then
				var_8_2.text = var_8_3.tagName
			else
				logError("找不到技能BattleTag: " .. tostring(var_8_0[iter_8_0]))
			end

			gohelper.setActive(var_8_1, true)
		end
	end

	for iter_8_1 = #var_8_0 + 1, #arg_8_0._skillTagGOs do
		gohelper.setActive(arg_8_0._skillTagGOs[iter_8_1], false)
	end

	gohelper.setActive(arg_8_0._goline, false)

	local var_8_4 = FightConfig.instance:getSkillEffectDesc(arg_8_0.monsterName, arg_8_1)
	local var_8_5 = HeroSkillModel.instance:getEffectTagIDsFromDescRecursion(var_8_4)

	for iter_8_2 = #var_8_5, 1, -1 do
		local var_8_6 = tonumber(var_8_5[iter_8_2])
		local var_8_7 = SkillConfig.instance:getSkillEffectDescCo(var_8_6)

		if var_8_7 then
			if not SkillHelper.canShowTag(var_8_7) then
				table.remove(var_8_5, iter_8_2)
			end
		else
			logError("找不到技能eff_desc: " .. tostring(var_8_6))
		end
	end

	local var_8_8 = 1

	for iter_8_3 = 1, #var_8_5 do
		local var_8_9 = tonumber(var_8_5[iter_8_3])
		local var_8_10 = SkillConfig.instance:getSkillEffectDescCo(var_8_9)

		if var_8_10.isSpecialCharacter == 1 then
			gohelper.setActive(arg_8_0._goline, true)

			local var_8_11 = arg_8_0._skillEffectGOs[var_8_8]

			if not var_8_11 then
				var_8_11 = gohelper.cloneInPlace(arg_8_0._goskillspecialitem, "item" .. var_8_8)

				table.insert(arg_8_0._skillEffectGOs, var_8_11)
			end

			local var_8_12 = gohelper.findChildImage(var_8_11, "titlebg/bg")
			local var_8_13 = gohelper.findChildText(var_8_11, "titlebg/bg/name")
			local var_8_14 = gohelper.findChildText(var_8_11, "desc")

			SkillHelper.addHyperLinkClick(var_8_14, arg_8_0._onHyperLinkClick, arg_8_0)

			local var_8_15 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_14.gameObject, FixTmpBreakLine)

			if var_8_10 then
				SLFramework.UGUI.GuiHelper.SetColor(var_8_12:GetComponent("Image"), var_0_0.skillTypeColor[var_8_10.color])

				var_8_13.text = SkillHelper.removeRichTag(var_8_10.name)
				var_8_14.text = SkillHelper.getSkillDesc(arg_8_0.monsterName, var_8_10)

				var_8_15:refreshTmpContent(var_8_14)
			else
				logError("找不到技能eff_desc: " .. tostring(var_8_9))
			end

			gohelper.setActive(var_8_11, true)

			var_8_8 = var_8_8 + 1
		end
	end

	for iter_8_4 = var_8_8, #arg_8_0._skillEffectGOs do
		gohelper.setActive(arg_8_0._skillEffectGOs[iter_8_4], false)
	end

	arg_8_0:_refreshArrow()
end

function var_0_0._onHyperLinkClick(arg_9_0, arg_9_1, arg_9_2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(arg_9_1), CommonBuffTipEnum.Anchor[arg_9_0.viewName], CommonBuffTipEnum.Pivot.Right)
end

function var_0_0.onUpdateParam(arg_10_0)
	arg_10_0:initView()
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:initView()
end

function var_0_0.initView(arg_12_0)
	local var_12_0 = arg_12_0.viewParam

	arg_12_0.srcSkillIdList = var_12_0.skillIdList
	arg_12_0.isSuper = var_12_0.super
	arg_12_0.isCharacter = true

	arg_12_0:updateMonsterName()
	arg_12_0:_setNewSkills(arg_12_0.srcSkillIdList, arg_12_0.isSuper, arg_12_0.isCharacter)

	local var_12_1 = var_12_0 and var_12_0.anchorX

	if var_12_1 then
		recthelper.setAnchorX(arg_12_0.viewGO.transform, var_12_1)
	end
end

function var_0_0.updateMonsterName(arg_13_0)
	arg_13_0.monsterName = arg_13_0.viewParam.monsterName

	if not arg_13_0.monsterName then
		logError("TowerSkillTipView 缺少 monsterName 参数")

		arg_13_0.monsterName = ""
	end
end

function var_0_0.showInfo(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if not arg_14_0._viewInitialized then
		return
	end

	arg_14_0.entityMo = FightDataHelper.entityMgr:getById(arg_14_3)
	arg_14_0.monsterName = FightConfig.instance:getEntityName(arg_14_3)
	arg_14_0.entitySkillIndex = arg_14_1.skillIndex

	if string.nilorempty(arg_14_0.monsterName) then
		logError("TowerSkillTipView monsterName 为 nil, entityId : " .. tostring(arg_14_3))

		arg_14_0.monsterName = ""
	end

	arg_14_0.srcSkillIdList = arg_14_1.skillIdList
	arg_14_0.isSuper = arg_14_1.super
	arg_14_0.isCharacter = arg_14_2

	gohelper.setActive(arg_14_0._gonewskilltip, true)
	arg_14_0:_setNewSkills(arg_14_0.srcSkillIdList, arg_14_0.isSuper, arg_14_0.isCharacter)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Tipsopen)
end

function var_0_0.hideInfo(arg_15_0)
	if not arg_15_0._viewInitialized then
		return
	end

	gohelper.setActive(arg_15_0._gonewskilltip, false)
end

function var_0_0.createAndRefreshSuperSkillItem(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0._skillIdList) do
		local var_16_0 = arg_16_0.superSkillItemList[iter_16_0]

		if not var_16_0 then
			var_16_0 = {
				id = iter_16_1,
				index = iter_16_0,
				go = gohelper.clone(arg_16_0._goSuperItem, arg_16_0._goSuperContent, iter_16_1)
			}
			var_16_0.icon = gohelper.findChildSingleImage(var_16_0.go, "imgIcon")
			var_16_0.tag = gohelper.findChildSingleImage(var_16_0.go, "tag/tagIcon")
			var_16_0.aggrandizement = gohelper.findChild(var_16_0.go, "aggrandizement")
			var_16_0.backbg = gohelper.findChild(var_16_0.go, "backbg")
			var_16_0.goSelect = gohelper.findChild(var_16_0.go, "go_select")
			var_16_0.btnClick = gohelper.findChildButtonWithAudio(var_16_0.go, "btn_click")

			var_16_0.btnClick:AddClickListener(arg_16_0.onSuperItemClick, arg_16_0, var_16_0)

			arg_16_0.superSkillItemList[iter_16_0] = var_16_0

			gohelper.setActive(var_16_0.tag, false)
			gohelper.setActive(var_16_0.backbg, false)
			gohelper.setActive(var_16_0.go, true)

			if not arg_16_0.curSuperSkillItemId then
				arg_16_0.curSuperSkillItemId = var_16_0.id
			end
		end

		local var_16_1 = lua_skill.configDict[iter_16_1]

		var_16_0.icon:LoadImage(ResUrl.getSkillIcon(var_16_1.icon))
		var_16_0.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_16_1.showTag))
		gohelper.setActive(var_16_0.aggrandizement, false)
		gohelper.setActive(var_16_0.goSelect, arg_16_0.curSuperSkillItemId == var_16_0.id)
	end

	for iter_16_2 = #arg_16_0._skillIdList + 1, #arg_16_0.superSkillItemList do
		gohelper.setActive(arg_16_0.superSkillItemList[iter_16_2].go, false)
	end

	arg_16_0:refreshDesc()
end

function var_0_0.onSuperItemClick(arg_17_0, arg_17_1)
	if arg_17_1 and arg_17_1.id == arg_17_0.curSuperSkillItemId then
		return
	end

	arg_17_0.curSuperSkillItemId = arg_17_1.id

	for iter_17_0, iter_17_1 in pairs(arg_17_0.superSkillItemList) do
		gohelper.setActive(iter_17_1.goSelect, iter_17_1.id == arg_17_0.curSuperSkillItemId)
	end

	arg_17_0:refreshDesc()
end

function var_0_0.refreshDesc(arg_18_0)
	local var_18_0 = lua_skill.configDict[arg_18_0.curSuperSkillItemId]

	if var_18_0 then
		gohelper.setActive(arg_18_0._gostoryDesc, not string.nilorempty(var_18_0.desc_art))

		arg_18_0._newskillname.text = var_18_0.name

		local var_18_1 = SkillHelper.getSkillDesc(arg_18_0.monsterName, var_18_0)

		arg_18_0._newskilldesc.text = var_18_1

		arg_18_0._fixTmpBreakLine:refreshTmpContent(arg_18_0._newskilldesc)

		arg_18_0._scrollskilltipScrollview.verticalNormalizedPosition = 1

		arg_18_0:_refreshSkillSpecial(var_18_0)
	else
		logError("找不到技能: " .. tostring(arg_18_0.curSuperSkillItemId))
	end
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0._scrollskilltipScrollview:RemoveOnValueChanged()

	for iter_19_0, iter_19_1 in pairs(arg_19_0.superSkillItemList) do
		iter_19_1.icon:UnLoadImage()
		iter_19_1.tag:UnLoadImage()
		iter_19_1.btnClick:RemoveClickListener()
	end
end

return var_0_0
