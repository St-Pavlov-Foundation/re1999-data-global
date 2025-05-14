module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoEpisodeLevelView", package.seeall)

local var_0_0 = class("FeiLinShiDuoEpisodeLevelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageFullBG1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG1")
	arg_1_0._gostoryPath = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath")
	arg_1_0._gostoryScroll = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll")
	arg_1_0._gostoryStages = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	arg_1_0._goTitle = gohelper.findChild(arg_1_0.viewGO, "#go_Title")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Title/#simage_title")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "#go_Title/#go_time")
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0.viewGO, "#go_Title/#go_time/#txt_limittime")
	arg_1_0._btnPlayBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Title/#btn_PlayBtn")
	arg_1_0._btnTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Task")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#btn_Task/#go_reddot")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._scrollStory = gohelper.findChildScrollRect(arg_1_0._gostoryPath, "")
	arg_1_0._goPath = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/path/path_2")
	arg_1_0._animPath = arg_1_0._goPath:GetComponent(gohelper.Type_Animator)
	arg_1_0._animPlayer = SLFramework.AnimatorPlayer.Get(arg_1_0.viewGO)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnPlayBtn:AddClickListener(arg_2_0._btnPlayBtnOnClick, arg_2_0)
	arg_2_0._btnTask:AddClickListener(arg_2_0._btnTaskOnClick, arg_2_0)
	arg_2_0._drag:AddDragBeginListener(arg_2_0._onDragBegin, arg_2_0)
	arg_2_0._drag:AddDragEndListener(arg_2_0._onDragEnd, arg_2_0)
	arg_2_0._touch:AddClickDownListener(arg_2_0._onClickDown, arg_2_0)
	arg_2_0._scrollStory:AddOnValueChanged(arg_2_0._onScrollValueChanged, arg_2_0)
	arg_2_0:addEventCb(FeiLinShiDuoGameController.instance, FeiLinShiDuoEvent.SelectEpisode, arg_2_0.onSelectEpisode, arg_2_0)
	arg_2_0:addEventCb(FeiLinShiDuoGameController.instance, FeiLinShiDuoEvent.NextEpisodePlayUnlockAnim, arg_2_0.playEpisodeUnlockAnim, arg_2_0)
	arg_2_0:addEventCb(FeiLinShiDuoGameController.instance, FeiLinShiDuoEvent.SwitchBG, arg_2_0.switchBG, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0.onCloseViewFinish, arg_2_0, LuaEventSystem.Low)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnPlayBtn:RemoveClickListener()
	arg_3_0._btnTask:RemoveClickListener()
	arg_3_0._drag:RemoveDragBeginListener()
	arg_3_0._drag:RemoveDragEndListener()
	arg_3_0._touch:RemoveClickDownListener()
	arg_3_0._scrollStory:RemoveOnValueChanged()
	arg_3_0:removeEventCb(FeiLinShiDuoGameController.instance, FeiLinShiDuoEvent.SelectEpisode, arg_3_0.onSelectEpisode, arg_3_0)
	arg_3_0:removeEventCb(FeiLinShiDuoGameController.instance, FeiLinShiDuoEvent.NextEpisodePlayUnlockAnim, arg_3_0.playEpisodeUnlockAnim, arg_3_0)
	arg_3_0:removeEventCb(FeiLinShiDuoGameController.instance, FeiLinShiDuoEvent.SwitchBG, arg_3_0.switchBG, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0.onCloseViewFinish, arg_3_0)
end

function var_0_0._btnPlayBtnOnClick(arg_4_0)
	local var_4_0 = ActivityModel.instance:getActMO(arg_4_0.activityId)
	local var_4_1 = var_4_0 and var_4_0.config and var_4_0.config.storyId

	StoryController.instance:playStory(var_4_1)
end

function var_0_0._btnTaskOnClick(arg_5_0)
	local var_5_0 = {
		activityId = arg_5_0.activityId
	}

	FeiLinShiDuoGameController.instance:openTaskView(var_5_0)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._taskAnimator = arg_6_0._btnTask.gameObject:GetComponentInChildren(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(arg_6_0._goreddot, RedDotEnum.DotNode.V2a5_Act185Task, nil, arg_6_0.refreshReddot, arg_6_0)

	arg_6_0.activityId = VersionActivity2_5Enum.ActivityId.FeiLinShiDuo

	arg_6_0:initEpisodeItem()

	local var_6_0 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)

	arg_6_0._offsetX = (var_6_0 - -300) / 2
	arg_6_0.minContentAnchorX = -4760 + var_6_0
	arg_6_0._bgWidth = recthelper.getWidth(arg_6_0._simageFullBG1.transform)
	arg_6_0._minBgPositionX = BootNativeUtil.getDisplayResolution() - arg_6_0._bgWidth
	arg_6_0._maxBgPositionX = 0
	arg_6_0._bgPositonMaxOffsetX = math.abs(arg_6_0._maxBgPositionX - arg_6_0._minBgPositionX)
	arg_6_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_6_0._gostoryPath)
	arg_6_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_6_0._gostoryPath)
	arg_6_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_6_0._gostoryPath, DungeonMapEpisodeAudio, arg_6_0._scrollStory)
end

function var_0_0.initEpisodeItem(arg_7_0)
	arg_7_0.episodeItemList = arg_7_0:getUserDataTb_()

	local var_7_0 = arg_7_0._gostoryStages.transform

	arg_7_0.stageCount = var_7_0.childCount

	for iter_7_0 = 1, arg_7_0.stageCount do
		local var_7_1 = var_7_0:GetChild(iter_7_0 - 1)
		local var_7_2 = string.format("item_%s", iter_7_0)
		local var_7_3 = arg_7_0:getResInst(arg_7_0.viewContainer._viewSetting.otherRes[1], var_7_1.gameObject, var_7_2)
		local var_7_4 = MonoHelper.addLuaComOnceToGo(var_7_3, FeiLinShiDuoEpisodeItem)

		var_7_4:onInit(var_7_3)
		table.insert(arg_7_0.episodeItemList, var_7_4)
	end
end

function var_0_0._onDragBegin(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEnd(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._audioScroll:onDragEnd()
end

function var_0_0._onScrollValueChanged(arg_10_0)
	return
end

function var_0_0._onClickDown(arg_11_0)
	arg_11_0._audioScroll:onClickDown()
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:refreshTime()
	arg_12_0:refreshUI()
	TaskDispatcher.runRepeat(arg_12_0.refreshTime, arg_12_0, TimeUtil.OneMinuteSecond)

	local var_12_0 = arg_12_0:getCurEpisodeIndex()

	arg_12_0:focusEpisodeItem(var_12_0, arg_12_0.curEpisodeId, false, false)
end

function var_0_0.getCurEpisodeIndex(arg_13_0)
	local var_13_0 = FeiLinShiDuoConfig.instance:getEpisodeConfig(arg_13_0.activityId, arg_13_0.curEpisodeId)
	local var_13_1 = var_13_0.mapId > 0 and var_13_0.preEpisodeId or var_13_0.episodeId

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.episodeItemList) do
		if iter_13_1.episodeId == var_13_1 then
			return iter_13_0
		end
	end

	return 1
end

function var_0_0.refreshUI(arg_14_0)
	arg_14_0:refreshTaskInfo()
	arg_14_0:refreshEpisode()
	arg_14_0:refreshEpisodeItem()
end

function var_0_0.refreshTaskInfo(arg_15_0)
	FeiLinShiDuoTaskListModel.instance:init(arg_15_0.activityId)
end

function var_0_0.refreshEpisode(arg_16_0)
	arg_16_0.curEpisodeId = FeiLinShiDuoModel.instance:getCurEpisodeId()

	local var_16_0 = FeiLinShiDuoModel.instance:getFinishStageIndex()

	if var_16_0 == 0 then
		gohelper.setActive(arg_16_0._goPath, false)
	else
		gohelper.setActive(arg_16_0._goPath, true)

		arg_16_0._animPath.speed = 1

		arg_16_0._animPath:Play("go" .. var_16_0, 0, 1)
	end

	if var_16_0 < arg_16_0.stageCount then
		if var_16_0 + 1 == arg_16_0.stageCount then
			local var_16_1 = FeiLinShiDuoConfig.instance:getStageEpisodes(arg_16_0.stageCount)

			for iter_16_0, iter_16_1 in pairs(var_16_1) do
				if not FeiLinShiDuoModel.instance.episodeFinishMap[iter_16_1.episodeId] and iter_16_1.storyId > 0 then
					arg_16_0._simageFullBG:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg" .. arg_16_0.stageCount - 1))
					arg_16_0._simageFullBG1:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg" .. arg_16_0.stageCount))

					break
				else
					arg_16_0._simageFullBG:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg" .. arg_16_0.stageCount))
					arg_16_0._simageFullBG1:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg0"))

					break
				end
			end
		else
			arg_16_0._simageFullBG:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg" .. var_16_0))
			arg_16_0._simageFullBG1:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg" .. var_16_0 + 1))
		end
	else
		arg_16_0._simageFullBG:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg" .. arg_16_0.stageCount))
		arg_16_0._simageFullBG1:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg0"))
	end
end

function var_0_0.isAllEpisodeFinish(arg_17_0)
	local var_17_0 = FeiLinShiDuoConfig.instance:getEpisodeConfigList()

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		if not FeiLinShiDuoModel.instance.episodeFinishMap[iter_17_1.episodeId] then
			return false
		end
	end

	return true
end

function var_0_0.refreshEpisodeItem(arg_18_0)
	local var_18_0 = FeiLinShiDuoConfig.instance:getNoGameEpisodeList(arg_18_0.activityId)

	if #var_18_0 > #arg_18_0.episodeItemList then
		logError("配置关卡数量不匹配，请检查")

		return
	end

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.episodeItemList) do
		if iter_18_0 > #var_18_0 then
			iter_18_1:isShowItem(false)
		else
			local var_18_1 = var_18_0[iter_18_0]

			iter_18_1:setInfo(iter_18_0, var_18_1)
		end
	end
end

function var_0_0.onSelectEpisode(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_0.curEpisodeId = arg_19_2

	arg_19_0:focusEpisodeItem(arg_19_1, arg_19_2, arg_19_3, true)
end

function var_0_0.focusEpisodeItem(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	local var_20_0 = arg_20_0.episodeItemList[arg_20_1]
	local var_20_1 = recthelper.getAnchorX(var_20_0._go.transform.parent)
	local var_20_2 = arg_20_0._offsetX - var_20_1

	if var_20_2 > 0 then
		var_20_2 = 0
	elseif var_20_2 < arg_20_0.minContentAnchorX then
		var_20_2 = arg_20_0.minContentAnchorX
	end

	if arg_20_4 then
		if arg_20_5 then
			ZProj.TweenHelper.DOAnchorPosX(arg_20_0._gostoryScroll.transform, var_20_2, 0.26)
		else
			ZProj.TweenHelper.DOAnchorPosX(arg_20_0._gostoryScroll.transform, var_20_2, 0.26, arg_20_0.onFocusEnd, arg_20_0, {
				arg_20_2,
				arg_20_3
			})
		end
	else
		ZProj.TweenHelper.DOAnchorPosX(arg_20_0._gostoryScroll.transform, var_20_2, 0)
	end
end

function var_0_0.onFocusEnd(arg_21_0, arg_21_1)
	arg_21_0.curEpisodeId = arg_21_1[1]
	arg_21_0.isGame = arg_21_1[2]

	if arg_21_0.isGame then
		local var_21_0 = FeiLinShiDuoConfig.instance:getGameEpisode(arg_21_0.curEpisodeId)

		if var_21_0 and var_21_0.mapId > 0 then
			local var_21_1 = {
				mapId = var_21_0.mapId,
				gameConfig = var_21_0
			}

			FeiLinShiDuoGameController.instance:openGameView(var_21_1)
		else
			logError(arg_21_0.curEpisodeId .. " 该关卡没有对应的游戏关卡")
		end
	else
		local var_21_2 = FeiLinShiDuoConfig.instance:getEpisodeConfig(arg_21_0.activityId, arg_21_0.curEpisodeId)
		local var_21_3 = var_21_2 and var_21_2.storyId

		if not var_21_3 then
			logError("剧情关卡没有配置剧情， 请检查：" .. arg_21_0.curEpisodeId)

			return
		end

		if FeiLinShiDuoModel.instance:getEpisodeFinishState(arg_21_0.curEpisodeId) then
			StoryController.instance:playStory(var_21_3)

			return
		end

		local var_21_4 = {}

		var_21_4.mark = true
		var_21_4.episodeId = arg_21_0.curEpisodeId

		StoryController.instance:playStory(var_21_3, var_21_4, arg_21_0.onStoryFinished, arg_21_0)
	end
end

function var_0_0.onStoryFinished(arg_22_0)
	FeiLinShiDuoGameController.instance:finishEpisode(arg_22_0.activityId, arg_22_0.curEpisodeId)
end

function var_0_0.onCloseViewFinish(arg_23_0, arg_23_1)
	if arg_23_1 == ViewName.FeiLinShiDuoResultView or arg_23_1 == ViewName.StoryFrontView then
		arg_23_0:onEpisodeFinish(arg_23_1)
	end
end

function var_0_0.onEpisodeFinish(arg_24_0, arg_24_1)
	if arg_24_1 == ViewName.StoryFrontView then
		FeiLinShiDuoStatHelper.instance:sendDungeonFinish()
	end

	local var_24_0 = FeiLinShiDuoModel.instance:getCurFinishEpisodeId()

	if var_24_0 and var_24_0 > 0 then
		FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.EpisodeItemPlayFinishAnim, var_24_0)
	end

	FeiLinShiDuoModel.instance:setCurFinishEpisodeId(0)
end

function var_0_0.playEpisodeUnlockAnim(arg_25_0, arg_25_1)
	arg_25_0.curEpisodeId = arg_25_1

	local var_25_0 = arg_25_0:getCurEpisodeIndex()

	arg_25_0:focusEpisodeItem(var_25_0, arg_25_0.curEpisodeId, false, true, true)
	arg_25_0:switchBG()
end

function var_0_0.switchBG(arg_26_0, arg_26_1)
	arg_26_0:refreshEpisode()

	if arg_26_1 then
		arg_26_0._animPlayer:Play("switch", arg_26_0.switchBGFinish, arg_26_0)
	end
end

function var_0_0.switchBGFinish(arg_27_0)
	return
end

function var_0_0.refreshReddot(arg_28_0, arg_28_1)
	arg_28_1:defaultRefreshDot()

	local var_28_0 = arg_28_1.show

	arg_28_0._taskAnimator:Play(var_28_0 and "loop" or "idle")
end

function var_0_0.refreshTime(arg_29_0)
	local var_29_0 = ActivityModel.instance:getActivityInfo()[arg_29_0.activityId]

	if var_29_0 then
		local var_29_1 = var_29_0:getRealEndTimeStamp() - ServerTime.now()

		if var_29_1 > 0 then
			local var_29_2 = TimeUtil.SecondToActivityTimeFormat(var_29_1)

			arg_29_0._txtlimittime.text = var_29_2

			return
		end
	end

	TaskDispatcher.cancelTask(arg_29_0.refreshTime, arg_29_0)
end

function var_0_0.onClose(arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0.refreshTime, arg_30_0)
	FeiLinShiDuoModel.instance:setCurEpisodeId(0)
end

function var_0_0.onDestroyView(arg_31_0)
	arg_31_0._simageFullBG:UnLoadImage()
	arg_31_0._simageFullBG1:UnLoadImage()
	FeiLinShiDuoModel.instance:reInit()
end

return var_0_0
