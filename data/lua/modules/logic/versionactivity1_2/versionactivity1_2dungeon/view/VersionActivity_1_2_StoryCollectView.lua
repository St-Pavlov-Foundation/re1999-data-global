module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_StoryCollectView", package.seeall)

slot0 = class("VersionActivity_1_2_StoryCollectView", BaseViewExtended)
slot1 = 12110

function slot0.onInitView(slot0)
	slot0._simagebookbg1 = gohelper.findChildSingleImage(slot0.viewGO, "root/bg/#simage_bookbg1")
	slot0._simagebookbg2 = gohelper.findChildSingleImage(slot0.viewGO, "root/bg/#simage_bookbg2")
	slot0._simagebookbg3 = gohelper.findChildSingleImage(slot0.viewGO, "root/bg/#simage_bookbg3")
	slot0._simagebookbg4 = gohelper.findChildSingleImage(slot0.viewGO, "root/bg/#simage_bookbg4")
	slot0._simagebookbg5 = gohelper.findChildSingleImage(slot0.viewGO, "root/bg/#simage_bookbg1/#simage_bookbg5")
	slot0._simageleftbookbg5 = gohelper.findChildSingleImage(slot0.viewGO, "root/left/#simage_bookbg5")
	slot0._simagebookbg6 = gohelper.findChildSingleImage(slot0.viewGO, "root/left/#simage_bookbg6")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "root/left/title/#simage_title")
	slot0._txttitleName = gohelper.findChildText(slot0.viewGO, "root/left/title/#txt_titleName")
	slot0._gofinishIcon = gohelper.findChild(slot0.viewGO, "root/left/title/#txt_titleName/#go_finishIcon")
	slot0._txttitleIndex = gohelper.findChildText(slot0.viewGO, "root/left/title/#txt_titleIndex")
	slot0._goleftNoteContent = gohelper.findChild(slot0.viewGO, "root/left/#go_leftNoteContent")
	slot0._gocategory = gohelper.findChild(slot0.viewGO, "root/left/#go_category")
	slot0._gocategoryItem = gohelper.findChild(slot0.viewGO, "root/left/#go_category/#go_categoryItem")
	slot0._gorightNoteContent = gohelper.findChild(slot0.viewGO, "root/right/#go_rightNoteContent")
	slot0._gorightEmpty = gohelper.findChild(slot0.viewGO, "root/right/#go_rightEmpty")
	slot0._gocollectReward = gohelper.findChild(slot0.viewGO, "root/right/collect/rewardItem/#go_collectReward")
	slot0._txtequiplv = gohelper.findChildText(slot0.viewGO, "root/right/collect/rewardItem/#go_collectReward/commonitemicon/#txt_equiplv")
	slot0._goequipcareer = gohelper.findChild(slot0.viewGO, "root/right/collect/rewardItem/#go_collectReward/commonitemicon/click/#go_equipcareer")
	slot0._gorefinebg = gohelper.findChild(slot0.viewGO, "root/right/collect/rewardItem/#go_collectReward/commonitemicon/click/#go_equipcareer/#go_refinebg")
	slot0._goboth = gohelper.findChild(slot0.viewGO, "root/right/collect/rewardItem/#go_collectReward/commonitemicon/click/#go_equipcareer/#go_both")
	slot0._imagecarrer = gohelper.findChildImage(slot0.viewGO, "root/right/collect/rewardItem/#go_collectReward/commonitemicon/click/#go_equipcareer/#go_both/#image_carrer")
	slot0._txtrefinelv = gohelper.findChildText(slot0.viewGO, "root/right/collect/rewardItem/#go_collectReward/commonitemicon/click/#go_equipcareer/#txt_refinelv")
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "root/right/collect/rewardItem/#go_finish")
	slot0._gocanget = gohelper.findChild(slot0.viewGO, "root/right/collect/#go_canget")
	slot0._gocollectNote = gohelper.findChild(slot0.viewGO, "root/right/collect/#go_collectNote")
	slot0._gocollectProcess = gohelper.findChild(slot0.viewGO, "root/right/collect/#go_collectProcess")
	slot0._txtcollectProcess = gohelper.findChildText(slot0.viewGO, "root/right/collect/#go_collectProcess/txt/#txt_collectProcess")
	slot0._gocollectContent = gohelper.findChild(slot0.viewGO, "root/right/collect/#go_collectProcess/#go_collectContent")
	slot0._gocollectItem = gohelper.findChild(slot0.viewGO, "root/right/collect/#go_collectProcess/#go_collectContent/#go_collectItem")
	slot0._gocollectFinish = gohelper.findChild(slot0.viewGO, "root/right/collect/#go_collectFinish")
	slot0._btntidyclue = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/collect/#go_collectFinish/#btn_tidyclue")
	slot0._gonoteItem = gohelper.findChild(slot0.viewGO, "root/#go_noteItem")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")
	slot0._goblock = gohelper.findChild(slot0.viewGO, "root/#go_block")
	slot0._root = gohelper.findChild(slot0.viewGO, "root")
	slot0._gomask = gohelper.findChild(slot0.viewGO, "#go_mask")
	slot0._gomaskGuide = gohelper.findChild(slot0.viewGO, "#go_mask_guide")
	slot0._maskClick = gohelper.getClick(slot0._gomask)
	slot0._ani = gohelper.onceAddComponent(slot0._root, typeof(UnityEngine.Animator))
	slot0._goCollectProcessAni = gohelper.onceAddComponent(slot0._gocollectProcess, typeof(UnityEngine.Animator))
	slot0._goCollectFinishAni = gohelper.onceAddComponent(slot0._gocollectFinish, typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntidyclue:AddClickListener(slot0._btntidyclueOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._maskClick:AddClickListener(slot0._onMaskClick, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveGet121BonusReply, slot0._onReceiveGet121BonusReply, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.focusCollectedAllClueTab, slot0._focusCollectedAllClueTab, slot0)
	slot0:addEventCb(GuideController.instance, GuideEvent.StoryCollectViewSelectTab, slot0._selectStoryTabByGuide, slot0)
	slot0:addEventCb(GuideController.instance, GuideEvent.ShowMarkingStoryInView, slot0._markingKeyWordInStory, slot0)
	slot0:addEventCb(GuideController.instance, GuideEvent.ShowMarkingStoryAllDone, slot0._onLastShowFlowDone, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, slot0._OnRemoveElement, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntidyclue:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._maskClick:RemoveClickListener()
end

function slot0._onReceiveGet121BonusReply(slot0, slot1)
	if not slot0._selectConfig then
		return
	end

	if slot1 == slot0._selectConfig.id then
		slot0.bonusFinished = VersionActivity1_2NoteModel.instance:getBonusFinished(slot0._selectConfig.id)

		slot0:_showCollectData()
	end
end

function slot0._btntidyclueOnClick(slot0)
	slot0:_markNote()
	slot0:_playMarkClueAni()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	slot0._simagebookbg1:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben03"))
	slot0._simagebookbg2:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben04"))
	slot0._simagebookbg3:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben01"))
	slot0._simagebookbg4:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben02"))
	slot0._simagebookbg5:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben07"))
	slot0._simageleftbookbg5:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben05"))
	slot0._simagebookbg6:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben06"))
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_mail_open)
	gohelper.setActive(slot0._goblock, false)
	gohelper.setActive(slot0._gomask, false)

	slot0._activityId = VersionActivityEnum.ActivityId.Act121
	slot0._storyList = VersionActivity1_2NoteConfig.instance:getStoryList()

	slot0:_showBtn()
	slot0:_showBtnUnlockAni()
end

function slot0.getBtnAniFinish(slot0)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Activity1_2NoteBtnUnlockAni .. slot0, 0)
end

function slot0.setBtnAniFinish(slot0, slot1)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Activity1_2NoteBtnUnlockAni .. slot0, slot1 or 1)
end

function slot0._showBtnUnlockAni(slot0)
	for slot4, slot5 in ipairs(slot0._storyList) do
		slot6 = slot0._storyList[slot4].id

		if DungeonModel.instance:hasPassLevel(slot0._storyList[slot4].episodeId) and uv0.getBtnAniFinish(slot6) == 0 then
			uv0.setBtnAniFinish(slot6)

			slot8 = slot0._btnList[slot4]

			gohelper.setActive(gohelper.findChild(slot8, "go_lock"), true)
			gohelper.onceAddComponent(slot8, typeof(UnityEngine.Animator)):Play("unlock")
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
		end
	end
end

function slot0._showBtn(slot0)
	slot0._btnComList = slot0:getUserDataTb_()
	slot0._btnList = slot0:getUserDataTb_()

	slot0:com_createObjList(slot0._onBtnShow, slot0._storyList, slot0._gocategory, slot0._gocategoryItem)

	slot0._selectIndex = 1

	slot0:_refreshBtnState()
	slot0:_refreshData()
end

function slot0._onBtnShow(slot0, slot1, slot2, slot3)
	gohelper.findChildText(slot1, "go_select/txt_name").text = slot2.name
	gohelper.findChildText(slot1, "go_normal/txt_name").text = slot2.name
	slot9 = DungeonModel.instance:hasPassLevel(slot2.episodeId)

	gohelper.setActive(gohelper.findChild(slot1, "go_normal"), slot9)
	gohelper.setActive(gohelper.findChild(slot1, "go_select"), slot9)
	gohelper.setActive(gohelper.findChild(slot1, "go_lock"), not slot9)

	slot10 = gohelper.findChildButtonWithAudio(slot1, "btn_click", AudioEnum.TeachNote.play_ui_activity_switch)

	slot10:RemoveClickListener()
	slot10:AddClickListener(slot0._onBtnClick, slot0, slot3)
	table.insert(slot0._btnComList, slot10)
	table.insert(slot0._btnList, slot1)
end

function slot0._refreshBtnState(slot0)
	for slot4, slot5 in ipairs(slot0._btnList) do
		gohelper.setActive(gohelper.findChild(slot5, "go_select"), DungeonModel.instance:hasPassLevel(slot0._storyList[slot4].episodeId) and slot0._selectIndex == slot4)
		gohelper.setActive(gohelper.findChild(slot5, "go_normal"), slot6 and slot0._selectIndex ~= slot4)
		gohelper.setActive(gohelper.findChild(slot5, "go_lock"), not slot6)
	end
end

function slot0._onBtnClick(slot0, slot1)
	if not DungeonModel.instance:hasPassLevel(slot0._storyList[slot1].episodeId) then
		GameFacade.showToast(ToastEnum.Activity1_2NoteStoryUnlockLick)

		return
	end

	if slot0._selectIndex == slot1 then
		return
	end

	slot0._isOpened = true
	slot0._selectIndex = slot1

	slot0:_refreshBtnState()
	slot0._ani:Play("siwtch", 0, 0)
	TaskDispatcher.runDelay(slot0._refreshData, slot0, 0.1)
end

function slot0._refreshData(slot0)
	slot0._selectConfig = slot0._storyList[slot0._selectIndex]
	slot0.bonusFinished = VersionActivity1_2NoteModel.instance:getBonusFinished(slot0._selectConfig.id)
	slot1 = string.splitToNumber(slot0._selectConfig.noteIds, "|")
	slot0._allClueCount = #slot1
	slot0._haveClueCount = 0
	slot0._haveNoteList = {}
	slot0._noteList = {}

	for slot5, slot6 in ipairs(slot1) do
		if VersionActivity1_2NoteModel.instance:getNote(slot6) then
			slot0._haveClueCount = slot0._haveClueCount + 1
			slot0._haveNoteList[slot5] = slot6
		end

		slot0._noteList[slot5] = slot6
	end

	slot0:_releaseSignObj()
	slot0:_showNoteCollectData()
	slot0:_showCollectData()

	slot0._txttitleIndex.text = string.format("%02d", slot0._selectIndex)

	slot0:_showReward()
	slot0:_refreshRedPoint()
end

function slot0._refreshRewardState(slot0)
	gohelper.setActive(slot0._gofinishIcon, slot0.bonusFinished)
	gohelper.setActive(slot0._gofinish, false)
end

function slot0._refreshRedPoint(slot0)
	for slot4, slot5 in ipairs(slot0._storyList) do
		gohelper.setActive(gohelper.findChild(slot0._btnList[slot4], "redPoint"), uv0.getStoryRedPoint(slot5.id))
	end
end

function slot0._showNoteCollectData(slot0)
	gohelper.setActive(slot0._gorightEmpty, false)
	gohelper.setActive(slot0._gorightNoteContent, true)

	slot0._textList = slot0:getUserDataTb_()

	slot0:com_createObjList(slot0._createLeftNote, 2, slot0._goleftNoteContent, slot0._gonoteItem)
	slot0:com_createObjList(slot0._createRightNote, slot0._allClueCount - 2, slot0._gorightNoteContent, slot0._gonoteItem)

	slot0._txttitleName.text = slot0._selectConfig.name

	slot0._simagetitle:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2(slot0._selectConfig.icon))
end

function slot0._playUnlockNoteAni(slot0)
	for slot5 = slot0._collectItemUnlockPlayIndex, slot0._haveClueCount do
		slot6 = gohelper.findChild(slot0._gocollectContent.transform:GetChild(slot5 - 1).gameObject, "go_collected")

		gohelper.setActive(slot6, true)
		gohelper.onceAddComponent(slot6, typeof(UnityEngine.Animator)):Play("unlock", 0, 0)
	end

	for slot5, slot6 in ipairs(slot0._playUnlockNoteAniIds) do
		slot7 = slot0._textList[slot6].transform.parent.gameObject
		slot8 = gohelper.findChildText(slot7, "txt_desc")
		slot9 = slot7:GetComponent(typeof(ZProj.MaterialPropsCtrl))
		slot10 = UnityEngine.Object.Instantiate(slot8.materialForRendering)
		slot8.fontMaterial = slot10

		slot9.mas:Clear()
		slot9.mas:Add(slot10)

		gohelper.onceAddComponent(slot7, gohelper.Type_CanvasGroup).alpha = 1
		gohelper.onceAddComponent(slot7, typeof(UnityEngine.Animator)).enabled = true

		gohelper.onceAddComponent(slot7, typeof(UnityEngine.Animator)):Play("unlock")
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_clue_unlock)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_clue_collect)
	TaskDispatcher.runDelay(slot0._afterUnlockNoteAni, slot0, 1)
end

function slot0._afterUnlockNoteAni(slot0)
	if slot0._haveClueCount == slot0._allClueCount and not slot0.bonusFinished then
		slot0:_closeProcessAndShowGoCollectFinish()
	else
		slot0:_refreshCollectData()
	end

	slot0:_showUnlockNote()
end

function slot0._showUnlockNote(slot0)
	if uv0.getFirstShowStory(slot0._selectConfig.id) == 0 then
		uv0.setFirstShowStory(slot0._selectConfig.id)

		for slot4, slot5 in ipairs(slot0._noteList) do
			if not VersionActivity1_2NoteModel.instance:getNote(slot5) then
				slot6 = slot0._textList[slot4].transform.parent.gameObject
				gohelper.onceAddComponent(slot6, gohelper.Type_CanvasGroup).alpha = 1
				gohelper.onceAddComponent(slot6, typeof(UnityEngine.Animator)).enabled = true

				gohelper.onceAddComponent(slot6, typeof(UnityEngine.Animator)):Play("open")
			end
		end
	end
end

function slot0._showCollectData(slot0)
	slot0:_refreshRewardState()

	slot0._playUnlockNoteAniIds = {}

	if not slot0.bonusFinished then
		for slot4, slot5 in ipairs(slot0._noteList) do
			if VersionActivity1_2NoteModel.instance:getNote(slot5) and uv0.getNoteItemUnlockAniFinish(slot5) == 0 then
				uv0.setNoteItemUnlockAniFinish(slot5)
				table.insert(slot0._playUnlockNoteAniIds, slot4)
			end
		end
	end

	slot0._collectItemUnlockPlayIndex = slot0._haveClueCount - #slot0._playUnlockNoteAniIds + 1
	slot0._txtcollectProcess.text = string.format("<color=#ad7b40>%d</color>/%d", slot0._haveClueCount, slot0._allClueCount)

	slot0:com_createObjList(slot0._onCollectPieceShow, slot0._noteList, slot0._gocollectContent, slot0._gocollectItem)

	if #slot0._playUnlockNoteAniIds > 0 then
		gohelper.setActive(slot0._gocollectNote, false)
		gohelper.setActive(slot0._gocollectFinish, false)
		gohelper.setActive(slot0._gocollectProcess, true)
		gohelper.setActive(slot0._goblock, true)

		if slot0._isOpened then
			TaskDispatcher.runDelay(slot0._playUnlockNoteAni, slot0, 0.7)
		else
			TaskDispatcher.runDelay(slot0._playUnlockNoteAni, slot0, 1)
		end

		return
	end

	slot0:_showUnlockNote()
	slot0:_refreshCollectData()
end

function slot0._refreshCollectData(slot0)
	gohelper.setActive(slot0._gocollectNote, slot0.bonusFinished)
	gohelper.setActive(slot0._gocollectProcess, not slot0.bonusFinished and slot0._haveClueCount < slot0._allClueCount)
	gohelper.setActive(slot0._gocollectFinish, not slot0.bonusFinished and slot0._haveClueCount == slot0._allClueCount)
	slot0._goCollectProcessAni:Play("idle")
	slot0._goCollectFinishAni:Play("open")

	if slot0.bonusFinished then
		TaskDispatcher.runDelay(slot0._markNote, slot0, 0.02)
	end

	slot0:com_createObjList(slot0._onCollectItemShow, string.splitToNumber(slot0._selectConfig.clueIds, "|"), slot0._gocollectNote, gohelper.findChild(slot0._gocollectNote, "txt_noteItem"))
	gohelper.setActive(slot0._goblock, false)
end

function slot0._closeProcessAndShowGoCollectFinish(slot0)
	slot0._showGoCollectAniFlow = slot0._showGoCollectAniFlow or FlowSequence.New()

	slot0._showGoCollectAniFlow:addWork(FunctionWork.New(function ()
		uv0._goCollectProcessAni:Play("close")
	end))
	slot0._showGoCollectAniFlow:addWork(WorkWaitSeconds.New(0.3))
	slot0._showGoCollectAniFlow:addWork(FunctionWork.New(function ()
		gohelper.setActive(uv0._gocollectProcess, false)
		gohelper.setActive(uv0._gocollectFinish, true)
		uv0._goCollectFinishAni:Play("open")
		uv0:_refreshCollectData()
	end))
	slot0._showGoCollectAniFlow:start()
end

function slot0._onCollectPieceShow(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChild(slot1, "go_empty")
	slot5 = gohelper.findChild(slot1, "go_collected")
	slot6 = gohelper.findChildComponent(slot1, "go_collected", typeof(UIMesh))
	slot7 = UnityEngine.Object.Instantiate(slot6.material)
	slot6.material = slot7
	slot8 = slot5:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	slot8.mas:Clear()
	slot8.mas:Add(slot7)
	gohelper.onceAddComponent(slot5, typeof(UnityEngine.Animator)):Play("idle", 0, 0)
	gohelper.setActive(slot5, slot3 < slot0._collectItemUnlockPlayIndex)
end

function slot0.getNoteItemUnlockAniFinish(slot0)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Activity1_2NoteItemUnlockAniFinish .. slot0, 0)
end

function slot0.setNoteItemUnlockAniFinish(slot0, slot1)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Activity1_2NoteItemUnlockAniFinish .. slot0, slot1 or 1)
end

function slot0._onCollectItemShow(slot0, slot1, slot2, slot3)
	slot5 = gohelper.findChild(slot1, "go_storytag")
	slot10 = lua_activity121_clue.configDict[slot2][slot0._activityId]
	gohelper.findChildText(slot1, "").text = slot10.name

	gohelper.setActive(gohelper.findChild(slot1, "go_vline"), slot10.tagType == 1)
	gohelper.setActive(gohelper.findChild(slot1, "go_line"), slot10.tagType == 2)
	gohelper.setActive(gohelper.findChild(slot1, "go_point"), slot10.tagType == 3)
	gohelper.setActive(gohelper.findChild(slot1, "go_wave"), slot10.tagType == 4)

	slot12 = nil

	if slot10.tagType == 1 then
		slot12 = slot8.transform
	elseif slot11 == 2 then
		slot12 = slot7.transform
	elseif slot11 == 3 then
		slot12 = slot6.transform
	elseif slot11 == 4 then
		slot12 = slot9.transform
	end

	gohelper.setActive(slot5, false)
	recthelper.setWidth(slot12, slot4:GetPreferredValues().x - 26)
end

function slot0._createLeftNote(slot0, slot1, slot2, slot3)
	slot0:_onNoteItemShow(slot1, slot0._haveNoteList[slot3], slot3)
end

function slot0._createRightNote(slot0, slot1, slot2, slot3)
	slot3 = slot3 + 2

	slot0:_onNoteItemShow(slot1, slot0._haveNoteList[slot3], slot3)
end

function slot0.getFirstShowStory(slot0)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Activity1_2NoteFirstShowStory .. slot0, 0)
end

function slot0.setFirstShowStory(slot0)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Activity1_2NoteFirstShowStory .. slot0, 1)
end

function slot0._onNoteItemShow(slot0, slot1, slot2, slot3)
	slot1.name = slot2 or 0
	slot11 = gohelper.findChildText(slot1, "go_empty/txt")
	slot13 = gohelper.findChild(slot1, "title")

	gohelper.setActive(gohelper.findChild(slot1, "go_line"), true)

	gohelper.findChildText(slot1, "title/go_titleNormal/txt_title").text = lua_activity121_note.configDict[slot0._noteList[slot3]][slot0._activityId].name
	gohelper.findChildText(slot1, "title/go_titleEmpty/txt_title").text = ""

	if not slot0._haveNoteList[slot3] then
		gohelper.setActive(slot1, true)
		gohelper.setActive(gohelper.findChild(slot1, "title/go_titleNormal"), false)
		gohelper.setActive(gohelper.findChild(slot1, "title/go_titleEmpty"), false)
		gohelper.setActive(gohelper.findChild(slot1, "go_empty"), true)

		gohelper.findChildText(slot1, "txt_desc").text = ""
		slot17 = DungeonConfig.instance:getEpisodeCO(slot14.episodeId)
		gohelper.onceAddComponent(slot1, typeof(UnityEngine.Animator)).enabled = false
		gohelper.onceAddComponent(slot1, gohelper.Type_CanvasGroup).alpha = uv0.getFirstShowStory(slot0._selectConfig.id) == 0 and 0 or 1
	else
		gohelper.setActive(slot5, true)
		gohelper.setActive(slot7, false)
		gohelper.setActive(slot10, false)

		slot9.text = slot0:_showNoteDesNormal(slot14.content)

		if slot0.bonusFinished then
			uv0.setNoteItemUnlockAniFinish(slot14.noteId)
		end

		if uv0.getNoteItemUnlockAniFinish(slot15) == 0 then
			gohelper.onceAddComponent(slot1, typeof(UnityEngine.Animator)).enabled = false
			gohelper.onceAddComponent(slot1, gohelper.Type_CanvasGroup).alpha = 0
		end
	end

	table.insert(slot0._textList, slot9)
	gohelper.onceAddComponent(slot1, typeof(UnityEngine.Animator)):Play("idle")
end

function slot0._episodeId2Number(slot0, slot1)
	slot0._episode2NumberDic = slot0._episode2NumberDic or {}

	if slot0._episode2NumberDic[slot1] then
		return slot0._episode2NumberDic[slot1]
	end

	slot2 = DungeonConfig.instance:getEpisodeCO(slot1)
	slot3 = DungeonConfig.instance:getChapterCO(slot2.chapterId)

	if DungeonConfig.instance:getChapterEpisodeCOList(slot2.chapterId) then
		table.sort(slot4, function (slot0, slot1)
			return slot0.id < slot1.id
		end)
	end

	for slot8, slot9 in ipairs(slot4) do
		for slot14, slot15 in ipairs(DungeonConfig.instance:get1_2VersionActivityEpisodeCoList(slot9.id)) do
			slot0._episode2NumberDic[slot15] = slot3.chapterIndex .. string.format(".%02d", slot8)
		end
	end

	return slot0._episode2NumberDic[slot1]
end

function slot0._showNoteDesNormal(slot0, slot1)
	return string.gsub(slot1, "<%d-:(.-)>", "%1")
end

function slot0._releaseSignObj(slot0)
	if slot0._signObjDic then
		for slot4, slot5 in pairs(slot0._signObjDic) do
			for slot9, slot10 in ipairs(slot5) do
				for slot14, slot15 in ipairs(slot10) do
					gohelper.destroy(slot15)
				end
			end
		end
	end

	slot0._signObjDic = {}
end

slot0._signTypeName = {
	"go_vline",
	"go_line",
	"go_point",
	"go_wave",
	[101.0] = "go_vline",
	[202.0] = "go_line",
	[104.0] = "go_wave",
	[303.0] = "go_point",
	[304.0] = "go_wave",
	[204.0] = "go_wave",
	[301.0] = "go_vline",
	[302.0] = "go_line",
	[102.0] = "go_line",
	[201.0] = "go_vline",
	[103.0] = "go_point",
	[203.0] = "go_point"
}

function slot0._markNote(slot0)
	slot0:_releaseSignObj()

	for slot4 = 1, slot0._allClueCount do
		if slot0._haveNoteList[slot4] then
			slot8 = "<%d-:(.-)>"
			slot9, slot10 = string.find(lua_activity121_note.configDict[slot5][slot0._activityId].content, "<%d-:.->")

			while slot9 do
				slot6 = string.gsub(slot6, slot8, function (slot0)
					uv0 = slot0

					return slot0
				end, 1)
				slot13 = slot0._textList[slot4]

				if lua_activity121_clue.configDict[tonumber(string.match(slot6, "<(%d-):.->"))][slot0._activityId] then
					slot15 = slot14.tagType

					if gohelper.cloneInPlace(gohelper.findChild(slot13.gameObject, uv0._signTypeName[slot11])) then
						slot0._signObjDic[slot11] = slot0._signObjDic[slot11] or {}

						table.insert(slot0:getUserDataTb_(), slot17)
						gohelper.setActive(slot17, true)

						slot19 = slot17.transform

						if GameUtil.utf8len(string.sub(slot6, 1, slot9 - 1)) <= slot13.textInfo.characterCount then
							slot24 = slot13.textInfo.characterInfo[slot21]
							slot25 = slot24.bottomLeft

							recthelper.setAnchorX(slot19, slot25.x + recthelper.getWidth(slot13.transform) / 2)
							recthelper.setAnchorY(slot19, slot24.baseLine - recthelper.getHeight(slot13.transform) / 2 - 10)

							slot33 = 0

							if (slot25.y - slot13.textInfo.characterInfo[GameUtil.utf8len("") + slot21 - 1].bottomRight.y) / slot13.fontSize > 1 then
								slot37 = slot22 - slot26

								recthelper.setWidth(slot19, slot37)

								for slot37 = slot21, slot28 do
									slot39 = slot13.textInfo.characterInfo[slot37 + 1]

									if slot13.textInfo.characterInfo[slot37] and slot39 and slot38.baseLine - slot39.baseLine > 1 then
										slot40 = gohelper.cloneInPlace(slot17)

										table.insert(slot18, slot40)

										slot41 = slot40.transform

										recthelper.setAnchorX(slot41, slot39.bottomLeft.x + slot22 / 2)
										recthelper.setAnchorY(slot41, slot39.baseLine - slot23 / 2 - 10)

										if slot33 + 1 > 0 and slot33 < slot32 - 1 then
											recthelper.setWidth(slot41, slot22)
										else
											recthelper.setWidth(slot41, slot30.x - slot39.bottomLeft.x)
										end
									end
								end
							else
								recthelper.setWidth(slot19, slot30.x - slot25.x)
							end
						end

						table.insert(slot0._signObjDic[slot11], slot18)
					end
				end

				slot9, slot10 = string.find(slot6, slot7)
			end
		end
	end

	if GuideModel.instance:isGuideFinish(uv1) and slot0.bonusFinished then
		for slot5, slot6 in ipairs(string.splitToNumber(slot0._selectConfig.clueIds, "|")) do
			if lua_activity121_clue.configDict[slot6][slot0._activityId].storyTag == 1 then
				gohelper.setActive(gohelper.findChild(slot0._gocollectNote.transform:GetChild(slot5 - 1).gameObject, "go_storytag"), true)
			end
		end
	end
end

function slot0._onMaskClick(slot0)
	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.skipLineWork)
end

function slot0._playMarkClueAni(slot0)
	gohelper.setActive(slot0._goblock, true)
	slot0:_releaseAniFlow()

	slot0._aniFlow = FlowSequence.New()
	slot1 = slot0._gocollectNote.transform

	function slot7()
		gohelper.setActive(uv0._gocollectFinish, false)

		slot3 = true

		gohelper.setActive(uv0._gocollectNote, slot3)

		for slot3 = 0, uv1.childCount - 1 do
			gohelper.setActive(uv1:GetChild(slot3).gameObject, false)
		end
	end

	slot0._aniFlow:addWork(FunctionWork.New(slot7))

	for slot6, slot7 in ipairs(string.splitToNumber(slot0._selectConfig.clueIds, "|")) do
		if slot0._signObjDic[slot7] then
			slot0._aniFlow:addWork(VersionActivity_1_2_StoryClueAniWork.New(slot0._signObjDic[slot7], slot0, slot6, slot7))
		end
	end

	slot0._aniFlow:addWork(TweenWork.New({
		type = "DOAnchorPos",
		tox = 0,
		toy = 0,
		t = 0.3,
		tr = slot0._root.transform
	}))
	slot0._aniFlow:addWork(TweenWork.New({
		toz = 1,
		type = "DOScale",
		tox = 1,
		toy = 1,
		t = 0.3,
		tr = slot0._root.transform
	}))
	slot0._aniFlow:addWork(FunctionWork.New(function ()
		gohelper.setActive(uv0._gomask, false)
		uv0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, uv0._onCloseView, uv0)
		Activity121Rpc.instance:sendGet121BonusRequest(uv0._selectConfig.id)
	end))
	slot0._aniFlow:registerDoneListener(slot0._onAniFlowDone, slot0)
	slot0._aniFlow:start()
end

function slot0._onAniFlowDone(slot0)
	gohelper.setActive(slot0._goblock, false)
	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.CollectStoryAniEnd)
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.CommonPropView then
		slot6 = ViewEvent.OnCloseViewFinish
		slot7 = slot0._onCloseView

		slot0:removeEventCb(ViewMgr.instance, slot6, slot7, slot0)

		slot2 = true

		for slot6, slot7 in ipairs(slot0._storyList) do
			if not VersionActivity1_2NoteModel.instance:getBonusFinished(slot7.id) then
				slot2 = false
			end
		end

		if slot2 then
			if GuideModel.instance:isGuideRunning(uv0) then
				return
			end

			slot0:_playLastShowFlow()
		end
	end
end

function slot0._playLastShowFlow(slot0)
	gohelper.setActive(slot0._goblock, true)

	if not slot0._lastShowFlow then
		slot1 = 0
		slot0._lastShowFlow = FlowSequence.New()

		for slot5, slot6 in ipairs(slot0._storyList) do
			slot0._lastShowFlow:addWork(FunctionWork.New(function ()
				uv0 = uv0 + 1

				uv1:_onBtnClick(uv0)
			end))

			slot12 = 1

			slot0._lastShowFlow:addWork(WorkWaitSeconds.New(slot12))

			for slot11, slot12 in ipairs(string.splitToNumber(slot6.clueIds, "|")) do
				if lua_activity121_clue.configDict[slot12][slot0._activityId].storyTag == 1 then
					slot0._lastShowFlow:addWork(FunctionWork.New(function ()
						slot1 = gohelper.findChild(uv0._gocollectNote.transform:GetChild(uv1 - 1).gameObject, "go_storytag")

						gohelper.setActive(slot1, true)
						gohelper.onceAddComponent(slot1, typeof(UnityEngine.Animator)):Play("open")
					end))
					slot0._lastShowFlow:addWork(WorkWaitSeconds.New(1))
				end
			end
		end
	end

	slot0._lastShowFlow:registerDoneListener(slot0._onLastShowFlowDone, slot0)
	slot0._lastShowFlow:start()
end

function slot0._onLastShowFlowDone(slot0)
	DungeonRpc.instance:sendMapElementRequest(12101091)
end

function slot0._OnRemoveElement(slot0, slot1)
	if slot1 == 12101091 then
		slot0:closeThis()
	end
end

function slot0._releaseAniFlow(slot0)
	if slot0._aniFlow then
		slot0._aniFlow:unregisterDoneListener(slot0._onAniFlowDone, slot0)
		slot0._aniFlow:destroy()

		slot0._aniFlow = nil
	end
end

function slot0._showReward(slot0)
	if string.nilorempty(slot0._selectConfig.bonus) then
		gohelper.setActive(slot0._gocollectReward, false)
		gohelper.setActive(slot0._gocanget, false)

		return
	end

	gohelper.setActive(slot0._gocollectReward, true)

	slot1 = string.splitToNumber(slot0._selectConfig.bonus, "#")
	slot0._reward = slot0._reward or IconMgr.instance:getCommonItemIcon(slot0._gocollectReward)

	slot0._reward:setMOValue(slot1[1], slot1[2], slot1[3])
	slot0._reward:setCountFontSize(34)
	gohelper.setActive(slot0._gocanget, not slot0.bonusFinished and slot0._haveClueCount == slot0._allClueCount)
end

function slot0.getStoryRedPoint(slot0)
	if VersionActivity1_2NoteModel.instance:getBonusFinished(slot0) then
		return false
	end

	for slot7, slot8 in ipairs(string.splitToNumber(lua_activity121_story.configDict[VersionActivityEnum.ActivityId.Act121][slot0].noteIds, "|")) do
		if VersionActivity1_2NoteModel.instance:getNote(slot8) and uv0.getNoteItemUnlockAniFinish(slot8) == 0 then
			return true
		end
	end
end

function slot0.getRedPoint()
	slot2 = VersionActivity1_2NoteConfig.instance
	slot4 = slot2

	for slot3, slot4 in ipairs(slot2.getStoryList(slot4)) do
		if uv0.getStoryRedPoint(slot4.id) then
			return true
		end
	end
end

function slot0._focusCollectedAllClueTab(slot0)
end

function slot0._selectStoryTabByGuide(slot0, slot1)
	slot0._selectIndex = tonumber(slot1)

	slot0:_refreshBtnState()
	slot0:_refreshData()
end

function slot0._markingKeyWordInStory(slot0, slot1)
	if slot0._guideMarkingStoryFlow then
		slot0._guideMarkingStoryFlow:stop()
		slot0._guideMarkingStoryFlow:destroy()

		slot0._guideMarkingStoryFlow = nil
	end

	slot0._guideMarkingStoryFlow = FlowSequence.New()
	slot2 = tonumber(slot1)
	slot0._curGuideMarkingStoryIndex = slot2

	slot0._guideMarkingStoryFlow:addWork(FunctionWork.New(function ()
		uv0:_onBtnClick(uv1)
	end))

	slot9 = 1

	slot0._guideMarkingStoryFlow:addWork(WorkWaitSeconds.New(slot9))

	for slot8, slot9 in ipairs(string.splitToNumber(slot0._storyList[slot2].clueIds, "|")) do
		if lua_activity121_clue.configDict[slot9][slot0._activityId].storyTag == 1 then
			slot0._guideMarkingStoryFlow:addWork(FunctionWork.New(function ()
				slot1 = gohelper.findChild(uv0._gocollectNote.transform:GetChild(uv1 - 1).gameObject, "go_storytag")

				gohelper.setActive(slot1, true)
				gohelper.onceAddComponent(slot1, typeof(UnityEngine.Animator)):Play("open")
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_level_chosen)
			end))
			slot0._guideMarkingStoryFlow:addWork(WorkWaitSeconds.New(1))
		end
	end

	slot0._guideMarkingStoryFlow:registerDoneListener(slot0._markingStoryFlowDone, slot0)
	slot0._guideMarkingStoryFlow:start()
end

function slot0._markingStoryFlowDone(slot0)
	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.CollectStoryAniEnd)
end

function slot0.onClose(slot0)
	if slot0._showGoCollectAniFlow then
		slot0._showGoCollectAniFlow:destroy()

		slot0._showGoCollectAniFlow = nil
	end

	if slot0._lastShowFlow then
		slot0._lastShowFlow:unregisterDoneListener(slot0._onLastShowFlowDone, slot0)
		slot0._lastShowFlow:destroy()

		slot0._lastShowFlow = nil
	end

	if slot0._guideMarkingStoryFlow then
		slot0._guideMarkingStoryFlow:stop()
		slot0._guideMarkingStoryFlow:destroy()

		slot0._guideMarkingStoryFlow = nil
	end

	slot0:_releaseAniFlow()
	TaskDispatcher.cancelTask(slot0._markNote, slot0)
	TaskDispatcher.cancelTask(slot0._refreshData, slot0)
	TaskDispatcher.cancelTask(slot0._afterUnlockNoteAni, slot0)
	TaskDispatcher.cancelTask(slot0._playUnlockNoteAni, slot0)

	if slot0._btnComList then
		for slot4, slot5 in ipairs(slot0._btnComList) do
			slot5:RemoveClickListener()
		end
	end

	if DungeonMapModel.instance:getElementById(12101091) then
		DungeonRpc.instance:sendMapElementRequest(12101091)
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagebookbg1:UnLoadImage()
	slot0._simagebookbg2:UnLoadImage()
	slot0._simagebookbg3:UnLoadImage()
	slot0._simagebookbg4:UnLoadImage()
	slot0._simagebookbg5:UnLoadImage()
	slot0._simagetitle:UnLoadImage()
	slot0._simageleftbookbg5:UnLoadImage()
	slot0._simagebookbg6:UnLoadImage()
end

return slot0
