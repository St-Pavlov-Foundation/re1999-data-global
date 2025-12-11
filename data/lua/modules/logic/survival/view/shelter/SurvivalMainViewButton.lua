module("modules.logic.survival.view.shelter.SurvivalMainViewButton", package.seeall)

local var_0_0 = class("SurvivalMainViewButton", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnExit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_lefttop/#btn_exit")
	arg_1_0.btnTarget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/Left/#btn_target")
	arg_1_0.btnRoleWareHouse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/Left/#btn_RoleWarehouse")
	arg_1_0.btnEquip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/Left/#btn_equip")
	arg_1_0._goequipred = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/Left/#btn_equip/go_arrow")
	arg_1_0.btnStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/BottomRight/#btn_start")
	arg_1_0.btnNpc = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/Left/#btn_npc")
	arg_1_0.btnWareHouse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/BottomRight/layout/#btn_Warehouse")
	arg_1_0.btnBuilding = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/BottomRight/layout/#btn_build")
	arg_1_0.goNewBuilding = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/BottomRight/layout/#btn_build/go_New")
	arg_1_0.goLevupBuilding = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/BottomRight/layout/#btn_build/go_levelUp")
	arg_1_0.goFixBuilding = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/BottomRight/layout/#btn_build/go_Fix")
	arg_1_0.txtProgress = gohelper.findChildTextMesh(arg_1_0.viewGO, "go_normalroot/Top/#go_progress/#txt_progress")
	arg_1_0.goMonster = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/Top/#go_monster")

	gohelper.setActive(arg_1_0.goMonster, false)

	arg_1_0.btnMonster = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/Top/#go_monster")
	arg_1_0.sImgMonster = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_normalroot/Top/#go_monster/#go_monsterHeadIcon")
	arg_1_0.txtMonsterTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "go_normalroot/Top/#go_monster/#txt_LimitTime")
	arg_1_0.goMonsterTimeIcon = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/Top/#go_monster/#txt_LimitTime/icon")
	arg_1_0.txtTaskDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "go_normalroot/Left/#go_target/TargetView/Viewport/Content/#txt_target")
	arg_1_0.txtSubTaskDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "go_normalroot/Left/#go_target/TargetView/Viewport/Content/#txt_sub")
	arg_1_0.goSubTaskIcon = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/Left/#go_target/TargetView/Viewport/Content/#txt_sub/image_icon")
	arg_1_0.goSubTaskReward = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/Left/#go_target/TargetView/Viewport/Content/#txt_sub/rewardIcon")
	arg_1_0.btnSubTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/Left/#go_target/TargetView/Viewport/Content/#txt_sub/btn")
	arg_1_0.goSubTaskMask = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/Left/#go_target/TargetView/Viewport/Content/#txt_sub/image_mask")
	arg_1_0.goUI = gohelper.findChild(arg_1_0.viewGO, "go_ui")
	arg_1_0.goUI2 = gohelper.findChild(arg_1_0.viewGO, "go_ui2")
	arg_1_0.goNormalRoot = gohelper.findChild(arg_1_0.viewGO, "go_normalroot")
	arg_1_0.goLeftTop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")
	arg_1_0.igoreViewList = {
		ViewName.SurvivalToastView,
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor,
		ViewName.GMGuideStatusView
	}
	arg_1_0.animator = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0.goRaycast = gohelper.findChild(arg_1_0.viewGO, "raycast")
	arg_1_0.interceptMask = gohelper.findChild(arg_1_0.viewGO, "interceptMask")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnSubTask, arg_2_0.onClickSubTask, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnExit, arg_2_0.onClickExit, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnStart, arg_2_0.onClickStart, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnEquip, arg_2_0.onClickEquip, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnRoleWareHouse, arg_2_0.onClickRoleWareHouse, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnTarget, arg_2_0.onClickTarget, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnNpc, arg_2_0.onClickNpc, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnBuilding, arg_2_0.onClickBuilding, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnWareHouse, arg_2_0.onClickWareHouse, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnMonster, arg_2_0.onClickMonster, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0.onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0.onCloseViewFinish, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnTaskDataUpdate, arg_2_0.onTaskDataUpdate, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnWeekInfoUpdate, arg_2_0.onWeekInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, arg_2_0.onBuildingInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_2_0.onShelterBagUpdate, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipRedUpdate, arg_2_0.updateEquipRed, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.BossPerformFinish, arg_2_0.refreshInterceptMask, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnSubTask)
	arg_3_0:removeClickCb(arg_3_0.btnExit)
	arg_3_0:removeClickCb(arg_3_0.btnStart)
	arg_3_0:removeClickCb(arg_3_0.btnNpc)
	arg_3_0:removeClickCb(arg_3_0.btnBuilding)
	arg_3_0:removeClickCb(arg_3_0.btnEquip)
	arg_3_0:removeClickCb(arg_3_0.btnRoleWareHouse)
	arg_3_0:removeClickCb(arg_3_0.btnTarget)
	arg_3_0:removeClickCb(arg_3_0.btnWareHouse)
	arg_3_0:removeClickCb(arg_3_0.btnMonster)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0.onOpenView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0.onCloseViewFinish, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnTaskDataUpdate, arg_3_0.onTaskDataUpdate, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnWeekInfoUpdate, arg_3_0.onWeekInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, arg_3_0.onBuildingInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_3_0.onShelterBagUpdate, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipRedUpdate, arg_3_0.updateEquipRed, arg_3_0)
end

function var_0_0.refreshHelpBtnPos(arg_4_0)
	recthelper.setAnchorX(arg_4_0.btnExit.transform, 220)
end

function var_0_0._addUnlockComp(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	MonoHelper.addNoUpdateLuaComOnceToGo(arg_5_1, SurvivalButtonUnlockPart, {
		unlockConditions = arg_5_2,
		eventParams = arg_5_3
	})
end

function var_0_0.onClickSubTask(arg_6_0)
	if not arg_6_0.subTaskId then
		return
	end

	local var_6_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_6_0 then
		return
	end

	local var_6_1 = var_6_0.taskPanel:getTaskBoxMo(SurvivalEnum.TaskModule.SubTask):getTaskInfo(arg_6_0.subTaskId)

	if not var_6_1 then
		return
	end

	if var_6_1:isCangetReward() then
		SurvivalWeekRpc.instance:sendSurvivalReceiveTaskRewardRequest(SurvivalEnum.TaskModule.SubTask, var_6_1.id)
	else
		JumpController.instance:jumpByParam(var_6_1.co.jump)
	end
end

function var_0_0.onClickExit(arg_7_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalGiveUpWeek, MsgBoxEnum.BoxType.Yes_No, arg_7_0._sendGiveUp, nil, nil, arg_7_0, nil, nil)
	SurvivalStatHelper.instance:statBtnClick("onClickExit", "SurvivalMainView")
end

function var_0_0._sendGiveUp(arg_8_0)
	SurvivalWeekRpc.instance:sendSurvivalAbandonWeek()
end

function var_0_0.onClickStart(arg_9_0)
	if SurvivalShelterModel.instance:getWeekInfo():getMonsterFight():needKillBoss() then
		local var_9_0 = SurvivalMapHelper.instance:getSurvivalBubbleComp()

		if not var_9_0:isPlayerBubbleShow() then
			local var_9_1 = SurvivalBubbleParam.New()

			var_9_1.content = luaLang("SurvivalBubble_1")
			var_9_1.duration = -1
			arg_9_0.bubbleId = var_9_0:showPlayerBubble(var_9_1)
		end

		return
	end

	SurvivalMapHelper.instance:stopShelterPlayerMove()
	SurvivalController.instance:enterSurvival()
	SurvivalStatHelper.instance:statBtnClick("onClickStart", "SurvivalMainView")
end

function var_0_0.onClickMonster(arg_10_0)
	local var_10_0 = SurvivalShelterModel.instance:getWeekInfo():getMonsterFight()

	if var_10_0 and var_10_0:canShowEntity() then
		SurvivalMapHelper.instance:gotoMonster(var_10_0.fightId)
	end

	SurvivalStatHelper.instance:statBtnClick("onClickMonster", "SurvivalMainView")
end

function var_0_0.onClickWareHouse(arg_11_0)
	ViewMgr.instance:openView(ViewName.ShelterMapBagView)
end

function var_0_0.onClickRoleWareHouse(arg_12_0)
	ViewMgr.instance:openView(ViewName.ShelterHeroWareHouseView)
	SurvivalStatHelper.instance:statBtnClick("onClickRoleWareHouse", "SurvivalMainView")
end

function var_0_0.onClickTarget(arg_13_0)
	ViewMgr.instance:openView(ViewName.ShelterTaskView)
	SurvivalStatHelper.instance:statBtnClick("onClickTarget", "SurvivalMainView")
end

function var_0_0.onClickNpc(arg_14_0)
	ViewMgr.instance:openView(ViewName.ShelterNpcManagerView)
	SurvivalStatHelper.instance:statBtnClick("onClickNpc", "SurvivalMainView")
end

function var_0_0.onClickBuilding(arg_15_0)
	ViewMgr.instance:openView(ViewName.ShelterBuildingManagerView)
	SurvivalStatHelper.instance:statBtnClick("onClickBuilding", "SurvivalMainView")
end

function var_0_0.onClickEquip(arg_16_0)
	SurvivalController.instance:openEquipView()
	SurvivalStatHelper.instance:statBtnClick("onClickEquip", "SurvivalMainView")
end

function var_0_0.onOpenView(arg_17_0)
	arg_17_0:refreshViewUIVisible()
	arg_17_0:refreshInterceptMask()
end

function var_0_0.onCloseViewFinish(arg_18_0)
	arg_18_0:refreshViewUIVisible()
end

function var_0_0.refreshViewUIVisible(arg_19_0)
	local var_19_0 = ViewHelper.instance:checkViewOnTheTop(arg_19_0.viewName, arg_19_0.igoreViewList)

	arg_19_0:setViewUIVisible(var_19_0)
end

function var_0_0.refreshBtnStart(arg_20_0)
	local var_20_0 = SurvivalShelterModel.instance:getWeekInfo():getMonsterFight():needKillBoss()

	ZProj.UGUIHelper.SetGrayscale(arg_20_0.btnStart.gameObject, var_20_0)
end

function var_0_0.setViewUIVisible(arg_21_0, arg_21_1)
	if arg_21_0._isViewUIVisible == arg_21_1 then
		return
	end

	arg_21_0._isViewUIVisible = arg_21_1

	if arg_21_1 then
		arg_21_0.animator:Play("in", 0, 0)
	else
		arg_21_0.animator:Play("out", 0, 0)
	end

	gohelper.setActive(arg_21_0.goRaycast, not arg_21_1)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMainViewVisible, arg_21_1)
end

function var_0_0.refreshInterceptMask(arg_22_0)
	local var_22_0, var_22_1 = SurvivalShelterModel.instance:getNeedShowFightSuccess()

	gohelper.setActive(arg_22_0.interceptMask, var_22_0)
end

function var_0_0.onTaskDataUpdate(arg_23_0)
	arg_23_0:refreshTask()
end

function var_0_0.onWeekInfoUpdate(arg_24_0)
	arg_24_0:refreshView()
end

function var_0_0.onBuildingInfoUpdate(arg_25_0)
	arg_25_0:_refreshBuildingButton()
end

function var_0_0.onShelterBagUpdate(arg_26_0)
	arg_26_0:_refreshBuildingButton()
end

function var_0_0.onOpen(arg_27_0)
	arg_27_0:refreshView()
	arg_27_0:refreshHelpBtnPos()
end

function var_0_0.updateEquipRed(arg_28_0)
	gohelper.setActive(arg_28_0._goequipred, SurvivalEquipRedDotHelper.instance.reddotType >= 0)
end

function var_0_0.refreshView(arg_29_0)
	arg_29_0:refreshProgress()
	arg_29_0:refreshTask()
	arg_29_0:refreshButton()
	arg_29_0:updateEquipRed()
	arg_29_0:refreshBtnStart()
end

function var_0_0.refreshProgress(arg_30_0)
	local var_30_0 = SurvivalShelterModel.instance:getWeekInfo()

	arg_30_0.txtProgress.text = formatLuaLang("versionactivity_1_2_114daydes", var_30_0.day)
end

function var_0_0.refreshTask(arg_31_0)
	local var_31_0 = SurvivalTaskModel.instance:getTaskList(SurvivalEnum.TaskModule.MainTask)
	local var_31_1

	for iter_31_0, iter_31_1 in ipairs(var_31_0) do
		if iter_31_1:isUnFinish() then
			var_31_1 = iter_31_1

			break
		end
	end

	arg_31_0.txtTaskDesc.text = var_31_1 and var_31_1:getDesc() or ""

	local var_31_2 = SurvivalTaskModel.instance:getTaskList(SurvivalEnum.TaskModule.SubTask)
	local var_31_3

	for iter_31_2, iter_31_3 in ipairs(var_31_2) do
		if iter_31_3:isUnFinish() or iter_31_3:isCangetReward() then
			var_31_3 = iter_31_3

			break
		end
	end

	arg_31_0.txtSubTaskDesc.text = var_31_3 and var_31_3:getDesc() or ""

	local var_31_4 = var_31_3 and var_31_3:isCangetReward() or false

	gohelper.setActive(arg_31_0.goSubTaskIcon, var_31_3 and not var_31_4)
	gohelper.setActive(arg_31_0.goSubTaskReward, var_31_4)
	gohelper.setActive(arg_31_0.goSubTaskMask, var_31_4)

	arg_31_0.subTaskId = var_31_3 and var_31_3.id
end

function var_0_0.refreshButton(arg_32_0)
	arg_32_0:_refreshBuildingButton()
end

function var_0_0._refreshBuildingButton(arg_33_0)
	local var_33_0 = SurvivalShelterModel.instance:getWeekInfo():getBuildingBtnStatus()

	gohelper.setActive(arg_33_0.goNewBuilding, var_33_0 == SurvivalEnum.ShelterBuildingBtnStatus.New)
	gohelper.setActive(arg_33_0.goFixBuilding, var_33_0 == SurvivalEnum.ShelterBuildingBtnStatus.Destroy)
	gohelper.setActive(arg_33_0.goLevupBuilding, var_33_0 == SurvivalEnum.ShelterBuildingBtnStatus.Levelup)
end

return var_0_0
