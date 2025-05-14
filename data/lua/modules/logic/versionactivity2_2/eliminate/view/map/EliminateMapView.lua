module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateMapView", package.seeall)

local var_0_0 = class("EliminateMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "map/#simage_bg")
	arg_1_0._simagebottom = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/bottom/#simage_bottom")

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

var_0_0.MapMaxOffsetX = 150
var_0_0.AnimationDuration = 1

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._vec4 = Vector4(0, 0.05, 0, 0)
	arg_4_0.goChapterNodeList = {}
	arg_4_0.nodeItemDict = {}

	for iter_4_0 = 1, EliminateMapModel.getChapterNum() do
		table.insert(arg_4_0.goChapterNodeList, gohelper.findChild(arg_4_0.viewGO, "map/chapter" .. iter_4_0))
	end

	arg_4_0:addEventCb(EliminateMapController.instance, EliminateMapEvent.OnSelectChapterChange, arg_4_0.onSelectChapterChange, arg_4_0)
	arg_4_0:addEventCb(EliminateMapController.instance, EliminateMapEvent.UnlockChapterAnimDone, arg_4_0._onUnlockChapterAnimDone, arg_4_0)
	arg_4_0:addEventCb(EliminateMapController.instance, EliminateMapEvent.OnUpdateEpisodeInfo, arg_4_0.onUpdateEpisodeInfo, arg_4_0)
	arg_4_0:addEventCb(EliminateMapController.instance, EliminateMapEvent.ClickEpisode, arg_4_0._onClickEpisode, arg_4_0)
	arg_4_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_4_0._onScreenSizeChange, arg_4_0, LuaEventSystem.Low)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_4_0._onCloseViewFinish, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_4_0._onOpenViewFinish, arg_4_0)

	arg_4_0.animator = SLFramework.AnimatorPlayer.Get(arg_4_0.viewGO)
	arg_4_0._gonormal = gohelper.findChild(arg_4_0.viewGO, "map/bg_eff_normal")
	arg_4_0._gospecial = gohelper.findChild(arg_4_0.viewGO, "map/bg_eff_special")
end

local var_0_1 = "EliminateMapViewBlock"

function var_0_0._startBlock(arg_5_0, arg_5_1)
	TaskDispatcher.cancelTask(arg_5_0._endBlock, arg_5_0)
	TaskDispatcher.runDelay(arg_5_0._endBlock, arg_5_0, arg_5_1 + 0.1)
	UIBlockMgr.instance:startBlock(var_0_1)
end

function var_0_0._endBlock(arg_6_0)
	UIBlockMgr.instance:endBlock(var_0_1)
end

function var_0_0.selectedNodeItem(arg_7_0, arg_7_1)
	arg_7_1:showChess(true)

	arg_7_0._curSelectedNodeItem = arg_7_1

	local var_7_0 = arg_7_1:isBoss()

	gohelper.setActive(arg_7_0._gonormal, not var_7_0)
	gohelper.setActive(arg_7_0._gospecial, var_7_0)
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.chapterId = arg_8_0.viewContainer.chapterId
	arg_8_0.lastCanFightEpisodeMo = EliminateMapModel.instance:getLastCanFightEpisodeMo(arg_8_0.chapterId)

	arg_8_0:refreshUI()
	arg_8_0:refreshPath()
end

function var_0_0.initMat(arg_9_0)
	local var_9_0 = arg_9_0.goChapterNodeList[arg_9_0.chapterId]

	arg_9_0.mat = gohelper.findChild(var_9_0, "lujinganim/luxian_light"):GetComponent(typeof(UnityEngine.UI.Graphic)).material
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0:refreshBg()
	arg_10_0:refreshNode()
end

function var_0_0.refreshBg(arg_11_0)
	local var_11_0 = lua_eliminate_chapter.configDict[arg_11_0.chapterId].map

	arg_11_0._simagebg:LoadImage(var_11_0)

	for iter_11_0 = 1, EliminateMapModel.getChapterNum() do
		gohelper.setActive(arg_11_0.goChapterNodeList[iter_11_0], iter_11_0 == arg_11_0.chapterId)
	end

	arg_11_0:initMat()
end

function var_0_0.refreshNode(arg_12_0)
	local var_12_0 = EliminateMapModel.instance:getEpisodeList(arg_12_0.chapterId)

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_1 = arg_12_0.nodeItemDict[iter_12_1.id]

		if not var_12_1 then
			var_12_1 = arg_12_0:createNodeItem(iter_12_1)
			arg_12_0.nodeItemDict[iter_12_1.id] = var_12_1

			var_12_1:setIndex(iter_12_0)
		end

		var_12_1:onUpdateMO(iter_12_1, arg_12_0.lastCanFightEpisodeMo)

		if var_12_1 ~= arg_12_0._curSelectedNodeItem then
			var_12_1:showChess(false)
		end
	end

	if arg_12_0._curSelectedNodeItem then
		arg_12_0:selectedNodeItem(arg_12_0._curSelectedNodeItem)
	end
end

function var_0_0.createNodeItem(arg_13_0, arg_13_1)
	local var_13_0 = gohelper.findChild(arg_13_0.goChapterNodeList[arg_13_0.chapterId], "node" .. arg_13_1.config.posIndex)
	local var_13_1 = arg_13_1.config.levelPosition == EliminateLevelEnum.levelType.boss and arg_13_0.viewContainer:getSetting().otherRes[3] or arg_13_0.viewContainer:getSetting().otherRes[2]
	local var_13_2 = arg_13_0:getResInst(var_13_1, var_13_0, arg_13_1.config.posIndex)
	local var_13_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_2, EliminateMapStageItem)

	var_13_3.parentTrans = var_13_0.transform

	return var_13_3
end

function var_0_0.refreshPath(arg_14_0)
	local var_14_0 = arg_14_0.lastCanFightEpisodeMo.config

	if arg_14_0:checkNeedPlayAnimation() and arg_14_0._isUpdateEpisodeInfo then
		local var_14_1 = arg_14_0.nodeItemDict[var_14_0.id]

		if var_14_1 then
			var_14_1:showMainInfo(false)
		end

		arg_14_0._targetItem = var_14_1

		local var_14_2 = EliminateMapModel.instance:getEpisodeConfig(var_14_0.preEpisode)
		local var_14_3 = var_14_2 and var_14_2.aniPos or 0
		local var_14_4 = arg_14_0.nodeItemDict[var_14_2.id]

		if var_14_4 then
			arg_14_0:selectedNodeItem(var_14_4)
			var_14_4:playAnim("finish")
		end

		arg_14_0._srcItem = var_14_4

		arg_14_0:setMatValue(var_14_3)
		TaskDispatcher.runDelay(arg_14_0.startPathAnimation, arg_14_0, EliminateMapEnum.MapViewOpenAnimLength)
		arg_14_0:_startBlock(EliminateMapEnum.MapViewOpenAnimLength)

		return
	end

	local var_14_5 = var_14_0 and var_14_0.aniPos or 0

	arg_14_0:setMatValue(var_14_5)

	if not arg_14_0._curSelectedNodeItem then
		local var_14_6 = arg_14_0.nodeItemDict[arg_14_0.lastCanFightEpisodeMo.id]

		arg_14_0:selectedNodeItem(var_14_6)
	end

	if arg_14_0._changeEpisodeAnimDone then
		arg_14_0._changeEpisodeAnimDone = false

		local var_14_7 = arg_14_0.nodeItemDict[arg_14_0.lastCanFightEpisodeMo.id]

		arg_14_0:selectedNodeItem(var_14_7)
		var_14_7:playChessAnim("open_right")
	end

	if arg_14_0._isUpdateEpisodeInfo or arg_14_0._updateNode then
		TaskDispatcher.cancelTask(arg_14_0._refreshNodyByUpdateEpisodeInfo, arg_14_0)
		TaskDispatcher.runDelay(arg_14_0._refreshNodyByUpdateEpisodeInfo, arg_14_0, EliminateMapEnum.MapViewOpenAnimLength)
		arg_14_0:_startBlock(EliminateMapEnum.MapViewOpenAnimLength)
	end
end

function var_0_0._refreshNodyByUpdateEpisodeInfo(arg_15_0)
	if arg_15_0._isUpdateEpisodeInfo or arg_15_0._updateNode then
		arg_15_0._isUpdateEpisodeInfo = false

		arg_15_0:refreshNode()
	end
end

function var_0_0.startPathAnimation(arg_16_0)
	local var_16_0 = arg_16_0.lastCanFightEpisodeMo.config
	local var_16_1 = var_16_0.aniPos or 0
	local var_16_2 = EliminateMapModel.instance:getEpisodeConfig(var_16_0.preEpisode)
	local var_16_3 = var_16_2 and var_16_2.aniPos or 0

	if var_16_3 == var_16_1 then
		arg_16_0:setMatValue(var_16_3)
		arg_16_0:_refreshNodyByUpdateEpisodeInfo()

		return
	end

	arg_16_0.srcAniPos = var_16_3
	arg_16_0.targetAniPos = var_16_1

	if arg_16_0._pathTweenId then
		ZProj.TweenHelper.KillById(arg_16_0._pathTweenId)

		arg_16_0._pathTweenId = nil
	end

	local var_16_4 = 0.33

	arg_16_0._pathTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, var_16_4, arg_16_0._onPathFrame, arg_16_0._onPathFinish, arg_16_0, nil, EaseType.Linear)

	arg_16_0:_startBlock(var_16_4)
end

function var_0_0._onPathFrame(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.srcAniPos + (arg_17_0.targetAniPos - arg_17_0.srcAniPos) * arg_17_1

	arg_17_0:setMatValue(var_17_0)
end

function var_0_0._onPathFinish(arg_18_0)
	arg_18_0:_refreshNodyByUpdateEpisodeInfo()
	arg_18_0:setMatValue(arg_18_0.targetAniPos)
	arg_18_0:playedPathAnimation(arg_18_0.lastCanFightEpisodeMo.id)
	arg_18_0._targetItem:showMainInfo(true)
	arg_18_0._targetItem:playAnim("unlock")
	arg_18_0:_showChessMoveAnim(arg_18_0._srcItem, arg_18_0._targetItem)
end

function var_0_0._showChessMoveAnim(arg_19_0, arg_19_1, arg_19_2)
	arg_19_1:showPointFinish(false)
	arg_19_1:showSign(false)
	arg_19_0:selectedNodeItem(arg_19_2)

	local var_19_0 = recthelper.getAnchorX(arg_19_1.parentTrans) < recthelper.getAnchorX(arg_19_2.parentTrans)
	local var_19_1 = arg_19_1:getChapterId()
	local var_19_2 = arg_19_2:getChapterId()

	if var_19_1 ~= var_19_2 then
		var_19_0 = var_19_1 < var_19_2
	end

	if var_19_0 then
		arg_19_1:playChessAnim("close_right")
		arg_19_2:playChessAnim("open_right")
	else
		arg_19_1:playChessAnim("close_left")
		arg_19_2:playChessAnim("open_left")
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_molu_role_move)
end

function var_0_0.setMatValue(arg_20_0, arg_20_1)
	arg_20_0._vec4.x = arg_20_1

	arg_20_0.mat:SetVector("_DissolveControl", arg_20_0._vec4)
end

function var_0_0.checkNeedPlayAnimation(arg_21_0)
	if EliminateMapModel.instance:isFirstEpisode(arg_21_0.lastCanFightEpisodeMo.id) then
		return false
	end

	return not arg_21_0:isPlayedPathAnimation()
end

function var_0_0.isPlayedPathAnimation(arg_22_0)
	arg_22_0:initPlayedPathAnimationEpisodeList()

	if tabletool.indexOf(arg_22_0.playedEpisodeIdList, arg_22_0.lastCanFightEpisodeMo.id) then
		return true
	end

	return false
end

function var_0_0.initPlayedPathAnimationEpisodeList(arg_23_0)
	if arg_23_0.playedEpisodeIdList then
		return
	end

	local var_23_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EliminateEpisodePathAnimationKey), "")

	if string.nilorempty(var_23_0) then
		arg_23_0.playedEpisodeIdList = {}

		return
	end

	arg_23_0.playedEpisodeIdList = string.splitToNumber(var_23_0, ";")
end

function var_0_0.playedPathAnimation(arg_24_0, arg_24_1)
	if tabletool.indexOf(arg_24_0.playedEpisodeIdList, arg_24_1) then
		return
	end

	table.insert(arg_24_0.playedEpisodeIdList, arg_24_1)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EliminateEpisodePathAnimationKey), table.concat(arg_24_0.playedEpisodeIdList, ";"))
end

var_0_0.EnterGameKey = "EnterEliminateKey"

function var_0_0._onClickEpisode(arg_25_0, arg_25_1)
	arg_25_0._selectedEpisodeCo = arg_25_1
	arg_25_0._selectedEpisodeId = arg_25_0._selectedEpisodeCo.id

	if not arg_25_0._curSelectedNodeItem then
		arg_25_0:_doEnterEpisode()

		return
	end

	local var_25_0 = arg_25_0.nodeItemDict[arg_25_0._selectedEpisodeId]

	if arg_25_0._curSelectedNodeItem == var_25_0 then
		arg_25_0:_doEnterEpisode()

		return
	end

	arg_25_0:_showChessMoveAnim(arg_25_0._curSelectedNodeItem, var_25_0)
	TaskDispatcher.cancelTask(arg_25_0._doEnterEpisode, arg_25_0)

	local var_25_1 = 0.5

	TaskDispatcher.runDelay(arg_25_0._doEnterEpisode, arg_25_0, var_25_1)
	arg_25_0:_startBlock(var_25_1)
end

function var_0_0._doEnterEpisode(arg_26_0)
	local var_26_0 = arg_26_0._selectedEpisodeCo.dialogueId

	if var_26_0 > 0 and not DialogueModel.instance:isFinishDialogue(var_26_0) then
		DialogueController.instance:enterDialogue(var_26_0, arg_26_0._enterEpisode, arg_26_0)

		return
	end

	arg_26_0:_enterEpisode()
end

function var_0_0._enterEpisode(arg_27_0)
	if not EliminateLevelModel.instance:selectSoliderIsUnLock() then
		arg_27_0.animator:Play("click", arg_27_0._onClickAnimDone, arg_27_0)
	else
		arg_27_0:_onClickAnimDone()
	end
end

function var_0_0._onClickAnimDone(arg_28_0)
	arg_28_0._changeEpisodeAnimDone = false

	local var_28_0 = arg_28_0._selectedEpisodeId

	EliminateMapController.instance:enterEpisode(var_28_0)
end

function var_0_0._onUnlockChapterAnimDone(arg_29_0)
	arg_29_0._changeEpisodeAnimDone = true
end

function var_0_0.onSelectChapterChange(arg_30_0)
	arg_30_0.chapterId = arg_30_0.viewContainer.chapterId
	arg_30_0.lastCanFightEpisodeMo = EliminateMapModel.instance:getLastCanFightEpisodeMo(arg_30_0.chapterId)

	arg_30_0:refreshUI()
	arg_30_0:refreshPath()
end

function var_0_0.onUpdateEpisodeInfo(arg_31_0)
	local var_31_0 = arg_31_0.lastCanFightEpisodeMo

	arg_31_0.lastCanFightEpisodeMo = EliminateMapModel.instance:getLastCanFightEpisodeMo(arg_31_0.chapterId)
	arg_31_0._isUpdateEpisodeInfo = not var_31_0 or var_31_0.id ~= arg_31_0.lastCanFightEpisodeMo.id
end

function var_0_0._onScreenSizeChange(arg_32_0)
	return
end

function var_0_0._onOpenViewFinish(arg_33_0, arg_33_1)
	if arg_33_1 == ViewName.EliminateEffectView then
		ViewMgr.instance:closeView(ViewName.EliminateSelectChessMenView)
		ViewMgr.instance:closeView(ViewName.EliminateSelectRoleView)
	end
end

function var_0_0._onCloseViewFinish(arg_34_0, arg_34_1)
	if arg_34_1 == ViewName.EliminateEffectView then
		if EliminateTeamSelectionModel.instance:getRestart() then
			EliminateTeamSelectionModel.instance:setRestart(false)
			arg_34_0:_enterEpisode()

			return
		end

		arg_34_0.animator:Play("out", arg_34_0._outAnimDone, arg_34_0)

		arg_34_0._updateNode = true

		arg_34_0:refreshPath()
	end
end

function var_0_0._outAnimDone(arg_35_0)
	return
end

function var_0_0.onClickAnimationDone(arg_36_0)
	UIBlockMgr.instance:endBlock(var_0_0.EnterGameKey)
	EliminateMapModel.instance:setPlayingClickAnimation(false)
	arg_36_0.viewContainer:setVisibleInternal(false)
end

function var_0_0.onGameLoadDone(arg_37_0)
	arg_37_0.viewContainer:setVisibleInternal(false)
end

function var_0_0.onClose(arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0.refreshPath, arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0.startPathAnimation, arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0._doEnterEpisode, arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0._refreshNodyByUpdateEpisodeInfo, arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0._endBlock, arg_38_0)
	arg_38_0:_endBlock()

	if arg_38_0._pathTweenId then
		ZProj.TweenHelper.KillById(arg_38_0._pathTweenId)

		arg_38_0._pathTweenId = nil
	end
end

function var_0_0.onDestroyView(arg_39_0)
	arg_39_0._simagebg:UnLoadImage()
	arg_39_0._simagebottom:UnLoadImage()
end

return var_0_0
