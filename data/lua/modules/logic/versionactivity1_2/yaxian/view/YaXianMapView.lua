module("modules.logic.versionactivity1_2.yaxian.view.YaXianMapView", package.seeall)

slot0 = class("YaXianMapView", BaseView)

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
	slot0.goChapterNodeList = {}
	slot0.nodeItemDict = {}

	for slot4 = 1, 3 do
		table.insert(slot0.goChapterNodeList, gohelper.findChild(slot0.viewGO, "map/chapter" .. slot4))
	end

	slot0:addEventCb(YaXianController.instance, YaXianEvent.OnSelectChapterChange, slot0.onSelectChapterChange, slot0)
	slot0:addEventCb(YaXianController.instance, YaXianEvent.OnUpdateEpisodeInfo, slot0.onUpdateEpisodeInfo, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenSizeChange, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.OnGameLoadDone, slot0.onGameLoadDone, slot0)

	slot0.aniCurveConfig = slot0.viewContainer._abLoader:getAssetItem(slot0.viewContainer:getSetting().otherRes[1]):GetResource()
	slot0.animator = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)

	slot0._simagebottom:LoadImage(ResUrl.getYaXianImage("img_quyu_bg"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.chapterId = slot0.viewContainer.chapterId
	slot0.lastCanFightEpisodeMo = YaXianModel.instance:getLastCanFightEpisodeMo(slot0.chapterId)

	slot0:initMat()
	slot0:setMapPos()
	slot0:refreshUI()
	slot0:refreshPath()
end

function slot0.initMat(slot0)
	slot0.mat = gohelper.findChild(slot0.goChapterNodeList[slot0.chapterId], "lujinganim/luxian"):GetComponent(typeof(UnityEngine.UI.Graphic)).material
end

function slot0.setMapPos(slot0)
	if slot0.chapterId ~= 1 then
		recthelper.setAnchorX(slot0._simagebg.transform, 0)
		recthelper.setAnchorX(slot0.goChapterNodeList[1].transform, 0)

		return
	end

	slot1 = SettingsModel.instance:getScreenSizeMinRate()
	slot4, slot5 = GameGlobalMgr.instance:getScreenState():getScreenSize()
	slot7 = (1 - (slot4 / slot5 - slot1) / (SettingsModel.instance:getScreenSizeMaxRate() - slot1)) * uv0.MapMaxOffsetX

	recthelper.setAnchorX(slot0._simagebg.transform, -slot7)
	recthelper.setAnchorX(slot0.goChapterNodeList[1].transform, -slot7)
end

function slot0.refreshUI(slot0)
	slot0:refreshBg()
	slot0:refreshNode()
end

function slot0.refreshBg(slot0)
	slot4 = "img_map_" .. string.format("%02d", slot0.chapterId)

	slot0._simagebg:LoadImage(ResUrl.getYaXianImage(slot4))

	for slot4 = 1, 3 do
		gohelper.setActive(slot0.goChapterNodeList[slot4], slot4 == slot0.chapterId)
	end
end

function slot0.refreshNode(slot0)
	slot2 = nil

	for slot6, slot7 in ipairs(YaXianModel.instance:getEpisodeList(slot0.chapterId)) do
		slot0:refreshNodeItem(slot0.nodeItemDict[slot7.id] or slot0:createNodeItem(slot7))
	end
end

function slot0.createNodeItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.episodeMo = slot1
	slot6 = slot1.id
	slot2.go = gohelper.findChild(slot0.goChapterNodeList[slot0.chapterId], "node" .. slot6)
	slot2.goPath = gohelper.findChild(slot2.go, "xian")
	slot2.txtNodeIndex = gohelper.findChildText(slot2.go, "info/txtnodenum/#txt_node_num")
	slot2.txtNodeName = gohelper.findChildText(slot2.go, "info/#txt_node_name")
	slot2.goToothItem = gohelper.findChild(slot2.go, "info/bg/node/teeth/tooth")
	slot2.click = gohelper.findChildClick(slot2.go, "info/clickarea")
	slot2.goSelect = gohelper.findChildClick(slot2.go, "#icon")

	gohelper.setActive(slot2.goToothItem, false)
	gohelper.setActive(slot2.goSelect, false)

	slot2.toothList = {}

	for slot6 = 1, 3 do
		table.insert(slot2.toothList, slot0:createToothItem(slot2.goToothItem))
	end

	slot2.click:AddClickListener(slot0.onClickEpisodeNode, slot0, slot2)

	slot0.nodeItemDict[slot1.id] = slot2

	return slot2
end

function slot0.createToothItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.cloneInPlace(slot1)
	slot2.goGet = gohelper.findChild(slot2.go, "#go_get")
	slot2.goLock = gohelper.findChild(slot2.go, "#go_lock")

	gohelper.setActive(slot2.go, true)

	return slot2
end

function slot0.refreshNodeItem(slot0, slot1)
	if slot1.episodeMo.star == 0 and slot1.episodeMo.id ~= slot0.lastCanFightEpisodeMo.id then
		gohelper.setActive(slot1.go, false)

		return
	end

	if slot1.episodeMo.id == slot0.lastCanFightEpisodeMo.id then
		gohelper.setActive(slot1.go, YaXianModel.instance:isFirstEpisode(slot1.episodeMo.id) or slot0:isPlayedPathAnimation())
	else
		gohelper.setActive(slot1.go, true)
	end

	gohelper.setActive(slot1.goSelect, slot2)

	slot1.txtNodeIndex.text = slot1.episodeMo.config.index
	slot1.txtNodeName.text = slot1.episodeMo.config.name

	slot0:refreshNodeItemStar(slot1)

	if slot1.episodeMo.id == slot0.lastCanFightEpisodeMo.id then
		gohelper.setActive(slot1.goPath, false)
	else
		gohelper.setActive(slot1.goPath, true)
	end
end

function slot0.refreshNodeItemStar(slot0, slot1)
	if not string.nilorempty(slot1.episodeMo.config.extStarCondition) then
		slot3 = 1 + #string.split(slot2, "|")
	end

	for slot7 = 1, slot3 do
		gohelper.setActive(slot1.toothList[slot7].go, true)
		gohelper.setActive(slot1.toothList[slot7].goGet, slot7 <= slot1.episodeMo.star)
		gohelper.setActive(slot1.toothList[slot7].goLock, slot1.episodeMo.star < slot7)
	end

	for slot7 = slot3 + 1, 3 do
		gohelper.setActive(slot1.toothList[slot7].go, false)
	end
end

function slot0.refreshPath(slot0)
	if YaXianModel.instance:isFirstEpisode(slot0.lastCanFightEpisodeMo.id) then
		slot0:setMatValue(slot0.lastCanFightEpisodeMo.config and slot0.lastCanFightEpisodeMo.config.aniPos or 0)

		return
	end

	slot2 = slot0.lastCanFightEpisodeMo.config.aniPos or 0

	if slot0:checkNeedPlayAnimation() then
		gohelper.setActive(slot0.nodeItemDict[slot1.id].go, false)
		slot0:setMatValue(YaXianConfig.instance:getPreEpisodeConfig(slot1.activityId, slot1.id) and slot4.aniPos or 0)
		TaskDispatcher.runDelay(slot0.startPathAnimation, slot0, 0.667)

		return
	end

	slot0:setMatValue(slot2)
end

function slot0.checkNeedPlayAnimation(slot0)
	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		return false
	end

	if YaXianModel.instance:isFirstEpisode(slot0.lastCanFightEpisodeMo.id) then
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

	if string.nilorempty(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.YaXianEpisodePathAnimationKey), "")) then
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
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.YaXianEpisodePathAnimationKey), table.concat(slot0.playedEpisodeIdList, ";"))
end

function slot0.startPathAnimation(slot0)
	if (YaXianConfig.instance:getPreEpisodeConfig(slot1.activityId, slot1.id) and slot3.aniPos or 0) == (slot0.lastCanFightEpisodeMo.config.aniPos or 0) then
		slot0:setMatValue(slot4)

		return
	end

	TaskDispatcher.cancelTask(slot0._onFrame, slot0)

	slot0.startTime = Time.time
	slot0.srcAniPos = slot4
	slot0.targetAniPos = slot2

	TaskDispatcher.runRepeat(slot0._onFrame, slot0, 0.001)
end

function slot0._onFrame(slot0)
	if uv0.AnimationDuration <= Time.time - slot0.startTime then
		slot0:onPathAnimationDone()

		return
	end

	slot0:setMatValue(Mathf.Lerp(slot0.srcAniPos, slot0.targetAniPos, slot0.aniCurveConfig:GetY(slot1 / uv0.AnimationDuration)))
end

function slot0.onPathAnimationDone(slot0)
	TaskDispatcher.cancelTask(slot0._onFrame, slot0)
	slot0:setMatValue(slot0.targetAniPos)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
	gohelper.setActive(slot0.nodeItemDict[slot0.lastCanFightEpisodeMo.id].go, true)
	slot0:playedPathAnimation(slot0.lastCanFightEpisodeMo.id)
end

function slot0.setMatValue(slot0, slot1)
	slot0.mat:SetTextureOffset("_Mask", Vector2.New(slot1, 0))
end

slot0.EnterGameKey = "EnterYaXianGameKey"

function slot0.onClickEpisodeNode(slot0, slot1)
	UIBlockMgr.instance:startBlock(uv0.EnterGameKey)
	slot0:_enterChessGame(slot1.episodeMo.config.id)
	YaXianModel.instance:setPlayingClickAnimation(true)
	slot0.animator:Play("click", slot0.onClickAnimationDone, slot0)
end

function slot0._enterChessGame(slot0, slot1)
	YaXianGameController.instance:enterChessGame(slot1)
end

function slot0.onSelectChapterChange(slot0)
	slot0.chapterId = slot0.viewContainer.chapterId
	slot0.lastCanFightEpisodeMo = YaXianModel.instance:getLastCanFightEpisodeMo(slot0.chapterId)

	slot0:setMapPos()
	slot0:refreshUI()
	slot0:refreshPath()
end

function slot0.onUpdateEpisodeInfo(slot0)
	slot0.lastCanFightEpisodeMo = YaXianModel.instance:getLastCanFightEpisodeMo(slot0.chapterId)

	slot0:refreshNode()

	if slot0.lastCanFightEpisodeMo.chapterId == slot0.chapterId then
		slot0:refreshPath()
	end
end

function slot0._onScreenSizeChange(slot0)
	slot0:setMapPos()
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.YaXianGameView then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.GameReset)
		slot0.animator:Play("out")
	end

	slot0:refreshPath()
end

function slot0.onClickAnimationDone(slot0)
	UIBlockMgr.instance:endBlock(uv0.EnterGameKey)
	YaXianModel.instance:setPlayingClickAnimation(false)
	slot0.viewContainer:setVisibleInternal(false)
end

function slot0.onGameLoadDone(slot0)
	slot0.viewContainer:setVisibleInternal(false)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onFrame, slot0)
	TaskDispatcher.cancelTask(slot0.startPathAnimation, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagebottom:UnLoadImage()

	for slot4, slot5 in pairs(slot0.nodeItemDict) do
		slot5.click:RemoveClickListener()
	end
end

return slot0
