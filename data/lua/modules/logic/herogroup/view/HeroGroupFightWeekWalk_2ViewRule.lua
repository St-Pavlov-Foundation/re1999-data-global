module("modules.logic.herogroup.view.HeroGroupFightWeekWalk_2ViewRule", package.seeall)

local var_0_0 = class("HeroGroupFightWeekWalk_2ViewRule", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goadditionRule = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule")
	arg_1_0._goruletemp = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_ruletemp")
	arg_1_0._imagetagicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_ruletemp/#image_tagicon")
	arg_1_0._gorulelist = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_rulelist")
	arg_1_0._btnadditionRuleclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_rulelist/#btn_additionRuleclick")
	arg_1_0._gobalance = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_balance")
	arg_1_0._txtBalanceRoleLv = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_balance/balancecontain/roleLvTxtbg/roleLvTxt/#txt_roleLv")
	arg_1_0._txtBalanceEquipLv = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_balance/balancecontain/equipLvTxtbg/equipLvTxt/#txt_equipLv")
	arg_1_0._txtBalanceTalent = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_balance/balancecontain/talentTxtbg/talentTxt/#txt_talent")
	arg_1_0._goruledesc = gohelper.findChild(arg_1_0.viewGO, "#go_container2/#go_ruledesc")

	gohelper.setActive(arg_1_0._goruledesc, false)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnadditionRuleclick:AddClickListener(arg_2_0._btnadditionRuleOnClick, arg_2_0)
	arg_2_0:addEventCb(arg_2_0.viewContainer, HeroGroupEvent.SwitchBalance, arg_2_0._refreshUI, arg_2_0)
	arg_2_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnBuffSetupReply, arg_2_0._refreshUI, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, arg_2_0._onModifyGroupSelectIndex, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnadditionRuleclick:RemoveClickListener()
	arg_3_0:removeEventCb(arg_3_0.viewContainer, HeroGroupEvent.SwitchBalance, arg_3_0._refreshUI, arg_3_0)
	arg_3_0:removeEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnBuffSetupReply, arg_3_0._refreshUI, arg_3_0)
	arg_3_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, arg_3_0._onModifyGroupSelectIndex, arg_3_0)
end

function var_0_0._btncloseruleOnClick(arg_4_0)
	if arg_4_0._isHardMode then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeHideRuleDesc)
	end
end

function var_0_0._btnadditionRuleOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = arg_5_0._ruleList,
		closeCb = arg_5_0._btncloseruleOnClick,
		closeCbObj = arg_5_0
	})

	if arg_5_0._isHardMode then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeShowRuleDesc)
	end
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._goruletemp, false)

	arg_6_0._rulesimageList = arg_6_0:getUserDataTb_()
	arg_6_0._rulesimagelineList = arg_6_0:getUserDataTb_()
	arg_6_0._simageList = arg_6_0:getUserDataTb_()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:_refreshUI()
end

function var_0_0._onModifyGroupSelectIndex(arg_8_0)
	local var_8_0 = arg_8_0:_getAdditionRule()

	if arg_8_0._additionRule ~= var_8_0 then
		arg_8_0:_refreshUI()
	end
end

function var_0_0._getAdditionRule(arg_9_0)
	local var_9_0 = ""
	local var_9_1 = WeekWalk_2Model.instance:getCurMapInfo()
	local var_9_2 = HeroGroupModel.instance.battleId
	local var_9_3 = var_9_1 and var_9_1:getBattleInfoByBattleId(var_9_2)
	local var_9_4 = WeekWalk_2BuffListModel.getCurHeroGroupSkillId()
	local var_9_5 = WeekWalk_2Model.instance:getInfo()
	local var_9_6 = lua_weekwalk_ver2_time.configDict[var_9_5.issueId]

	if var_9_3 then
		if var_9_3.index == WeekWalk_2Enum.BattleIndex.First then
			var_9_0 = var_9_6.ruleFront
		else
			var_9_0 = var_9_6.ruleRear
		end
	end

	if var_9_4 then
		local var_9_7 = lua_weekwalk_ver2_skill.configDict[var_9_4]

		var_9_0 = var_9_0 .. "|" .. var_9_7.rules
	end

	return var_9_0
end

function var_0_0._refreshUI(arg_10_0)
	arg_10_0._episodeId = HeroGroupModel.instance.episodeId
	arg_10_0._battleId = HeroGroupModel.instance.battleId

	local var_10_0 = DungeonConfig.instance:getEpisodeCO(arg_10_0._episodeId)
	local var_10_1 = DungeonConfig.instance:getChapterCO(var_10_0.chapterId)
	local var_10_2, var_10_3, var_10_4 = HeroGroupBalanceHelper.getBalanceLv()

	if var_10_2 then
		gohelper.setActive(arg_10_0._gobalance, true)

		arg_10_0._txtBalanceRoleLv.text = HeroConfig.instance:getCommonLevelDisplay(var_10_2)
		arg_10_0._txtBalanceEquipLv.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("common_format_level"), var_10_4)
		arg_10_0._txtBalanceTalent.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("common_format_level"), var_10_3)
	else
		gohelper.setActive(arg_10_0._gobalance, false)
	end

	arg_10_0._isHardMode = var_10_1.type == DungeonEnum.ChapterType.Hard

	local var_10_5

	var_10_5 = var_10_1.type == DungeonEnum.ChapterType.WeekWalk

	if var_10_1.type == DungeonEnum.ChapterType.Normal then
		gohelper.setActive(arg_10_0._goadditionRule, false)

		return
	end

	local var_10_6 = lua_battle.configDict[arg_10_0._battleId]
	local var_10_7 = arg_10_0:_getAdditionRule()

	arg_10_0._additionRule = var_10_7

	local var_10_8 = FightStrUtil.instance:getSplitString2Cache(var_10_7, true, "|", "#")

	if var_10_0.type == DungeonEnum.EpisodeType.Meilanni then
		var_10_8 = var_0_0.meilanniExcludeRules(var_10_8)
	end

	if not var_10_8 or #var_10_8 == 0 then
		gohelper.setActive(arg_10_0._goadditionRule, false)

		return
	end

	arg_10_0._cloneRuleGos = arg_10_0._cloneRuleGos or arg_10_0:getUserDataTb_()

	arg_10_0:_clearRules()

	arg_10_0._ruleList = var_10_8

	gohelper.setActive(arg_10_0._goadditionRule, true)

	for iter_10_0, iter_10_1 in ipairs(var_10_8) do
		local var_10_9 = iter_10_1[1]
		local var_10_10 = iter_10_1[2]
		local var_10_11 = lua_rule.configDict[var_10_10]

		if var_10_11 then
			arg_10_0:_addRuleItem(var_10_11, var_10_9)
		end

		if iter_10_0 == #var_10_8 then
			gohelper.setActive(arg_10_0._rulesimagelineList[iter_10_0], false)
		end
	end
end

function var_0_0._addRuleItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = gohelper.clone(arg_11_0._goruletemp, arg_11_0._gorulelist, arg_11_1.id)

	gohelper.setActive(var_11_0, true)
	table.insert(arg_11_0._cloneRuleGos, var_11_0)

	local var_11_1 = gohelper.findChildImage(var_11_0, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(var_11_1, "wz_" .. arg_11_2)

	local var_11_2 = gohelper.findChildImage(var_11_0, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_11_2, arg_11_1.icon)
end

function var_0_0._clearRules(arg_12_0)
	for iter_12_0 = #arg_12_0._cloneRuleGos, 1, -1 do
		gohelper.destroy(arg_12_0._cloneRuleGos[iter_12_0])

		arg_12_0._cloneRuleGos[iter_12_0] = nil
	end
end

function var_0_0.meilanniExcludeRules(arg_13_0)
	if not arg_13_0 or #arg_13_0 == 0 then
		return
	end

	local var_13_0 = MeilanniModel.instance:getCurMapId()
	local var_13_1 = var_13_0 and MeilanniModel.instance:getMapInfo(var_13_0)
	local var_13_2 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0) do
		local var_13_3 = iter_13_1[2]

		if var_13_1 and not var_13_1:isExcludeRule(var_13_3) then
			table.insert(var_13_2, iter_13_1)
		end
	end

	return var_13_2
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
