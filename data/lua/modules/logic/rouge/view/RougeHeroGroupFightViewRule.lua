module("modules.logic.rouge.view.RougeHeroGroupFightViewRule", package.seeall)

local var_0_0 = class("RougeHeroGroupFightViewRule", BaseView)

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
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeHideRuleDesc)
end

function var_0_0._btnadditionRuleOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = arg_5_0._ruleList,
		closeCb = arg_5_0._btncloseruleOnClick,
		closeCbObj = arg_5_0
	})
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeShowRuleDesc)
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._goruleitem, false)
	gohelper.setActive(arg_6_0._goruletemp, false)
	gohelper.setActive(arg_6_0._goruledesc, false)

	arg_6_0._rulesimageList = arg_6_0:getUserDataTb_()
	arg_6_0._rulesimagelineList = arg_6_0:getUserDataTb_()
	arg_6_0._simageList = arg_6_0:getUserDataTb_()
end

local var_0_1 = "#E6E6E6"
local var_0_2 = "#C86A6A"

function var_0_0._addRuleItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = gohelper.clone(arg_7_0._goruletemp, arg_7_0._gorulelist, arg_7_1.id)

	gohelper.setActive(var_7_0, true)
	table.insert(arg_7_0._cloneRuleGos, var_7_0)

	local var_7_1 = gohelper.findChildImage(var_7_0, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(var_7_1, "wz_" .. arg_7_2)

	local var_7_2 = gohelper.findChildImage(var_7_0, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_7_2, arg_7_1.icon)
	SLFramework.UGUI.GuiHelper.SetColor(var_7_2, arg_7_3 and var_0_2 or var_0_1)
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:_refreshUI()
end

function var_0_0._refreshUI(arg_9_0)
	arg_9_0._episodeId = HeroGroupModel.instance.episodeId
	arg_9_0._battleId = HeroGroupModel.instance.battleId

	local var_9_0 = DungeonConfig.instance:getEpisodeCO(arg_9_0._episodeId)
	local var_9_1 = DungeonConfig.instance:getChapterCO(var_9_0.chapterId)
	local var_9_2, var_9_3, var_9_4 = HeroGroupBalanceHelper.getBalanceLv()

	if var_9_2 then
		gohelper.setActive(arg_9_0._gobalance, true)
	else
		gohelper.setActive(arg_9_0._gobalance, false)
	end

	arg_9_0._isHardMode = var_9_1.type == DungeonEnum.ChapterType.Hard

	local var_9_5

	var_9_5 = var_9_1.type == DungeonEnum.ChapterType.WeekWalk

	if var_9_1.type == DungeonEnum.ChapterType.Normal then
		gohelper.setActive(arg_9_0._goadditionRule, false)

		return
	end

	local var_9_6 = lua_battle.configDict[arg_9_0._battleId]
	local var_9_7 = var_9_6 and var_9_6.additionRule or ""
	local var_9_8 = GameUtil.splitString2(var_9_7, true, "|", "#")

	if var_9_0.type == DungeonEnum.EpisodeType.Meilanni then
		var_9_8 = var_0_0.meilanniExcludeRules(var_9_8)
	end

	local var_9_9 = var_9_8 and #var_9_8 or 0
	local var_9_10 = arg_9_0:_addRougeSurpriseAdditionRules(var_9_8)

	if not var_9_10 or #var_9_10 == 0 then
		gohelper.setActive(arg_9_0._goadditionRule, false)

		return
	end

	arg_9_0._cloneRuleGos = arg_9_0._cloneRuleGos or arg_9_0:getUserDataTb_()

	arg_9_0:_clearRules()
	gohelper.setActive(arg_9_0._goadditionRule, true)

	arg_9_0._ruleList = var_9_10

	for iter_9_0, iter_9_1 in ipairs(var_9_10) do
		local var_9_11 = iter_9_1[1]
		local var_9_12 = iter_9_1[2]
		local var_9_13 = lua_rule.configDict[var_9_12]

		if var_9_13 then
			local var_9_14 = var_9_9 < iter_9_0

			arg_9_0:_addRuleItem(var_9_13, var_9_11, var_9_14)
		end

		if iter_9_0 == #var_9_10 then
			gohelper.setActive(arg_9_0._rulesimagelineList[iter_9_0], false)
		end
	end
end

function var_0_0._addRougeSurpriseAdditionRules(arg_10_0, arg_10_1)
	arg_10_1 = arg_10_1 or {}

	local var_10_0 = RougeMapModel.instance:getCurNode()
	local var_10_1 = var_10_0 and var_10_0.eventMo
	local var_10_2 = var_10_1 and var_10_1:getSurpriseAttackList()

	if var_10_2 then
		for iter_10_0, iter_10_1 in ipairs(var_10_2) do
			local var_10_3 = lua_rouge_surprise_attack.configDict[iter_10_1]

			if var_10_3 and not string.nilorempty(var_10_3.additionRule) then
				local var_10_4 = GameUtil.splitString2(var_10_3.additionRule, true, "|", "#")

				tabletool.addValues(arg_10_1, var_10_4)
			end
		end
	end

	return arg_10_1
end

function var_0_0._clearRules(arg_11_0)
	for iter_11_0 = #arg_11_0._cloneRuleGos, 1, -1 do
		gohelper.destroy(arg_11_0._cloneRuleGos[iter_11_0])

		arg_11_0._cloneRuleGos[iter_11_0] = nil
	end
end

function var_0_0.meilanniExcludeRules(arg_12_0)
	if not arg_12_0 or #arg_12_0 == 0 then
		return
	end

	local var_12_0 = MeilanniModel.instance:getCurMapId()
	local var_12_1 = var_12_0 and MeilanniModel.instance:getMapInfo(var_12_0)
	local var_12_2 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0) do
		local var_12_3 = iter_12_1[2]

		if var_12_1 and not var_12_1:isExcludeRule(var_12_3) then
			table.insert(var_12_2, iter_12_1)
		end
	end

	return var_12_2
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
