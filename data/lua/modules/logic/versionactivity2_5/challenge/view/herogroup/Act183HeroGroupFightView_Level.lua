module("modules.logic.versionactivity2_5.challenge.view.herogroup.Act183HeroGroupFightView_Level", package.seeall)

local var_0_0 = class("Act183HeroGroupFightView_Level", HeroGroupFightViewLevel)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._gotargetlist = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList")
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
	arg_2_0._episodeInfo = DungeonModel.instance:getEpisodeInfo(arg_2_0._episodeId)
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

function var_0_0._refreshTarget(arg_8_0)
	arg_8_0:_refreshAdvanceStaList()
end

function var_0_0._refreshAdvanceStaList(arg_9_0)
	local var_9_0 = Act183Helper.getEpisodeConditionDescList(arg_9_0._episodeId)

	arg_9_0._conditionDescNum = var_9_0 and #var_9_0 or 0
	arg_9_0._useOneStarFlag = arg_9_0._conditionDescNum > 3

	local var_9_1 = arg_9_0._useOneStarFlag and 1 or arg_9_0._conditionDescNum

	arg_9_0:_initStars(var_9_1)
	gohelper.CreateObjList(arg_9_0, arg_9_0._refreshTargetItem, var_9_0, arg_9_0._gotargetlist, arg_9_0._gonormalcondition)
end

function var_0_0._refreshTargetItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = gohelper.findChildText(arg_10_1, "#txt_normalcondition")
	local var_10_1 = gohelper.findChild(arg_10_1, "#go_normalfinish")
	local var_10_2 = gohelper.findChild(arg_10_1, "#go_normalunfinish")

	var_10_0.text = arg_10_2

	local var_10_3 = arg_10_3 <= arg_10_0._episodeInfo.star

	gohelper.setActive(var_10_1, var_10_3)
	gohelper.setActive(var_10_2, not var_10_3)
	ZProj.UGUIHelper.SetColorAlpha(var_10_0, var_10_3 and 1 or 0.63)

	if arg_10_0._useOneStarFlag then
		arg_10_0:_setStar(arg_10_0._starList[1], arg_10_0._episodeInfo.star >= arg_10_0._conditionDescNum)
	else
		arg_10_0:_setStar(arg_10_0._starList[arg_10_3], var_10_3)
	end
end

function var_0_0._initStars(arg_11_0, arg_11_1)
	if arg_11_0._starList then
		return
	end

	for iter_11_0 = 1, math.huge do
		local var_11_0 = gohelper.findChild(arg_11_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star" .. iter_11_0)

		if gohelper.isNil(var_11_0) then
			break
		end

		local var_11_1 = iter_11_0 == arg_11_1

		gohelper.setActive(var_11_0, var_11_1)

		if var_11_1 then
			arg_11_0._starList = arg_11_0:getUserDataTb_()

			for iter_11_1 = 1, arg_11_1 do
				local var_11_2 = gohelper.findChildImage(var_11_0, "star" .. iter_11_1)

				table.insert(arg_11_0._starList, var_11_2)
			end
		end
	end
end

function var_0_0.refreshFightConditions(arg_12_0)
	local var_12_0 = arg_12_0._episodeMo:getConditionIds()
	local var_12_1 = var_12_0 and #var_12_0 or 0
	local var_12_2 = var_12_1 > 0

	gohelper.setActive(arg_12_0._goadditioncontain, var_12_2)

	if not var_12_2 then
		return
	end

	local var_12_3 = {}
	local var_12_4 = {}

	if var_12_0 then
		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			local var_12_5 = arg_12_0:_getOrCreateConditionItem(iter_12_0)
			local var_12_6 = arg_12_0._episodeMo:isConditionPass(iter_12_1)
			local var_12_7 = Act183Config.instance:getConditionCo(iter_12_1)

			var_12_5.txtcontent.text = var_12_7 and var_12_7.decs1 or ""

			Act183Helper.setEpisodeConditionStar(var_12_5.imagestar, var_12_6, nil, true)
			gohelper.setActive(var_12_5.viewGO, true)

			var_12_4[iter_12_0] = var_12_6
			var_12_3[var_12_5] = true
		end
	end

	for iter_12_2, iter_12_3 in pairs(arg_12_0._conditionItemTab) do
		if not var_12_3[iter_12_3] then
			gohelper.setActive(iter_12_3.viewGO, false)
		end
	end

	arg_12_0:refreshFightConditionTitleStar(var_12_1, var_12_4)
end

function var_0_0.refreshFightConditionTitleStar(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0["_goadditionstar" .. arg_13_1]

	if not var_13_0 then
		return
	end

	for iter_13_0 = 1, arg_13_1 do
		local var_13_1 = gohelper.findChildImage(var_13_0, "star" .. iter_13_0)

		if not gohelper.isNil(var_13_1) then
			local var_13_2 = arg_13_2[iter_13_0]

			Act183Helper.setEpisodeConditionStar(var_13_1, var_13_2)
		end
	end

	gohelper.setActive(var_13_0, true)
end

function var_0_0._getOrCreateConditionItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._conditionItemTab[arg_14_1]

	if not var_14_0 then
		var_14_0 = arg_14_0:getUserDataTb_()
		var_14_0.viewGO = gohelper.cloneInPlace(arg_14_0._goadditionitem, "fightcondition_" .. arg_14_1)
		var_14_0.txtcontent = gohelper.findChildText(var_14_0.viewGO, "#txt_normalcondition")
		var_14_0.imagestar = gohelper.findChildImage(var_14_0.viewGO, "#image_star")
		arg_14_0._conditionItemTab[arg_14_1] = var_14_0
	end

	return var_14_0
end

function var_0_0.refreshChallengeRules(arg_15_0)
	arg_15_0._baseRuleDescList = Act183Config.instance:getEpisodeAllRuleDesc(arg_15_0._episodeId)
	arg_15_0._hasBaseRule = (arg_15_0._baseRuleDescList and #arg_15_0._baseRuleDescList or 0) > 0

	gohelper.setActive(arg_15_0._gobaserulecontainer, arg_15_0._hasBaseRule)

	if arg_15_0._hasBaseRule then
		gohelper.CreateObjList(arg_15_0, arg_15_0._refreshBaseRuleItem, arg_15_0._baseRuleDescList, arg_15_0._gobaserules, arg_15_0._gobaseruleItem)
	end

	arg_15_0._escapeRules = arg_15_0._groupEpisodeMo:getEscapeRules(arg_15_0._episodeId)

	if (arg_15_0._episodeMo and arg_15_0._episodeMo:getEpisodeType()) == Act183Enum.EpisodeType.Boss then
		local var_15_0 = {}
		local var_15_1 = arg_15_0._groupEpisodeMo:getTargetTypeAndStatusEpisodes(Act183Enum.EpisodeType.Sub, Act183Enum.EpisodeStatus.Locked)
		local var_15_2 = arg_15_0._groupEpisodeMo:getTargetTypeAndStatusEpisodes(Act183Enum.EpisodeType.Sub, Act183Enum.EpisodeStatus.Unlocked)

		tabletool.addValues(var_15_0, var_15_1)
		tabletool.addValues(var_15_0, var_15_2)

		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			local var_15_3 = iter_15_1:getEpisodeId()
			local var_15_4 = Act183Config.instance:getEpisodeAllRuleDesc(var_15_3)

			for iter_15_2 = 1, #var_15_4 do
				table.insert(arg_15_0._escapeRules, {
					episodeId = var_15_3,
					ruleIndex = iter_15_2,
					ruleDesc = var_15_4[iter_15_2]
				})
			end
		end
	end

	arg_15_0._canGetRule = arg_15_0._escapeRules and #arg_15_0._escapeRules > 0

	gohelper.setActive(arg_15_0._goescapecontainer, arg_15_0._canGetRule)

	if arg_15_0._canGetRule then
		gohelper.CreateObjList(arg_15_0, arg_15_0._refreshEscapeRuleItem, arg_15_0._escapeRules, arg_15_0._goescaperules, arg_15_0._goescaperuleitem)
	end

	gohelper.setActive(arg_15_0._gochallenge, arg_15_0._hasBaseRule or arg_15_0._canGetRule)
end

function var_0_0._refreshBaseRuleItem(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = gohelper.findChildImage(arg_16_1, "icon")

	Act183Helper.setRuleIcon(arg_16_0._episodeId, arg_16_3, var_16_0)
end

function var_0_0._refreshEscapeRuleItem(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = gohelper.findChildImage(arg_17_1, "icon")
	local var_17_1 = arg_17_2.episodeId
	local var_17_2 = arg_17_2.ruleIndex

	Act183Helper.setRuleIcon(var_17_1, var_17_2, var_17_0)
end

function var_0_0.refreshChallengeTips(arg_18_0)
	if arg_18_0._initChallengeTipsDone then
		return
	end

	arg_18_0:_refreshBaseRuleTipContents()
	arg_18_0:_refreshEscapeRuleTipContents()

	arg_18_0._initChallengeTipsDone = true
end

function var_0_0._refreshBaseRuleTipContents(arg_19_0)
	if not arg_19_0._hasBaseRule then
		return
	end

	arg_19_0._gobaseruletipitem = gohelper.cloneInPlace(arg_19_0._gochallengetipitem, "baseruleitem")

	arg_19_0:_refreshTipTitle(arg_19_0._gobaseruletipitem, "p_v2a5_challenge_herogroupview_basictxt")

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._baseRuleDescList) do
		local var_19_0 = gohelper.clone(arg_19_0._gochallengedescitem, arg_19_0._gobaseruletipitem, "item_" .. iter_19_0)
		local var_19_1 = gohelper.onceAddComponent(var_19_0, gohelper.Type_TextMesh)
		local var_19_2 = gohelper.findChildImage(var_19_0, "image_icon")

		var_19_1.text = SkillHelper.buildDesc(iter_19_1)

		SkillHelper.addHyperLinkClick(var_19_1)
		Act183Helper.setRuleIcon(arg_19_0._episodeId, iter_19_0, var_19_2)
		gohelper.setActive(var_19_0, true)
	end

	gohelper.setActive(arg_19_0._gobaseruletipitem, true)
end

function var_0_0._refreshEscapeRuleTipContents(arg_20_0)
	if not arg_20_0._canGetRule then
		return
	end

	arg_20_0._goescaperuletipitem = gohelper.cloneInPlace(arg_20_0._gochallengetipitem, "escaperuleitem")

	arg_20_0:_refreshTipTitle(arg_20_0._goescaperuletipitem, "p_v2a5_challenge_herogroupview_escapetxt")

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._escapeRules) do
		local var_20_0 = gohelper.clone(arg_20_0._gochallengedescitem, arg_20_0._goescaperuletipitem, "item_" .. iter_20_0)
		local var_20_1 = gohelper.onceAddComponent(var_20_0, gohelper.Type_TextMesh)

		var_20_1.text = SkillHelper.buildDesc(iter_20_1.ruleDesc)

		SkillHelper.addHyperLinkClick(var_20_1)

		local var_20_2 = iter_20_1.episodeId
		local var_20_3 = iter_20_1.ruleIndex
		local var_20_4 = gohelper.findChildImage(var_20_0, "image_icon")

		Act183Helper.setRuleIcon(var_20_2, var_20_3, var_20_4)
		gohelper.setActive(var_20_0, true)
	end

	gohelper.setActive(arg_20_0._goescaperuletipitem, true)
end

function var_0_0._refreshTipTitle(arg_21_0, arg_21_1, arg_21_2)
	gohelper.findChildText(arg_21_1, "title/txt_name").text = luaLang(arg_21_2)
end

return var_0_0
