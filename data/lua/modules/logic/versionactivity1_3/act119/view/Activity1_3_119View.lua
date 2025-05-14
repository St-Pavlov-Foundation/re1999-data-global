module("modules.logic.versionactivity1_3.act119.view.Activity1_3_119View", package.seeall)

local var_0_0 = class("Activity1_3_119View", BaseView)
local var_0_1 = {
	Hard = 2,
	Normal = 1
}
local var_0_2 = 6
local var_0_3 = 3

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Title/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Title/#txt_LimitTime")
	arg_1_0._simageBookLeft = gohelper.findChildSingleImage(arg_1_0.viewGO, "Book/BookLower/#simage_BookLeft")
	arg_1_0._simageBookRight = gohelper.findChildSingleImage(arg_1_0.viewGO, "Book/BookLower/#simage_BookRight")
	arg_1_0._simageFolderNormalBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Book/Folder/#simage_FolderNormalBG")
	arg_1_0._simageFolderHardBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Book/Folder/#simage_FolderHardBG")
	arg_1_0._goTabList = gohelper.findChild(arg_1_0.viewGO, "Book/Folder/#go_TabList")
	arg_1_0._goTabItem = gohelper.findChild(arg_1_0.viewGO, "Book/Folder/#go_TabList/#go_TabItem")
	arg_1_0._simagePhoto = gohelper.findChildSingleImage(arg_1_0.viewGO, "Book/#simage_Photo")
	arg_1_0._simagePageLeft = gohelper.findChildSingleImage(arg_1_0.viewGO, "Book/BookPage/#simage_PageLeft")
	arg_1_0._simagePageRight = gohelper.findChildSingleImage(arg_1_0.viewGO, "Book/BookPage/#simage_PageRight")
	arg_1_0._simagePhotoIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Book/BookInfo/PageLeft/LeftUp/#simage_Photo")
	arg_1_0._simagePhotoNormalBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Book/BookInfo/PageLeft/LeftUp/#simage_PhotoNormalBG")
	arg_1_0._simagePhotoHardBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Book/BookInfo/PageLeft/LeftUp/#simage_PhotoHardBG")
	arg_1_0._txtPhotoBigNum = gohelper.findChildText(arg_1_0.viewGO, "Book/BookInfo/PageLeft/LeftUp/#txt_PhotoBigNum")
	arg_1_0._txtPhotoSmallNum = gohelper.findChildText(arg_1_0.viewGO, "Book/BookInfo/PageLeft/LeftUp/#txt_PhotoBigNum/#txt_PhotoSmallNum")
	arg_1_0._txtPhotoName = gohelper.findChildText(arg_1_0.viewGO, "Book/BookInfo/PageLeft/LeftUp/#txt_PhotoBigNum/#txt_PhotoName")
	arg_1_0._goNormalSelected = gohelper.findChild(arg_1_0.viewGO, "Book/BookInfo/PageLeft/LeftMiddle/#go_NormalSelected")
	arg_1_0._goHardSelected = gohelper.findChild(arg_1_0.viewGO, "Book/BookInfo/PageLeft/LeftMiddle/#go_HardSelected")
	arg_1_0._goHardLocked = gohelper.findChild(arg_1_0.viewGO, "Book/BookInfo/PageLeft/LeftMiddle/#go_HardLocked")
	arg_1_0._btnNormal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Book/BookInfo/PageLeft/LeftMiddle/#btn_Normal")
	arg_1_0._btnHard = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Book/BookInfo/PageLeft/LeftMiddle/#btn_Hard")
	arg_1_0._txtRecommendLevelNum = gohelper.findChildText(arg_1_0.viewGO, "Book/BookInfo/PageLeft/LeftDown/LevelInfo/txt_RecommendLevel/#txt_RecommendLevelNum")
	arg_1_0._txtLevelDesc = gohelper.findChildText(arg_1_0.viewGO, "Book/BookInfo/PageLeft/LeftDown/LevelInfo/#txt_LevelDesc")
	arg_1_0._scrollSampleRole = gohelper.findChildScrollRect(arg_1_0.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#scroll_SampleRole")
	arg_1_0._goSampleRole = gohelper.findChild(arg_1_0.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#scroll_SampleRole/Viewport/#go_SampleRole")
	arg_1_0._goSampleRoleItem = gohelper.findChild(arg_1_0.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#scroll_SampleRole/Viewport/#go_SampleRole/#go_SampleRoleItem")
	arg_1_0._imageQualityBG = gohelper.findChildImage(arg_1_0.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#scroll_SampleRole/Viewport/#go_SampleRole/#go_SampleRoleItem/#image_QualityBG")
	arg_1_0._imageRoleIcon = gohelper.findChildImage(arg_1_0.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#scroll_SampleRole/Viewport/#go_SampleRole/#go_SampleRoleItem/image_Mask/#image_RoleIcon")
	arg_1_0._gosamplehero = gohelper.findChild(arg_1_0.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#go_samplehero")
	arg_1_0._txtNormalTaskDesc = gohelper.findChildText(arg_1_0.viewGO, "Book/BookInfo/PageRight/NormalTask/Content/#txt_NormalTaskDesc")
	arg_1_0._goNormalComplete = gohelper.findChild(arg_1_0.viewGO, "Book/BookInfo/PageRight/NormalTask/#go_NormalComplete")
	arg_1_0._txtHardTaskDesc1 = gohelper.findChildText(arg_1_0.viewGO, "Book/BookInfo/PageRight/HardTask1/Content/#txt_NormalTaskDesc")
	arg_1_0._gohardComplete1 = gohelper.findChild(arg_1_0.viewGO, "Book/BookInfo/PageRight/HardTask1/#go_NormalComplete")
	arg_1_0._txtHardTaskDesc2 = gohelper.findChildText(arg_1_0.viewGO, "Book/BookInfo/PageRight/HardTask2/Content/#txt_NormalTaskDesc")
	arg_1_0._gohardComplete2 = gohelper.findChild(arg_1_0.viewGO, "Book/BookInfo/PageRight/HardTask2/#go_NormalComplete")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bookleft/leftup/#simage_icon")
	arg_1_0._goStartBtn = gohelper.findChild(arg_1_0.viewGO, "Book/BookInfo/#go_StartBtn")
	arg_1_0._btnStartNormal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Book/BookInfo/#go_StartBtn/#btn_StartNormal")
	arg_1_0._btnStartHard = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Book/BookInfo/#go_StartBtn/#btn_StartHard")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")
	arg_1_0._goTaskGroup1 = gohelper.findChild(arg_1_0.viewGO, "Book/BookInfo/PageRight/NormalTask")
	arg_1_0._goTaskGroup2 = gohelper.findChild(arg_1_0.viewGO, "Book/BookInfo/PageRight/HardTask1")
	arg_1_0._goTaskGroup3 = gohelper.findChild(arg_1_0.viewGO, "Book/BookInfo/PageRight/HardTask2")
	arg_1_0._goTaskRewardGroup = gohelper.findChild(arg_1_0.viewGO, "Book/BookInfo/PageRight/Reward")
	arg_1_0._gosampleHeroItem = gohelper.findChild(arg_1_0.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#scroll_SampleRole/Viewport/#go_SampleRole/#go_SampleRoleItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnNormal:AddClickListener(arg_2_0._btnNormalOnClick, arg_2_0)
	arg_2_0._btnHard:AddClickListener(arg_2_0._btnHardOnClick, arg_2_0)
	arg_2_0._btnStartNormal:AddClickListener(arg_2_0._btnStartNormalOnClick, arg_2_0)
	arg_2_0._btnStartHard:AddClickListener(arg_2_0._btnStartHardOnClick, arg_2_0)
	arg_2_0:addEventCb(Activity119Controller.instance, Activity119Event.TabChange, arg_2_0.onTabChange, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0._updateLeftTime, arg_2_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_2_0._onUpdateTaskList, arg_2_0)
	TaskDispatcher.runRepeat(arg_2_0._refreshTime, arg_2_0, 60)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnNormal:RemoveClickListener()
	arg_3_0._btnHard:RemoveClickListener()
	arg_3_0._btnStartNormal:RemoveClickListener()
	arg_3_0._btnStartHard:RemoveClickListener()
	arg_3_0:removeEventCb(Activity119Controller.instance, Activity119Event.TabChange, arg_3_0.onTabChange, arg_3_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_3_0._updateLeftTime, arg_3_0)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, arg_3_0._onUpdateTaskList, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._viewOpening = true
	arg_4_0._animtor = gohelper.onceAddComponent(arg_4_0.viewGO, typeof(UnityEngine.Animator))

	arg_4_0._simageFullBG:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_fullbg"))
	arg_4_0._simagePhoto:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_characterphoto"))
	arg_4_0._simageBookLeft:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_leftlowerpagebg"))
	arg_4_0._simageBookRight:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_rightlowerpagebg"))
	arg_4_0._simageFolderNormalBG:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_normalleftsidepagebg"))
	arg_4_0._simageFolderHardBG:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_hardleftsidepagebg"))
	arg_4_0._simagePageLeft:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_leftupperpagebg"))
	arg_4_0._simagePageRight:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_rightupperpagebg"))
	arg_4_0._simagePhotoNormalBG:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_normallevelphotobg"))
	arg_4_0._simagePhotoHardBG:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_hardlevelphotobg"))
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_swath_open)
	gohelper.addUIClickAudio(arg_4_0._btnStartHard.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	gohelper.addUIClickAudio(arg_4_0._btnStartNormal.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	arg_4_0:initTabItems()
	arg_4_0:initRewardItems()

	arg_4_0.taskCanvasGroups = arg_4_0:getUserDataTb_()
	arg_4_0.taskCanvasGroups[1] = gohelper.onceAddComponent(gohelper.findChild(arg_4_0.viewGO, "Book/BookInfo/PageRight/NormalTask/Content"), typeof(UnityEngine.CanvasGroup))
	arg_4_0.taskCanvasGroups[2] = gohelper.onceAddComponent(gohelper.findChild(arg_4_0.viewGO, "Book/BookInfo/PageRight/HardTask1/Content"), typeof(UnityEngine.CanvasGroup))
	arg_4_0.taskCanvasGroups[3] = gohelper.onceAddComponent(gohelper.findChild(arg_4_0.viewGO, "Book/BookInfo/PageRight/HardTask2/Content"), typeof(UnityEngine.CanvasGroup))
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:_updateLeftTime()
	arg_6_0:_updateTabState()

	local var_6_0 = Activity119Model.instance:getData()

	arg_6_0:onTabChange(var_6_0.lastSelectDay)

	arg_6_0._viewOpening = false
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.onDestroyView(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._refreshTime, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._delayRefreshActionBtnView, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._playUnLockAnim, arg_8_0)

	for iter_8_0 = 1, #arg_8_0.tabs do
		arg_8_0.tabs[iter_8_0]:dispose()
	end

	arg_8_0.tabs = nil

	for iter_8_1 = 1, #arg_8_0.heroItems do
		arg_8_0.heroItems[iter_8_1]:dispose()
	end

	arg_8_0.heroItems = nil

	for iter_8_2 = 1, #arg_8_0.rewards do
		arg_8_0.rewards[iter_8_2]:dispose()
	end

	arg_8_0.rewards = nil

	arg_8_0._simageFullBG:UnLoadImage()
	arg_8_0._simagePhoto:UnLoadImage()
	arg_8_0._simageBookLeft:UnLoadImage()
	arg_8_0._simageBookRight:UnLoadImage()
	arg_8_0._simageFolderNormalBG:UnLoadImage()
	arg_8_0._simageFolderHardBG:UnLoadImage()
	arg_8_0._simagePageLeft:UnLoadImage()
	arg_8_0._simagePageRight:UnLoadImage()
	arg_8_0._simagePhotoNormalBG:UnLoadImage()
	arg_8_0._simagePhotoHardBG:UnLoadImage()
end

function var_0_0.initTabItems(arg_9_0)
	gohelper.setActive(arg_9_0._goTabItem, false)

	arg_9_0.tabs = {}

	for iter_9_0 = 1, var_0_2 do
		local var_9_0 = Activity1_3_119TabItem.New()
		local var_9_1 = gohelper.cloneInPlace(arg_9_0._goTabItem, "tab_" .. iter_9_0)

		gohelper.setActive(var_9_1, true)
		var_9_0:init(var_9_1, iter_9_0)

		arg_9_0.tabs[iter_9_0] = var_9_0
	end
end

function var_0_0.initRewardItems(arg_10_0)
	gohelper.setActive(arg_10_0._goTaskRewardGroup, false)

	arg_10_0.rewards = {}

	for iter_10_0 = 1, var_0_3 do
		local var_10_0 = Activity1_3_119RewardItem.New()
		local var_10_1 = arg_10_0["_goTaskGroup" .. iter_10_0]
		local var_10_2 = gohelper.clone(arg_10_0._goTaskRewardGroup, var_10_1, "RewardItem")

		transformhelper.setLocalPos(var_10_2.transform, 0, 0, 0)
		gohelper.setActive(var_10_2, true)
		var_10_0:init(var_10_2)

		arg_10_0.rewards[iter_10_0] = var_10_0
	end
end

function var_0_0.onTabChange(arg_11_0, arg_11_1)
	if arg_11_0.curIndex == arg_11_1 then
		return
	end

	local var_11_0 = Activity119Model.instance:getData()

	if var_11_0.lastSelectDay ~= arg_11_1 then
		var_11_0.lastSelectDay = arg_11_1

		Activity119Model.instance:saveData()
	end

	if arg_11_0.curIndex then
		arg_11_0.tabs[arg_11_0.curIndex]:changeSelect(false)
	end

	arg_11_0._config = Activity119Config.instance:getConfig(VersionActivity1_3Enum.ActivityId.Act307, arg_11_1)
	arg_11_0.curIndex = arg_11_1

	arg_11_0.tabs[arg_11_0.curIndex]:changeSelect(true)

	arg_11_0._curMode = nil

	if var_11_0.lastSelectModel == var_0_1.Normal or not arg_11_0:isHardUnLock() then
		arg_11_0:_btnNormalOnClick()
	else
		arg_11_0:_btnHardOnClick()
	end

	arg_11_0:_refreshPageLeftDesc(arg_11_0._config, arg_11_0.curIndex)
	arg_11_0:_refreshTaskInfo()
	arg_11_0:_resetTrialHeroPos()
end

function var_0_0._btnNormalOnClick(arg_12_0)
	local var_12_0 = arg_12_0._curMode

	arg_12_0._curMode = var_0_1.Normal

	local var_12_1 = Activity119Model.instance:getData()

	if var_12_1.lastSelectModel ~= var_0_1.Normal then
		var_12_1.lastSelectModel = var_0_1.Normal

		Activity119Model.instance:saveData()
	end

	if not var_12_0 or var_12_0 ~= arg_12_0._curMode then
		arg_12_0._animtor.enabled = true

		arg_12_0._animtor:Play("tonormal")
		arg_12_0:_refreshModeInfo(arg_12_0._curMode)
	end

	if var_12_0 and var_12_0 ~= arg_12_0._curMode then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end
end

function var_0_0._btnHardOnClick(arg_13_0)
	if not arg_13_0:isHardUnLock() then
		GameFacade.showToast(ToastEnum.Act119HardLock)

		return
	end

	local var_13_0 = Activity119Model.instance:getData()

	if var_13_0.lastSelectModel ~= var_0_1.Hard then
		var_13_0.lastSelectModel = var_0_1.Hard

		Activity119Model.instance:saveData()
	end

	local var_13_1 = arg_13_0._curMode

	arg_13_0._curMode = var_0_1.Hard

	if not var_13_1 or var_13_1 ~= arg_13_0._curMode then
		arg_13_0._animtor.enabled = true

		arg_13_0._animtor:Play("tohard")
		arg_13_0:_refreshModeInfo(arg_13_0._curMode)
	end

	if var_13_1 and var_13_1 ~= arg_13_0._curMode then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end
end

function var_0_0._btnStartNormalOnClick(arg_14_0)
	if not ActivityModel.instance:isActOnLine(VersionActivity1_3Enum.ActivityId.Act307) then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local var_14_0 = arg_14_0._config.normalCO.id
	local var_14_1 = DungeonConfig.instance:getEpisodeCO(var_14_0)

	DungeonFightController.instance:enterFight(var_14_1.chapterId, var_14_0)
end

function var_0_0._btnStartHardOnClick(arg_15_0)
	if not ActivityModel.instance:isActOnLine(VersionActivity1_3Enum.ActivityId.Act307) then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local var_15_0 = arg_15_0._config.hardCO.id
	local var_15_1 = DungeonConfig.instance:getEpisodeCO(var_15_0)

	DungeonFightController.instance:enterFight(var_15_1.chapterId, var_15_0)
end

function var_0_0._refreshPageLeftDesc(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._simagePhotoIcon:LoadImage(ResUrl.getDreamTailImage(arg_16_1.normalCO.icon))

	arg_16_0._txtPhotoBigNum.text = string.format("%02d", arg_16_2)
	arg_16_0._txtPhotoSmallNum.text = string.format("TRAINING NO.%s", arg_16_2)
	arg_16_0._txtPhotoName.text = arg_16_1.normalCO.name
end

function var_0_0._refreshModeInfo(arg_17_0, arg_17_1)
	arg_17_0:_resetTrialHeroPos()

	local var_17_0 = arg_17_1 == var_0_1.Hard and arg_17_0._config.hardCO or arg_17_0._config.normalCO
	local var_17_1 = DungeonConfig.instance:getEpisodeCO(var_17_0.id)
	local var_17_2 = DungeonConfig.instance:getBattleCo(var_17_1.id)
	local var_17_3 = var_17_2 and string.splitToNumber(var_17_2.monsterGroupIds, "#")
	local var_17_4 = var_17_3 and var_17_3[1]
	local var_17_5 = var_17_4 and lua_monster_group.configDict[var_17_4]
	local var_17_6 = var_17_5 and var_17_5.monster
	local var_17_7 = var_17_6 and string.splitToNumber(var_17_6, "#")[1]
	local var_17_8 = var_17_7 and lua_monster.configDict[var_17_7]
	local var_17_9 = var_17_8 and HeroConfig.instance:getCommonLevelDisplay(var_17_8.level) or ""

	arg_17_0._txtRecommendLevelNum.text = var_17_9
	arg_17_0._txtLevelDesc.text = var_17_0.des

	HeroGroupTrialModel.instance:setTrialByBattleId(var_17_1.battleId)
	arg_17_0:_updateTrialHeroItems()

	local var_17_10 = Activity119Model.instance:getData()

	if not arg_17_0:_checkAndPlayUnLockAnim(var_17_10, arg_17_0.curIndex, arg_17_0._viewOpening) then
		arg_17_0:_refreshHardUnlockView()
	end

	TaskDispatcher.runDelay(arg_17_0._delayRefreshActionBtnView, arg_17_0, 0.2)
end

function var_0_0._resetTrialHeroPos(arg_18_0)
	local var_18_0 = arg_18_0._gosamplehero.transform
	local var_18_1 = var_18_0.localPosition

	transformhelper.setLocalPosXY(var_18_0, 0, var_18_1.y)
end

function var_0_0._updateTrialHeroItems(arg_19_0)
	gohelper.setActive(arg_19_0._gosampleHeroItem, false)

	if not arg_19_0.heroItems then
		arg_19_0.heroItems = {}
	end

	local var_19_0 = HeroGroupTrialModel.instance:getList()

	for iter_19_0 = 1, #var_19_0 do
		local var_19_1 = arg_19_0.heroItems[iter_19_0]

		if not var_19_1 then
			var_19_1 = Activity1_3_119TrialHeroItem.New()

			local var_19_2 = gohelper.cloneInPlace(arg_19_0._gosampleHeroItem, "Hero" .. iter_19_0)

			var_19_1:init(var_19_2, iter_19_0)

			arg_19_0.heroItems[iter_19_0] = var_19_1
		end

		gohelper.setActive(var_19_1.go, true)
		var_19_1:updateMO()
	end

	for iter_19_1 = #var_19_0 + 1, #arg_19_0.heroItems do
		gohelper.setActive(arg_19_0.heroItems[iter_19_1].go, false)
	end
end

function var_0_0._refreshTaskInfo(arg_20_0)
	local var_20_0 = arg_20_0._config.taskList

	arg_20_0._txtNormalTaskDesc.text = var_20_0[1].desc
	arg_20_0._txtHardTaskDesc1.text = var_20_0[2].desc
	arg_20_0._txtHardTaskDesc2.text = var_20_0[3].desc

	local var_20_1 = arg_20_0:isHardUnLock()

	for iter_20_0 = 1, 3 do
		arg_20_0.rewards[iter_20_0]:setBonus(var_20_0[iter_20_0].bonus, var_20_0[iter_20_0].id, iter_20_0 == 1 or var_20_1)
	end

	arg_20_0:_updateTaskStatus()
	arg_20_0:calcTxtLen()
end

function var_0_0._refreshHardUnlockView(arg_21_0)
	gohelper.setActive(arg_21_0._goHardLocked, not arg_21_0:isHardUnLock())
end

function var_0_0._delayRefreshActionBtnView(arg_22_0)
	gohelper.setActive(arg_22_0._btnStartNormal.gameObject, arg_22_0._curMode ~= var_0_1.Hard)
	gohelper.setActive(arg_22_0._btnStartHard.gameObject, arg_22_0._curMode == var_0_1.Hard)
end

function var_0_0._onUpdateTaskList(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(arg_23_1.taskInfo) do
		if iter_23_1.type == TaskEnum.TaskType.Activity119 then
			arg_23_0:_updateTabState()
			arg_23_0:_updateTaskStatus()
		end
	end
end

function var_0_0._updateTaskStatus(arg_24_0)
	local var_24_0 = arg_24_0._config.taskList

	for iter_24_0 = 1, 3 do
		local var_24_1 = TaskModel.instance:getTaskById(var_24_0[iter_24_0].id)
		local var_24_2 = Activity119Enum.TaskStatus.Unfinished

		if var_24_1 then
			if var_24_1.finishCount > 0 then
				var_24_2 = Activity119Enum.TaskStatus.GotReward
			elseif var_24_1.hasFinished then
				var_24_2 = Activity119Enum.TaskStatus.Finished
			end
		end

		arg_24_0.rewards[iter_24_0]:updateTaskStatus(var_24_2)

		arg_24_0.taskCanvasGroups[iter_24_0].alpha = var_24_2 == Activity119Enum.TaskStatus.GotReward and 0.4 or 1

		if iter_24_0 == 1 then
			gohelper.setActive(arg_24_0._goNormalComplete, var_24_2 == Activity119Enum.TaskStatus.GotReward)
		elseif iter_24_0 == 2 then
			gohelper.setActive(arg_24_0._gohardComplete1, var_24_2 == Activity119Enum.TaskStatus.GotReward)
		elseif iter_24_0 == 3 then
			gohelper.setActive(arg_24_0._gohardComplete2, var_24_2 == Activity119Enum.TaskStatus.GotReward)
		end
	end
end

function var_0_0.calcTxtLen(arg_25_0)
	if not arg_25_0._txtnormalTaskDesc then
		return
	end

	arg_25_0:updateLineLen(gohelper.findChildTextMesh(arg_25_0.viewGO, "Book/BookInfo/PageRight/NormalTask/Content/txt_NormalTaskTitle"), arg_25_0._txtnormalTaskDesc, arg_25_0._goNormalComplete)
	arg_25_0:updateLineLen(gohelper.findChildTextMesh(arg_25_0.viewGO, "Book/BookInfo/PageRight/HardTask1/Content/txt_NormalTaskTitle"), arg_25_0._txthardTaskDesc1, arg_25_0._gohardComplete1)
	arg_25_0:updateLineLen(gohelper.findChildTextMesh(arg_25_0.viewGO, "Book/BookInfo/PageRight/HardTask2/Content/txt_NormalTaskTitle"), arg_25_0._txthardTaskDesc2, arg_25_0._gohardComplete2)
end

function var_0_0.updateLineLen(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = gohelper.findChild(arg_26_3, "image_Complete1")
	local var_26_1 = gohelper.findChild(arg_26_3, "image_Complete2")
	local var_26_2 = gohelper.findChild(arg_26_3, "image_Complete3")
	local var_26_3 = arg_26_1:GetTextInfo(arg_26_1.text).lineInfo

	recthelper.setWidth(var_26_0.transform, var_26_3[0].length + 17)

	local var_26_4 = arg_26_2:GetTextInfo(arg_26_2.text).lineInfo

	recthelper.setWidth(var_26_1.transform, var_26_4[0].length + 25)

	if var_26_4.Length <= 1 or var_26_4[1].length <= 1 then
		gohelper.setActive(var_26_2, false)
	else
		gohelper.setActive(var_26_2, true)
		recthelper.setWidth(var_26_2.transform, var_26_4[1].length + 25)
	end
end

function var_0_0._updateLeftTime(arg_27_0)
	local var_27_0 = ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act307)

	if not var_27_0 or not arg_27_0.tabs then
		return
	end

	local var_27_1 = math.ceil((ServerTime.now() - var_27_0:getRealStartTimeStamp()) / 86400)
	local var_27_2 = Activity119Model.instance:getData()
	local var_27_3 = Activity119Config.instance:getConfig(VersionActivity1_3Enum.ActivityId.Act307, var_27_2.lastSelectDay)

	if not var_27_3 or var_27_1 < var_27_3.normalCO.openDay then
		var_27_2.lastSelectDay = 1

		Activity119Model.instance:saveData()
	end

	for iter_27_0 = 1, var_0_2 do
		arg_27_0.tabs[iter_27_0]:updateLock(var_27_1)
	end

	arg_27_0:_refreshTime()
end

function var_0_0._refreshTime(arg_28_0)
	local var_28_0 = ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act307)

	if not var_28_0 or not var_28_0.online then
		arg_28_0._txtLimitTime.text = luaLang("versionactivity_1_2_114enterview_isend")
	else
		arg_28_0._txtLimitTime.text = string.format(luaLang("remain"), var_28_0:getRemainTimeStr2ByEndTime())
	end
end

function var_0_0._updateTabState(arg_29_0)
	for iter_29_0 = 1, var_0_2 do
		arg_29_0.tabs[iter_29_0]:updateFinishView()
	end
end

function var_0_0._playUnLockAnim(arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._playUnLockAnim, arg_30_0)

	arg_30_0._animtor.enabled = true

	arg_30_0._animtor:Play(UIAnimationName.Unlock)
end

function var_0_0._checkAndPlayUnLockAnim(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_0:isHardUnLock() and not tabletool.indexOf(arg_31_1.unLockHardList, arg_31_2) then
		table.insert(arg_31_1.unLockHardList, arg_31_2)
		Activity119Model.instance:saveData()

		if arg_31_3 then
			TaskDispatcher.runDelay(arg_31_0._playUnLockAnim, arg_31_0, 1)
		else
			arg_31_0:_playUnLockAnim()
		end

		return true
	end
end

function var_0_0.isHardUnLock(arg_32_0)
	return DungeonModel.instance:hasPassLevel(arg_32_0._config.normalCO.id)
end

return var_0_0
