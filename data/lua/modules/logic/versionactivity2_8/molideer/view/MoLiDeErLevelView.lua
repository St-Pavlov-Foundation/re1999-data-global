module("modules.logic.versionactivity2_8.molideer.view.MoLiDeErLevelView", package.seeall)

local var_0_0 = class("MoLiDeErLevelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._gopath = gohelper.findChild(arg_1_0.viewGO, "#go_path")
	arg_1_0._goscrollcontent = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent")
	arg_1_0._gostages = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent/#go_stages")
	arg_1_0._gotitle = gohelper.findChild(arg_1_0.viewGO, "#go_title")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_title/#simage_title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "#go_title/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_task")
	arg_1_0._goreddotreward = gohelper.findChild(arg_1_0.viewGO, "#btn_task/#go_reddotreward")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")
	arg_1_0._goPathParent = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent/path/path_2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErController.instance, MoLiDeErEvent.OnFinishEpisode, arg_2_0.onEpisodeFinish, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErController.instance, MoLiDeErEvent.OnClickEpisodeItem, arg_2_0.onClickEpisodeItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0:removeEventCb(MoLiDeErController.instance, MoLiDeErEvent.OnFinishEpisode, arg_3_0.onEpisodeFinish, arg_3_0)
	arg_3_0:removeEventCb(MoLiDeErController.instance, MoLiDeErEvent.OnClickEpisodeItem, arg_3_0.onClickEpisodeItem, arg_3_0)
end

function var_0_0._btntaskOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.MoLiDeErTaskView)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._taskAnimator = arg_5_0._btntask.gameObject:GetComponentInChildren(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(arg_5_0._goreddotreward, RedDotEnum.DotNode.V2a8MoLiDeEr, nil, arg_5_0._refreshRedDot, arg_5_0)
	arg_5_0:_initLevelItem()

	arg_5_0._viewAnimator = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0._initLevelItem(arg_6_0)
	arg_6_0._levelItemList = {}

	local var_6_0 = arg_6_0._gostages.transform
	local var_6_1 = var_6_0.childCount

	for iter_6_0 = 1, var_6_1 do
		local var_6_2 = var_6_0:GetChild(iter_6_0 - 1)
		local var_6_3 = string.format("item_%s", iter_6_0)
		local var_6_4 = arg_6_0:getResInst(arg_6_0.viewContainer._viewSetting.otherRes[1], var_6_2.gameObject, var_6_3)
		local var_6_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_4, MoLiDeErLevelItem)

		table.insert(arg_6_0._levelItemList, var_6_5)
	end

	arg_6_0._pathAnimItemList = {}

	local var_6_6 = arg_6_0._goPathParent.transform
	local var_6_7 = var_6_6.childCount

	for iter_6_1 = 1, var_6_7 do
		local var_6_8 = var_6_6:GetChild(iter_6_1 - 1)
		local var_6_9 = var_6_8:GetComponent(typeof(UnityEngine.Animator))

		var_6_8.name = string.format("path_%s", iter_6_1 + 1)

		table.insert(arg_6_0._pathAnimItemList, var_6_9)
	end
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0.updateTime, arg_8_0, TimeUtil.OneMinuteSecond)

	arg_8_0._actId = MoLiDeErModel.instance:getCurActId()

	arg_8_0:updateTime()
	arg_8_0:refreshUI()

	local var_8_0 = arg_8_0.viewParam.episodeId

	if var_8_0 then
		arg_8_0:onClickEpisodeItem(0, var_8_0)
	end

	if arg_8_0:_checkFirstEnter() then
		arg_8_0._levelItemList[1]:setAnimState(MoLiDeErEnum.LevelState.Unlock, true)
		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_yuzhou_level_lit)
		arg_8_0:_lockScreen(true)
		TaskDispatcher.runDelay(arg_8_0._playFirstUnlock, arg_8_0, 0.8)
	end
end

function var_0_0.refreshUI(arg_9_0)
	local var_9_0 = MoLiDeErConfig.instance:getEpisodeListById(arg_9_0._actId)

	if #var_9_0 ~= #arg_9_0._levelItemList then
		logError("levelItem Count not match")

		return
	end

	local var_9_1 = 1
	local var_9_2
	local var_9_3 = arg_9_0._actId

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._levelItemList) do
		local var_9_4 = var_9_0[iter_9_0]
		local var_9_5 = var_9_4.preEpisodeId
		local var_9_6 = MoLiDeErModel.instance:isEpisodeFinish(var_9_3, var_9_5)
		local var_9_7 = MoLiDeErModel.instance:isEpisodeFinish(var_9_3, var_9_4.episodeId)
		local var_9_8 = var_9_5 == nil or var_9_5 == 0 or var_9_6

		iter_9_1:setActive(var_9_8)
		iter_9_1:setData(iter_9_0, var_9_4)

		if var_9_8 then
			iter_9_1:refreshUI(false)

			local var_9_9 = iter_9_0

			var_9_2 = var_9_4.episodeId
		end

		arg_9_0:setPathItemState(iter_9_0, var_9_7, false)
	end

	arg_9_0:_focusStoryItem(var_9_2)
end

function var_0_0._focusStoryItem(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._levelItemList) do
		local var_10_0 = iter_10_1.episodeId == arg_10_1

		iter_10_1:setFocus(var_10_0)
	end
end

function var_0_0.setPathItemState(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0._pathAnimItemList[arg_11_1]

	if var_11_0 then
		gohelper.setActive(var_11_0.gameObject, arg_11_2)

		if not arg_11_2 then
			return
		end

		local var_11_1 = arg_11_3 and MoLiDeErEnum.AnimName.LevelPathItemFinish or MoLiDeErEnum.AnimName.LevelPathItemFinished

		var_11_0:Play(var_11_1, 0)
	end
end

function var_0_0.onClickEpisodeItem(arg_12_0, arg_12_1, arg_12_2)
	MoLiDeErController.instance:enterEpisode(arg_12_0._actId, arg_12_2)
end

function var_0_0.onEpisodeFinish(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_1 ~= arg_13_0._actId then
		return
	end

	if not arg_13_3 then
		arg_13_0:_checkRedDot()
	end

	arg_13_0._finishEpisodeId = arg_13_2
	arg_13_0._isSkipGame = arg_13_3

	arg_13_0:_lockScreen(true)
	arg_13_0._viewAnimator:Play(MoLiDeErEnum.AnimName.LevelViewOpen)
	TaskDispatcher.runDelay(arg_13_0.onLevelOpenAnimTimeEnd, arg_13_0, MoLiDeErEnum.LevelAnimTime.LevelViewOpen)
	TaskDispatcher.runDelay(arg_13_0.forceEndBlock, arg_13_0, MoLiDeErEnum.LevelAnimTime.LevelForceEndBlock)
end

function var_0_0._checkRedDot(arg_14_0)
	logNormal("莫莉德尔角色活动 关卡完成 请求红点")
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.V2a8MoLiDeErTask
	})
end

function var_0_0.forceEndBlock(arg_15_0)
	logError("莫莉德尔角色活动 关卡解锁表现超时")
	arg_15_0:_lockScreen(false)
end

function var_0_0.onLevelOpenAnimTimeEnd(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.onLevelOpenAnimTimeEnd, arg_16_0)

	local var_16_0 = arg_16_0._finishEpisodeId
	local var_16_1

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._levelItemList) do
		if iter_16_1.episodeId == var_16_0 then
			var_16_1 = iter_16_1

			break
		end
	end

	if var_16_1 == nil then
		logError("莫莉德尔 角色活动 不存在对应关卡id的level item id:" .. tostring(var_16_0))

		return
	end

	if not MoLiDeErModel.instance:isEpisodeFinish(arg_16_0._actId, var_16_0, true) or arg_16_0._isSkipGame == true then
		logNormal("莫莉德尔 角色活动 非首次通关")

		if not arg_16_0._isSkipGame then
			var_16_1:setStarState(true)
		end

		arg_16_0:onLevelUnlockAnimTimeEnd()

		arg_16_0._isSkipGame = false

		return
	end

	var_16_1:refreshUI(true)
	AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_yuzhou_level_lit)

	local var_16_2 = var_16_1.index

	arg_16_0:setPathItemState(var_16_2, true, true)

	if var_16_2 < #arg_16_0._levelItemList then
		TaskDispatcher.runDelay(arg_16_0.onLevelFinishAnimTimeEnd, arg_16_0, MoLiDeErEnum.LevelAnimTime.LevelItemFinish)
	else
		arg_16_0:_focusStoryItem(var_16_1.episodeId)
		TaskDispatcher.runDelay(arg_16_0.onLevelUnlockAnimTimeEnd, arg_16_0, MoLiDeErEnum.LevelAnimTime.LevelItemFinish)
	end
end

function var_0_0.onLevelFinishAnimTimeEnd(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0.onLevelFinishAnimTimeEnd, arg_17_0)

	local var_17_0 = arg_17_0._finishEpisodeId
	local var_17_1

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._levelItemList) do
		if iter_17_1.preEpisodeId == var_17_0 then
			var_17_1 = iter_17_1

			break
		end
	end

	if var_17_1 == nil then
		logError("莫莉德尔 角色活动 不存在对应关卡id的level item id:" .. tostring(var_17_0))

		return
	end

	var_17_1:setActive(true)
	var_17_1:refreshUI(true)
	AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_fuleyuan_newlevels_unlock)
	arg_17_0:_focusStoryItem(var_17_1.episodeId)
	TaskDispatcher.runDelay(arg_17_0.onLevelUnlockAnimTimeEnd, arg_17_0, MoLiDeErEnum.LevelAnimTime.LevelItemUnlock)
end

function var_0_0.onLevelUnlockAnimTimeEnd(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.onLevelUnlockAnimTimeEnd, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.forceEndBlock, arg_18_0)

	arg_18_0._finishEpisodeId = nil

	arg_18_0:_lockScreen(false)
end

function var_0_0._playFirstUnlock(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._playFirstUnlock, arg_19_0)
	arg_19_0:_lockScreen(false)
end

function var_0_0.updateTime(arg_20_0)
	local var_20_0 = arg_20_0._actId
	local var_20_1 = ActivityModel.instance:getActivityInfo()[var_20_0]

	if var_20_1 then
		local var_20_2 = var_20_1:getRealEndTimeStamp() - ServerTime.now()

		if var_20_2 > 0 then
			if arg_20_0._txtLimitTime ~= nil then
				local var_20_3 = TimeUtil.SecondToActivityTimeFormat(var_20_2)

				arg_20_0._txtLimitTime.text = var_20_3
			end

			return
		end
	end

	TaskDispatcher.cancelTask(arg_20_0.updateTime, arg_20_0)
end

function var_0_0._refreshRedDot(arg_21_0, arg_21_1)
	arg_21_1:defaultRefreshDot()

	local var_21_0 = arg_21_1.show

	arg_21_0._taskAnimator:Play(var_21_0 and "loop" or "idle")
end

function var_0_0._lockScreen(arg_22_0, arg_22_1)
	if arg_22_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("MoLiDeErLevelView")
	else
		UIBlockMgr.instance:endBlock("MoLiDeErLevelView")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function var_0_0._checkFirstEnter(arg_23_0)
	local var_23_0 = arg_23_0._levelItemList[2]

	if var_23_0 and not MoLiDeErModel.instance:isEpisodeFinish(arg_23_0._actId, var_23_0.preEpisodeId) then
		local var_23_1 = string.format("ActMoLiDeErFirstEnter_%s", PlayerModel.instance:getMyUserId())

		if PlayerPrefsHelper.getNumber(var_23_1, 0) == 0 then
			PlayerPrefsHelper.setNumber(var_23_1, 1)

			return true
		end
	end

	return false
end

function var_0_0.onClose(arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0.updateTime, arg_24_0)
end

function var_0_0.onDestroyView(arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0.updateTime, arg_25_0)
end

return var_0_0
