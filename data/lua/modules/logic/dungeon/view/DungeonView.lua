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
	arg_1_0._btnexplore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/categorylist/#btn_secretroom")
	arg_1_0._goexploreUnselectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_secretroom/#go_secretroomUnselectText")
	arg_1_0._goexploreSelectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_secretroom/#go_secretroomSelectText")
	arg_1_0._gogoldUnselectIcon = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_gold/#go_goldUnselectText/icon")
	arg_1_0._gogoldRedPoint = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_gold/#go_goldUnselectText/icon_redpoint")
	arg_1_0._btngold = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/categorylist/#btn_gold")
	arg_1_0._gogoldUnselectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_gold/#go_goldUnselectText")
	arg_1_0._gogoldSelectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_gold/#go_goldSelectText")
	arg_1_0._btnresource = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/categorylist/#btn_resource")
	arg_1_0._goresUnselectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_resource/#go_resUnselectText")
	arg_1_0._goresSelectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_resource/#go_resSelectText")
	arg_1_0._btnweekwalk = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/categorylist/#btn_weekwalk")
	arg_1_0._goweekwalkUnselectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkUnselectText")
	arg_1_0._goweekwalkSelectText = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkSelectText")
	arg_1_0._goweekwalkicon = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkUnselectText/#go_weekwalk_icon")
	arg_1_0._goweekwalkreward1 = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkUnselectText/#go_weekwalk_reward1")
	arg_1_0._goweekwalkreward2 = gohelper.findChild(arg_1_0.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkUnselectText/#go_weekwalk_reward2")
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
	arg_1_0._btnDramaReward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_story/#btn_story")
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
	arg_2_0._btnstory:AddClickListener(arg_2_0._btnstoryOnClick, arg_2_0)
	arg_2_0._btngold:AddClickListener(arg_2_0._btngoldOnClick, arg_2_0)
	arg_2_0._btnresource:AddClickListener(arg_2_0._btnresourceOnClick, arg_2_0)
	arg_2_0._btnweekwalk:AddClickListener(arg_2_0._btnweekwalkOnClick, arg_2_0)
	arg_2_0._btnanecdote:AddClickListener(arg_2_0._btnanecdoteOnClick, arg_2_0)
	arg_2_0._btnDramaReward:AddClickListener(arg_2_0._btnDramaRewardOnClick, arg_2_0)
	arg_2_0._btntower:AddClickListener(arg_2_0._btnTowerOnClick, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ResidentStoryChange, arg_2_0._onResidentStoryChange, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.RefreshTowerReddot, arg_2_0._showTowerEffect, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnpermanent:RemoveClickListener()
	arg_3_0._btnrouge:RemoveClickListener()
	arg_3_0._btnexplore:RemoveClickListener()
	arg_3_0._btnstory:RemoveClickListener()
	arg_3_0._btngold:RemoveClickListener()
	arg_3_0._btnresource:RemoveClickListener()
	arg_3_0._btnweekwalk:RemoveClickListener()
	arg_3_0._btnanecdote:RemoveClickListener()
	arg_3_0._btnDramaReward:RemoveClickListener()
	arg_3_0._btntower:RemoveClickListener()
	arg_3_0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.ResidentStoryChange, arg_3_0._onResidentStoryChange, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.RefreshTowerReddot, arg_3_0._showTowerEffect, arg_3_0)
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

function var_0_0._btnstoryOnClick(arg_16_0)
	if arg_16_0._curIsNormalType then
		return
	end

	arg_16_0:changeCategory(DungeonEnum.ChapterType.Normal)
	arg_16_0:setBtnStatus()
	arg_16_0:_delayOnShowStoryView()
	TaskDispatcher.cancelTask(arg_16_0._delayOnShowStoryView, arg_16_0)
	TaskDispatcher.runDelay(arg_16_0._delayOnShowStoryView, arg_16_0, 0)
end

function var_0_0._delayOnShowStoryView(arg_17_0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnShowStoryView)
end

function var_0_0._btnmainOnClick(arg_18_0)
	arg_18_0:closeThis()
end

function var_0_0._btngoldOnClick(arg_19_0)
	if DungeonModel.instance:chapterListIsResType() then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.GainDungeon) then
		arg_19_0:changeCategory(DungeonEnum.ChapterType.Gold)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickDungeonCategory)
		module_views_preloader.DungeonViewGold(function()
			arg_19_0:setBtnStatus()
		end)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.GainDungeon))
	end
end

function var_0_0._btnresourceOnClick(arg_21_0)
	if DungeonModel.instance:chapterListIsBreakType() then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ResDungeon) then
		arg_21_0:changeCategory(DungeonEnum.ChapterType.Break)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickDungeonCategory)
		module_views_preloader.DungeonViewBreak(function()
			arg_21_0:setBtnStatus()
		end)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.ResDungeon))
	end
end

function var_0_0.changeCategory(arg_23_0, arg_23_1, arg_23_2)
	if DungeonModel.instance.curChapterType == arg_23_1 then
		return
	end

	if arg_23_1 == DungeonEnum.ChapterType.Normal then
		arg_23_0._scrollchapter.horizontalNormalizedPosition = 0
	else
		arg_23_0._scrollchapterresource.horizontalNormalizedPosition = 0

		if DungeonModel.instance.resScrollPosX then
			recthelper.setAnchorX(arg_23_0._scrollchapterresource.transform, DungeonModel.instance.resScrollPosX)

			DungeonModel.instance.resScrollPosX = nil
		end
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeChapterList, arg_23_1)
	DungeonModel.instance:changeCategory(arg_23_1, arg_23_2)
end

function var_0_0._btnbackOnClick(arg_24_0)
	arg_24_0:closeThis()
end

function var_0_0.playCategoryAnimation(arg_25_0)
	gohelper.setActive(arg_25_0._btnstory.gameObject, true)
	gohelper.setActive(arg_25_0._btnresource.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ResDungeon))
	gohelper.setActive(arg_25_0._btngold.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.GainDungeon))
end

function var_0_0._editableInitView(arg_26_0)
	arg_26_0._simagebg:LoadImage(ResUrl.getDungeonIcon("full/bg1"))

	arg_26_0._gocategory = gohelper.findChild(arg_26_0.viewGO, "bottom/categorylist")

	gohelper.addUIClickAudio(arg_26_0._btnstory.gameObject, AudioEnum.UI.UI_checkpoint_story_Click)
	gohelper.addUIClickAudio(arg_26_0._btngold.gameObject, AudioEnum.UI.UI_checkpoint_resources_Click)
	gohelper.addUIClickAudio(arg_26_0._btnresource.gameObject, AudioEnum.UI.UI_checkpoint_Insight_Click)
	gohelper.addUIClickAudio(arg_26_0._btnweekwalk.gameObject, AudioEnum.UI.UI_checkpoint_story_Click)
end

function var_0_0._isShowWeekWalk(arg_27_0)
	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.WeekWalk) then
		return false
	end

	if GuideController.instance:isForbidGuides() then
		return true
	end

	if VersionValidator.instance:isInReviewing() then
		return true
	end

	local var_27_0 = GuideModel.instance:getById(501)

	if not var_27_0 then
		return false
	end

	if var_27_0.isFinish then
		return true
	end

	return var_27_0.currStepId > 1
end

function var_0_0._isShowExplore(arg_28_0)
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

function var_0_0._refreshBtnUnlock(arg_29_0)
	gohelper.setActive(arg_29_0._btngold.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.GainDungeon))
	gohelper.setActive(arg_29_0._btnweekwalk.gameObject, arg_29_0:_isShowWeekWalk())
	gohelper.setActive(arg_29_0._btnexplore.gameObject, arg_29_0:_isShowExplore())

	local var_29_0 = DungeonModel.instance:getChapterListOpenTimeValid(DungeonEnum.ChapterType.Break)

	gohelper.setActive(arg_29_0._btnresource.gameObject, var_29_0 and OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ResDungeon))

	local var_29_1 = RoleStoryModel.instance:isInResident()
	local var_29_2 = VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS()

	gohelper.setActive(arg_29_0._btnanecdote, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.RoleStory) and var_29_1 and var_29_2 == false)

	local var_29_3 = PermanentModel.instance:hasActivityOnline()

	gohelper.setActive(arg_29_0._btnpermanent, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Permanent) and var_29_3)
	gohelper.setActive(arg_29_0._btnrouge, RougeOutsideController.instance:isOpen())
	gohelper.setActive(arg_29_0._btntower, TowerController.instance:isOpen())
end

function var_0_0.setBtnStatus(arg_30_0)
	local var_30_0, var_30_1, var_30_2, var_30_3, var_30_4, var_30_5 = DungeonModel.instance:getChapterListTypes()
	local var_30_6 = DungeonModel.instance:chapterListIsRoleStory()
	local var_30_7 = DungeonModel.instance:chapterListIsPermanent()
	local var_30_8 = false
	local var_30_9 = false

	var_30_0 = var_30_0 or var_30_4

	gohelper.setActive(arg_30_0._gostorySelectText, var_30_0)
	gohelper.setActive(arg_30_0._gostoryUnselectText, not var_30_0)

	arg_30_0._curIsNormalType = var_30_0

	gohelper.setActive(arg_30_0._goexploreSelectText, var_30_5)
	gohelper.setActive(arg_30_0._goexploreUnselectText, not var_30_5)
	gohelper.setActive(arg_30_0._gogoldSelectText, var_30_1)
	gohelper.setActive(arg_30_0._gogoldUnselectText, not var_30_1)
	gohelper.setActive(arg_30_0._goresSelectText, var_30_2)
	gohelper.setActive(arg_30_0._goresUnselectText, not var_30_2)
	gohelper.setActive(arg_30_0._goweekwalkSelectText, var_30_3)
	gohelper.setActive(arg_30_0._goweekwalkUnselectText, not var_30_3)
	gohelper.setActive(arg_30_0._gorougeSelectText, var_30_8)
	gohelper.setActive(arg_30_0._gorougeUnselectText, not var_30_8)
	gohelper.setActive(arg_30_0._gocategory, not var_30_3 and not var_30_5)
	gohelper.setActive(arg_30_0._goanecdoteUnselectText, not var_30_6)
	gohelper.setActive(arg_30_0._goanecdoteSelectText, var_30_6)
	gohelper.setActive(arg_30_0._goperUnselectText, not var_30_7)
	gohelper.setActive(arg_30_0._goperSelectText, var_30_7)
	gohelper.setActive(arg_30_0._gotowerSelectText, var_30_9)
	gohelper.setActive(arg_30_0._gotowerUnselectText, not var_30_9)

	if var_30_5 then
		arg_30_0.viewContainer:setOverrideClose(arg_30_0._onExploreClose, arg_30_0)
	elseif var_30_3 then
		arg_30_0.viewContainer:setOverrideClose(arg_30_0._onNavigateCloseCallback, arg_30_0)
	else
		arg_30_0.viewContainer:setOverrideClose(nil, nil)
	end

	gohelper.setActive(arg_30_0._gostory, true)

	if var_30_0 then
		if not arg_30_0._firstShowNormal then
			arg_30_0._firstShowNormal = true
			DungeonChapterListModel.instance.firstShowNormalTime = Time.time
		end

		arg_30_0:_focusNormalChapter(arg_30_0._moveChapterId)
		recthelper.setAnchorY(arg_30_0._gostory.transform, 0)

		arg_30_0._animator = arg_30_0._animator or arg_30_0.viewGO:GetComponent("Animator")

		if arg_30_0._animator then
			arg_30_0._animator.enabled = true

			arg_30_0._animator:Play("open", 0, 0)
		end
	else
		DungeonController.instance:dispatchEvent(DungeonEvent.FakeUnfoldMainStorySection)
		recthelper.setAnchorY(arg_30_0._gostory.transform, 10000)
	end

	gohelper.setActive(arg_30_0._goresource, var_30_1 or var_30_2)
	gohelper.setActive(arg_30_0._goweekwalk, var_30_3)
	gohelper.setActive(arg_30_0._goexplore, var_30_5)
	gohelper.setActive(arg_30_0._gopermanent, var_30_7)
	DungeonModel.instance:setDungeonStoryviewState(var_30_0)
	arg_30_0:refreshRoleStoryStatus()

	if var_30_1 or var_30_2 then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnShowResourceView)
	end

	arg_30_0._isWeekWalkType = var_30_3

	if var_30_3 then
		arg_30_0:_switchWeekWalkTab()
	elseif var_30_5 then
		arg_30_0.viewContainer:switchTab(DungeonEnum.DungeonViewTabEnum.Explore)
	elseif var_30_7 then
		arg_30_0.viewContainer:switchTab(DungeonEnum.DungeonViewTabEnum.Permanent)
	else
		arg_30_0.viewContainer:switchTab()
	end

	if DungeonModel.instance.resScrollPosX then
		recthelper.setAnchorX(arg_30_0._scrollchapterresource.transform, DungeonModel.instance.resScrollPosX)

		DungeonModel.instance.resScrollPosX = nil
	end

	arg_30_0:_showWeekWalkEffect()
	arg_30_0:_showGoldEffect()
	arg_30_0:_showTowerEffect()
	AudioBgmManager.instance:checkBgm()
end

function var_0_0._switchWeekWalkTab(arg_31_0)
	local var_31_0 = WeekWalkModel.instance:getInfo():getNotFinishedMap()

	if var_31_0 and WeekWalkModel.isShallowMap(var_31_0.sceneId) then
		arg_31_0.viewContainer:switchTab(DungeonEnum.DungeonViewTabEnum.WeekWalk)
	else
		local var_31_1 = WeekWalk_2Model.instance:getInfo()

		if var_31_1 and var_31_1:isOpen() then
			arg_31_0.viewContainer:switchTab(DungeonEnum.DungeonViewTabEnum.WeekWalk_2)
		else
			arg_31_0.viewContainer:switchTab(DungeonEnum.DungeonViewTabEnum.WeekWalk)
		end
	end
end

function var_0_0._showWeekWalkEffect(arg_32_0)
	local var_32_0 = WeekWalkTaskListModel.instance:canGetReward(WeekWalkEnum.TaskType.Week)
	local var_32_1 = WeekWalkModel.instance:getInfo()
	local var_32_2 = var_32_0 or var_32_1 and var_32_1.isPopShallowSettle
	local var_32_3 = var_32_1 and var_32_1.isPopDeepSettle
	local var_32_4 = WeekWalk_2Model.instance:getInfo()
	local var_32_5 = var_32_4 and var_32_4.isPopSettle
	local var_32_6 = var_32_3 or var_32_5

	gohelper.setActive(arg_32_0._goweekwalkreward1, var_32_2)
	gohelper.setActive(arg_32_0._goweekwalkreward2, not var_32_2 and var_32_6)
	gohelper.setActive(arg_32_0._goweekwalkicon, not var_32_2 and not var_32_6)
end

function var_0_0._showGoldEffect(arg_33_0)
	local var_33_0 = DungeonModel.instance:getEquipRemainingNum() > 0

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.EquipDungeon) then
		gohelper.setActive(arg_33_0._gogoldUnselectIcon, not var_33_0)
		gohelper.setActive(arg_33_0._gogoldRedPoint, var_33_0)
	else
		gohelper.setActive(arg_33_0._gogoldUnselectIcon, true)
		gohelper.setActive(arg_33_0._gogoldRedPoint, false)
	end
end

function var_0_0._showTowerEffect(arg_34_0)
	if not TowerController.instance:isOpen() then
		return
	end

	local var_34_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Tower) or {}
	local var_34_1 = TowerTaskModel.instance:getTaskItemCanGetCount(var_34_0)
	local var_34_2 = TowerPermanentModel.instance:checkCanShowMopUpReddot()
	local var_34_3 = TowerController.instance:checkReddotHasNewUpdateTower()

	gohelper.setActive(arg_34_0._gotowerReddotEffect, var_34_1 > 0 or var_34_2 or var_34_3)
end

function var_0_0.onUpdateParam(arg_35_0)
	arg_35_0:setBtnStatus()
end

function var_0_0.onOpen(arg_36_0)
	if ViewMgr.instance:isOpen(ViewName.MainView) then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Main_enterance)
	end

	arg_36_0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeChapter, arg_36_0._onChangeChapter, arg_36_0)
	arg_36_0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, arg_36_0._refreshBtnUnlock, arg_36_0)
	arg_36_0:addEventCb(ViewMgr.instance, ViewEvent.DestroyViewFinish, arg_36_0._onDestroyViewFinish, arg_36_0)
	arg_36_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_36_0._onCloseView, arg_36_0)
	arg_36_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnAllShallowLayerFinish, arg_36_0._onAllShallowLayerFinish, arg_36_0)
	arg_36_0:addEventCb(DungeonController.instance, DungeonEvent.OnDramaRewardStatusChange, arg_36_0._refreshDramaBtnStatus, arg_36_0)
	arg_36_0:addEventCb(Activity165Controller.instance, Activity165Event.refreshStoryReddot, arg_36_0._onRefreshStoryReddot, arg_36_0)
	arg_36_0:_refreshDramaBtnStatus()
	arg_36_0:_moveChapter(DungeonMainStoryModel.instance:getJumpFocusChapterIdOnce())
	arg_36_0:_refreshBtnUnlock()
	arg_36_0:playCategoryAnimation()
end

function var_0_0._moveChapter(arg_37_0, arg_37_1)
	if not arg_37_1 then
		arg_37_1 = DungeonMainStoryModel.instance:getClickChapterId()
	else
		DungeonMainStoryModel.instance:saveClickChapterId(arg_37_1)
	end

	if not arg_37_1 then
		DungeonMainStoryModel.instance:initSelectedSectionId()
	end

	arg_37_0._moveChapterId = arg_37_1

	arg_37_0:setBtnStatus()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterDungeonChatperView, arg_37_0._moveChapterId)
end

function var_0_0._onCloseView(arg_38_0, arg_38_1)
	if arg_38_1 == ViewName.DungeonMapView and DungeonModel.instance.chapterTriggerNewChapter then
		local var_38_0 = DungeonModel.instance.unlockNewChapterId

		arg_38_0:_focusNormalChapter(var_38_0)
	end
end

function var_0_0._onAllShallowLayerFinish(arg_39_0)
	if arg_39_0._isWeekWalkType then
		arg_39_0:_switchWeekWalkTab()
	end
end

function var_0_0._focusNormalChapter(arg_40_0, arg_40_1)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnFocusNormalChapter, arg_40_1)
end

function var_0_0._resetMovementType(arg_41_0)
	arg_41_0._scrollchapter.movementType = 1
end

function var_0_0._onDestroyViewFinish(arg_42_0, arg_42_1)
	return
end

function var_0_0._onChangeChapter(arg_43_0, arg_43_1)
	if not DungeonModel.instance:chapterListIsNormalType() then
		return
	end

	arg_43_0:_moveChapter(arg_43_1)
end

function var_0_0.refreshRoleStoryStatus(arg_44_0)
	local var_44_0 = DungeonModel.instance:chapterListIsRoleStory()
	local var_44_1 = RoleStoryModel.instance:isInResident()
	local var_44_2 = RoleStoryModel.instance:checkActStoryOpen()

	arg_44_0:setRoleStoryStatus((var_44_1 or var_44_2) and var_44_0)

	if var_44_0 and not var_44_1 and not var_44_2 then
		arg_44_0:_btnstoryOnClick()
		arg_44_0:_refreshBtnUnlock()
	end
end

function var_0_0.setRoleStoryStatus(arg_45_0, arg_45_1)
	if arg_45_1 then
		if not arg_45_0._roleStoryView then
			arg_45_0._roleStoryView = RoleStoryView.New(arg_45_0._goRoleStory)
		end

		arg_45_0._roleStoryView:show()
	elseif arg_45_0._roleStoryView then
		arg_45_0._roleStoryView:hide()
	end
end

function var_0_0._onResidentStoryChange(arg_46_0)
	arg_46_0:refreshRoleStoryStatus()
end

function var_0_0.destoryRoleStory(arg_47_0)
	if arg_47_0._roleStoryView then
		arg_47_0._roleStoryView:destory()

		arg_47_0._roleStoryView = nil
	end
end

function var_0_0.onClose(arg_48_0)
	return
end

function var_0_0.onDestroyView(arg_49_0)
	arg_49_0._simagebg:UnLoadImage()
	TaskDispatcher.cancelTask(arg_49_0._resetMovementType, arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0._delayOnShowStoryView, arg_49_0)
	arg_49_0:destoryRoleStory()
end

function var_0_0._refreshDramaBtnStatus(arg_50_0)
	arg_50_0.storyUnSelectIconTag:refreshDot()
	arg_50_0.storySelectIconTag:refreshDot()

	local var_50_0 = DungeonModel.instance:isCanGetDramaReward()

	gohelper.setActive(arg_50_0._btnDramaReward, var_50_0)

	if var_50_0 then
		local var_50_1 = arg_50_0.viewParam

		if var_50_1 and var_50_1.fromMainView then
			DungeonController.instance:dispatchEvent(DungeonEvent.OnShowDramaRewardGuide)
		end
	end
end

function var_0_0.refreshStoryIcon(arg_51_0, arg_51_1)
	local var_51_0 = RedDotModel.instance:isDotShow(arg_51_1.dotId, 0) or DungeonModel.instance:isCanGetDramaReward()

	if arg_51_1.reverse then
		var_51_0 = not var_51_0
	end

	gohelper.setActive(arg_51_1.go, var_51_0)
end

function var_0_0._checkPermanentReddot(arg_52_0, arg_52_1)
	local var_52_0 = RedDotModel.instance:isDotShow(arg_52_1.dotId, 0) or not PermanentModel.instance:isActivityLocalRead()

	var_52_0 = var_52_0 or PermanentModel.instance:IsDotShowPermanent2_1()

	gohelper.setActive(arg_52_0._goperUnselectIcon, not var_52_0)
	gohelper.setActive(arg_52_0._goreddotpermanent, var_52_0)
end

function var_0_0._onRefreshStoryReddot(arg_53_0)
	if not arg_53_0._goreddotpermanentTag then
		return
	end

	arg_53_0._goreddotpermanentTag:refreshDot()
end

return var_0_0
