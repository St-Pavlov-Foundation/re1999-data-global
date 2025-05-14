module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaMapViewStageItem", package.seeall)

local var_0_0 = class("JiaLaBoNaMapViewStageItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._goRoot = gohelper.findChild(arg_1_0.viewGO, "Root")
	arg_1_0._imagePoint = gohelper.findChildImage(arg_1_0.viewGO, "Root/#image_Point")
	arg_1_0._imageStageFinishedBG = gohelper.findChildImage(arg_1_0.viewGO, "Root/unlock/#image_StageFinishedBG")
	arg_1_0._imageLine = gohelper.findChildImage(arg_1_0.viewGO, "Root/unlock/#image_Line")
	arg_1_0._imageAngle = gohelper.findChildImage(arg_1_0.viewGO, "Root/unlock/#image_Angle")
	arg_1_0._txtStageName = gohelper.findChildText(arg_1_0.viewGO, "Root/unlock/Info/#txt_StageName")
	arg_1_0._txtStageNum = gohelper.findChildText(arg_1_0.viewGO, "Root/unlock/Info/#txt_StageName/#txt_StageNum")
	arg_1_0._imageNoStar = gohelper.findChildImage(arg_1_0.viewGO, "Root/unlock/Info/#txt_StageName/#image_NoStar")
	arg_1_0._imageHasStar = gohelper.findChildImage(arg_1_0.viewGO, "Root/unlock/Info/#txt_StageName/#image_HasStar")
	arg_1_0._btnReview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/unlock/Info/#txt_StageName/#btn_Review")
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/unlock/#btn_Click")
	arg_1_0._imagechess = gohelper.findChildImage(arg_1_0.viewGO, "Root/unlock/image_chess")
	arg_1_0._goUnLock = gohelper.findChild(arg_1_0.viewGO, "Root/unlock")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)

	gohelper.setActive(arg_1_0._imagechess, false)

	arg_1_0._chessAnimator = gohelper.findChild(arg_1_0.viewGO, "Root/unlock/image_chess/ani"):GetComponent(JiaLaBoNaEnum.ComponentType.Animator)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0._btnClickOnClick, arg_2_0)
	arg_2_0._btnReview:AddClickListener(arg_2_0._btnReviewOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	if arg_3_0._btnClick then
		arg_3_0._btnClick:RemoveClickListener()
		arg_3_0._btnReview:RemoveClickListener()
	end
end

function var_0_0._btnClickOnClick(arg_4_0)
	if arg_4_0._config then
		local var_4_0 = Activity120Model.instance:getCurEpisodeId() == arg_4_0._config.id

		JiaLaBoNaController.instance:enterChessGame(arg_4_0._config.activityId, arg_4_0._config.id, var_4_0 and 0.1 or 0.6)
		JiaLaBoNaController.instance:dispatchEvent(JiaLaBoNaEvent.SelectEpisode)
	end
end

function var_0_0._btnReviewOnClick(arg_5_0)
	if arg_5_0._config then
		JiaLaBoNaController.instance:openStoryView(arg_5_0._config.id)
	end
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	return
end

function var_0_0.onSelect(arg_7_0)
	if not arg_7_0._config then
		return
	end

	local var_7_0 = Activity120Model.instance:getCurEpisodeId()
	local var_7_1 = arg_7_0._config.id == var_7_0

	if arg_7_0._isLasetSelect == var_7_1 then
		return
	end

	if arg_7_0._isLasetSelect == nil then
		arg_7_0._isLasetSelect = var_7_1
		arg_7_0._isLastSelectId = var_7_0

		gohelper.setActive(arg_7_0._imagechess, var_7_1)
	else
		TaskDispatcher.cancelTask(arg_7_0._playChessAnim, arg_7_0)

		arg_7_0._isLasetSelect = var_7_1

		if arg_7_0._isLasetSelect then
			AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_role_move)
			TaskDispatcher.runDelay(arg_7_0._playChessAnim, arg_7_0, 0.15)
		else
			arg_7_0:_playChessAnim()
		end
	end
end

function var_0_0._playChessAnim(arg_8_0)
	if not arg_8_0._config then
		return
	end

	local var_8_0 = Activity120Model.instance:getCurEpisodeId()
	local var_8_1 = arg_8_0._isLastSelectId or arg_8_0._config.id

	arg_8_0._isLastSelectId = var_8_0

	local var_8_2 = arg_8_0:_getChessAnimName(var_8_1 < var_8_0)

	if arg_8_0._isLasetSelect then
		gohelper.setActive(arg_8_0._imagechess, true)
	end

	arg_8_0._chessAnimator:Play(var_8_2)
	TaskDispatcher.cancelTask(arg_8_0._onChessAnimEnd, arg_8_0)
	TaskDispatcher.runDelay(arg_8_0._onChessAnimEnd, arg_8_0, 0.3)
end

function var_0_0._onChessAnimEnd(arg_9_0)
	gohelper.setActive(arg_9_0._imagechess, arg_9_0._isLasetSelect)
end

function var_0_0._getChessAnimName(arg_10_0, arg_10_1)
	if arg_10_0._isLasetSelect then
		return arg_10_1 and "open_right" or "open_left"
	end

	return arg_10_1 and "close_right" or "close_left"
end

function var_0_0.setStageType(arg_11_0, arg_11_1)
	arg_11_0._stageType = arg_11_1 or JiaLaBoNaEnum.StageType.Main
end

function var_0_0.setCfg(arg_12_0, arg_12_1)
	arg_12_0._config = arg_12_1
	arg_12_0._isLock = true
end

function var_0_0.getCfgId(arg_13_0)
	return arg_13_0._config and arg_13_0._config.id
end

function var_0_0.getCfgPreId(arg_14_0)
	return arg_14_0._config and arg_14_0._config.preEpisode
end

function var_0_0.getCfgChapterId(arg_15_0)
	return arg_15_0._config and arg_15_0._config.chapterId
end

function var_0_0.refreshUI(arg_16_0, arg_16_1)
	if not arg_16_0._config then
		gohelper.setActive(arg_16_0._goRoot, false)

		return
	end

	gohelper.setActive(arg_16_0._goRoot, true)

	local var_16_0 = false

	if Activity120Model.instance:isEpisodeClear(arg_16_0._config.id) then
		arg_16_0:_clearanceUI()

		if arg_16_1 then
			arg_16_0._animator:Play("finish", 0, 0)
		end
	elseif arg_16_0._config.preEpisode == 0 or Activity120Model.instance:isEpisodeClear(arg_16_0._config.preEpisode) and JiaLaBoNaHelper.isOpenDay(arg_16_0._config.id) then
		arg_16_0:_unLockUI()

		if arg_16_1 then
			arg_16_0._animator:Play("unlock", 0, 0)
		end
	else
		var_16_0 = true

		arg_16_0:_lockUI()
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._imagePoint, var_16_0 and "#FFFFFF" or arg_16_0:_getValueByType(JiaLaBoNaEnum.Stage.StageNameColor, arg_16_0._stageType))

	arg_16_0._txtStageName.text = arg_16_0._config.name
	arg_16_0._txtStageNum.text = arg_16_0._config.orderId

	if arg_16_0._lastStateType ~= arg_16_0._stageType then
		arg_16_0._lastStateType = arg_16_0._stageType

		arg_16_0:_stageTypeUI()
	end
end

function var_0_0._stageTypeUI(arg_17_0)
	local var_17_0 = arg_17_0:_getValueByType(JiaLaBoNaEnum.Stage.StageNameColor, arg_17_0._stageType)

	SLFramework.UGUI.GuiHelper.SetColor(arg_17_0._txtStageName, var_17_0)

	local var_17_1 = arg_17_0:_getValueByType(JiaLaBoNaEnum.Stage.StageColor, arg_17_0._stageType)

	SLFramework.UGUI.GuiHelper.SetColor(arg_17_0._imageLine, var_17_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_17_0._txtStageNum, var_17_1)
end

function var_0_0._getValueByType(arg_18_0, arg_18_1, arg_18_2)
	return arg_18_1[arg_18_2] or arg_18_1[JiaLaBoNaEnum.StageType.Main]
end

function var_0_0._lockUI(arg_19_0)
	gohelper.setActive(arg_19_0._goUnLock, false)
	UISpriteSetMgr.instance:setJiaLaBoNaSprite(arg_19_0._imagePoint, JiaLaBoNaEnum.StatgePiontSpriteName.UnFinished)
end

function var_0_0._unLockUI(arg_20_0)
	gohelper.setActive(arg_20_0._goUnLock, true)
	gohelper.setActive(arg_20_0._imageStageFinishedBG, false)
	gohelper.setActive(arg_20_0._btnReview, false)
	arg_20_0:_startUI(false)
	UISpriteSetMgr.instance:setJiaLaBoNaSprite(arg_20_0._imagePoint, JiaLaBoNaEnum.StatgePiontSpriteName.UnFinished)
end

function var_0_0._clearanceUI(arg_21_0)
	gohelper.setActive(arg_21_0._goUnLock, true)
	gohelper.setActive(arg_21_0._imageStageFinishedBG, true)
	gohelper.setActive(arg_21_0._btnReview, arg_21_0:_isHasStory())

	local var_21_0 = Activity120Model.instance:getEpisodeData(arg_21_0._config.id)

	arg_21_0:_startUI(var_21_0 and var_21_0.star and var_21_0.star > 1)
	UISpriteSetMgr.instance:setJiaLaBoNaSprite(arg_21_0._imagePoint, JiaLaBoNaEnum.StatgePiontSpriteName.Finished)
end

function var_0_0._startUI(arg_22_0, arg_22_1)
	gohelper.setActive(arg_22_0._imageNoStar, not arg_22_1)
	gohelper.setActive(arg_22_0._imageHasStar, arg_22_1)
end

function var_0_0._isHasStory(arg_23_0)
	if arg_23_0._config then
		local var_23_0 = Activity120Config.instance:getEpisodeStoryList(arg_23_0._config.activityId, arg_23_0._config.id)

		if var_23_0 and #var_23_0 > 0 then
			return true
		end
	end

	return false
end

function var_0_0.onDestroyView(arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._onChessAnimEnd, arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._playChessAnim, arg_24_0)
	arg_24_0:removeEventListeners()
	arg_24_0:__onDispose()
end

var_0_0.prefabPath = "ui/viewres/versionactivity_1_3/v1a3_jialabona/v1a3_jialabonamapviewstageitem.prefab"

return var_0_0
