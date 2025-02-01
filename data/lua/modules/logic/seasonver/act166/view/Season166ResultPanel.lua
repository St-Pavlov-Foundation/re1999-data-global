module("modules.logic.seasonver.act166.view.Season166ResultPanel", package.seeall)

slot0 = class("Season166ResultPanel", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg/#simage_mask")
	slot0._simagelight = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg/#simage_mask/#simage_light")
	slot0._goFinish = gohelper.findChild(slot0.viewGO, "#simage_fullbg/#go_Finish")
	slot0._imageBattleFinish = gohelper.findChildImage(slot0.viewGO, "#simage_fullbg/#go_Finish/#image_BattleFinish")
	slot0._imageBattleFinish2 = gohelper.findChildImage(slot0.viewGO, "#simage_fullbg/#go_Finish/#image_BattleFinish2")
	slot0._imageBattleFinish3 = gohelper.findChildImage(slot0.viewGO, "#simage_fullbg/#go_Finish/#image_BattleFinish3")
	slot0._imageBattleFinish4 = gohelper.findChildImage(slot0.viewGO, "#simage_fullbg/#go_Finish/#image_BattleFinish4")
	slot0._goBaseInfo = gohelper.findChild(slot0.viewGO, "#simage_fullbg/#go_BaseInfo")
	slot0._goStarRoot = gohelper.findChild(slot0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_StarRoot")
	slot0._imageStar1 = gohelper.findChildImage(slot0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_StarRoot/star1/#image_Star1")
	slot0._imageStar2 = gohelper.findChildImage(slot0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_StarRoot/star2/#image_Star2")
	slot0._imageStar3 = gohelper.findChildImage(slot0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_StarRoot/star3/#image_Star3")
	slot0._txtScore = gohelper.findChildText(slot0.viewGO, "#simage_fullbg/#go_BaseInfo/#txt_Score")
	slot0._simageAllFinish = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg/#go_BaseInfo/#simage_AllFinish")
	slot0._txtScore1 = gohelper.findChildText(slot0.viewGO, "#simage_fullbg/#go_BaseInfo/#simage_AllFinish/#txt_Score1")
	slot0._goTargetRoot = gohelper.findChild(slot0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot")
	slot0._goTarget1 = gohelper.findChild(slot0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot/#go_Target1")
	slot0._txtTarget1 = gohelper.findChildText(slot0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot/#go_Target1/#txt_Target1")
	slot0._txtIntegral1 = gohelper.findChildText(slot0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot/#go_Target1/#txt_Integral1")
	slot0._goTarget2 = gohelper.findChild(slot0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot/#go_Target2")
	slot0._txtTarget2 = gohelper.findChildText(slot0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot/#go_Target2/#txt_Target2")
	slot0._txtIntegral2 = gohelper.findChildText(slot0.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot/#go_Target2/#txt_Integral2")
	slot0._goTrainInfo = gohelper.findChild(slot0.viewGO, "#simage_fullbg/#go_TrainInfo")
	slot0._txtTrain = gohelper.findChildText(slot0.viewGO, "#simage_fullbg/#go_TrainInfo/#txt_Train")
	slot0._goEpisode1 = gohelper.findChild(slot0.viewGO, "#simage_fullbg/#go_TrainInfo/Episode/Episode1/#go_Episode1")
	slot0._goEpisode2 = gohelper.findChild(slot0.viewGO, "#simage_fullbg/#go_TrainInfo/Episode/Episode2/#go_Episode2")
	slot0._goEpisode3 = gohelper.findChild(slot0.viewGO, "#simage_fullbg/#go_TrainInfo/Episode/Episode3/#go_Episode3")
	slot0._goEpisode4 = gohelper.findChild(slot0.viewGO, "#simage_fullbg/#go_TrainInfo/Episode/Episode4/#go_Episode4")
	slot0._goEpisode5 = gohelper.findChild(slot0.viewGO, "#simage_fullbg/#go_TrainInfo/Episode/Episode5/#go_Episode5")
	slot0._goEpisode6 = gohelper.findChild(slot0.viewGO, "#simage_fullbg/#go_TrainInfo/Episode/Episode6/#go_Episode6")
	slot0._txtTip = gohelper.findChildText(slot0.viewGO, "#simage_fullbg/#txt_Tip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickModalMask(slot0)
	if slot0.closing then
		return
	end

	if slot0._isCanSkip then
		slot0.closing = true

		if slot0.episodeType == DungeonEnum.EpisodeType.Season166Base then
			slot0.anim:Play("close1")
		else
			slot0.anim:Play("close2")
		end

		TaskDispatcher.runDelay(slot0.closeAnimEnd, slot0, 0.17)
	end
end

function slot0.closeAnimEnd(slot0)
	ViewMgr.instance:openView(ViewName.Season166ResultView)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
end

function slot0.onOpen(slot0)
	slot0._isCanSkip = false
	slot0.result = Season166Model.instance:getFightResult()
	slot0.episodeType = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId).type

	slot0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_checkpoint_result)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._tweenScore, slot0)
	TaskDispatcher.cancelTask(slot0._onTweenFinish, slot0)
	TaskDispatcher.cancelTask(slot0.openAnimEnd, slot0)
	TaskDispatcher.cancelTask(slot0.closeAnimEnd, slot0)
end

function slot0.refreshUI(slot0)
	if slot0.episodeType == DungeonEnum.EpisodeType.Season166Base then
		gohelper.setActive(slot0._goTrainInfo, false)
		slot0:refreshBaseInfo()
		gohelper.setActive(slot0._goBaseInfo, true)
		slot0.anim:Play("open1")
	else
		gohelper.setActive(slot0._goBaseInfo, false)
		slot0:refreshTrainInfo()
		gohelper.setActive(slot0._goTrainInfo, true)
		slot0.anim:Play("open2")
	end

	TaskDispatcher.runDelay(slot0.openAnimEnd, slot0, 3)
end

function slot0.openAnimEnd(slot0)
	if slot0.episodeType == DungeonEnum.EpisodeType.Season166Base then
		if not string.nilorempty(slot0.result.targetInfo) then
			gohelper.setActive(slot0._goTargetRoot, true)
			TaskDispatcher.runDelay(slot0._tweenScore, slot0, 1)
		else
			slot0:_onTweenFinish()
		end
	else
		slot0:_onTweenFinish()
	end
end

function slot0.refreshBaseInfo(slot0)
	gohelper.setActive(slot0._imageBattleFinish, true)
	gohelper.setActive(slot0._imageBattleFinish2, true)
	gohelper.setActive(slot0._imageBattleFinish3, false)
	gohelper.setActive(slot0._imageBattleFinish4, false)

	slot0._txtScore.text = slot0.result.battleScore
	slot0._txtScore1.text = slot0.result.battleScore

	slot0:refreshStar()
	slot0:refreshTarget()
end

function slot0.refreshTrainInfo(slot0)
	gohelper.setActive(slot0._imageBattleFinish, false)
	gohelper.setActive(slot0._imageBattleFinish2, false)
	gohelper.setActive(slot0._imageBattleFinish3, true)
	gohelper.setActive(slot0._imageBattleFinish4, true)

	for slot5 = 1, 6 do
		if Season166Config.instance:getSeasonTrainCos(slot0.result.activityId)[slot5] then
			slot7 = nil

			if slot6.trainId == slot0.result.id then
				slot0._txtTrain.text = GameUtil.setFirstStrSize(slot6.name, 98)
				slot7 = true
			else
				slot7 = Season166Model.instance:isTrainPass(slot0.result.activityId, slot6.trainId)
			end

			gohelper.setActive(slot0["_goEpisode" .. slot5], slot7)
		end
	end
end

function slot0.refreshStar(slot0)
	if slot0.episodeType ~= DungeonEnum.EpisodeType.Season166Base then
		return
	end

	slot2 = Season166BaseSpotModel.instance:getScoreLevelCfg(slot0.result.activityId, slot0.result.id, slot0.result.totalScore) and slot1.star or 0

	for slot6 = 1, 3 do
		slot7 = "_imageStar" .. slot6

		if slot1 and slot1.level == 4 then
			UISpriteSetMgr.instance:setSeason166Sprite(slot0[slot7], "season166_result_bulb3")
		end

		gohelper.setActive(slot0[slot7], slot6 <= slot2)
	end
end

function slot0.refreshTarget(slot0)
	if slot0.episodeType ~= DungeonEnum.EpisodeType.Season166Base then
		return
	end

	if not string.nilorempty(slot0.result.targetInfo) then
		gohelper.setActive(slot0._txtScore, #GameUtil.splitString2(slot0.result.targetInfo, true) < 2)
		gohelper.setActive(slot0._simageAllFinish, #slot1 == 2)

		for slot5 = 1, 2 do
			if slot1[slot5] then
				slot7 = slot6[1]
				slot8 = slot6[2]
				slot0["_txtTarget" .. slot5].text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("season166_resultpanel_target" .. slot7), slot8)
				slot0["_txtIntegral" .. slot5].text = "+" .. Season166Config.instance:getAdditionScoreByParam(Season166Config.instance:getSeasonBaseTargetCo(slot0.result.activityId, slot0.result.id, slot7), slot8)

				gohelper.setActive(slot0["_goTarget" .. slot5], true)
			else
				gohelper.setActive(slot0["_goTarget" .. slot5], false)
			end
		end
	end
end

function slot0._tweenScore(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_score)
	gohelper.setActive(slot0._goStarRoot, true)

	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot0.result.battleScore, slot0.result.totalScore, 1, slot0._onTweenUpdate, nil, slot0)

	TaskDispatcher.runDelay(slot0._onTweenFinish, slot0, 1)
end

function slot0._onTweenUpdate(slot0, slot1)
	if slot0._txtScore and slot0._txtScore1 then
		slot0._txtScore.text = Mathf.Ceil(slot1)
		slot0._txtScore1.text = Mathf.Ceil(slot1)
	end
end

function slot0._onTweenFinish(slot0)
	slot0._isCanSkip = true

	gohelper.setActive(slot0._txtTip, true)
end

return slot0
