module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateMapStageItem", package.seeall)

local var_0_0 = class("EliminateMapStageItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagepoint = gohelper.findChildImage(arg_1_0.viewGO, "#image_point")
	arg_1_0._imagepointfinished = gohelper.findChildImage(arg_1_0.viewGO, "#image_pointfinished")
	arg_1_0._gostage = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stage")
	arg_1_0._gostagefinish = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stage/#go_stagefinish")
	arg_1_0._goGame = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stage/#go_Game")
	arg_1_0._goStageLine = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stage/#go_StageLine")
	arg_1_0._goStageLineFinished = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stage/#go_StageLineFinished")
	arg_1_0._imageline = gohelper.findChildImage(arg_1_0.viewGO, "unlock/#go_stage/#image_line")
	arg_1_0._imageangle = gohelper.findChildImage(arg_1_0.viewGO, "unlock/#go_stage/#image_angle")
	arg_1_0._imagelinefinish = gohelper.findChildImage(arg_1_0.viewGO, "unlock/#go_stage/#image_linefinish")
	arg_1_0._imageanglefinish = gohelper.findChildImage(arg_1_0.viewGO, "unlock/#go_stage/#image_anglefinish")
	arg_1_0._txtstagename = gohelper.findChildText(arg_1_0.viewGO, "unlock/#go_stage/info/#txt_stagename")
	arg_1_0._txtstageNum = gohelper.findChildText(arg_1_0.viewGO, "unlock/#go_stage/info/#txt_stagename/#txt_stageNum")
	arg_1_0._gostar = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star")
	arg_1_0._gostar1 = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star/#go_star1")
	arg_1_0._imageStar1 = gohelper.findChildImage(arg_1_0.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star/#go_star1/has/#image_Star1")
	arg_1_0._gostar2 = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star/#go_star2")
	arg_1_0._imageStar2 = gohelper.findChildImage(arg_1_0.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star/#go_star2/has/#image_Star2")
	arg_1_0._btnreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "unlock/#go_stage/info/#txt_stagename/#btn_review")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "unlock/#btn_click")
	arg_1_0._imagechess = gohelper.findChildImage(arg_1_0.viewGO, "unlock/#image_chess")
	arg_1_0._imageSign = gohelper.findChildImage(arg_1_0.viewGO, "#image_Sign")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreview:AddClickListener(arg_2_0._btnreviewOnClick, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreview:RemoveClickListener()
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnreviewOnClick(arg_4_0)
	local var_4_0 = arg_4_0._config.dialogueId

	if var_4_0 > 0 then
		DialogueController.instance:enterDialogue(var_4_0)
	end
end

function var_0_0._btnclickOnClick(arg_5_0)
	arg_5_0:_onClickEnterEpisode()
end

function var_0_0._onClickEnterEpisode(arg_6_0)
	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.ClickEpisode, arg_6_0._config)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._gostarNo1 = gohelper.findChild(arg_7_0.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star/#go_star1/no")
	arg_7_0._gostarNo2 = gohelper.findChild(arg_7_0.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star/#go_star2/no")
	arg_7_0._animator = arg_7_0.viewGO:GetComponent("Animator")
	arg_7_0._goUnlock = gohelper.findChild(arg_7_0.viewGO, "unlock")
	arg_7_0._chessAnimator = gohelper.findChild(arg_7_0.viewGO, "unlock/#image_chess/ani"):GetComponent("Animator")

	gohelper.setActive(arg_7_0._imageSign, false)
	gohelper.setActive(arg_7_0._imagepointfinished, false)
	gohelper.setActive(arg_7_0._imagechess, false)
	gohelper.setActive(arg_7_0._imagepoint, true)
	gohelper.setActive(arg_7_0._goGame, false)
end

function var_0_0.playAnim(arg_8_0, arg_8_1)
	arg_8_0._animator:Play(arg_8_1, 0, 0)
end

function var_0_0.playChessAnim(arg_9_0, arg_9_1)
	arg_9_0._chessAnimator:Play(arg_9_1, 0, 0)
end

function var_0_0._editableAddEvents(arg_10_0)
	return
end

function var_0_0._editableRemoveEvents(arg_11_0)
	return
end

function var_0_0.isBoss(arg_12_0)
	return arg_12_0._isBoss
end

function var_0_0.getChapterId(arg_13_0)
	return arg_13_0._config.chapterId
end

function var_0_0.setIndex(arg_14_0, arg_14_1)
	arg_14_0._index = arg_14_1
end

function var_0_0.onUpdateMO(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0._episodeMo = arg_15_1

	local var_15_0 = arg_15_0._episodeMo.star ~= 0

	arg_15_0._config = arg_15_0._episodeMo.config
	arg_15_0._isBoss = arg_15_0._config.levelPosition == EliminateLevelEnum.levelType.boss
	arg_15_0._isShowMainInfo = var_15_0 or arg_15_1 == arg_15_2

	arg_15_0:showMainInfo(arg_15_0._isShowMainInfo)
	gohelper.setActive(arg_15_0._btnreview, var_15_0 and arg_15_0._config.dialogueId > 0)

	local var_15_1

	if arg_15_0._isBoss then
		var_15_1 = var_15_0 and EliminateMapEnum.BossPassedColor or EliminateMapEnum.BossUnPassedColor
	else
		var_15_1 = var_15_0 and EliminateMapEnum.NormalPassedColor or EliminateMapEnum.NormalUnPassedColor
	end

	local var_15_2

	if arg_15_0._isBoss then
		var_15_2 = var_15_0 and EliminateMapEnum.TxtBossPassedColor or EliminateMapEnum.TxtBossUnPassedColor
	else
		var_15_2 = var_15_0 and EliminateMapEnum.TxtNormalPassedColor or EliminateMapEnum.TxtNormalUnPassedColor
	end

	arg_15_0._txtstagename.color = var_15_2
	arg_15_0._imagepoint.color = not arg_15_0._isShowMainInfo and EliminateMapEnum.TxtNormalUnPassedColor or var_15_1
	arg_15_0._imagepointfinished.color = var_15_1
	arg_15_0._imageline.color = var_15_1
	arg_15_0._imageangle.color = var_15_1
	arg_15_0._txtstagename.text = arg_15_0._config.name
	arg_15_0._txtstageNum.text = string.format("STAGE <color=#FFC67C>%s-%s</color>", arg_15_0._config.chapterId, arg_15_0._index)

	gohelper.setActive(arg_15_0._goStageLine, not var_15_0)
	gohelper.setActive(arg_15_0._gostagefinish, var_15_0)
	gohelper.setActive(arg_15_0._goStageLineFinished, var_15_0)
	gohelper.setActive(arg_15_0._imageline, not var_15_0)
	gohelper.setActive(arg_15_0._imageangle, not var_15_0)
	gohelper.setActive(arg_15_0._imagelinefinish, var_15_0)
	gohelper.setActive(arg_15_0._imageanglefinish, var_15_0)
	arg_15_0:_showStars()
end

function var_0_0.showMainInfo(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0._goUnlock, arg_16_1)
end

function var_0_0.showChess(arg_17_0, arg_17_1)
	gohelper.setActive(arg_17_0._imagechess, arg_17_1)
	gohelper.setActive(arg_17_0._imagepointfinished, arg_17_1)
	gohelper.setActive(arg_17_0._imageSign, arg_17_1)
	gohelper.setActive(arg_17_0._goGame, arg_17_1)
end

function var_0_0.showPointFinish(arg_18_0, arg_18_1)
	gohelper.setActive(arg_18_0._imagepointfinished, arg_18_1)
	gohelper.setActive(arg_18_0._goGame, arg_18_1)
end

function var_0_0.showSign(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._imageSign, arg_19_1)
end

function var_0_0._showStars(arg_20_0)
	local var_20_0 = arg_20_0._config.warChessId
	local var_20_1 = lua_war_chess_episode.configDict[var_20_0]
	local var_20_2 = not string.nilorempty(var_20_1.extraWinCondition) and 2 or 1

	for iter_20_0 = 1, 2 do
		local var_20_3 = arg_20_0["_gostar" .. iter_20_0]
		local var_20_4 = iter_20_0 <= var_20_2

		gohelper.setActive(var_20_3, var_20_4)

		if var_20_4 then
			local var_20_5 = arg_20_0["_imageStar" .. iter_20_0]
			local var_20_6 = iter_20_0 <= arg_20_0._episodeMo.star

			gohelper.setActive(var_20_5, var_20_6)

			local var_20_7 = arg_20_0["_gostarNo" .. iter_20_0]

			gohelper.setActive(var_20_7, not var_20_6)
		end
	end
end

function var_0_0.onSelect(arg_21_0, arg_21_1)
	return
end

function var_0_0.onDestroyView(arg_22_0)
	return
end

return var_0_0
