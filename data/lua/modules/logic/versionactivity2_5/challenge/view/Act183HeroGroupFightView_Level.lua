module("modules.logic.versionactivity2_5.challenge.view.Act183HeroGroupFightView_Level", package.seeall)

local var_0_0 = class("Act183HeroGroupFightView_Level", HeroGroupFightViewLevel)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._goadditioncontain = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/challenge_additioncontain")
	arg_1_0._goadditionitem = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/challenge_additioncontain/targetList/#go_additionitem")
	arg_1_0._goadditionstar1 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/challenge_additioncontain/text/starcontainer/#go_star1")
	arg_1_0._goadditionstar2 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/challenge_additioncontain/text/starcontainer/#go_star2")
	arg_1_0._goadditionstar3 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/challenge_additioncontain/text/starcontainer/#go_star3")
	arg_1_0._gochallenge = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege")
	arg_1_0._gobaserulecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/basictxt")
	arg_1_0._gobaserules = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/basictxt/Iconlist")
	arg_1_0._gobaseruleItem = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/basictxt/Iconlist/#go_item")
	arg_1_0._goescapecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/escapetxt")
	arg_1_0._goescaperules = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/escapetxt/Iconlist")
	arg_1_0._goescaperuleitem = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/escapetxt/Iconlist/#go_item")
	arg_1_0._btnchallengetip = gohelper.findChildButton(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/title/#btn_info")
	arg_1_0._btnchallengetip = gohelper.findChildButton(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/title/#btn_info")
	arg_1_0._gochallengetips = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_challengetips")
	arg_1_0._btnclosechallengetips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#go_challengetips/#btn_closechallengetips")
	arg_1_0._gochallengetipscontent = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_challengetips/#scroll_challengetips/Viewport/Content")
	arg_1_0._gochallengetiptitle = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_challengetips/#scroll_challengetips/Viewport/Content/#go_tipitem/title")
	arg_1_0._gochallengetipitem = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_challengetips/#scroll_challengetips/Viewport/Content/#go_tipitem")
	arg_1_0._gochallengedescitem = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_challengetips/#scroll_challengetips/Viewport/Content/#go_tipitem/#txt_desc")
end

function var_0_0._editableInitView(arg_2_0)
	var_0_0.super._editableInitView(arg_2_0)

	arg_2_0._activityId = Act183Model.instance:getActivityId()
	arg_2_0._episodeId = HeroGroupModel.instance.episodeId
	arg_2_0._episodeCo = Act183Config.instance:getEpisodeCo(arg_2_0._episodeId)
	arg_2_0._episodeMo = Act183Model.instance:getEpisodeMo(arg_2_0._episodeCo.groupId, arg_2_0._episodeId)
	arg_2_0._groupEpisodeMo = Act183Model.instance:getGroupEpisodeMo(arg_2_0._episodeCo.groupId)
	arg_2_0._groupType = arg_2_0._groupEpisodeMo:getGroupType()
	arg_2_0._hardMode = arg_2_0._groupType == Act183Enum.GroupType.HardMain
	arg_2_0._conditionItemTab = arg_2_0:getUserDataTb_()
end

function var_0_0.addEvents(arg_3_0)
	var_0_0.super.addEvents(arg_3_0)
	arg_3_0._btnchallengetip:AddClickListener(arg_3_0._btnchallengetipOnClick, arg_3_0)
	arg_3_0._btnclosechallengetips:AddClickListener(arg_3_0._btnclosechallengetipsOnClick, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	var_0_0.super.removeEvents(arg_4_0)
	arg_4_0._btnchallengetip:RemoveClickListener()
	arg_4_0._btnclosechallengetips:RemoveClickListener()
end

function var_0_0._btnchallengetipOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._gochallengetips, true)
	arg_5_0:refreshChallengeTips()
end

function var_0_0._btnclosechallengetipsOnClick(arg_6_0)
	gohelper.setActive(arg_6_0._gochallengetips, false)
end

function var_0_0._refreshUI(arg_7_0)
	var_0_0.super._refreshUI(arg_7_0)
	arg_7_0:refreshChallengeRules()
	arg_7_0:refreshFightConditions()
	gohelper.setActive(arg_7_0._gohardEffect, arg_7_0._hardMode)
end

function var_0_0.refreshFightConditions(arg_8_0)
	local var_8_0 = arg_8_0._episodeMo:getConditionIds()
	local var_8_1 = var_8_0 and #var_8_0 or 0
	local var_8_2 = var_8_1 > 0

	gohelper.setActive(arg_8_0._goadditioncontain, var_8_2)

	if not var_8_2 then
		return
	end

	local var_8_3 = {}
	local var_8_4 = {}

	if var_8_0 then
		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			local var_8_5 = arg_8_0:_getOrCreateConditionItem(iter_8_0)
			local var_8_6 = arg_8_0._episodeMo:isConditionPass(iter_8_1)
			local var_8_7 = Act183Config.instance:getConditionCo(iter_8_1)

			var_8_5.txtcontent.text = var_8_7 and var_8_7.decs1 or ""

			gohelper.setActive(var_8_5.viewGO, true)
			gohelper.setActive(var_8_5.gofinish, var_8_6)
			gohelper.setActive(var_8_5.gounfinish, not var_8_6)

			var_8_4[iter_8_0] = var_8_6
			var_8_3[var_8_5] = true
		end
	end

	for iter_8_2, iter_8_3 in pairs(arg_8_0._conditionItemTab) do
		if not var_8_3[iter_8_3] then
			gohelper.setActive(iter_8_3.viewGO, false)
		end
	end

	arg_8_0:refreshFightConditionTitleStar(var_8_1, var_8_4)
end

function var_0_0.refreshFightConditionTitleStar(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0["_goadditionstar" .. arg_9_1]

	if not var_9_0 then
		return
	end

	for iter_9_0 = 1, arg_9_1 do
		local var_9_1 = gohelper.findChildImage(var_9_0, "star" .. iter_9_0)

		if not gohelper.isNil(var_9_1) then
			local var_9_2 = arg_9_2[iter_9_0]

			arg_9_0:_setStar(var_9_1, var_9_2)
		end
	end

	gohelper.setActive(var_9_0, true)
end

function var_0_0._getOrCreateConditionItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._conditionItemTab[arg_10_1]

	if not var_10_0 then
		var_10_0 = arg_10_0:getUserDataTb_()
		var_10_0.viewGO = gohelper.cloneInPlace(arg_10_0._goadditionitem, "fightcondition_" .. arg_10_1)
		var_10_0.txtcontent = gohelper.findChildText(var_10_0.viewGO, "#txt_normalcondition")
		var_10_0.gofinish = gohelper.findChild(var_10_0.viewGO, "#go_normalfinish")
		var_10_0.gounfinish = gohelper.findChild(var_10_0.viewGO, "#go_normalunfinish")
		arg_10_0._conditionItemTab[arg_10_1] = var_10_0
	end

	return var_10_0
end

function var_0_0.refreshChallengeRules(arg_11_0)
	arg_11_0._baseRuleDescList = Act183Config.instance:getEpisodeAllRuleDesc(arg_11_0._episodeId)
	arg_11_0._hasBaseRule = (arg_11_0._baseRuleDescList and #arg_11_0._baseRuleDescList or 0) > 0

	gohelper.setActive(arg_11_0._gobaserulecontainer, arg_11_0._hasBaseRule)

	if arg_11_0._hasBaseRule then
		gohelper.CreateObjList(arg_11_0, arg_11_0._refreshBaseRuleItem, arg_11_0._baseRuleDescList, arg_11_0._gobaserules, arg_11_0._gobaseruleItem)
	end

	local var_11_0 = (arg_11_0._episodeMo and arg_11_0._episodeMo:getEpisodeType()) == Act183Enum.EpisodeType.Sub

	arg_11_0._escapeRules = arg_11_0._groupEpisodeMo:getEscapeRules(arg_11_0._episodeId)

	local var_11_1 = arg_11_0._escapeRules and #arg_11_0._escapeRules > 0

	arg_11_0._canGetRule = var_11_0 and var_11_1

	gohelper.setActive(arg_11_0._goescapecontainer, arg_11_0._canGetRule)

	if arg_11_0._canGetRule then
		gohelper.CreateObjList(arg_11_0, arg_11_0._refreshEscapeRuleItem, arg_11_0._escapeRules, arg_11_0._goescaperules, arg_11_0._goescaperuleitem)
	end

	gohelper.setActive(arg_11_0._gochallenge, arg_11_0._hasBaseRule or arg_11_0._canGetRule)
end

function var_0_0._refreshBaseRuleItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = gohelper.findChildImage(arg_12_1, "icon")

	Act183Helper.setRuleIcon(arg_12_0._episodeId, arg_12_3, var_12_0)
end

function var_0_0._refreshEscapeRuleItem(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = gohelper.findChildImage(arg_13_1, "icon")
	local var_13_1 = arg_13_2.episodeId
	local var_13_2 = arg_13_2.ruleIndex

	Act183Helper.setRuleIcon(var_13_1, var_13_2, var_13_0)
end

function var_0_0.refreshChallengeTips(arg_14_0)
	if arg_14_0._initChallengeTipsDone then
		return
	end

	arg_14_0:_refreshBaseRuleTipContents()
	arg_14_0:_refreshEscapeRuleTipContents()

	arg_14_0._initChallengeTipsDone = true
end

function var_0_0._refreshBaseRuleTipContents(arg_15_0)
	if not arg_15_0._hasBaseRule then
		return
	end

	arg_15_0._gobaseruletipitem = gohelper.cloneInPlace(arg_15_0._gochallengetipitem, "baseruleitem")

	arg_15_0:_refreshTipTitle(arg_15_0._gobaseruletipitem, "p_v2a5_challenge_herogroupview_basictxt")

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._baseRuleDescList) do
		local var_15_0 = gohelper.clone(arg_15_0._gochallengedescitem, arg_15_0._gobaseruletipitem, "item_" .. iter_15_0)
		local var_15_1 = gohelper.onceAddComponent(var_15_0, gohelper.Type_TextMesh)
		local var_15_2 = gohelper.findChildImage(var_15_0, "image_icon")

		var_15_1.text = SkillHelper.buildDesc(iter_15_1)

		SkillHelper.addHyperLinkClick(var_15_1)
		Act183Helper.setRuleIcon(arg_15_0._episodeId, iter_15_0, var_15_2)
		gohelper.setActive(var_15_0, true)
	end

	gohelper.setActive(arg_15_0._gobaseruletipitem, true)
end

function var_0_0._refreshEscapeRuleTipContents(arg_16_0)
	if not arg_16_0._canGetRule then
		return
	end

	arg_16_0._goescaperuletipitem = gohelper.cloneInPlace(arg_16_0._gochallengetipitem, "escaperuleitem")

	arg_16_0:_refreshTipTitle(arg_16_0._goescaperuletipitem, "p_v2a5_challenge_herogroupview_escapetxt")

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._escapeRules) do
		local var_16_0 = gohelper.clone(arg_16_0._gochallengedescitem, arg_16_0._goescaperuletipitem, "item_" .. iter_16_0)
		local var_16_1 = gohelper.onceAddComponent(var_16_0, gohelper.Type_TextMesh)

		var_16_1.text = SkillHelper.buildDesc(iter_16_1.ruleDesc)

		SkillHelper.addHyperLinkClick(var_16_1)

		local var_16_2 = iter_16_1.episodeId
		local var_16_3 = iter_16_1.ruleIndex
		local var_16_4 = gohelper.findChildImage(var_16_0, "image_icon")

		Act183Helper.setRuleIcon(var_16_2, var_16_3, var_16_4)
		gohelper.setActive(var_16_0, true)
	end

	gohelper.setActive(arg_16_0._goescaperuletipitem, true)
end

function var_0_0._refreshTipTitle(arg_17_0, arg_17_1, arg_17_2)
	gohelper.findChildText(arg_17_1, "title/txt_name").text = luaLang(arg_17_2)
end

return var_0_0
