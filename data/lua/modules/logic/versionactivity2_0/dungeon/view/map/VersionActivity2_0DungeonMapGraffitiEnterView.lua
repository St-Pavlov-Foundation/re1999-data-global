module("modules.logic.versionactivity2_0.dungeon.view.map.VersionActivity2_0DungeonMapGraffitiEnterView", package.seeall)

local var_0_0 = class("VersionActivity2_0DungeonMapGraffitiEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorole1 = gohelper.findChild(arg_1_0.viewGO, "root/role/#go_role1")
	arg_1_0._gorole2 = gohelper.findChild(arg_1_0.viewGO, "root/role/#go_role2")
	arg_1_0._gorole3 = gohelper.findChild(arg_1_0.viewGO, "root/role/#go_role3")
	arg_1_0._gorole4 = gohelper.findChild(arg_1_0.viewGO, "root/role/#go_role4")
	arg_1_0._btnenterGraffiti = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_enterGraffiti")
	arg_1_0._btnenterGraffiti2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_enterGraffiti2")
	arg_1_0._btnback = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_back")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")
	arg_1_0._gograffitiReddot = gohelper.findChild(arg_1_0.viewGO, "root/#btn_enterGraffiti/#go_graffitiReddot")
	arg_1_0._gobackReddot = gohelper.findChild(arg_1_0.viewGO, "root/#btn_back/#go_backReddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnenterGraffiti:AddClickListener(arg_2_0._btnenterGraffitiOnClick, arg_2_0)
	arg_2_0._btnenterGraffiti2:AddClickListener(arg_2_0._btnenterGraffitiOnClick, arg_2_0)
	arg_2_0._btnback:AddClickListener(arg_2_0._btnbackOnClick, arg_2_0)
	arg_2_0:addEventCb(Activity161Controller.instance, Activity161Event.SetGraffitiMapSceneCanvas, arg_2_0.setCanvasView, arg_2_0)
	arg_2_0:addEventCb(Activity161Controller.instance, Activity161Event.OpenGuideDialogue, arg_2_0.openGuideDialogue, arg_2_0)
	arg_2_0:addEventCb(Activity161Controller.instance, Activity161Event.EnterGraffitiView, arg_2_0._btnenterGraffitiOnClick, arg_2_0)
	arg_2_0:addEventCb(Activity161Controller.instance, Activity161Event.CloseRestaurantWithEffect, arg_2_0.closeViewWithEffect, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnenterGraffiti:RemoveClickListener()
	arg_3_0._btnenterGraffiti2:RemoveClickListener()
	arg_3_0._btnback:RemoveClickListener()
	arg_3_0:removeEventCb(Activity161Controller.instance, Activity161Event.SetGraffitiMapSceneCanvas, arg_3_0.setCanvasView, arg_3_0)
	arg_3_0:removeEventCb(Activity161Controller.instance, Activity161Event.OpenGuideDialogue, arg_3_0.openGuideDialogue, arg_3_0)
	arg_3_0:removeEventCb(Activity161Controller.instance, Activity161Event.EnterGraffitiView, arg_3_0._btnenterGraffitiOnClick, arg_3_0)
	arg_3_0:removeEventCb(Activity161Controller.instance, Activity161Event.CloseRestaurantWithEffect, arg_3_0.closeViewWithEffect, arg_3_0)
end

var_0_0.TextShowInterval = 0.06
var_0_0.TalkStepShowInterval = 1
var_0_0.TalkFinishTime = 2
var_0_0.ScrollTalkMargin = {
	Top = 10,
	Bottom = 20
}
var_0_0.TextMaxHeight = 200
var_0_0.TipHeight = 10

function var_0_0._btnenterGraffitiOnClick(arg_4_0)
	if VersionActivity2_0DungeonModel.instance:isDraggingMapState() then
		return
	end

	local var_4_0 = {
		actId = arg_4_0.actId
	}

	Activity161Controller.instance:openGraffitiView(var_4_0)
end

function var_0_0._btnbackOnClick(arg_5_0)
	Activity161Controller.instance:dispatchEvent(Activity161Event.CloseGraffitiEnterView)

	arg_5_0.isClickBack = true

	local var_5_0 = VersionActivity2_0DungeonModel.instance:getCurNeedUnlockGraffitiElement()

	if var_5_0 then
		VersionActivity2_0DungeonController.instance:dispatchEvent(VersionActivity2_0DungeonEvent.FocusElement, var_5_0)
	else
		VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnActivityDungeonMoChange)
	end

	arg_5_0:closeThis()
end

function var_0_0.openGuideDialogue(arg_6_0, arg_6_1)
	VersionActivity2_0DungeonController.instance:openDialogueView(tonumber(arg_6_1))
end

function var_0_0.setCanvasView(arg_7_0, arg_7_1)
	arg_7_0.mapCfg = arg_7_1.mapConfig
	arg_7_0.canvasGO = arg_7_1.canvasGO
	arg_7_0.sceneGO = arg_7_1.sceneGo

	gohelper.addChild(arg_7_0.canvasGO, arg_7_0.viewGO)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.actId = Activity161Model.instance:getActId()
	arg_8_0.roleTab = arg_8_0:getUserDataTb_()
	arg_8_0.dialogMap = {}
	arg_8_0.isStartTalk = false
	arg_8_0.isClickBack = false

	RedDotController.instance:addRedDot(arg_8_0._gobackReddot, RedDotEnum.DotNode.V2a0DungeonHasUnDoElement, nil, arg_8_0.checkHasUnDoElement, arg_8_0)

	local var_8_0 = {
		{
			id = RedDotEnum.DotNode.V2a0GraffitiReward,
			uid = arg_8_0.actId
		},
		{
			id = RedDotEnum.DotNode.V2a0GraffitiUnlock,
			uid = arg_8_0.actId
		}
	}

	RedDotController.instance:addMultiRedDot(arg_8_0._gograffitiReddot, var_8_0)
end

function var_0_0.checkHasUnDoElement(arg_9_0, arg_9_1)
	arg_9_1:defaultRefreshDot()

	if not arg_9_1.show and VersionActivity2_0DungeonModel.instance:getCurNeedUnlockGraffitiElement() then
		arg_9_1.show = true

		arg_9_1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function var_0_0.onOpen(arg_10_0)
	VersionActivity2_0DungeonModel.instance:setOpeningGraffitiEntrance(false)
	arg_10_0:initRoleComp()
	arg_10_0:initDialog()
	arg_10_0:startTalk()
end

function var_0_0.initRoleComp(arg_11_0)
	for iter_11_0 = 1, 4 do
		local var_11_0 = {
			go = arg_11_0["_gorole" .. iter_11_0]
		}

		var_11_0.canvasGroup = var_11_0.go:GetComponent(gohelper.Type_CanvasGroup)
		var_11_0.gotalkDot = gohelper.findChild(var_11_0.go, "vx_pot")
		var_11_0.gotalk = gohelper.findChild(var_11_0.go, "go_talk")
		var_11_0.gotalkRect = var_11_0.gotalk:GetComponent(gohelper.Type_RectTransform)
		var_11_0.scrolltalk = gohelper.findChildScrollRect(var_11_0.go, "go_talk/Scroll View")
		var_11_0.txttalk = gohelper.findChildText(var_11_0.go, "go_talk/Scroll View/Viewport/Content/txt_talk")
		var_11_0.imgchess = gohelper.findChildImage(var_11_0.go, "#chess/image_chess")
		arg_11_0.roleTab[iter_11_0] = var_11_0

		UISpriteSetMgr.instance:setV2a0DungeonSprite(var_11_0.imgchess, "v2a0_dungeon_chess_" .. iter_11_0)

		local var_11_1 = Activity161Config.instance:getChessConfig(iter_11_0)
		local var_11_2 = string.splitToNumber(var_11_1.pos, "#")

		recthelper.setAnchor(var_11_0.go.transform, var_11_2[1], var_11_2[2])
		gohelper.setActive(var_11_0.gotalk, false)
		gohelper.setActive(var_11_0.gotalkDot, false)
	end

	gohelper.setActive(arg_11_0.roleTab[Activity161Enum.npcRole].go, false)
end

function var_0_0.initDialog(arg_12_0)
	arg_12_0.dialogState, arg_12_0.recentFinishDialogMO = Activity161Controller.instance:checkRencentGraffitiHasDialog()

	if arg_12_0:canDialog() then
		local var_12_0 = arg_12_0.recentFinishDialogMO.config.dialogGroupId

		arg_12_0.dialogMap = Activity161Config.instance:getAllDialogMapCoByGraoupId(var_12_0)

		for iter_12_0, iter_12_1 in pairs(arg_12_0.dialogMap) do
			if iter_12_1.chessId >= Activity161Enum.npcRole then
				local var_12_1 = Activity161Config.instance:getChessConfig(iter_12_1.chessId)

				UISpriteSetMgr.instance:setV2a0DungeonSprite(arg_12_0.roleTab[Activity161Enum.npcRole].imgchess, var_12_1.resource)

				local var_12_2 = string.splitToNumber(var_12_1.pos, "#")

				recthelper.setAnchor(arg_12_0.roleTab[Activity161Enum.npcRole].go.transform, var_12_2[1], var_12_2[2])
				gohelper.setActive(arg_12_0.roleTab[Activity161Enum.npcRole].go, true)

				break
			end
		end
	end
end

function var_0_0.canDialog(arg_13_0)
	return not arg_13_0.dialogState and arg_13_0.recentFinishDialogMO
end

function var_0_0.startTalk(arg_14_0)
	if arg_14_0:canDialog() then
		arg_14_0.isStartTalk = true
		arg_14_0.curStepIndex = 1
		arg_14_0.curCharIndex = 0
		arg_14_0.lastShowTime = Time.time - var_0_0.TextShowInterval
		arg_14_0.dialogConfig = arg_14_0.dialogMap[arg_14_0.curStepIndex]
		arg_14_0.dialogLength = utf8.len(arg_14_0.dialogConfig.dialog)

		arg_14_0:initUpdateBeat()
	else
		arg_14_0.isStartTalk = false
	end
end

function var_0_0.initUpdateBeat(arg_15_0)
	arg_15_0.updateHandle = UpdateBeat:CreateListener(arg_15_0._onTalkFrame, arg_15_0)

	UpdateBeat:AddListener(arg_15_0.updateHandle)

	arg_15_0.lateUpdateHandle = UpdateBeat:CreateListener(arg_15_0._onTalkFrameLateUpdate, arg_15_0)

	UpdateBeat:AddListener(arg_15_0.lateUpdateHandle)
end

function var_0_0._onTalkFrame(arg_16_0)
	if arg_16_0.closedView then
		return
	end

	if not arg_16_0.isStartTalk then
		return
	end

	if arg_16_0.waitPlayNextStep or arg_16_0.waitFinishTalk then
		return
	end

	if Time.time - arg_16_0.lastShowTime < var_0_0.TextShowInterval then
		return
	end

	arg_16_0:showTalkContent()
end

function var_0_0.showTalkContent(arg_17_0)
	if arg_17_0.closedView then
		return
	end

	arg_17_0.lastShowTime = Time.time
	arg_17_0.curCharIndex = arg_17_0.curCharIndex + 1
	arg_17_0.curChessId = Mathf.Min(arg_17_0.dialogConfig.chessId, Activity161Enum.npcRole)

	gohelper.setActive(arg_17_0.roleTab[arg_17_0.curChessId].gotalk, true)
	gohelper.setActive(arg_17_0.roleTab[arg_17_0.curChessId].gotalkDot, true)

	arg_17_0.roleTab[arg_17_0.curChessId].txttalk.text = utf8.sub(arg_17_0.dialogConfig.dialog, 1, arg_17_0.curCharIndex)
	arg_17_0.roleTab[arg_17_0.curChessId].scrolltalk.verticalNormalizedPosition = 0
	arg_17_0.isDirty = true

	if arg_17_0.curCharIndex == arg_17_0.dialogLength + 1 then
		if arg_17_0.dialogMap[arg_17_0.curStepIndex + 1] then
			arg_17_0.waitPlayNextStep = true

			TaskDispatcher.runDelay(arg_17_0.playNextStep, arg_17_0, var_0_0.TalkStepShowInterval)
		else
			arg_17_0.waitFinishTalk = true

			TaskDispatcher.runDelay(arg_17_0.onFinishTalk, arg_17_0, var_0_0.TalkFinishTime)
		end
	end
end

function var_0_0.playNextStep(arg_18_0)
	arg_18_0.waitPlayNextStep = false
	arg_18_0.curCharIndex = 0
	arg_18_0.curStepIndex = arg_18_0.curStepIndex + 1
	arg_18_0.dialogConfig = arg_18_0.dialogMap[arg_18_0.curStepIndex]
	arg_18_0.dialogLength = utf8.len(arg_18_0.dialogConfig.dialog)

	arg_18_0:hideAllTalk()
end

function var_0_0.onFinishTalk(arg_19_0)
	arg_19_0.waitFinishTalk = false
	arg_19_0.waitPlayNextStep = false
	arg_19_0.isStartTalk = false
	arg_19_0.lastShowTime = 0
	arg_19_0.curCharIndex = 0
	arg_19_0.curStepIndex = 1

	arg_19_0:hideAllTalk()
	gohelper.setActive(arg_19_0.roleTab[Activity161Enum.npcRole].go, false)
	arg_19_0:removeUpdateBeat()
end

function var_0_0.hideAllTalk(arg_20_0)
	for iter_20_0 = 1, 4 do
		gohelper.setActive(arg_20_0.roleTab[iter_20_0].gotalkDot, false)
		gohelper.setActive(arg_20_0.roleTab[iter_20_0].gotalk, false)
	end
end

function var_0_0._onTalkFrameLateUpdate(arg_21_0)
	if arg_21_0.closedView then
		return
	end

	if not arg_21_0.isStartTalk then
		return
	end

	if arg_21_0.waitPlayNextStep or arg_21_0.waitFinishTalk then
		return
	end

	if not arg_21_0.isDirty then
		return
	end

	arg_21_0.isDirty = false

	local var_21_0 = 0
	local var_21_1 = arg_21_0.roleTab[arg_21_0.curChessId].txttalk.preferredHeight
	local var_21_2 = var_0_0.ScrollTalkMargin.Top + var_0_0.ScrollTalkMargin.Bottom

	if var_21_1 > var_0_0.TextMaxHeight then
		var_21_0 = var_0_0.TextMaxHeight + var_21_2
	else
		var_21_0 = var_21_1 + var_21_2
	end

	if arg_21_0.waitPlayNextStep then
		var_21_0 = var_21_0 + var_0_0.TipHeight
	end

	recthelper.setHeight(arg_21_0.roleTab[arg_21_0.curChessId].gotalkRect, var_21_0)
end

function var_0_0.onClose(arg_22_0)
	Activity161Controller.instance:dispatchEvent(Activity161Event.CloseGraffitiEnterView)
	Activity161Controller.instance:saveRecentGraffitiDialog()
	arg_22_0:removeUpdateBeat()
	TaskDispatcher.cancelTask(arg_22_0.playNextStep, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0.onFinishTalk, arg_22_0)

	arg_22_0.closedView = true

	VersionActivity2_0DungeonModel.instance:setMapNeedTweenState(false)

	if not arg_22_0.isClickBack then
		VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnActivityDungeonMoChange)
	end

	VersionActivity2_0DungeonModel.instance:setOpenGraffitiEntrance(false)
	TaskDispatcher.cancelTask(arg_22_0.closeThis, arg_22_0)
end

function var_0_0.closeViewWithEffect(arg_23_0)
	Activity161Controller.instance:dispatchEvent(Activity161Event.PlayExcessiveEffect)
	TaskDispatcher.runDelay(arg_23_0.closeThis, arg_23_0, 0.5)
end

function var_0_0.removeUpdateBeat(arg_24_0)
	if arg_24_0.updateHandle then
		UpdateBeat:RemoveListener(arg_24_0.updateHandle)
	end

	if arg_24_0.lateUpdateHandle then
		UpdateBeat:RemoveListener(arg_24_0.lateUpdateHandle)
	end
end

function var_0_0.onDestroyView(arg_25_0)
	return
end

return var_0_0
