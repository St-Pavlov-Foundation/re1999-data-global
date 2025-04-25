module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoEpisodeLevelView", package.seeall)

slot0 = class("FeiLinShiDuoEpisodeLevelView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageFullBG1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG1")
	slot0._gostoryPath = gohelper.findChild(slot0.viewGO, "#go_storyPath")
	slot0._gostoryScroll = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll")
	slot0._gostoryStages = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	slot0._goTitle = gohelper.findChild(slot0.viewGO, "#go_Title")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#go_Title/#simage_title")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "#go_Title/#go_time")
	slot0._txtlimittime = gohelper.findChildText(slot0.viewGO, "#go_Title/#go_time/#txt_limittime")
	slot0._btnPlayBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Title/#btn_PlayBtn")
	slot0._btnTask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Task")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#btn_Task/#go_reddot")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._scrollStory = gohelper.findChildScrollRect(slot0._gostoryPath, "")
	slot0._goPath = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll/path/path_2")
	slot0._animPath = slot0._goPath:GetComponent(gohelper.Type_Animator)
	slot0._animPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnPlayBtn:AddClickListener(slot0._btnPlayBtnOnClick, slot0)
	slot0._btnTask:AddClickListener(slot0._btnTaskOnClick, slot0)
	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._touch:AddClickDownListener(slot0._onClickDown, slot0)
	slot0._scrollStory:AddOnValueChanged(slot0._onScrollValueChanged, slot0)
	slot0:addEventCb(FeiLinShiDuoGameController.instance, FeiLinShiDuoEvent.SelectEpisode, slot0.onSelectEpisode, slot0)
	slot0:addEventCb(FeiLinShiDuoGameController.instance, FeiLinShiDuoEvent.NextEpisodePlayUnlockAnim, slot0.playEpisodeUnlockAnim, slot0)
	slot0:addEventCb(FeiLinShiDuoGameController.instance, FeiLinShiDuoEvent.SwitchBG, slot0.switchBG, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0, LuaEventSystem.Low)
end

function slot0.removeEvents(slot0)
	slot0._btnPlayBtn:RemoveClickListener()
	slot0._btnTask:RemoveClickListener()
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
	slot0._touch:RemoveClickDownListener()
	slot0._scrollStory:RemoveOnValueChanged()
	slot0:removeEventCb(FeiLinShiDuoGameController.instance, FeiLinShiDuoEvent.SelectEpisode, slot0.onSelectEpisode, slot0)
	slot0:removeEventCb(FeiLinShiDuoGameController.instance, FeiLinShiDuoEvent.NextEpisodePlayUnlockAnim, slot0.playEpisodeUnlockAnim, slot0)
	slot0:removeEventCb(FeiLinShiDuoGameController.instance, FeiLinShiDuoEvent.SwitchBG, slot0.switchBG, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
end

function slot0._btnPlayBtnOnClick(slot0)
	StoryController.instance:playStory(ActivityModel.instance:getActMO(slot0.activityId) and slot1.config and slot1.config.storyId)
end

function slot0._btnTaskOnClick(slot0)
	FeiLinShiDuoGameController.instance:openTaskView({
		activityId = slot0.activityId
	})
end

function slot0._editableInitView(slot0)
	slot0._taskAnimator = slot0._btnTask.gameObject:GetComponentInChildren(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.V2a5_Act185Task, nil, slot0.refreshReddot, slot0)

	slot0.activityId = VersionActivity2_5Enum.ActivityId.FeiLinShiDuo

	slot0:initEpisodeItem()

	slot1 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	slot0._offsetX = (slot1 - -300) / 2
	slot0.minContentAnchorX = -4760 + slot1
	slot0._bgWidth = recthelper.getWidth(slot0._simageFullBG1.transform)
	slot0._minBgPositionX = BootNativeUtil.getDisplayResolution() - slot0._bgWidth
	slot0._maxBgPositionX = 0
	slot0._bgPositonMaxOffsetX = math.abs(slot0._maxBgPositionX - slot0._minBgPositionX)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._gostoryPath)
	slot0._touch = SLFramework.UGUI.UIClickListener.Get(slot0._gostoryPath)
	slot0._audioScroll = MonoHelper.addLuaComOnceToGo(slot0._gostoryPath, DungeonMapEpisodeAudio, slot0._scrollStory)
end

function slot0.initEpisodeItem(slot0)
	slot0.episodeItemList = slot0:getUserDataTb_()
	slot0.stageCount = slot0._gostoryStages.transform.childCount

	for slot5 = 1, slot0.stageCount do
		slot8 = slot0:getResInst(slot0.viewContainer._viewSetting.otherRes[1], slot1:GetChild(slot5 - 1).gameObject, string.format("item_%s", slot5))
		slot9 = MonoHelper.addLuaComOnceToGo(slot8, FeiLinShiDuoEpisodeItem)

		slot9:onInit(slot8)
		table.insert(slot0.episodeItemList, slot9)
	end
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0._audioScroll:onDragBegin()
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot0._audioScroll:onDragEnd()
end

function slot0._onScrollValueChanged(slot0)
end

function slot0._onClickDown(slot0)
	slot0._audioScroll:onClickDown()
end

function slot0.onOpen(slot0)
	slot0:refreshTime()
	slot0:refreshUI()
	TaskDispatcher.runRepeat(slot0.refreshTime, slot0, TimeUtil.OneMinuteSecond)
	slot0:focusEpisodeItem(slot0:getCurEpisodeIndex(), slot0.curEpisodeId, false, false)
end

function slot0.getCurEpisodeIndex(slot0)
	for slot6, slot7 in ipairs(slot0.episodeItemList) do
		if slot7.episodeId == (FeiLinShiDuoConfig.instance:getEpisodeConfig(slot0.activityId, slot0.curEpisodeId).mapId > 0 and slot1.preEpisodeId or slot1.episodeId) then
			return slot6
		end
	end

	return 1
end

function slot0.refreshUI(slot0)
	slot0:refreshTaskInfo()
	slot0:refreshEpisode()
	slot0:refreshEpisodeItem()
end

function slot0.refreshTaskInfo(slot0)
	FeiLinShiDuoTaskListModel.instance:init(slot0.activityId)
end

function slot0.refreshEpisode(slot0)
	slot0.curEpisodeId = FeiLinShiDuoModel.instance:getCurEpisodeId()

	if FeiLinShiDuoModel.instance:getFinishStageIndex() == 0 then
		gohelper.setActive(slot0._goPath, false)
	else
		gohelper.setActive(slot0._goPath, true)

		slot0._animPath.speed = 1

		slot0._animPath:Play("go" .. slot2, 0, 1)
	end

	if slot2 < slot0.stageCount then
		if slot2 + 1 == slot0.stageCount then
			for slot7, slot8 in pairs(FeiLinShiDuoConfig.instance:getStageEpisodes(slot0.stageCount)) do
				if not FeiLinShiDuoModel.instance.episodeFinishMap[slot8.episodeId] and slot8.storyId > 0 then
					slot0._simageFullBG:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg" .. slot0.stageCount - 1))
					slot0._simageFullBG1:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg" .. slot0.stageCount))

					break
				else
					slot0._simageFullBG:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg" .. slot0.stageCount))
					slot0._simageFullBG1:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg0"))

					break
				end
			end
		else
			slot0._simageFullBG:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg" .. slot2))
			slot0._simageFullBG1:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg" .. slot2 + 1))
		end
	else
		slot0._simageFullBG:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg" .. slot0.stageCount))
		slot0._simageFullBG1:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg0"))
	end
end

function slot0.isAllEpisodeFinish(slot0)
	for slot5, slot6 in ipairs(FeiLinShiDuoConfig.instance:getEpisodeConfigList()) do
		if not FeiLinShiDuoModel.instance.episodeFinishMap[slot6.episodeId] then
			return false
		end
	end

	return true
end

function slot0.refreshEpisodeItem(slot0)
	if #FeiLinShiDuoConfig.instance:getNoGameEpisodeList(slot0.activityId) > #slot0.episodeItemList then
		logError("配置关卡数量不匹配，请检查")

		return
	end

	for slot5, slot6 in ipairs(slot0.episodeItemList) do
		if slot5 > #slot1 then
			slot6:isShowItem(false)
		else
			slot6:setInfo(slot5, slot1[slot5])
		end
	end
end

function slot0.onSelectEpisode(slot0, slot1, slot2, slot3)
	slot0.curEpisodeId = slot2

	slot0:focusEpisodeItem(slot1, slot2, slot3, true)
end

function slot0.focusEpisodeItem(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0._offsetX - recthelper.getAnchorX(slot0.episodeItemList[slot1]._go.transform.parent) > 0 then
		slot8 = 0
	elseif slot8 < slot0.minContentAnchorX then
		slot8 = slot0.minContentAnchorX
	end

	if slot4 then
		if slot5 then
			ZProj.TweenHelper.DOAnchorPosX(slot0._gostoryScroll.transform, slot8, 0.26)
		else
			ZProj.TweenHelper.DOAnchorPosX(slot0._gostoryScroll.transform, slot8, 0.26, slot0.onFocusEnd, slot0, {
				slot2,
				slot3
			})
		end
	else
		ZProj.TweenHelper.DOAnchorPosX(slot0._gostoryScroll.transform, slot8, 0)
	end
end

function slot0.onFocusEnd(slot0, slot1)
	slot0.curEpisodeId = slot1[1]
	slot0.isGame = slot1[2]

	if slot0.isGame then
		if FeiLinShiDuoConfig.instance:getGameEpisode(slot0.curEpisodeId) and slot2.mapId > 0 then
			FeiLinShiDuoGameController.instance:openGameView({
				mapId = slot2.mapId,
				gameConfig = slot2
			})
		else
			logError(slot0.curEpisodeId .. " 该关卡没有对应的游戏关卡")
		end
	else
		if not (FeiLinShiDuoConfig.instance:getEpisodeConfig(slot0.activityId, slot0.curEpisodeId) and slot2.storyId) then
			logError("剧情关卡没有配置剧情， 请检查：" .. slot0.curEpisodeId)

			return
		end

		if FeiLinShiDuoModel.instance:getEpisodeFinishState(slot0.curEpisodeId) then
			StoryController.instance:playStory(slot3)

			return
		end

		StoryController.instance:playStory(slot3, {
			mark = true,
			episodeId = slot0.curEpisodeId
		}, slot0.onStoryFinished, slot0)
	end
end

function slot0.onStoryFinished(slot0)
	FeiLinShiDuoGameController.instance:finishEpisode(slot0.activityId, slot0.curEpisodeId)
end

function slot0.onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.FeiLinShiDuoResultView or slot1 == ViewName.StoryFrontView then
		slot0:onEpisodeFinish(slot1)
	end
end

function slot0.onEpisodeFinish(slot0, slot1)
	if slot1 == ViewName.StoryFrontView then
		FeiLinShiDuoStatHelper.instance:sendDungeonFinish()
	end

	if FeiLinShiDuoModel.instance:getCurFinishEpisodeId() and slot2 > 0 then
		FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.EpisodeItemPlayFinishAnim, slot2)
	end

	FeiLinShiDuoModel.instance:setCurFinishEpisodeId(0)
end

function slot0.playEpisodeUnlockAnim(slot0, slot1)
	slot0.curEpisodeId = slot1

	slot0:focusEpisodeItem(slot0:getCurEpisodeIndex(), slot0.curEpisodeId, false, true, true)
	slot0:switchBG()
end

function slot0.switchBG(slot0, slot1)
	slot0:refreshEpisode()

	if slot1 then
		slot0._animPlayer:Play("switch", slot0.switchBGFinish, slot0)
	end
end

function slot0.switchBGFinish(slot0)
end

function slot0.refreshReddot(slot0, slot1)
	slot1:defaultRefreshDot()
	slot0._taskAnimator:Play(slot1.show and "loop" or "idle")
end

function slot0.refreshTime(slot0)
	if ActivityModel.instance:getActivityInfo()[slot0.activityId] and slot1:getRealEndTimeStamp() - ServerTime.now() > 0 then
		slot0._txtlimittime.text = TimeUtil.SecondToActivityTimeFormat(slot2)

		return
	end

	TaskDispatcher.cancelTask(slot0.refreshTime, slot0)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshTime, slot0)
	FeiLinShiDuoModel.instance:setCurEpisodeId(0)
end

function slot0.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
	slot0._simageFullBG1:UnLoadImage()
	FeiLinShiDuoModel.instance:reInit()
end

return slot0
