module("modules.logic.seasonver.act166.view.Season166ResultPanel", package.seeall)

local var_0_0 = class("Season166ResultPanel", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg/#simage_mask")
	arg_1_0._simagelight = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg/#simage_mask/#simage_light")
	arg_1_0._goFinish = gohelper.findChild(arg_1_0.viewGO, "#simage_fullbg/#go_Finish")
	arg_1_0._imageBattleFinish = gohelper.findChildImage(arg_1_0.viewGO, "#simage_fullbg/#go_Finish/#image_BattleFinish")
	arg_1_0._imageBattleFinish2 = gohelper.findChildImage(arg_1_0.viewGO, "#simage_fullbg/#go_Finish/#image_BattleFinish2")
	arg_1_0._imageBattleFinish3 = gohelper.findChildImage(arg_1_0.viewGO, "#simage_fullbg/#go_Finish/#image_BattleFinish3")
	arg_1_0._imageBattleFinish4 = gohelper.findChildImage(arg_1_0.viewGO, "#simage_fullbg/#go_Finish/#image_BattleFinish4")
	arg_1_0._goBaseInfo = gohelper.findChild(arg_1_0.viewGO, "#simage_fullbg/#go_BaseInfo")
	arg_1_0._goStarRoot = gohelper.findChild(arg_1_0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_StarRoot")
	arg_1_0._imageStar1 = gohelper.findChildImage(arg_1_0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_StarRoot/star1/#image_Star1")
	arg_1_0._imageStar2 = gohelper.findChildImage(arg_1_0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_StarRoot/star2/#image_Star2")
	arg_1_0._imageStar3 = gohelper.findChildImage(arg_1_0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_StarRoot/star3/#image_Star3")
	arg_1_0._txtScore = gohelper.findChildText(arg_1_0.viewGO, "#simage_fullbg/#go_BaseInfo/#txt_Score")
	arg_1_0._simageAllFinish = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg/#go_BaseInfo/#simage_AllFinish")
	arg_1_0._txtScore1 = gohelper.findChildText(arg_1_0.viewGO, "#simage_fullbg/#go_BaseInfo/#simage_AllFinish/#txt_Score1")
	arg_1_0._goTargetRoot = gohelper.findChild(arg_1_0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot")
	arg_1_0._goTarget1 = gohelper.findChild(arg_1_0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot/#go_Target1")
	arg_1_0._txtTarget1 = gohelper.findChildText(arg_1_0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot/#go_Target1/#txt_Target1")
	arg_1_0._txtIntegral1 = gohelper.findChildText(arg_1_0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot/#go_Target1/#txt_Integral1")
	arg_1_0._goTarget2 = gohelper.findChild(arg_1_0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot/#go_Target2")
	arg_1_0._txtTarget2 = gohelper.findChildText(arg_1_0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot/#go_Target2/#txt_Target2")
	arg_1_0._txtIntegral2 = gohelper.findChildText(arg_1_0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot/#go_Target2/#txt_Integral2")
	arg_1_0._goTrainInfo = gohelper.findChild(arg_1_0.viewGO, "#simage_fullbg/#go_TrainInfo")
	arg_1_0._txtTrain = gohelper.findChildText(arg_1_0.viewGO, "#simage_fullbg/#go_TrainInfo/#txt_Train")
	arg_1_0._goEpisode1 = gohelper.findChild(arg_1_0.viewGO, "#simage_fullbg/#go_TrainInfo/Episode/Episode1/#go_Episode1")
	arg_1_0._goEpisode2 = gohelper.findChild(arg_1_0.viewGO, "#simage_fullbg/#go_TrainInfo/Episode/Episode2/#go_Episode2")
	arg_1_0._goEpisode3 = gohelper.findChild(arg_1_0.viewGO, "#simage_fullbg/#go_TrainInfo/Episode/Episode3/#go_Episode3")
	arg_1_0._goEpisode4 = gohelper.findChild(arg_1_0.viewGO, "#simage_fullbg/#go_TrainInfo/Episode/Episode4/#go_Episode4")
	arg_1_0._goEpisode5 = gohelper.findChild(arg_1_0.viewGO, "#simage_fullbg/#go_TrainInfo/Episode/Episode5/#go_Episode5")
	arg_1_0._goEpisode6 = gohelper.findChild(arg_1_0.viewGO, "#simage_fullbg/#go_TrainInfo/Episode/Episode6/#go_Episode6")
	arg_1_0._txtTip = gohelper.findChildText(arg_1_0.viewGO, "#simage_fullbg/#txt_Tip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onClickModalMask(arg_4_0)
	if arg_4_0.closing then
		return
	end

	if arg_4_0._isCanSkip then
		arg_4_0.closing = true

		if arg_4_0.episodeType == DungeonEnum.EpisodeType.Season166Base then
			arg_4_0.anim:Play("close1")
		else
			arg_4_0.anim:Play("close2")
		end

		TaskDispatcher.runDelay(arg_4_0.closeAnimEnd, arg_4_0, 0.17)
	end
end

function var_0_0.closeAnimEnd(arg_5_0)
	ViewMgr.instance:openView(ViewName.Season166ResultView)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.anim = arg_6_0.viewGO:GetComponent(gohelper.Type_Animator)
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._isCanSkip = false
	arg_7_0.result = Season166Model.instance:getFightResult()
	arg_7_0.episodeType = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId).type

	arg_7_0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_checkpoint_result)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._tweenScore, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._onTweenFinish, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.openAnimEnd, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.closeAnimEnd, arg_9_0)
end

function var_0_0.refreshUI(arg_10_0)
	if arg_10_0.episodeType == DungeonEnum.EpisodeType.Season166Base then
		gohelper.setActive(arg_10_0._goTrainInfo, false)
		arg_10_0:refreshBaseInfo()
		gohelper.setActive(arg_10_0._goBaseInfo, true)
		arg_10_0.anim:Play("open1")
	else
		gohelper.setActive(arg_10_0._goBaseInfo, false)
		arg_10_0:refreshTrainInfo()
		gohelper.setActive(arg_10_0._goTrainInfo, true)
		arg_10_0.anim:Play("open2")
	end

	TaskDispatcher.runDelay(arg_10_0.openAnimEnd, arg_10_0, 3)
end

function var_0_0.openAnimEnd(arg_11_0)
	if arg_11_0.episodeType == DungeonEnum.EpisodeType.Season166Base then
		if not string.nilorempty(arg_11_0.result.targetInfo) then
			gohelper.setActive(arg_11_0._goTargetRoot, true)
			TaskDispatcher.runDelay(arg_11_0._tweenScore, arg_11_0, 1)
		else
			arg_11_0:_onTweenFinish()
		end
	else
		arg_11_0:_onTweenFinish()
	end
end

function var_0_0.refreshBaseInfo(arg_12_0)
	gohelper.setActive(arg_12_0._imageBattleFinish, true)
	gohelper.setActive(arg_12_0._imageBattleFinish2, true)
	gohelper.setActive(arg_12_0._imageBattleFinish3, false)
	gohelper.setActive(arg_12_0._imageBattleFinish4, false)

	arg_12_0._txtScore.text = arg_12_0.result.battleScore
	arg_12_0._txtScore1.text = arg_12_0.result.battleScore

	arg_12_0:refreshStar()
	arg_12_0:refreshTarget()
end

function var_0_0.refreshTrainInfo(arg_13_0)
	gohelper.setActive(arg_13_0._imageBattleFinish, false)
	gohelper.setActive(arg_13_0._imageBattleFinish2, false)
	gohelper.setActive(arg_13_0._imageBattleFinish3, true)
	gohelper.setActive(arg_13_0._imageBattleFinish4, true)

	local var_13_0 = Season166Config.instance:getSeasonTrainCos(arg_13_0.result.activityId)

	for iter_13_0 = 1, 6 do
		local var_13_1 = var_13_0[iter_13_0]

		if var_13_1 then
			local var_13_2
			local var_13_3

			if var_13_1.trainId == arg_13_0.result.id then
				arg_13_0._txtTrain.text = GameUtil.setFirstStrSize(var_13_1.name, 98)
				var_13_3 = true
			else
				var_13_3 = Season166Model.instance:isTrainPass(arg_13_0.result.activityId, var_13_1.trainId)
			end

			gohelper.setActive(arg_13_0["_goEpisode" .. iter_13_0], var_13_3)
		end
	end
end

function var_0_0.refreshStar(arg_14_0)
	if arg_14_0.episodeType ~= DungeonEnum.EpisodeType.Season166Base then
		return
	end

	local var_14_0 = Season166BaseSpotModel.instance:getScoreLevelCfg(arg_14_0.result.activityId, arg_14_0.result.id, arg_14_0.result.totalScore)
	local var_14_1 = var_14_0 and var_14_0.star or 0

	for iter_14_0 = 1, 3 do
		local var_14_2 = "_imageStar" .. iter_14_0

		if var_14_0 and var_14_0.level == 4 then
			UISpriteSetMgr.instance:setSeason166Sprite(arg_14_0[var_14_2], "season166_result_bulb3")
		end

		gohelper.setActive(arg_14_0[var_14_2], iter_14_0 <= var_14_1)
	end
end

function var_0_0.refreshTarget(arg_15_0)
	if arg_15_0.episodeType ~= DungeonEnum.EpisodeType.Season166Base then
		return
	end

	if not string.nilorempty(arg_15_0.result.targetInfo) then
		local var_15_0 = GameUtil.splitString2(arg_15_0.result.targetInfo, true)

		gohelper.setActive(arg_15_0._txtScore, #var_15_0 < 2)
		gohelper.setActive(arg_15_0._simageAllFinish, #var_15_0 == 2)

		for iter_15_0 = 1, 2 do
			local var_15_1 = var_15_0[iter_15_0]

			if var_15_1 then
				local var_15_2 = var_15_1[1]
				local var_15_3 = var_15_1[2]
				local var_15_4 = Season166Config.instance:getSeasonBaseTargetCo(arg_15_0.result.activityId, arg_15_0.result.id, var_15_2)
				local var_15_5 = Season166Config.instance:getAdditionScoreByParam(var_15_4, var_15_3)
				local var_15_6 = luaLang("season166_resultpanel_target" .. var_15_2)
				local var_15_7 = GameUtil.getSubPlaceholderLuaLangOneParam(var_15_6, var_15_3)

				arg_15_0["_txtTarget" .. iter_15_0].text = var_15_7
				arg_15_0["_txtIntegral" .. iter_15_0].text = "+" .. var_15_5

				gohelper.setActive(arg_15_0["_goTarget" .. iter_15_0], true)
			else
				gohelper.setActive(arg_15_0["_goTarget" .. iter_15_0], false)
			end
		end
	end
end

function var_0_0._tweenScore(arg_16_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_score)
	gohelper.setActive(arg_16_0._goStarRoot, true)

	arg_16_0._tweenId = ZProj.TweenHelper.DOTweenFloat(arg_16_0.result.battleScore, arg_16_0.result.totalScore, 1, arg_16_0._onTweenUpdate, nil, arg_16_0)

	TaskDispatcher.runDelay(arg_16_0._onTweenFinish, arg_16_0, 1)
end

function var_0_0._onTweenUpdate(arg_17_0, arg_17_1)
	if arg_17_0._txtScore and arg_17_0._txtScore1 then
		arg_17_0._txtScore.text = Mathf.Ceil(arg_17_1)
		arg_17_0._txtScore1.text = Mathf.Ceil(arg_17_1)
	end
end

function var_0_0._onTweenFinish(arg_18_0)
	arg_18_0._isCanSkip = true

	gohelper.setActive(arg_18_0._txtTip, true)
end

return var_0_0
