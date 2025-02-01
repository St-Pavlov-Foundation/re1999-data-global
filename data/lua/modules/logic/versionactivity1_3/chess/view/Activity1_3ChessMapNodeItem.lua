module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessMapNodeItem", package.seeall)

slot0 = class("Activity1_3ChessMapNodeItem", LuaCompBase)
slot0.prefabPath = "ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_mapviewstageitem.prefab"
slot1 = {
	open = 2,
	passIncompletly = 3,
	lock = 1,
	pass = 4
}
slot2 = "#E3C479"
slot3 = "#FFFFFF"

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._goRoot = gohelper.findChild(slot1, "Root")
	slot0._imagePoint = gohelper.findChildImage(slot1, "Root/#image_Point")
	slot0._imageStageFinishedBG = gohelper.findChildImage(slot1, "Root/unlock/#image_StageFinishedBG")
	slot0._txtStageName = gohelper.findChildText(slot1, "Root/unlock/Info/#txt_StageName")
	slot0._txtStageNum = gohelper.findChildText(slot1, "Root/unlock/Info/#txt_StageName/#txt_StageNum")
	slot0._imageNoStar = gohelper.findChildImage(slot1, "Root/unlock/Info/#txt_StageName/#image_NoStar")
	slot0._imageHasStar = gohelper.findChildImage(slot1, "Root/unlock/Info/#txt_StageName/#image_Star")
	slot0._btnClick = gohelper.findChildClick(slot1, "Root/unlock/#btn_Click")
	slot0._btnReview = gohelper.findChildButtonWithAudio(slot1, "Root/unlock/Info/#txt_StageName/#btn_Review")
	slot0._goUnLock = gohelper.findChild(slot1, "Root/unlock")
	slot0._goChess = gohelper.findChild(slot1, "Root/unlock/image_chess")
	slot3 = typeof(UnityEngine.Animator)
	slot0._nodeItemAnimator = slot1:GetComponent(slot3)
	slot0._chessAnimator = gohelper.findChild(slot1, "Root/unlock/image_chess/ani"):GetComponent(slot3)
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
	if not slot0._config then
		return
	end

	if not slot0._clickCallback then
		return
	end

	slot0._clickCallback(slot0._clickCbObj, slot0._config.id)
end

function slot0._btnReviewOnClick(slot0)
	if slot0._config then
		Activity1_3ChessController.instance:openStoryView(slot0._config.id)
	end
end

function slot0.onUpdateMO(slot0, slot1)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.setCfg(slot0, slot1)
	slot0._config = slot1
	slot0._isLock = true
end

function slot0.setClickCallback(slot0, slot1, slot2)
	slot0._clickCallback = slot1
	slot0._clickCbObj = slot2
end

function slot0._checkNodeItemState(slot0)
	if Activity122Model.instance:getEpisodeData(slot0._config.id) then
		if slot1.star == 2 then
			return uv0.pass
		elseif slot1.star == 1 then
			return uv0.passIncompletly
		else
			return uv0.open
		end
	end

	if slot0._config.preEpisode == 0 or Activity122Model.instance:isEpisodeClear(slot0._config.preEpisode) and Activity1_3ChessController.isOpenDay(slot0._config.id) then
		return uv0.open
	else
		return uv0.lock
	end
end

function slot0.refreshUI(slot0)
	if not slot0._config then
		gohelper.setActive(slot0._goRoot, false)

		return
	end

	gohelper.setActive(slot0._goRoot, true)
	slot0:_refreshNodeStateView(slot0:_checkNodeItemState())

	slot0._txtStageName.text = slot0._config.name
	slot0._txtStageNum.text = slot0._config.orderId

	slot0:_refreshChess()
end

function slot0._refreshNodeStateView(slot0, slot1)
	if slot0._nodeStateViewAction == nil then
		slot0._nodeStateViewAction = {
			[uv0.lock] = slot0._lockUI,
			[uv0.open] = slot0._unLockUI,
			[uv0.passIncompletly] = slot0._refreshPassIncompletlyView,
			[uv0.pass] = slot0._refreshPassView
		}
	end

	slot0._nodeStateViewAction[slot1](slot0)
	UISpriteSetMgr.instance:setActivity1_3ChessSprite(slot0._imagePoint, slot0:_getNodePointSprite(slot1))

	if slot1 == uv0.lock then
		return
	end

	slot2 = Activity122Model.instance:getPlayerCacheData()
	slot3 = slot1 == uv0.open and not slot2["isEpisodeUnlock_" .. slot0._config.id]

	if (slot1 == uv0.pass or slot1 == uv0.passIncompletly) and not slot2["isEpisodePass_" .. slot0._config.id] then
		Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.SetNodePathEffectToPassNode)
		slot0:delayPlayNodePassAni(0.8)
	end

	if slot3 then
		gohelper.setActive(slot0._goRoot, false)
		slot0:delayPlayNodeUnlockAni(1.5)
	end
end

function slot0._getNodePointSprite(slot0, slot1, slot2)
	if slot0._nodeState2SpriteMap == nil then
		slot0._nodeState2SpriteMap = {
			[uv0.lock] = JiaLaBoNaEnum.StatgePiontSpriteName.UnFinished,
			[uv0.open] = Activity1_3ChessEnum.SpriteName.NodeUnFinished,
			[uv0.passIncompletly] = Activity1_3ChessEnum.SpriteName.NodeFinished,
			[uv0.pass] = Activity1_3ChessEnum.SpriteName.NodeFinished
		}
	end

	slot3 = slot0._nodeState2SpriteMap[slot1]
	slot5 = slot0._config.id == Activity122Model.instance:getCurEpisodeId() or slot2

	if slot2 ~= nil then
		slot5 = slot2
	end

	if slot5 then
		slot3 = Activity1_3ChessEnum.SpriteName.NodeCurrent or slot3
	end

	return slot3
end

function slot0._refreshPassView(slot0)
	gohelper.setActive(slot0._goUnLock, true)
	gohelper.setActive(slot0._btnReview.gameObject, true)
	gohelper.setActive(slot0._imageStageFinishedBG, true)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagePoint, uv0)
	slot0:_refreshStarState(true)
end

function slot0._refreshPassIncompletlyView(slot0)
	gohelper.setActive(slot0._goUnLock, true)
	gohelper.setActive(slot0._imageStageFinishedBG, true)
	gohelper.setActive(slot0._btnReview.gameObject, true)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagePoint, uv0)
	slot0:_refreshStarState(false)
end

function slot0._lockUI(slot0)
	gohelper.setActive(slot0._goUnLock, false)
	gohelper.setActive(slot0._btnReview.gameObject, false)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagePoint, uv0)
end

function slot0._unLockUI(slot0)
	gohelper.setActive(slot0._goUnLock, true)
	gohelper.setActive(slot0._imageStageFinishedBG, false)
	gohelper.setActive(slot0._btnReview.gameObject, false)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagePoint, uv0)
	slot0:_refreshStarState(false)
end

function slot0._refreshStarState(slot0, slot1)
	gohelper.setActive(slot0._imageNoStar.gameObject, not slot1)
	gohelper.setActive(slot0._imageHasStar.gameObject, slot1)
end

function slot0._refreshChess(slot0)
	if Activity122Model.instance:getCurEpisodeId() == 0 then
		gohelper.setActive(slot0._goChess, slot0._config.id == 1)
	else
		gohelper.setActive(slot0._goChess, slot0._config.id == slot1)
	end
end

function slot0.delayPlayNodePassAni(slot0, slot1)
	slot0._nodeStateViewAction[uv0.open](slot0)
	TaskDispatcher.runDelay(slot0.playNodePassAni, slot0, slot1 or 0.5)
end

function slot0.delayPlayNodeUnlockAni(slot0, slot1)
	gohelper.setActive(slot0._goRoot, false)
	TaskDispatcher.runDelay(slot0.playNodeUnlockAni, slot0, slot1 or 0.5)
end

function slot0.playNodePassAni(slot0)
	Activity122Model.instance:getPlayerCacheData()["isEpisodePass_" .. slot0._config.id] = true

	Activity122Model.instance:saveCacheData()
	gohelper.setActive(slot0._imageStageFinishedBG.gameObject, true)
	slot0:_refreshStarState(slot0:_checkNodeItemState() == uv0.pass)
	slot0._nodeItemAnimator:Play("finish")
	Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.ShowPassEpisodeEffect)
	TaskDispatcher.runDelay(slot0.refreshUI, slot0, 0.8)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_jlbn_level_pass)
end

function slot0.playNodeUnlockAni(slot0)
	Activity122Model.instance:getPlayerCacheData()["isEpisodeUnlock_" .. slot0._config.id] = true

	Activity122Model.instance:saveCacheData()
	gohelper.setActive(slot0._goRoot, true)
	slot0._nodeItemAnimator:Play("unlock")
	AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.NewEpisodeUnlock)
end

function slot0.playAppearAni(slot0, slot1)
	gohelper.setActive(slot0._goChess, true)

	slot2 = Activity122Model.instance:getCurEpisodeId()

	slot0._chessAnimator:Play(slot1 < slot0._config.id and "open_right" or "open_left")
	UISpriteSetMgr.instance:setActivity1_3ChessSprite(slot0._imagePoint, slot0:_getNodePointSprite(slot0:_checkNodeItemState(), true))
end

function slot0.playDisAppearAni(slot0, slot1)
	gohelper.setActive(slot0._goChess, true)

	slot2 = Activity122Model.instance:getCurEpisodeId()

	slot0._chessAnimator:Play(slot0._config.id < slot1 and "close_right" or "close_left")
	UISpriteSetMgr.instance:setActivity1_3ChessSprite(slot0._imagePoint, slot0:_getNodePointSprite(slot0:_checkNodeItemState(), false))
end

function slot0.onDestroyView(slot0)
	slot0._clickCallback = nil
	slot0._clickCbObj = nil

	slot0:removeEventListeners()
	TaskDispatcher.cancelTask(slot0.playNodePassAni, slot0)
	TaskDispatcher.cancelTask(slot0.playNodeUnlockAni, slot0)
	TaskDispatcher.cancelTask(slot0.refreshUI, slot0)
end

return slot0
