module("modules.logic.versionactivity1_7.dungeon.view.store.VersionActivity1_7StoreTalk", package.seeall)

local var_0_0 = class("VersionActivity1_7StoreTalk", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gostagearea = gohelper.findChild(arg_1_0.viewGO, "#go_stagearea")
	arg_1_0._imagechess = gohelper.findChildImage(arg_1_0.viewGO, "Right/#chess/#image_chess")
	arg_1_0._gochess = gohelper.findChild(arg_1_0.viewGO, "Right/#chess")
	arg_1_0._godot = gohelper.findChild(arg_1_0.viewGO, "Right/vx_pot")
	arg_1_0._goTalk = gohelper.findChild(arg_1_0.viewGO, "Right/#go_talk")
	arg_1_0._goArrowTip = gohelper.findChild(arg_1_0.viewGO, "Right/#go_talk/#go_ArrowTips")
	arg_1_0._scrollTalk = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/#go_talk/Scroll View")
	arg_1_0._txttalk = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_talk/Scroll View/Viewport/Content/#txt_talk")

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

var_0_0.TalkMinTriggerDuration = 2
var_0_0.TalkStepShowDuration = 2
var_0_0.TalkTxtShowDuration = 6
var_0_0.TextSpawnInterval = 0.06
var_0_0.ChessJumpAnimDuration = 1.167
var_0_0.ScrollTalkMargin = {
	Top = 10,
	Bottom = 20
}
var_0_0.TextMaxHeight = 200
var_0_0.TipHeight = 10
var_0_0.SplitChar = "|"

function var_0_0.onClickStage(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_7Store.play_ui_jinye_click_stage)
	arg_4_0:triggerTalkByType(ActivityStoreConfig.BubbleTalkTriggerType.ClickStageArea)
end

function var_0_0.onClickText(arg_5_0)
	if arg_5_0.waitFinishTalk then
		return
	end

	if arg_5_0.waitPlayNextStep then
		TaskDispatcher.cancelTask(arg_5_0.playNextStep, arg_5_0)
		arg_5_0:playNextStep()

		return
	end

	if arg_5_0.start then
		arg_5_0.currentCharIndex = arg_5_0.contentLen

		arg_5_0:_tickContent()
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._scrollTalk.verticalNormalizedPosition = 1
	arg_6_0.lastTriggerTime = -var_0_0.TalkMinTriggerDuration
	arg_6_0.canTriggerList = {}
	arg_6_0.tempTypeList = {}
	arg_6_0.triggerStepList = {}
	arg_6_0.actId = VersionActivity1_7Enum.ActivityId.DungeonStore
	arg_6_0.stageClick = gohelper.getClickWithDefaultAudio(arg_6_0._gostagearea)

	arg_6_0.stageClick:AddClickListener(arg_6_0.onClickStage, arg_6_0)

	arg_6_0.talkTextClick = gohelper.getClickWithDefaultAudio(arg_6_0._goTalk)

	arg_6_0.talkTextClick:AddClickListener(arg_6_0.onClickText, arg_6_0)

	arg_6_0.rectTrTalk = arg_6_0._goTalk:GetComponent(gohelper.Type_RectTransform)
	arg_6_0.rectTrContent = gohelper.findChildComponent(arg_6_0.viewGO, "Right/#go_talk/Scroll View/Viewport/Content", gohelper.Type_RectTransform)
	arg_6_0.chessAnim = arg_6_0._gochess:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(arg_6_0._godot, false)
	gohelper.setActive(arg_6_0._goTalk, false)
	gohelper.setActive(arg_6_0._goArrowTip, false)
	arg_6_0:initUpdateBeat()
	arg_6_0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, arg_6_0.onBuyGoodsSuccess, arg_6_0, LuaEventSystem.Low)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_6_0.onCloseViewFinish, arg_6_0, LuaEventSystem.Low)
end

function var_0_0.initUpdateBeat(arg_7_0)
	arg_7_0.updateHandle = UpdateBeat:CreateListener(arg_7_0._onFrame, arg_7_0)

	UpdateBeat:AddListener(arg_7_0.updateHandle)

	arg_7_0.lateUpdateHandle = UpdateBeat:CreateListener(arg_7_0._onFrameLateUpdate, arg_7_0)

	UpdateBeat:AddListener(arg_7_0.lateUpdateHandle)
end

function var_0_0._onFrameLateUpdate(arg_8_0)
	if arg_8_0.closed then
		return
	end

	if not arg_8_0.start then
		return
	end

	if arg_8_0.needSetVerticalNormalized then
		arg_8_0._scrollTalk.verticalNormalizedPosition = 0
		arg_8_0.needSetVerticalNormalized = false
	end

	if not arg_8_0.isDirty then
		return
	end

	arg_8_0.isDirty = false
	arg_8_0.needSetVerticalNormalized = true

	local var_8_0 = arg_8_0._txttalk.preferredHeight
	local var_8_1 = var_0_0.ScrollTalkMargin.Top + var_0_0.ScrollTalkMargin.Bottom
	local var_8_2

	if var_8_0 > var_0_0.TextMaxHeight then
		var_8_2 = var_0_0.TextMaxHeight + var_8_1
	else
		var_8_2 = var_8_0 + var_8_1
	end

	if arg_8_0.waitPlayNextStep then
		var_8_2 = var_8_2 + var_0_0.TipHeight
	end

	recthelper.setHeight(arg_8_0.rectTrTalk, var_8_2)
end

function var_0_0._onFrame(arg_9_0)
	if arg_9_0.closed then
		return
	end

	if not arg_9_0.start then
		return
	end

	if arg_9_0.waitPlayNextStep or arg_9_0.waitFinishTalk then
		return
	end

	if Time.time - arg_9_0.lastSpawnTime < var_0_0.TextSpawnInterval then
		return
	end

	arg_9_0:_tickContent()
end

function var_0_0._tickContent(arg_10_0)
	if arg_10_0.closed then
		return
	end

	arg_10_0.lastSpawnTime = Time.time
	arg_10_0.currentCharIndex = arg_10_0.currentCharIndex + 1
	arg_10_0._txttalk.text = utf8.sub(arg_10_0.content, 1, arg_10_0.currentCharIndex)
	arg_10_0.isDirty = true

	if arg_10_0.currentCharIndex == arg_10_0.contentLen + 1 then
		if arg_10_0.triggerStepList[arg_10_0.currentStepIndex + 1] then
			arg_10_0:startWaitPlayNextStep()
			TaskDispatcher.runDelay(arg_10_0.playNextStep, arg_10_0, var_0_0.TalkStepShowDuration)
		else
			arg_10_0:startWaitFinishTalk()
			TaskDispatcher.runDelay(arg_10_0.onFinishTalk, arg_10_0, var_0_0.TalkTxtShowDuration)
		end
	end
end

function var_0_0.startWaitFinishTalk(arg_11_0)
	arg_11_0.waitFinishTalk = true
end

function var_0_0.startWaitPlayNextStep(arg_12_0)
	arg_12_0.waitPlayNextStep = true

	gohelper.setActive(arg_12_0._goArrowTip, true)
end

function var_0_0.onFinishTalk(arg_13_0)
	if arg_13_0._scrollTalk then
		arg_13_0._scrollTalk.verticalNormalizedPosition = 0
	end

	arg_13_0.lastSpawnTime = nil
	arg_13_0.currentCharIndex = nil
	arg_13_0.currentStepIndex = nil
	arg_13_0.content = nil
	arg_13_0.start = false
	arg_13_0.waitFinishTalk = false

	gohelper.setActive(arg_13_0._goTalk, false)
end

function var_0_0.playNextStep(arg_14_0)
	arg_14_0:playStep(arg_14_0.currentStepIndex + 1)

	arg_14_0.waitPlayNextStep = false

	gohelper.setActive(arg_14_0._goArrowTip, false)
end

function var_0_0.onCloseViewFinish(arg_15_0, arg_15_1)
	if arg_15_1 ~= ViewName.CommonPropView then
		return
	end

	if not arg_15_0.buyGoodsId then
		return
	end

	tabletool.clear(arg_15_0.tempTypeList)
	table.insert(arg_15_0.tempTypeList, ActivityStoreConfig.BubbleTalkTriggerType.BuyGoodsByRare)
	table.insert(arg_15_0.tempTypeList, ActivityStoreConfig.BubbleTalkTriggerType.BuyGoodsById)

	local var_15_0 = lua_activity107.configDict[arg_15_0.actId][arg_15_0.buyGoodsId]

	if var_15_0.maxBuyCount ~= 0 and var_15_0.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(arg_15_0.actId, var_15_0.id) < 1 then
		table.insert(arg_15_0.tempTypeList, ActivityStoreConfig.BubbleTalkTriggerType.SellOutGoodsByRare)
		table.insert(arg_15_0.tempTypeList, ActivityStoreConfig.BubbleTalkTriggerType.SellOutGoodsById)
	end

	arg_15_0:triggerTalkByTypeList(arg_15_0.tempTypeList, arg_15_0.buyGoodsId)

	arg_15_0.buyGoodsId = nil
end

function var_0_0.onBuyGoodsSuccess(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0.actId ~= arg_16_1 then
		return
	end

	arg_16_0.buyGoodsId = arg_16_2
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0:initGroupCo()
	UISpriteSetMgr.instance:setV1a7MainActivitySprite(arg_17_0._imagechess, arg_17_0.groupCo.resource)
	TaskDispatcher.runDelay(arg_17_0._triggerEnterAudio, arg_17_0, 0.5)
end

function var_0_0._triggerEnterAudio(arg_18_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_7Store.play_ui_jinye_chess_enter)
end

function var_0_0.onOpenFinish(arg_19_0)
	if arg_19_0.isFirstEnter then
		arg_19_0:triggerTalkByType(ActivityStoreConfig.BubbleTalkTriggerType.FirstEnterActivityStore)

		local var_19_0 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_7PlayedStoreGroupIdKey)
		local var_19_1 = PlayerPrefsHelper.getString(var_19_0, "")
		local var_19_2 = string.splitToNumber(var_19_1, var_0_0.SplitChar)

		table.insert(var_19_2, arg_19_0.groupCo.groupId)
		PlayerPrefsHelper.setString(var_19_0, table.concat(var_19_2, var_0_0.SplitChar))
	else
		arg_19_0:triggerTalkByType(ActivityStoreConfig.BubbleTalkTriggerType.EnterActivityStore)
	end
end

function var_0_0.initGroupCo(arg_20_0)
	local var_20_0 = ActivityStoreConfig.instance:getUnlockGroupList(arg_20_0.actId)
	local var_20_1 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_7PlayedStoreGroupIdKey)
	local var_20_2 = {}

	for iter_20_0, iter_20_1 in ipairs(string.split(PlayerPrefsHelper.getString(var_20_1, ""), var_0_0.SplitChar)) do
		local var_20_3 = tonumber(iter_20_1)

		table.insert(var_20_2, var_20_3)
	end

	local var_20_4 = #var_20_0

	for iter_20_2 = var_20_4, 1, -1 do
		local var_20_5 = var_20_0[iter_20_2]

		if not tabletool.indexOf(var_20_2, var_20_5.groupId) then
			arg_20_0.isFirstEnter = true
			arg_20_0.groupCo = var_20_5
			arg_20_0.talkCoList = ActivityStoreConfig.instance:getGroupTalkCoList(arg_20_0.groupCo.groupId)

			return
		end
	end

	arg_20_0.isFirstEnter = false

	math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 7)))

	arg_20_0.groupCo = var_20_0[math.random(var_20_4)]
	arg_20_0.talkCoList = ActivityStoreConfig.instance:getGroupTalkCoList(arg_20_0.groupCo.groupId)
end

function var_0_0.triggerTalkByTypeList(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = ActivityStoreConfig.BubbleTalkTriggerType.None

	tabletool.clear(arg_21_0.canTriggerList)

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.talkCoList) do
		if tabletool.indexOf(arg_21_1, iter_21_1.triggerType) and ActivityStoreConfig.instance:checkTalkCanTrigger(arg_21_0.actId, iter_21_1, arg_21_2) then
			table.insert(arg_21_0.canTriggerList, iter_21_1)

			if var_21_0 < iter_21_1.triggerType then
				var_21_0 = iter_21_1.triggerType
			end
		end
	end

	for iter_21_2 = #arg_21_0.canTriggerList, 1, -1 do
		if arg_21_0.canTriggerList[iter_21_2].triggerType ~= var_21_0 then
			GameUtil.tabletool_fastRemoveValueByPos(arg_21_0.canTriggerList, iter_21_2)
		end
	end

	if #arg_21_0.canTriggerList < 1 then
		return
	end

	arg_21_0:_triggerTalk(arg_21_0:getRandomTalkCo(arg_21_0.canTriggerList))
end

function var_0_0.triggerTalkByType(arg_22_0, arg_22_1, arg_22_2)
	tabletool.clear(arg_22_0.canTriggerList)

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.talkCoList) do
		if arg_22_1 == iter_22_1.triggerType and ActivityStoreConfig.instance:checkTalkCanTrigger(arg_22_0.actId, iter_22_1, arg_22_2) then
			table.insert(arg_22_0.canTriggerList, iter_22_1)
		end
	end

	if #arg_22_0.canTriggerList < 1 then
		return
	end

	arg_22_0:_triggerTalk(arg_22_0:getRandomTalkCo(arg_22_0.canTriggerList))
end

function var_0_0.getRandomTalkCo(arg_23_0, arg_23_1)
	local var_23_0 = #arg_23_1

	if var_23_0 == 1 then
		return arg_23_1[1]
	end

	local var_23_1 = 0

	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		var_23_1 = var_23_1 + iter_23_1.weight
	end

	local var_23_2 = math.random(var_23_1)
	local var_23_3 = 0

	for iter_23_2, iter_23_3 in ipairs(arg_23_1) do
		var_23_3 = var_23_3 + iter_23_3.weight

		if var_23_2 <= var_23_3 then
			return iter_23_3
		end
	end

	return arg_23_1[var_23_0]
end

function var_0_0._triggerTalk(arg_24_0, arg_24_1)
	local var_24_0 = Time.time

	if var_24_0 - arg_24_0.lastTriggerTime < var_0_0.TalkMinTriggerDuration then
		return
	end

	arg_24_0:buildStepCoList(arg_24_1)
	TaskDispatcher.cancelTask(arg_24_0.playNextStep, arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0.onFinishTalk, arg_24_0)
	gohelper.setActive(arg_24_0._goTalk, true)
	gohelper.setActive(arg_24_0._goArrowTip, false)

	arg_24_0._txttalk.text = ""
	arg_24_0.lastTriggerTime = var_24_0
	arg_24_0.lastSpawnTime = var_24_0 - var_0_0.TextSpawnInterval

	arg_24_0:playStep(1)

	arg_24_0.start = true
	arg_24_0.waitFinishTalk = false
	arg_24_0.waitPlayNextStep = false
end

function var_0_0.playStep(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.triggerStepList[arg_25_1]

	if not var_25_0 then
		return
	end

	TaskDispatcher.cancelTask(arg_25_0.stopChessAnim, arg_25_0)
	TaskDispatcher.runRepeat(arg_25_0.stopChessAnim, arg_25_0, var_0_0.ChessJumpAnimDuration)
	arg_25_0.chessAnim:Play("jump")
	gohelper.setActive(arg_25_0._godot, true)

	arg_25_0.currentCharIndex = 1
	arg_25_0.currentStepIndex = arg_25_1
	arg_25_0.content = var_25_0.content
	arg_25_0.contentLen = utf8.len(arg_25_0.content)

	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_7Store.play_ui_jinye_chess_talk)
end

function var_0_0.buildStepCoList(arg_26_0, arg_26_1)
	tabletool.clear(arg_26_0.triggerStepList)

	local var_26_0 = lua_activity107_bubble_talk_step.configDict[arg_26_1.id]

	for iter_26_0, iter_26_1 in pairs(var_26_0) do
		table.insert(arg_26_0.triggerStepList, iter_26_1)
	end

	if #arg_26_0.triggerStepList > 1 then
		table.sort(arg_26_0.triggerStepList, var_0_0.sortStep)
	end
end

function var_0_0.stopChessAnim(arg_27_0)
	if arg_27_0.waitPlayNextStep or arg_27_0.waitFinishTalk then
		arg_27_0.chessAnim:Play("idle")
		gohelper.setActive(arg_27_0._godot, false)
		TaskDispatcher.cancelTask(arg_27_0.stopChessAnim, arg_27_0)
	end
end

function var_0_0.onClose(arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0.stopChessAnim, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0.playNextStep, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0.onFinishTalk, arg_28_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_7Store.stop_ui_jinye_chess_talk)
	TaskDispatcher.cancelTask(arg_28_0._triggerEnterAudio, arg_28_0)

	if arg_28_0.updateHandle then
		UpdateBeat:RemoveListener(arg_28_0.updateHandle)
	end

	if arg_28_0.lateUpdateHandle then
		UpdateBeat:RemoveListener(arg_28_0.lateUpdateHandle)
	end

	arg_28_0.closed = true
end

function var_0_0.onDestroyView(arg_29_0)
	arg_29_0.stageClick:RemoveClickListener()
	arg_29_0.talkTextClick:RemoveClickListener()
end

function var_0_0.sortStep(arg_30_0, arg_30_1)
	return arg_30_0.step < arg_30_1.step
end

return var_0_0
