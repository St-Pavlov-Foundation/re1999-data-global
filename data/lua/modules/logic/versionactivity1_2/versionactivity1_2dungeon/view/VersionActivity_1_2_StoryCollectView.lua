module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_StoryCollectView", package.seeall)

local var_0_0 = class("VersionActivity_1_2_StoryCollectView", BaseViewExtended)
local var_0_1 = 12110

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebookbg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_bookbg1")
	arg_1_0._simagebookbg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_bookbg2")
	arg_1_0._simagebookbg3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_bookbg3")
	arg_1_0._simagebookbg4 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_bookbg4")
	arg_1_0._simagebookbg5 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_bookbg1/#simage_bookbg5")
	arg_1_0._simageleftbookbg5 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/left/#simage_bookbg5")
	arg_1_0._simagebookbg6 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/left/#simage_bookbg6")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/left/title/#simage_title")
	arg_1_0._txttitleName = gohelper.findChildText(arg_1_0.viewGO, "root/left/title/#txt_titleName")
	arg_1_0._gofinishIcon = gohelper.findChild(arg_1_0.viewGO, "root/left/title/#txt_titleName/#go_finishIcon")
	arg_1_0._txttitleIndex = gohelper.findChildText(arg_1_0.viewGO, "root/left/title/#txt_titleIndex")
	arg_1_0._goleftNoteContent = gohelper.findChild(arg_1_0.viewGO, "root/left/#go_leftNoteContent")
	arg_1_0._gocategory = gohelper.findChild(arg_1_0.viewGO, "root/left/#go_category")
	arg_1_0._gocategoryItem = gohelper.findChild(arg_1_0.viewGO, "root/left/#go_category/#go_categoryItem")
	arg_1_0._gorightNoteContent = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_rightNoteContent")
	arg_1_0._gorightEmpty = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_rightEmpty")
	arg_1_0._gocollectReward = gohelper.findChild(arg_1_0.viewGO, "root/right/collect/rewardItem/#go_collectReward")
	arg_1_0._txtequiplv = gohelper.findChildText(arg_1_0.viewGO, "root/right/collect/rewardItem/#go_collectReward/commonitemicon/#txt_equiplv")
	arg_1_0._goequipcareer = gohelper.findChild(arg_1_0.viewGO, "root/right/collect/rewardItem/#go_collectReward/commonitemicon/click/#go_equipcareer")
	arg_1_0._gorefinebg = gohelper.findChild(arg_1_0.viewGO, "root/right/collect/rewardItem/#go_collectReward/commonitemicon/click/#go_equipcareer/#go_refinebg")
	arg_1_0._goboth = gohelper.findChild(arg_1_0.viewGO, "root/right/collect/rewardItem/#go_collectReward/commonitemicon/click/#go_equipcareer/#go_both")
	arg_1_0._imagecarrer = gohelper.findChildImage(arg_1_0.viewGO, "root/right/collect/rewardItem/#go_collectReward/commonitemicon/click/#go_equipcareer/#go_both/#image_carrer")
	arg_1_0._txtrefinelv = gohelper.findChildText(arg_1_0.viewGO, "root/right/collect/rewardItem/#go_collectReward/commonitemicon/click/#go_equipcareer/#txt_refinelv")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "root/right/collect/rewardItem/#go_finish")
	arg_1_0._gocanget = gohelper.findChild(arg_1_0.viewGO, "root/right/collect/#go_canget")
	arg_1_0._gocollectNote = gohelper.findChild(arg_1_0.viewGO, "root/right/collect/#go_collectNote")
	arg_1_0._gocollectProcess = gohelper.findChild(arg_1_0.viewGO, "root/right/collect/#go_collectProcess")
	arg_1_0._txtcollectProcess = gohelper.findChildText(arg_1_0.viewGO, "root/right/collect/#go_collectProcess/txt/#txt_collectProcess")
	arg_1_0._gocollectContent = gohelper.findChild(arg_1_0.viewGO, "root/right/collect/#go_collectProcess/#go_collectContent")
	arg_1_0._gocollectItem = gohelper.findChild(arg_1_0.viewGO, "root/right/collect/#go_collectProcess/#go_collectContent/#go_collectItem")
	arg_1_0._gocollectFinish = gohelper.findChild(arg_1_0.viewGO, "root/right/collect/#go_collectFinish")
	arg_1_0._btntidyclue = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/collect/#go_collectFinish/#btn_tidyclue")
	arg_1_0._gonoteItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_noteItem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._goblock = gohelper.findChild(arg_1_0.viewGO, "root/#go_block")
	arg_1_0._root = gohelper.findChild(arg_1_0.viewGO, "root")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "#go_mask")
	arg_1_0._gomaskGuide = gohelper.findChild(arg_1_0.viewGO, "#go_mask_guide")
	arg_1_0._maskClick = gohelper.getClick(arg_1_0._gomask)
	arg_1_0._ani = gohelper.onceAddComponent(arg_1_0._root, typeof(UnityEngine.Animator))
	arg_1_0._goCollectProcessAni = gohelper.onceAddComponent(arg_1_0._gocollectProcess, typeof(UnityEngine.Animator))
	arg_1_0._goCollectFinishAni = gohelper.onceAddComponent(arg_1_0._gocollectFinish, typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntidyclue:AddClickListener(arg_2_0._btntidyclueOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._maskClick:AddClickListener(arg_2_0._onMaskClick, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveGet121BonusReply, arg_2_0._onReceiveGet121BonusReply, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.focusCollectedAllClueTab, arg_2_0._focusCollectedAllClueTab, arg_2_0)
	arg_2_0:addEventCb(GuideController.instance, GuideEvent.StoryCollectViewSelectTab, arg_2_0._selectStoryTabByGuide, arg_2_0)
	arg_2_0:addEventCb(GuideController.instance, GuideEvent.ShowMarkingStoryInView, arg_2_0._markingKeyWordInStory, arg_2_0)
	arg_2_0:addEventCb(GuideController.instance, GuideEvent.ShowMarkingStoryAllDone, arg_2_0._onLastShowFlowDone, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_2_0._OnRemoveElement, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntidyclue:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._maskClick:RemoveClickListener()
end

function var_0_0._onReceiveGet121BonusReply(arg_4_0, arg_4_1)
	if not arg_4_0._selectConfig then
		return
	end

	if arg_4_1 == arg_4_0._selectConfig.id then
		arg_4_0.bonusFinished = VersionActivity1_2NoteModel.instance:getBonusFinished(arg_4_0._selectConfig.id)

		arg_4_0:_showCollectData()
	end
end

function var_0_0._btntidyclueOnClick(arg_5_0)
	arg_5_0:_markNote()
	arg_5_0:_playMarkClueAni()
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._simagebookbg1:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben03"))
	arg_7_0._simagebookbg2:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben04"))
	arg_7_0._simagebookbg3:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben01"))
	arg_7_0._simagebookbg4:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben02"))
	arg_7_0._simagebookbg5:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben07"))
	arg_7_0._simageleftbookbg5:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben05"))
	arg_7_0._simagebookbg6:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben06"))
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_mail_open)
	gohelper.setActive(arg_7_0._goblock, false)
	gohelper.setActive(arg_7_0._gomask, false)

	arg_7_0._activityId = VersionActivityEnum.ActivityId.Act121
	arg_7_0._storyList = VersionActivity1_2NoteConfig.instance:getStoryList()

	arg_7_0:_showBtn()
	arg_7_0:_showBtnUnlockAni()
end

function var_0_0.getBtnAniFinish(arg_8_0)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Activity1_2NoteBtnUnlockAni .. arg_8_0, 0)
end

function var_0_0.setBtnAniFinish(arg_9_0, arg_9_1)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Activity1_2NoteBtnUnlockAni .. arg_9_0, arg_9_1 or 1)
end

function var_0_0._showBtnUnlockAni(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._storyList) do
		local var_10_0 = arg_10_0._storyList[iter_10_0].id

		if DungeonModel.instance:hasPassLevel(arg_10_0._storyList[iter_10_0].episodeId) and var_0_0.getBtnAniFinish(var_10_0) == 0 then
			var_0_0.setBtnAniFinish(var_10_0)

			local var_10_1 = arg_10_0._btnList[iter_10_0]

			gohelper.setActive(gohelper.findChild(var_10_1, "go_lock"), true)
			gohelper.onceAddComponent(var_10_1, typeof(UnityEngine.Animator)):Play("unlock")
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
		end
	end
end

function var_0_0._showBtn(arg_11_0)
	arg_11_0._btnComList = arg_11_0:getUserDataTb_()
	arg_11_0._btnList = arg_11_0:getUserDataTb_()

	arg_11_0:com_createObjList(arg_11_0._onBtnShow, arg_11_0._storyList, arg_11_0._gocategory, arg_11_0._gocategoryItem)

	arg_11_0._selectIndex = 1

	arg_11_0:_refreshBtnState()
	arg_11_0:_refreshData()
end

function var_0_0._onBtnShow(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = gohelper.findChildText(arg_12_1, "go_select/txt_name")
	local var_12_1 = gohelper.findChildText(arg_12_1, "go_normal/txt_name")
	local var_12_2 = gohelper.findChild(arg_12_1, "go_normal")
	local var_12_3 = gohelper.findChild(arg_12_1, "go_select")
	local var_12_4 = gohelper.findChild(arg_12_1, "go_lock")

	var_12_0.text = arg_12_2.name
	var_12_1.text = arg_12_2.name

	local var_12_5 = DungeonModel.instance:hasPassLevel(arg_12_2.episodeId)

	gohelper.setActive(var_12_2, var_12_5)
	gohelper.setActive(var_12_3, var_12_5)
	gohelper.setActive(var_12_4, not var_12_5)

	local var_12_6 = gohelper.findChildButtonWithAudio(arg_12_1, "btn_click", AudioEnum.TeachNote.play_ui_activity_switch)

	var_12_6:RemoveClickListener()
	var_12_6:AddClickListener(arg_12_0._onBtnClick, arg_12_0, arg_12_3)
	table.insert(arg_12_0._btnComList, var_12_6)
	table.insert(arg_12_0._btnList, arg_12_1)
end

function var_0_0._refreshBtnState(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0._btnList) do
		local var_13_0 = DungeonModel.instance:hasPassLevel(arg_13_0._storyList[iter_13_0].episodeId)

		gohelper.setActive(gohelper.findChild(iter_13_1, "go_select"), var_13_0 and arg_13_0._selectIndex == iter_13_0)
		gohelper.setActive(gohelper.findChild(iter_13_1, "go_normal"), var_13_0 and arg_13_0._selectIndex ~= iter_13_0)
		gohelper.setActive(gohelper.findChild(iter_13_1, "go_lock"), not var_13_0)
	end
end

function var_0_0._onBtnClick(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._storyList[arg_14_1]

	if not DungeonModel.instance:hasPassLevel(var_14_0.episodeId) then
		GameFacade.showToast(ToastEnum.Activity1_2NoteStoryUnlockLick)

		return
	end

	if arg_14_0._selectIndex == arg_14_1 then
		return
	end

	arg_14_0._isOpened = true
	arg_14_0._selectIndex = arg_14_1

	arg_14_0:_refreshBtnState()
	arg_14_0._ani:Play("siwtch", 0, 0)
	TaskDispatcher.runDelay(arg_14_0._refreshData, arg_14_0, 0.1)
end

function var_0_0._refreshData(arg_15_0)
	arg_15_0._selectConfig = arg_15_0._storyList[arg_15_0._selectIndex]
	arg_15_0.bonusFinished = VersionActivity1_2NoteModel.instance:getBonusFinished(arg_15_0._selectConfig.id)

	local var_15_0 = string.splitToNumber(arg_15_0._selectConfig.noteIds, "|")

	arg_15_0._allClueCount = #var_15_0
	arg_15_0._haveClueCount = 0
	arg_15_0._haveNoteList = {}
	arg_15_0._noteList = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if VersionActivity1_2NoteModel.instance:getNote(iter_15_1) then
			arg_15_0._haveClueCount = arg_15_0._haveClueCount + 1
			arg_15_0._haveNoteList[iter_15_0] = iter_15_1
		end

		arg_15_0._noteList[iter_15_0] = iter_15_1
	end

	arg_15_0:_releaseSignObj()
	arg_15_0:_showNoteCollectData()
	arg_15_0:_showCollectData()

	arg_15_0._txttitleIndex.text = string.format("%02d", arg_15_0._selectIndex)

	arg_15_0:_showReward()
	arg_15_0:_refreshRedPoint()
end

function var_0_0._refreshRewardState(arg_16_0)
	gohelper.setActive(arg_16_0._gofinishIcon, arg_16_0.bonusFinished)
	gohelper.setActive(arg_16_0._gofinish, false)
end

function var_0_0._refreshRedPoint(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0._storyList) do
		gohelper.setActive(gohelper.findChild(arg_17_0._btnList[iter_17_0], "redPoint"), var_0_0.getStoryRedPoint(iter_17_1.id))
	end
end

function var_0_0._showNoteCollectData(arg_18_0)
	gohelper.setActive(arg_18_0._gorightEmpty, false)
	gohelper.setActive(arg_18_0._gorightNoteContent, true)

	arg_18_0._textList = arg_18_0:getUserDataTb_()

	arg_18_0:com_createObjList(arg_18_0._createLeftNote, 2, arg_18_0._goleftNoteContent, arg_18_0._gonoteItem)
	arg_18_0:com_createObjList(arg_18_0._createRightNote, arg_18_0._allClueCount - 2, arg_18_0._gorightNoteContent, arg_18_0._gonoteItem)

	arg_18_0._txttitleName.text = arg_18_0._selectConfig.name

	arg_18_0._simagetitle:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2(arg_18_0._selectConfig.icon))
end

function var_0_0._playUnlockNoteAni(arg_19_0)
	local var_19_0 = arg_19_0._gocollectContent.transform

	for iter_19_0 = arg_19_0._collectItemUnlockPlayIndex, arg_19_0._haveClueCount do
		local var_19_1 = gohelper.findChild(var_19_0:GetChild(iter_19_0 - 1).gameObject, "go_collected")

		gohelper.setActive(var_19_1, true)
		gohelper.onceAddComponent(var_19_1, typeof(UnityEngine.Animator)):Play("unlock", 0, 0)
	end

	for iter_19_1, iter_19_2 in ipairs(arg_19_0._playUnlockNoteAniIds) do
		local var_19_2 = arg_19_0._textList[iter_19_2].transform.parent.gameObject
		local var_19_3 = gohelper.findChildText(var_19_2, "txt_desc")
		local var_19_4 = var_19_2:GetComponent(typeof(ZProj.MaterialPropsCtrl))
		local var_19_5 = UnityEngine.Object.Instantiate(var_19_3.materialForRendering)

		var_19_3.fontMaterial = var_19_5

		var_19_4.mas:Clear()
		var_19_4.mas:Add(var_19_5)

		gohelper.onceAddComponent(var_19_2, gohelper.Type_CanvasGroup).alpha = 1
		gohelper.onceAddComponent(var_19_2, typeof(UnityEngine.Animator)).enabled = true

		gohelper.onceAddComponent(var_19_2, typeof(UnityEngine.Animator)):Play("unlock")
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_clue_unlock)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_clue_collect)
	TaskDispatcher.runDelay(arg_19_0._afterUnlockNoteAni, arg_19_0, 1)
end

function var_0_0._afterUnlockNoteAni(arg_20_0)
	if arg_20_0._haveClueCount == arg_20_0._allClueCount and not arg_20_0.bonusFinished then
		arg_20_0:_closeProcessAndShowGoCollectFinish()
	else
		arg_20_0:_refreshCollectData()
	end

	arg_20_0:_showUnlockNote()
end

function var_0_0._showUnlockNote(arg_21_0)
	if var_0_0.getFirstShowStory(arg_21_0._selectConfig.id) == 0 then
		var_0_0.setFirstShowStory(arg_21_0._selectConfig.id)

		for iter_21_0, iter_21_1 in ipairs(arg_21_0._noteList) do
			if not VersionActivity1_2NoteModel.instance:getNote(iter_21_1) then
				local var_21_0 = arg_21_0._textList[iter_21_0].transform.parent.gameObject

				gohelper.onceAddComponent(var_21_0, gohelper.Type_CanvasGroup).alpha = 1
				gohelper.onceAddComponent(var_21_0, typeof(UnityEngine.Animator)).enabled = true

				gohelper.onceAddComponent(var_21_0, typeof(UnityEngine.Animator)):Play("open")
			end
		end
	end
end

function var_0_0._showCollectData(arg_22_0)
	arg_22_0:_refreshRewardState()

	arg_22_0._playUnlockNoteAniIds = {}

	if not arg_22_0.bonusFinished then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0._noteList) do
			if VersionActivity1_2NoteModel.instance:getNote(iter_22_1) and var_0_0.getNoteItemUnlockAniFinish(iter_22_1) == 0 then
				var_0_0.setNoteItemUnlockAniFinish(iter_22_1)
				table.insert(arg_22_0._playUnlockNoteAniIds, iter_22_0)
			end
		end
	end

	arg_22_0._collectItemUnlockPlayIndex = arg_22_0._haveClueCount - #arg_22_0._playUnlockNoteAniIds + 1
	arg_22_0._txtcollectProcess.text = string.format("<color=#ad7b40>%d</color>/%d", arg_22_0._haveClueCount, arg_22_0._allClueCount)

	arg_22_0:com_createObjList(arg_22_0._onCollectPieceShow, arg_22_0._noteList, arg_22_0._gocollectContent, arg_22_0._gocollectItem)

	if #arg_22_0._playUnlockNoteAniIds > 0 then
		gohelper.setActive(arg_22_0._gocollectNote, false)
		gohelper.setActive(arg_22_0._gocollectFinish, false)
		gohelper.setActive(arg_22_0._gocollectProcess, true)
		gohelper.setActive(arg_22_0._goblock, true)

		if arg_22_0._isOpened then
			TaskDispatcher.runDelay(arg_22_0._playUnlockNoteAni, arg_22_0, 0.7)
		else
			TaskDispatcher.runDelay(arg_22_0._playUnlockNoteAni, arg_22_0, 1)
		end

		return
	end

	arg_22_0:_showUnlockNote()
	arg_22_0:_refreshCollectData()
end

function var_0_0._refreshCollectData(arg_23_0)
	gohelper.setActive(arg_23_0._gocollectNote, arg_23_0.bonusFinished)
	gohelper.setActive(arg_23_0._gocollectProcess, not arg_23_0.bonusFinished and arg_23_0._haveClueCount < arg_23_0._allClueCount)
	gohelper.setActive(arg_23_0._gocollectFinish, not arg_23_0.bonusFinished and arg_23_0._haveClueCount == arg_23_0._allClueCount)
	arg_23_0._goCollectProcessAni:Play("idle")
	arg_23_0._goCollectFinishAni:Play("open")

	if arg_23_0.bonusFinished then
		TaskDispatcher.runDelay(arg_23_0._markNote, arg_23_0, 0.02)
	end

	local var_23_0 = string.splitToNumber(arg_23_0._selectConfig.clueIds, "|")
	local var_23_1 = gohelper.findChild(arg_23_0._gocollectNote, "txt_noteItem")

	arg_23_0:com_createObjList(arg_23_0._onCollectItemShow, var_23_0, arg_23_0._gocollectNote, var_23_1)
	gohelper.setActive(arg_23_0._goblock, false)
end

function var_0_0._closeProcessAndShowGoCollectFinish(arg_24_0)
	arg_24_0._showGoCollectAniFlow = arg_24_0._showGoCollectAniFlow or FlowSequence.New()

	arg_24_0._showGoCollectAniFlow:addWork(FunctionWork.New(function()
		arg_24_0._goCollectProcessAni:Play("close")
	end))
	arg_24_0._showGoCollectAniFlow:addWork(WorkWaitSeconds.New(0.3))
	arg_24_0._showGoCollectAniFlow:addWork(FunctionWork.New(function()
		gohelper.setActive(arg_24_0._gocollectProcess, false)
		gohelper.setActive(arg_24_0._gocollectFinish, true)
		arg_24_0._goCollectFinishAni:Play("open")
		arg_24_0:_refreshCollectData()
	end))
	arg_24_0._showGoCollectAniFlow:start()
end

function var_0_0._onCollectPieceShow(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = gohelper.findChild(arg_27_1, "go_empty")
	local var_27_1 = gohelper.findChild(arg_27_1, "go_collected")
	local var_27_2 = gohelper.findChildComponent(arg_27_1, "go_collected", typeof(UIMesh))
	local var_27_3 = UnityEngine.Object.Instantiate(var_27_2.material)

	var_27_2.material = var_27_3

	local var_27_4 = var_27_1:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	var_27_4.mas:Clear()
	var_27_4.mas:Add(var_27_3)
	gohelper.onceAddComponent(var_27_1, typeof(UnityEngine.Animator)):Play("idle", 0, 0)
	gohelper.setActive(var_27_1, arg_27_3 < arg_27_0._collectItemUnlockPlayIndex)
end

function var_0_0.getNoteItemUnlockAniFinish(arg_28_0)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Activity1_2NoteItemUnlockAniFinish .. arg_28_0, 0)
end

function var_0_0.setNoteItemUnlockAniFinish(arg_29_0, arg_29_1)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Activity1_2NoteItemUnlockAniFinish .. arg_29_0, arg_29_1 or 1)
end

function var_0_0._onCollectItemShow(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = gohelper.findChildText(arg_30_1, "")
	local var_30_1 = gohelper.findChild(arg_30_1, "go_storytag")
	local var_30_2 = gohelper.findChild(arg_30_1, "go_point")
	local var_30_3 = gohelper.findChild(arg_30_1, "go_line")
	local var_30_4 = gohelper.findChild(arg_30_1, "go_vline")
	local var_30_5 = gohelper.findChild(arg_30_1, "go_wave")
	local var_30_6 = lua_activity121_clue.configDict[arg_30_2][arg_30_0._activityId]

	var_30_0.text = var_30_6.name

	local var_30_7 = var_30_6.tagType

	gohelper.setActive(var_30_4, var_30_6.tagType == 1)
	gohelper.setActive(var_30_3, var_30_6.tagType == 2)
	gohelper.setActive(var_30_2, var_30_6.tagType == 3)
	gohelper.setActive(var_30_5, var_30_6.tagType == 4)

	local var_30_8

	if var_30_7 == 1 then
		var_30_8 = var_30_4.transform
	elseif var_30_7 == 2 then
		var_30_8 = var_30_3.transform
	elseif var_30_7 == 3 then
		var_30_8 = var_30_2.transform
	elseif var_30_7 == 4 then
		var_30_8 = var_30_5.transform
	end

	gohelper.setActive(var_30_1, false)
	recthelper.setWidth(var_30_8, var_30_0:GetPreferredValues().x - 26)
end

function var_0_0._createLeftNote(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	arg_31_0:_onNoteItemShow(arg_31_1, arg_31_0._haveNoteList[arg_31_3], arg_31_3)
end

function var_0_0._createRightNote(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	arg_32_3 = arg_32_3 + 2

	arg_32_0:_onNoteItemShow(arg_32_1, arg_32_0._haveNoteList[arg_32_3], arg_32_3)
end

function var_0_0.getFirstShowStory(arg_33_0)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Activity1_2NoteFirstShowStory .. arg_33_0, 0)
end

function var_0_0.setFirstShowStory(arg_34_0)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Activity1_2NoteFirstShowStory .. arg_34_0, 1)
end

function var_0_0._onNoteItemShow(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = var_0_0.getFirstShowStory(arg_35_0._selectConfig.id) == 0

	arg_35_1.name = arg_35_2 or 0

	local var_35_1 = gohelper.findChild(arg_35_1, "title/go_titleNormal")
	local var_35_2 = gohelper.findChildText(arg_35_1, "title/go_titleNormal/txt_title")
	local var_35_3 = gohelper.findChild(arg_35_1, "title/go_titleEmpty")
	local var_35_4 = gohelper.findChildText(arg_35_1, "title/go_titleEmpty/txt_title")
	local var_35_5 = gohelper.findChildText(arg_35_1, "txt_desc")
	local var_35_6 = gohelper.findChild(arg_35_1, "go_empty")
	local var_35_7 = gohelper.findChildText(arg_35_1, "go_empty/txt")
	local var_35_8 = gohelper.findChild(arg_35_1, "go_line")
	local var_35_9 = gohelper.findChild(arg_35_1, "title")

	gohelper.setActive(var_35_8, true)

	local var_35_10 = lua_activity121_note.configDict[arg_35_0._noteList[arg_35_3]][arg_35_0._activityId]

	var_35_2.text = var_35_10.name
	var_35_4.text = ""

	local var_35_11 = arg_35_0._haveNoteList[arg_35_3]

	if not var_35_11 then
		gohelper.setActive(arg_35_1, true)
		gohelper.setActive(var_35_1, false)
		gohelper.setActive(var_35_3, false)
		gohelper.setActive(var_35_6, true)

		var_35_5.text = ""

		local var_35_12 = var_35_10.episodeId
		local var_35_13 = DungeonConfig.instance:getEpisodeCO(var_35_12)

		gohelper.onceAddComponent(arg_35_1, typeof(UnityEngine.Animator)).enabled = false
		gohelper.onceAddComponent(arg_35_1, gohelper.Type_CanvasGroup).alpha = var_35_0 and 0 or 1
	else
		gohelper.setActive(var_35_1, true)
		gohelper.setActive(var_35_3, false)
		gohelper.setActive(var_35_6, false)

		var_35_5.text = arg_35_0:_showNoteDesNormal(var_35_10.content)

		if arg_35_0.bonusFinished then
			var_0_0.setNoteItemUnlockAniFinish(var_35_10.noteId)
		end

		if var_0_0.getNoteItemUnlockAniFinish(var_35_11) == 0 then
			gohelper.onceAddComponent(arg_35_1, typeof(UnityEngine.Animator)).enabled = false
			gohelper.onceAddComponent(arg_35_1, gohelper.Type_CanvasGroup).alpha = 0
		end
	end

	table.insert(arg_35_0._textList, var_35_5)
	gohelper.onceAddComponent(arg_35_1, typeof(UnityEngine.Animator)):Play("idle")
end

function var_0_0._episodeId2Number(arg_36_0, arg_36_1)
	arg_36_0._episode2NumberDic = arg_36_0._episode2NumberDic or {}

	if arg_36_0._episode2NumberDic[arg_36_1] then
		return arg_36_0._episode2NumberDic[arg_36_1]
	end

	local var_36_0 = DungeonConfig.instance:getEpisodeCO(arg_36_1)
	local var_36_1 = DungeonConfig.instance:getChapterCO(var_36_0.chapterId)
	local var_36_2 = DungeonConfig.instance:getChapterEpisodeCOList(var_36_0.chapterId)

	if var_36_2 then
		table.sort(var_36_2, function(arg_37_0, arg_37_1)
			return arg_37_0.id < arg_37_1.id
		end)
	end

	for iter_36_0, iter_36_1 in ipairs(var_36_2) do
		local var_36_3 = DungeonConfig.instance:get1_2VersionActivityEpisodeCoList(iter_36_1.id)

		for iter_36_2, iter_36_3 in ipairs(var_36_3) do
			arg_36_0._episode2NumberDic[iter_36_3] = var_36_1.chapterIndex .. string.format(".%02d", iter_36_0)
		end
	end

	return arg_36_0._episode2NumberDic[arg_36_1]
end

function var_0_0._showNoteDesNormal(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_1

	return string.gsub(var_38_0, "<%d-:(.-)>", "%1")
end

function var_0_0._releaseSignObj(arg_39_0)
	if arg_39_0._signObjDic then
		for iter_39_0, iter_39_1 in pairs(arg_39_0._signObjDic) do
			for iter_39_2, iter_39_3 in ipairs(iter_39_1) do
				for iter_39_4, iter_39_5 in ipairs(iter_39_3) do
					gohelper.destroy(iter_39_5)
				end
			end
		end
	end

	arg_39_0._signObjDic = {}
end

var_0_0._signTypeName = {
	"go_vline",
	"go_line",
	"go_point",
	"go_wave",
	[101] = "go_vline",
	[202] = "go_line",
	[104] = "go_wave",
	[303] = "go_point",
	[304] = "go_wave",
	[204] = "go_wave",
	[301] = "go_vline",
	[302] = "go_line",
	[102] = "go_line",
	[201] = "go_vline",
	[103] = "go_point",
	[203] = "go_point"
}

function var_0_0._markNote(arg_40_0)
	arg_40_0:_releaseSignObj()

	for iter_40_0 = 1, arg_40_0._allClueCount do
		local var_40_0 = arg_40_0._haveNoteList[iter_40_0]

		if var_40_0 then
			local var_40_1 = lua_activity121_note.configDict[var_40_0][arg_40_0._activityId].content
			local var_40_2 = "<%d-:.->"
			local var_40_3 = "<%d-:(.-)>"
			local var_40_4, var_40_5 = string.find(var_40_1, var_40_2)

			while var_40_4 do
				local var_40_6 = string.match(var_40_1, "<(%d-):.->")
				local var_40_7 = tonumber(var_40_6)
				local var_40_8 = ""

				var_40_1 = string.gsub(var_40_1, var_40_3, function(arg_41_0)
					var_40_8 = arg_41_0

					return arg_41_0
				end, 1)

				local var_40_9 = arg_40_0._textList[iter_40_0]
				local var_40_10 = lua_activity121_clue.configDict[var_40_7][arg_40_0._activityId]

				if var_40_10 then
					local var_40_11 = var_40_10.tagType
					local var_40_12 = string.sub(var_40_1, 1, var_40_4 - 1)
					local var_40_13 = gohelper.cloneInPlace(gohelper.findChild(var_40_9.gameObject, var_0_0._signTypeName[var_40_7]))

					if var_40_13 then
						arg_40_0._signObjDic[var_40_7] = arg_40_0._signObjDic[var_40_7] or {}

						local var_40_14 = arg_40_0:getUserDataTb_()

						table.insert(var_40_14, var_40_13)
						gohelper.setActive(var_40_13, true)

						local var_40_15 = var_40_13.transform
						local var_40_16 = var_40_9.textInfo.characterCount
						local var_40_17 = GameUtil.utf8len(var_40_12)

						if var_40_17 <= var_40_16 then
							local var_40_18 = recthelper.getWidth(var_40_9.transform)
							local var_40_19 = recthelper.getHeight(var_40_9.transform)
							local var_40_20 = var_40_9.textInfo.characterInfo[var_40_17]
							local var_40_21 = var_40_20.bottomLeft
							local var_40_22 = var_40_21.x + var_40_18 / 2
							local var_40_23 = var_40_20.baseLine - var_40_19 / 2 - 10

							recthelper.setAnchorX(var_40_15, var_40_22)
							recthelper.setAnchorY(var_40_15, var_40_23)

							local var_40_24 = GameUtil.utf8len(var_40_8) + var_40_17 - 1
							local var_40_25 = var_40_9.textInfo.characterInfo[var_40_24].bottomRight
							local var_40_26 = var_40_9.fontSize
							local var_40_27 = (var_40_21.y - var_40_25.y) / var_40_26
							local var_40_28 = 0

							if var_40_27 > 1 then
								recthelper.setWidth(var_40_15, var_40_18 - var_40_22)

								for iter_40_1 = var_40_17, var_40_24 do
									local var_40_29 = var_40_9.textInfo.characterInfo[iter_40_1]
									local var_40_30 = var_40_9.textInfo.characterInfo[iter_40_1 + 1]

									if var_40_29 and var_40_30 and var_40_29.baseLine - var_40_30.baseLine > 1 then
										local var_40_31 = gohelper.cloneInPlace(var_40_13)

										table.insert(var_40_14, var_40_31)

										local var_40_32 = var_40_31.transform

										var_40_21 = var_40_30.bottomLeft

										local var_40_33 = var_40_21.x + var_40_18 / 2
										local var_40_34 = var_40_30.baseLine - var_40_19 / 2 - 10

										recthelper.setAnchorX(var_40_32, var_40_33)
										recthelper.setAnchorY(var_40_32, var_40_34)

										var_40_28 = var_40_28 + 1

										if var_40_28 > 0 and var_40_28 < var_40_27 - 1 then
											recthelper.setWidth(var_40_32, var_40_18)
										else
											recthelper.setWidth(var_40_32, var_40_25.x - var_40_30.bottomLeft.x)
										end
									end
								end
							else
								recthelper.setWidth(var_40_15, var_40_25.x - var_40_21.x)
							end
						end

						table.insert(arg_40_0._signObjDic[var_40_7], var_40_14)
					end
				end

				local var_40_35

				var_40_4, var_40_35 = string.find(var_40_1, var_40_2)
			end
		end
	end

	if GuideModel.instance:isGuideFinish(var_0_1) and arg_40_0.bonusFinished then
		local var_40_36 = string.splitToNumber(arg_40_0._selectConfig.clueIds, "|")

		for iter_40_2, iter_40_3 in ipairs(var_40_36) do
			if lua_activity121_clue.configDict[iter_40_3][arg_40_0._activityId].storyTag == 1 then
				local var_40_37 = arg_40_0._gocollectNote.transform:GetChild(iter_40_2 - 1).gameObject
				local var_40_38 = gohelper.findChild(var_40_37, "go_storytag")

				gohelper.setActive(var_40_38, true)
			end
		end
	end
end

function var_0_0._onMaskClick(arg_42_0)
	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.skipLineWork)
end

function var_0_0._playMarkClueAni(arg_43_0)
	gohelper.setActive(arg_43_0._goblock, true)
	arg_43_0:_releaseAniFlow()

	arg_43_0._aniFlow = FlowSequence.New()

	local var_43_0 = arg_43_0._gocollectNote.transform

	arg_43_0._aniFlow:addWork(FunctionWork.New(function()
		gohelper.setActive(arg_43_0._gocollectFinish, false)
		gohelper.setActive(arg_43_0._gocollectNote, true)

		for iter_44_0 = 0, var_43_0.childCount - 1 do
			local var_44_0 = var_43_0:GetChild(iter_44_0).gameObject

			gohelper.setActive(var_44_0, false)
		end
	end))

	local var_43_1 = string.splitToNumber(arg_43_0._selectConfig.clueIds, "|")

	for iter_43_0, iter_43_1 in ipairs(var_43_1) do
		if arg_43_0._signObjDic[iter_43_1] then
			arg_43_0._aniFlow:addWork(VersionActivity_1_2_StoryClueAniWork.New(arg_43_0._signObjDic[iter_43_1], arg_43_0, iter_43_0, iter_43_1))
		end
	end

	arg_43_0._aniFlow:addWork(TweenWork.New({
		type = "DOAnchorPos",
		tox = 0,
		toy = 0,
		t = 0.3,
		tr = arg_43_0._root.transform
	}))
	arg_43_0._aniFlow:addWork(TweenWork.New({
		toz = 1,
		type = "DOScale",
		tox = 1,
		toy = 1,
		t = 0.3,
		tr = arg_43_0._root.transform
	}))
	arg_43_0._aniFlow:addWork(FunctionWork.New(function()
		gohelper.setActive(arg_43_0._gomask, false)
		arg_43_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_43_0._onCloseView, arg_43_0)
		Activity121Rpc.instance:sendGet121BonusRequest(arg_43_0._selectConfig.id)
	end))
	arg_43_0._aniFlow:registerDoneListener(arg_43_0._onAniFlowDone, arg_43_0)
	arg_43_0._aniFlow:start()
end

function var_0_0._onAniFlowDone(arg_46_0)
	gohelper.setActive(arg_46_0._goblock, false)
	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.CollectStoryAniEnd)
end

function var_0_0._onCloseView(arg_47_0, arg_47_1)
	if arg_47_1 == ViewName.CommonPropView then
		arg_47_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_47_0._onCloseView, arg_47_0)

		local var_47_0 = true

		for iter_47_0, iter_47_1 in ipairs(arg_47_0._storyList) do
			if not VersionActivity1_2NoteModel.instance:getBonusFinished(iter_47_1.id) then
				var_47_0 = false
			end
		end

		if var_47_0 then
			if GuideModel.instance:isGuideRunning(var_0_1) then
				return
			end

			arg_47_0:_playLastShowFlow()
		end
	end
end

function var_0_0._playLastShowFlow(arg_48_0)
	gohelper.setActive(arg_48_0._goblock, true)

	if not arg_48_0._lastShowFlow then
		local var_48_0 = 0

		arg_48_0._lastShowFlow = FlowSequence.New()

		for iter_48_0, iter_48_1 in ipairs(arg_48_0._storyList) do
			arg_48_0._lastShowFlow:addWork(FunctionWork.New(function()
				var_48_0 = var_48_0 + 1

				arg_48_0:_onBtnClick(var_48_0)
			end))
			arg_48_0._lastShowFlow:addWork(WorkWaitSeconds.New(1))

			local var_48_1 = string.splitToNumber(iter_48_1.clueIds, "|")

			for iter_48_2, iter_48_3 in ipairs(var_48_1) do
				if lua_activity121_clue.configDict[iter_48_3][arg_48_0._activityId].storyTag == 1 then
					arg_48_0._lastShowFlow:addWork(FunctionWork.New(function()
						local var_50_0 = arg_48_0._gocollectNote.transform:GetChild(iter_48_2 - 1).gameObject
						local var_50_1 = gohelper.findChild(var_50_0, "go_storytag")

						gohelper.setActive(var_50_1, true)
						gohelper.onceAddComponent(var_50_1, typeof(UnityEngine.Animator)):Play("open")
					end))
					arg_48_0._lastShowFlow:addWork(WorkWaitSeconds.New(1))
				end
			end
		end
	end

	arg_48_0._lastShowFlow:registerDoneListener(arg_48_0._onLastShowFlowDone, arg_48_0)
	arg_48_0._lastShowFlow:start()
end

function var_0_0._onLastShowFlowDone(arg_51_0)
	DungeonRpc.instance:sendMapElementRequest(12101091)
end

function var_0_0._OnRemoveElement(arg_52_0, arg_52_1)
	if arg_52_1 == 12101091 then
		arg_52_0:closeThis()
	end
end

function var_0_0._releaseAniFlow(arg_53_0)
	if arg_53_0._aniFlow then
		arg_53_0._aniFlow:unregisterDoneListener(arg_53_0._onAniFlowDone, arg_53_0)
		arg_53_0._aniFlow:destroy()

		arg_53_0._aniFlow = nil
	end
end

function var_0_0._showReward(arg_54_0)
	if string.nilorempty(arg_54_0._selectConfig.bonus) then
		gohelper.setActive(arg_54_0._gocollectReward, false)
		gohelper.setActive(arg_54_0._gocanget, false)

		return
	end

	gohelper.setActive(arg_54_0._gocollectReward, true)

	local var_54_0 = string.splitToNumber(arg_54_0._selectConfig.bonus, "#")

	arg_54_0._reward = arg_54_0._reward or IconMgr.instance:getCommonItemIcon(arg_54_0._gocollectReward)

	arg_54_0._reward:setMOValue(var_54_0[1], var_54_0[2], var_54_0[3])
	arg_54_0._reward:setCountFontSize(34)
	gohelper.setActive(arg_54_0._gocanget, not arg_54_0.bonusFinished and arg_54_0._haveClueCount == arg_54_0._allClueCount)
end

function var_0_0.getStoryRedPoint(arg_55_0)
	if VersionActivity1_2NoteModel.instance:getBonusFinished(arg_55_0) then
		return false
	end

	local var_55_0 = VersionActivityEnum.ActivityId.Act121
	local var_55_1 = lua_activity121_story.configDict[var_55_0][arg_55_0]
	local var_55_2 = string.splitToNumber(var_55_1.noteIds, "|")

	for iter_55_0, iter_55_1 in ipairs(var_55_2) do
		if VersionActivity1_2NoteModel.instance:getNote(iter_55_1) and var_0_0.getNoteItemUnlockAniFinish(iter_55_1) == 0 then
			return true
		end
	end
end

function var_0_0.getRedPoint()
	for iter_56_0, iter_56_1 in ipairs(VersionActivity1_2NoteConfig.instance:getStoryList()) do
		if var_0_0.getStoryRedPoint(iter_56_1.id) then
			return true
		end
	end
end

function var_0_0._focusCollectedAllClueTab(arg_57_0)
	return
end

function var_0_0._selectStoryTabByGuide(arg_58_0, arg_58_1)
	arg_58_0._selectIndex = tonumber(arg_58_1)

	arg_58_0:_refreshBtnState()
	arg_58_0:_refreshData()
end

function var_0_0._markingKeyWordInStory(arg_59_0, arg_59_1)
	if arg_59_0._guideMarkingStoryFlow then
		arg_59_0._guideMarkingStoryFlow:stop()
		arg_59_0._guideMarkingStoryFlow:destroy()

		arg_59_0._guideMarkingStoryFlow = nil
	end

	arg_59_0._guideMarkingStoryFlow = FlowSequence.New()

	local var_59_0 = tonumber(arg_59_1)

	arg_59_0._curGuideMarkingStoryIndex = var_59_0

	local var_59_1 = arg_59_0._storyList[var_59_0]

	arg_59_0._guideMarkingStoryFlow:addWork(FunctionWork.New(function()
		arg_59_0:_onBtnClick(var_59_0)
	end))
	arg_59_0._guideMarkingStoryFlow:addWork(WorkWaitSeconds.New(1))

	local var_59_2 = string.splitToNumber(var_59_1.clueIds, "|")

	for iter_59_0, iter_59_1 in ipairs(var_59_2) do
		if lua_activity121_clue.configDict[iter_59_1][arg_59_0._activityId].storyTag == 1 then
			arg_59_0._guideMarkingStoryFlow:addWork(FunctionWork.New(function()
				local var_61_0 = arg_59_0._gocollectNote.transform:GetChild(iter_59_0 - 1).gameObject
				local var_61_1 = gohelper.findChild(var_61_0, "go_storytag")

				gohelper.setActive(var_61_1, true)
				gohelper.onceAddComponent(var_61_1, typeof(UnityEngine.Animator)):Play("open")
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_level_chosen)
			end))
			arg_59_0._guideMarkingStoryFlow:addWork(WorkWaitSeconds.New(1))
		end
	end

	arg_59_0._guideMarkingStoryFlow:registerDoneListener(arg_59_0._markingStoryFlowDone, arg_59_0)
	arg_59_0._guideMarkingStoryFlow:start()
end

function var_0_0._markingStoryFlowDone(arg_62_0)
	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.CollectStoryAniEnd)
end

function var_0_0.onClose(arg_63_0)
	if arg_63_0._showGoCollectAniFlow then
		arg_63_0._showGoCollectAniFlow:destroy()

		arg_63_0._showGoCollectAniFlow = nil
	end

	if arg_63_0._lastShowFlow then
		arg_63_0._lastShowFlow:unregisterDoneListener(arg_63_0._onLastShowFlowDone, arg_63_0)
		arg_63_0._lastShowFlow:destroy()

		arg_63_0._lastShowFlow = nil
	end

	if arg_63_0._guideMarkingStoryFlow then
		arg_63_0._guideMarkingStoryFlow:stop()
		arg_63_0._guideMarkingStoryFlow:destroy()

		arg_63_0._guideMarkingStoryFlow = nil
	end

	arg_63_0:_releaseAniFlow()
	TaskDispatcher.cancelTask(arg_63_0._markNote, arg_63_0)
	TaskDispatcher.cancelTask(arg_63_0._refreshData, arg_63_0)
	TaskDispatcher.cancelTask(arg_63_0._afterUnlockNoteAni, arg_63_0)
	TaskDispatcher.cancelTask(arg_63_0._playUnlockNoteAni, arg_63_0)

	if arg_63_0._btnComList then
		for iter_63_0, iter_63_1 in ipairs(arg_63_0._btnComList) do
			iter_63_1:RemoveClickListener()
		end
	end

	if DungeonMapModel.instance:getElementById(12101091) then
		DungeonRpc.instance:sendMapElementRequest(12101091)
	end
end

function var_0_0.onDestroyView(arg_64_0)
	arg_64_0._simagebookbg1:UnLoadImage()
	arg_64_0._simagebookbg2:UnLoadImage()
	arg_64_0._simagebookbg3:UnLoadImage()
	arg_64_0._simagebookbg4:UnLoadImage()
	arg_64_0._simagebookbg5:UnLoadImage()
	arg_64_0._simagetitle:UnLoadImage()
	arg_64_0._simageleftbookbg5:UnLoadImage()
	arg_64_0._simagebookbg6:UnLoadImage()
end

return var_0_0
