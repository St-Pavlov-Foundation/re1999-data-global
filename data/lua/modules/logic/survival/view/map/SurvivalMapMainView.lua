module("modules.logic.survival.view.map.SurvivalMapMainView", package.seeall)

local var_0_0 = class("SurvivalMapMainView", SurvivalMapDragBaseView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._btnbag = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "BottomRight/#btn_bag")
	arg_1_0._gobagfull = gohelper.findChild(arg_1_0.viewGO, "BottomRight/#btn_bag/#go_overweight")
	arg_1_0._btnmap = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "BottomRight/#btn_map")
	arg_1_0._btnlog = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "BottomRight/#btn_log")
	arg_1_0._btnabort = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_abort")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_task")
	arg_1_0._btnteam = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_team")
	arg_1_0._txtTeamLv = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/#btn_team/go_level/#txt_level")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_equip")
	arg_1_0._goequipred = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_equip/go_arrow")
	arg_1_0._btnbox = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_box")
	arg_1_0._animbox = gohelper.findChildAnim(arg_1_0.viewGO, "Left/#btn_box")
	arg_1_0._txtBoxNum = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/#btn_box/#txt_num")
	arg_1_0._gotask = gohelper.findChild(arg_1_0.viewGO, "Left/#go_task")
	arg_1_0._txtTask = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/#go_task/TaskView/Viewport/Content/#txt_task")
	arg_1_0._viewAnim = gohelper.findChildAnim(arg_1_0.viewGO, "")
	arg_1_0.igoreViewList = {
		ViewName.SurvivalToastView,
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor,
		ViewName.GMGuideStatusView,
		ViewName.SurvivalCurrencyTipView
	}
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnabort:AddClickListener(arg_2_0._onClickAbort, arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._onClickTask, arg_2_0)
	arg_2_0._btnteam:AddClickListener(arg_2_0._onClickTeam, arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._onClickEquip, arg_2_0)
	arg_2_0._btnbox:AddClickListener(arg_2_0._onClickBox, arg_2_0)
	arg_2_0._btnbag:AddClickListener(arg_2_0._onClickBag, arg_2_0)
	arg_2_0._btnmap:AddClickListener(arg_2_0._onClickMap, arg_2_0)
	arg_2_0._btnlog:AddClickListener(arg_2_0._onClickLog, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapBagUpdate, arg_2_0._refreshBagFull, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnAttrUpdate, arg_2_0._refreshTeamLv, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnFollowTaskUpdate, arg_2_0._refreshCurTask, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnTalentCountUpdate, arg_2_0.onRefreshBoxNum, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipRedUpdate, arg_2_0.updateEquipRed, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0.onRefreshViewState, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0.onRefreshViewState, arg_2_0)
	arg_2_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_2_0.refreshHelpBtnPos, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnabort:RemoveClickListener()
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnteam:RemoveClickListener()
	arg_3_0._btnequip:RemoveClickListener()
	arg_3_0._btnbox:RemoveClickListener()
	arg_3_0._btnbag:RemoveClickListener()
	arg_3_0._btnmap:RemoveClickListener()
	arg_3_0._btnlog:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapBagUpdate, arg_3_0._refreshBagFull, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnAttrUpdate, arg_3_0._refreshTeamLv, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnFollowTaskUpdate, arg_3_0._refreshCurTask, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnTalentCountUpdate, arg_3_0.onRefreshBoxNum, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipRedUpdate, arg_3_0.updateEquipRed, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0.onRefreshViewState, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0.onRefreshViewState, arg_3_0)
	arg_3_0:removeEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_3_0.refreshHelpBtnPos, arg_3_0)
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
	arg_4_0:onRefreshBoxNum(true)
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

function var_0_0.onRefreshBoxNum(arg_7_0, arg_7_1)
	local var_7_0 = SurvivalMapModel.instance:getSceneMo()

	arg_7_0._txtBoxNum.text = var_7_0.gainTalentNum

	if not arg_7_1 then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_qiutu_award_all)
		arg_7_0._animbox:Play("get", 0, 0)
	end
end

function var_0_0.onRefreshViewState(arg_8_0)
	if arg_8_0._isTopView == nil then
		arg_8_0._isTopView = true
	end

	local var_8_0 = ViewHelper.instance:checkViewOnTheTop(arg_8_0.viewName, arg_8_0.igoreViewList)

	if var_8_0 == arg_8_0._isTopView then
		return
	end

	arg_8_0._isTopView = var_8_0

	arg_8_0._viewAnim:Play(arg_8_0._isTopView and "in" or "close", 0, 0)
end

function var_0_0._onClickAbort(arg_9_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalGiveUp, MsgBoxEnum.BoxType.Yes_No, arg_9_0._sendGiveUp, nil, nil, arg_9_0, nil, nil)
	SurvivalStatHelper.instance:statBtnClick("_onClickAbort", "SurvivalMapMainView")
end

function var_0_0._sendGiveUp(arg_10_0)
	SurvivalInteriorRpc.instance:sendSurvivalSceneGiveUp()
end

function var_0_0._onClickBag(arg_11_0)
	ViewMgr.instance:openView(ViewName.SurvivalMapBagView)
	SurvivalStatHelper.instance:statBtnClick("_onClickBag", "SurvivalMapMainView")
end

function var_0_0._onClickTask(arg_12_0)
	ViewMgr.instance:openView(ViewName.ShelterTaskView, {
		moduleId = SurvivalEnum.TaskModule.NormalTask
	})
	SurvivalStatHelper.instance:statBtnClick("_onClickTask", "SurvivalMapMainView")
end

function var_0_0._onClickTeam(arg_13_0)
	ViewMgr.instance:openView(ViewName.SurvivalMapTeamView)
	SurvivalStatHelper.instance:statBtnClick("_onClickTeam", "SurvivalMapMainView")
end

function var_0_0._onClickEquip(arg_14_0)
	SurvivalController.instance:openEquipView()
	SurvivalStatHelper.instance:statBtnClick("_onClickEquip", "SurvivalMapMainView")
end

function var_0_0._onClickBox(arg_15_0)
	local var_15_0 = arg_15_0._btnbox.transform
	local var_15_1 = var_15_0.lossyScale
	local var_15_2 = var_15_0.position
	local var_15_3 = recthelper.getWidth(var_15_0)
	local var_15_4 = recthelper.getHeight(var_15_0)

	var_15_2.x = var_15_2.x - var_15_3 / 2 * var_15_1.x
	var_15_2.y = var_15_2.y + var_15_4 / 2 * var_15_1.y

	local var_15_5, var_15_6 = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.TalentDesc)

	ViewMgr.instance:openView(ViewName.SurvivalCurrencyTipView, {
		arrow = "TR",
		txt = var_15_6,
		pos = var_15_2
	})
	SurvivalStatHelper.instance:statBtnClick("_onClickBox", "SurvivalMapMainView")
end

function var_0_0._onClickMap(arg_16_0)
	if SurvivalMapHelper.instance:isInFlow() then
		return
	end

	ViewMgr.instance:openView(ViewName.SurvivalSmallMapView)
	SurvivalStatHelper.instance:statBtnClick("_onClickMap", "SurvivalMapMainView")
end

function var_0_0._onClickLog(arg_17_0)
	SurvivalInteriorRpc.instance:sendSurvivalSceneOperationLog()
	SurvivalStatHelper.instance:statBtnClick("_onClickLog", "SurvivalMapMainView")
end

function var_0_0._refreshBagFull(arg_18_0)
	local var_18_0 = SurvivalMapModel.instance:getSceneMo()
	local var_18_1 = var_18_0.bag.totalMass > var_18_0.bag.maxWeightLimit + SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.AttrWeight)

	gohelper.setActive(arg_18_0._gobagfull, var_18_1)
end

function var_0_0._refreshCurTask(arg_19_0)
	local var_19_0 = SurvivalMapModel.instance:getSceneMo().followTask
	local var_19_1 = var_19_0.moduleId > 0 and SurvivalConfig.instance:getTaskCo(var_19_0.moduleId, var_19_0.taskId)

	gohelper.setActive(arg_19_0._gotask, var_19_1)

	if var_19_1 then
		arg_19_0._txtTask.text = var_19_1.desc2
	end
end

function var_0_0.calcSceneBoard(arg_20_0)
	local var_20_0 = SurvivalMapModel.instance:getCurMapCo()

	arg_20_0._mapMinX = var_20_0.minX
	arg_20_0._mapMaxX = var_20_0.maxX
	arg_20_0._mapMinY = var_20_0.minY
	arg_20_0._mapMaxY = var_20_0.maxY
	arg_20_0._maxDis = 7.5
	arg_20_0._minDis = 5
end

function var_0_0.onClickScene(arg_21_0, arg_21_1, arg_21_2)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_qiutu_general_click)

	local var_21_0 = {}

	arg_21_0.viewContainer:dispatchEvent(SurvivalEvent.OnClickSurvivalScene, arg_21_2, var_21_0)

	if var_21_0.use then
		return
	end

	local var_21_1 = SurvivalMapModel.instance:getSceneMo().player.pos

	if var_21_1 == arg_21_2 then
		SurvivalMapModel.instance:setShowTarget()

		if not SurvivalMapHelper.instance:isInFlow() then
			SurvivalMapHelper.instance:tryShowEventView(var_21_1)
		end

		return
	end

	if not SurvivalMapHelper.instance:isInFlow() and isDebugBuild and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
		local var_21_2 = SurvivalMapHelper.instance:getEntity(0)

		var_21_2:setPosAndDir(arg_21_2, var_21_2._unitMo.dir)
		GMRpc.instance:sendGMRequest("surPlayerMove " .. arg_21_2.q .. " " .. arg_21_2.r)

		return
	end

	if not SurvivalMapModel.instance:canWalk(true) then
		return
	end

	local var_21_3 = SurvivalMapModel.instance:getCurMapCo().walkables
	local var_21_4 = SurvivalAStarFindPath.instance:findPath(var_21_1, arg_21_2, var_21_3)

	if var_21_4 then
		if SurvivalMapModel.instance:getShowTargetPos() == arg_21_2 then
			SurvivalMapModel.instance:setMoveToTarget(var_21_4[#var_21_4], var_21_4)
			SurvivalMapModel.instance:setShowTarget(nil, true)

			if not SurvivalMapHelper.instance:isInFlow() then
				local var_21_5 = SurvivalHelper.instance:getDir(var_21_1, var_21_4[1])

				SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.PlayerMove, tostring(var_21_5))
			else
				SurvivalMapHelper.instance:tryRemoveFlow()
			end
		else
			SurvivalMapModel.instance:setShowTarget(arg_21_2)
			table.insert(var_21_4, 1, var_21_1)
			SurvivalMapHelper.instance:getScene().path:setPathListShow(var_21_4)

			if SurvivalMapModel.instance._targetPos ~= arg_21_2 then
				SurvivalMapModel.instance:setMoveToTarget()
			end
		end
	else
		SurvivalMapModel.instance:setMoveToTarget()
		SurvivalMapModel.instance:setShowTarget()
	end
end

function var_0_0.setScenePosSafety(arg_22_0, arg_22_1)
	var_0_0.super.setScenePosSafety(arg_22_0, arg_22_1)
	SurvivalMapHelper.instance:getSceneFogComp():updateCenterPos(arg_22_1)
	SurvivalMapHelper.instance:getSceneFogComp():updateTexture()
end

function var_0_0.onSceneScaleChange(arg_23_0)
	SurvivalMapHelper.instance:getSceneFogComp():updateTexture()
end

function var_0_0._refreshTeamLv(arg_24_0, arg_24_1)
	if arg_24_1 and arg_24_1 ~= SurvivalEnum.AttrType.HeroFightLevel then
		return
	end

	local var_24_0 = SurvivalShelterModel.instance:getWeekInfo()

	arg_24_0._txtTeamLv.text = "Lv." .. var_24_0:getAttr(SurvivalEnum.AttrType.HeroFightLevel)
end

function var_0_0.onClose(arg_25_0)
	SurvivalMapModel.instance.save_mapScale = arg_25_0._scale or 1
end

return var_0_0
