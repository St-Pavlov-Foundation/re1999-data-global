module("modules.logic.fight.view.preview.SkillEditorView", package.seeall)

local var_0_0 = class("SkillEditorView", BaseViewExtended)

var_0_0.selectPosId = {
	[FightEnum.EntitySide.MySide] = 1,
	[FightEnum.EntitySide.EnemySide] = 1
}
var_0_0.prevSelectPosId = {
	[FightEnum.EntitySide.MySide] = 1,
	[FightEnum.EntitySide.EnemySide] = 1
}

function var_0_0.setSelectPosId(arg_1_0, arg_1_1)
	var_0_0.prevSelectPosId[arg_1_0] = var_0_0.selectPosId[arg_1_0]
	var_0_0.selectPosId[arg_1_0] = arg_1_1
end

var_0_0.selectSkillId = {}
var_0_0.lockCamera = false
var_0_0.useVirtualCamera2 = false

function var_0_0.onInitView(arg_2_0)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.High)

	arg_2_0._btnSpeed = gohelper.findChildButton(arg_2_0.viewGO, "btnSpeed")
	arg_2_0._btnExit = gohelper.findChildButton(arg_2_0.viewGO, "right/btnExit")
	arg_2_0._btnVisible = gohelper.findChildButton(arg_2_0.viewGO, "right/btnVisible")
	arg_2_0._txtSpeed = gohelper.findChildText(arg_2_0.viewGO, "btnSpeed/Text")
	arg_2_0._btnUseSub = gohelper.findChildButton(arg_2_0.viewGO, "right/btn_use_sub")
	arg_2_0._btnSceneDissolve = gohelper.findChildButton(arg_2_0.viewGO, "right/btn_scene_dissolve")
	arg_2_0._toggleLockCamera = gohelper.findChildToggle(arg_2_0.viewGO, "scene/goToggleRoot/lockCamera")
	arg_2_0._toggleVirtualCamera = gohelper.findChildToggle(arg_2_0.viewGO, "scene/goToggleRoot/toggleVirtualCamera")
	arg_2_0._toggleList = gohelper.findChild(arg_2_0.viewGO, "scene/goToggleRoot")
	arg_2_0._btnShowToggleList = gohelper.findChildButton(arg_2_0.viewGO, "scene/btnToggleList")

	arg_2_0:_updateSpeed()

	local var_2_0 = tonumber(PlayerModel.instance:getPlayinfo().userId)

	gohelper.setActive(arg_2_0._btnExit.gameObject, var_2_0 and var_2_0 ~= 0)
	arg_2_0:_showSceneDissolveBtn()

	var_0_0.lockCamera = false

	FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
end

function var_0_0._showSceneDissolveBtn(arg_3_0)
	local var_3_0 = GameSceneMgr.instance:getScene(SceneType.Fight).level:getCurLevelId()
	local var_3_1 = lua_scene_level.configDict[var_3_0]

	gohelper.setActive(arg_3_0._btnSceneDissolve.gameObject, var_3_1 and var_3_1.sceneId == 115 or false)
end

function var_0_0.addEvents(arg_4_0)
	arg_4_0._btnShowToggleList:AddClickListener(arg_4_0._onBtnShowToggleList, arg_4_0)
	arg_4_0._btnSpeed:AddClickListener(arg_4_0._onClickSpeed, arg_4_0)
	arg_4_0._btnExit:AddClickListener(arg_4_0._onClickExit, arg_4_0)
	arg_4_0._btnVisible:AddClickListener(arg_4_0._onClickVisible, arg_4_0)
	arg_4_0._btnUseSub:AddClickListener(arg_4_0._onBtnUseSub, arg_4_0)
	arg_4_0._btnSceneDissolve:AddClickListener(arg_4_0._onBtnSceneDissolve, arg_4_0)
	arg_4_0._toggleLockCamera:AddOnValueChanged(arg_4_0._onToggleLockCameraChanged, arg_4_0)
	arg_4_0._toggleVirtualCamera:AddOnValueChanged(arg_4_0._onToggleVritualCameraChanged, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.OnSkillEditorSceneChange, arg_4_0._showSceneDissolveBtn, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.SetSkillEditorViewVisible, arg_4_0._onSetSkillEditorViewVisible, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.OnBuffClick, arg_4_0._onBuffClick, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.SetGMViewVisible, arg_4_0.onSetGMViewVisible, arg_4_0)
end

function var_0_0.removeEvents(arg_5_0)
	arg_5_0._btnShowToggleList:RemoveClickListener()
	arg_5_0._btnSpeed:RemoveClickListener()
	arg_5_0._btnExit:RemoveClickListener()
	arg_5_0._btnVisible:RemoveClickListener()
	arg_5_0._btnUseSub:RemoveClickListener()
	arg_5_0._btnSceneDissolve:RemoveClickListener()
	arg_5_0._toggleLockCamera:RemoveOnValueChanged()
	arg_5_0._toggleVirtualCamera:RemoveOnValueChanged()
	arg_5_0:removeEventCb(FightController.instance, FightEvent.OnSkillEditorSceneChange, arg_5_0._showSceneDissolveBtn, arg_5_0)
	arg_5_0:removeEventCb(FightController.instance, FightEvent.SetSkillEditorViewVisible, arg_5_0._onSetSkillEditorViewVisible, arg_5_0)
	arg_5_0:removeEventCb(FightController.instance, FightEvent.OnBuffClick, arg_5_0._onBuffClick, arg_5_0)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:openSubView(SkillEditorToolsBtnView, arg_6_0.viewGO)
end

function var_0_0._updateSpeed(arg_7_0)
	local var_7_0 = FightModel.instance:getUserSpeed() == 1 and 1 or 2

	arg_7_0._txtSpeed.text = string.format("X%d", var_7_0)
end

function var_0_0._onClickSpeed(arg_8_0)
	local var_8_0 = FightModel.instance:getUserSpeed() == 1 and 2 or 1

	FightModel.instance:setUserSpeed(var_8_0)
	FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	arg_8_0:_updateSpeed()
end

function var_0_0._onClickExit(arg_9_0)
	arg_9_0:closeThis()
	SkillEditorMgr.instance:exit()
	FightController.instance:exitFightScene()
end

function var_0_0._onClickVisible(arg_10_0)
	local var_10_0 = gohelper.onceAddComponent(arg_10_0.viewGO, typeof(UnityEngine.CanvasGroup))

	if var_10_0.alpha == 1 then
		var_10_0.alpha = 0

		FightController.instance:dispatchEvent(FightEvent.OnHideSkillEditorUIEvent, 0)
	else
		var_10_0.alpha = 1

		FightController.instance:dispatchEvent(FightEvent.OnHideSkillEditorUIEvent, 1)
	end
end

function var_0_0._onBtnUseSub(arg_11_0)
	if not SkillEditorMgr.instance.select_sub_hero_model then
		return
	end

	local var_11_0 = GameSceneMgr.instance:getCurScene().entityMgr:getEntityByPosId(SceneTag.UnitPlayer, var_0_0.selectPosId[FightEnum.EntitySide.MySide]):getMO()

	if var_11_0.uid == SkillEditorMgr.instance.select_sub_hero_model.uid then
		var_11_0 = FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.MySide)[1]
	end

	GameSceneMgr.instance:getCurScene().entityMgr:removeUnit(SceneTag.UnitPlayer, var_11_0.id)
	FightDataHelper.entityMgr:getById(var_11_0.id):setDead()
	FightController.instance:dispatchEvent(FightEvent.BeforeDeadEffect, var_11_0.id)
	FightController.instance:dispatchEvent(FightEvent.OnEntityDead, var_11_0.id)

	local var_11_1 = {
		fromId = SkillEditorMgr.instance.select_sub_hero_model.uid,
		toId = var_11_0.uid
	}

	arg_11_0.change_hero_work_flow = FlowSequence.New()

	local var_11_2 = FightWorkStepChangeHero.New(var_11_1)

	arg_11_0.change_hero_work_flow:addWork(var_11_2)
	arg_11_0.change_hero_work_flow:addWork(WorkWaitSeconds.New(1))
	arg_11_0.change_hero_work_flow:addWork(FunctionWork.New(function()
		SkillEditorMgr.instance:_buildSubHero()
	end))
	arg_11_0.change_hero_work_flow:start({})
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnSubHeroEnter, SkillEditorMgr.instance.select_sub_hero_model.id)

	SkillEditorMgr.instance.select_sub_hero_model = nil
end

function var_0_0._onBtnSceneDissolve(arg_13_0)
	arg_13_0._loader = MultiAbLoader.New()

	arg_13_0._loader:addPath(ResUrl.getCameraAnim("m_s63_zjmzd/m_s63_zjmzd"))
	arg_13_0._loader:startLoad(arg_13_0._onLoaded, arg_13_0)
end

function var_0_0._onFinish(arg_14_0)
	gohelper.setActive(arg_14_0.viewContainer.viewGO, true)
	FightController.instance:dispatchEvent(FightEvent.SetIsShowNameUI, true)
	TaskDispatcher.cancelTask(arg_14_0._onFinish, arg_14_0)
	UnityEngine.Shader.DisableKeyword("_USEPOP_ON")
end

function var_0_0._onLoaded(arg_15_0)
	gohelper.setActive(arg_15_0.viewContainer.viewGO, false)
	FightController.instance:dispatchEvent(FightEvent.SetIsShowNameUI, false)
	UnityEngine.Shader.EnableKeyword("_USEPOP_ON")

	local var_15_0 = GameSceneMgr.instance:getCurScene().level:getSceneGo().transform:GetComponent(typeof(UnityEngine.Animation))

	var_15_0:Play("m_s63_ani")
	TaskDispatcher.runDelay(arg_15_0._onFinish, arg_15_0, var_15_0.clip.length)

	arg_15_0._animatorInst = arg_15_0._loader:getFirstAssetItem():GetResource()
	arg_15_0._animComp = CameraMgr.instance:getCameraRootAnimator()
	arg_15_0._animComp.enabled = true
	arg_15_0._animComp.runtimeAnimatorController = nil
	arg_15_0._animComp.runtimeAnimatorController = arg_15_0._animatorInst
	arg_15_0._animComp.speed = FightModel.instance:getSpeed()

	arg_15_0._animComp:Play("popcam")
end

function var_0_0._onToggleLockCameraChanged(arg_16_0)
	var_0_0.lockCamera = not var_0_0.lockCamera
	CameraMgr.instance:getMainCameraGO():GetComponent(typeof(Cinemachine.CinemachineBrain)).enabled = not var_0_0.lockCamera
end

function var_0_0._onToggleVritualCameraChanged(arg_17_0)
	var_0_0.useVirtualCamera2 = arg_17_0._toggleVirtualCamera.isOn and true or false

	local var_17_0 = var_0_0.useVirtualCamera2 and 2 or 1

	CameraMgr.instance:switchVirtualCamera(var_17_0)
end

function var_0_0._onBtnShowToggleList(arg_18_0)
	arg_18_0._showToggleList = not arg_18_0._showToggleList

	gohelper.setActive(arg_18_0._toggleList, arg_18_0._showToggleList)
end

function var_0_0.onClose(arg_19_0)
	if arg_19_0.change_hero_work_flow then
		arg_19_0.change_hero_work_flow:stop()

		arg_19_0.change_hero_work_flow = nil
	end

	FightModel.instance:setUserSpeed(1)

	CameraMgr.instance:getMainCameraGO():GetComponent(typeof(Cinemachine.CinemachineBrain)).enabled = true

	FightSystem.instance:dispose()
end

function var_0_0._onSetSkillEditorViewVisible(arg_20_0, arg_20_1)
	TaskDispatcher.runDelay(function()
		if arg_20_0.viewGO then
			gohelper.setActive(arg_20_0.viewGO, arg_20_1)
			FightView._resetCamera()
		end
	end, arg_20_0, 0.16)
end

function var_0_0._onBuffClick(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0 = FightDataHelper.entityMgr:getById(arg_22_1)

	if not var_22_0 then
		logError("get EntityMo fail, entityId : " .. tostring(arg_22_1))

		return
	end

	if isDebugBuild then
		local var_22_1 = {}

		for iter_22_0, iter_22_1 in pairs(var_22_0:getBuffDic()) do
			local var_22_2 = lua_skill_buff.configDict[iter_22_1.buffId]
			local var_22_3 = var_22_2.isNoShow == 0 and "show" or "noShow"
			local var_22_4 = var_22_2.isGoodBuff == 1 and "good" or "bad"
			local var_22_5 = iter_22_1.buffId
			local var_22_6 = var_22_2.name
			local var_22_7 = iter_22_1.count
			local var_22_8 = iter_22_1.duration
			local var_22_9 = var_22_2.desc
			local var_22_10 = string.format("id=%d count=%d duration=%d name=%s desc=%s %s %s", var_22_5, var_22_7, var_22_8, var_22_6, var_22_9, var_22_4, var_22_3)

			table.insert(var_22_1, var_22_10)
		end

		logNormal(string.format("buff list %d :\n%s", #var_22_1, table.concat(var_22_1, "\n")))
	end
end

function var_0_0.onSetGMViewVisible(arg_23_0, arg_23_1)
	gohelper.setActive(arg_23_0.viewGO, arg_23_1)
end

return var_0_0
