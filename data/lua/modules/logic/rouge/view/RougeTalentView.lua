module("modules.logic.rouge.view.RougeTalentView", package.seeall)

local var_0_0 = class("RougeTalentView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageTypeIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/Top/#simage_TypeIcon")
	arg_1_0._txtType = gohelper.findChildText(arg_1_0.viewGO, "Left/Top/#txt_Type")
	arg_1_0._txtLv = gohelper.findChildText(arg_1_0.viewGO, "Left/Top/#txt_Lv")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "Left/Top/#txt_Num")
	arg_1_0._imageslider = gohelper.findChildImage(arg_1_0.viewGO, "Left/Top/Slider/#image_slider")
	arg_1_0._txtDescr1 = gohelper.findChildText(arg_1_0.viewGO, "Left/Skill/#scroll_desc_overseas/viewport/Layout/#txt_Descr1")
	arg_1_0._txtDescr2 = gohelper.findChildText(arg_1_0.viewGO, "Left/Skill/#scroll_desc_overseas/viewport/Layout/#txt_Descr2")
	arg_1_0._godetail = gohelper.findChild(arg_1_0.viewGO, "Left/Card/Layout/#go_detail")
	arg_1_0._imageskillicon = gohelper.findChildImage(arg_1_0.viewGO, "Left/Card/Layout/#go_detail/#image_skillicon")
	arg_1_0._txtdec2 = gohelper.findChildText(arg_1_0.viewGO, "Left/Card/Layout/#go_detail/#txt_dec2")
	arg_1_0._goskillitem = gohelper.findChild(arg_1_0.viewGO, "Left/Card/Layout/#go_skillitem")
	arg_1_0._scrollTree = gohelper.findChildScrollRect(arg_1_0.viewGO, "Tree/#scroll_Tree")
	arg_1_0._simageTypeIcon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Tree/#scroll_Tree/Viewport/Branch/#simage_TypeIcon2")
	arg_1_0._goNormal = gohelper.findChild(arg_1_0.viewGO, "Tree/#scroll_Tree/Viewport/Branch/#go_Normal")
	arg_1_0._goSpecial = gohelper.findChild(arg_1_0.viewGO, "Tree/#scroll_Tree/Viewport/Branch/#go_Special")
	arg_1_0._goBranch = gohelper.findChild(arg_1_0.viewGO, "Tree/#scroll_Tree/Viewport/Branch/#go_Branch")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

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

function var_0_0._setBtnStatus(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	gohelper.setActive(arg_4_2, not arg_4_1)
	gohelper.setActive(arg_4_3, arg_4_1)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._imagePointGo1 = gohelper.findChild(arg_5_0._txtDescr1.gameObject, "image_Point")
	arg_5_0._imagePointGo2 = gohelper.findChild(arg_5_0._txtDescr2.gameObject, "image_Point")
	arg_5_0._imageTypeIcon = gohelper.findChildImage(arg_5_0.viewGO, "Left/Top/#simage_TypeIcon")
	arg_5_0._imageTypeIcon2 = gohelper.findChildImage(arg_5_0.viewGO, "Tree/#scroll_Tree/Viewport/Branch/#simage_TypeIcon2")
	arg_5_0._gocontent = gohelper.findChild(arg_5_0.viewGO, "Tree/#scroll_Tree/Viewport/Branch")

	gohelper.setActive(arg_5_0._godetail, false)

	arg_5_0._skillItemList = arg_5_0:getUserDataTb_()
end

function var_0_0._initIcon(arg_6_0)
	local var_6_0 = arg_6_0._rougeInfo.style
	local var_6_1 = arg_6_0._rougeInfo.season
	local var_6_2 = lua_rouge_style.configDict[var_6_1][var_6_0]
	local var_6_3 = string.format("%s_light", var_6_2.icon)

	UISpriteSetMgr.instance:setRouge2Sprite(arg_6_0._imageTypeIcon, var_6_3)
	UISpriteSetMgr.instance:setRouge2Sprite(arg_6_0._imageTypeIcon2, var_6_3)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._season = RougeConfig1.instance:season()
	arg_8_0._rougeInfo = RougeModel.instance:getRougeInfo()

	local var_8_0 = RougeModel.instance:getStyle()

	arg_8_0._styleConfig = RougeConfig1.instance:getStyleConfig(var_8_0)
	arg_8_0._txtType.text = arg_8_0._styleConfig.name
	arg_8_0._txtLv.text = string.format("Lv.%s", arg_8_0._rougeInfo.teamLevel)
	arg_8_0._txtDescr1.text = arg_8_0._styleConfig.passiveSkillDescs
	arg_8_0._txtDescr2.text = arg_8_0._styleConfig.passiveSkillDescs2

	gohelper.setActive(arg_8_0._imagePointGo1, not string.nilorempty(arg_8_0._styleConfig.passiveSkillDescs))
	gohelper.setActive(arg_8_0._imagePointGo2, not string.nilorempty(arg_8_0._styleConfig.passiveSkillDescs2))
	arg_8_0:_initLevel()

	arg_8_0._nextLevel = math.min(arg_8_0._rougeInfo.teamLevel + 1, arg_8_0._maxLevelConfig.level)

	local var_8_1 = arg_8_0._levelList[arg_8_0._nextLevel]
	local var_8_2 = arg_8_0._rougeInfo.teamExp

	arg_8_0._txtNum.text = string.format("<color=#b67a45>%s</color>/%s", var_8_2, var_8_1.exp)
	arg_8_0._imageslider.fillAmount = var_8_2 / var_8_1.exp
	arg_8_0._moveContent = true

	arg_8_0:_initTalentList()
	arg_8_0:_initSkill()
	arg_8_0:_initIcon()
	arg_8_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeTalentInfo, arg_8_0._onUpdateRougeTalentInfo, arg_8_0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, arg_8_0._onTouchScreenUp, arg_8_0)
end

function var_0_0._onTouchScreenUp(arg_9_0)
	if arg_9_0._showTips then
		arg_9_0._showTips = false

		return
	end

	gohelper.setActive(arg_9_0._godetail, false)
	arg_9_0:_refreshAllBtnStatus()
end

function var_0_0._initLevel(arg_10_0)
	arg_10_0._levelList = {}

	local var_10_0 = lua_rouge_level.configDict[arg_10_0._season]
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if var_10_1 <= iter_10_1.level then
			var_10_1 = iter_10_1.level
			arg_10_0._maxLevelConfig = iter_10_1
		end

		arg_10_0._levelList[iter_10_1.level] = iter_10_1
	end
end

function var_0_0._initTalentList(arg_11_0)
	arg_11_0._talentCompList = arg_11_0:getUserDataTb_()
	arg_11_0._groupMap = arg_11_0:getUserDataTb_()

	local var_11_0 = arg_11_0._rougeInfo.talentInfo
	local var_11_1 = RougeConfig1.instance:getConstValueByID(RougeEnum.Const.TalentCost)

	arg_11_0._costTalentPoint = tonumber(var_11_1)

	local var_11_2 = RougeConfig1.instance:getConstValueByID(RougeEnum.Const.TalentBigNode)
	local var_11_3 = string.splitToNumber(var_11_2, "#")
	local var_11_4 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_3) do
		var_11_4[iter_11_1] = true
	end

	local var_11_5 = 1
	local var_11_6

	while var_11_5 <= #var_11_0 do
		local var_11_7 = var_11_5
		local var_11_8 = var_11_5 + 1

		var_11_5 = var_11_8 + 1

		local var_11_9 = var_11_8 / 2
		local var_11_10 = var_11_0[var_11_7]
		local var_11_11 = var_11_0[var_11_8]

		if not var_11_10 or not var_11_11 then
			return
		end

		local var_11_12 = gohelper.cloneInPlace(arg_11_0._goBranch)

		gohelper.setActive(var_11_12, true)

		local var_11_13 = var_11_4[var_11_9]
		local var_11_14 = gohelper.clone(var_11_13 and arg_11_0._goSpecial or arg_11_0._goNormal, var_11_12)

		gohelper.setActive(var_11_14, true)

		local var_11_15 = var_11_14:GetComponent(typeof(UnityEngine.Animator))
		local var_11_16 = gohelper.findChild(var_11_14, "Left")
		local var_11_17 = gohelper.findChild(var_11_14, "Right")
		local var_11_18 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_16, RougeTalentItem)
		local var_11_19 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_17, RougeTalentItem)

		table.insert(arg_11_0._talentCompList, var_11_18)
		table.insert(arg_11_0._talentCompList, var_11_19)

		arg_11_0._groupMap[var_11_18] = var_11_15
		arg_11_0._groupMap[var_11_19] = var_11_15

		var_11_18:setSpecial(var_11_13)
		var_11_19:setSpecial(var_11_13)
		var_11_18:setInfo(arg_11_0, var_11_7, var_11_10, var_11_19, var_11_6)
		var_11_19:setInfo(arg_11_0, var_11_8, var_11_11, var_11_18, var_11_6)

		var_11_6 = {
			var_11_18,
			var_11_19
		}
	end

	arg_11_0:_onUpdateRougeTalentInfo()
end

function var_0_0._onUpdateRougeTalentInfo(arg_12_0)
	local var_12_0 = arg_12_0._rougeInfo.talentInfo
	local var_12_1 = arg_12_0._rougeInfo.talentPoint
	local var_12_2
	local var_12_3
	local var_12_4
	local var_12_5
	local var_12_6 = 1

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._talentCompList) do
		local var_12_7 = var_12_0[iter_12_0]

		if not var_12_4 then
			var_12_2 = var_12_7
			var_12_4 = iter_12_1
		else
			var_12_3 = var_12_7
			var_12_5 = iter_12_1
		end

		if var_12_4 and var_12_5 then
			var_12_4:updateInfo(var_12_2)
			var_12_5:updateInfo(var_12_3)
			var_12_4:updateState(var_12_1 >= arg_12_0._costTalentPoint)
			var_12_5:updateState(var_12_1 >= arg_12_0._costTalentPoint)

			if var_12_4:isRootPlayCloseAnim() or var_12_5:isRootPlayCloseAnim() then
				arg_12_0._groupMap[var_12_4]:Play("close", 0, 0)
			end

			if var_12_4:isRootPlayOpenAnim() or var_12_5:isRootPlayOpenAnim() then
				arg_12_0._groupMap[var_12_4]:Play("open", 0, 0)
			end

			if var_12_4:needCostTalentPoint() or var_12_5:needCostTalentPoint() then
				var_12_1 = var_12_1 - arg_12_0._costTalentPoint
			end

			if arg_12_0._moveContent and var_12_6 > 4 and (var_12_4:canActivated() or var_12_5:canActivated()) then
				arg_12_0._moveContent = false

				recthelper.setAnchorY(arg_12_0._gocontent.transform, (var_12_6 - 4 + 1) * 180)
			end

			var_12_4 = nil
			var_12_5 = nil
			var_12_6 = var_12_6 + 1
		end
	end
end

function var_0_0._initSkill(arg_13_0)
	local var_13_0 = RougeDLCHelper.getAllCurrentUseStyleSkills(arg_13_0._styleConfig.id)
	local var_13_1 = RougeOutsideModel.instance:config()
	local var_13_2 = {}

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_3 = arg_13_0:_getOrCreateSkillItem(iter_13_0)
		local var_13_4 = var_13_1:getSkillCo(iter_13_1.type, iter_13_1.skillId)
		local var_13_5 = var_13_4 and var_13_4.icon

		if not string.nilorempty(var_13_5) then
			UISpriteSetMgr.instance:setRouge2Sprite(var_13_3.imagenormalicon, var_13_5, true)
			UISpriteSetMgr.instance:setRouge2Sprite(var_13_3.imagselecticon, var_13_5 .. "_light", true)
		else
			logError(string.format("未配置肉鸽流派技能图标, 技能类型 = %s, 技能id = %s", iter_13_1.type, iter_13_1.skillId))
		end

		arg_13_0["_skillDesc" .. iter_13_0] = var_13_4 and var_13_4.desc
		arg_13_0["_skillIcon" .. iter_13_0] = var_13_4 and var_13_4.icon

		gohelper.setActive(var_13_3.viewGO, true)

		var_13_2[var_13_3] = true
	end

	for iter_13_2, iter_13_3 in ipairs(arg_13_0._skillItemList) do
		if not var_13_2[iter_13_3] then
			gohelper.setActive(iter_13_3.viewGO, false)
		end
	end
end

function var_0_0._getOrCreateSkillItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._skillItemList and arg_14_0._skillItemList[arg_14_1]

	if not var_14_0 then
		var_14_0 = arg_14_0:getUserDataTb_()
		var_14_0.viewGO = gohelper.cloneInPlace(arg_14_0._goskillitem, "item_" .. arg_14_1)
		var_14_0.gonormal = gohelper.findChild(var_14_0.viewGO, "go_normal")
		var_14_0.imagenormalicon = gohelper.findChildImage(var_14_0.viewGO, "go_normal/image_icon")
		var_14_0.goselect = gohelper.findChild(var_14_0.viewGO, "go_select")
		var_14_0.imagselecticon = gohelper.findChildImage(var_14_0.viewGO, "go_select/image_icon")
		var_14_0.btnclick = gohelper.findChildButtonWithAudio(var_14_0.viewGO, "btn_click")

		var_14_0.btnclick:AddClickListener(arg_14_0._btnskillOnClick, arg_14_0, arg_14_1)
		table.insert(arg_14_0._skillItemList, var_14_0)
	end

	return var_14_0
end

function var_0_0._btnskillOnClick(arg_15_0, arg_15_1)
	arg_15_0._showTips = true
	arg_15_0._txtdec2.text = arg_15_0["_skillDesc" .. arg_15_1]

	UISpriteSetMgr.instance:setRouge2Sprite(arg_15_0._imageskillicon, arg_15_0["_skillIcon" .. arg_15_1], true)
	gohelper.setActive(arg_15_0._godetail, false)
	gohelper.setActive(arg_15_0._godetail, true)
	gohelper.setAsLastSibling(arg_15_0._godetail)
	arg_15_0:_refreshAllBtnStatus(arg_15_1)
end

function var_0_0._refreshAllBtnStatus(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0._skillItemList) do
		local var_16_0 = arg_16_1 == iter_16_0

		arg_16_0:_setBtnStatus(var_16_0, iter_16_1.gonormal, iter_16_1.goselect)
	end
end

function var_0_0._removeAllSkillClickListener(arg_17_0)
	if arg_17_0._skillItemList then
		for iter_17_0, iter_17_1 in pairs(arg_17_0._skillItemList) do
			if iter_17_1.btnclick then
				iter_17_1.btnclick:RemoveClickListener()
			end
		end
	end
end

function var_0_0.setTalentCompSelected(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0._talentCompList) do
		iter_18_1:setSelected(iter_18_1 == arg_18_1)
	end
end

function var_0_0.activeTalent(arg_19_0, arg_19_1)
	arg_19_0._tmpActiveTalentId = arg_19_1 and arg_19_1._talentId

	RougeRpc.instance:sendActiveTalentRequest(arg_19_0._season, arg_19_1._index - 1, arg_19_0.activeTalentCb, arg_19_0)
end

function var_0_0.activeTalentCb(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_2 ~= 0 then
		return
	end

	RougeStatController.instance:trackUpdateTalent(arg_20_0._tmpActiveTalentId)

	arg_20_0._tmpActiveTalentId = nil
end

function var_0_0.onClose(arg_21_0)
	arg_21_0._tmpActiveTalentId = nil

	arg_21_0:_removeAllSkillClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, arg_21_0._onTouchScreenUp, arg_21_0)
end

function var_0_0.onDestroyView(arg_22_0)
	return
end

return var_0_0
