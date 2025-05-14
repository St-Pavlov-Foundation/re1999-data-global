module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateLevelView", package.seeall)

local var_0_0 = class("EliminateLevelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")
	arg_1_0._gocameraMain = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain")
	arg_1_0._simageteamchessMaskBG2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_cameraMain/#simage_teamchessMaskBG2")
	arg_1_0._simageeliminatechessMaskBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_cameraMain/#simage_eliminatechessMaskBG")
	arg_1_0._simageeliminatechessMaskBG2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_cameraMain/#simage_eliminatechessMaskBG2")
	arg_1_0._simageteamchessMaskBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_cameraMain/#simage_teamchessMaskBG")
	arg_1_0._goModeBGDec = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Title/#go_ModeBGDec")
	arg_1_0._txtTurns = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Middle/Title/#txt_Turns")
	arg_1_0._goPoint = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Title/Point/#go_Point")
	arg_1_0._goPointLight = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Title/Point/#go_PointLight")
	arg_1_0._goEliminate = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Title/Eliminate/#go_Eliminate")
	arg_1_0._goEliminateLight = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Title/Eliminate/#go_EliminateLight")
	arg_1_0._goteamchess = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/#go_teamchess")
	arg_1_0._goPointViewList = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/#go_eliminatechess/Right/#go_PointViewList")
	arg_1_0._goeliminatechess = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/#go_eliminatechess")
	arg_1_0._btnTaskcancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cameraMain/Left/Task/#btn_Task_cancel")
	arg_1_0._goTaskPanel = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel")
	arg_1_0._imageTaskBG = gohelper.findChildImage(arg_1_0.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel/#image_TaskBG")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel/#image_TaskBG/#go_Item")
	arg_1_0._txtTaskTarget = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel/#image_TaskBG/#go_Item/#txt_TaskTarget")
	arg_1_0._btnTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cameraMain/Left/Task/#btn_Task")
	arg_1_0._imageRoleBG = gohelper.findChildImage(arg_1_0.viewGO, "#go_cameraMain/Left/Role/#image_RoleBG")
	arg_1_0._imageRoleBG2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_cameraMain/Left/Role/#image_RoleBG2")
	arg_1_0._imageRoleHPFG = gohelper.findChildImage(arg_1_0.viewGO, "#go_cameraMain/Left/Role/Role/#image_RoleHPFG")
	arg_1_0._imageRolehpfgeff1 = gohelper.findChildImage(arg_1_0.viewGO, "#go_cameraMain/Left/Role/Role/#image_RoleHPFG/#image_Rolehpfg_eff1")
	arg_1_0._simageRole = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_cameraMain/Left/Role/Role/image/#simage_Role")
	arg_1_0._txtRoleHP = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Left/Role/Role/image_RoleHPNumBG/#txt_RoleHP")
	arg_1_0._gorolePointDamage = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Role/Role/#go_rolePointDamage")
	arg_1_0._goRoleSkillPoint1 = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1")
	arg_1_0._goRoleSkill = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill")
	arg_1_0._goRoleSkillBG = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillBG")
	arg_1_0._goRoleSkillBGDisable = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillBGDisable")
	arg_1_0._imageRoleSkill = gohelper.findChildImage(arg_1_0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/image/#image_RoleSkill")
	arg_1_0._goRolevxbreak = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/image/#go_Role_vx_break")
	arg_1_0._imageRoleSkillFG = gohelper.findChildImage(arg_1_0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#image_RoleSkillFG")
	arg_1_0._imageRoleSkillfgeff1 = gohelper.findChildImage(arg_1_0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#image_RoleSkillFG/#image_RoleSkillfg_eff1")
	arg_1_0._goRoleSkillFull = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillFull")
	arg_1_0._goRoleSkillLoop = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillFull/#go_RoleSkill_Loop")
	arg_1_0._goRoleSkillClickEffect = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillClick_Effect")
	arg_1_0._txtRoleCostNum = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/image_SkillEnergyBG/#txt_RoleCostNum")
	arg_1_0._goRoleSkillClick = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillClick")
	arg_1_0._goRoleSkillPoint2 = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint2")
	arg_1_0._goRolevxdamage = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Role/#go_Role_vx_damage")
	arg_1_0._imageEnemyBG = gohelper.findChildImage(arg_1_0.viewGO, "#go_cameraMain/Right/Enemy/#image_EnemyBG")
	arg_1_0._imageEnemyBG2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_cameraMain/Right/Enemy/#image_EnemyBG2")
	arg_1_0._goenemyPointDamage = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Right/Enemy/Enemy/#go_enemyPointDamage")
	arg_1_0._imageEnemyHPFG = gohelper.findChildImage(arg_1_0.viewGO, "#go_cameraMain/Right/Enemy/Enemy/#image_EnemyHPFG")
	arg_1_0._imageEnemyhpfgeff2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_cameraMain/Right/Enemy/Enemy/#image_EnemyHPFG/#image_Enemyhpfg_eff2")
	arg_1_0._simageEnemy = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_cameraMain/Right/Enemy/Enemy/image/#simage_Enemy")
	arg_1_0._goenemyvxbreak = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Right/Enemy/Enemy/image/#go_enemy_vx_break")
	arg_1_0._txtEnemyHP = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Right/Enemy/Enemy/image_EnemyHPNumBG/#txt_EnemyHP")
	arg_1_0._goEnemySkillPoint1 = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1")
	arg_1_0._goEnemySkill = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill")
	arg_1_0._goEnemySkillBG = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/#go_EnemySkillBG")
	arg_1_0._goEnemySkillBGDisable = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/#go_EnemySkillBGDisable")
	arg_1_0._imageEnemySkill = gohelper.findChildImage(arg_1_0.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/image/#image_EnemySkill")
	arg_1_0._imageenemySkillFG = gohelper.findChildImage(arg_1_0.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/#image_enemySkillFG")
	arg_1_0._imageEnemyskillfgeff2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/#image_enemySkillFG/#image_Enemyskillfg_eff2")
	arg_1_0._goEnemySkillFull = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/#go_EnemySkillFull")
	arg_1_0._txtEnemyCostNum = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/image_SkillEnergyBG/#txt_EnemyCostNum")
	arg_1_0._goEnemySkillPoint2 = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint2")
	arg_1_0._goEnemyvxdamage = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Right/Enemy/#go_Enemy_vx_damage")
	arg_1_0._btnPointViewBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cameraMain/Right/#btn_PointViewBtn")
	arg_1_0._txtPointView = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Right/#btn_PointViewBtn/#txt_PointView")
	arg_1_0._goskillViewPoint = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/#go_skillViewPoint")
	arg_1_0._goRolePoint = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/#go_skillViewPoint/#go_Role_Point")
	arg_1_0._goEnemyPoint = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/#go_skillViewPoint/#go_Enemy_Point")
	arg_1_0._goenemyInfo = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/#go_enemyInfo")
	arg_1_0._goEnemyChessPoint = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/#go_enemyInfo/#go_EnemyChessPoint")
	arg_1_0._goSkillRelease = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/#go_SkillRelease")
	arg_1_0._gorectMask = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/#go_SkillRelease/#go_rectMask")
	arg_1_0._txtskillTipDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/#go_SkillRelease/#txt_skillTipDesc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnTaskcancel:AddClickListener(arg_2_0._btnTaskcancelOnClick, arg_2_0)
	arg_2_0._btnTask:AddClickListener(arg_2_0._btnTaskOnClick, arg_2_0)
	arg_2_0._btnPointViewBtn:AddClickListener(arg_2_0._btnPointViewBtnOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnTaskcancel:RemoveClickListener()
	arg_3_0._btnTask:RemoveClickListener()
	arg_3_0._btnPointViewBtn:RemoveClickListener()
end

local var_0_1 = SLFramework.UGUI.UILongPressListener
local var_0_2 = SLFramework.UGUI.UIClickListener
local var_0_3 = ZProj.TweenHelper
local var_0_4 = ZProj.UIEffectsCollection

function var_0_0._btnTaskcancelOnClick(arg_4_0)
	arg_4_0:changeShowTaskPanelState(true)
end

function var_0_0._btnTaskOnClick(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_switch)
	arg_5_0:changeShowTaskPanelState(true)
end

function var_0_0.changeShowTaskPanelState(arg_6_0, arg_6_1)
	arg_6_0._isShowTaskPanel = not arg_6_0._isShowTaskPanel

	if not arg_6_0._isShowTaskPanel then
		arg_6_0._taskAni:Play("close")
		TaskDispatcher.runDelay(arg_6_0.setTaskViewActive, arg_6_0, 0.27)
	else
		arg_6_0:setTaskViewActive()
	end

	if arg_6_1 then
		gohelper.setActive(arg_6_0._btnTaskcancel, arg_6_0._isShowTaskPanel)
	end
end

function var_0_0.setTaskViewActive(arg_7_0)
	gohelper.setActive(arg_7_0._goTaskPanel, arg_7_0._isShowTaskPanel)
end

function var_0_0._btnPointViewBtnOnClick(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_open)
	arg_8_0:setTeamChessViewWatchState()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0.roleGo = gohelper.findChild(arg_9_0.viewGO, "#go_cameraMain/Left/Role/Role")
	arg_9_0.enemyGo = gohelper.findChild(arg_9_0.viewGO, "#go_cameraMain/Right/Enemy/Enemy")
	arg_9_0._goRoleSkillClickEffect = gohelper.findChild(arg_9_0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillClick_Effect")
	arg_9_0._imageRole = gohelper.findChildImage(arg_9_0.viewGO, "#go_cameraMain/Left/Role/Role/image/#simage_Role")
	arg_9_0._imageEnemy = gohelper.findChildImage(arg_9_0.viewGO, "#go_cameraMain/Right/Enemy/Enemy/image/#simage_Enemy")
	arg_9_0._effectAck = gohelper.findChild(arg_9_0.viewGO, "#go_cameraMain/#eff_attack")
	arg_9_0._effectToPlayer = gohelper.findChild(arg_9_0.viewGO, "#go_cameraMain/#eff_attack/1")
	arg_9_0._effectToEnemy = gohelper.findChild(arg_9_0.viewGO, "#go_cameraMain/#eff_attack/2")
	arg_9_0.roleSkillLongPress = var_0_1.Get(arg_9_0._goRoleSkillClick)

	arg_9_0.roleSkillLongPress:AddClickListener(arg_9_0._roleSkillLongPressClick, arg_9_0)
	arg_9_0.roleSkillLongPress:AddLongPressListener(arg_9_0._roleSkillLongPress, arg_9_0)
	arg_9_0.roleSkillLongPress:SetLongPressTime({
		0.5,
		9999
	})

	arg_9_0.enemyInfoMaskClick = var_0_2.Get(arg_9_0._goenemyInfo)

	arg_9_0.enemyInfoMaskClick:AddClickListener(arg_9_0.hideEnemyInfoView, arg_9_0)

	arg_9_0.pointViewListClick = var_0_2.Get(arg_9_0._goPointViewList)

	arg_9_0.pointViewListClick:AddClickListener(arg_9_0._pointViewListClick, arg_9_0)

	arg_9_0.roleClick = var_0_2.Get(arg_9_0._simageRole.gameObject)

	arg_9_0.roleClick:AddClickListener(arg_9_0.onRoleClick, arg_9_0)

	arg_9_0.enemySkillClick = var_0_1.Get(arg_9_0._goEnemySkill)

	arg_9_0.enemySkillClick:AddLongPressListener(arg_9_0.showEnemySkillView, arg_9_0)
	arg_9_0.enemySkillClick:SetLongPressTime({
		0.5,
		9999
	})

	arg_9_0._ani = arg_9_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_9_0._taskAni = arg_9_0._goTaskPanel:GetComponent(typeof(UnityEngine.Animator))
	arg_9_0._teamChessViewAni = arg_9_0._goteamchess:GetComponent(typeof(UnityEngine.Animator))
	arg_9_0._eliminateChessViewAni = arg_9_0._goeliminatechess:GetComponent(typeof(UnityEngine.Animator))
	arg_9_0._eliminateLightAni = arg_9_0._goEliminateLight:GetComponent(typeof(UnityEngine.Animator))
	arg_9_0._pointLightAni = arg_9_0._goPointLight:GetComponent(typeof(UnityEngine.Animator))
	arg_9_0._roleSkillUIEffect = var_0_4.Get(arg_9_0._goRoleSkill)
	arg_9_0._roleGoUIEffect = var_0_4.Get(arg_9_0.roleGo)
	arg_9_0._enemyGoUIEffect = var_0_4.Get(arg_9_0.enemyGo)
	arg_9_0._eliminatechessMaskCanvasGroup = arg_9_0._simageeliminatechessMaskBG.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_9_0._eliminatechessMaskCanvasGroup2 = arg_9_0._simageeliminatechessMaskBG2.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_9_0._teamchessMaskCanvasGroup = arg_9_0._simageteamchessMaskBG.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_9_0._teamchessMaskCanvasGroup2 = arg_9_0._simageteamchessMaskBG2.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(arg_9_0._goRoleSkillClickEffect, false)
	gohelper.setActive(arg_9_0._effectAck, false)
	EliminateLevelController.instance:BgSwitch(EliminateEnum.AudioFightStep.FightNormal)
end

function var_0_0._roleSkillLongPressClick(arg_10_0)
	if not EliminateLevelModel.instance:mainCharacterSkillIsUnLock() then
		GameFacade.showToast(ToastEnum.EliminateMainSkillLocked)

		return
	end

	if not EliminateLevelModel.instance:canReleaseSkill() then
		GameFacade.showToast(ToastEnum.EliminateSkillEnergyNotEnough)

		return
	end

	arg_10_0:skillRelease()
end

function var_0_0.hideRoleSkillClickEffect(arg_11_0)
	gohelper.setActive(arg_11_0._goRoleSkillClickEffect, false)
end

function var_0_0._roleSkillLongPress(arg_12_0)
	arg_12_0:showSkillView()
end

function var_0_0.onRoleClick(arg_13_0)
	EliminateLevelController.instance:clickMainCharacter()
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.setParent(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0._gocameraMain.transform:SetParent(arg_15_1.transform)
	EliminateTeamChessModel.instance:setViewCanvas(arg_15_2)

	local var_15_0 = arg_15_0._gocameraMain.transform

	transformhelper.setLocalScale(var_15_0, 0.009259259, 0.009259259, 0.009259259)
	transformhelper.setLocalPos(var_15_0, 0, 0, 0)
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.EliminateRoundStateChangeGoActive)
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0.showWatchView = false
	arg_16_0._canUseSkill = true

	arg_16_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.TeamChessWarInfoUpdate, arg_16_0.updateInfo, arg_16_0)
	arg_16_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChange, arg_16_0.updateViewState, arg_16_0)
	arg_16_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.MainCharacterHpChange, arg_16_0.mainCharacterHpChange, arg_16_0)
	arg_16_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.LevelConditionChange, arg_16_0.updateTaskInfo, arg_16_0)
	arg_16_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.MainCharacterPowerChange, arg_16_0.mainCharacterPowerChange, arg_16_0)
	arg_16_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.WarChessCharacterSkillSuccess, arg_16_0.onSkillRelease, arg_16_0)
	arg_16_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.CharacterHpDamageFlyEffectPlayFinish, arg_16_0.mainCharacterHpChangeFlyFinish, arg_16_0)
	arg_16_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.TeamChessSelectEffectBegin, arg_16_0.initTeamChessSkill, arg_16_0)
	arg_16_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.TeamChessSelectEffectEnd, arg_16_0.onTeamChessSkillRelease, arg_16_0)
	arg_16_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessOnFlowStart, arg_16_0.teamChessOnFlowStart, arg_16_0)
	arg_16_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessOnFlowEnd, arg_16_0.teamChessOnFlowEnd, arg_16_0)
	arg_16_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.EnemyForecastChessIdUpdate, arg_16_0.updateEnemyForecastChess, arg_16_0)
	arg_16_0:addEventCb(EliminateChessController.instance, EliminateChessEvent.PerformBegin, arg_16_0.eliminateOnPerformBegin, arg_16_0)
	arg_16_0:addEventCb(EliminateChessController.instance, EliminateChessEvent.PerformEnd, arg_16_0.eliminateOnPerformEnd, arg_16_0)
	arg_16_0:addEventCb(EliminateChessController.instance, EliminateChessEvent.Match3ChessBeginViewClose, arg_16_0.match3ChessBeginViewClose, arg_16_0)
	EliminateLevelController.instance:changeRoundType(EliminateEnum.RoundType.TeamChess)
	arg_16_0:hideEnemyInfoView()
	arg_16_0:initInfo()
	arg_16_0:initTask()
	arg_16_0:refreshInfo()
	arg_16_0:loadAndSetMaskSprite()
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.updateInfo(arg_18_0)
	return
end

local var_0_5 = ZProj.UIEffectsCollection

function var_0_0.initTask(arg_19_0)
	arg_19_0._isShowTaskPanel = false

	gohelper.setActive(arg_19_0._goTaskPanel, arg_19_0._isShowTaskPanel)
	gohelper.setActive(arg_19_0._btnTaskcancel, arg_19_0._isShowTaskPanel)

	local var_19_0 = EliminateTeamChessModel.instance:getCurWarChessEpisodeConfig()

	arg_19_0._taskItem = arg_19_0:getUserDataTb_()

	local var_19_1 = EliminateTeamChessModel.instance:getCurTeamChessWar()

	if not string.nilorempty(var_19_0.winCondition) then
		local var_19_2 = gohelper.clone(arg_19_0._goItem, arg_19_0._imageTaskBG.gameObject, "taskItem")
		local var_19_3 = var_0_5.Get(var_19_2)

		gohelper.findChildText(var_19_2, "#txt_TaskTarget").text = EliminateLevelModel.instance.formatString(var_19_0.winConditionDesc)

		var_19_3:SetGray(not var_19_1:winConditionIsFinish())
		gohelper.setActive(var_19_2, true)

		arg_19_0._taskItem[1] = var_19_3
	end

	if not string.nilorempty(var_19_0.extraWinCondition) then
		local var_19_4 = gohelper.clone(arg_19_0._goItem, arg_19_0._imageTaskBG.gameObject, "taskItem")
		local var_19_5 = var_0_5.Get(var_19_4)

		gohelper.findChildText(var_19_4, "#txt_TaskTarget").text = EliminateLevelModel.instance.formatString(var_19_0.extraWinConditionDesc)

		var_19_5:SetGray(not var_19_1:extraWinConditionIsFinish())
		gohelper.setActive(var_19_4, true)

		arg_19_0._taskItem[2] = var_19_5
	end
end

function var_0_0.initInfo(arg_20_0)
	local var_20_0 = EliminateTeamChessModel.instance:getCurTeamMyInfo()

	if var_20_0 then
		local var_20_1 = EliminateConfig.instance:getTeamChessCharacterConfig(var_20_0.id)

		if var_20_1.resPic then
			arg_20_0._simageRole:LoadImage(ResUrl.getHeadIconSmall(var_20_1.resPic))
		end

		local var_20_2 = EliminateConfig.instance:getMainCharacterSkillConfig(var_20_1.activeSkillIds)
		local var_20_3 = var_20_2 and var_20_2.icon or ""

		if not string.nilorempty(var_20_3) then
			UISpriteSetMgr.instance:setV2a2EliminateSprite(arg_20_0._imageRoleSkill, var_20_3, false)
		end
	end

	local var_20_4 = EliminateTeamChessModel.instance:getCurTeamEnemyInfo()

	if var_20_4 then
		local var_20_5 = EliminateConfig.instance:getTeamChessEnemyConfig(var_20_4.id)

		if var_20_5.headImg then
			arg_20_0._simageEnemy:LoadImage(ResUrl.getHeadIconSmall(var_20_5.headImg))
		end
	end
end

function var_0_0.refreshInfo(arg_21_0)
	arg_21_0:refreshHpInfo()
	arg_21_0:refreshSkillPowerInfo()
	arg_21_0:updateEnemyForecastChess()
	gohelper.setActive(arg_21_0._goRoleSkill, EliminateLevelModel.instance:mainCharacterSkillIsUnLock())
end

function var_0_0.refreshHpInfo(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = EliminateTeamChessModel.instance:getCurTeamMyInfo()

	if var_22_0 then
		local var_22_1 = EliminateConfig.instance:getTeamChessCharacterConfig(var_22_0.id)

		arg_22_0._txtRoleHP.text = var_22_0.hp

		var_0_3.DOFillAmount(arg_22_0._imageRoleHPFG, var_22_0.hp / var_22_1.hp, EliminateTeamChessEnum.hpChangeTime, nil, nil, nil, EaseType.OutQuart)
		var_0_3.DOFillAmount(arg_22_0._imageRolehpfgeff1, var_22_0.hp / var_22_1.hp, EliminateTeamChessEnum.hpChangeTime, nil, nil, nil, EaseType.OutQuart)
		arg_22_0._roleGoUIEffect:SetGray(var_22_0.hp <= 0)
		arg_22_0:setImageGray(arg_22_0._imageRole, var_22_0.hp <= 0)
	end

	local var_22_2 = EliminateTeamChessModel.instance:getCurTeamEnemyInfo()

	if var_22_2 then
		local var_22_3 = EliminateConfig.instance:getTeamChessEnemyConfig(var_22_2.id)

		arg_22_0._txtEnemyHP.text = var_22_2.hp

		local var_22_4 = var_22_3 and var_22_3.hp or 1

		var_0_3.DOFillAmount(arg_22_0._imageEnemyHPFG, var_22_2.hp / var_22_4, EliminateTeamChessEnum.hpChangeTime, nil, nil, nil, EaseType.OutQuart)
		var_0_3.DOFillAmount(arg_22_0._imageEnemyhpfgeff2, var_22_2.hp / var_22_4, EliminateTeamChessEnum.hpChangeTime, nil, nil, nil, EaseType.OutQuart)
		arg_22_0._enemyGoUIEffect:SetGray(var_22_2.hp <= 0)
		arg_22_0:setImageGray(arg_22_0._imageEnemy, var_22_2.hp <= 0)
	end

	if arg_22_1 ~= nil then
		gohelper.setActive(arg_22_0._goenemyvxbreak, false)
		gohelper.setActive(arg_22_0._goEnemyvxdamage, false)
		gohelper.setActive(arg_22_0._goRolevxbreak, false)
		gohelper.setActive(arg_22_0._goRolevxdamage, false)

		if arg_22_1 == EliminateTeamChessEnum.TeamChessTeamType.player then
			local var_22_5 = var_22_0.hp > 0

			gohelper.setActive(arg_22_0._goRolevxdamage, true)
			gohelper.setActive(arg_22_0._goRolevxbreak, not var_22_5)
		end

		if arg_22_1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
			local var_22_6 = var_22_2.hp > 0

			gohelper.setActive(arg_22_0._goEnemyvxdamage, true)
			gohelper.setActive(arg_22_0._goenemyvxbreak, not var_22_6)
		end

		if var_22_2.hp <= 0 or var_22_0.hp <= 0 then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_zhuzhanzhe_death)
		else
			arg_22_2 = arg_22_2 or 1

			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess["play_ui_youyu_attack_" .. arg_22_2])
		end
	end
end

function var_0_0.refreshSkillPowerInfo(arg_23_0)
	local var_23_0 = EliminateTeamChessModel.instance:getCurTeamMyInfo()

	if var_23_0 then
		local var_23_1 = EliminateConfig.instance:getTeamChessCharacterConfig(var_23_0.id)
		local var_23_2 = EliminateConfig.instance:getMainCharacterSkillConfig(var_23_1.activeSkillIds).cost

		if var_23_2 <= var_23_0.power then
			arg_23_0._txtRoleCostNum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("eliminate_skill_power_content1"), var_23_0.power, var_23_2)
		else
			arg_23_0._txtRoleCostNum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("eliminate_skill_power_content2"), var_23_0.power, var_23_2)
		end

		var_0_3.DOFillAmount(arg_23_0._imageRoleSkillFG, var_23_0.power / var_23_2, EliminateTeamChessEnum.powerChangeTime, nil, nil, nil, EaseType.OutQuart)
		var_0_3.DOFillAmount(arg_23_0._imageRoleSkillfgeff1, var_23_0.power / var_23_2, EliminateTeamChessEnum.powerChangeTime, nil, nil, nil, EaseType.OutQuart)
		arg_23_0:updateRoleSkillGray(true)
	end
end

function var_0_0.updateTaskInfo(arg_24_0)
	local var_24_0 = EliminateTeamChessModel.instance:getCurTeamChessWar()

	if arg_24_0._taskItem[1] then
		arg_24_0._taskItem[1]:SetGray(not var_24_0:winConditionIsFinish())
	end

	if arg_24_0._taskItem[2] then
		arg_24_0._taskItem[2]:SetGray(not var_24_0:extraWinConditionIsFinish())
	end

	arg_24_0:match3ChessBeginViewClose(true)
end

function var_0_0.mainCharacterHpChange(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_2 < 0 and math.abs(arg_25_2) > 0 then
		local var_25_0, var_25_1, var_25_2 = transformhelper.getPos(arg_25_0._simageRole.transform)
		local var_25_3, var_25_4, var_25_5 = transformhelper.getPos(arg_25_0._simageEnemy.transform)

		if arg_25_1 == EliminateTeamChessEnum.TeamChessTeamType.player then
			EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.PlayCharacterDamageFlyEffect, arg_25_1, arg_25_2, var_25_3, var_25_4, var_25_0, var_25_1)
		end

		if arg_25_1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
			EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.PlayCharacterDamageFlyEffect, arg_25_1, arg_25_2, var_25_0, var_25_1, var_25_3, var_25_4)
		end
	else
		arg_25_0:refreshHpInfo()
	end
end

function var_0_0.mainCharacterHpChangeFlyFinish(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	if arg_26_1 == EliminateTeamChessEnum.TeamChessTeamType.player then
		local var_26_0, var_26_1, var_26_2 = transformhelper.getPos(arg_26_0._gorolePointDamage.transform)

		EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.PlayDamageEffect, arg_26_2, var_26_0, var_26_1, EliminateTeamChessEnum.HpDamageType.Character)
	end

	if arg_26_1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		local var_26_3, var_26_4, var_26_5 = transformhelper.getPos(arg_26_0._goenemyPointDamage.transform)

		EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.PlayDamageEffect, arg_26_2, var_26_3, var_26_4, EliminateTeamChessEnum.HpDamageType.Character)
	end

	gohelper.setActive(arg_26_0._effectToEnemy, arg_26_1 == EliminateTeamChessEnum.TeamChessTeamType.enemy)
	gohelper.setActive(arg_26_0._effectToPlayer, arg_26_1 == EliminateTeamChessEnum.TeamChessTeamType.player)
	gohelper.setActive(arg_26_0._effectAck, false)
	gohelper.setActive(arg_26_0._effectAck, true)
	arg_26_0:refreshHpInfo(arg_26_1, arg_26_3)
end

function var_0_0.updateEnemyForecastChess(arg_27_0)
	gohelper.setActive(arg_27_0._goEnemySkill, false)

	local var_27_0 = EliminateTeamChessModel.instance:getEnemyForecastChess()

	if var_27_0 then
		local var_27_1 = var_27_0[1]
		local var_27_2 = EliminateConfig.instance:getSoldierChessConfig(var_27_1.chessId)
		local var_27_3 = var_27_1.round
		local var_27_4 = EliminateLevelModel.instance:getRoundNumber()
		local var_27_5 = var_27_2 and var_27_2.resPic or ""

		if not string.nilorempty(var_27_5) then
			UISpriteSetMgr.instance:setV2a2ChessSprite(arg_27_0._imageEnemySkill, var_27_5, false)
			gohelper.setActive(arg_27_0._goEnemySkill, true)
		end

		local var_27_6 = var_27_3 - var_27_4

		arg_27_0._txtEnemyCostNum.text = var_27_6

		local var_27_7 = 1

		if var_27_6 > 0 then
			var_27_7 = 1 / (var_27_6 + 1)
		else
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_skill_release)
		end

		var_0_3.DOFillAmount(arg_27_0._imageenemySkillFG, var_27_7, EliminateTeamChessEnum.teamChessForecastUpdateStep, nil, nil, nil, EaseType.OutQuart)
		var_0_3.DOFillAmount(arg_27_0._imageEnemyskillfgeff2, var_27_7, EliminateTeamChessEnum.teamChessForecastUpdateStep, arg_27_0.hpChangeEnd, arg_27_0, nil, EaseType.OutQuart)
		gohelper.setActive(arg_27_0._goEnemySkillFull, var_27_6 == 0)
	end
end

function var_0_0.hpChangeEnd(arg_28_0)
	gohelper.setActive(arg_28_0._effectAck, false)
end

function var_0_0.mainCharacterPowerChange(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0:refreshSkillPowerInfo()
end

function var_0_0.updateViewState(arg_30_0, arg_30_1)
	if arg_30_0.showWatchView then
		arg_30_0:setTeamChessViewWatchState()
	end

	local var_30_0 = EliminateLevelModel.instance:getCurRoundType()

	arg_30_0._isTeamChess = var_30_0 == EliminateEnum.RoundType.TeamChess
	arg_30_0._isMatch3Chess = var_30_0 == EliminateEnum.RoundType.Match3Chess
	arg_30_0._isSwitch = arg_30_1

	if arg_30_1 then
		if arg_30_0._isTeamChess and arg_30_0._eliminateChessViewAni then
			arg_30_0._eliminateChessViewAni:Play("close")
		end

		if arg_30_0._isMatch3Chess and arg_30_0._teamChessViewAni then
			arg_30_0._teamChessViewAni:Play("close")
		end

		arg_30_0._ani:Play("fightin")
		TaskDispatcher.runDelay(arg_30_0.refreshViewActive, arg_30_0, 0.67)
	else
		arg_30_0:refreshViewActive()
	end

	local var_30_1 = EliminateTeamChessModel.instance:getCurWarChessEpisodeConfig()
	local var_30_2 = var_30_1 and var_30_1.chessScene == "scenes/v2a2_m_s12_xdwf/scenes_prefab/v2a2_m_s12_xdwf_jd_p.prefab"

	arg_30_0._teamchessMaskCanvasGroup2.alpha = arg_30_0._isTeamChess and var_30_2 and 1 or 0
	arg_30_0._eliminatechessMaskCanvasGroup2.alpha = arg_30_0._isMatch3Chess and var_30_2 and 1 or 0
	arg_30_0._eliminatechessMaskCanvasGroup.alpha = arg_30_0._isMatch3Chess and 1 or 0
	arg_30_0._teamchessMaskCanvasGroup.alpha = arg_30_0._isTeamChess and 1 or 0

	arg_30_0._goEnemySkill.transform:SetParent(arg_30_0._isMatch3Chess and arg_30_0._goEnemySkillPoint1.transform or arg_30_0._goEnemySkillPoint2.transform)
	arg_30_0._goRoleSkill.transform:SetParent(arg_30_0._isMatch3Chess and arg_30_0._goRoleSkillPoint1.transform or arg_30_0._goRoleSkillPoint2.transform)
	transformhelper.setLocalPos(arg_30_0._goEnemySkill.transform, 0, 0, 0)
	transformhelper.setLocalPos(arg_30_0._goRoleSkill.transform, 0, 0, 0)
	gohelper.setActive(arg_30_0._imageEnemyBG2.gameObject, arg_30_0._isTeamChess)
	gohelper.setActive(arg_30_0._imageRoleBG2.gameObject, arg_30_0._isTeamChess)
	gohelper.setActive(arg_30_0._imageEnemyBG.gameObject, arg_30_0._isMatch3Chess)
	gohelper.setActive(arg_30_0._imageRoleBG.gameObject, arg_30_0._isMatch3Chess)

	arg_30_0._txtTurns.text = EliminateLevelModel.instance:getRoundNumber()
	arg_30_0._txtPointView.text = luaLang("eliminate_watch_teamchess")

	arg_30_0:refreshInfo()
	arg_30_0:onSkillReleaseCancel(true)

	arg_30_0._canUseSkill = arg_30_0._isMatch3Chess
end

function var_0_0.refreshViewActive(arg_31_0)
	arg_31_0:setTeamChessViewActive(arg_31_0._isTeamChess)
	arg_31_0:setEliminateViewActive(arg_31_0._isMatch3Chess)

	if arg_31_0._isSwitch then
		arg_31_0._ani:Play("fightout")
	end

	TaskDispatcher.runDelay(arg_31_0.refreshLightAni, arg_31_0, 0.33)

	arg_31_0._isShowTaskPanel = arg_31_0._isTeamChess

	arg_31_0:setTaskViewActive()
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.EliminateRoundStateChangeEnd)
	arg_31_0:updateRoleSkillGray(false)
end

function var_0_0.refreshLightAni(arg_32_0)
	if arg_32_0._isTeamChess and arg_32_0._eliminateLightAni then
		arg_32_0._eliminateLightAni:Play("open")
	end

	if arg_32_0._isMatch3Chess and arg_32_0._pointLightAni then
		arg_32_0._pointLightAni:Play("open")
	end
end

function var_0_0.setTeamChessViewActive(arg_33_0, arg_33_1)
	gohelper.setActive(arg_33_0._goteamchess, arg_33_1)
	gohelper.setActiveCanvasGroup(arg_33_0._goEliminateLight, arg_33_1)
	gohelper.setActiveCanvasGroup(arg_33_0._goPoint, arg_33_1)
end

function var_0_0.setEliminateViewActive(arg_34_0, arg_34_1)
	gohelper.setActive(arg_34_0._goeliminatechess, arg_34_1)
	gohelper.setActiveCanvasGroup(arg_34_0._goEliminate, arg_34_1)
	gohelper.setActiveCanvasGroup(arg_34_0._goPointLight, arg_34_1)
	gohelper.setActive(arg_34_0._btnPointViewBtn, arg_34_1)
end

function var_0_0.setTeamChessViewWatchState(arg_35_0)
	arg_35_0.showWatchView = not arg_35_0.showWatchView

	gohelper.setActive(arg_35_0._goRoleSkill, not arg_35_0.showWatchView)
	arg_35_0:updateTeamChessViewWatchState(arg_35_0.showWatchView)
	EliminateLevelModel.instance:setIsWatchTeamChess(arg_35_0.showWatchView)
	arg_35_0:updateRoleSkillGray(false)
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessViewWatchView, arg_35_0.showWatchView)
end

function var_0_0.updateTeamChessViewWatchState(arg_36_0, arg_36_1)
	gohelper.setActive(arg_36_0._goteamchess, arg_36_1)
	gohelper.setActive(arg_36_0._goeliminatechess, not arg_36_1)

	arg_36_0._txtPointView.text = arg_36_1 and luaLang("eliminate_return_match3") or luaLang("eliminate_watch_teamchess")
end

function var_0_0.showSkillView(arg_37_0)
	local var_37_0 = EliminateTeamChessModel.instance:getCurTeamMyInfo()

	if var_37_0 == nil then
		return
	end

	local var_37_1 = EliminateConfig.instance:getTeamChessCharacterConfig(var_37_0.id)
	local var_37_2 = {
		point = arg_37_0._goRolePoint,
		showType = EliminateLevelEnum.skillShowType.skill,
		skillId = var_37_1.activeSkillIds
	}

	ViewMgr.instance:openView(ViewName.EliminateCharacterSkillTipView, var_37_2)
end

function var_0_0.showEnemySkillView(arg_38_0)
	local var_38_0 = EliminateTeamChessModel.instance:getEnemyForecastChess()

	if var_38_0 == nil then
		return
	end

	local var_38_1 = {
		forecastChess = var_38_0,
		point = arg_38_0._goEnemyPoint,
		showType = EliminateLevelEnum.skillShowType.forecast
	}

	ViewMgr.instance:openView(ViewName.EliminateCharacterSkillTipView, var_38_1)
end

function var_0_0._pointViewListClick(arg_39_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_open)
	arg_39_0:setTeamChessViewWatchState()
end

function var_0_0.match3ChessBeginViewClose(arg_40_0, arg_40_1)
	local var_40_0 = EliminateLevelModel.instance:getCurRoundType()
	local var_40_1 = EliminateLevelModel.instance:getRoundNumber()
	local var_40_2 = EliminateEnum.levelTargetTipShowTime

	if var_40_0 == EliminateEnum.RoundType.TeamChess then
		var_40_2 = EliminateEnum.levelTargetTipShowTimeInTeamChess
		arg_40_1 = true
	elseif var_40_1 == 1 then
		var_40_2 = EliminateEnum.levelTargetTipShowTime
		arg_40_1 = true
	else
		var_40_2 = EliminateEnum.levelTargetTipShowTimeInTeamChess
	end

	if arg_40_1 ~= nil and arg_40_1 then
		arg_40_0:changeShowTaskPanelState()
		TaskDispatcher.runDelay(arg_40_0.changeShowTaskPanelState, arg_40_0, var_40_2)
	end
end

function var_0_0.initCharacterSkill(arg_41_0)
	if arg_41_0._skillReleaseView == nil then
		arg_41_0._skillReleaseView = MonoHelper.addNoUpdateLuaComOnceToGo(arg_41_0._goSkillRelease, EliminateMainCharacterSkill)

		arg_41_0._skillReleaseView:setCanvas(EliminateTeamChessModel.instance:getViewCanvas())
	end

	local var_41_0, var_41_1 = EliminateChessItemController.instance:getMaxWidthAndHeight()

	arg_41_0._skillReleaseView:setTargetTrAndHoleSize(arg_41_0._goeliminatechess.transform, var_41_0, var_41_1, -30, 15)
	arg_41_0._skillReleaseView:setCanvas(EliminateTeamChessModel.instance:getViewCanvas())
	arg_41_0._skillReleaseView:setClickCb(arg_41_0.onSkillReleaseCancel, arg_41_0)
end

function var_0_0.onSkillRelease(arg_42_0)
	local var_42_0 = EliminateLevelModel.instance:getCurRoundType()
	local var_42_1 = EliminateLevelController.instance:getCurSelectSkill()

	if var_42_0 == var_42_1:getEffectRound() and var_42_0 == EliminateEnum.RoundType.Match3Chess then
		EliminateTeamChessModel.instance:updateMainCharacterPower(EliminateTeamChessEnum.TeamChessTeamType.player, -var_42_1:getCost())
	end

	if isTypeOf(var_42_1, CharacterSkillAddDiamondMO) then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_skill_release)
	end

	EliminateLevelController.instance:cancelSkillRelease()
	arg_42_0:hideSkillRelease()
	arg_42_0:refreshSkillPowerInfo()
end

function var_0_0.onSkillReleaseCancel(arg_43_0, arg_43_1)
	EliminateLevelController.instance:cancelSkillRelease()
	arg_43_0:hideSkillRelease()

	if arg_43_1 == nil then
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.WarChessCharacterSkillCancel, true)
	end
end

function var_0_0.skillRelease(arg_44_0)
	local var_44_0 = EliminateTeamChessModel.instance:getCurTeamMyInfo()

	if var_44_0 == nil then
		return
	end

	local var_44_1 = EliminateConfig.instance:getTeamChessCharacterConfig(var_44_0.id)
	local var_44_2 = EliminateConfig.instance:getMainCharacterSkillConfig(var_44_1.activeSkillIds)

	if var_44_2 == nil then
		return
	end

	if EliminateLevelController.instance:setCurSelectSkill(var_44_2.id, var_44_2.effect):getEffectRound() == EliminateEnum.RoundType.TeamChess then
		if EliminateTeamChessModel.instance:getCurTeamRoundStepState() == EliminateTeamChessEnum.TeamChessRoundType.settlement then
			return
		end
	elseif not arg_44_0._canUseSkill then
		return
	end

	if not EliminateLevelController.instance:canReleaseByRound() then
		EliminateLevelController.instance:cancelSkillRelease()

		return
	end

	if EliminateLevelController.instance:canRelease() then
		gohelper.setActive(arg_44_0._goRoleSkillClickEffect, true)
		TaskDispatcher.runDelay(arg_44_0.hideRoleSkillClickEffect, arg_44_0, 2)
		EliminateLevelController.instance:releaseSkill()

		return
	end

	gohelper.setActive(arg_44_0._goSkillRelease, true)
	arg_44_0:initCharacterSkill()
	arg_44_0._skillReleaseView:refreshSkillData()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_skill_release)
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.WarChessCharacterSkillViewOpen)
end

function var_0_0.hideSkillRelease(arg_45_0)
	gohelper.setActive(arg_45_0._goSkillRelease, false)
end

function var_0_0.initTeamChessSkill(arg_46_0, arg_46_1, arg_46_2)
	if arg_46_0._skillReleaseView == nil then
		arg_46_0._skillReleaseView = MonoHelper.addNoUpdateLuaComOnceToGo(arg_46_0._goSkillRelease, EliminateMainCharacterSkill)

		arg_46_0._skillReleaseView:setCanvas(EliminateTeamChessModel.instance:getViewCanvas())
	end

	arg_46_0._skillReleaseView:setTargetTrAndHoleSize(arg_46_0._goteamchess.transform, arg_46_1 + 200, arg_46_2, 20)
	arg_46_0._skillReleaseView:setClickCb(arg_46_0.onTeamChessSkillReleaseCancel, arg_46_0)
	arg_46_0._skillReleaseView:refreshTeamChessSkillData()
	gohelper.setActive(arg_46_0._goSkillRelease, true)
	EliminateTeamChessModel.instance:setTeamChessSkillState(true)
end

function var_0_0.onTeamChessSkillRelease(arg_47_0)
	arg_47_0:hideSkillRelease()
	EliminateTeamChessModel.instance:setTeamChessSkillState(false)
end

function var_0_0.onTeamChessSkillReleaseCancel(arg_48_0)
	arg_48_0:hideSkillRelease()
	EliminateTeamChessModel.instance:setTeamChessSkillState(false)
	EliminateTeamChessController.instance:clearReleasePlaceSkill()
end

function var_0_0.teamChessOnFlowEnd(arg_49_0)
	EliminateLevelController.instance:checkMainSkill()
	EliminateLevelController.instance:checkPlayerSoliderCount()
end

function var_0_0.eliminateOnPerformBegin(arg_50_0)
	arg_50_0._canUseSkill = false
end

function var_0_0.eliminateOnPerformEnd(arg_51_0)
	arg_51_0:refreshSkillPowerInfo()

	arg_51_0._canUseSkill = true
end

function var_0_0.teamChessOnFlowStart(arg_52_0)
	arg_52_0:updateRoleSkillGray(false)
end

function var_0_0.updateRoleSkillGray(arg_53_0, arg_53_1)
	if not EliminateLevelModel.instance:mainCharacterSkillIsUnLock() then
		return
	end

	local var_53_0 = EliminateTeamChessModel.instance:getCurTeamMyInfo()
	local var_53_1 = false
	local var_53_2

	if var_53_0 then
		local var_53_3 = EliminateConfig.instance:getTeamChessCharacterConfig(var_53_0.id)
		local var_53_4 = EliminateConfig.instance:getMainCharacterSkillConfig(var_53_3.activeSkillIds)
		local var_53_5 = EliminateLevelController.instance:getTempSkillMo(var_53_4.id, var_53_4.effect)
		local var_53_6 = not EliminateLevelController.instance:canReleaseByRound(var_53_5) or arg_53_0.showWatchView
		local var_53_7 = EliminateLevelModel.instance:getCurRoundType()

		if var_53_5:getEffectRound() == EliminateEnum.RoundType.TeamChess and var_53_7 == EliminateEnum.RoundType.TeamChess then
			local var_53_8 = EliminateTeamChessModel.instance:getCurTeamRoundStepState() == EliminateTeamChessEnum.TeamChessRoundType.settlement

			var_53_6 = var_53_6 or var_53_8
		end

		local var_53_9 = not var_53_6 and var_53_0.power >= var_53_4.cost

		if var_53_9 and arg_53_1 and not gohelper.isNil(arg_53_0._goRoleSkillFull) and not arg_53_0._goRoleSkillFull.activeInHierarchy then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_skill_release)
		end

		gohelper.setActive(arg_53_0._goRoleSkillFull, var_53_9)
		arg_53_0._roleSkillUIEffect:SetGray(var_53_6)
		arg_53_0:setImageGray(arg_53_0._imageRoleSkill, var_53_6)
	end
end

function var_0_0.setImageGray(arg_54_0, arg_54_1, arg_54_2)
	if arg_54_0.grayMat == nil then
		local var_54_0 = arg_54_0.viewContainer:getSetting().otherRes[9]

		arg_54_0.grayMat = arg_54_0.viewContainer._abLoader:getAssetItem(var_54_0):GetResource()
	end

	if arg_54_0.normalMat == nil then
		local var_54_1 = arg_54_0.viewContainer:getSetting().otherRes[10]

		arg_54_0.normalMat = arg_54_0.viewContainer._abLoader:getAssetItem(var_54_1):GetResource()
	end

	if arg_54_2 then
		arg_54_1.material = arg_54_0.grayMat
	else
		arg_54_1.material = arg_54_0.normalMat
	end
end

function var_0_0.loadAndSetMaskSprite(arg_55_0)
	local var_55_0 = arg_55_0._gorectMask:GetComponent(typeof(ZProj.RectMaskHole))
	local var_55_1 = arg_55_0.viewContainer:getSetting().otherRes[11]
	local var_55_2 = arg_55_0.viewContainer._abLoader:getAssetItem(var_55_1):GetResource()

	if not gohelper.isNil(var_55_2) and not gohelper.isNil(var_55_0) then
		var_55_0.sprite = UnityEngine.Sprite.Create(var_55_2, UnityEngine.Rect.New(0, 0, var_55_2.width, var_55_2.height), Vector2.zero)
	end
end

function var_0_0.hideEnemyInfoView(arg_56_0)
	return
end

function var_0_0.onDestroyView(arg_57_0)
	if arg_57_0.roleSkillLongPress then
		arg_57_0.roleSkillLongPress:RemoveClickListener()
		arg_57_0.roleSkillLongPress:RemoveLongPressListener()

		arg_57_0.roleSkillLongPress = nil
	end

	if arg_57_0.enemyInfoMaskClick then
		arg_57_0.enemyInfoMaskClick:RemoveClickListener()

		arg_57_0.enemyInfoMaskClick = nil
	end

	if arg_57_0.pointViewListClick then
		arg_57_0.pointViewListClick:RemoveClickListener()

		arg_57_0.pointViewListClick = nil
	end

	if arg_57_0.roleClick then
		arg_57_0.roleClick:RemoveClickListener()

		arg_57_0.roleClick = nil
	end

	if arg_57_0.enemySkillClick then
		arg_57_0.enemySkillClick:RemoveLongPressListener()

		arg_57_0.enemySkillClick = nil
	end

	if arg_57_0._skillDetailsView then
		arg_57_0._skillDetailsView:onDestroy()

		arg_57_0._skillDetailsView = nil
	end

	if arg_57_0._skillReleaseView then
		arg_57_0._skillReleaseView:onDestroy()

		arg_57_0._skillReleaseView = nil
	end

	TaskDispatcher.cancelTask(arg_57_0.setTaskViewActive, arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0.changeShowTaskPanelState, arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0.hideRoleSkillClickEffect, arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0.refreshLightAni, arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0.refreshViewActive, arg_57_0)

	arg_57_0._ani = nil
	arg_57_0._taskAni = nil
	arg_57_0._teamChessViewAni = nil
	arg_57_0._eliminateChessViewAni = nil
	arg_57_0._eliminateLightAni = nil
	arg_57_0._pointLightAni = nil
	arg_57_0.grayMat = nil
	arg_57_0.normalMat = nil
end

function var_0_0.setOverrideClose(arg_58_0)
	return
end

return var_0_0
