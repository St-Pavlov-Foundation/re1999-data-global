module("modules.logic.dungeon.view.DungeonView", package.seeall)

local var_0_0 = class("DungeonView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gostory = gohelper.findChild(arg_1_0.viewGO, "#go_story")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_story/#simage_bg")
	arg_1_0._scrollchapter = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_story/chapterlist/#scroll_chapter")
	arg_1_0._goresource = gohelper.findChild(arg_1_0.viewGO, "#go_resource")
	arg_1_0._simageresourcebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_resource/#simage_resourcebg")
	arg_1_0._simagedrawbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_resource/#simage_drawbg")
	arg_1_0._scrollchapterresource = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_resource/chapterlist/#scroll_chapter_resource")
	arg_1_0._gorescontent = gohelper.findChild(arg_1_0.viewGO, "#go_resource/chapterlist/#scroll_chapter_resource/#go_rescontent")
	arg_1_0._goweekwalk = gohelper.findChild(arg_1_0.viewGO, "#go_weekwalk")
	arg_1_0._goexplore = gohelper.findChild(arg_1_0.viewGO, "#go_explore")
	arg_1_0._btnstory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/categorylist/#btn_story")
	arg_1_0._gostoryUnselectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_story/#go_storyUnselectText")
	arg_1_0._gostorySelectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_story/#go_storySelectText")
	arg_1_0._gostorytrace = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_story/#go_trace")
	arg_1_0._btnexplore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/categorylist/#btn_secretroom")
	arg_1_0._goexploreUnselectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_secretroom/#go_secretroomUnselectText")
	arg_1_0._goexploreSelectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_secretroom/#go_secretroomSelectText")
	arg_1_0._gogoldUnselectIcon = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_gold/#go_goldUnselectText/icon")
	arg_1_0._gogoldRedPoint = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_gold/#go_goldUnselectText/icon_redpoint")
	arg_1_0._btngold = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/categorylist/#btn_gold")
	arg_1_0._gogoldUnselectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_gold/#go_goldUnselectText")
	arg_1_0._gogoldSelectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_gold/#go_goldSelectText")
	arg_1_0._gogoldtrace = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_gold/#go_trace")
	arg_1_0._btnresource = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/categorylist/#btn_resource")
	arg_1_0._goresUnselectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_resource/#go_resUnselectText")
	arg_1_0._goresSelectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_resource/#go_resSelectText")
	arg_1_0._goresourcetrace = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_resource/#go_trace")
	arg_1_0._btnweekwalk = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/categorylist/#btn_weekwalk")
	arg_1_0._goweekwalkUnselectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkUnselectText")
	arg_1_0._goweekwalkSelectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkSelectText")
	arg_1_0._goweekwalkicon = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkUnselectText/#go_weekwalk_icon")
	arg_1_0._goweekwalkreward1 = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkUnselectText/#go_weekwalk_reward1")
	arg_1_0._goweekwalkreward2 = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkUnselectText/#go_weekwalk_reward2")
	arg_1_0._goweekwalkreward3 = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkUnselectText/#go_weekwalk_reward3")
	arg_1_0._btnrouge = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/categorylist/#btn_rouge")
	arg_1_0._gorougeUnselectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_rouge/#go_rougeUnselectText")
	arg_1_0._gorougeSelectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_rouge/#go_rougeSelectText")
	arg_1_0._goRoleStory = gohelper.findChild(arg_1_0.viewGO, "#go_RoleStory")
	arg_1_0._btnanecdote = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/categorylist/#btn_anecdote")
	arg_1_0._goanecdoteUnselectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_anecdote/#go_anecdoteUnselectText")
	arg_1_0._goanecdoteSelectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_anecdote/#go_anecdoteSelectText")
	arg_1_0._goanecdoteUnRed = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_anecdote/#go_anecdoteUnselectText/icon")
	arg_1_0._goanecdoteRed = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_anecdote/#go_anecdoteUnselectText/icon1")

	RedDotController.instance:addRedDotTag(arg_1_0._goanecdoteUnRed, RedDotEnum.DotNode.RoleStory, true)
	RedDotController.instance:addRedDotTag(arg_1_0._goanecdoteRed, RedDotEnum.DotNode.RoleStory)

	arg_1_0._gopermanent = gohelper.findChild(arg_1_0.viewGO, "#go_permanent")
	arg_1_0._btnpermanent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/categorylist/#btn_permanent")
	arg_1_0._goperUnselectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_permanent/#go_perUnselectText")
	arg_1_0._goperUnselectIcon = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_permanent/#go_perUnselectText/icon")
	arg_1_0._goperSelectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_permanent/#go_perSelectText")
	arg_1_0._goreddotpermanent = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_permanent/#go_perUnselectText/redpoint")
	arg_1_0._goreddotpermanentTag = RedDotController.instance:addRedDotTag(arg_1_0._goreddotpermanent, RedDotEnum.DotNode.Dungeon_Permanent, false, arg_1_0._checkPermanentReddot, arg_1_0)
	arg_1_0._btntrace = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_story/layout/#btn_trace")
	arg_1_0._simagetracehero = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_story/layout/#btn_trace/#simage_hero")
	arg_1_0._btnDramaReward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_story/layout/#btn_story")
	arg_1_0._gostoryUnselectTextIcon = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_story/#go_storyUnselectText/icon")
	arg_1_0._goreddotstory = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_story/#go_storyUnselectText/redpoint")
	arg_1_0.storyUnSelectIconTag = RedDotController.instance:addRedDotTag(arg_1_0._gostoryUnselectTextIcon, RedDotEnum.DotNode.HeroInvitationReward, true, arg_1_0.refreshStoryIcon, arg_1_0)
	arg_1_0.storySelectIconTag = RedDotController.instance:addRedDotTag(arg_1_0._goreddotstory, RedDotEnum.DotNode.HeroInvitationReward, nil, arg_1_0.refreshStoryIcon, arg_1_0)
	arg_1_0._btntower = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/categorylist/#btn_tower")
	arg_1_0._gotowerUnselectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_tower/#go_towerUnselectText")
	arg_1_0._gotowerSelectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_tower/#go_towerSelectText")
	arg_1_0._gotowerReddotEffect = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_tower/#go_towerUnselectText/redpoint")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnpermanent:AddClickListener(arg_2_0._btnpermanentOnClick, arg_2_0)
	arg_2_0._btnrouge:AddClickListener(arg_2_0._btnrougeOnClick, arg_2_0)
	arg_2_0._btnexplore:AddClickListener(arg_2_0._btnexploreOnClick, arg_2_0)
	arg_2_0._btntrace:AddClickListener(arg_2_0._btntracedOnClick, arg_2_0)
	arg_2_0._btnstory:AddClickListener(arg_2_0._btnstoryOnClick, arg_2_0)
	arg_2_0._btngold:AddClickListener(arg_2_0._btngoldOnClick, arg_2_0)
	arg_2_0._btnresource:AddClickListener(arg_2_0._btnresourceOnClick, arg_2_0)
	arg_2_0._btnweekwalk:AddClickListener(arg_2_0._btnweekwalkOnClick, arg_2_0)
	arg_2_0._btnanecdote:AddClickListener(arg_2_0._btnanecdoteOnClick, arg_2_0)
	arg_2_0._btnDramaReward:AddClickListener(arg_2_0._btnDramaRewardOnClick, arg_2_0)
	arg_2_0._btntower:AddClickListener(arg_2_0._btnTowerOnClick, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ResidentStoryChange, arg_2_0._onResidentStoryChange, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.RefreshTowerReddot, arg_2_0._showTowerEffect, arg_2_0)
	arg_2_0:addEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnLoadFinishTracedIcon, arg_2_0._refreshTracedIcon, arg_2_0)
	arg_2_0:addEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnRefreshTraced, arg_2_0._refreshTraced, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnpermanent:RemoveClickListener()
	arg_3_0._btnrouge:RemoveClickListener()
	arg_3_0._btnexplore:RemoveClickListener()
	arg_3_0._btntrace:RemoveClickListener()
	arg_3_0._btnstory:RemoveClickListener()
	arg_3_0._btngold:RemoveClickListener()
	arg_3_0._btnresource:RemoveClickListener()
	arg_3_0._btnweekwalk:RemoveClickListener()
	arg_3_0._btnanecdote:RemoveClickListener()
	arg_3_0._btnDramaReward:RemoveClickListener()
	arg_3_0._btntower:RemoveClickListener()
	arg_3_0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.ResidentStoryChange, arg_3_0._onResidentStoryChange, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.RefreshTowerReddot, arg_3_0._showTowerEffect, arg_3_0)
	arg_3_0:removeEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnLoadFinishTracedIcon, arg_3_0._refreshTracedIcon, arg_3_0)
	arg_3_0:removeEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnRefreshTraced, arg_3_0._refreshTraced, arg_3_0)
end

function var_0_0._btnTowerOnClick(arg_4_0)
	TowerController.instance:openMainView()
end

function var_0_0._btnpermanentOnClick(arg_5_0)
	if DungeonModel.instance:chapterListIsPermanent() then
		return
	end

	arg_5_0:changeCategory(DungeonEnum.ChapterType.PermanentActivity)
	arg_5_0:setBtnStatus()
end

function var_0_0._btnanecdoteOnClick(arg_6_0)
	if DungeonModel.instance:chapterListIsRoleStory() then
		return
	end

	arg_6_0:changeCategory(DungeonEnum.ChapterType.RoleStory)
	arg_6_0:setBtnStatus()
end

function var_0_0._btnweekwalkOnClick(arg_7_0)
	arg_7_0:changeCategory(DungeonEnum.ChapterType.WeekWalk, false)
	module_views_preloader.DungeonViewWeekWalk(function()
		arg_7_0:setBtnStatus()
	end)
end

function var_0_0._btnexploreOnClick(arg_9_0)
	arg_9_0:changeCategory(DungeonEnum.ChapterType.Explore, false)
	module_views_preloader.DungeonViewExplore(function()
		arg_9_0:setBtnStatus()
	end)
end

function var_0_0._btnrougeOnClick(arg_11_0)
	RougeController.instance:openRougeMainView()
end

function var_0_0._btnDramaRewardOnClick(arg_12_0)
	DungeonRpc.instance:sendGetMainDramaRewardRequest()
end

function var_0_0._onNavigateCloseCallback(arg_13_0)
	arg_13_0.viewContainer:setOverrideClose(nil, nil)
	gohelper.setActive(arg_13_0._gocategory, true)
	arg_13_0:_btnstoryOnClick()
end

function var_0_0._onExploreClose(arg_14_0)
	local var_14_0 = arg_14_0.viewContainer:getExploreView()

	if var_14_0 then
		var_14_0:onHide(arg_14_0._realCloseSubView, arg_14_0)
	end
end

function var_0_0._realCloseSubView(arg_15_0)
	arg_15_0.viewContainer:setOverrideClose(nil, nil)
	gohelper.setActive(arg_15_0._gocategory, true)
	arg_15_0:_btnstoryOnClick()
end

function var_0_0._btntracedOnClick(arg_16_0)
	CharacterRecommedController.instance:onJumpReturnRecommedView()
end

function var_0_0._btnstoryOnClick(arg_17_0)
	if arg_17_0._curIsNormalType then
		return
	end

	arg_17_0:changeCategory(DungeonEnum.ChapterType.Normal)
	arg_17_0:setBtnStatus()
	arg_17_0:_delayOnShowStoryView()
	TaskDispatcher.cancelTask(arg_17_0._delayOnShowStoryView, arg_17_0)
	TaskDispatcher.runDelay(arg_17_0._delayOnShowStoryView, arg_17_0, 0)
end

function var_0_0._delayOnShowStoryView(arg_18_0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnShowStoryView)
end

function var_0_0._btnmainOnClick(arg_19_0)
	arg_19_0:closeThis()
end

function var_0_0._btngoldOnClick(arg_20_0)
	if DungeonModel.instance:chapterListIsResType() then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.GainDungeon) then
		arg_20_0:changeCategory(DungeonEnum.ChapterType.Gold)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickDungeonCategory)
		module_views_preloader.DungeonViewGold(function()
			arg_20_0:setBtnStatus()
		end)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.GainDungeon))
	end
end

function var_0_0._btnresourceOnClick(arg_22_0)
	if DungeonModel.instance:chapterListIsBreakType() then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ResDungeon) then
		arg_22_0:changeCategory(DungeonEnum.ChapterType.Break)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickDungeonCategory)
		module_views_preloader.DungeonViewBreak(function()
			arg_22_0:setBtnStatus()
		end)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.ResDungeon))
	end
end

function var_0_0.changeCategory(arg_24_0, arg_24_1, arg_24_2)
	if DungeonModel.instance.curChapterType == arg_24_1 then
		return
	end

	if arg_24_1 == DungeonEnum.ChapterType.Normal then
		arg_24_0._scrollchapter.horizontalNormalizedPosition = 0
	else
		arg_24_0._scrollchapterresource.horizontalNormalizedPosition = 0

		if DungeonModel.instance.resScrollPosX then
			recthelper.setAnchorX(arg_24_0._scrollchapterresource.transform, DungeonModel.instance.resScrollPosX)

			DungeonModel.instance.resScrollPosX = nil
		end
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeChapterList, arg_24_1)
	DungeonModel.instance:changeCategory(arg_24_1, arg_24_2)
end

function var_0_0._btnbackOnClick(arg_25_0)
	arg_25_0:closeThis()
end

function var_0_0.playCategoryAnimation(arg_26_0)
	gohelper.setActive(arg_26_0._btnstory.gameObject, true)
	gohelper.setActive(arg_26_0._btnresource.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ResDungeon))
	gohelper.setActive(arg_26_0._btngold.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.GainDungeon))
end

function var_0_0._editableInitView(arg_27_0)
	arg_27_0._simagebg:LoadImage(ResUrl.getDungeonIcon("full/bg1"))

	arg_27_0._gocategory = gohelper.findChild(arg_27_0.viewGO, "bottom/categorylist")

	gohelper.addUIClickAudio(arg_27_0._btnstory.gameObject, AudioEnum.UI.UI_checkpoint_story_Click)
	gohelper.addUIClickAudio(arg_27_0._btngold.gameObject, AudioEnum.UI.UI_checkpoint_resources_Click)
	gohelper.addUIClickAudio(arg_27_0._btnresource.gameObject, AudioEnum.UI.UI_checkpoint_Insight_Click)
	gohelper.addUIClickAudio(arg_27_0._btnweekwalk.gameObject, AudioEnum.UI.UI_checkpoint_story_Click)
end

function var_0_0._isShowWeekWalk(arg_28_0)
	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.WeekWalk) then
		return false
	end

	if GuideController.instance:isForbidGuides() then
		return true
	end

	if VersionValidator.instance:isInReviewing() then
		return true
	end

	local var_28_0 = GuideModel.instance:getById(501)

	if not var_28_0 then
		return false
	end

	if var_28_0.isFinish then
		return true
	end

	return var_28_0.currStepId > 1
end

function var_0_0._isShowExplore(arg_29_0)
	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Explore) then
		return false
	end

	if GuideController.instance:isForbidGuides() then
		return true
	end

	if VersionValidator.instance:isInReviewing() then
		return true
	end

	return true
end

function var_0_0._refreshBtnUnlock(arg_30_0)
	gohelper.setActive(arg_30_0._btngold.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.GainDungeon))
	gohelper.setActive(arg_30_0._btnweekwalk.gameObject, arg_30_0:_isShowWeekWalk())
	gohelper.setActive(arg_30_0._btnexplore.gameObject, arg_30_0:_isShowExplore())

	local var_30_0 = DungeonModel.instance:getChapterListOpenTimeValid(DungeonEnum.ChapterType.Break)

	gohelper.setActive(arg_30_0._btnresource.gameObject, var_30_0 and OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ResDungeon))

	local var_30_1 = RoleStoryModel.instance:isInResident()
	local var_30_2 = VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS()

	gohelper.setActive(arg_30_0._btnanecdote, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.RoleStory) and var_30_1 and var_30_2 == false)

	local var_30_3 = PermanentModel.instance:hasActivityOnline()

	gohelper.setActive(arg_30_0._btnpermanent, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Permanent) and var_30_3)
	gohelper.setActive(arg_30_0._btnrouge, RougeOutsideController.instance:isOpen())
	gohelper.setActive(arg_30_0._btntower, TowerController.instance:isOpen())
end

function var_0_0.setBtnStatus(arg_31_0)
	local var_31_0, var_31_1, var_31_2, var_31_3, var_31_4, var_31_5 = DungeonModel.instance:getChapterListTypes()
	local var_31_6 = DungeonModel.instance:chapterListIsRoleStory()
	local var_31_7 = DungeonModel.instance:chapterListIsPermanent()
	local var_31_8 = false
	local var_31_9 = false

	var_31_0 = var_31_0 or var_31_4

	gohelper.setActive(arg_31_0._gostorySelectText, var_31_0)
	gohelper.setActive(arg_31_0._gostoryUnselectText, not var_31_0)

	arg_31_0._curIsNormalType = var_31_0

	gohelper.setActive(arg_31_0._goexploreSelectText, var_31_5)
	gohelper.setActive(arg_31_0._goexploreUnselectText, not var_31_5)
	gohelper.setActive(arg_31_0._gogoldSelectText, var_31_1)
	gohelper.setActive(arg_31_0._gogoldUnselectText, not var_31_1)
	gohelper.setActive(arg_31_0._goresSelectText, var_31_2)
	gohelper.setActive(arg_31_0._goresUnselectText, not var_31_2)
	gohelper.setActive(arg_31_0._goweekwalkSelectText, var_31_3)
	gohelper.setActive(arg_31_0._goweekwalkUnselectText, not var_31_3)
	gohelper.setActive(arg_31_0._gorougeSelectText, var_31_8)
	gohelper.setActive(arg_31_0._gorougeUnselectText, not var_31_8)
	gohelper.setActive(arg_31_0._gocategory, not var_31_3 and not var_31_5)
	gohelper.setActive(arg_31_0._goanecdoteUnselectText, not var_31_6)
	gohelper.setActive(arg_31_0._goanecdoteSelectText, var_31_6)
	gohelper.setActive(arg_31_0._goperUnselectText, not var_31_7)
	gohelper.setActive(arg_31_0._goperSelectText, var_31_7)
	gohelper.setActive(arg_31_0._gotowerSelectText, var_31_9)
	gohelper.setActive(arg_31_0._gotowerUnselectText, not var_31_9)

	if var_31_5 then
		arg_31_0.viewContainer:setOverrideClose(arg_31_0._onExploreClose, arg_31_0)
	elseif var_31_3 then
		arg_31_0.viewContainer:setOverrideClose(arg_31_0._onNavigateCloseCallback, arg_31_0)
	else
		arg_31_0.viewContainer:setOverrideClose(nil, nil)
	end

	gohelper.setActive(arg_31_0._gostory, true)

	if var_31_0 then
		if not arg_31_0._firstShowNormal then
			arg_31_0._firstShowNormal = true
			DungeonChapterListModel.instance.firstShowNormalTime = Time.time
		end

		arg_31_0:_focusNormalChapter(arg_31_0._moveChapterId)
		recthelper.setAnchorY(arg_31_0._gostory.transform, 0)

		arg_31_0._animator = arg_31_0._animator or arg_31_0.viewGO:GetComponent("Animator")

		if arg_31_0._animator then
			arg_31_0._animator.enabled = true

			arg_31_0._animator:Play("open", 0, 0)
		end
	else
		DungeonController.instance:dispatchEvent(DungeonEvent.FakeUnfoldMainStorySection)
		recthelper.setAnchorY(arg_31_0._gostory.transform, 10000)
	end

	gohelper.setActive(arg_31_0._goresource, var_31_1 or var_31_2)
	gohelper.setActive(arg_31_0._goweekwalk, var_31_3)
	gohelper.setActive(arg_31_0._goexplore, var_31_5)
	gohelper.setActive(arg_31_0._gopermanent, var_31_7)
	DungeonModel.instance:setDungeonStoryviewState(var_31_0)
	arg_31_0:refreshRoleStoryStatus()

	if var_31_1 or var_31_2 then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnShowResourceView)
	end

	arg_31_0._isWeekWalkType = var_31_3

	if var_31_3 then
		arg_31_0:_switchWeekWalkTab()
	elseif var_31_5 then
		arg_31_0.viewContainer:switchTab(DungeonEnum.DungeonViewTabEnum.Explore)
	elseif var_31_7 then
		arg_31_0.viewContainer:switchTab(DungeonEnum.DungeonViewTabEnum.Permanent)
	else
		arg_31_0.viewContainer:switchTab()
	end

	if DungeonModel.instance.resScrollPosX then
		recthelper.setAnchorX(arg_31_0._scrollchapterresource.transform, DungeonModel.instance.resScrollPosX)

		DungeonModel.instance.resScrollPosX = nil
	end

	arg_31_0:_showWeekWalkEffect()
	arg_31_0:_showGoldEffect()
	arg_31_0:_showTowerEffect()
	AudioBgmManager.instance:checkBgm()
end

function var_0_0._switchWeekWalkTab(arg_32_0)
	local var_32_0 = WeekWalkModel.instance:getInfo():getNotFinishedMap()

	if var_32_0 and WeekWalkModel.isShallowMap(var_32_0.sceneId) then
		arg_32_0.viewContainer:switchTab(DungeonEnum.DungeonViewTabEnum.WeekWalk)
	else
		local var_32_1 = WeekWalk_2Model.instance:getInfo()

		if var_32_1 and var_32_1:isOpen() then
			arg_32_0.viewContainer:switchTab(DungeonEnum.DungeonViewTabEnum.WeekWalk_2)
		else
			arg_32_0.viewContainer:switchTab(DungeonEnum.DungeonViewTabEnum.WeekWalk)
		end
	end
end

function var_0_0._showWeekWalkEffect(arg_33_0)
	local var_33_0 = WeekWalkTaskListModel.instance:canGetReward(WeekWalkEnum.TaskType.Week)
	local var_33_1 = WeekWalkModel.instance:getInfo()
	local var_33_2 = var_33_0 or var_33_1 and var_33_1.isPopShallowSettle
	local var_33_3 = var_33_1 and var_33_1.isPopDeepSettle
	local var_33_4 = WeekWalk_2Model.instance:getInfo()
	local var_33_5 = var_33_4 and var_33_4.isPopSettle

	gohelper.setActive(arg_33_0._goweekwalkreward1, false)
	gohelper.setActive(arg_33_0._goweekwalkreward2, false)
	gohelper.setActive(arg_33_0._goweekwalkreward3, false)
	gohelper.setActive(arg_33_0._goweekwalkicon, not var_33_2 and not var_33_3 and not var_33_5)

	if var_33_2 then
		gohelper.setActive(arg_33_0._goweekwalkreward1, true)
	elseif var_33_3 then
		gohelper.setActive(arg_33_0._goweekwalkreward2, true)
	elseif var_33_5 then
		gohelper.setActive(arg_33_0._goweekwalkreward3, true)
	end
end

function var_0_0._showGoldEffect(arg_34_0)
	local var_34_0 = DungeonModel.instance:getEquipRemainingNum() > 0

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.EquipDungeon) then
		gohelper.setActive(arg_34_0._gogoldUnselectIcon, not var_34_0)
		gohelper.setActive(arg_34_0._gogoldRedPoint, var_34_0)
	else
		gohelper.setActive(arg_34_0._gogoldUnselectIcon, true)
		gohelper.setActive(arg_34_0._gogoldRedPoint, false)
	end
end

function var_0_0._showTowerEffect(arg_35_0)
	if not TowerController.instance:isOpen() then
		return
	end

	local var_35_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Tower) or {}
	local var_35_1 = TowerTaskModel.instance:getTaskItemCanGetCount(var_35_0)
	local var_35_2 = TowerPermanentModel.instance:checkCanShowMopUpReddot()
	local var_35_3 = TowerController.instance:checkReddotHasNewUpdateTower()

	gohelper.setActive(arg_35_0._gotowerReddotEffect, var_35_1 > 0 or var_35_2 or var_35_3)
end

function var_0_0.onUpdateParam(arg_36_0)
	arg_36_0:setBtnStatus()
end

function var_0_0.onOpen(arg_37_0)
	if ViewMgr.instance:isOpen(ViewName.MainView) then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Main_enterance)
	end

	arg_37_0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeChapter, arg_37_0._onChangeChapter, arg_37_0)
	arg_37_0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, arg_37_0._refreshBtnUnlock, arg_37_0)
	arg_37_0:addEventCb(ViewMgr.instance, ViewEvent.DestroyViewFinish, arg_37_0._onDestroyViewFinish, arg_37_0)
	arg_37_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_37_0._onCloseView, arg_37_0)
	arg_37_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnAllShallowLayerFinish, arg_37_0._onAllShallowLayerFinish, arg_37_0)
	arg_37_0:addEventCb(DungeonController.instance, DungeonEvent.OnDramaRewardStatusChange, arg_37_0._refreshDramaBtnStatus, arg_37_0)
	arg_37_0:addEventCb(Activity165Controller.instance, Activity165Event.refreshStoryReddot, arg_37_0._onRefreshStoryReddot, arg_37_0)
	arg_37_0:_refreshDramaBtnStatus()
	arg_37_0:_moveChapter(DungeonMainStoryModel.instance:getJumpFocusChapterIdOnce())
	arg_37_0:_refreshBtnUnlock()
	arg_37_0:playCategoryAnimation()
	arg_37_0:_refreshTraced()
end

function var_0_0._moveChapter(arg_38_0, arg_38_1)
	if not arg_38_1 then
		arg_38_1 = DungeonMainStoryModel.instance:getClickChapterId()
	else
		DungeonMainStoryModel.instance:saveClickChapterId(arg_38_1)
	end

	if not arg_38_1 then
		DungeonMainStoryModel.instance:initSelectedSectionId()
	end

	arg_38_0._moveChapterId = arg_38_1

	arg_38_0:setBtnStatus()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterDungeonChatperView, arg_38_0._moveChapterId)
end

function var_0_0._onCloseView(arg_39_0, arg_39_1)
	if arg_39_1 == ViewName.DungeonMapView and DungeonModel.instance.chapterTriggerNewChapter then
		local var_39_0 = DungeonModel.instance.unlockNewChapterId

		arg_39_0:_focusNormalChapter(var_39_0)
	end

	if (arg_39_1 == ViewName.RougeMainView or arg_39_1 == ViewName.TowerMainView) and arg_39_0._animator then
		arg_39_0._animator.enabled = true

		arg_39_0._animator:Play("open", 0, 0)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnShowStoryView)
	end
end

function var_0_0._onAllShallowLayerFinish(arg_40_0)
	if arg_40_0._isWeekWalkType then
		arg_40_0:_switchWeekWalkTab()
	end
end

function var_0_0._focusNormalChapter(arg_41_0, arg_41_1)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnFocusNormalChapter, arg_41_1)
end

function var_0_0._resetMovementType(arg_42_0)
	arg_42_0._scrollchapter.movementType = 1
end

function var_0_0._onDestroyViewFinish(arg_43_0, arg_43_1)
	return
end

function var_0_0._onChangeChapter(arg_44_0, arg_44_1)
	if not DungeonModel.instance:chapterListIsNormalType() then
		return
	end

	arg_44_0:_moveChapter(arg_44_1)
end

function var_0_0.refreshRoleStoryStatus(arg_45_0)
	local var_45_0 = DungeonModel.instance:chapterListIsRoleStory()
	local var_45_1 = RoleStoryModel.instance:isInResident()
	local var_45_2 = RoleStoryModel.instance:checkActStoryOpen()

	arg_45_0:setRoleStoryStatus((var_45_1 or var_45_2) and var_45_0)

	if var_45_0 and not var_45_1 and not var_45_2 then
		arg_45_0:_btnstoryOnClick()
		arg_45_0:_refreshBtnUnlock()
	end
end

function var_0_0.setRoleStoryStatus(arg_46_0, arg_46_1)
	if arg_46_1 then
		if not arg_46_0._roleStoryView then
			arg_46_0._roleStoryView = RoleStoryView.New(arg_46_0._goRoleStory)
		end

		arg_46_0._roleStoryView:show()
	elseif arg_46_0._roleStoryView then
		arg_46_0._roleStoryView:hide()
	end
end

function var_0_0._onResidentStoryChange(arg_47_0)
	arg_47_0:refreshRoleStoryStatus()
end

function var_0_0.destoryRoleStory(arg_48_0)
	if arg_48_0._roleStoryView then
		arg_48_0._roleStoryView:destory()

		arg_48_0._roleStoryView = nil
	end
end

function var_0_0.onClose(arg_49_0)
	return
end

function var_0_0.onDestroyView(arg_50_0)
	arg_50_0._simagebg:UnLoadImage()
	arg_50_0._simagetracehero:UnLoadImage()
	TaskDispatcher.cancelTask(arg_50_0._resetMovementType, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._delayOnShowStoryView, arg_50_0)
	arg_50_0:destoryRoleStory()
end

function var_0_0._refreshDramaBtnStatus(arg_51_0)
	arg_51_0.storyUnSelectIconTag:refreshDot()
	arg_51_0.storySelectIconTag:refreshDot()

	local var_51_0 = DungeonModel.instance:isCanGetDramaReward()

	gohelper.setActive(arg_51_0._btnDramaReward, var_51_0)

	if var_51_0 then
		local var_51_1 = arg_51_0.viewParam

		if var_51_1 and var_51_1.fromMainView then
			DungeonController.instance:dispatchEvent(DungeonEvent.OnShowDramaRewardGuide)
		end
	end
end

function var_0_0.refreshStoryIcon(arg_52_0, arg_52_1)
	local var_52_0 = RedDotModel.instance:isDotShow(arg_52_1.dotId, 0) or DungeonModel.instance:isCanGetDramaReward()

	if arg_52_1.reverse then
		var_52_0 = not var_52_0
	end

	gohelper.setActive(arg_52_1.go, var_52_0)
end

function var_0_0._checkPermanentReddot(arg_53_0, arg_53_1)
	local var_53_0 = RedDotModel.instance:isDotShow(arg_53_1.dotId, 0) or not PermanentModel.instance:isActivityLocalRead()

	var_53_0 = var_53_0 or PermanentModel.instance:IsDotShowPermanent2_1()

	gohelper.setActive(arg_53_0._goperUnselectIcon, not var_53_0)
	gohelper.setActive(arg_53_0._goreddotpermanent, var_53_0)
end

function var_0_0._onRefreshStoryReddot(arg_54_0)
	if not arg_54_0._goreddotpermanentTag then
		return
	end

	arg_54_0._goreddotpermanentTag:refreshDot()
end

function var_0_0._refreshTraced(arg_55_0)
	arg_55_0:_refreshTracedIcon()
	arg_55_0:_refreshTracedHeroIcon()
end

function var_0_0._refreshTracedHeroIcon(arg_56_0)
	local var_56_0 = CharacterRecommedModel.instance:getTracedHeroDevelopGoalsMO()

	if var_56_0 then
		local var_56_1 = var_56_0:getHeroSkinCo()

		arg_56_0._simagetracehero:LoadImage(ResUrl.getHeadIconSmall(var_56_1.headIcon))
		gohelper.setActive(arg_56_0._btntrace.gameObject, true)
	else
		gohelper.setActive(arg_56_0._btntrace.gameObject, false)
	end
end

function var_0_0._refreshTracedIcon(arg_57_0)
	local var_57_0 = CharacterRecommedController.instance:getTradeIcon()

	if not var_57_0 then
		return
	end

	local var_57_1 = CharacterRecommedModel.instance:isTradeStory()

	if var_57_1 and not arg_57_0._tracedStoryIcon then
		arg_57_0._tracedStoryIcon = gohelper.clone(var_57_0, arg_57_0._gostorytrace)
	end

	gohelper.setActive(arg_57_0._tracedStoryIcon, var_57_1)

	local var_57_2 = CharacterRecommedModel.instance:isTradeResDungeon()

	if var_57_2 and not arg_57_0._tracedResIcon then
		arg_57_0._tracedResIcon = gohelper.clone(var_57_0, arg_57_0._gogoldtrace)
	end

	gohelper.setActive(arg_57_0._tracedResIcon, var_57_2)

	local var_57_3 = CharacterRecommedModel.instance:isTradeRankResDungeon()

	if var_57_3 and not arg_57_0._tracedresourceIcon then
		arg_57_0._tracedresourceIcon = gohelper.clone(var_57_0, arg_57_0._goresourcetrace)
	end

	gohelper.setActive(arg_57_0._tracedresourceIcon, var_57_3)
end

return var_0_0
