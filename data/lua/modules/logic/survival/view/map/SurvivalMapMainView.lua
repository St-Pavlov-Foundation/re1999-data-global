module("modules.logic.survival.view.map.SurvivalMapMainView", package.seeall)

local var_0_0 = class("SurvivalMapMainView", SurvivalMapDragBaseView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._btnbag = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "BottomRight/#btn_bag")
	arg_1_0._gobagfull = gohelper.findChild(arg_1_0.viewGO, "BottomRight/#btn_bag/#go_overweight")
	arg_1_0._btnlog = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "BottomRight/#btn_log")
	arg_1_0._btnabort = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_abort")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_task")
	arg_1_0._btnteam = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_team")
	arg_1_0._txtTeamLv = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/#btn_team/go_level/#txt_level")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_equip")
	arg_1_0._goequipred = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_equip/go_arrow")
	arg_1_0._gotask = gohelper.findChild(arg_1_0.viewGO, "Left/#go_task")
	arg_1_0._txtTask = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/#go_task/TaskView/Viewport/Content/#txt_task")
	arg_1_0._viewAnim = gohelper.findChildAnim(arg_1_0.viewGO, "")
	arg_1_0._imageBlack = gohelper.findChildImage(arg_1_0.viewGO, "#image_black")
	arg_1_0.igoreViewList = {
		ViewName.SurvivalToastView,
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor,
		ViewName.GMGuideStatusView,
		ViewName.SurvivalCurrencyTipView,
		ViewName.SurvivalCommonTipsView
	}
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnabort:AddClickListener(arg_2_0._onClickAbort, arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._onClickTask, arg_2_0)
	arg_2_0._btnteam:AddClickListener(arg_2_0._onClickTeam, arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._onClickEquip, arg_2_0)
	arg_2_0._btnbag:AddClickListener(arg_2_0._onClickBag, arg_2_0)
	arg_2_0._btnlog:AddClickListener(arg_2_0._onClickLog, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapBagUpdate, arg_2_0._refreshBagFull, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnAttrUpdate, arg_2_0._refreshTeamLv, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnFollowTaskUpdate, arg_2_0._refreshCurTask, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipRedUpdate, arg_2_0.updateEquipRed, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnPlayerTornadoTransferBegin, arg_2_0.onPlayerTornadoTransferBegin, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnPlayerTornadoTransferEnd, arg_2_0.onPlayerTornadoTransferEnd, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.onFlowEnd, arg_2_0.checkPlaySpBlockAudio, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0.onRefreshViewState, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0.onRefreshViewState, arg_2_0)
	arg_2_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_2_0.refreshHelpBtnPos, arg_2_0)
	arg_2_0:addEventCb(GuideController.instance, GuideEvent.FinishGuideLastStep, arg_2_0.refreshHelpBtnPos, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnabort:RemoveClickListener()
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnteam:RemoveClickListener()
	arg_3_0._btnequip:RemoveClickListener()
	arg_3_0._btnbag:RemoveClickListener()
	arg_3_0._btnlog:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapBagUpdate, arg_3_0._refreshBagFull, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnAttrUpdate, arg_3_0._refreshTeamLv, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnFollowTaskUpdate, arg_3_0._refreshCurTask, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipRedUpdate, arg_3_0.updateEquipRed, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnPlayerTornadoTransferBegin, arg_3_0.onPlayerTornadoTransferBegin, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnPlayerTornadoTransferEnd, arg_3_0.onPlayerTornadoTransferEnd, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.onFlowEnd, arg_3_0.checkPlaySpBlockAudio, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0.onRefreshViewState, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0.onRefreshViewState, arg_3_0)
	arg_3_0:removeEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_3_0.refreshHelpBtnPos, arg_3_0)
	arg_3_0:removeEventCb(GuideController.instance, GuideEvent.FinishGuideLastStep, arg_3_0.refreshHelpBtnPos, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	var_0_0.super.onOpen(arg_4_0)

	arg_4_0._scale = 1

	local var_4_0 = SurvivalMapModel.instance:getSceneMo()

	arg_4_0._targetPos = Vector3(var_4_0.player:getWorldPos())

	SurvivalMapHelper.instance:setFocusPos(arg_4_0._targetPos.x, arg_4_0._targetPos.y, arg_4_0._targetPos.z)
	arg_4_0:_setScale(SurvivalMapModel.instance.save_mapScale, true)
	arg_4_0:_refreshBagFull()
	arg_4_0:_refreshCurTask()
	arg_4_0:_refreshTeamLv()
	arg_4_0:onRefreshViewState()
	arg_4_0:updateEquipRed()
	arg_4_0:refreshHelpBtnPos()
end

function var_0_0.refreshHelpBtnPos(arg_5_0)
	if HelpController.instance:checkGuideStepLock(HelpEnum.HelpId.Survival) then
		recthelper.setAnchorX(arg_5_0._btnabort.transform, 349.3)
	else
		recthelper.setAnchorX(arg_5_0._btnabort.transform, 215.1)
	end
end

function var_0_0.updateEquipRed(arg_6_0)
	gohelper.setActive(arg_6_0._goequipred, SurvivalEquipRedDotHelper.instance.reddotType >= 0)
end

function var_0_0.onRefreshViewState(arg_7_0)
	if arg_7_0._isTopView == nil then
		arg_7_0._isTopView = true
	end

	local var_7_0 = ViewHelper.instance:checkViewOnTheTop(arg_7_0.viewName, arg_7_0.igoreViewList)

	if var_7_0 == arg_7_0._isTopView then
		return
	end

	arg_7_0._isTopView = var_7_0

	arg_7_0._viewAnim:Play(arg_7_0._isTopView and "in" or "close", 0, 0)
end

function var_0_0._onClickAbort(arg_8_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalGiveUp, MsgBoxEnum.BoxType.Yes_No, arg_8_0._sendGiveUp, nil, nil, arg_8_0, nil, nil)
	SurvivalStatHelper.instance:statBtnClick("_onClickAbort", "SurvivalMapMainView")
end

function var_0_0._sendGiveUp(arg_9_0)
	SurvivalInteriorRpc.instance:sendSurvivalSceneGiveUp()
end

function var_0_0._onClickBag(arg_10_0)
	ViewMgr.instance:openView(ViewName.SurvivalMapBagView)
	SurvivalStatHelper.instance:statBtnClick("_onClickBag", "SurvivalMapMainView")
end

function var_0_0._onClickTask(arg_11_0)
	ViewMgr.instance:openView(ViewName.ShelterTaskView, {
		moduleId = SurvivalEnum.TaskModule.NormalTask
	})
	SurvivalStatHelper.instance:statBtnClick("_onClickTask", "SurvivalMapMainView")
end

function var_0_0._onClickTeam(arg_12_0)
	ViewMgr.instance:openView(ViewName.SurvivalMapTeamView)
	SurvivalStatHelper.instance:statBtnClick("_onClickTeam", "SurvivalMapMainView")
end

function var_0_0._onClickEquip(arg_13_0)
	SurvivalController.instance:openEquipView()
	SurvivalStatHelper.instance:statBtnClick("_onClickEquip", "SurvivalMapMainView")
end

function var_0_0._onClickLog(arg_14_0)
	SurvivalInteriorRpc.instance:sendSurvivalSceneOperationLog()
	SurvivalStatHelper.instance:statBtnClick("_onClickLog", "SurvivalMapMainView")
end

function var_0_0._refreshBagFull(arg_15_0)
	local var_15_0 = SurvivalMapHelper.instance:getBagMo()
	local var_15_1 = var_15_0.totalMass > var_15_0.maxWeightLimit + SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.AttrWeight)

	gohelper.setActive(arg_15_0._gobagfull, var_15_1)
end

function var_0_0._refreshCurTask(arg_16_0)
	local var_16_0 = SurvivalMapModel.instance:getSceneMo().mainTask
	local var_16_1 = var_16_0.taskId > 0 and SurvivalConfig.instance:getTaskCo(var_16_0.moduleId, var_16_0.taskId)

	gohelper.setActive(arg_16_0._gotask, var_16_1)

	if var_16_1 then
		arg_16_0._txtTask.text = var_16_1.desc2
	end
end

function var_0_0.calcSceneBoard(arg_17_0)
	local var_17_0 = SurvivalMapHelper.instance:getSceneCameraComp()

	arg_17_0._mapMinX = var_17_0.mapMinX
	arg_17_0._mapMaxX = var_17_0.mapMaxX
	arg_17_0._mapMinY = var_17_0.mapMinY
	arg_17_0._mapMaxY = var_17_0.mapMaxY
	arg_17_0._maxDis = var_17_0.maxDis
	arg_17_0._minDis = var_17_0.minDis
end

function var_0_0.onClickScene(arg_18_0, arg_18_1, arg_18_2)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_qiutu_general_click)

	local var_18_0 = {}

	arg_18_0.viewContainer:dispatchEvent(SurvivalEvent.OnClickSurvivalScene, arg_18_2, var_18_0)

	if var_18_0.use then
		return
	end

	local var_18_1 = SurvivalMapModel.instance:getSceneMo().player.pos

	if var_18_1 == arg_18_2 then
		SurvivalMapModel.instance:setShowTarget()

		if not SurvivalMapHelper.instance:isInFlow() then
			SurvivalMapHelper.instance:tryShowEventView(var_18_1)
		end

		return
	end

	if not SurvivalMapHelper.instance:isInFlow() and isDebugBuild and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
		local var_18_2 = SurvivalMapHelper.instance:getEntity(0)

		var_18_2:setPosAndDir(arg_18_2, var_18_2._unitMo.dir)
		GMRpc.instance:sendGMRequest("surPlayerMove " .. arg_18_2.q .. " " .. arg_18_2.r)

		return
	end

	if not SurvivalMapModel.instance:canWalk(true) then
		return
	end

	if SurvivalMapModel.instance:isInFog2(arg_18_2) then
		SurvivalMapModel.instance:setMoveToTarget()
		SurvivalMapModel.instance:setShowTarget()

		return
	end

	local var_18_3 = SurvivalMapModel.instance:getCurMapCo().walkables
	local var_18_4 = SurvivalAStarFindPath.instance:findPath(var_18_1, arg_18_2, var_18_3)

	if var_18_4 then
		if SurvivalMapModel.instance:getShowTargetPos() == arg_18_2 then
			SurvivalMapModel.instance:setMoveToTarget(var_18_4[#var_18_4], var_18_4)
			SurvivalMapModel.instance:setShowTarget(nil, true)

			if not SurvivalMapHelper.instance:isInFlow() then
				local var_18_5 = SurvivalHelper.instance:getDir(var_18_1, var_18_4[1])

				SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.PlayerMove, tostring(var_18_5))
			else
				SurvivalMapHelper.instance:tryRemoveFlow()
			end
		else
			SurvivalMapModel.instance:setShowTarget(arg_18_2)
			table.insert(var_18_4, 1, var_18_1)
			SurvivalMapHelper.instance:getScene().path:setPathListShow(var_18_4)

			if SurvivalMapModel.instance._targetPos ~= arg_18_2 then
				SurvivalMapModel.instance:setMoveToTarget()
			end
		end
	else
		SurvivalMapModel.instance:setMoveToTarget()
		SurvivalMapModel.instance:setShowTarget()
	end
end

function var_0_0.setScenePosSafety(arg_19_0, arg_19_1)
	var_0_0.super.setScenePosSafety(arg_19_0, arg_19_1)
	SurvivalMapHelper.instance:getSceneFogComp():updateCenterPos(arg_19_1)
	SurvivalMapHelper.instance:getSceneFogComp():updateTexture()
	SurvivalMapHelper.instance:updateCloudShow()
	arg_19_0:checkPlaySpBlockAudio()
end

function var_0_0.onSceneScaleChange(arg_20_0)
	SurvivalMapHelper.instance:getSceneFogComp():updateTexture()
	SurvivalMapHelper.instance:updateCloudShow()
end

function var_0_0._refreshTeamLv(arg_21_0, arg_21_1)
	if arg_21_1 and arg_21_1 ~= SurvivalEnum.AttrType.HeroFightLevel then
		return
	end

	local var_21_0 = SurvivalShelterModel.instance:getWeekInfo()

	arg_21_0._txtTeamLv.text = "Lv." .. var_21_0:getAttr(SurvivalEnum.AttrType.HeroFightLevel)
end

function var_0_0.onPlayerTornadoTransferBegin(arg_22_0)
	gohelper.setActive(arg_22_0._imageBlack, true)
	ZProj.TweenHelper.DoFade(arg_22_0._imageBlack, 0, 1, 0.8)
end

function var_0_0.onPlayerTornadoTransferEnd(arg_23_0)
	gohelper.setActive(arg_23_0._imageBlack, false)
end

local var_0_1 = Vector3()
local var_0_2 = SurvivalHexNode.New()
local var_0_3

function var_0_0.checkPlaySpBlockAudio(arg_24_0)
	if not var_0_3 then
		var_0_3 = tonumber((SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.TornadoSpEvent)))
	end

	local var_24_0 = SurvivalMapModel.instance:getSceneMo()
	local var_24_1 = UnityEngine.Screen.width
	local var_24_2 = UnityEngine.Screen.height

	var_0_1:Set(var_24_1 / 2, var_24_2 / 2, 0)

	local var_24_3 = SurvivalHelper.instance:getScene3DPos(var_0_1)

	var_0_2:set(SurvivalHelper.instance:worldPointToHex(var_24_3.x, var_24_3.y, var_24_3.z))

	local var_24_4
	local var_24_5 = SurvivalHelper.instance:getAllPointsByDis(var_0_2, 6)

	for iter_24_0, iter_24_1 in ipairs(var_24_5) do
		local var_24_6 = var_24_0:getListByPos(iter_24_1)

		if var_24_6 then
			for iter_24_2, iter_24_3 in ipairs(var_24_6) do
				if iter_24_3.cfgId == var_0_3 then
					var_24_4 = true

					break
				end
			end
		end

		if var_24_4 then
			break
		end
	end

	if var_24_4 ~= arg_24_0._haveTornado then
		arg_24_0._haveTornado = var_24_4

		if var_24_4 then
			AudioMgr.instance:trigger(AudioEnum3_1.Survival.TornadoStart)
		else
			AudioMgr.instance:trigger(AudioEnum3_1.Survival.TornadoEnd)
		end
	end

	if var_24_0.sceneProp.magmaStatus == SurvivalEnum.MagmaStatus.Active then
		local var_24_7

		for iter_24_4, iter_24_5 in ipairs(var_24_5) do
			if var_24_0:getBlockTypeByPos(iter_24_5) == SurvivalEnum.UnitSubType.Magma then
				var_24_7 = true

				break
			end
		end

		if var_24_7 ~= arg_24_0._haveMagma then
			arg_24_0._haveMagma = var_24_7

			if var_24_7 then
				AudioMgr.instance:trigger(AudioEnum3_1.Survival.MagmaActive)
			else
				AudioMgr.instance:trigger(AudioEnum3_1.Survival.MagmaDeactive)
			end
		end
	elseif arg_24_0._haveMagma then
		arg_24_0._haveMagma = nil

		AudioMgr.instance:trigger(AudioEnum3_1.Survival.MagmaDeactive)
	end
end

function var_0_0.onClose(arg_25_0)
	SurvivalMapModel.instance.save_mapScale = arg_25_0._scale or 1
end

function var_0_0.onDestroyView(arg_26_0)
	AudioMgr.instance:trigger(AudioEnum3_1.Survival.TornadoEnd)
	AudioMgr.instance:trigger(AudioEnum3_1.Survival.MagmaDeactive)
end

return var_0_0
