module("modules.logic.versionactivity1_3.act119.view.Activity1_3_119View", package.seeall)

slot0 = class("Activity1_3_119View", BaseView)
slot1 = {
	Hard = 2,
	Normal = 1
}
slot2 = 6
slot3 = 3

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Title/#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Title/#txt_LimitTime")
	slot0._simageBookLeft = gohelper.findChildSingleImage(slot0.viewGO, "Book/BookLower/#simage_BookLeft")
	slot0._simageBookRight = gohelper.findChildSingleImage(slot0.viewGO, "Book/BookLower/#simage_BookRight")
	slot0._simageFolderNormalBG = gohelper.findChildSingleImage(slot0.viewGO, "Book/Folder/#simage_FolderNormalBG")
	slot0._simageFolderHardBG = gohelper.findChildSingleImage(slot0.viewGO, "Book/Folder/#simage_FolderHardBG")
	slot0._goTabList = gohelper.findChild(slot0.viewGO, "Book/Folder/#go_TabList")
	slot0._goTabItem = gohelper.findChild(slot0.viewGO, "Book/Folder/#go_TabList/#go_TabItem")
	slot0._simagePhoto = gohelper.findChildSingleImage(slot0.viewGO, "Book/#simage_Photo")
	slot0._simagePageLeft = gohelper.findChildSingleImage(slot0.viewGO, "Book/BookPage/#simage_PageLeft")
	slot0._simagePageRight = gohelper.findChildSingleImage(slot0.viewGO, "Book/BookPage/#simage_PageRight")
	slot0._simagePhotoIcon = gohelper.findChildSingleImage(slot0.viewGO, "Book/BookInfo/PageLeft/LeftUp/#simage_Photo")
	slot0._simagePhotoNormalBG = gohelper.findChildSingleImage(slot0.viewGO, "Book/BookInfo/PageLeft/LeftUp/#simage_PhotoNormalBG")
	slot0._simagePhotoHardBG = gohelper.findChildSingleImage(slot0.viewGO, "Book/BookInfo/PageLeft/LeftUp/#simage_PhotoHardBG")
	slot0._txtPhotoBigNum = gohelper.findChildText(slot0.viewGO, "Book/BookInfo/PageLeft/LeftUp/#txt_PhotoBigNum")
	slot0._txtPhotoSmallNum = gohelper.findChildText(slot0.viewGO, "Book/BookInfo/PageLeft/LeftUp/#txt_PhotoBigNum/#txt_PhotoSmallNum")
	slot0._txtPhotoName = gohelper.findChildText(slot0.viewGO, "Book/BookInfo/PageLeft/LeftUp/#txt_PhotoBigNum/#txt_PhotoName")
	slot0._goNormalSelected = gohelper.findChild(slot0.viewGO, "Book/BookInfo/PageLeft/LeftMiddle/#go_NormalSelected")
	slot0._goHardSelected = gohelper.findChild(slot0.viewGO, "Book/BookInfo/PageLeft/LeftMiddle/#go_HardSelected")
	slot0._goHardLocked = gohelper.findChild(slot0.viewGO, "Book/BookInfo/PageLeft/LeftMiddle/#go_HardLocked")
	slot0._btnNormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "Book/BookInfo/PageLeft/LeftMiddle/#btn_Normal")
	slot0._btnHard = gohelper.findChildButtonWithAudio(slot0.viewGO, "Book/BookInfo/PageLeft/LeftMiddle/#btn_Hard")
	slot0._txtRecommendLevelNum = gohelper.findChildText(slot0.viewGO, "Book/BookInfo/PageLeft/LeftDown/LevelInfo/txt_RecommendLevel/#txt_RecommendLevelNum")
	slot0._txtLevelDesc = gohelper.findChildText(slot0.viewGO, "Book/BookInfo/PageLeft/LeftDown/LevelInfo/#txt_LevelDesc")
	slot0._scrollSampleRole = gohelper.findChildScrollRect(slot0.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#scroll_SampleRole")
	slot0._goSampleRole = gohelper.findChild(slot0.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#scroll_SampleRole/Viewport/#go_SampleRole")
	slot0._goSampleRoleItem = gohelper.findChild(slot0.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#scroll_SampleRole/Viewport/#go_SampleRole/#go_SampleRoleItem")
	slot0._imageQualityBG = gohelper.findChildImage(slot0.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#scroll_SampleRole/Viewport/#go_SampleRole/#go_SampleRoleItem/#image_QualityBG")
	slot0._imageRoleIcon = gohelper.findChildImage(slot0.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#scroll_SampleRole/Viewport/#go_SampleRole/#go_SampleRoleItem/image_Mask/#image_RoleIcon")
	slot0._gosamplehero = gohelper.findChild(slot0.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#go_samplehero")
	slot0._txtNormalTaskDesc = gohelper.findChildText(slot0.viewGO, "Book/BookInfo/PageRight/NormalTask/Content/#txt_NormalTaskDesc")
	slot0._goNormalComplete = gohelper.findChild(slot0.viewGO, "Book/BookInfo/PageRight/NormalTask/#go_NormalComplete")
	slot0._txtHardTaskDesc1 = gohelper.findChildText(slot0.viewGO, "Book/BookInfo/PageRight/HardTask1/Content/#txt_NormalTaskDesc")
	slot0._gohardComplete1 = gohelper.findChild(slot0.viewGO, "Book/BookInfo/PageRight/HardTask1/#go_NormalComplete")
	slot0._txtHardTaskDesc2 = gohelper.findChildText(slot0.viewGO, "Book/BookInfo/PageRight/HardTask2/Content/#txt_NormalTaskDesc")
	slot0._gohardComplete2 = gohelper.findChild(slot0.viewGO, "Book/BookInfo/PageRight/HardTask2/#go_NormalComplete")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "bookleft/leftup/#simage_icon")
	slot0._goStartBtn = gohelper.findChild(slot0.viewGO, "Book/BookInfo/#go_StartBtn")
	slot0._btnStartNormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "Book/BookInfo/#go_StartBtn/#btn_StartNormal")
	slot0._btnStartHard = gohelper.findChildButtonWithAudio(slot0.viewGO, "Book/BookInfo/#go_StartBtn/#btn_StartHard")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")
	slot0._goTaskGroup1 = gohelper.findChild(slot0.viewGO, "Book/BookInfo/PageRight/NormalTask")
	slot0._goTaskGroup2 = gohelper.findChild(slot0.viewGO, "Book/BookInfo/PageRight/HardTask1")
	slot0._goTaskGroup3 = gohelper.findChild(slot0.viewGO, "Book/BookInfo/PageRight/HardTask2")
	slot0._goTaskRewardGroup = gohelper.findChild(slot0.viewGO, "Book/BookInfo/PageRight/Reward")
	slot0._gosampleHeroItem = gohelper.findChild(slot0.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#scroll_SampleRole/Viewport/#go_SampleRole/#go_SampleRoleItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnNormal:AddClickListener(slot0._btnNormalOnClick, slot0)
	slot0._btnHard:AddClickListener(slot0._btnHardOnClick, slot0)
	slot0._btnStartNormal:AddClickListener(slot0._btnStartNormalOnClick, slot0)
	slot0._btnStartHard:AddClickListener(slot0._btnStartHardOnClick, slot0)
	slot0:addEventCb(Activity119Controller.instance, Activity119Event.TabChange, slot0.onTabChange, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._updateLeftTime, slot0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, slot0._onUpdateTaskList, slot0)
	TaskDispatcher.runRepeat(slot0._refreshTime, slot0, 60)
end

function slot0.removeEvents(slot0)
	slot0._btnNormal:RemoveClickListener()
	slot0._btnHard:RemoveClickListener()
	slot0._btnStartNormal:RemoveClickListener()
	slot0._btnStartHard:RemoveClickListener()
	slot0:removeEventCb(Activity119Controller.instance, Activity119Event.TabChange, slot0.onTabChange, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0._updateLeftTime, slot0)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, slot0._onUpdateTaskList, slot0)
end

function slot0._editableInitView(slot0)
	slot0._viewOpening = true
	slot0._animtor = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animator))

	slot0._simageFullBG:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_fullbg"))
	slot0._simagePhoto:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_characterphoto"))
	slot0._simageBookLeft:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_leftlowerpagebg"))
	slot0._simageBookRight:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_rightlowerpagebg"))
	slot0._simageFolderNormalBG:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_normalleftsidepagebg"))
	slot0._simageFolderHardBG:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_hardleftsidepagebg"))
	slot0._simagePageLeft:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_leftupperpagebg"))
	slot0._simagePageRight:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_rightupperpagebg"))
	slot0._simagePhotoNormalBG:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_normallevelphotobg"))
	slot0._simagePhotoHardBG:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_hardlevelphotobg"))
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_swath_open)
	gohelper.addUIClickAudio(slot0._btnStartHard.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	gohelper.addUIClickAudio(slot0._btnStartNormal.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	slot0:initTabItems()
	slot0:initRewardItems()

	slot0.taskCanvasGroups = slot0:getUserDataTb_()
	slot0.taskCanvasGroups[1] = gohelper.onceAddComponent(gohelper.findChild(slot0.viewGO, "Book/BookInfo/PageRight/NormalTask/Content"), typeof(UnityEngine.CanvasGroup))
	slot0.taskCanvasGroups[2] = gohelper.onceAddComponent(gohelper.findChild(slot0.viewGO, "Book/BookInfo/PageRight/HardTask1/Content"), typeof(UnityEngine.CanvasGroup))
	slot0.taskCanvasGroups[3] = gohelper.onceAddComponent(gohelper.findChild(slot0.viewGO, "Book/BookInfo/PageRight/HardTask2/Content"), typeof(UnityEngine.CanvasGroup))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_updateLeftTime()
	slot0:_updateTabState()
	slot0:onTabChange(Activity119Model.instance:getData().lastSelectDay)

	slot0._viewOpening = false
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._refreshTime, slot0)
	TaskDispatcher.cancelTask(slot0._delayRefreshActionBtnView, slot0)

	slot4 = slot0

	TaskDispatcher.cancelTask(slot0._playUnLockAnim, slot4)

	for slot4 = 1, #slot0.tabs do
		slot0.tabs[slot4]:dispose()
	end

	slot0.tabs = nil

	for slot4 = 1, #slot0.heroItems do
		slot0.heroItems[slot4]:dispose()
	end

	slot0.heroItems = nil

	for slot4 = 1, #slot0.rewards do
		slot0.rewards[slot4]:dispose()
	end

	slot0.rewards = nil

	slot0._simageFullBG:UnLoadImage()
	slot0._simagePhoto:UnLoadImage()
	slot0._simageBookLeft:UnLoadImage()
	slot0._simageBookRight:UnLoadImage()
	slot0._simageFolderNormalBG:UnLoadImage()
	slot0._simageFolderHardBG:UnLoadImage()
	slot0._simagePageLeft:UnLoadImage()
	slot0._simagePageRight:UnLoadImage()
	slot0._simagePhotoNormalBG:UnLoadImage()
	slot0._simagePhotoHardBG:UnLoadImage()
end

function slot0.initTabItems(slot0)
	slot4 = false

	gohelper.setActive(slot0._goTabItem, slot4)

	slot0.tabs = {}

	for slot4 = 1, uv0 do
		slot5 = Activity1_3_119TabItem.New()
		slot6 = gohelper.cloneInPlace(slot0._goTabItem, "tab_" .. slot4)

		gohelper.setActive(slot6, true)
		slot5:init(slot6, slot4)

		slot0.tabs[slot4] = slot5
	end
end

function slot0.initRewardItems(slot0)
	slot4 = false

	gohelper.setActive(slot0._goTaskRewardGroup, slot4)

	slot0.rewards = {}

	for slot4 = 1, uv0 do
		slot5 = Activity1_3_119RewardItem.New()
		slot7 = gohelper.clone(slot0._goTaskRewardGroup, slot0["_goTaskGroup" .. slot4], "RewardItem")

		transformhelper.setLocalPos(slot7.transform, 0, 0, 0)
		gohelper.setActive(slot7, true)
		slot5:init(slot7)

		slot0.rewards[slot4] = slot5
	end
end

function slot0.onTabChange(slot0, slot1)
	if slot0.curIndex == slot1 then
		return
	end

	if Activity119Model.instance:getData().lastSelectDay ~= slot1 then
		slot2.lastSelectDay = slot1

		Activity119Model.instance:saveData()
	end

	if slot0.curIndex then
		slot0.tabs[slot0.curIndex]:changeSelect(false)
	end

	slot0._config = Activity119Config.instance:getConfig(VersionActivity1_3Enum.ActivityId.Act307, slot1)
	slot0.curIndex = slot1

	slot0.tabs[slot0.curIndex]:changeSelect(true)

	slot0._curMode = nil

	if slot2.lastSelectModel == uv0.Normal or not slot0:isHardUnLock() then
		slot0:_btnNormalOnClick()
	else
		slot0:_btnHardOnClick()
	end

	slot0:_refreshPageLeftDesc(slot0._config, slot0.curIndex)
	slot0:_refreshTaskInfo()
	slot0:_resetTrialHeroPos()
end

function slot0._btnNormalOnClick(slot0)
	slot1 = slot0._curMode
	slot0._curMode = uv0.Normal

	if Activity119Model.instance:getData().lastSelectModel ~= uv0.Normal then
		slot2.lastSelectModel = uv0.Normal

		Activity119Model.instance:saveData()
	end

	if not slot1 or slot1 ~= slot0._curMode then
		slot0._animtor.enabled = true

		slot0._animtor:Play("tonormal")
		slot0:_refreshModeInfo(slot0._curMode)
	end

	if slot1 and slot1 ~= slot0._curMode then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end
end

function slot0._btnHardOnClick(slot0)
	if not slot0:isHardUnLock() then
		GameFacade.showToast(ToastEnum.Act119HardLock)

		return
	end

	if Activity119Model.instance:getData().lastSelectModel ~= uv0.Hard then
		slot1.lastSelectModel = uv0.Hard

		Activity119Model.instance:saveData()
	end

	slot0._curMode = uv0.Hard

	if not slot0._curMode or slot2 ~= slot0._curMode then
		slot0._animtor.enabled = true

		slot0._animtor:Play("tohard")
		slot0:_refreshModeInfo(slot0._curMode)
	end

	if slot2 and slot2 ~= slot0._curMode then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end
end

function slot0._btnStartNormalOnClick(slot0)
	if not ActivityModel.instance:isActOnLine(VersionActivity1_3Enum.ActivityId.Act307) then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	slot1 = slot0._config.normalCO.id

	DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot1).chapterId, slot1)
end

function slot0._btnStartHardOnClick(slot0)
	if not ActivityModel.instance:isActOnLine(VersionActivity1_3Enum.ActivityId.Act307) then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	slot1 = slot0._config.hardCO.id

	DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot1).chapterId, slot1)
end

function slot0._refreshPageLeftDesc(slot0, slot1, slot2)
	slot0._simagePhotoIcon:LoadImage(ResUrl.getDreamTailImage(slot1.normalCO.icon))

	slot0._txtPhotoBigNum.text = string.format("%02d", slot2)
	slot0._txtPhotoSmallNum.text = string.format("TRAINING NO.%s", slot2)
	slot0._txtPhotoName.text = slot1.normalCO.name
end

function slot0._refreshModeInfo(slot0, slot1)
	slot0:_resetTrialHeroPos()

	slot2 = slot1 == uv0.Hard and slot0._config.hardCO or slot0._config.normalCO
	slot5 = DungeonConfig.instance:getBattleCo(DungeonConfig.instance:getEpisodeCO(slot2.id).id) and string.splitToNumber(slot4.monsterGroupIds, "#")
	slot6 = slot5 and slot5[1]
	slot7 = slot6 and lua_monster_group.configDict[slot6]
	slot8 = slot7 and slot7.monster
	slot9 = slot8 and string.splitToNumber(slot8, "#")[1]
	slot10 = slot9 and lua_monster.configDict[slot9]
	slot0._txtRecommendLevelNum.text = slot10 and HeroConfig.instance:getCommonLevelDisplay(slot10.level) or ""
	slot0._txtLevelDesc.text = slot2.des

	HeroGroupTrialModel.instance:setTrialByBattleId(slot3.battleId)
	slot0:_updateTrialHeroItems()

	if not slot0:_checkAndPlayUnLockAnim(Activity119Model.instance:getData(), slot0.curIndex, slot0._viewOpening) then
		slot0:_refreshHardUnlockView()
	end

	TaskDispatcher.runDelay(slot0._delayRefreshActionBtnView, slot0, 0.2)
end

function slot0._resetTrialHeroPos(slot0)
	slot1 = slot0._gosamplehero.transform

	transformhelper.setLocalPosXY(slot1, 0, slot1.localPosition.y)
end

function slot0._updateTrialHeroItems(slot0)
	gohelper.setActive(slot0._gosampleHeroItem, false)

	if not slot0.heroItems then
		slot0.heroItems = {}
	end

	for slot5 = 1, #HeroGroupTrialModel.instance:getList() do
		if not slot0.heroItems[slot5] then
			slot6 = Activity1_3_119TrialHeroItem.New()

			slot6:init(gohelper.cloneInPlace(slot0._gosampleHeroItem, "Hero" .. slot5), slot5)

			slot0.heroItems[slot5] = slot6
		end

		gohelper.setActive(slot6.go, true)
		slot6:updateMO()
	end

	for slot5 = #slot1 + 1, #slot0.heroItems do
		gohelper.setActive(slot0.heroItems[slot5].go, false)
	end
end

function slot0._refreshTaskInfo(slot0)
	slot1 = slot0._config.taskList
	slot0._txtNormalTaskDesc.text = slot1[1].desc
	slot0._txtHardTaskDesc1.text = slot1[2].desc
	slot0._txtHardTaskDesc2.text = slot1[3].desc

	for slot6 = 1, 3 do
		slot0.rewards[slot6]:setBonus(slot1[slot6].bonus, slot1[slot6].id, slot6 == 1 or slot0:isHardUnLock())
	end

	slot0:_updateTaskStatus()
	slot0:calcTxtLen()
end

function slot0._refreshHardUnlockView(slot0)
	gohelper.setActive(slot0._goHardLocked, not slot0:isHardUnLock())
end

function slot0._delayRefreshActionBtnView(slot0)
	gohelper.setActive(slot0._btnStartNormal.gameObject, slot0._curMode ~= uv0.Hard)
	gohelper.setActive(slot0._btnStartHard.gameObject, slot0._curMode == uv0.Hard)
end

function slot0._onUpdateTaskList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.taskInfo) do
		if slot6.type == TaskEnum.TaskType.Activity119 then
			slot0:_updateTabState()
			slot0:_updateTaskStatus()
		end
	end
end

function slot0._updateTaskStatus(slot0)
	for slot5 = 1, 3 do
		slot7 = Activity119Enum.TaskStatus.Unfinished

		if TaskModel.instance:getTaskById(slot0._config.taskList[slot5].id) then
			if slot6.finishCount > 0 then
				slot7 = Activity119Enum.TaskStatus.GotReward
			elseif slot6.hasFinished then
				slot7 = Activity119Enum.TaskStatus.Finished
			end
		end

		slot0.rewards[slot5]:updateTaskStatus(slot7)

		slot0.taskCanvasGroups[slot5].alpha = slot7 == Activity119Enum.TaskStatus.GotReward and 0.4 or 1

		if slot5 == 1 then
			gohelper.setActive(slot0._goNormalComplete, slot7 == Activity119Enum.TaskStatus.GotReward)
		elseif slot5 == 2 then
			gohelper.setActive(slot0._gohardComplete1, slot7 == Activity119Enum.TaskStatus.GotReward)
		elseif slot5 == 3 then
			gohelper.setActive(slot0._gohardComplete2, slot7 == Activity119Enum.TaskStatus.GotReward)
		end
	end
end

function slot0.calcTxtLen(slot0)
	if not slot0._txtnormalTaskDesc then
		return
	end

	slot0:updateLineLen(gohelper.findChildTextMesh(slot0.viewGO, "Book/BookInfo/PageRight/NormalTask/Content/txt_NormalTaskTitle"), slot0._txtnormalTaskDesc, slot0._goNormalComplete)
	slot0:updateLineLen(gohelper.findChildTextMesh(slot0.viewGO, "Book/BookInfo/PageRight/HardTask1/Content/txt_NormalTaskTitle"), slot0._txthardTaskDesc1, slot0._gohardComplete1)
	slot0:updateLineLen(gohelper.findChildTextMesh(slot0.viewGO, "Book/BookInfo/PageRight/HardTask2/Content/txt_NormalTaskTitle"), slot0._txthardTaskDesc2, slot0._gohardComplete2)
end

function slot0.updateLineLen(slot0, slot1, slot2, slot3)
	recthelper.setWidth(gohelper.findChild(slot3, "image_Complete1").transform, slot1:GetTextInfo(slot1.text).lineInfo[0].length + 17)

	slot7 = slot2:GetTextInfo(slot2.text).lineInfo

	recthelper.setWidth(gohelper.findChild(slot3, "image_Complete2").transform, slot7[0].length + 25)

	if slot7.Length <= 1 or slot7[1].length <= 1 then
		gohelper.setActive(gohelper.findChild(slot3, "image_Complete3"), false)
	else
		gohelper.setActive(slot6, true)
		recthelper.setWidth(slot6.transform, slot7[1].length + 25)
	end
end

function slot0._updateLeftTime(slot0)
	if not ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act307) or not slot0.tabs then
		return
	end

	if not Activity119Config.instance:getConfig(VersionActivity1_3Enum.ActivityId.Act307, Activity119Model.instance:getData().lastSelectDay) or math.ceil((ServerTime.now() - slot1:getRealStartTimeStamp()) / 86400) < slot4.normalCO.openDay then
		slot3.lastSelectDay = 1

		Activity119Model.instance:saveData()
	end

	for slot8 = 1, uv0 do
		slot0.tabs[slot8]:updateLock(slot2)
	end

	slot0:_refreshTime()
end

function slot0._refreshTime(slot0)
	if not ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act307) or not slot1.online then
		slot0._txtLimitTime.text = luaLang("versionactivity_1_2_114enterview_isend")
	else
		slot0._txtLimitTime.text = string.format(luaLang("remain"), slot1:getRemainTimeStr2ByEndTime())
	end
end

function slot0._updateTabState(slot0)
	for slot4 = 1, uv0 do
		slot0.tabs[slot4]:updateFinishView()
	end
end

function slot0._playUnLockAnim(slot0)
	TaskDispatcher.cancelTask(slot0._playUnLockAnim, slot0)

	slot0._animtor.enabled = true

	slot0._animtor:Play(UIAnimationName.Unlock)
end

function slot0._checkAndPlayUnLockAnim(slot0, slot1, slot2, slot3)
	if slot0:isHardUnLock() and not tabletool.indexOf(slot1.unLockHardList, slot2) then
		table.insert(slot1.unLockHardList, slot2)
		Activity119Model.instance:saveData()

		if slot3 then
			TaskDispatcher.runDelay(slot0._playUnLockAnim, slot0, 1)
		else
			slot0:_playUnLockAnim()
		end

		return true
	end
end

function slot0.isHardUnLock(slot0)
	return DungeonModel.instance:hasPassLevel(slot0._config.normalCO.id)
end

return slot0
