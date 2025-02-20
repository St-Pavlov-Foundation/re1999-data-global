module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateLevelView", package.seeall)

slot0 = class("EliminateLevelView", BaseView)

function slot0.onInitView(slot0)
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")
	slot0._gocameraMain = gohelper.findChild(slot0.viewGO, "#go_cameraMain")
	slot0._simageteamchessMaskBG2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_cameraMain/#simage_teamchessMaskBG2")
	slot0._simageeliminatechessMaskBG = gohelper.findChildSingleImage(slot0.viewGO, "#go_cameraMain/#simage_eliminatechessMaskBG")
	slot0._simageeliminatechessMaskBG2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_cameraMain/#simage_eliminatechessMaskBG2")
	slot0._simageteamchessMaskBG = gohelper.findChildSingleImage(slot0.viewGO, "#go_cameraMain/#simage_teamchessMaskBG")
	slot0._goModeBGDec = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Middle/Title/#go_ModeBGDec")
	slot0._txtTurns = gohelper.findChildText(slot0.viewGO, "#go_cameraMain/Middle/Title/#txt_Turns")
	slot0._goPoint = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Middle/Title/Point/#go_Point")
	slot0._goPointLight = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Middle/Title/Point/#go_PointLight")
	slot0._goEliminate = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Middle/Title/Eliminate/#go_Eliminate")
	slot0._goEliminateLight = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Middle/Title/Eliminate/#go_EliminateLight")
	slot0._goteamchess = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Middle/#go_teamchess")
	slot0._goPointViewList = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Middle/#go_eliminatechess/Right/#go_PointViewList")
	slot0._goeliminatechess = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Middle/#go_eliminatechess")
	slot0._btnTaskcancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cameraMain/Left/Task/#btn_Task_cancel")
	slot0._goTaskPanel = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel")
	slot0._imageTaskBG = gohelper.findChildImage(slot0.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel/#image_TaskBG")
	slot0._goItem = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel/#image_TaskBG/#go_Item")
	slot0._txtTaskTarget = gohelper.findChildText(slot0.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel/#image_TaskBG/#go_Item/#txt_TaskTarget")
	slot0._btnTask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cameraMain/Left/Task/#btn_Task")
	slot0._imageRoleBG = gohelper.findChildImage(slot0.viewGO, "#go_cameraMain/Left/Role/#image_RoleBG")
	slot0._imageRoleBG2 = gohelper.findChildImage(slot0.viewGO, "#go_cameraMain/Left/Role/#image_RoleBG2")
	slot0._imageRoleHPFG = gohelper.findChildImage(slot0.viewGO, "#go_cameraMain/Left/Role/Role/#image_RoleHPFG")
	slot0._imageRolehpfgeff1 = gohelper.findChildImage(slot0.viewGO, "#go_cameraMain/Left/Role/Role/#image_RoleHPFG/#image_Rolehpfg_eff1")
	slot0._simageRole = gohelper.findChildSingleImage(slot0.viewGO, "#go_cameraMain/Left/Role/Role/image/#simage_Role")
	slot0._txtRoleHP = gohelper.findChildText(slot0.viewGO, "#go_cameraMain/Left/Role/Role/image_RoleHPNumBG/#txt_RoleHP")
	slot0._gorolePointDamage = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/Role/Role/#go_rolePointDamage")
	slot0._goRoleSkillPoint1 = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1")
	slot0._goRoleSkill = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill")
	slot0._goRoleSkillBG = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillBG")
	slot0._goRoleSkillBGDisable = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillBGDisable")
	slot0._imageRoleSkill = gohelper.findChildImage(slot0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/image/#image_RoleSkill")
	slot0._goRolevxbreak = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/image/#go_Role_vx_break")
	slot0._imageRoleSkillFG = gohelper.findChildImage(slot0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#image_RoleSkillFG")
	slot0._imageRoleSkillfgeff1 = gohelper.findChildImage(slot0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#image_RoleSkillFG/#image_RoleSkillfg_eff1")
	slot0._goRoleSkillFull = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillFull")
	slot0._goRoleSkillLoop = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillFull/#go_RoleSkill_Loop")
	slot0._goRoleSkillClickEffect = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillClick_Effect")
	slot0._txtRoleCostNum = gohelper.findChildText(slot0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/image_SkillEnergyBG/#txt_RoleCostNum")
	slot0._goRoleSkillClick = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillClick")
	slot0._goRoleSkillPoint2 = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint2")
	slot0._goRolevxdamage = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/Role/#go_Role_vx_damage")
	slot0._imageEnemyBG = gohelper.findChildImage(slot0.viewGO, "#go_cameraMain/Right/Enemy/#image_EnemyBG")
	slot0._imageEnemyBG2 = gohelper.findChildImage(slot0.viewGO, "#go_cameraMain/Right/Enemy/#image_EnemyBG2")
	slot0._goenemyPointDamage = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Right/Enemy/Enemy/#go_enemyPointDamage")
	slot0._imageEnemyHPFG = gohelper.findChildImage(slot0.viewGO, "#go_cameraMain/Right/Enemy/Enemy/#image_EnemyHPFG")
	slot0._imageEnemyhpfgeff2 = gohelper.findChildImage(slot0.viewGO, "#go_cameraMain/Right/Enemy/Enemy/#image_EnemyHPFG/#image_Enemyhpfg_eff2")
	slot0._simageEnemy = gohelper.findChildSingleImage(slot0.viewGO, "#go_cameraMain/Right/Enemy/Enemy/image/#simage_Enemy")
	slot0._goenemyvxbreak = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Right/Enemy/Enemy/image/#go_enemy_vx_break")
	slot0._txtEnemyHP = gohelper.findChildText(slot0.viewGO, "#go_cameraMain/Right/Enemy/Enemy/image_EnemyHPNumBG/#txt_EnemyHP")
	slot0._goEnemySkillPoint1 = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1")
	slot0._goEnemySkill = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill")
	slot0._goEnemySkillBG = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/#go_EnemySkillBG")
	slot0._goEnemySkillBGDisable = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/#go_EnemySkillBGDisable")
	slot0._imageEnemySkill = gohelper.findChildImage(slot0.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/image/#image_EnemySkill")
	slot0._imageenemySkillFG = gohelper.findChildImage(slot0.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/#image_enemySkillFG")
	slot0._imageEnemyskillfgeff2 = gohelper.findChildImage(slot0.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/#image_enemySkillFG/#image_Enemyskillfg_eff2")
	slot0._goEnemySkillFull = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/#go_EnemySkillFull")
	slot0._txtEnemyCostNum = gohelper.findChildText(slot0.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/image_SkillEnergyBG/#txt_EnemyCostNum")
	slot0._goEnemySkillPoint2 = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint2")
	slot0._goEnemyvxdamage = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Right/Enemy/#go_Enemy_vx_damage")
	slot0._btnPointViewBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cameraMain/Right/#btn_PointViewBtn")
	slot0._txtPointView = gohelper.findChildText(slot0.viewGO, "#go_cameraMain/Right/#btn_PointViewBtn/#txt_PointView")
	slot0._goskillViewPoint = gohelper.findChild(slot0.viewGO, "#go_cameraMain/#go_skillViewPoint")
	slot0._goRolePoint = gohelper.findChild(slot0.viewGO, "#go_cameraMain/#go_skillViewPoint/#go_Role_Point")
	slot0._goEnemyPoint = gohelper.findChild(slot0.viewGO, "#go_cameraMain/#go_skillViewPoint/#go_Enemy_Point")
	slot0._goenemyInfo = gohelper.findChild(slot0.viewGO, "#go_cameraMain/#go_enemyInfo")
	slot0._goEnemyChessPoint = gohelper.findChild(slot0.viewGO, "#go_cameraMain/#go_enemyInfo/#go_EnemyChessPoint")
	slot0._goSkillRelease = gohelper.findChild(slot0.viewGO, "#go_cameraMain/#go_SkillRelease")
	slot0._gorectMask = gohelper.findChild(slot0.viewGO, "#go_cameraMain/#go_SkillRelease/#go_rectMask")
	slot0._txtskillTipDesc = gohelper.findChildText(slot0.viewGO, "#go_cameraMain/#go_SkillRelease/#txt_skillTipDesc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnTaskcancel:AddClickListener(slot0._btnTaskcancelOnClick, slot0)
	slot0._btnTask:AddClickListener(slot0._btnTaskOnClick, slot0)
	slot0._btnPointViewBtn:AddClickListener(slot0._btnPointViewBtnOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnTaskcancel:RemoveClickListener()
	slot0._btnTask:RemoveClickListener()
	slot0._btnPointViewBtn:RemoveClickListener()
end

slot1 = SLFramework.UGUI.UILongPressListener
slot2 = SLFramework.UGUI.UIClickListener
slot3 = ZProj.TweenHelper
slot4 = ZProj.UIEffectsCollection

function slot0._btnTaskcancelOnClick(slot0)
	slot0:changeShowTaskPanelState(true)
end

function slot0._btnTaskOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_switch)
	slot0:changeShowTaskPanelState(true)
end

function slot0.changeShowTaskPanelState(slot0, slot1)
	slot0._isShowTaskPanel = not slot0._isShowTaskPanel

	if not slot0._isShowTaskPanel then
		slot0._taskAni:Play("close")
		TaskDispatcher.runDelay(slot0.setTaskViewActive, slot0, 0.27)
	else
		slot0:setTaskViewActive()
	end

	if slot1 then
		gohelper.setActive(slot0._btnTaskcancel, slot0._isShowTaskPanel)
	end
end

function slot0.setTaskViewActive(slot0)
	gohelper.setActive(slot0._goTaskPanel, slot0._isShowTaskPanel)
end

function slot0._btnPointViewBtnOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_open)
	slot0:setTeamChessViewWatchState()
end

function slot0._editableInitView(slot0)
	slot0.roleGo = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/Role/Role")
	slot0.enemyGo = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Right/Enemy/Enemy")
	slot0._goRoleSkillClickEffect = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillClick_Effect")
	slot0._imageRole = gohelper.findChildImage(slot0.viewGO, "#go_cameraMain/Left/Role/Role/image/#simage_Role")
	slot0._imageEnemy = gohelper.findChildImage(slot0.viewGO, "#go_cameraMain/Right/Enemy/Enemy/image/#simage_Enemy")
	slot0._effectAck = gohelper.findChild(slot0.viewGO, "#go_cameraMain/#eff_attack")
	slot0._effectToPlayer = gohelper.findChild(slot0.viewGO, "#go_cameraMain/#eff_attack/1")
	slot0._effectToEnemy = gohelper.findChild(slot0.viewGO, "#go_cameraMain/#eff_attack/2")
	slot0.roleSkillLongPress = uv0.Get(slot0._goRoleSkillClick)

	slot0.roleSkillLongPress:AddClickListener(slot0._roleSkillLongPressClick, slot0)
	slot0.roleSkillLongPress:AddLongPressListener(slot0._roleSkillLongPress, slot0)
	slot0.roleSkillLongPress:SetLongPressTime({
		0.5,
		9999
	})

	slot0.enemyInfoMaskClick = uv1.Get(slot0._goenemyInfo)

	slot0.enemyInfoMaskClick:AddClickListener(slot0.hideEnemyInfoView, slot0)

	slot0.pointViewListClick = uv1.Get(slot0._goPointViewList)

	slot0.pointViewListClick:AddClickListener(slot0._pointViewListClick, slot0)

	slot0.roleClick = uv1.Get(slot0._simageRole.gameObject)

	slot0.roleClick:AddClickListener(slot0.onRoleClick, slot0)

	slot0.enemySkillClick = uv0.Get(slot0._goEnemySkill)

	slot0.enemySkillClick:AddLongPressListener(slot0.showEnemySkillView, slot0)
	slot0.enemySkillClick:SetLongPressTime({
		0.5,
		9999
	})

	slot0._ani = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._taskAni = slot0._goTaskPanel:GetComponent(typeof(UnityEngine.Animator))
	slot0._teamChessViewAni = slot0._goteamchess:GetComponent(typeof(UnityEngine.Animator))
	slot0._eliminateChessViewAni = slot0._goeliminatechess:GetComponent(typeof(UnityEngine.Animator))
	slot0._eliminateLightAni = slot0._goEliminateLight:GetComponent(typeof(UnityEngine.Animator))
	slot0._pointLightAni = slot0._goPointLight:GetComponent(typeof(UnityEngine.Animator))
	slot0._roleSkillUIEffect = uv2.Get(slot0._goRoleSkill)
	slot0._roleGoUIEffect = uv2.Get(slot0.roleGo)
	slot0._enemyGoUIEffect = uv2.Get(slot0.enemyGo)
	slot0._eliminatechessMaskCanvasGroup = slot0._simageeliminatechessMaskBG.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._eliminatechessMaskCanvasGroup2 = slot0._simageeliminatechessMaskBG2.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._teamchessMaskCanvasGroup = slot0._simageteamchessMaskBG.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._teamchessMaskCanvasGroup2 = slot0._simageteamchessMaskBG2.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(slot0._goRoleSkillClickEffect, false)
	gohelper.setActive(slot0._effectAck, false)
	EliminateLevelController.instance:BgSwitch(EliminateEnum.AudioFightStep.FightNormal)
end

function slot0._roleSkillLongPressClick(slot0)
	if not EliminateLevelModel.instance:mainCharacterSkillIsUnLock() then
		GameFacade.showToast(ToastEnum.EliminateMainSkillLocked)

		return
	end

	if not EliminateLevelModel.instance:canReleaseSkill() then
		GameFacade.showToast(ToastEnum.EliminateSkillEnergyNotEnough)

		return
	end

	slot0:skillRelease()
end

function slot0.hideRoleSkillClickEffect(slot0)
	gohelper.setActive(slot0._goRoleSkillClickEffect, false)
end

function slot0._roleSkillLongPress(slot0)
	slot0:showSkillView()
end

function slot0.onRoleClick(slot0)
	EliminateLevelController.instance:clickMainCharacter()
end

function slot0.onUpdateParam(slot0)
end

function slot0.setParent(slot0, slot1, slot2)
	slot0._gocameraMain.transform:SetParent(slot1.transform)
	EliminateTeamChessModel.instance:setViewCanvas(slot2)

	slot3 = slot0._gocameraMain.transform

	transformhelper.setLocalScale(slot3, 0.009259259, 0.009259259, 0.009259259)
	transformhelper.setLocalPos(slot3, 0, 0, 0)
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.EliminateRoundStateChangeGoActive)
end

function slot0.onOpen(slot0)
	slot0.showWatchView = false
	slot0._canUseSkill = true

	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.TeamChessWarInfoUpdate, slot0.updateInfo, slot0)
	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChange, slot0.updateViewState, slot0)
	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.MainCharacterHpChange, slot0.mainCharacterHpChange, slot0)
	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.LevelConditionChange, slot0.updateTaskInfo, slot0)
	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.MainCharacterPowerChange, slot0.mainCharacterPowerChange, slot0)
	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.WarChessCharacterSkillSuccess, slot0.onSkillRelease, slot0)
	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.CharacterHpDamageFlyEffectPlayFinish, slot0.mainCharacterHpChangeFlyFinish, slot0)
	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.TeamChessSelectEffectBegin, slot0.initTeamChessSkill, slot0)
	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.TeamChessSelectEffectEnd, slot0.onTeamChessSkillRelease, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessOnFlowStart, slot0.teamChessOnFlowStart, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessOnFlowEnd, slot0.teamChessOnFlowEnd, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.EnemyForecastChessIdUpdate, slot0.updateEnemyForecastChess, slot0)
	slot0:addEventCb(EliminateChessController.instance, EliminateChessEvent.PerformBegin, slot0.eliminateOnPerformBegin, slot0)
	slot0:addEventCb(EliminateChessController.instance, EliminateChessEvent.PerformEnd, slot0.eliminateOnPerformEnd, slot0)
	slot0:addEventCb(EliminateChessController.instance, EliminateChessEvent.Match3ChessBeginViewClose, slot0.match3ChessBeginViewClose, slot0)
	EliminateLevelController.instance:changeRoundType(EliminateEnum.RoundType.TeamChess)
	slot0:hideEnemyInfoView()
	slot0:initInfo()
	slot0:initTask()
	slot0:refreshInfo()
	slot0:loadAndSetMaskSprite()
end

function slot0.onClose(slot0)
end

function slot0.updateInfo(slot0)
end

slot5 = ZProj.UIEffectsCollection

function slot0.initTask(slot0)
	slot0._isShowTaskPanel = false

	gohelper.setActive(slot0._goTaskPanel, slot0._isShowTaskPanel)
	gohelper.setActive(slot0._btnTaskcancel, slot0._isShowTaskPanel)

	slot0._taskItem = slot0:getUserDataTb_()

	if not string.nilorempty(EliminateTeamChessModel.instance:getCurWarChessEpisodeConfig().winCondition) then
		slot3 = gohelper.clone(slot0._goItem, slot0._imageTaskBG.gameObject, "taskItem")
		slot4 = uv0.Get(slot3)
		gohelper.findChildText(slot3, "#txt_TaskTarget").text = EliminateLevelModel.instance.formatString(slot1.winConditionDesc)

		slot4:SetGray(not EliminateTeamChessModel.instance:getCurTeamChessWar():winConditionIsFinish())
		gohelper.setActive(slot3, true)

		slot0._taskItem[1] = slot4
	end

	if not string.nilorempty(slot1.extraWinCondition) then
		slot3 = gohelper.clone(slot0._goItem, slot0._imageTaskBG.gameObject, "taskItem")
		slot4 = uv0.Get(slot3)
		gohelper.findChildText(slot3, "#txt_TaskTarget").text = EliminateLevelModel.instance.formatString(slot1.extraWinConditionDesc)

		slot4:SetGray(not slot2:extraWinConditionIsFinish())
		gohelper.setActive(slot3, true)

		slot0._taskItem[2] = slot4
	end
end

function slot0.initInfo(slot0)
	if EliminateTeamChessModel.instance:getCurTeamMyInfo() then
		if EliminateConfig.instance:getTeamChessCharacterConfig(slot1.id).resPic then
			slot0._simageRole:LoadImage(ResUrl.getHeadIconSmall(slot2.resPic))
		end

		if not string.nilorempty(EliminateConfig.instance:getMainCharacterSkillConfig(slot2.activeSkillIds) and slot3.icon or "") then
			UISpriteSetMgr.instance:setV2a2EliminateSprite(slot0._imageRoleSkill, slot4, false)
		end
	end

	if EliminateTeamChessModel.instance:getCurTeamEnemyInfo() and EliminateConfig.instance:getTeamChessEnemyConfig(slot2.id).headImg then
		slot0._simageEnemy:LoadImage(ResUrl.getHeadIconSmall(slot3.headImg))
	end
end

function slot0.refreshInfo(slot0)
	slot0:refreshHpInfo()
	slot0:refreshSkillPowerInfo()
	slot0:updateEnemyForecastChess()
	gohelper.setActive(slot0._goRoleSkill, EliminateLevelModel.instance:mainCharacterSkillIsUnLock())
end

function slot0.refreshHpInfo(slot0, slot1, slot2)
	if EliminateTeamChessModel.instance:getCurTeamMyInfo() then
		slot4 = EliminateConfig.instance:getTeamChessCharacterConfig(slot3.id)
		slot0._txtRoleHP.text = slot3.hp

		uv0.DOFillAmount(slot0._imageRoleHPFG, slot3.hp / slot4.hp, EliminateTeamChessEnum.hpChangeTime, nil, , , EaseType.OutQuart)
		uv0.DOFillAmount(slot0._imageRolehpfgeff1, slot3.hp / slot4.hp, EliminateTeamChessEnum.hpChangeTime, nil, , , EaseType.OutQuart)
		slot0._roleGoUIEffect:SetGray(slot3.hp <= 0)
		slot0:setImageGray(slot0._imageRole, slot3.hp <= 0)
	end

	if EliminateTeamChessModel.instance:getCurTeamEnemyInfo() then
		slot0._txtEnemyHP.text = slot4.hp
		slot6 = EliminateConfig.instance:getTeamChessEnemyConfig(slot4.id) and slot5.hp or 1

		uv0.DOFillAmount(slot0._imageEnemyHPFG, slot4.hp / slot6, EliminateTeamChessEnum.hpChangeTime, nil, , , EaseType.OutQuart)
		uv0.DOFillAmount(slot0._imageEnemyhpfgeff2, slot4.hp / slot6, EliminateTeamChessEnum.hpChangeTime, nil, , , EaseType.OutQuart)
		slot0._enemyGoUIEffect:SetGray(slot4.hp <= 0)
		slot0:setImageGray(slot0._imageEnemy, slot4.hp <= 0)
	end

	if slot1 ~= nil then
		gohelper.setActive(slot0._goenemyvxbreak, false)
		gohelper.setActive(slot0._goEnemyvxdamage, false)
		gohelper.setActive(slot0._goRolevxbreak, false)
		gohelper.setActive(slot0._goRolevxdamage, false)

		if slot1 == EliminateTeamChessEnum.TeamChessTeamType.player then
			gohelper.setActive(slot0._goRolevxdamage, true)
			gohelper.setActive(slot0._goRolevxbreak, not (slot3.hp > 0))
		end

		if slot1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
			gohelper.setActive(slot0._goEnemyvxdamage, true)
			gohelper.setActive(slot0._goenemyvxbreak, not (slot4.hp > 0))
		end

		if slot4.hp <= 0 or slot3.hp <= 0 then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_zhuzhanzhe_death)
		else
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess["play_ui_youyu_attack_" .. (slot2 or 1)])
		end
	end
end

function slot0.refreshSkillPowerInfo(slot0)
	if EliminateTeamChessModel.instance:getCurTeamMyInfo() then
		if EliminateConfig.instance:getMainCharacterSkillConfig(EliminateConfig.instance:getTeamChessCharacterConfig(slot1.id).activeSkillIds).cost <= slot1.power then
			slot0._txtRoleCostNum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("eliminate_skill_power_content1"), slot1.power, slot4)
		else
			slot0._txtRoleCostNum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("eliminate_skill_power_content2"), slot1.power, slot4)
		end

		uv0.DOFillAmount(slot0._imageRoleSkillFG, slot1.power / slot4, EliminateTeamChessEnum.powerChangeTime, nil, , , EaseType.OutQuart)
		uv0.DOFillAmount(slot0._imageRoleSkillfgeff1, slot1.power / slot4, EliminateTeamChessEnum.powerChangeTime, nil, , , EaseType.OutQuart)
		slot0:updateRoleSkillGray(true)
	end
end

function slot0.updateTaskInfo(slot0)
	if slot0._taskItem[1] then
		slot0._taskItem[1]:SetGray(not EliminateTeamChessModel.instance:getCurTeamChessWar():winConditionIsFinish())
	end

	if slot0._taskItem[2] then
		slot0._taskItem[2]:SetGray(not slot1:extraWinConditionIsFinish())
	end

	slot0:match3ChessBeginViewClose(true)
end

function slot0.mainCharacterHpChange(slot0, slot1, slot2)
	if slot2 < 0 and math.abs(slot2) > 0 then
		slot3, slot4, slot5 = transformhelper.getPos(slot0._simageRole.transform)
		slot6, slot7, slot8 = transformhelper.getPos(slot0._simageEnemy.transform)

		if slot1 == EliminateTeamChessEnum.TeamChessTeamType.player then
			EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.PlayCharacterDamageFlyEffect, slot1, slot2, slot6, slot7, slot3, slot4)
		end

		if slot1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
			EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.PlayCharacterDamageFlyEffect, slot1, slot2, slot3, slot4, slot6, slot7)
		end
	else
		slot0:refreshHpInfo()
	end
end

function slot0.mainCharacterHpChangeFlyFinish(slot0, slot1, slot2, slot3)
	if slot1 == EliminateTeamChessEnum.TeamChessTeamType.player then
		slot4, slot5, slot6 = transformhelper.getPos(slot0._gorolePointDamage.transform)

		EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.PlayDamageEffect, slot2, slot4, slot5, EliminateTeamChessEnum.HpDamageType.Character)
	end

	if slot1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		slot4, slot5, slot6 = transformhelper.getPos(slot0._goenemyPointDamage.transform)

		EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.PlayDamageEffect, slot2, slot4, slot5, EliminateTeamChessEnum.HpDamageType.Character)
	end

	gohelper.setActive(slot0._effectToEnemy, slot1 == EliminateTeamChessEnum.TeamChessTeamType.enemy)
	gohelper.setActive(slot0._effectToPlayer, slot1 == EliminateTeamChessEnum.TeamChessTeamType.player)
	gohelper.setActive(slot0._effectAck, false)
	gohelper.setActive(slot0._effectAck, true)
	slot0:refreshHpInfo(slot1, slot3)
end

function slot0.updateEnemyForecastChess(slot0)
	gohelper.setActive(slot0._goEnemySkill, false)

	if EliminateTeamChessModel.instance:getEnemyForecastChess() then
		slot2 = slot1[1]
		slot4 = slot2.round
		slot5 = EliminateLevelModel.instance:getRoundNumber()

		if not string.nilorempty(EliminateConfig.instance:getSoldierChessConfig(slot2.chessId) and slot3.resPic or "") then
			UISpriteSetMgr.instance:setV2a2ChessSprite(slot0._imageEnemySkill, slot6, false)
			gohelper.setActive(slot0._goEnemySkill, true)
		end

		slot7 = slot4 - slot5
		slot0._txtEnemyCostNum.text = slot7
		slot8 = 1

		if slot7 > 0 then
			slot8 = 1 / (slot7 + 1)
		else
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_skill_release)
		end

		uv0.DOFillAmount(slot0._imageenemySkillFG, slot8, EliminateTeamChessEnum.teamChessForecastUpdateStep, nil, , , EaseType.OutQuart)
		uv0.DOFillAmount(slot0._imageEnemyskillfgeff2, slot8, EliminateTeamChessEnum.teamChessForecastUpdateStep, slot0.hpChangeEnd, slot0, nil, EaseType.OutQuart)
		gohelper.setActive(slot0._goEnemySkillFull, slot7 == 0)
	end
end

function slot0.hpChangeEnd(slot0)
	gohelper.setActive(slot0._effectAck, false)
end

function slot0.mainCharacterPowerChange(slot0, slot1, slot2)
	slot0:refreshSkillPowerInfo()
end

function slot0.updateViewState(slot0, slot1)
	if slot0.showWatchView then
		slot0:setTeamChessViewWatchState()
	end

	slot0._isTeamChess = EliminateLevelModel.instance:getCurRoundType() == EliminateEnum.RoundType.TeamChess
	slot0._isMatch3Chess = slot2 == EliminateEnum.RoundType.Match3Chess
	slot0._isSwitch = slot1

	if slot1 then
		if slot0._isTeamChess and slot0._eliminateChessViewAni then
			slot0._eliminateChessViewAni:Play("close")
		end

		if slot0._isMatch3Chess and slot0._teamChessViewAni then
			slot0._teamChessViewAni:Play("close")
		end

		slot0._ani:Play("fightin")
		TaskDispatcher.runDelay(slot0.refreshViewActive, slot0, 0.67)
	else
		slot0:refreshViewActive()
	end

	slot4 = EliminateTeamChessModel.instance:getCurWarChessEpisodeConfig() and slot3.chessScene == "scenes/v2a2_m_s12_xdwf/scenes_prefab/v2a2_m_s12_xdwf_jd_p.prefab"
	slot0._teamchessMaskCanvasGroup2.alpha = slot0._isTeamChess and slot4 and 1 or 0
	slot0._eliminatechessMaskCanvasGroup2.alpha = slot0._isMatch3Chess and slot4 and 1 or 0
	slot0._eliminatechessMaskCanvasGroup.alpha = slot0._isMatch3Chess and 1 or 0
	slot0._teamchessMaskCanvasGroup.alpha = slot0._isTeamChess and 1 or 0

	slot0._goEnemySkill.transform:SetParent(slot0._isMatch3Chess and slot0._goEnemySkillPoint1.transform or slot0._goEnemySkillPoint2.transform)
	slot0._goRoleSkill.transform:SetParent(slot0._isMatch3Chess and slot0._goRoleSkillPoint1.transform or slot0._goRoleSkillPoint2.transform)
	transformhelper.setLocalPos(slot0._goEnemySkill.transform, 0, 0, 0)
	transformhelper.setLocalPos(slot0._goRoleSkill.transform, 0, 0, 0)
	gohelper.setActive(slot0._imageEnemyBG2.gameObject, slot0._isTeamChess)
	gohelper.setActive(slot0._imageRoleBG2.gameObject, slot0._isTeamChess)
	gohelper.setActive(slot0._imageEnemyBG.gameObject, slot0._isMatch3Chess)
	gohelper.setActive(slot0._imageRoleBG.gameObject, slot0._isMatch3Chess)

	slot0._txtTurns.text = EliminateLevelModel.instance:getRoundNumber()
	slot0._txtPointView.text = luaLang("eliminate_watch_teamchess")

	slot0:refreshInfo()
	slot0:onSkillReleaseCancel(true)

	slot0._canUseSkill = slot0._isMatch3Chess
end

function slot0.refreshViewActive(slot0)
	slot0:setTeamChessViewActive(slot0._isTeamChess)
	slot0:setEliminateViewActive(slot0._isMatch3Chess)

	if slot0._isSwitch then
		slot0._ani:Play("fightout")
	end

	TaskDispatcher.runDelay(slot0.refreshLightAni, slot0, 0.33)

	slot0._isShowTaskPanel = slot0._isTeamChess

	slot0:setTaskViewActive()
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.EliminateRoundStateChangeEnd)
	slot0:updateRoleSkillGray(false)
end

function slot0.refreshLightAni(slot0)
	if slot0._isTeamChess and slot0._eliminateLightAni then
		slot0._eliminateLightAni:Play("open")
	end

	if slot0._isMatch3Chess and slot0._pointLightAni then
		slot0._pointLightAni:Play("open")
	end
end

function slot0.setTeamChessViewActive(slot0, slot1)
	gohelper.setActive(slot0._goteamchess, slot1)
	gohelper.setActiveCanvasGroup(slot0._goEliminateLight, slot1)
	gohelper.setActiveCanvasGroup(slot0._goPoint, slot1)
end

function slot0.setEliminateViewActive(slot0, slot1)
	gohelper.setActive(slot0._goeliminatechess, slot1)
	gohelper.setActiveCanvasGroup(slot0._goEliminate, slot1)
	gohelper.setActiveCanvasGroup(slot0._goPointLight, slot1)
	gohelper.setActive(slot0._btnPointViewBtn, slot1)
end

function slot0.setTeamChessViewWatchState(slot0)
	slot0.showWatchView = not slot0.showWatchView

	gohelper.setActive(slot0._goRoleSkill, not slot0.showWatchView)
	slot0:updateTeamChessViewWatchState(slot0.showWatchView)
	EliminateLevelModel.instance:setIsWatchTeamChess(slot0.showWatchView)
	slot0:updateRoleSkillGray(false)
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessViewWatchView, slot0.showWatchView)
end

function slot0.updateTeamChessViewWatchState(slot0, slot1)
	gohelper.setActive(slot0._goteamchess, slot1)
	gohelper.setActive(slot0._goeliminatechess, not slot1)

	slot0._txtPointView.text = slot1 and luaLang("eliminate_return_match3") or luaLang("eliminate_watch_teamchess")
end

function slot0.showSkillView(slot0)
	if EliminateTeamChessModel.instance:getCurTeamMyInfo() == nil then
		return
	end

	ViewMgr.instance:openView(ViewName.EliminateCharacterSkillTipView, {
		point = slot0._goRolePoint,
		showType = EliminateLevelEnum.skillShowType.skill,
		skillId = EliminateConfig.instance:getTeamChessCharacterConfig(slot1.id).activeSkillIds
	})
end

function slot0.showEnemySkillView(slot0)
	if EliminateTeamChessModel.instance:getEnemyForecastChess() == nil then
		return
	end

	ViewMgr.instance:openView(ViewName.EliminateCharacterSkillTipView, {
		forecastChess = slot1,
		point = slot0._goEnemyPoint,
		showType = EliminateLevelEnum.skillShowType.forecast
	})
end

function slot0._pointViewListClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_open)
	slot0:setTeamChessViewWatchState()
end

function slot0.match3ChessBeginViewClose(slot0, slot1)
	slot3 = EliminateLevelModel.instance:getRoundNumber()
	slot4 = EliminateEnum.levelTargetTipShowTime

	if EliminateLevelModel.instance:getCurRoundType() == EliminateEnum.RoundType.TeamChess then
		slot4 = EliminateEnum.levelTargetTipShowTimeInTeamChess
		slot1 = true
	elseif slot3 == 1 then
		slot4 = EliminateEnum.levelTargetTipShowTime
		slot1 = true
	else
		slot4 = EliminateEnum.levelTargetTipShowTimeInTeamChess
	end

	if slot1 ~= nil and slot1 then
		slot0:changeShowTaskPanelState()
		TaskDispatcher.runDelay(slot0.changeShowTaskPanelState, slot0, slot4)
	end
end

function slot0.initCharacterSkill(slot0)
	if slot0._skillReleaseView == nil then
		slot0._skillReleaseView = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goSkillRelease, EliminateMainCharacterSkill)

		slot0._skillReleaseView:setCanvas(EliminateTeamChessModel.instance:getViewCanvas())
	end

	slot1, slot2 = EliminateChessItemController.instance:getMaxWidthAndHeight()

	slot0._skillReleaseView:setTargetTrAndHoleSize(slot0._goeliminatechess.transform, slot1, slot2, -30, 15)
	slot0._skillReleaseView:setCanvas(EliminateTeamChessModel.instance:getViewCanvas())
	slot0._skillReleaseView:setClickCb(slot0.onSkillReleaseCancel, slot0)
end

function slot0.onSkillRelease(slot0)
	if EliminateLevelModel.instance:getCurRoundType() == EliminateLevelController.instance:getCurSelectSkill():getEffectRound() and slot1 == EliminateEnum.RoundType.Match3Chess then
		EliminateTeamChessModel.instance:updateMainCharacterPower(EliminateTeamChessEnum.TeamChessTeamType.player, -slot2:getCost())
	end

	if isTypeOf(slot2, CharacterSkillAddDiamondMO) then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_skill_release)
	end

	EliminateLevelController.instance:cancelSkillRelease()
	slot0:hideSkillRelease()
	slot0:refreshSkillPowerInfo()
end

function slot0.onSkillReleaseCancel(slot0, slot1)
	EliminateLevelController.instance:cancelSkillRelease()
	slot0:hideSkillRelease()

	if slot1 == nil then
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.WarChessCharacterSkillCancel, true)
	end
end

function slot0.skillRelease(slot0)
	if EliminateTeamChessModel.instance:getCurTeamMyInfo() == nil then
		return
	end

	if EliminateConfig.instance:getMainCharacterSkillConfig(EliminateConfig.instance:getTeamChessCharacterConfig(slot1.id).activeSkillIds) == nil then
		return
	end

	if EliminateLevelController.instance:setCurSelectSkill(slot3.id, slot3.effect):getEffectRound() == EliminateEnum.RoundType.TeamChess then
		if EliminateTeamChessModel.instance:getCurTeamRoundStepState() == EliminateTeamChessEnum.TeamChessRoundType.settlement then
			return
		end
	elseif not slot0._canUseSkill then
		return
	end

	if not EliminateLevelController.instance:canReleaseByRound() then
		EliminateLevelController.instance:cancelSkillRelease()

		return
	end

	if EliminateLevelController.instance:canRelease() then
		gohelper.setActive(slot0._goRoleSkillClickEffect, true)
		TaskDispatcher.runDelay(slot0.hideRoleSkillClickEffect, slot0, 2)
		EliminateLevelController.instance:releaseSkill()

		return
	end

	gohelper.setActive(slot0._goSkillRelease, true)
	slot0:initCharacterSkill()
	slot0._skillReleaseView:refreshSkillData()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_skill_release)
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.WarChessCharacterSkillViewOpen)
end

function slot0.hideSkillRelease(slot0)
	gohelper.setActive(slot0._goSkillRelease, false)
end

function slot0.initTeamChessSkill(slot0, slot1, slot2)
	if slot0._skillReleaseView == nil then
		slot0._skillReleaseView = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goSkillRelease, EliminateMainCharacterSkill)

		slot0._skillReleaseView:setCanvas(EliminateTeamChessModel.instance:getViewCanvas())
	end

	slot0._skillReleaseView:setTargetTrAndHoleSize(slot0._goteamchess.transform, slot1 + 200, slot2, 20)
	slot0._skillReleaseView:setClickCb(slot0.onTeamChessSkillReleaseCancel, slot0)
	slot0._skillReleaseView:refreshTeamChessSkillData()
	gohelper.setActive(slot0._goSkillRelease, true)
	EliminateTeamChessModel.instance:setTeamChessSkillState(true)
end

function slot0.onTeamChessSkillRelease(slot0)
	slot0:hideSkillRelease()
	EliminateTeamChessModel.instance:setTeamChessSkillState(false)
end

function slot0.onTeamChessSkillReleaseCancel(slot0)
	slot0:hideSkillRelease()
	EliminateTeamChessModel.instance:setTeamChessSkillState(false)
	EliminateTeamChessController.instance:clearReleasePlaceSkill()
end

function slot0.teamChessOnFlowEnd(slot0)
	EliminateLevelController.instance:checkMainSkill()
	EliminateLevelController.instance:checkPlayerSoliderCount()
end

function slot0.eliminateOnPerformBegin(slot0)
	slot0._canUseSkill = false
end

function slot0.eliminateOnPerformEnd(slot0)
	slot0:refreshSkillPowerInfo()

	slot0._canUseSkill = true
end

function slot0.teamChessOnFlowStart(slot0)
	slot0:updateRoleSkillGray(false)
end

function slot0.updateRoleSkillGray(slot0, slot1)
	if not EliminateLevelModel.instance:mainCharacterSkillIsUnLock() then
		return
	end

	slot3 = false
	slot4 = nil

	if EliminateTeamChessModel.instance:getCurTeamMyInfo() then
		slot6 = EliminateConfig.instance:getMainCharacterSkillConfig(EliminateConfig.instance:getTeamChessCharacterConfig(slot2.id).activeSkillIds)

		if slot4:getEffectRound() == EliminateEnum.RoundType.TeamChess and EliminateLevelModel.instance:getCurRoundType() == EliminateEnum.RoundType.TeamChess then
			slot3 = not EliminateLevelController.instance:canReleaseByRound(EliminateLevelController.instance:getTempSkillMo(slot6.id, slot6.effect)) or slot0.showWatchView or EliminateTeamChessModel.instance:getCurTeamRoundStepState() == EliminateTeamChessEnum.TeamChessRoundType.settlement
		end

		if not slot3 and slot6.cost <= slot2.power and slot1 and not gohelper.isNil(slot0._goRoleSkillFull) and not slot0._goRoleSkillFull.activeInHierarchy then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_skill_release)
		end

		gohelper.setActive(slot0._goRoleSkillFull, slot8)
		slot0._roleSkillUIEffect:SetGray(slot3)
		slot0:setImageGray(slot0._imageRoleSkill, slot3)
	end
end

function slot0.setImageGray(slot0, slot1, slot2)
	if slot0.grayMat == nil then
		slot0.grayMat = slot0.viewContainer._abLoader:getAssetItem(slot0.viewContainer:getSetting().otherRes[9]):GetResource()
	end

	if slot0.normalMat == nil then
		slot0.normalMat = slot0.viewContainer._abLoader:getAssetItem(slot0.viewContainer:getSetting().otherRes[10]):GetResource()
	end

	if slot2 then
		slot1.material = slot0.grayMat
	else
		slot1.material = slot0.normalMat
	end
end

function slot0.loadAndSetMaskSprite(slot0)
	slot1 = slot0._gorectMask:GetComponent(typeof(ZProj.RectMaskHole))

	if not gohelper.isNil(slot0.viewContainer._abLoader:getAssetItem(slot0.viewContainer:getSetting().otherRes[11]):GetResource()) and not gohelper.isNil(slot1) then
		slot1.sprite = UnityEngine.Sprite.Create(slot3, UnityEngine.Rect.New(0, 0, slot3.width, slot3.height), Vector2.zero)
	end
end

function slot0.hideEnemyInfoView(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0.roleSkillLongPress then
		slot0.roleSkillLongPress:RemoveClickListener()
		slot0.roleSkillLongPress:RemoveLongPressListener()

		slot0.roleSkillLongPress = nil
	end

	if slot0.enemyInfoMaskClick then
		slot0.enemyInfoMaskClick:RemoveClickListener()

		slot0.enemyInfoMaskClick = nil
	end

	if slot0.pointViewListClick then
		slot0.pointViewListClick:RemoveClickListener()

		slot0.pointViewListClick = nil
	end

	if slot0.roleClick then
		slot0.roleClick:RemoveClickListener()

		slot0.roleClick = nil
	end

	if slot0.enemySkillClick then
		slot0.enemySkillClick:RemoveLongPressListener()

		slot0.enemySkillClick = nil
	end

	if slot0._skillDetailsView then
		slot0._skillDetailsView:onDestroy()

		slot0._skillDetailsView = nil
	end

	if slot0._skillReleaseView then
		slot0._skillReleaseView:onDestroy()

		slot0._skillReleaseView = nil
	end

	TaskDispatcher.cancelTask(slot0.setTaskViewActive, slot0)
	TaskDispatcher.cancelTask(slot0.changeShowTaskPanelState, slot0)
	TaskDispatcher.cancelTask(slot0.hideRoleSkillClickEffect, slot0)
	TaskDispatcher.cancelTask(slot0.refreshLightAni, slot0)
	TaskDispatcher.cancelTask(slot0.refreshViewActive, slot0)

	slot0._ani = nil
	slot0._taskAni = nil
	slot0._teamChessViewAni = nil
	slot0._eliminateChessViewAni = nil
	slot0._eliminateLightAni = nil
	slot0._pointLightAni = nil
	slot0.grayMat = nil
	slot0.normalMat = nil
end

function slot0.setOverrideClose(slot0)
end

return slot0
