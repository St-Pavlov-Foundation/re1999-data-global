module("modules.logic.versionactivity2_5.challenge.view.herogroup.Act183HeroGroupFightView", package.seeall)

local var_0_0 = class("Act183HeroGroupFightView", HeroGroupFightView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

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
	arg_1_0._goleadertips = gohelper.findChild(arg_1_0.viewGO, "#go_righttop/#go_LeaderTips")
	arg_1_0._txtleadertips = gohelper.findChildText(arg_1_0.viewGO, "#go_righttop/#go_LeaderTips/txt_LeaderTips")

	SkillHelper.addHyperLinkClick(arg_1_0._txtleadertips.gameObject)
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
end

function var_0_0._btnclothOnClock(arg_4_0)
	if Act183Helper.isOnlyCanUseLimitPlayerCloth(arg_4_0._episodeId) then
		GameFacade.showToast(ToastEnum.Act183OnlyOnePlayerCloth)

		return
	end

	var_0_0.super._btnclothOnClock(arg_4_0)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._activityId = Act183Model.instance:getActivityId()
	arg_5_0._episodeId = HeroGroupModel.instance.episodeId

	arg_5_0:checkAct183HeroList()
	var_0_0.super._editableInitView(arg_5_0)
end

function var_0_0._checkEquipClothSkill(arg_6_0)
	if arg_6_0:setLimitPlayerCloth() then
		return
	end

	var_0_0.super._checkEquipClothSkill(arg_6_0)
end

function var_0_0.setLimitPlayerCloth(arg_7_0)
	local var_7_0 = Act183Helper.isOnlyCanUseLimitPlayerCloth(arg_7_0._episodeId)

	if var_7_0 then
		local var_7_1 = Act183Helper.getLimitUsePlayerCloth()
		local var_7_2 = PlayerClothModel.instance:hasCloth(var_7_1)

		HeroGroupModel.instance:replaceCloth(var_7_2 and var_7_1 or 0)
		HeroGroupModel.instance:saveCurGroupData()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	end

	return var_7_0
end

function var_0_0._refreshBtns(arg_8_0, arg_8_1)
	var_0_0.super._refreshBtns(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._dropherogroup, false)
	TaskDispatcher.cancelTask(arg_8_0._checkDropArrow, arg_8_0)
end

function var_0_0.checkAct183HeroList(arg_9_0)
	local var_9_0 = Act183Helper.getEpisodeBattleNum(arg_9_0._episodeId)
	local var_9_1 = Act183Config.instance:getEpisodeCo(arg_9_0._episodeId)
	local var_9_2 = var_9_1 and var_9_1.groupId
	local var_9_3 = Act183Model.instance:getGroupEpisodeMo(var_9_2)
	local var_9_4 = HeroGroupModel.instance:getCurGroupMO()

	var_9_4:checkAct183HeroList(var_9_0, var_9_3)
	HeroSingleGroupModel.instance:setMaxHeroCount(var_9_0)
	HeroSingleGroupModel.instance:setSingleGroup(var_9_4, true)

	arg_9_0._groupEpisodeMo = var_9_3
	arg_9_0._episodeMo = Act183Model.instance:getEpisodeMo(var_9_2, arg_9_0._episodeId)
end

function var_0_0.openHeroGroupEditView(arg_10_0)
	arg_10_0._param = arg_10_0._param or {}
	arg_10_0._param.activityId = Act183Model.instance:getActivityId()
	arg_10_0._param.episodeId = HeroGroupModel.instance.episodeId

	ViewMgr.instance:openView(ViewName.Act183HeroGroupEditView, arg_10_0._param)
end

function var_0_0._refreshReplay(arg_11_0)
	gohelper.setActive(arg_11_0._goReplayBtn, false)
	gohelper.setActive(arg_11_0._gomemorytimes, false)
end

function var_0_0.onOpen(arg_12_0)
	var_0_0.super.onOpen(arg_12_0)

	local var_12_0 = Act183Model.instance:getUnlockSupportHeros()

	if Act183Helper.isEpisodeCanUseSupportHero(arg_12_0._episodeId) and var_12_0 then
		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			HeroGroupTrialModel.instance:addAtLast(iter_12_1)
		end
	end

	arg_12_0:refreshLeaderTips()
end

function var_0_0.refreshLeaderTips(arg_13_0)
	local var_13_0 = Act183Helper.isEpisodeHasTeamLeader(arg_13_0._episodeId)

	gohelper.setActive(arg_13_0._goleadertips, var_13_0)

	if not var_13_0 then
		return
	end

	local var_13_1 = Act183Config.instance:getLeaderSkillDesc(arg_13_0._episodeId)

	arg_13_0._txtleadertips.text = SkillHelper.buildDesc(var_13_1)
end

function var_0_0._refreshPowerShow(arg_14_0)
	gohelper.setActive(arg_14_0._gopowercontent, false)
end

function var_0_0.onClose(arg_15_0)
	var_0_0.super.onClose(arg_15_0)
	HeroSingleGroupModel.instance:setMaxHeroCount()

	HeroGroupTrialModel.instance.curBattleId = nil
end

return var_0_0
