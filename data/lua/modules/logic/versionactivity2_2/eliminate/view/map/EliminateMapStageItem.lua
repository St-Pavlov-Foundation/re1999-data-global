module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateMapStageItem", package.seeall)

slot0 = class("EliminateMapStageItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imagepoint = gohelper.findChildImage(slot0.viewGO, "#image_point")
	slot0._imagepointfinished = gohelper.findChildImage(slot0.viewGO, "#image_pointfinished")
	slot0._gostage = gohelper.findChild(slot0.viewGO, "unlock/#go_stage")
	slot0._gostagefinish = gohelper.findChild(slot0.viewGO, "unlock/#go_stage/#go_stagefinish")
	slot0._goGame = gohelper.findChild(slot0.viewGO, "unlock/#go_stage/#go_Game")
	slot0._goStageLine = gohelper.findChild(slot0.viewGO, "unlock/#go_stage/#go_StageLine")
	slot0._goStageLineFinished = gohelper.findChild(slot0.viewGO, "unlock/#go_stage/#go_StageLineFinished")
	slot0._imageline = gohelper.findChildImage(slot0.viewGO, "unlock/#go_stage/#image_line")
	slot0._imageangle = gohelper.findChildImage(slot0.viewGO, "unlock/#go_stage/#image_angle")
	slot0._imagelinefinish = gohelper.findChildImage(slot0.viewGO, "unlock/#go_stage/#image_linefinish")
	slot0._imageanglefinish = gohelper.findChildImage(slot0.viewGO, "unlock/#go_stage/#image_anglefinish")
	slot0._txtstagename = gohelper.findChildText(slot0.viewGO, "unlock/#go_stage/info/#txt_stagename")
	slot0._txtstageNum = gohelper.findChildText(slot0.viewGO, "unlock/#go_stage/info/#txt_stagename/#txt_stageNum")
	slot0._gostar = gohelper.findChild(slot0.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star")
	slot0._gostar1 = gohelper.findChild(slot0.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star/#go_star1")
	slot0._imageStar1 = gohelper.findChildImage(slot0.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star/#go_star1/has/#image_Star1")
	slot0._gostar2 = gohelper.findChild(slot0.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star/#go_star2")
	slot0._imageStar2 = gohelper.findChildImage(slot0.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star/#go_star2/has/#image_Star2")
	slot0._btnreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "unlock/#go_stage/info/#txt_stagename/#btn_review")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "unlock/#btn_click")
	slot0._imagechess = gohelper.findChildImage(slot0.viewGO, "unlock/#image_chess")
	slot0._imageSign = gohelper.findChildImage(slot0.viewGO, "#image_Sign")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreview:AddClickListener(slot0._btnreviewOnClick, slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreview:RemoveClickListener()
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnreviewOnClick(slot0)
	if slot0._config.dialogueId > 0 then
		DialogueController.instance:enterDialogue(slot1)
	end
end

function slot0._btnclickOnClick(slot0)
	slot0:_onClickEnterEpisode()
end

function slot0._onClickEnterEpisode(slot0)
	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.ClickEpisode, slot0._config)
end

function slot0._editableInitView(slot0)
	slot0._gostarNo1 = gohelper.findChild(slot0.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star/#go_star1/no")
	slot0._gostarNo2 = gohelper.findChild(slot0.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star/#go_star2/no")
	slot0._animator = slot0.viewGO:GetComponent("Animator")
	slot0._goUnlock = gohelper.findChild(slot0.viewGO, "unlock")
	slot0._chessAnimator = gohelper.findChild(slot0.viewGO, "unlock/#image_chess/ani"):GetComponent("Animator")

	gohelper.setActive(slot0._imageSign, false)
	gohelper.setActive(slot0._imagepointfinished, false)
	gohelper.setActive(slot0._imagechess, false)
	gohelper.setActive(slot0._imagepoint, true)
	gohelper.setActive(slot0._goGame, false)
end

function slot0.playAnim(slot0, slot1)
	slot0._animator:Play(slot1, 0, 0)
end

function slot0.playChessAnim(slot0, slot1)
	slot0._chessAnimator:Play(slot1, 0, 0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.isBoss(slot0)
	return slot0._isBoss
end

function slot0.getChapterId(slot0)
	return slot0._config.chapterId
end

function slot0.setIndex(slot0, slot1)
	slot0._index = slot1
end

function slot0.onUpdateMO(slot0, slot1, slot2)
	slot0._episodeMo = slot1
	slot3 = slot0._episodeMo.star ~= 0
	slot0._config = slot0._episodeMo.config
	slot0._isBoss = slot0._config.levelPosition == EliminateLevelEnum.levelType.boss
	slot0._isShowMainInfo = slot3 or slot1 == slot2

	slot0:showMainInfo(slot0._isShowMainInfo)
	gohelper.setActive(slot0._btnreview, slot3 and slot0._config.dialogueId > 0)

	slot4 = nil
	slot4 = slot0._isBoss and (slot3 and EliminateMapEnum.BossPassedColor or EliminateMapEnum.BossUnPassedColor) or slot3 and EliminateMapEnum.NormalPassedColor or EliminateMapEnum.NormalUnPassedColor
	slot5 = nil
	slot0._txtstagename.color = slot0._isBoss and (slot3 and EliminateMapEnum.TxtBossPassedColor or EliminateMapEnum.TxtBossUnPassedColor) or slot3 and EliminateMapEnum.TxtNormalPassedColor or EliminateMapEnum.TxtNormalUnPassedColor
	slot0._imagepoint.color = not slot0._isShowMainInfo and EliminateMapEnum.TxtNormalUnPassedColor or slot4
	slot0._imagepointfinished.color = slot4
	slot0._imageline.color = slot4
	slot0._imageangle.color = slot4
	slot0._txtstagename.text = slot0._config.name
	slot0._txtstageNum.text = string.format("STAGE <color=#FFC67C>%s-%s</color>", slot0._config.chapterId, slot0._index)

	gohelper.setActive(slot0._goStageLine, not slot3)
	gohelper.setActive(slot0._gostagefinish, slot3)
	gohelper.setActive(slot0._goStageLineFinished, slot3)
	gohelper.setActive(slot0._imageline, not slot3)
	gohelper.setActive(slot0._imageangle, not slot3)
	gohelper.setActive(slot0._imagelinefinish, slot3)
	gohelper.setActive(slot0._imageanglefinish, slot3)
	slot0:_showStars()
end

function slot0.showMainInfo(slot0, slot1)
	gohelper.setActive(slot0._goUnlock, slot1)
end

function slot0.showChess(slot0, slot1)
	gohelper.setActive(slot0._imagechess, slot1)
	gohelper.setActive(slot0._imagepointfinished, slot1)
	gohelper.setActive(slot0._imageSign, slot1)
	gohelper.setActive(slot0._goGame, slot1)
end

function slot0.showPointFinish(slot0, slot1)
	gohelper.setActive(slot0._imagepointfinished, slot1)
	gohelper.setActive(slot0._goGame, slot1)
end

function slot0.showSign(slot0, slot1)
	gohelper.setActive(slot0._imageSign, slot1)
end

function slot0._showStars(slot0)
	for slot8 = 1, 2 do
		slot10 = slot8 <= (not string.nilorempty(lua_war_chess_episode.configDict[slot0._config.warChessId].extraWinCondition) and 2 or 1)

		gohelper.setActive(slot0["_gostar" .. slot8], slot10)

		if slot10 then
			slot12 = slot8 <= slot0._episodeMo.star

			gohelper.setActive(slot0["_imageStar" .. slot8], slot12)
			gohelper.setActive(slot0["_gostarNo" .. slot8], not slot12)
		end
	end
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
