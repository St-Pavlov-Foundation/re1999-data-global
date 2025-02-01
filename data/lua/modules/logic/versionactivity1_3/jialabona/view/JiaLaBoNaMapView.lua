module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaMapView", package.seeall)

slot0 = class("JiaLaBoNaMapView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "LeftTop/#simage_Title")
	slot0._btnRewardBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "RightTop/#btn_RewardBtn")
	slot0._goreddotreward = gohelper.findChild(slot0.viewGO, "RightTop/#go_reddotreward")
	slot0._golockNextPoint = gohelper.findChild(slot0.viewGO, "Map/Path1/#go_lockNextPoint")
	slot0._golockNext = gohelper.findChild(slot0.viewGO, "Map/Path1/#go_lockNext")
	slot0._btnLockNext = gohelper.findChildButtonWithAudio(slot0.viewGO, "Map/Path1/#go_lockNext/#btn_LockNext")
	slot0._goNextBtn = gohelper.findChild(slot0.viewGO, "Map/Path1/#go_NextBtn")
	slot0._btnNext = gohelper.findChildButtonWithAudio(slot0.viewGO, "Map/Path1/#go_NextBtn/#btn_Next")
	slot0._goPreviousBtn = gohelper.findChild(slot0.viewGO, "Map/Path2/#go_PreviousBtn")
	slot0._btnPrevious = gohelper.findChildButtonWithAudio(slot0.viewGO, "Map/Path2/#go_PreviousBtn/Root/#btn_Previous")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnRewardBtn:AddClickListener(slot0._btnRewardBtnOnClick, slot0)
	slot0._btnLockNext:AddClickListener(slot0._btnLockNextOnClick, slot0)
	slot0._btnNext:AddClickListener(slot0._btnNextOnClick, slot0)
	slot0._btnPrevious:AddClickListener(slot0._btnPreviousOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnRewardBtn:RemoveClickListener()
	slot0._btnLockNext:RemoveClickListener()
	slot0._btnNext:RemoveClickListener()
	slot0._btnPrevious:RemoveClickListener()
end

function slot0._btnRewardBtnOnClick(slot0)
	ViewMgr.instance:openView(ViewName.JiaLaBoNaTaskView)
end

function slot0._btnLockNextOnClick(slot0)
	if slot0:_isOpenByChapterId(JiaLaBoNaEnum.Chapter.Two) then
		return
	end

	if not JiaLaBoNaHelper.getFristEpisodeCoByChapterId(JiaLaBoNaEnum.Chapter.Two) then
		logNormal(string.format("can not find v1a3 activity episodeCfg. actId:%s chapterId:%s", VersionActivity1_3Enum.ActivityId.Act306, JiaLaBoNaEnum.Chapter.Two))

		return
	end

	JiaLaBoNaHelper.showToastByEpsodeId(slot1.id, true)
end

function slot0._btnNextOnClick(slot0)
	if slot0:_isOpenByChapterId(JiaLaBoNaEnum.Chapter.Two) then
		slot0:_delaySwitchPage(JiaLaBoNaEnum.Chapter.Two)
		AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_chapter_switch)
	end
end

function slot0._btnPreviousOnClick(slot0)
	slot0:_delaySwitchPage(JiaLaBoNaEnum.Chapter.One)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_chapter_switch)
end

function slot0._delaySwitchPage(slot0, slot1)
	if slot0.viewContainer then
		slot0.viewContainer:switchScene(slot1 == JiaLaBoNaEnum.Chapter.Two)

		slot0._delayPage = slot1

		TaskDispatcher.cancelTask(slot0._onDelaySwitchPage, slot0)
		TaskDispatcher.runDelay(slot0._onDelaySwitchPage, slot0, 0.5)
	end
end

function slot0._onDelaySwitchPage(slot0, slot1)
	slot0:_onShiwchPage(slot0._delayPage)
end

function slot0._editableInitView(slot0)
	slot0._Path1GO = gohelper.findChild(slot0.viewGO, "Map/Path1")
	slot0._Path2GO = gohelper.findChild(slot0.viewGO, "Map/Path2")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "Map/image_Mask")
	slot0._simageMainPath1 = gohelper.findChildSingleImage(slot0.viewGO, "Map/Path1/image_MainPath1")
	slot0._simageBranchPath1_1 = gohelper.findChildSingleImage(slot0.viewGO, "Map/Path1/image_BranchPath1_1")
	slot0._simageBranchPath1_2 = gohelper.findChildSingleImage(slot0.viewGO, "Map/Path1/image_BranchPath1_2")
	slot0._simageMainPath2 = gohelper.findChildSingleImage(slot0.viewGO, "Map/Path2/image_MainPath2")
	slot0._simageBranchPath2_1 = gohelper.findChildSingleImage(slot0.viewGO, "Map/Path2/#image_BranchPath2_1")
	slot0._simageBranchPath2_2 = gohelper.findChildSingleImage(slot0.viewGO, "Map/Path2/#image_BranchPath2_2")

	slot0._simagemask:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_igfullmask"))
	slot0._simageMainPath1:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_og_mapmainpath_1"))
	slot0._simageBranchPath1_1:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_og_mapbranchpath_1_1"))
	slot0._simageBranchPath1_2:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_og_mapbranchpath_1_2"))
	slot0._simageMainPath2:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_og_mapmainpath_2"))
	slot0._simageBranchPath2_1:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_og_mapbranchpath_2_1"))
	slot0._simageBranchPath2_2:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_og_mapbranchpath_2_2"))
	RedDotController.instance:addRedDot(slot0._goreddotreward, RedDotEnum.DotNode.Activity1_3RedDotAct120)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(JiaLaBoNaController.instance, JiaLaBoNaEvent.Refresh120MapData, slot0._onRefreshMapData, slot0)
	slot0:addEventCb(JiaLaBoNaController.instance, JiaLaBoNaEvent.SelectEpisode, slot0._onSelectEpisode, slot0)
	slot0:addEventCb(JiaLaBoNaController.instance, JiaLaBoNaEvent.ClearNewEpisode, slot0._onClearNewEpisode, slot0)
	slot0:_initStages()
	slot0:_refreshStageItemList()
	slot0:_refreshSelectStageItem()
	slot0:_onShiwchPage(slot0:_getSelectChapterId() or JiaLaBoNaEnum.Chapter.One, UIAnimationName.Open)
	slot0:_refreshUI()

	slot2, slot3 = JiaLaBoNaHelper.isOpenChapterDay(JiaLaBoNaEnum.Chapter.Two)

	if not slot2 and slot3 and slot3 > 0 then
		TaskDispatcher.runDelay(slot0._onCDCharpterOpen, slot0, slot3)
	end
end

function slot0._onRefreshMapData(slot0)
	if slot0._clrearNewEpisodeId then
		if slot0._canPlayNewEpisodeTime <= Time.time then
			if slot0.viewContainer and slot0.viewContainer.playPathAnim then
				slot0.viewContainer:playPathAnim()
			end

			if slot0:_getStageItemById(slot0._clrearNewEpisodeId) then
				slot1:refreshUI(true)
				AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_jlbn_level_pass)
			end

			TaskDispatcher.cancelTask(slot0._onDelayReshMapData, slot0)
			TaskDispatcher.runDelay(slot0._onDelayReshMapData, slot0, JiaLaBoNaEnum.AnimatorTime.ChapterPath)
			slot0.viewContainer:refreshInteract(slot0._clrearNewEpisodeId)
		end
	else
		slot0:_refreshStageItemList()
		slot0:_refreshUI()
	end
end

function slot0._onDelayReshMapData(slot0)
	slot0._clrearNewEpisodeId = nil

	if slot0:_getStageItemById(slot0._clrearNewEpisodeId, true) then
		if JiaLaBoNaHelper.isOpenDay(slot1:getCfgId()) then
			AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_jlbn_level_unlock)

			if slot1:getCfgChapterId() ~= slot0._curChapterId then
				slot0.viewContainer:refreshPathPoin()
				slot0:_onShiwchPage(slot2)
			end
		end

		slot1:refreshUI(true)
	end

	slot0:_refreshUI()
end

function slot0._onSelectEpisode(slot0)
	if slot0:_getSelectChapterId() and slot1 ~= slot0._curChapterId then
		slot0:_onShiwchPage(slot1)
	end

	slot0:_refreshSelectStageItem()
end

function slot0._onClearNewEpisode(slot0, slot1)
	if slot1 then
		slot0._clrearNewEpisodeId = slot1
		slot0._canPlayNewEpisodeTime = Time.time + JiaLaBoNaEnum.AnimatorTime.MapViewOpen - 0.05

		TaskDispatcher.cancelTask(slot0._onRefreshMapData, slot0)
		TaskDispatcher.runDelay(slot0._onRefreshMapData, slot0, JiaLaBoNaEnum.AnimatorTime.MapViewOpen)

		if slot0:_getStageItemById(slot0._clrearNewEpisodeId) then
			slot2:_unLockUI()
		end

		if slot0:_getStageItemById(slot0._clrearNewEpisodeId, true) then
			slot3:_lockUI()
		end
	end
end

function slot0._onCDCharpterOpen(slot0)
	if not slot0._clrearNewEpisodeId then
		slot0:_refreshStageItemList()
		slot0:_refreshUI()
	end
end

function slot0._onShiwchPage(slot0, slot1, slot2)
	slot0._curChapterId = slot1

	gohelper.setActive(slot0._Path1GO, slot1 ~= JiaLaBoNaEnum.Chapter.Two)
	gohelper.setActive(slot0._Path2GO, slot1 == JiaLaBoNaEnum.Chapter.Two)

	if slot0.viewContainer and slot0.viewContainer.switchPage then
		slot0.viewContainer:switchPage(slot1, slot2)
	end
end

function slot0._initStages(slot0)
	if slot0._stageItemList then
		return
	end

	slot1 = JiaLaBoNaMapViewStageItem.prefabPath
	slot0._stageItemList = {}

	for slot6, slot7 in ipairs({
		slot0._Path1GO,
		slot0._Path2GO
	}) do
		for slot11 = 1, 4 do
			slot13 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot1, gohelper.findChild(slot7, string.format("#go_Stage%s", slot11))), JiaLaBoNaMapViewStageItem, slot0)

			slot13:setStageType(slot11 < 5 and JiaLaBoNaEnum.StageType.Main or JiaLaBoNaEnum.StageType.Branch)
			table.insert(slot0._stageItemList, slot13)
		end
	end

	slot0._episodeCfgList, slot0._chapterIdList = Activity120Config.instance:getEpisodeList(VersionActivity1_3Enum.ActivityId.Act306)

	for slot7, slot8 in ipairs(slot0._episodeCfgList) do
		slot0._stageItemList[slot7]:setCfg(slot8)
	end
end

function slot0._getSelectChapterId(slot0)
	if not slot0._episodeCfgList or #slot0._episodeCfgList < 1 then
		return
	end

	if Activity120Model.instance:getCurEpisodeId() and Activity120Config.instance:getEpisodeCo(VersionActivity1_3Enum.ActivityId.Act306, slot2) and JiaLaBoNaHelper.isOpenDay(slot2) then
		return slot3.chapterId
	end

	slot4 = slot0._episodeCfgList[1]

	for slot8, slot9 in ipairs(slot0._episodeCfgList) do
		if slot1:isEpisodeClear(slot9.id) then
			slot4 = slot9
		else
			if JiaLaBoNaHelper.isOpenDay(slot9.id) then
				slot4 = slot9
			end

			break
		end
	end

	if slot4 then
		slot1:setCurEpisodeId(slot4.id)

		return slot4.chapterId
	end
end

function slot0._isCanShowChapter(slot0, slot1)
	if JiaLaBoNaHelper.getFristEpisodeCoByChapterId(slot1) and (Activity120Model.instance:isEpisodeClear(slot2.id) or slot2.preEpisode == 0 or slot3:isEpisodeClear(slot2.preEpisode)) then
		return true
	end

	return false
end

function slot0._isOpenByChapterId(slot0, slot1)
	return JiaLaBoNaHelper.isOpenChapterDay(slot1, false)
end

function slot0._refreshUI(slot0)
	slot1, slot2 = slot0:_isOpenByChapterId(JiaLaBoNaEnum.Chapter.Two)

	gohelper.setActive(slot0._golockNext, not slot1)
	gohelper.setActive(slot0._goNextBtn, slot1)
	gohelper.setActive(slot0._golockNextPoint, not slot1)
end

function slot0._getStageItemById(slot0, slot1, slot2)
	for slot6 = 1, #slot0._stageItemList do
		slot7 = slot0._stageItemList[slot6]

		if slot2 then
			if slot7:getCfgPreId() == slot1 then
				return slot7
			end
		elseif slot7:getCfgId() == slot1 then
			return slot7
		end
	end
end

function slot0._refreshStageItemList(slot0)
	for slot4 = 1, #slot0._stageItemList do
		slot0._stageItemList[slot4]:refreshUI()
	end
end

function slot0._refreshSelectStageItem(slot0)
	for slot4 = 1, #slot0._stageItemList do
		slot0._stageItemList[slot4]:onSelect()
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onDelaySwitchPage, slot0)
	TaskDispatcher.cancelTask(slot0._onDelayReshMapData, slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshMapData, slot0)
	TaskDispatcher.cancelTask(slot0._onCDCharpterOpen, slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._stageItemList then
		for slot4, slot5 in ipairs(slot0._stageItemList) do
			slot5:onDestroyView()
		end

		slot0._stageItemList = nil
	end

	slot0._simagemask:UnLoadImage()
	slot0._simageMainPath1:UnLoadImage()
	slot0._simageBranchPath1_1:UnLoadImage()
	slot0._simageBranchPath1_2:UnLoadImage()
	slot0._simageMainPath2:UnLoadImage()
	slot0._simageBranchPath2_1:UnLoadImage()
	slot0._simageBranchPath2_2:UnLoadImage()
end

return slot0
