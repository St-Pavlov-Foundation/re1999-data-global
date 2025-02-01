module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaMapViewStageItem", package.seeall)

slot0 = class("JiaLaBoNaMapViewStageItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._goRoot = gohelper.findChild(slot0.viewGO, "Root")
	slot0._imagePoint = gohelper.findChildImage(slot0.viewGO, "Root/#image_Point")
	slot0._imageStageFinishedBG = gohelper.findChildImage(slot0.viewGO, "Root/unlock/#image_StageFinishedBG")
	slot0._imageLine = gohelper.findChildImage(slot0.viewGO, "Root/unlock/#image_Line")
	slot0._imageAngle = gohelper.findChildImage(slot0.viewGO, "Root/unlock/#image_Angle")
	slot0._txtStageName = gohelper.findChildText(slot0.viewGO, "Root/unlock/Info/#txt_StageName")
	slot0._txtStageNum = gohelper.findChildText(slot0.viewGO, "Root/unlock/Info/#txt_StageName/#txt_StageNum")
	slot0._imageNoStar = gohelper.findChildImage(slot0.viewGO, "Root/unlock/Info/#txt_StageName/#image_NoStar")
	slot0._imageHasStar = gohelper.findChildImage(slot0.viewGO, "Root/unlock/Info/#txt_StageName/#image_HasStar")
	slot0._btnReview = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/unlock/Info/#txt_StageName/#btn_Review")
	slot0._btnClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/unlock/#btn_Click")
	slot0._imagechess = gohelper.findChildImage(slot0.viewGO, "Root/unlock/image_chess")
	slot0._goUnLock = gohelper.findChild(slot0.viewGO, "Root/unlock")
	slot0._animator = slot0.viewGO:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)

	gohelper.setActive(slot0._imagechess, false)

	slot0._chessAnimator = gohelper.findChild(slot0.viewGO, "Root/unlock/image_chess/ani"):GetComponent(JiaLaBoNaEnum.ComponentType.Animator)
end

function slot0.addEventListeners(slot0)
	slot0._btnClick:AddClickListener(slot0._btnClickOnClick, slot0)
	slot0._btnReview:AddClickListener(slot0._btnReviewOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	if slot0._btnClick then
		slot0._btnClick:RemoveClickListener()
		slot0._btnReview:RemoveClickListener()
	end
end

function slot0._btnClickOnClick(slot0)
	if slot0._config then
		JiaLaBoNaController.instance:enterChessGame(slot0._config.activityId, slot0._config.id, Activity120Model.instance:getCurEpisodeId() == slot0._config.id and 0.1 or 0.6)
		JiaLaBoNaController.instance:dispatchEvent(JiaLaBoNaEvent.SelectEpisode)
	end
end

function slot0._btnReviewOnClick(slot0)
	if slot0._config then
		JiaLaBoNaController.instance:openStoryView(slot0._config.id)
	end
end

function slot0.onUpdateMO(slot0, slot1)
end

function slot0.onSelect(slot0)
	if not slot0._config then
		return
	end

	if slot0._isLasetSelect == (slot0._config.id == Activity120Model.instance:getCurEpisodeId()) then
		return
	end

	if slot0._isLasetSelect == nil then
		slot0._isLasetSelect = slot2
		slot0._isLastSelectId = slot1

		gohelper.setActive(slot0._imagechess, slot2)
	else
		TaskDispatcher.cancelTask(slot0._playChessAnim, slot0)

		slot0._isLasetSelect = slot2

		if slot0._isLasetSelect then
			AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_role_move)
			TaskDispatcher.runDelay(slot0._playChessAnim, slot0, 0.15)
		else
			slot0:_playChessAnim()
		end
	end
end

function slot0._playChessAnim(slot0)
	if not slot0._config then
		return
	end

	slot1 = Activity120Model.instance:getCurEpisodeId()
	slot0._isLastSelectId = slot1
	slot3 = slot0:_getChessAnimName((slot0._isLastSelectId or slot0._config.id) < slot1)

	if slot0._isLasetSelect then
		gohelper.setActive(slot0._imagechess, true)
	end

	slot0._chessAnimator:Play(slot3)
	TaskDispatcher.cancelTask(slot0._onChessAnimEnd, slot0)
	TaskDispatcher.runDelay(slot0._onChessAnimEnd, slot0, 0.3)
end

function slot0._onChessAnimEnd(slot0)
	gohelper.setActive(slot0._imagechess, slot0._isLasetSelect)
end

function slot0._getChessAnimName(slot0, slot1)
	if slot0._isLasetSelect then
		return slot1 and "open_right" or "open_left"
	end

	return slot1 and "close_right" or "close_left"
end

function slot0.setStageType(slot0, slot1)
	slot0._stageType = slot1 or JiaLaBoNaEnum.StageType.Main
end

function slot0.setCfg(slot0, slot1)
	slot0._config = slot1
	slot0._isLock = true
end

function slot0.getCfgId(slot0)
	return slot0._config and slot0._config.id
end

function slot0.getCfgPreId(slot0)
	return slot0._config and slot0._config.preEpisode
end

function slot0.getCfgChapterId(slot0)
	return slot0._config and slot0._config.chapterId
end

function slot0.refreshUI(slot0, slot1)
	if not slot0._config then
		gohelper.setActive(slot0._goRoot, false)

		return
	end

	gohelper.setActive(slot0._goRoot, true)

	slot2 = false

	if Activity120Model.instance:isEpisodeClear(slot0._config.id) then
		slot0:_clearanceUI()

		if slot1 then
			slot0._animator:Play("finish", 0, 0)
		end
	elseif slot0._config.preEpisode == 0 or Activity120Model.instance:isEpisodeClear(slot0._config.preEpisode) and JiaLaBoNaHelper.isOpenDay(slot0._config.id) then
		slot0:_unLockUI()

		if slot1 then
			slot0._animator:Play("unlock", 0, 0)
		end
	else
		slot2 = true

		slot0:_lockUI()
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagePoint, slot2 and "#FFFFFF" or slot0:_getValueByType(JiaLaBoNaEnum.Stage.StageNameColor, slot0._stageType))

	slot0._txtStageName.text = slot0._config.name
	slot0._txtStageNum.text = slot0._config.orderId

	if slot0._lastStateType ~= slot0._stageType then
		slot0._lastStateType = slot0._stageType

		slot0:_stageTypeUI()
	end
end

function slot0._stageTypeUI(slot0)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtStageName, slot0:_getValueByType(JiaLaBoNaEnum.Stage.StageNameColor, slot0._stageType))

	slot2 = slot0:_getValueByType(JiaLaBoNaEnum.Stage.StageColor, slot0._stageType)

	SLFramework.UGUI.GuiHelper.SetColor(slot0._imageLine, slot2)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtStageNum, slot2)
end

function slot0._getValueByType(slot0, slot1, slot2)
	return slot1[slot2] or slot1[JiaLaBoNaEnum.StageType.Main]
end

function slot0._lockUI(slot0)
	gohelper.setActive(slot0._goUnLock, false)
	UISpriteSetMgr.instance:setJiaLaBoNaSprite(slot0._imagePoint, JiaLaBoNaEnum.StatgePiontSpriteName.UnFinished)
end

function slot0._unLockUI(slot0)
	gohelper.setActive(slot0._goUnLock, true)
	gohelper.setActive(slot0._imageStageFinishedBG, false)
	gohelper.setActive(slot0._btnReview, false)
	slot0:_startUI(false)
	UISpriteSetMgr.instance:setJiaLaBoNaSprite(slot0._imagePoint, JiaLaBoNaEnum.StatgePiontSpriteName.UnFinished)
end

function slot0._clearanceUI(slot0)
	gohelper.setActive(slot0._goUnLock, true)
	gohelper.setActive(slot0._imageStageFinishedBG, true)
	gohelper.setActive(slot0._btnReview, slot0:_isHasStory())
	slot0:_startUI(Activity120Model.instance:getEpisodeData(slot0._config.id) and slot1.star and slot1.star > 1)
	UISpriteSetMgr.instance:setJiaLaBoNaSprite(slot0._imagePoint, JiaLaBoNaEnum.StatgePiontSpriteName.Finished)
end

function slot0._startUI(slot0, slot1)
	gohelper.setActive(slot0._imageNoStar, not slot1)
	gohelper.setActive(slot0._imageHasStar, slot1)
end

function slot0._isHasStory(slot0)
	if slot0._config and Activity120Config.instance:getEpisodeStoryList(slot0._config.activityId, slot0._config.id) and #slot1 > 0 then
		return true
	end

	return false
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onChessAnimEnd, slot0)
	TaskDispatcher.cancelTask(slot0._playChessAnim, slot0)
	slot0:removeEventListeners()
	slot0:__onDispose()
end

slot0.prefabPath = "ui/viewres/versionactivity_1_3/v1a3_jialabona/v1a3_jialabonamapviewstageitem.prefab"

return slot0
