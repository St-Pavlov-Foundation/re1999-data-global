module("modules.logic.versionactivity1_7.dungeon.view.store.VersionActivity1_7StoreTalk", package.seeall)

slot0 = class("VersionActivity1_7StoreTalk", BaseView)

function slot0.onInitView(slot0)
	slot0._gostagearea = gohelper.findChild(slot0.viewGO, "#go_stagearea")
	slot0._imagechess = gohelper.findChildImage(slot0.viewGO, "Right/#chess/#image_chess")
	slot0._gochess = gohelper.findChild(slot0.viewGO, "Right/#chess")
	slot0._godot = gohelper.findChild(slot0.viewGO, "Right/vx_pot")
	slot0._goTalk = gohelper.findChild(slot0.viewGO, "Right/#go_talk")
	slot0._goArrowTip = gohelper.findChild(slot0.viewGO, "Right/#go_talk/#go_ArrowTips")
	slot0._scrollTalk = gohelper.findChildScrollRect(slot0.viewGO, "Right/#go_talk/Scroll View")
	slot0._txttalk = gohelper.findChildText(slot0.viewGO, "Right/#go_talk/Scroll View/Viewport/Content/#txt_talk")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot0.TalkMinTriggerDuration = 2
slot0.TalkStepShowDuration = 2
slot0.TalkTxtShowDuration = 6
slot0.TextSpawnInterval = 0.06
slot0.ChessJumpAnimDuration = 1.167
slot0.ScrollTalkMargin = {
	Top = 10,
	Bottom = 20
}
slot0.TextMaxHeight = 200
slot0.TipHeight = 10
slot0.SplitChar = "|"

function slot0.onClickStage(slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_7Store.play_ui_jinye_click_stage)
	slot0:triggerTalkByType(ActivityStoreConfig.BubbleTalkTriggerType.ClickStageArea)
end

function slot0.onClickText(slot0)
	if slot0.waitFinishTalk then
		return
	end

	if slot0.waitPlayNextStep then
		TaskDispatcher.cancelTask(slot0.playNextStep, slot0)
		slot0:playNextStep()

		return
	end

	if slot0.start then
		slot0.currentCharIndex = slot0.contentLen

		slot0:_tickContent()
	end
end

function slot0._editableInitView(slot0)
	slot0._scrollTalk.verticalNormalizedPosition = 1
	slot0.lastTriggerTime = -uv0.TalkMinTriggerDuration
	slot0.canTriggerList = {}
	slot0.tempTypeList = {}
	slot0.triggerStepList = {}
	slot0.actId = VersionActivity1_7Enum.ActivityId.DungeonStore
	slot0.stageClick = gohelper.getClickWithDefaultAudio(slot0._gostagearea)

	slot0.stageClick:AddClickListener(slot0.onClickStage, slot0)

	slot0.talkTextClick = gohelper.getClickWithDefaultAudio(slot0._goTalk)

	slot0.talkTextClick:AddClickListener(slot0.onClickText, slot0)

	slot0.rectTrTalk = slot0._goTalk:GetComponent(gohelper.Type_RectTransform)
	slot0.rectTrContent = gohelper.findChildComponent(slot0.viewGO, "Right/#go_talk/Scroll View/Viewport/Content", gohelper.Type_RectTransform)
	slot0.chessAnim = slot0._gochess:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(slot0._godot, false)
	gohelper.setActive(slot0._goTalk, false)
	gohelper.setActive(slot0._goArrowTip, false)
	slot0:initUpdateBeat()
	slot0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, slot0.onBuyGoodsSuccess, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0, LuaEventSystem.Low)
end

function slot0.initUpdateBeat(slot0)
	slot0.updateHandle = UpdateBeat:CreateListener(slot0._onFrame, slot0)

	UpdateBeat:AddListener(slot0.updateHandle)

	slot0.lateUpdateHandle = UpdateBeat:CreateListener(slot0._onFrameLateUpdate, slot0)

	UpdateBeat:AddListener(slot0.lateUpdateHandle)
end

function slot0._onFrameLateUpdate(slot0)
	if slot0.closed then
		return
	end

	if not slot0.start then
		return
	end

	if slot0.needSetVerticalNormalized then
		slot0._scrollTalk.verticalNormalizedPosition = 0
		slot0.needSetVerticalNormalized = false
	end

	if not slot0.isDirty then
		return
	end

	slot0.isDirty = false
	slot0.needSetVerticalNormalized = true
	slot2 = uv0.ScrollTalkMargin.Top + uv0.ScrollTalkMargin.Bottom
	slot3 = nil

	if slot0.waitPlayNextStep then
		slot3 = (uv0.TextMaxHeight < slot0._txttalk.preferredHeight and uv0.TextMaxHeight + slot2 or slot1 + slot2) + uv0.TipHeight
	end

	recthelper.setHeight(slot0.rectTrTalk, slot3)
end

function slot0._onFrame(slot0)
	if slot0.closed then
		return
	end

	if not slot0.start then
		return
	end

	if slot0.waitPlayNextStep or slot0.waitFinishTalk then
		return
	end

	if Time.time - slot0.lastSpawnTime < uv0.TextSpawnInterval then
		return
	end

	slot0:_tickContent()
end

function slot0._tickContent(slot0)
	if slot0.closed then
		return
	end

	slot0.lastSpawnTime = Time.time
	slot0.currentCharIndex = slot0.currentCharIndex + 1
	slot0._txttalk.text = utf8.sub(slot0.content, 1, slot0.currentCharIndex)
	slot0.isDirty = true

	if slot0.currentCharIndex == slot0.contentLen + 1 then
		if slot0.triggerStepList[slot0.currentStepIndex + 1] then
			slot0:startWaitPlayNextStep()
			TaskDispatcher.runDelay(slot0.playNextStep, slot0, uv0.TalkStepShowDuration)
		else
			slot0:startWaitFinishTalk()
			TaskDispatcher.runDelay(slot0.onFinishTalk, slot0, uv0.TalkTxtShowDuration)
		end
	end
end

function slot0.startWaitFinishTalk(slot0)
	slot0.waitFinishTalk = true
end

function slot0.startWaitPlayNextStep(slot0)
	slot0.waitPlayNextStep = true

	gohelper.setActive(slot0._goArrowTip, true)
end

function slot0.onFinishTalk(slot0)
	if slot0._scrollTalk then
		slot0._scrollTalk.verticalNormalizedPosition = 0
	end

	slot0.lastSpawnTime = nil
	slot0.currentCharIndex = nil
	slot0.currentStepIndex = nil
	slot0.content = nil
	slot0.start = false
	slot0.waitFinishTalk = false

	gohelper.setActive(slot0._goTalk, false)
end

function slot0.playNextStep(slot0)
	slot0:playStep(slot0.currentStepIndex + 1)

	slot0.waitPlayNextStep = false

	gohelper.setActive(slot0._goArrowTip, false)
end

function slot0.onCloseViewFinish(slot0, slot1)
	if slot1 ~= ViewName.CommonPropView then
		return
	end

	if not slot0.buyGoodsId then
		return
	end

	tabletool.clear(slot0.tempTypeList)
	table.insert(slot0.tempTypeList, ActivityStoreConfig.BubbleTalkTriggerType.BuyGoodsByRare)
	table.insert(slot0.tempTypeList, ActivityStoreConfig.BubbleTalkTriggerType.BuyGoodsById)

	if lua_activity107.configDict[slot0.actId][slot0.buyGoodsId].maxBuyCount ~= 0 and slot2.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(slot0.actId, slot2.id) < 1 then
		table.insert(slot0.tempTypeList, ActivityStoreConfig.BubbleTalkTriggerType.SellOutGoodsByRare)
		table.insert(slot0.tempTypeList, ActivityStoreConfig.BubbleTalkTriggerType.SellOutGoodsById)
	end

	slot0:triggerTalkByTypeList(slot0.tempTypeList, slot0.buyGoodsId)

	slot0.buyGoodsId = nil
end

function slot0.onBuyGoodsSuccess(slot0, slot1, slot2)
	if slot0.actId ~= slot1 then
		return
	end

	slot0.buyGoodsId = slot2
end

function slot0.onOpen(slot0)
	slot0:initGroupCo()
	UISpriteSetMgr.instance:setV1a7MainActivitySprite(slot0._imagechess, slot0.groupCo.resource)
	TaskDispatcher.runDelay(slot0._triggerEnterAudio, slot0, 0.5)
end

function slot0._triggerEnterAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_7Store.play_ui_jinye_chess_enter)
end

function slot0.onOpenFinish(slot0)
	if slot0.isFirstEnter then
		slot0:triggerTalkByType(ActivityStoreConfig.BubbleTalkTriggerType.FirstEnterActivityStore)

		slot1 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_7PlayedStoreGroupIdKey)
		slot3 = string.splitToNumber(PlayerPrefsHelper.getString(slot1, ""), uv0.SplitChar)

		table.insert(slot3, slot0.groupCo.groupId)
		PlayerPrefsHelper.setString(slot1, table.concat(slot3, uv0.SplitChar))
	else
		slot0:triggerTalkByType(ActivityStoreConfig.BubbleTalkTriggerType.EnterActivityStore)
	end
end

function slot0.initGroupCo(slot0)
	slot1 = ActivityStoreConfig.instance:getUnlockGroupList(slot0.actId)
	slot8 = ""
	slot7 = uv0.SplitChar

	for slot7, slot8 in ipairs(string.split(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_7PlayedStoreGroupIdKey), slot8), slot7)) do
		table.insert({}, tonumber(slot8))
	end

	for slot8 = #slot1, 1, -1 do
		if not tabletool.indexOf(slot3, slot1[slot8].groupId) then
			slot0.isFirstEnter = true
			slot0.groupCo = slot9
			slot0.talkCoList = ActivityStoreConfig.instance:getGroupTalkCoList(slot0.groupCo.groupId)

			return
		end
	end

	slot0.isFirstEnter = false

	math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 7)))

	slot0.groupCo = slot1[math.random(slot4)]
	slot0.talkCoList = ActivityStoreConfig.instance:getGroupTalkCoList(slot0.groupCo.groupId)
end

function slot0.triggerTalkByTypeList(slot0, slot1, slot2)
	tabletool.clear(slot0.canTriggerList)

	for slot7, slot8 in ipairs(slot0.talkCoList) do
		if tabletool.indexOf(slot1, slot8.triggerType) and ActivityStoreConfig.instance:checkTalkCanTrigger(slot0.actId, slot8, slot2) then
			table.insert(slot0.canTriggerList, slot8)

			if ActivityStoreConfig.BubbleTalkTriggerType.None < slot8.triggerType then
				slot3 = slot8.triggerType
			end
		end
	end

	for slot7 = #slot0.canTriggerList, 1, -1 do
		if slot0.canTriggerList[slot7].triggerType ~= slot3 then
			GameUtil.tabletool_fastRemoveValueByPos(slot0.canTriggerList, slot7)
		end
	end

	if #slot0.canTriggerList < 1 then
		return
	end

	slot0:_triggerTalk(slot0:getRandomTalkCo(slot0.canTriggerList))
end

function slot0.triggerTalkByType(slot0, slot1, slot2)
	tabletool.clear(slot0.canTriggerList)

	for slot6, slot7 in ipairs(slot0.talkCoList) do
		if slot1 == slot7.triggerType and ActivityStoreConfig.instance:checkTalkCanTrigger(slot0.actId, slot7, slot2) then
			table.insert(slot0.canTriggerList, slot7)
		end
	end

	if #slot0.canTriggerList < 1 then
		return
	end

	slot0:_triggerTalk(slot0:getRandomTalkCo(slot0.canTriggerList))
end

function slot0.getRandomTalkCo(slot0, slot1)
	if #slot1 == 1 then
		return slot1[1]
	end

	for slot7, slot8 in ipairs(slot1) do
		slot3 = 0 + slot8.weight
	end

	for slot9, slot10 in ipairs(slot1) do
		if math.random(slot3) <= 0 + slot10.weight then
			return slot10
		end
	end

	return slot1[slot2]
end

function slot0._triggerTalk(slot0, slot1)
	if Time.time - slot0.lastTriggerTime < uv0.TalkMinTriggerDuration then
		return
	end

	slot0:buildStepCoList(slot1)
	TaskDispatcher.cancelTask(slot0.playNextStep, slot0)
	TaskDispatcher.cancelTask(slot0.onFinishTalk, slot0)
	gohelper.setActive(slot0._goTalk, true)
	gohelper.setActive(slot0._goArrowTip, false)

	slot0._txttalk.text = ""
	slot0.lastTriggerTime = slot2
	slot0.lastSpawnTime = slot2 - uv0.TextSpawnInterval

	slot0:playStep(1)

	slot0.start = true
	slot0.waitFinishTalk = false
	slot0.waitPlayNextStep = false
end

function slot0.playStep(slot0, slot1)
	if not slot0.triggerStepList[slot1] then
		return
	end

	TaskDispatcher.cancelTask(slot0.stopChessAnim, slot0)
	TaskDispatcher.runRepeat(slot0.stopChessAnim, slot0, uv0.ChessJumpAnimDuration)
	slot0.chessAnim:Play("jump")
	gohelper.setActive(slot0._godot, true)

	slot0.currentCharIndex = 1
	slot0.currentStepIndex = slot1
	slot0.content = slot2.content
	slot0.contentLen = utf8.len(slot0.content)

	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_7Store.play_ui_jinye_chess_talk)
end

function slot0.buildStepCoList(slot0, slot1)
	tabletool.clear(slot0.triggerStepList)

	for slot6, slot7 in pairs(lua_activity107_bubble_talk_step.configDict[slot1.id]) do
		table.insert(slot0.triggerStepList, slot7)
	end

	if #slot0.triggerStepList > 1 then
		table.sort(slot0.triggerStepList, uv0.sortStep)
	end
end

function slot0.stopChessAnim(slot0)
	if slot0.waitPlayNextStep or slot0.waitFinishTalk then
		slot0.chessAnim:Play("idle")
		gohelper.setActive(slot0._godot, false)
		TaskDispatcher.cancelTask(slot0.stopChessAnim, slot0)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.stopChessAnim, slot0)
	TaskDispatcher.cancelTask(slot0.playNextStep, slot0)
	TaskDispatcher.cancelTask(slot0.onFinishTalk, slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_7Store.stop_ui_jinye_chess_talk)
	TaskDispatcher.cancelTask(slot0._triggerEnterAudio, slot0)

	if slot0.updateHandle then
		UpdateBeat:RemoveListener(slot0.updateHandle)
	end

	if slot0.lateUpdateHandle then
		UpdateBeat:RemoveListener(slot0.lateUpdateHandle)
	end

	slot0.closed = true
end

function slot0.onDestroyView(slot0)
	slot0.stageClick:RemoveClickListener()
	slot0.talkTextClick:RemoveClickListener()
end

function slot0.sortStep(slot0, slot1)
	return slot0.step < slot1.step
end

return slot0
