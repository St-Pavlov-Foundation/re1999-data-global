module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaMapView", package.seeall)

local var_0_0 = class("JiaLaBoNaMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "LeftTop/#simage_Title")
	arg_1_0._btnRewardBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "RightTop/#btn_RewardBtn")
	arg_1_0._goreddotreward = gohelper.findChild(arg_1_0.viewGO, "RightTop/#go_reddotreward")
	arg_1_0._golockNextPoint = gohelper.findChild(arg_1_0.viewGO, "Map/Path1/#go_lockNextPoint")
	arg_1_0._golockNext = gohelper.findChild(arg_1_0.viewGO, "Map/Path1/#go_lockNext")
	arg_1_0._btnLockNext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Map/Path1/#go_lockNext/#btn_LockNext")
	arg_1_0._goNextBtn = gohelper.findChild(arg_1_0.viewGO, "Map/Path1/#go_NextBtn")
	arg_1_0._btnNext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Map/Path1/#go_NextBtn/#btn_Next")
	arg_1_0._goPreviousBtn = gohelper.findChild(arg_1_0.viewGO, "Map/Path2/#go_PreviousBtn")
	arg_1_0._btnPrevious = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Map/Path2/#go_PreviousBtn/Root/#btn_Previous")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnRewardBtn:AddClickListener(arg_2_0._btnRewardBtnOnClick, arg_2_0)
	arg_2_0._btnLockNext:AddClickListener(arg_2_0._btnLockNextOnClick, arg_2_0)
	arg_2_0._btnNext:AddClickListener(arg_2_0._btnNextOnClick, arg_2_0)
	arg_2_0._btnPrevious:AddClickListener(arg_2_0._btnPreviousOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnRewardBtn:RemoveClickListener()
	arg_3_0._btnLockNext:RemoveClickListener()
	arg_3_0._btnNext:RemoveClickListener()
	arg_3_0._btnPrevious:RemoveClickListener()
end

function var_0_0._btnRewardBtnOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.JiaLaBoNaTaskView)
end

function var_0_0._btnLockNextOnClick(arg_5_0)
	if arg_5_0:_isOpenByChapterId(JiaLaBoNaEnum.Chapter.Two) then
		return
	end

	local var_5_0 = JiaLaBoNaHelper.getFristEpisodeCoByChapterId(JiaLaBoNaEnum.Chapter.Two)

	if not var_5_0 then
		logNormal(string.format("can not find v1a3 activity episodeCfg. actId:%s chapterId:%s", VersionActivity1_3Enum.ActivityId.Act306, JiaLaBoNaEnum.Chapter.Two))

		return
	end

	JiaLaBoNaHelper.showToastByEpsodeId(var_5_0.id, true)
end

function var_0_0._btnNextOnClick(arg_6_0)
	if arg_6_0:_isOpenByChapterId(JiaLaBoNaEnum.Chapter.Two) then
		arg_6_0:_delaySwitchPage(JiaLaBoNaEnum.Chapter.Two)
		AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_chapter_switch)
	end
end

function var_0_0._btnPreviousOnClick(arg_7_0)
	arg_7_0:_delaySwitchPage(JiaLaBoNaEnum.Chapter.One)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_chapter_switch)
end

function var_0_0._delaySwitchPage(arg_8_0, arg_8_1)
	if arg_8_0.viewContainer then
		arg_8_0.viewContainer:switchScene(arg_8_1 == JiaLaBoNaEnum.Chapter.Two)

		arg_8_0._delayPage = arg_8_1

		TaskDispatcher.cancelTask(arg_8_0._onDelaySwitchPage, arg_8_0)
		TaskDispatcher.runDelay(arg_8_0._onDelaySwitchPage, arg_8_0, 0.5)
	end
end

function var_0_0._onDelaySwitchPage(arg_9_0, arg_9_1)
	arg_9_0:_onShiwchPage(arg_9_0._delayPage)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._Path1GO = gohelper.findChild(arg_10_0.viewGO, "Map/Path1")
	arg_10_0._Path2GO = gohelper.findChild(arg_10_0.viewGO, "Map/Path2")
	arg_10_0._simagemask = gohelper.findChildSingleImage(arg_10_0.viewGO, "Map/image_Mask")
	arg_10_0._simageMainPath1 = gohelper.findChildSingleImage(arg_10_0.viewGO, "Map/Path1/image_MainPath1")
	arg_10_0._simageBranchPath1_1 = gohelper.findChildSingleImage(arg_10_0.viewGO, "Map/Path1/image_BranchPath1_1")
	arg_10_0._simageBranchPath1_2 = gohelper.findChildSingleImage(arg_10_0.viewGO, "Map/Path1/image_BranchPath1_2")
	arg_10_0._simageMainPath2 = gohelper.findChildSingleImage(arg_10_0.viewGO, "Map/Path2/image_MainPath2")
	arg_10_0._simageBranchPath2_1 = gohelper.findChildSingleImage(arg_10_0.viewGO, "Map/Path2/#image_BranchPath2_1")
	arg_10_0._simageBranchPath2_2 = gohelper.findChildSingleImage(arg_10_0.viewGO, "Map/Path2/#image_BranchPath2_2")

	arg_10_0._simagemask:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_igfullmask"))
	arg_10_0._simageMainPath1:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_og_mapmainpath_1"))
	arg_10_0._simageBranchPath1_1:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_og_mapbranchpath_1_1"))
	arg_10_0._simageBranchPath1_2:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_og_mapbranchpath_1_2"))
	arg_10_0._simageMainPath2:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_og_mapmainpath_2"))
	arg_10_0._simageBranchPath2_1:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_og_mapbranchpath_2_1"))
	arg_10_0._simageBranchPath2_2:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_og_mapbranchpath_2_2"))
	RedDotController.instance:addRedDot(arg_10_0._goreddotreward, RedDotEnum.DotNode.Activity1_3RedDotAct120)
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:addEventCb(JiaLaBoNaController.instance, JiaLaBoNaEvent.Refresh120MapData, arg_12_0._onRefreshMapData, arg_12_0)
	arg_12_0:addEventCb(JiaLaBoNaController.instance, JiaLaBoNaEvent.SelectEpisode, arg_12_0._onSelectEpisode, arg_12_0)
	arg_12_0:addEventCb(JiaLaBoNaController.instance, JiaLaBoNaEvent.ClearNewEpisode, arg_12_0._onClearNewEpisode, arg_12_0)
	arg_12_0:_initStages()

	local var_12_0 = arg_12_0:_getSelectChapterId() or JiaLaBoNaEnum.Chapter.One

	arg_12_0:_refreshStageItemList()
	arg_12_0:_refreshSelectStageItem()
	arg_12_0:_onShiwchPage(var_12_0, UIAnimationName.Open)
	arg_12_0:_refreshUI()

	local var_12_1, var_12_2 = JiaLaBoNaHelper.isOpenChapterDay(JiaLaBoNaEnum.Chapter.Two)

	if not var_12_1 and var_12_2 and var_12_2 > 0 then
		TaskDispatcher.runDelay(arg_12_0._onCDCharpterOpen, arg_12_0, var_12_2)
	end
end

function var_0_0._onRefreshMapData(arg_13_0)
	if arg_13_0._clrearNewEpisodeId then
		if arg_13_0._canPlayNewEpisodeTime <= Time.time then
			if arg_13_0.viewContainer and arg_13_0.viewContainer.playPathAnim then
				arg_13_0.viewContainer:playPathAnim()
			end

			local var_13_0 = arg_13_0:_getStageItemById(arg_13_0._clrearNewEpisodeId)

			if var_13_0 then
				var_13_0:refreshUI(true)
				AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_jlbn_level_pass)
			end

			TaskDispatcher.cancelTask(arg_13_0._onDelayReshMapData, arg_13_0)
			TaskDispatcher.runDelay(arg_13_0._onDelayReshMapData, arg_13_0, JiaLaBoNaEnum.AnimatorTime.ChapterPath)
			arg_13_0.viewContainer:refreshInteract(arg_13_0._clrearNewEpisodeId)
		end
	else
		arg_13_0:_refreshStageItemList()
		arg_13_0:_refreshUI()
	end
end

function var_0_0._onDelayReshMapData(arg_14_0)
	local var_14_0 = arg_14_0:_getStageItemById(arg_14_0._clrearNewEpisodeId, true)

	arg_14_0._clrearNewEpisodeId = nil

	if var_14_0 then
		if JiaLaBoNaHelper.isOpenDay(var_14_0:getCfgId()) then
			AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_jlbn_level_unlock)

			local var_14_1 = var_14_0:getCfgChapterId()

			if var_14_1 ~= arg_14_0._curChapterId then
				arg_14_0.viewContainer:refreshPathPoin()
				arg_14_0:_onShiwchPage(var_14_1)
			end
		end

		var_14_0:refreshUI(true)
	end

	arg_14_0:_refreshUI()
end

function var_0_0._onSelectEpisode(arg_15_0)
	local var_15_0 = arg_15_0:_getSelectChapterId()

	if var_15_0 and var_15_0 ~= arg_15_0._curChapterId then
		arg_15_0:_onShiwchPage(var_15_0)
	end

	arg_15_0:_refreshSelectStageItem()
end

function var_0_0._onClearNewEpisode(arg_16_0, arg_16_1)
	if arg_16_1 then
		arg_16_0._clrearNewEpisodeId = arg_16_1
		arg_16_0._canPlayNewEpisodeTime = Time.time + JiaLaBoNaEnum.AnimatorTime.MapViewOpen - 0.05

		TaskDispatcher.cancelTask(arg_16_0._onRefreshMapData, arg_16_0)
		TaskDispatcher.runDelay(arg_16_0._onRefreshMapData, arg_16_0, JiaLaBoNaEnum.AnimatorTime.MapViewOpen)

		local var_16_0 = arg_16_0:_getStageItemById(arg_16_0._clrearNewEpisodeId)

		if var_16_0 then
			var_16_0:_unLockUI()
		end

		local var_16_1 = arg_16_0:_getStageItemById(arg_16_0._clrearNewEpisodeId, true)

		if var_16_1 then
			var_16_1:_lockUI()
		end
	end
end

function var_0_0._onCDCharpterOpen(arg_17_0)
	if not arg_17_0._clrearNewEpisodeId then
		arg_17_0:_refreshStageItemList()
		arg_17_0:_refreshUI()
	end
end

function var_0_0._onShiwchPage(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._curChapterId = arg_18_1

	gohelper.setActive(arg_18_0._Path1GO, arg_18_1 ~= JiaLaBoNaEnum.Chapter.Two)
	gohelper.setActive(arg_18_0._Path2GO, arg_18_1 == JiaLaBoNaEnum.Chapter.Two)

	if arg_18_0.viewContainer and arg_18_0.viewContainer.switchPage then
		arg_18_0.viewContainer:switchPage(arg_18_1, arg_18_2)
	end
end

function var_0_0._initStages(arg_19_0)
	if arg_19_0._stageItemList then
		return
	end

	local var_19_0 = JiaLaBoNaMapViewStageItem.prefabPath
	local var_19_1 = {
		arg_19_0._Path1GO,
		arg_19_0._Path2GO
	}

	arg_19_0._stageItemList = {}

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		for iter_19_2 = 1, 4 do
			local var_19_2 = arg_19_0:getResInst(var_19_0, gohelper.findChild(iter_19_1, string.format("#go_Stage%s", iter_19_2)))
			local var_19_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_19_2, JiaLaBoNaMapViewStageItem, arg_19_0)

			var_19_3:setStageType(iter_19_2 < 5 and JiaLaBoNaEnum.StageType.Main or JiaLaBoNaEnum.StageType.Branch)
			table.insert(arg_19_0._stageItemList, var_19_3)
		end
	end

	local var_19_4 = VersionActivity1_3Enum.ActivityId.Act306

	arg_19_0._episodeCfgList, arg_19_0._chapterIdList = Activity120Config.instance:getEpisodeList(var_19_4)

	for iter_19_3, iter_19_4 in ipairs(arg_19_0._episodeCfgList) do
		arg_19_0._stageItemList[iter_19_3]:setCfg(iter_19_4)
	end
end

function var_0_0._getSelectChapterId(arg_20_0)
	if not arg_20_0._episodeCfgList or #arg_20_0._episodeCfgList < 1 then
		return
	end

	local var_20_0 = Activity120Model.instance
	local var_20_1 = var_20_0:getCurEpisodeId()
	local var_20_2 = var_20_1 and Activity120Config.instance:getEpisodeCo(VersionActivity1_3Enum.ActivityId.Act306, var_20_1)

	if var_20_2 and JiaLaBoNaHelper.isOpenDay(var_20_1) then
		return var_20_2.chapterId
	end

	local var_20_3 = arg_20_0._episodeCfgList[1]

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._episodeCfgList) do
		if var_20_0:isEpisodeClear(iter_20_1.id) then
			var_20_3 = iter_20_1
		else
			if JiaLaBoNaHelper.isOpenDay(iter_20_1.id) then
				var_20_3 = iter_20_1
			end

			break
		end
	end

	if var_20_3 then
		var_20_0:setCurEpisodeId(var_20_3.id)

		return var_20_3.chapterId
	end
end

function var_0_0._isCanShowChapter(arg_21_0, arg_21_1)
	local var_21_0 = JiaLaBoNaHelper.getFristEpisodeCoByChapterId(arg_21_1)

	if var_21_0 then
		local var_21_1 = Activity120Model.instance

		if var_21_1:isEpisodeClear(var_21_0.id) or var_21_0.preEpisode == 0 or var_21_1:isEpisodeClear(var_21_0.preEpisode) then
			return true
		end
	end

	return false
end

function var_0_0._isOpenByChapterId(arg_22_0, arg_22_1)
	return JiaLaBoNaHelper.isOpenChapterDay(arg_22_1, false)
end

function var_0_0._refreshUI(arg_23_0)
	local var_23_0, var_23_1 = arg_23_0:_isOpenByChapterId(JiaLaBoNaEnum.Chapter.Two)

	gohelper.setActive(arg_23_0._golockNext, not var_23_0)
	gohelper.setActive(arg_23_0._goNextBtn, var_23_0)
	gohelper.setActive(arg_23_0._golockNextPoint, not var_23_0)
end

function var_0_0._getStageItemById(arg_24_0, arg_24_1, arg_24_2)
	for iter_24_0 = 1, #arg_24_0._stageItemList do
		local var_24_0 = arg_24_0._stageItemList[iter_24_0]

		if arg_24_2 then
			if var_24_0:getCfgPreId() == arg_24_1 then
				return var_24_0
			end
		elseif var_24_0:getCfgId() == arg_24_1 then
			return var_24_0
		end
	end
end

function var_0_0._refreshStageItemList(arg_25_0)
	for iter_25_0 = 1, #arg_25_0._stageItemList do
		arg_25_0._stageItemList[iter_25_0]:refreshUI()
	end
end

function var_0_0._refreshSelectStageItem(arg_26_0)
	for iter_26_0 = 1, #arg_26_0._stageItemList do
		arg_26_0._stageItemList[iter_26_0]:onSelect()
	end
end

function var_0_0.onClose(arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._onDelaySwitchPage, arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._onDelayReshMapData, arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._onRefreshMapData, arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._onCDCharpterOpen, arg_27_0)
end

function var_0_0.onDestroyView(arg_28_0)
	if arg_28_0._stageItemList then
		for iter_28_0, iter_28_1 in ipairs(arg_28_0._stageItemList) do
			iter_28_1:onDestroyView()
		end

		arg_28_0._stageItemList = nil
	end

	arg_28_0._simagemask:UnLoadImage()
	arg_28_0._simageMainPath1:UnLoadImage()
	arg_28_0._simageBranchPath1_1:UnLoadImage()
	arg_28_0._simageBranchPath1_2:UnLoadImage()
	arg_28_0._simageMainPath2:UnLoadImage()
	arg_28_0._simageBranchPath2_1:UnLoadImage()
	arg_28_0._simageBranchPath2_2:UnLoadImage()
end

return var_0_0
