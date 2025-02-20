module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateMapView", package.seeall)

slot0 = class("EliminateMapView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "map/#simage_bg")
	slot0._simagebottom = gohelper.findChildSingleImage(slot0.viewGO, "window/bottom/#simage_bottom")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot0.MapMaxOffsetX = 150
slot0.AnimationDuration = 1

function slot0._editableInitView(slot0)
	slot4 = 0.05
	slot0._vec4 = Vector4(0, slot4, 0, 0)
	slot0.goChapterNodeList = {}
	slot0.nodeItemDict = {}

	for slot4 = 1, EliminateMapModel.getChapterNum() do
		table.insert(slot0.goChapterNodeList, gohelper.findChild(slot0.viewGO, "map/chapter" .. slot4))
	end

	slot0:addEventCb(EliminateMapController.instance, EliminateMapEvent.OnSelectChapterChange, slot0.onSelectChapterChange, slot0)
	slot0:addEventCb(EliminateMapController.instance, EliminateMapEvent.UnlockChapterAnimDone, slot0._onUnlockChapterAnimDone, slot0)
	slot0:addEventCb(EliminateMapController.instance, EliminateMapEvent.OnUpdateEpisodeInfo, slot0.onUpdateEpisodeInfo, slot0)
	slot0:addEventCb(EliminateMapController.instance, EliminateMapEvent.ClickEpisode, slot0._onClickEpisode, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenSizeChange, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)

	slot0.animator = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "map/bg_eff_normal")
	slot0._gospecial = gohelper.findChild(slot0.viewGO, "map/bg_eff_special")
end

slot1 = "EliminateMapViewBlock"

function slot0._startBlock(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._endBlock, slot0)
	TaskDispatcher.runDelay(slot0._endBlock, slot0, slot1 + 0.1)
	UIBlockMgr.instance:startBlock(uv0)
end

function slot0._endBlock(slot0)
	UIBlockMgr.instance:endBlock(uv0)
end

function slot0.selectedNodeItem(slot0, slot1)
	slot1:showChess(true)

	slot0._curSelectedNodeItem = slot1
	slot2 = slot1:isBoss()

	gohelper.setActive(slot0._gonormal, not slot2)
	gohelper.setActive(slot0._gospecial, slot2)
end

function slot0.onOpen(slot0)
	slot0.chapterId = slot0.viewContainer.chapterId
	slot0.lastCanFightEpisodeMo = EliminateMapModel.instance:getLastCanFightEpisodeMo(slot0.chapterId)

	slot0:refreshUI()
	slot0:refreshPath()
end

function slot0.initMat(slot0)
	slot0.mat = gohelper.findChild(slot0.goChapterNodeList[slot0.chapterId], "lujinganim/luxian_light"):GetComponent(typeof(UnityEngine.UI.Graphic)).material
end

function slot0.refreshUI(slot0)
	slot0:refreshBg()
	slot0:refreshNode()
end

function slot0.refreshBg(slot0)
	slot5 = lua_eliminate_chapter.configDict[slot0.chapterId].map

	slot0._simagebg:LoadImage(slot5)

	for slot5 = 1, EliminateMapModel.getChapterNum() do
		gohelper.setActive(slot0.goChapterNodeList[slot5], slot5 == slot0.chapterId)
	end

	slot0:initMat()
end

function slot0.refreshNode(slot0)
	for slot5, slot6 in ipairs(EliminateMapModel.instance:getEpisodeList(slot0.chapterId)) do
		if not slot0.nodeItemDict[slot6.id] then
			slot7 = slot0:createNodeItem(slot6)
			slot0.nodeItemDict[slot6.id] = slot7

			slot7:setIndex(slot5)
		end

		slot7:onUpdateMO(slot6, slot0.lastCanFightEpisodeMo)

		if slot7 ~= slot0._curSelectedNodeItem then
			slot7:showChess(false)
		end
	end

	if slot0._curSelectedNodeItem then
		slot0:selectedNodeItem(slot0._curSelectedNodeItem)
	end
end

function slot0.createNodeItem(slot0, slot1)
	slot2 = gohelper.findChild(slot0.goChapterNodeList[slot0.chapterId], "node" .. slot1.config.posIndex)
	slot5 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot1.config.levelPosition == EliminateLevelEnum.levelType.boss and slot0.viewContainer:getSetting().otherRes[3] or slot0.viewContainer:getSetting().otherRes[2], slot2, slot1.config.posIndex), EliminateMapStageItem)
	slot5.parentTrans = slot2.transform

	return slot5
end

function slot0.refreshPath(slot0)
	slot1 = slot0.lastCanFightEpisodeMo.config

	if slot0:checkNeedPlayAnimation() and slot0._isUpdateEpisodeInfo then
		if slot0.nodeItemDict[slot1.id] then
			slot2:showMainInfo(false)
		end

		slot0._targetItem = slot2
		slot4 = EliminateMapModel.instance:getEpisodeConfig(slot1.preEpisode) and slot3.aniPos or 0

		if slot0.nodeItemDict[slot3.id] then
			slot0:selectedNodeItem(slot5)
			slot5:playAnim("finish")
		end

		slot0._srcItem = slot5

		slot0:setMatValue(slot4)
		TaskDispatcher.runDelay(slot0.startPathAnimation, slot0, EliminateMapEnum.MapViewOpenAnimLength)
		slot0:_startBlock(EliminateMapEnum.MapViewOpenAnimLength)

		return
	end

	slot0:setMatValue(slot1 and slot1.aniPos or 0)

	if not slot0._curSelectedNodeItem then
		slot0:selectedNodeItem(slot0.nodeItemDict[slot0.lastCanFightEpisodeMo.id])
	end

	if slot0._changeEpisodeAnimDone then
		slot0._changeEpisodeAnimDone = false
		slot3 = slot0.nodeItemDict[slot0.lastCanFightEpisodeMo.id]

		slot0:selectedNodeItem(slot3)
		slot3:playChessAnim("open_right")
	end

	if slot0._isUpdateEpisodeInfo or slot0._updateNode then
		TaskDispatcher.cancelTask(slot0._refreshNodyByUpdateEpisodeInfo, slot0)
		TaskDispatcher.runDelay(slot0._refreshNodyByUpdateEpisodeInfo, slot0, EliminateMapEnum.MapViewOpenAnimLength)
		slot0:_startBlock(EliminateMapEnum.MapViewOpenAnimLength)
	end
end

function slot0._refreshNodyByUpdateEpisodeInfo(slot0)
	if slot0._isUpdateEpisodeInfo or slot0._updateNode then
		slot0._isUpdateEpisodeInfo = false

		slot0:refreshNode()
	end
end

function slot0.startPathAnimation(slot0)
	if (EliminateMapModel.instance:getEpisodeConfig(slot1.preEpisode) and slot3.aniPos or 0) == (slot0.lastCanFightEpisodeMo.config.aniPos or 0) then
		slot0:setMatValue(slot4)
		slot0:_refreshNodyByUpdateEpisodeInfo()

		return
	end

	slot0.srcAniPos = slot4
	slot0.targetAniPos = slot2

	if slot0._pathTweenId then
		ZProj.TweenHelper.KillById(slot0._pathTweenId)

		slot0._pathTweenId = nil
	end

	slot5 = 0.33
	slot0._pathTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, slot5, slot0._onPathFrame, slot0._onPathFinish, slot0, nil, EaseType.Linear)

	slot0:_startBlock(slot5)
end

function slot0._onPathFrame(slot0, slot1)
	slot0:setMatValue(slot0.srcAniPos + (slot0.targetAniPos - slot0.srcAniPos) * slot1)
end

function slot0._onPathFinish(slot0)
	slot0:_refreshNodyByUpdateEpisodeInfo()
	slot0:setMatValue(slot0.targetAniPos)
	slot0:playedPathAnimation(slot0.lastCanFightEpisodeMo.id)
	slot0._targetItem:showMainInfo(true)
	slot0._targetItem:playAnim("unlock")
	slot0:_showChessMoveAnim(slot0._srcItem, slot0._targetItem)
end

function slot0._showChessMoveAnim(slot0, slot1, slot2)
	slot1:showPointFinish(false)
	slot1:showSign(false)
	slot0:selectedNodeItem(slot2)

	slot5 = recthelper.getAnchorX(slot1.parentTrans) < recthelper.getAnchorX(slot2.parentTrans)

	if slot1:getChapterId() ~= slot2:getChapterId() then
		slot5 = slot6 < slot7
	end

	if slot5 then
		slot1:playChessAnim("close_right")
		slot2:playChessAnim("open_right")
	else
		slot1:playChessAnim("close_left")
		slot2:playChessAnim("open_left")
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_molu_role_move)
end

function slot0.setMatValue(slot0, slot1)
	slot0._vec4.x = slot1

	slot0.mat:SetVector("_DissolveControl", slot0._vec4)
end

function slot0.checkNeedPlayAnimation(slot0)
	if EliminateMapModel.instance:isFirstEpisode(slot0.lastCanFightEpisodeMo.id) then
		return false
	end

	return not slot0:isPlayedPathAnimation()
end

function slot0.isPlayedPathAnimation(slot0)
	slot0:initPlayedPathAnimationEpisodeList()

	if tabletool.indexOf(slot0.playedEpisodeIdList, slot0.lastCanFightEpisodeMo.id) then
		return true
	end

	return false
end

function slot0.initPlayedPathAnimationEpisodeList(slot0)
	if slot0.playedEpisodeIdList then
		return
	end

	if string.nilorempty(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EliminateEpisodePathAnimationKey), "")) then
		slot0.playedEpisodeIdList = {}

		return
	end

	slot0.playedEpisodeIdList = string.splitToNumber(slot1, ";")
end

function slot0.playedPathAnimation(slot0, slot1)
	if tabletool.indexOf(slot0.playedEpisodeIdList, slot1) then
		return
	end

	table.insert(slot0.playedEpisodeIdList, slot1)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EliminateEpisodePathAnimationKey), table.concat(slot0.playedEpisodeIdList, ";"))
end

slot0.EnterGameKey = "EnterEliminateKey"

function slot0._onClickEpisode(slot0, slot1)
	slot0._selectedEpisodeCo = slot1
	slot0._selectedEpisodeId = slot0._selectedEpisodeCo.id

	if not slot0._curSelectedNodeItem then
		slot0:_doEnterEpisode()

		return
	end

	if slot0._curSelectedNodeItem == slot0.nodeItemDict[slot0._selectedEpisodeId] then
		slot0:_doEnterEpisode()

		return
	end

	slot0:_showChessMoveAnim(slot0._curSelectedNodeItem, slot2)
	TaskDispatcher.cancelTask(slot0._doEnterEpisode, slot0)

	slot3 = 0.5

	TaskDispatcher.runDelay(slot0._doEnterEpisode, slot0, slot3)
	slot0:_startBlock(slot3)
end

function slot0._doEnterEpisode(slot0)
	if slot0._selectedEpisodeCo.dialogueId > 0 and not DialogueModel.instance:isFinishDialogue(slot1) then
		DialogueController.instance:enterDialogue(slot1, slot0._enterEpisode, slot0)

		return
	end

	slot0:_enterEpisode()
end

function slot0._enterEpisode(slot0)
	if not EliminateLevelModel.instance:selectSoliderIsUnLock() then
		slot0.animator:Play("click", slot0._onClickAnimDone, slot0)
	else
		slot0:_onClickAnimDone()
	end
end

function slot0._onClickAnimDone(slot0)
	slot0._changeEpisodeAnimDone = false

	EliminateMapController.instance:enterEpisode(slot0._selectedEpisodeId)
end

function slot0._onUnlockChapterAnimDone(slot0)
	slot0._changeEpisodeAnimDone = true
end

function slot0.onSelectChapterChange(slot0)
	slot0.chapterId = slot0.viewContainer.chapterId
	slot0.lastCanFightEpisodeMo = EliminateMapModel.instance:getLastCanFightEpisodeMo(slot0.chapterId)

	slot0:refreshUI()
	slot0:refreshPath()
end

function slot0.onUpdateEpisodeInfo(slot0)
	slot0.lastCanFightEpisodeMo = EliminateMapModel.instance:getLastCanFightEpisodeMo(slot0.chapterId)
	slot0._isUpdateEpisodeInfo = not slot0.lastCanFightEpisodeMo or slot1.id ~= slot0.lastCanFightEpisodeMo.id
end

function slot0._onScreenSizeChange(slot0)
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.EliminateEffectView then
		ViewMgr.instance:closeView(ViewName.EliminateSelectChessMenView)
		ViewMgr.instance:closeView(ViewName.EliminateSelectRoleView)
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.EliminateEffectView then
		if EliminateTeamSelectionModel.instance:getRestart() then
			EliminateTeamSelectionModel.instance:setRestart(false)
			slot0:_enterEpisode()

			return
		end

		slot0.animator:Play("out", slot0._outAnimDone, slot0)

		slot0._updateNode = true

		slot0:refreshPath()
	end
end

function slot0._outAnimDone(slot0)
end

function slot0.onClickAnimationDone(slot0)
	UIBlockMgr.instance:endBlock(uv0.EnterGameKey)
	EliminateMapModel.instance:setPlayingClickAnimation(false)
	slot0.viewContainer:setVisibleInternal(false)
end

function slot0.onGameLoadDone(slot0)
	slot0.viewContainer:setVisibleInternal(false)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshPath, slot0)
	TaskDispatcher.cancelTask(slot0.startPathAnimation, slot0)
	TaskDispatcher.cancelTask(slot0._doEnterEpisode, slot0)
	TaskDispatcher.cancelTask(slot0._refreshNodyByUpdateEpisodeInfo, slot0)
	TaskDispatcher.cancelTask(slot0._endBlock, slot0)
	slot0:_endBlock()

	if slot0._pathTweenId then
		ZProj.TweenHelper.KillById(slot0._pathTweenId)

		slot0._pathTweenId = nil
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagebottom:UnLoadImage()
end

return slot0
