module("modules.logic.dungeon.view.DungeonView", package.seeall)

slot0 = class("DungeonView", BaseView)

function slot0.onInitView(slot0)
	slot0._gostory = gohelper.findChild(slot0.viewGO, "#go_story")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_story/#simage_bg")
	slot0._scrollchapter = gohelper.findChildScrollRect(slot0.viewGO, "#go_story/chapterlist/#scroll_chapter")
	slot0._goresource = gohelper.findChild(slot0.viewGO, "#go_resource")
	slot0._simageresourcebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_resource/#simage_resourcebg")
	slot0._simagedrawbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_resource/#simage_drawbg")
	slot0._scrollchapterresource = gohelper.findChildScrollRect(slot0.viewGO, "#go_resource/chapterlist/#scroll_chapter_resource")
	slot0._gorescontent = gohelper.findChild(slot0.viewGO, "#go_resource/chapterlist/#scroll_chapter_resource/#go_rescontent")
	slot0._goweekwalk = gohelper.findChild(slot0.viewGO, "#go_weekwalk")
	slot0._goexplore = gohelper.findChild(slot0.viewGO, "#go_explore")
	slot0._btnstory = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/categorylist/#btn_story")
	slot0._gostoryUnselectText = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_story/#go_storyUnselectText")
	slot0._gostorySelectText = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_story/#go_storySelectText")
	slot0._btnexplore = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/categorylist/#btn_secretroom")
	slot0._goexploreUnselectText = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_secretroom/#go_secretroomUnselectText")
	slot0._goexploreSelectText = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_secretroom/#go_secretroomSelectText")
	slot0._gogoldUnselectIcon = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_gold/#go_goldUnselectText/icon")
	slot0._gogoldRedPoint = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_gold/#go_goldUnselectText/icon_redpoint")
	slot0._btngold = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/categorylist/#btn_gold")
	slot0._gogoldUnselectText = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_gold/#go_goldUnselectText")
	slot0._gogoldSelectText = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_gold/#go_goldSelectText")
	slot0._btnresource = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/categorylist/#btn_resource")
	slot0._goresUnselectText = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_resource/#go_resUnselectText")
	slot0._goresSelectText = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_resource/#go_resSelectText")
	slot0._btnweekwalk = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/categorylist/#btn_weekwalk")
	slot0._goweekwalkUnselectText = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkUnselectText")
	slot0._goweekwalkSelectText = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkSelectText")
	slot0._goweekwalkicon = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkUnselectText/#go_weekwalk_icon")
	slot0._goweekwalkreward1 = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkUnselectText/#go_weekwalk_reward1")
	slot0._goweekwalkreward2 = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkUnselectText/#go_weekwalk_reward2")
	slot0._btnrouge = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/categorylist/#btn_rouge")
	slot0._gorougeUnselectText = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_rouge/#go_rougeUnselectText")
	slot0._gorougeSelectText = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_rouge/#go_rougeSelectText")
	slot0._goRoleStory = gohelper.findChild(slot0.viewGO, "#go_RoleStory")
	slot0._btnanecdote = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/categorylist/#btn_anecdote")
	slot0._goanecdoteUnselectText = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_anecdote/#go_anecdoteUnselectText")
	slot0._goanecdoteSelectText = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_anecdote/#go_anecdoteSelectText")
	slot0._goanecdoteUnRed = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_anecdote/#go_anecdoteUnselectText/icon")
	slot0._goanecdoteRed = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_anecdote/#go_anecdoteUnselectText/icon1")

	RedDotController.instance:addRedDotTag(slot0._goanecdoteUnRed, RedDotEnum.DotNode.RoleStory, true)
	RedDotController.instance:addRedDotTag(slot0._goanecdoteRed, RedDotEnum.DotNode.RoleStory)

	slot0._gopermanent = gohelper.findChild(slot0.viewGO, "#go_permanent")
	slot0._btnpermanent = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/categorylist/#btn_permanent")
	slot0._goperUnselectText = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_permanent/#go_perUnselectText")
	slot0._goperUnselectIcon = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_permanent/#go_perUnselectText/icon")
	slot0._goperSelectText = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_permanent/#go_perSelectText")
	slot0._goreddotpermanent = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_permanent/#go_perUnselectText/redpoint")

	RedDotController.instance:addRedDotTag(slot0._goreddotpermanent, RedDotEnum.DotNode.Dungeon_Permanent, false, slot0._checkPermanentReddot, slot0)

	slot0._btnDramaReward = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_story/#btn_story")
	slot0._gostoryUnselectTextIcon = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_story/#go_storyUnselectText/icon")
	slot0._goreddotstory = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_story/#go_storyUnselectText/redpoint")
	slot0.storyUnSelectIconTag = RedDotController.instance:addRedDotTag(slot0._gostoryUnselectTextIcon, RedDotEnum.DotNode.HeroInvitationReward, true, slot0.refreshStoryIcon, slot0)
	slot0.storySelectIconTag = RedDotController.instance:addRedDotTag(slot0._goreddotstory, RedDotEnum.DotNode.HeroInvitationReward, nil, slot0.refreshStoryIcon, slot0)
	slot0._btntower = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/categorylist/#btn_tower")
	slot0._gotowerUnselectText = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_tower/#go_towerUnselectText")
	slot0._gotowerSelectText = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_tower/#go_towerSelectText")
	slot0._gotowerReddotEffect = gohelper.findChild(slot0.viewGO, "bottom/categorylist/#btn_tower/#go_towerUnselectText/redpoint")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnpermanent:AddClickListener(slot0._btnpermanentOnClick, slot0)
	slot0._btnrouge:AddClickListener(slot0._btnrougeOnClick, slot0)
	slot0._btnexplore:AddClickListener(slot0._btnexploreOnClick, slot0)
	slot0._btnstory:AddClickListener(slot0._btnstoryOnClick, slot0)
	slot0._btngold:AddClickListener(slot0._btngoldOnClick, slot0)
	slot0._btnresource:AddClickListener(slot0._btnresourceOnClick, slot0)
	slot0._btnweekwalk:AddClickListener(slot0._btnweekwalkOnClick, slot0)
	slot0._btnanecdote:AddClickListener(slot0._btnanecdoteOnClick, slot0)
	slot0._btnDramaReward:AddClickListener(slot0._btnDramaRewardOnClick, slot0)
	slot0._btntower:AddClickListener(slot0._btnTowerOnClick, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ResidentStoryChange, slot0._onResidentStoryChange, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.RefreshTowerReddot, slot0._showTowerEffect, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnpermanent:RemoveClickListener()
	slot0._btnrouge:RemoveClickListener()
	slot0._btnexplore:RemoveClickListener()
	slot0._btnstory:RemoveClickListener()
	slot0._btngold:RemoveClickListener()
	slot0._btnresource:RemoveClickListener()
	slot0._btnweekwalk:RemoveClickListener()
	slot0._btnanecdote:RemoveClickListener()
	slot0._btnDramaReward:RemoveClickListener()
	slot0._btntower:RemoveClickListener()
	slot0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.ResidentStoryChange, slot0._onResidentStoryChange, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.RefreshTowerReddot, slot0._showTowerEffect, slot0)
end

function slot0._btnTowerOnClick(slot0)
	TowerController.instance:openMainView()
end

function slot0._btnpermanentOnClick(slot0)
	if DungeonModel.instance:chapterListIsPermanent() then
		return
	end

	slot0:changeCategory(DungeonEnum.ChapterType.PermanentActivity)
	slot0:setBtnStatus()
end

function slot0._btnanecdoteOnClick(slot0)
	if DungeonModel.instance:chapterListIsRoleStory() then
		return
	end

	slot0:changeCategory(DungeonEnum.ChapterType.RoleStory)
	slot0:setBtnStatus()
end

function slot0._btnweekwalkOnClick(slot0)
	slot0:changeCategory(DungeonEnum.ChapterType.WeekWalk, false)
	module_views_preloader.DungeonViewWeekWalk(function ()
		uv0:setBtnStatus()
	end)
end

function slot0._btnexploreOnClick(slot0)
	slot0:changeCategory(DungeonEnum.ChapterType.Explore, false)
	module_views_preloader.DungeonViewExplore(function ()
		uv0:setBtnStatus()
	end)
end

function slot0._btnrougeOnClick(slot0)
	RougeController.instance:openRougeMainView()
end

function slot0._btnDramaRewardOnClick(slot0)
	DungeonRpc.instance:sendGetMainDramaRewardRequest()
end

function slot0._onNavigateCloseCallback(slot0)
	slot0.viewContainer:setOverrideClose(nil, )
	gohelper.setActive(slot0._gocategory, true)
	slot0:_btnstoryOnClick()
end

function slot0._onExploreClose(slot0)
	if slot0.viewContainer:getExploreView() then
		slot1:onHide(slot0._realCloseSubView, slot0)
	end
end

function slot0._realCloseSubView(slot0)
	slot0.viewContainer:setOverrideClose(nil, )
	gohelper.setActive(slot0._gocategory, true)
	slot0:_btnstoryOnClick()
end

function slot0._btnstoryOnClick(slot0)
	if DungeonModel.instance:chapterListIsNormalType() then
		return
	end

	slot0:changeCategory(DungeonEnum.ChapterType.Normal)
	slot0:setBtnStatus()
	slot0:_delayOnShowStoryView()
	TaskDispatcher.cancelTask(slot0._delayOnShowStoryView, slot0)
	TaskDispatcher.runDelay(slot0._delayOnShowStoryView, slot0, 0)
end

function slot0._delayOnShowStoryView(slot0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnShowStoryView)
end

function slot0._btnmainOnClick(slot0)
	slot0:closeThis()
end

function slot0._btngoldOnClick(slot0)
	if DungeonModel.instance:chapterListIsResType() then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.GainDungeon) then
		slot0:changeCategory(DungeonEnum.ChapterType.Gold)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickDungeonCategory)
		module_views_preloader.DungeonViewGold(function ()
			uv0:setBtnStatus()
		end)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.GainDungeon))
	end
end

function slot0._btnresourceOnClick(slot0)
	if DungeonModel.instance:chapterListIsBreakType() then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ResDungeon) then
		slot0:changeCategory(DungeonEnum.ChapterType.Break)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickDungeonCategory)
		module_views_preloader.DungeonViewBreak(function ()
			uv0:setBtnStatus()
		end)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.ResDungeon))
	end
end

function slot0.changeCategory(slot0, slot1, slot2)
	if DungeonModel.instance.curChapterType == slot1 then
		return
	end

	if slot1 == DungeonEnum.ChapterType.Normal then
		slot0._scrollchapter.horizontalNormalizedPosition = 0
	else
		slot0._scrollchapterresource.horizontalNormalizedPosition = 0

		if DungeonModel.instance.resScrollPosX then
			recthelper.setAnchorX(slot0._scrollchapterresource.transform, DungeonModel.instance.resScrollPosX)

			DungeonModel.instance.resScrollPosX = nil
		end
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeChapterList, slot1)
	DungeonModel.instance:changeCategory(slot1, slot2)
end

function slot0._btnbackOnClick(slot0)
	slot0:closeThis()
end

function slot0.playCategoryAnimation(slot0)
	gohelper.setActive(slot0._btnstory.gameObject, true)
	gohelper.setActive(slot0._btnresource.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ResDungeon))
	gohelper.setActive(slot0._btngold.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.GainDungeon))
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getDungeonIcon("full/bg1"))

	slot0._gocategory = gohelper.findChild(slot0.viewGO, "bottom/categorylist")

	gohelper.addUIClickAudio(slot0._btnstory.gameObject, AudioEnum.UI.UI_checkpoint_story_Click)
	gohelper.addUIClickAudio(slot0._btngold.gameObject, AudioEnum.UI.UI_checkpoint_resources_Click)
	gohelper.addUIClickAudio(slot0._btnresource.gameObject, AudioEnum.UI.UI_checkpoint_Insight_Click)
	gohelper.addUIClickAudio(slot0._btnweekwalk.gameObject, AudioEnum.UI.UI_checkpoint_story_Click)
end

function slot0._isShowWeekWalk(slot0)
	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.WeekWalk) then
		return false
	end

	if GuideController.instance:isForbidGuides() then
		return true
	end

	if VersionValidator.instance:isInReviewing() then
		return true
	end

	if not GuideModel.instance:getById(501) then
		return false
	end

	if slot3.isFinish then
		return true
	end

	return slot3.currStepId > 1
end

function slot0._isShowExplore(slot0)
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

function slot0._refreshBtnUnlock(slot0)
	gohelper.setActive(slot0._btngold.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.GainDungeon))
	gohelper.setActive(slot0._btnweekwalk.gameObject, slot0:_isShowWeekWalk())
	gohelper.setActive(slot0._btnexplore.gameObject, slot0:_isShowExplore())
	gohelper.setActive(slot0._btnresource.gameObject, DungeonModel.instance:getChapterListOpenTimeValid(DungeonEnum.ChapterType.Break) and OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ResDungeon))
	gohelper.setActive(slot0._btnanecdote, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.RoleStory) and RoleStoryModel.instance:isInResident() and (VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS()) == false)
	gohelper.setActive(slot0._btnpermanent, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Permanent) and PermanentModel.instance:hasActivityOnline())
	gohelper.setActive(slot0._btnrouge, RougeOutsideController.instance:isOpen())
	gohelper.setActive(slot0._btntower, TowerController.instance:isOpen())
end

function slot0.setBtnStatus(slot0)
	slot1, slot2, slot3, slot4, slot5, slot6 = DungeonModel.instance:getChapterListTypes()
	slot7 = DungeonModel.instance:chapterListIsRoleStory()
	slot8 = DungeonModel.instance:chapterListIsPermanent()
	slot9 = false
	slot10 = false
	slot1 = slot1 or slot5

	gohelper.setActive(slot0._gostorySelectText, slot1)
	gohelper.setActive(slot0._gostoryUnselectText, not slot1)
	gohelper.setActive(slot0._goexploreSelectText, slot6)
	gohelper.setActive(slot0._goexploreUnselectText, not slot6)
	gohelper.setActive(slot0._gogoldSelectText, slot2)
	gohelper.setActive(slot0._gogoldUnselectText, not slot2)
	gohelper.setActive(slot0._goresSelectText, slot3)
	gohelper.setActive(slot0._goresUnselectText, not slot3)
	gohelper.setActive(slot0._goweekwalkSelectText, slot4)
	gohelper.setActive(slot0._goweekwalkUnselectText, not slot4)
	gohelper.setActive(slot0._gorougeSelectText, slot9)
	gohelper.setActive(slot0._gorougeUnselectText, not slot9)
	gohelper.setActive(slot0._gocategory, not slot4 and not slot6)
	gohelper.setActive(slot0._goanecdoteUnselectText, not slot7)
	gohelper.setActive(slot0._goanecdoteSelectText, slot7)
	gohelper.setActive(slot0._goperUnselectText, not slot8)
	gohelper.setActive(slot0._goperSelectText, slot8)
	gohelper.setActive(slot0._gotowerSelectText, slot10)
	gohelper.setActive(slot0._gotowerUnselectText, not slot10)

	if slot6 then
		slot0.viewContainer:setOverrideClose(slot0._onExploreClose, slot0)
	elseif slot4 then
		slot0.viewContainer:setOverrideClose(slot0._onNavigateCloseCallback, slot0)
	else
		slot0.viewContainer:setOverrideClose(nil, )
	end

	if slot1 then
		gohelper.setActive(slot0._gostory, false)

		if not slot0._firstShowNormal then
			slot0._firstShowNormal = true
			DungeonChapterListModel.instance.firstShowNormalTime = Time.time
		end

		if slot0._moveChapterId then
			slot0:_focusNormalChapter(slot0._moveChapterId)
		end
	end

	gohelper.setActive(slot0._gostory, slot1)
	gohelper.setActive(slot0._goresource, slot2 or slot3)
	gohelper.setActive(slot0._goweekwalk, slot4)
	gohelper.setActive(slot0._goexplore, slot6)
	gohelper.setActive(slot0._gopermanent, slot8)
	DungeonModel.instance:setDungeonStoryviewState(slot1)
	slot0:refreshRoleStoryStatus()

	if slot2 or slot3 then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnShowResourceView)
	end

	if slot4 then
		slot0.viewContainer:switchTab(1)
	elseif slot6 then
		slot0.viewContainer:switchTab(2)
	elseif slot8 then
		slot0.viewContainer:switchTab(3)
	else
		slot0.viewContainer:switchTab()
	end

	if DungeonModel.instance.resScrollPosX then
		recthelper.setAnchorX(slot0._scrollchapterresource.transform, DungeonModel.instance.resScrollPosX)

		DungeonModel.instance.resScrollPosX = nil
	end

	slot0:_showWeekWalkEffect()
	slot0:_showGoldEffect()
	slot0:_showTowerEffect()
	AudioBgmManager.instance:checkBgm()
end

function slot0._showWeekWalkEffect(slot0)
	slot2 = WeekWalkModel.instance:getInfo()
	slot3 = WeekWalkTaskListModel.instance:canGetReward(WeekWalkEnum.TaskType.Week) or slot2 and slot2.isPopShallowSettle
	slot4 = slot2 and slot2.isPopDeepSettle

	gohelper.setActive(slot0._goweekwalkreward1, slot3)
	gohelper.setActive(slot0._goweekwalkreward2, not slot3 and slot4)
	gohelper.setActive(slot0._goweekwalkicon, not slot3 and not slot4)
end

function slot0._showGoldEffect(slot0)
	slot1 = DungeonModel.instance:getEquipRemainingNum() > 0

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.EquipDungeon) then
		gohelper.setActive(slot0._gogoldUnselectIcon, not slot1)
		gohelper.setActive(slot0._gogoldRedPoint, slot1)
	else
		gohelper.setActive(slot0._gogoldUnselectIcon, true)
		gohelper.setActive(slot0._gogoldRedPoint, false)
	end
end

function slot0._showTowerEffect(slot0)
	if not TowerController.instance:isOpen() then
		return
	end

	gohelper.setActive(slot0._gotowerReddotEffect, TowerTaskModel.instance:getTaskItemCanGetCount(TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Tower) or {}) > 0 or TowerPermanentModel.instance:checkCanShowMopUpReddot() or TowerController.instance:checkReddotHasNewUpdateTower())
end

function slot0.onUpdateParam(slot0)
	slot0:setBtnStatus()
end

function slot0.onOpen(slot0)
	if ViewMgr.instance:isOpen(ViewName.MainView) then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Main_enterance)
	end

	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeChapter, slot0._onChangeChapter, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, slot0._refreshBtnUnlock, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.DestroyViewFinish, slot0._onDestroyViewFinish, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnDramaRewardStatusChange, slot0._refreshDramaBtnStatus, slot0)
	slot0:_refreshDramaBtnStatus()
	slot0:_moveChapter()
	slot0:_refreshBtnUnlock()
	slot0:playCategoryAnimation()
end

function slot0._moveChapter(slot0, slot1)
	if not slot1 then
		slot2, slot3 = DungeonModel.instance:getLastEpisodeConfigAndInfo()
		slot1 = slot2.chapterId
	end

	slot0._moveChapterId = slot1

	slot0:setBtnStatus()

	slot0._moveChapter = nil

	DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterDungeonChatperView, slot0._moveChapterId)
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.DungeonMapView and DungeonModel.instance.chapterTriggerNewChapter then
		slot0:_focusNormalChapter(DungeonModel.instance.unlockNewChapterId)
	end
end

function slot0._focusNormalChapter(slot0, slot1)
	slot0._scrollchapter.movementType = 2

	recthelper.setAnchorX(gohelper.findChild(slot0._scrollchapter.gameObject, "content").transform, -(slot0.viewContainer:getScrollParam().startSpace + DungeonChapterListModel.instance:getMixCellPos(slot1) - recthelper.getWidth(slot0._scrollchapter.transform) / 2))
	TaskDispatcher.cancelTask(slot0._resetMovementType, slot0)
	TaskDispatcher.runDelay(slot0._resetMovementType, slot0, 0)
	slot0.viewContainer:getScrollView():refreshScroll()
end

function slot0._resetMovementType(slot0)
	slot0._scrollchapter.movementType = 1
end

function slot0._onDestroyViewFinish(slot0, slot1)
end

function slot0._onChangeChapter(slot0, slot1)
	if not DungeonModel.instance:chapterListIsNormalType() then
		return
	end

	slot0:_moveChapter(slot1)
end

function slot0.refreshRoleStoryStatus(slot0)
	slot1 = DungeonModel.instance:chapterListIsRoleStory()

	slot0:setRoleStoryStatus((RoleStoryModel.instance:isInResident() or RoleStoryModel.instance:checkActStoryOpen()) and slot1)

	if slot1 and not slot2 and not slot3 then
		slot0:_btnstoryOnClick()
		slot0:_refreshBtnUnlock()
	end
end

function slot0.setRoleStoryStatus(slot0, slot1)
	if slot1 then
		if not slot0._roleStoryView then
			slot0._roleStoryView = RoleStoryView.New(slot0._goRoleStory)
		end

		slot0._roleStoryView:show()
	elseif slot0._roleStoryView then
		slot0._roleStoryView:hide()
	end
end

function slot0._onResidentStoryChange(slot0)
	slot0:refreshRoleStoryStatus()
end

function slot0.destoryRoleStory(slot0)
	if slot0._roleStoryView then
		slot0._roleStoryView:destory()

		slot0._roleStoryView = nil
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._resetMovementType, slot0)
	TaskDispatcher.cancelTask(slot0._delayOnShowStoryView, slot0)
	slot0:destoryRoleStory()
end

function slot0._refreshDramaBtnStatus(slot0)
	slot0.storyUnSelectIconTag:refreshDot()
	slot0.storySelectIconTag:refreshDot()

	slot1 = DungeonModel.instance:isCanGetDramaReward()

	gohelper.setActive(slot0._btnDramaReward, slot1)

	if slot1 and slot0.viewParam and slot2.fromMainView then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnShowDramaRewardGuide)
	end
end

function slot0.refreshStoryIcon(slot0, slot1)
	if slot1.reverse then
		slot2 = not (RedDotModel.instance:isDotShow(slot1.dotId, 0) or DungeonModel.instance:isCanGetDramaReward())
	end

	gohelper.setActive(slot1.go, slot2)
end

function slot0._checkPermanentReddot(slot0, slot1)
	slot2 = RedDotModel.instance:isDotShow(slot1.dotId, 0) or not PermanentModel.instance:isActivityLocalRead()

	gohelper.setActive(slot0._goperUnselectIcon, not slot2)
	gohelper.setActive(slot0._goreddotpermanent, slot2)
end

return slot0
