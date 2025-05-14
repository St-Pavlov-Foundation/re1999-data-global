module("modules.logic.versionactivity1_2.yaxian.view.YaXianMapView", package.seeall)

local var_0_0 = class("YaXianMapView", BaseView)

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
	arg_4_0.goChapterNodeList = {}
	arg_4_0.nodeItemDict = {}

	for iter_4_0 = 1, 3 do
		table.insert(arg_4_0.goChapterNodeList, gohelper.findChild(arg_4_0.viewGO, "map/chapter" .. iter_4_0))
	end

	arg_4_0:addEventCb(YaXianController.instance, YaXianEvent.OnSelectChapterChange, arg_4_0.onSelectChapterChange, arg_4_0)
	arg_4_0:addEventCb(YaXianController.instance, YaXianEvent.OnUpdateEpisodeInfo, arg_4_0.onUpdateEpisodeInfo, arg_4_0)
	arg_4_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_4_0._onScreenSizeChange, arg_4_0, LuaEventSystem.Low)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_4_0._onCloseViewFinish, arg_4_0)
	arg_4_0:addEventCb(YaXianGameController.instance, YaXianEvent.OnGameLoadDone, arg_4_0.onGameLoadDone, arg_4_0)

	local var_4_0 = arg_4_0.viewContainer:getSetting().otherRes[1]

	arg_4_0.aniCurveConfig = arg_4_0.viewContainer._abLoader:getAssetItem(var_4_0):GetResource()
	arg_4_0.animator = ZProj.ProjAnimatorPlayer.Get(arg_4_0.viewGO)

	arg_4_0._simagebottom:LoadImage(ResUrl.getYaXianImage("img_quyu_bg"))
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.chapterId = arg_6_0.viewContainer.chapterId
	arg_6_0.lastCanFightEpisodeMo = YaXianModel.instance:getLastCanFightEpisodeMo(arg_6_0.chapterId)

	arg_6_0:initMat()
	arg_6_0:setMapPos()
	arg_6_0:refreshUI()
	arg_6_0:refreshPath()
end

function var_0_0.initMat(arg_7_0)
	local var_7_0 = arg_7_0.goChapterNodeList[arg_7_0.chapterId]

	arg_7_0.mat = gohelper.findChild(var_7_0, "lujinganim/luxian"):GetComponent(typeof(UnityEngine.UI.Graphic)).material
end

function var_0_0.setMapPos(arg_8_0)
	if arg_8_0.chapterId ~= 1 then
		recthelper.setAnchorX(arg_8_0._simagebg.transform, 0)
		recthelper.setAnchorX(arg_8_0.goChapterNodeList[1].transform, 0)

		return
	end

	local var_8_0 = SettingsModel.instance:getScreenSizeMinRate()
	local var_8_1 = SettingsModel.instance:getScreenSizeMaxRate()
	local var_8_2, var_8_3 = GameGlobalMgr.instance:getScreenState():getScreenSize()
	local var_8_4 = (1 - (var_8_2 / var_8_3 - var_8_0) / (var_8_1 - var_8_0)) * var_0_0.MapMaxOffsetX

	recthelper.setAnchorX(arg_8_0._simagebg.transform, -var_8_4)
	recthelper.setAnchorX(arg_8_0.goChapterNodeList[1].transform, -var_8_4)
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0:refreshBg()
	arg_9_0:refreshNode()
end

function var_0_0.refreshBg(arg_10_0)
	arg_10_0._simagebg:LoadImage(ResUrl.getYaXianImage("img_map_" .. string.format("%02d", arg_10_0.chapterId)))

	for iter_10_0 = 1, 3 do
		gohelper.setActive(arg_10_0.goChapterNodeList[iter_10_0], iter_10_0 == arg_10_0.chapterId)
	end
end

function var_0_0.refreshNode(arg_11_0)
	local var_11_0 = YaXianModel.instance:getEpisodeList(arg_11_0.chapterId)
	local var_11_1

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_2 = arg_11_0.nodeItemDict[iter_11_1.id] or arg_11_0:createNodeItem(iter_11_1)

		arg_11_0:refreshNodeItem(var_11_2)
	end
end

function var_0_0.createNodeItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getUserDataTb_()

	var_12_0.episodeMo = arg_12_1
	var_12_0.go = gohelper.findChild(arg_12_0.goChapterNodeList[arg_12_0.chapterId], "node" .. arg_12_1.id)
	var_12_0.goPath = gohelper.findChild(var_12_0.go, "xian")
	var_12_0.txtNodeIndex = gohelper.findChildText(var_12_0.go, "info/txtnodenum/#txt_node_num")
	var_12_0.txtNodeName = gohelper.findChildText(var_12_0.go, "info/#txt_node_name")
	var_12_0.goToothItem = gohelper.findChild(var_12_0.go, "info/bg/node/teeth/tooth")
	var_12_0.click = gohelper.findChildClick(var_12_0.go, "info/clickarea")
	var_12_0.goSelect = gohelper.findChildClick(var_12_0.go, "#icon")

	gohelper.setActive(var_12_0.goToothItem, false)
	gohelper.setActive(var_12_0.goSelect, false)

	var_12_0.toothList = {}

	for iter_12_0 = 1, 3 do
		table.insert(var_12_0.toothList, arg_12_0:createToothItem(var_12_0.goToothItem))
	end

	var_12_0.click:AddClickListener(arg_12_0.onClickEpisodeNode, arg_12_0, var_12_0)

	arg_12_0.nodeItemDict[arg_12_1.id] = var_12_0

	return var_12_0
end

function var_0_0.createToothItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getUserDataTb_()

	var_13_0.go = gohelper.cloneInPlace(arg_13_1)
	var_13_0.goGet = gohelper.findChild(var_13_0.go, "#go_get")
	var_13_0.goLock = gohelper.findChild(var_13_0.go, "#go_lock")

	gohelper.setActive(var_13_0.go, true)

	return var_13_0
end

function var_0_0.refreshNodeItem(arg_14_0, arg_14_1)
	if arg_14_1.episodeMo.star == 0 and arg_14_1.episodeMo.id ~= arg_14_0.lastCanFightEpisodeMo.id then
		gohelper.setActive(arg_14_1.go, false)

		return
	end

	local var_14_0 = arg_14_1.episodeMo.id == arg_14_0.lastCanFightEpisodeMo.id

	if var_14_0 then
		gohelper.setActive(arg_14_1.go, YaXianModel.instance:isFirstEpisode(arg_14_1.episodeMo.id) or arg_14_0:isPlayedPathAnimation())
	else
		gohelper.setActive(arg_14_1.go, true)
	end

	gohelper.setActive(arg_14_1.goSelect, var_14_0)

	arg_14_1.txtNodeIndex.text = arg_14_1.episodeMo.config.index
	arg_14_1.txtNodeName.text = arg_14_1.episodeMo.config.name

	arg_14_0:refreshNodeItemStar(arg_14_1)

	if arg_14_1.episodeMo.id == arg_14_0.lastCanFightEpisodeMo.id then
		gohelper.setActive(arg_14_1.goPath, false)
	else
		gohelper.setActive(arg_14_1.goPath, true)
	end
end

function var_0_0.refreshNodeItemStar(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.episodeMo.config.extStarCondition
	local var_15_1 = 1

	if not string.nilorempty(var_15_0) then
		var_15_1 = var_15_1 + #string.split(var_15_0, "|")
	end

	for iter_15_0 = 1, var_15_1 do
		gohelper.setActive(arg_15_1.toothList[iter_15_0].go, true)
		gohelper.setActive(arg_15_1.toothList[iter_15_0].goGet, iter_15_0 <= arg_15_1.episodeMo.star)
		gohelper.setActive(arg_15_1.toothList[iter_15_0].goLock, iter_15_0 > arg_15_1.episodeMo.star)
	end

	for iter_15_1 = var_15_1 + 1, 3 do
		gohelper.setActive(arg_15_1.toothList[iter_15_1].go, false)
	end
end

function var_0_0.refreshPath(arg_16_0)
	if YaXianModel.instance:isFirstEpisode(arg_16_0.lastCanFightEpisodeMo.id) then
		local var_16_0 = arg_16_0.lastCanFightEpisodeMo.config and arg_16_0.lastCanFightEpisodeMo.config.aniPos or 0

		arg_16_0:setMatValue(var_16_0)

		return
	end

	local var_16_1 = arg_16_0.lastCanFightEpisodeMo.config
	local var_16_2 = var_16_1.aniPos or 0

	if arg_16_0:checkNeedPlayAnimation() then
		local var_16_3 = arg_16_0.nodeItemDict[var_16_1.id]

		gohelper.setActive(var_16_3.go, false)

		local var_16_4 = YaXianConfig.instance:getPreEpisodeConfig(var_16_1.activityId, var_16_1.id)
		local var_16_5 = var_16_4 and var_16_4.aniPos or 0

		arg_16_0:setMatValue(var_16_5)
		TaskDispatcher.runDelay(arg_16_0.startPathAnimation, arg_16_0, 0.667)

		return
	end

	arg_16_0:setMatValue(var_16_2)
end

function var_0_0.checkNeedPlayAnimation(arg_17_0)
	if not ViewHelper.instance:checkViewOnTheTop(arg_17_0.viewName) then
		return false
	end

	if YaXianModel.instance:isFirstEpisode(arg_17_0.lastCanFightEpisodeMo.id) then
		return false
	end

	return not arg_17_0:isPlayedPathAnimation()
end

function var_0_0.isPlayedPathAnimation(arg_18_0)
	arg_18_0:initPlayedPathAnimationEpisodeList()

	if tabletool.indexOf(arg_18_0.playedEpisodeIdList, arg_18_0.lastCanFightEpisodeMo.id) then
		return true
	end

	return false
end

function var_0_0.initPlayedPathAnimationEpisodeList(arg_19_0)
	if arg_19_0.playedEpisodeIdList then
		return
	end

	local var_19_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.YaXianEpisodePathAnimationKey), "")

	if string.nilorempty(var_19_0) then
		arg_19_0.playedEpisodeIdList = {}

		return
	end

	arg_19_0.playedEpisodeIdList = string.splitToNumber(var_19_0, ";")
end

function var_0_0.playedPathAnimation(arg_20_0, arg_20_1)
	if tabletool.indexOf(arg_20_0.playedEpisodeIdList, arg_20_1) then
		return
	end

	table.insert(arg_20_0.playedEpisodeIdList, arg_20_1)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.YaXianEpisodePathAnimationKey), table.concat(arg_20_0.playedEpisodeIdList, ";"))
end

function var_0_0.startPathAnimation(arg_21_0)
	local var_21_0 = arg_21_0.lastCanFightEpisodeMo.config
	local var_21_1 = var_21_0.aniPos or 0
	local var_21_2 = YaXianConfig.instance:getPreEpisodeConfig(var_21_0.activityId, var_21_0.id)
	local var_21_3 = var_21_2 and var_21_2.aniPos or 0

	if var_21_3 == var_21_1 then
		arg_21_0:setMatValue(var_21_3)

		return
	end

	TaskDispatcher.cancelTask(arg_21_0._onFrame, arg_21_0)

	arg_21_0.startTime = Time.time
	arg_21_0.srcAniPos = var_21_3
	arg_21_0.targetAniPos = var_21_1

	TaskDispatcher.runRepeat(arg_21_0._onFrame, arg_21_0, 0.001)
end

function var_0_0._onFrame(arg_22_0)
	local var_22_0 = Time.time - arg_22_0.startTime

	if var_22_0 >= var_0_0.AnimationDuration then
		arg_22_0:onPathAnimationDone()

		return
	end

	local var_22_1 = var_22_0 / var_0_0.AnimationDuration
	local var_22_2 = arg_22_0.aniCurveConfig:GetY(var_22_1)

	arg_22_0:setMatValue(Mathf.Lerp(arg_22_0.srcAniPos, arg_22_0.targetAniPos, var_22_2))
end

function var_0_0.onPathAnimationDone(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._onFrame, arg_23_0)
	arg_23_0:setMatValue(arg_23_0.targetAniPos)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)

	local var_23_0 = arg_23_0.nodeItemDict[arg_23_0.lastCanFightEpisodeMo.id]

	gohelper.setActive(var_23_0.go, true)
	arg_23_0:playedPathAnimation(arg_23_0.lastCanFightEpisodeMo.id)
end

function var_0_0.setMatValue(arg_24_0, arg_24_1)
	arg_24_0.mat:SetTextureOffset("_Mask", Vector2.New(arg_24_1, 0))
end

var_0_0.EnterGameKey = "EnterYaXianGameKey"

function var_0_0.onClickEpisodeNode(arg_25_0, arg_25_1)
	UIBlockMgr.instance:startBlock(var_0_0.EnterGameKey)

	local var_25_0 = arg_25_1.episodeMo.config

	arg_25_0:_enterChessGame(var_25_0.id)
	YaXianModel.instance:setPlayingClickAnimation(true)
	arg_25_0.animator:Play("click", arg_25_0.onClickAnimationDone, arg_25_0)
end

function var_0_0._enterChessGame(arg_26_0, arg_26_1)
	YaXianGameController.instance:enterChessGame(arg_26_1)
end

function var_0_0.onSelectChapterChange(arg_27_0)
	arg_27_0.chapterId = arg_27_0.viewContainer.chapterId
	arg_27_0.lastCanFightEpisodeMo = YaXianModel.instance:getLastCanFightEpisodeMo(arg_27_0.chapterId)

	arg_27_0:setMapPos()
	arg_27_0:refreshUI()
	arg_27_0:refreshPath()
end

function var_0_0.onUpdateEpisodeInfo(arg_28_0)
	arg_28_0.lastCanFightEpisodeMo = YaXianModel.instance:getLastCanFightEpisodeMo(arg_28_0.chapterId)

	arg_28_0:refreshNode()

	if arg_28_0.lastCanFightEpisodeMo.chapterId == arg_28_0.chapterId then
		arg_28_0:refreshPath()
	end
end

function var_0_0._onScreenSizeChange(arg_29_0)
	arg_29_0:setMapPos()
end

function var_0_0._onCloseViewFinish(arg_30_0, arg_30_1)
	if arg_30_1 == ViewName.YaXianGameView then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.GameReset)
		arg_30_0.animator:Play("out")
	end

	arg_30_0:refreshPath()
end

function var_0_0.onClickAnimationDone(arg_31_0)
	UIBlockMgr.instance:endBlock(var_0_0.EnterGameKey)
	YaXianModel.instance:setPlayingClickAnimation(false)
	arg_31_0.viewContainer:setVisibleInternal(false)
end

function var_0_0.onGameLoadDone(arg_32_0)
	arg_32_0.viewContainer:setVisibleInternal(false)
end

function var_0_0.onClose(arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._onFrame, arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0.startPathAnimation, arg_33_0)
end

function var_0_0.onDestroyView(arg_34_0)
	arg_34_0._simagebg:UnLoadImage()
	arg_34_0._simagebottom:UnLoadImage()

	for iter_34_0, iter_34_1 in pairs(arg_34_0.nodeItemDict) do
		iter_34_1.click:RemoveClickListener()
	end
end

return var_0_0
