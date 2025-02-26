module("modules.logic.fight.view.preview.SkillEditorView", package.seeall)

slot0 = class("SkillEditorView", BaseViewExtended)
slot0.selectPosId = {
	[FightEnum.EntitySide.MySide] = 1,
	[FightEnum.EntitySide.EnemySide] = 1
}
slot0.prevSelectPosId = {
	[FightEnum.EntitySide.MySide] = 1,
	[FightEnum.EntitySide.EnemySide] = 1
}

function slot0.setSelectPosId(slot0, slot1)
	uv0.prevSelectPosId[slot0] = uv0.selectPosId[slot0]
	uv0.selectPosId[slot0] = slot1
end

slot0.selectSkillId = {}
slot0.lockCamera = false
slot0.useVirtualCamera2 = false

function slot0.onInitView(slot0)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.High)

	slot0._btnSpeed = gohelper.findChildButton(slot0.viewGO, "btnSpeed")
	slot0._btnExit = gohelper.findChildButton(slot0.viewGO, "right/btnExit")
	slot0._btnVisible = gohelper.findChildButton(slot0.viewGO, "right/btnVisible")
	slot0._txtSpeed = gohelper.findChildText(slot0.viewGO, "btnSpeed/Text")
	slot0._btnUseSub = gohelper.findChildButton(slot0.viewGO, "right/btn_use_sub")
	slot0._btnSceneDissolve = gohelper.findChildButton(slot0.viewGO, "right/btn_scene_dissolve")
	slot0._toggleLockCamera = gohelper.findChildToggle(slot0.viewGO, "scene/goToggleRoot/lockCamera")
	slot0._toggleVirtualCamera = gohelper.findChildToggle(slot0.viewGO, "scene/goToggleRoot/toggleVirtualCamera")
	slot0._toggleList = gohelper.findChild(slot0.viewGO, "scene/goToggleRoot")
	slot0._btnShowToggleList = gohelper.findChildButton(slot0.viewGO, "scene/btnToggleList")

	slot0:_updateSpeed()
	gohelper.setActive(slot0._btnExit.gameObject, tonumber(PlayerModel.instance:getPlayinfo().userId) and slot1 ~= 0)
	slot0:_showSceneDissolveBtn()

	uv0.lockCamera = false

	FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
end

function slot0._showSceneDissolveBtn(slot0)
	gohelper.setActive(slot0._btnSceneDissolve.gameObject, lua_scene_level.configDict[GameSceneMgr.instance:getScene(SceneType.Fight).level:getCurLevelId()] and slot2.sceneId == 115 or false)
end

function slot0.addEvents(slot0)
	slot0._btnShowToggleList:AddClickListener(slot0._onBtnShowToggleList, slot0)
	slot0._btnSpeed:AddClickListener(slot0._onClickSpeed, slot0)
	slot0._btnExit:AddClickListener(slot0._onClickExit, slot0)
	slot0._btnVisible:AddClickListener(slot0._onClickVisible, slot0)
	slot0._btnUseSub:AddClickListener(slot0._onBtnUseSub, slot0)
	slot0._btnSceneDissolve:AddClickListener(slot0._onBtnSceneDissolve, slot0)
	slot0._toggleLockCamera:AddOnValueChanged(slot0._onToggleLockCameraChanged, slot0)
	slot0._toggleVirtualCamera:AddOnValueChanged(slot0._onToggleVritualCameraChanged, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillEditorSceneChange, slot0._showSceneDissolveBtn, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SetSkillEditorViewVisible, slot0._onSetSkillEditorViewVisible, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBuffClick, slot0._onBuffClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnShowToggleList:RemoveClickListener()
	slot0._btnSpeed:RemoveClickListener()
	slot0._btnExit:RemoveClickListener()
	slot0._btnVisible:RemoveClickListener()
	slot0._btnUseSub:RemoveClickListener()
	slot0._btnSceneDissolve:RemoveClickListener()
	slot0._toggleLockCamera:RemoveOnValueChanged()
	slot0._toggleVirtualCamera:RemoveOnValueChanged()
	slot0:removeEventCb(FightController.instance, FightEvent.OnSkillEditorSceneChange, slot0._showSceneDissolveBtn, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SetSkillEditorViewVisible, slot0._onSetSkillEditorViewVisible, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnBuffClick, slot0._onBuffClick, slot0)
end

function slot0.onOpen(slot0)
	slot0:openSubView(SkillEditorToolsBtnView, slot0.viewGO)
end

function slot0._updateSpeed(slot0)
	slot0._txtSpeed.text = string.format("X%d", FightModel.instance:getUserSpeed() == 1 and 1 or 2)
end

function slot0._onClickSpeed(slot0)
	FightModel.instance:setUserSpeed(FightModel.instance:getUserSpeed() == 1 and 2 or 1)
	FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	slot0:_updateSpeed()
end

function slot0._onClickExit(slot0)
	slot0:closeThis()
	SkillEditorMgr.instance:exit()
	FightController.instance:exitFightScene()
end

function slot0._onClickVisible(slot0)
	if gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.CanvasGroup)).alpha == 1 then
		slot1.alpha = 0

		FightController.instance:dispatchEvent(FightEvent.OnHideSkillEditorUIEvent, 0)
	else
		slot1.alpha = 1

		FightController.instance:dispatchEvent(FightEvent.OnHideSkillEditorUIEvent, 1)
	end
end

function slot0._onBtnUseSub(slot0)
	if not SkillEditorMgr.instance.select_sub_hero_model then
		return
	end

	if GameSceneMgr.instance:getCurScene().entityMgr:getEntityByPosId(SceneTag.UnitPlayer, uv0.selectPosId[FightEnum.EntitySide.MySide]):getMO().uid == SkillEditorMgr.instance.select_sub_hero_model.uid then
		slot1 = FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.MySide)[1]
	end

	GameSceneMgr.instance:getCurScene().entityMgr:removeUnit(SceneTag.UnitPlayer, slot1.id)
	FightDataHelper.entityMgr:getById(slot1.id):setDead()
	FightController.instance:dispatchEvent(FightEvent.BeforeDeadEffect, slot1.id)
	FightController.instance:dispatchEvent(FightEvent.OnEntityDead, slot1.id)

	slot0.change_hero_work_flow = FlowSequence.New()

	slot0.change_hero_work_flow:addWork(FightWorkStepChangeHero.New({
		fromId = SkillEditorMgr.instance.select_sub_hero_model.uid,
		toId = slot1.uid
	}))
	slot0.change_hero_work_flow:addWork(WorkWaitSeconds.New(1))
	slot0.change_hero_work_flow:addWork(FunctionWork.New(function ()
		SkillEditorMgr.instance:_buildSubHero()
	end))
	slot0.change_hero_work_flow:start({})
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnSubHeroEnter, SkillEditorMgr.instance.select_sub_hero_model.id)

	SkillEditorMgr.instance.select_sub_hero_model = nil
end

function slot0._onBtnSceneDissolve(slot0)
	slot0._loader = MultiAbLoader.New()

	slot0._loader:addPath(ResUrl.getCameraAnim("m_s63_zjmzd/m_s63_zjmzd"))
	slot0._loader:startLoad(slot0._onLoaded, slot0)
end

function slot0._onFinish(slot0)
	gohelper.setActive(slot0.viewContainer.viewGO, true)
	FightController.instance:dispatchEvent(FightEvent.SetIsShowNameUI, true)
	TaskDispatcher.cancelTask(slot0._onFinish, slot0)
	UnityEngine.Shader.DisableKeyword("_USEPOP_ON")
end

function slot0._onLoaded(slot0)
	gohelper.setActive(slot0.viewContainer.viewGO, false)
	FightController.instance:dispatchEvent(FightEvent.SetIsShowNameUI, false)
	UnityEngine.Shader.EnableKeyword("_USEPOP_ON")

	slot1 = GameSceneMgr.instance:getCurScene().level:getSceneGo().transform:GetComponent(typeof(UnityEngine.Animation))

	slot1:Play("m_s63_ani")
	TaskDispatcher.runDelay(slot0._onFinish, slot0, slot1.clip.length)

	slot0._animatorInst = slot0._loader:getFirstAssetItem():GetResource()
	slot0._animComp = CameraMgr.instance:getCameraRootAnimator()
	slot0._animComp.enabled = true
	slot0._animComp.runtimeAnimatorController = nil
	slot0._animComp.runtimeAnimatorController = slot0._animatorInst
	slot0._animComp.speed = FightModel.instance:getSpeed()

	slot0._animComp:Play("popcam")
end

function slot0._onToggleLockCameraChanged(slot0)
	uv0.lockCamera = not uv0.lockCamera
	CameraMgr.instance:getMainCameraGO():GetComponent(typeof(Cinemachine.CinemachineBrain)).enabled = not uv0.lockCamera
end

function slot0._onToggleVritualCameraChanged(slot0)
	uv0.useVirtualCamera2 = slot0._toggleVirtualCamera.isOn and true or false

	CameraMgr.instance:switchVirtualCamera(uv0.useVirtualCamera2 and 2 or 1)
end

function slot0._onBtnShowToggleList(slot0)
	slot0._showToggleList = not slot0._showToggleList

	gohelper.setActive(slot0._toggleList, slot0._showToggleList)
end

function slot0.onClose(slot0)
	if slot0.change_hero_work_flow then
		slot0.change_hero_work_flow:stop()

		slot0.change_hero_work_flow = nil
	end

	FightModel.instance:setUserSpeed(1)

	CameraMgr.instance:getMainCameraGO():GetComponent(typeof(Cinemachine.CinemachineBrain)).enabled = true

	FightSystem.instance:dispose()
end

function slot0._onSetSkillEditorViewVisible(slot0, slot1)
	TaskDispatcher.runDelay(function ()
		if uv0.viewGO then
			gohelper.setActive(uv0.viewGO, uv1)
			FightView._resetCamera()
		end
	end, slot0, 0.16)
end

function slot0._onBuffClick(slot0, slot1, slot2, slot3, slot4)
	if not FightDataHelper.entityMgr:getById(slot1) then
		logError("get EntityMo fail, entityId : " .. tostring(slot1))

		return
	end

	if isDebugBuild then
		slot6 = {}

		for slot10, slot11 in pairs(slot5:getBuffDic()) do
			table.insert(slot6, string.format("id=%d count=%d duration=%d name=%s desc=%s %s %s", slot11.buffId, slot11.count, slot11.duration, slot12.name, slot12.desc, slot12.isGoodBuff == 1 and "good" or "bad", lua_skill_buff.configDict[slot11.buffId].isNoShow == 0 and "show" or "noShow"))
		end

		logNormal(string.format("buff list %d :\n%s", #slot6, table.concat(slot6, "\n")))
	end
end

return slot0
