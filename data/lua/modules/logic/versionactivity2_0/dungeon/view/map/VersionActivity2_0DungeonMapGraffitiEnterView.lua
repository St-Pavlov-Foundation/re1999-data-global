module("modules.logic.versionactivity2_0.dungeon.view.map.VersionActivity2_0DungeonMapGraffitiEnterView", package.seeall)

slot0 = class("VersionActivity2_0DungeonMapGraffitiEnterView", BaseView)

function slot0.onInitView(slot0)
	slot0._gorole1 = gohelper.findChild(slot0.viewGO, "root/role/#go_role1")
	slot0._gorole2 = gohelper.findChild(slot0.viewGO, "root/role/#go_role2")
	slot0._gorole3 = gohelper.findChild(slot0.viewGO, "root/role/#go_role3")
	slot0._gorole4 = gohelper.findChild(slot0.viewGO, "root/role/#go_role4")
	slot0._btnenterGraffiti = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_enterGraffiti")
	slot0._btnenterGraffiti2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_enterGraffiti2")
	slot0._btnback = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_back")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "root/#go_topleft")
	slot0._gograffitiReddot = gohelper.findChild(slot0.viewGO, "root/#btn_enterGraffiti/#go_graffitiReddot")
	slot0._gobackReddot = gohelper.findChild(slot0.viewGO, "root/#btn_back/#go_backReddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnenterGraffiti:AddClickListener(slot0._btnenterGraffitiOnClick, slot0)
	slot0._btnenterGraffiti2:AddClickListener(slot0._btnenterGraffitiOnClick, slot0)
	slot0._btnback:AddClickListener(slot0._btnbackOnClick, slot0)
	slot0:addEventCb(Activity161Controller.instance, Activity161Event.SetGraffitiMapSceneCanvas, slot0.setCanvasView, slot0)
	slot0:addEventCb(Activity161Controller.instance, Activity161Event.OpenGuideDialogue, slot0.openGuideDialogue, slot0)
	slot0:addEventCb(Activity161Controller.instance, Activity161Event.EnterGraffitiView, slot0._btnenterGraffitiOnClick, slot0)
	slot0:addEventCb(Activity161Controller.instance, Activity161Event.CloseRestaurantWithEffect, slot0.closeViewWithEffect, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnenterGraffiti:RemoveClickListener()
	slot0._btnenterGraffiti2:RemoveClickListener()
	slot0._btnback:RemoveClickListener()
	slot0:removeEventCb(Activity161Controller.instance, Activity161Event.SetGraffitiMapSceneCanvas, slot0.setCanvasView, slot0)
	slot0:removeEventCb(Activity161Controller.instance, Activity161Event.OpenGuideDialogue, slot0.openGuideDialogue, slot0)
	slot0:removeEventCb(Activity161Controller.instance, Activity161Event.EnterGraffitiView, slot0._btnenterGraffitiOnClick, slot0)
	slot0:removeEventCb(Activity161Controller.instance, Activity161Event.CloseRestaurantWithEffect, slot0.closeViewWithEffect, slot0)
end

slot0.TextShowInterval = 0.06
slot0.TalkStepShowInterval = 1
slot0.TalkFinishTime = 2
slot0.ScrollTalkMargin = {
	Top = 10,
	Bottom = 20
}
slot0.TextMaxHeight = 200
slot0.TipHeight = 10

function slot0._btnenterGraffitiOnClick(slot0)
	if VersionActivity2_0DungeonModel.instance:isDraggingMapState() then
		return
	end

	Activity161Controller.instance:openGraffitiView({
		actId = slot0.actId
	})
end

function slot0._btnbackOnClick(slot0)
	Activity161Controller.instance:dispatchEvent(Activity161Event.CloseGraffitiEnterView)

	slot0.isClickBack = true

	if VersionActivity2_0DungeonModel.instance:getCurNeedUnlockGraffitiElement() then
		VersionActivity2_0DungeonController.instance:dispatchEvent(VersionActivity2_0DungeonEvent.FocusElement, slot1)
	else
		VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnActivityDungeonMoChange)
	end

	slot0:closeThis()
end

function slot0.openGuideDialogue(slot0, slot1)
	VersionActivity2_0DungeonController.instance:openDialogueView(tonumber(slot1))
end

function slot0.setCanvasView(slot0, slot1)
	slot0.mapCfg = slot1.mapConfig
	slot0.canvasGO = slot1.canvasGO
	slot0.sceneGO = slot1.sceneGo

	gohelper.addChild(slot0.canvasGO, slot0.viewGO)
end

function slot0._editableInitView(slot0)
	slot0.actId = Activity161Model.instance:getActId()
	slot0.roleTab = slot0:getUserDataTb_()
	slot0.dialogMap = {}
	slot0.isStartTalk = false
	slot0.isClickBack = false

	RedDotController.instance:addRedDot(slot0._gobackReddot, RedDotEnum.DotNode.V2a0DungeonHasUnDoElement, nil, slot0.checkHasUnDoElement, slot0)
	RedDotController.instance:addMultiRedDot(slot0._gograffitiReddot, {
		{
			id = RedDotEnum.DotNode.V2a0GraffitiReward,
			uid = slot0.actId
		},
		{
			id = RedDotEnum.DotNode.V2a0GraffitiUnlock,
			uid = slot0.actId
		}
	})
end

function slot0.checkHasUnDoElement(slot0, slot1)
	slot1:defaultRefreshDot()

	if not slot1.show and VersionActivity2_0DungeonModel.instance:getCurNeedUnlockGraffitiElement() then
		slot1.show = true

		slot1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function slot0.onOpen(slot0)
	VersionActivity2_0DungeonModel.instance:setOpeningGraffitiEntrance(false)
	slot0:initRoleComp()
	slot0:initDialog()
	slot0:startTalk()
end

function slot0.initRoleComp(slot0)
	for slot4 = 1, 4 do
		slot5 = {
			go = slot0["_gorole" .. slot4]
		}
		slot5.canvasGroup = slot5.go:GetComponent(gohelper.Type_CanvasGroup)
		slot5.gotalkDot = gohelper.findChild(slot5.go, "vx_pot")
		slot5.gotalk = gohelper.findChild(slot5.go, "go_talk")
		slot5.gotalkRect = slot5.gotalk:GetComponent(gohelper.Type_RectTransform)
		slot5.scrolltalk = gohelper.findChildScrollRect(slot5.go, "go_talk/Scroll View")
		slot5.txttalk = gohelper.findChildText(slot5.go, "go_talk/Scroll View/Viewport/Content/txt_talk")
		slot5.imgchess = gohelper.findChildImage(slot5.go, "#chess/image_chess")
		slot0.roleTab[slot4] = slot5

		UISpriteSetMgr.instance:setV2a0DungeonSprite(slot5.imgchess, "v2a0_dungeon_chess_" .. slot4)

		slot7 = string.splitToNumber(Activity161Config.instance:getChessConfig(slot4).pos, "#")

		recthelper.setAnchor(slot5.go.transform, slot7[1], slot7[2])
		gohelper.setActive(slot5.gotalk, false)
		gohelper.setActive(slot5.gotalkDot, false)
	end

	gohelper.setActive(slot0.roleTab[Activity161Enum.npcRole].go, false)
end

function slot0.initDialog(slot0)
	slot0.dialogState, slot0.recentFinishDialogMO = Activity161Controller.instance:checkRencentGraffitiHasDialog()

	if slot0:canDialog() then
		slot0.dialogMap = Activity161Config.instance:getAllDialogMapCoByGraoupId(slot0.recentFinishDialogMO.config.dialogGroupId)

		for slot5, slot6 in pairs(slot0.dialogMap) do
			if Activity161Enum.npcRole <= slot6.chessId then
				slot7 = Activity161Config.instance:getChessConfig(slot6.chessId)

				UISpriteSetMgr.instance:setV2a0DungeonSprite(slot0.roleTab[Activity161Enum.npcRole].imgchess, slot7.resource)

				slot8 = string.splitToNumber(slot7.pos, "#")

				recthelper.setAnchor(slot0.roleTab[Activity161Enum.npcRole].go.transform, slot8[1], slot8[2])
				gohelper.setActive(slot0.roleTab[Activity161Enum.npcRole].go, true)

				break
			end
		end
	end
end

function slot0.canDialog(slot0)
	return not slot0.dialogState and slot0.recentFinishDialogMO
end

function slot0.startTalk(slot0)
	if slot0:canDialog() then
		slot0.isStartTalk = true
		slot0.curStepIndex = 1
		slot0.curCharIndex = 0
		slot0.lastShowTime = Time.time - uv0.TextShowInterval
		slot0.dialogConfig = slot0.dialogMap[slot0.curStepIndex]
		slot0.dialogLength = utf8.len(slot0.dialogConfig.dialog)

		slot0:initUpdateBeat()
	else
		slot0.isStartTalk = false
	end
end

function slot0.initUpdateBeat(slot0)
	slot0.updateHandle = UpdateBeat:CreateListener(slot0._onTalkFrame, slot0)

	UpdateBeat:AddListener(slot0.updateHandle)

	slot0.lateUpdateHandle = UpdateBeat:CreateListener(slot0._onTalkFrameLateUpdate, slot0)

	UpdateBeat:AddListener(slot0.lateUpdateHandle)
end

function slot0._onTalkFrame(slot0)
	if slot0.closedView then
		return
	end

	if not slot0.isStartTalk then
		return
	end

	if slot0.waitPlayNextStep or slot0.waitFinishTalk then
		return
	end

	if Time.time - slot0.lastShowTime < uv0.TextShowInterval then
		return
	end

	slot0:showTalkContent()
end

function slot0.showTalkContent(slot0)
	if slot0.closedView then
		return
	end

	slot0.lastShowTime = Time.time
	slot0.curCharIndex = slot0.curCharIndex + 1
	slot0.curChessId = Mathf.Min(slot0.dialogConfig.chessId, Activity161Enum.npcRole)

	gohelper.setActive(slot0.roleTab[slot0.curChessId].gotalk, true)
	gohelper.setActive(slot0.roleTab[slot0.curChessId].gotalkDot, true)

	slot0.roleTab[slot0.curChessId].txttalk.text = utf8.sub(slot0.dialogConfig.dialog, 1, slot0.curCharIndex)
	slot0.roleTab[slot0.curChessId].scrolltalk.verticalNormalizedPosition = 0
	slot0.isDirty = true

	if slot0.curCharIndex == slot0.dialogLength + 1 then
		if slot0.dialogMap[slot0.curStepIndex + 1] then
			slot0.waitPlayNextStep = true

			TaskDispatcher.runDelay(slot0.playNextStep, slot0, uv0.TalkStepShowInterval)
		else
			slot0.waitFinishTalk = true

			TaskDispatcher.runDelay(slot0.onFinishTalk, slot0, uv0.TalkFinishTime)
		end
	end
end

function slot0.playNextStep(slot0)
	slot0.waitPlayNextStep = false
	slot0.curCharIndex = 0
	slot0.curStepIndex = slot0.curStepIndex + 1
	slot0.dialogConfig = slot0.dialogMap[slot0.curStepIndex]
	slot0.dialogLength = utf8.len(slot0.dialogConfig.dialog)

	slot0:hideAllTalk()
end

function slot0.onFinishTalk(slot0)
	slot0.waitFinishTalk = false
	slot0.waitPlayNextStep = false
	slot0.isStartTalk = false
	slot0.lastShowTime = 0
	slot0.curCharIndex = 0
	slot0.curStepIndex = 1

	slot0:hideAllTalk()
	gohelper.setActive(slot0.roleTab[Activity161Enum.npcRole].go, false)
	slot0:removeUpdateBeat()
end

function slot0.hideAllTalk(slot0)
	for slot4 = 1, 4 do
		gohelper.setActive(slot0.roleTab[slot4].gotalkDot, false)
		gohelper.setActive(slot0.roleTab[slot4].gotalk, false)
	end
end

function slot0._onTalkFrameLateUpdate(slot0)
	if slot0.closedView then
		return
	end

	if not slot0.isStartTalk then
		return
	end

	if slot0.waitPlayNextStep or slot0.waitFinishTalk then
		return
	end

	if not slot0.isDirty then
		return
	end

	slot0.isDirty = false
	slot1 = 0
	slot3 = uv0.ScrollTalkMargin.Top + uv0.ScrollTalkMargin.Bottom

	if slot0.waitPlayNextStep then
		slot1 = (uv0.TextMaxHeight < slot0.roleTab[slot0.curChessId].txttalk.preferredHeight and uv0.TextMaxHeight + slot3 or slot2 + slot3) + uv0.TipHeight
	end

	recthelper.setHeight(slot0.roleTab[slot0.curChessId].gotalkRect, slot1)
end

function slot0.onClose(slot0)
	Activity161Controller.instance:dispatchEvent(Activity161Event.CloseGraffitiEnterView)
	Activity161Controller.instance:saveRecentGraffitiDialog()
	slot0:removeUpdateBeat()
	TaskDispatcher.cancelTask(slot0.playNextStep, slot0)
	TaskDispatcher.cancelTask(slot0.onFinishTalk, slot0)

	slot0.closedView = true

	VersionActivity2_0DungeonModel.instance:setMapNeedTweenState(false)

	if not slot0.isClickBack then
		VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnActivityDungeonMoChange)
	end

	VersionActivity2_0DungeonModel.instance:setOpenGraffitiEntrance(false)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
end

function slot0.closeViewWithEffect(slot0)
	Activity161Controller.instance:dispatchEvent(Activity161Event.PlayExcessiveEffect)
	TaskDispatcher.runDelay(slot0.closeThis, slot0, 0.5)
end

function slot0.removeUpdateBeat(slot0)
	if slot0.updateHandle then
		UpdateBeat:RemoveListener(slot0.updateHandle)
	end

	if slot0.lateUpdateHandle then
		UpdateBeat:RemoveListener(slot0.lateUpdateHandle)
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
