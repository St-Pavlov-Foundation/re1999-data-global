module("modules.logic.herogroup.view.HeroGroupFightViewRule", package.seeall)

local var_0_0 = class("HeroGroupFightViewRule", BaseView)

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
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnadditionRuleclick:RemoveClickListener()
	arg_3_0:removeEventCb(arg_3_0.viewContainer, HeroGroupEvent.SwitchBalance, arg_3_0._refreshUI, arg_3_0)
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

function var_0_0._refreshUI(arg_8_0)
	arg_8_0._episodeId = HeroGroupModel.instance.episodeId
	arg_8_0._battleId = HeroGroupModel.instance.battleId

	local var_8_0 = DungeonConfig.instance:getEpisodeCO(arg_8_0._episodeId)
	local var_8_1 = DungeonConfig.instance:getChapterCO(var_8_0.chapterId)
	local var_8_2, var_8_3, var_8_4 = HeroGroupBalanceHelper.getBalanceLv()

	if var_8_2 then
		gohelper.setActive(arg_8_0._gobalance, true)

		arg_8_0._txtBalanceRoleLv.text = HeroConfig.instance:getCommonLevelDisplay(var_8_2)
		arg_8_0._txtBalanceEquipLv.text = luaLang("level") .. var_8_4
		arg_8_0._txtBalanceTalent.text = luaLang("level") .. var_8_3
	else
		gohelper.setActive(arg_8_0._gobalance, false)
	end

	arg_8_0._isHardMode = var_8_1.type == DungeonEnum.ChapterType.Hard

	local var_8_5

	var_8_5 = var_8_1.type == DungeonEnum.ChapterType.WeekWalk

	if var_8_1.type == DungeonEnum.ChapterType.Normal then
		gohelper.setActive(arg_8_0._goadditionRule, false)

		return
	end

	local var_8_6 = lua_battle.configDict[arg_8_0._battleId]
	local var_8_7 = var_8_6 and var_8_6.additionRule or ""
	local var_8_8 = FightStrUtil.instance:getSplitString2Cache(var_8_7, true, "|", "#")

	if var_8_0.type == DungeonEnum.EpisodeType.Meilanni then
		var_8_8 = var_0_0.meilanniExcludeRules(var_8_8)
	end

	if not var_8_8 or #var_8_8 == 0 then
		gohelper.setActive(arg_8_0._goadditionRule, false)

		return
	end

	arg_8_0._cloneRuleGos = arg_8_0._cloneRuleGos or arg_8_0:getUserDataTb_()

	arg_8_0:_clearRules()

	arg_8_0._ruleList = var_8_8

	gohelper.setActive(arg_8_0._goadditionRule, true)

	for iter_8_0, iter_8_1 in ipairs(var_8_8) do
		local var_8_9 = iter_8_1[1]
		local var_8_10 = iter_8_1[2]
		local var_8_11 = lua_rule.configDict[var_8_10]

		if var_8_11 then
			arg_8_0:_addRuleItem(var_8_11, var_8_9)
		end

		if iter_8_0 == #var_8_8 then
			gohelper.setActive(arg_8_0._rulesimagelineList[iter_8_0], false)
		end
	end
end

function var_0_0._addRuleItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = gohelper.clone(arg_9_0._goruletemp, arg_9_0._gorulelist, arg_9_1.id)

	gohelper.setActive(var_9_0, true)
	table.insert(arg_9_0._cloneRuleGos, var_9_0)

	local var_9_1 = gohelper.findChildImage(var_9_0, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(var_9_1, "wz_" .. arg_9_2)

	local var_9_2 = gohelper.findChildImage(var_9_0, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_9_2, arg_9_1.icon)
end

function var_0_0._clearRules(arg_10_0)
	for iter_10_0 = #arg_10_0._cloneRuleGos, 1, -1 do
		gohelper.destroy(arg_10_0._cloneRuleGos[iter_10_0])

		arg_10_0._cloneRuleGos[iter_10_0] = nil
	end
end

function var_0_0.meilanniExcludeRules(arg_11_0)
	if not arg_11_0 or #arg_11_0 == 0 then
		return
	end

	local var_11_0 = MeilanniModel.instance:getCurMapId()
	local var_11_1 = var_11_0 and MeilanniModel.instance:getMapInfo(var_11_0)
	local var_11_2 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0) do
		local var_11_3 = iter_11_1[2]

		if var_11_1 and not var_11_1:isExcludeRule(var_11_3) then
			table.insert(var_11_2, iter_11_1)
		end
	end

	return var_11_2
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
