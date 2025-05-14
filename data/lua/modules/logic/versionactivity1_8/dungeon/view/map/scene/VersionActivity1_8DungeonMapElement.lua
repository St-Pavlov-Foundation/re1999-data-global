module("modules.logic.versionactivity1_8.dungeon.view.map.scene.VersionActivity1_8DungeonMapElement", package.seeall)

local var_0_0 = class("VersionActivity1_8DungeonMapElement", LuaCompBase)
local var_0_1 = 1.6
local var_0_2 = Vector2(1.5, 1.5)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._config = arg_1_1[1]
	arg_1_0._sceneElements = arg_1_1[2]
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
	arg_2_0._transform = arg_2_1.transform

	arg_2_0:updatePos()

	if arg_2_0._resLoader then
		return
	end

	arg_2_0._resLoader = MultiAbLoader.New()
	arg_2_0._resPath = arg_2_0._config.res

	if not string.nilorempty(arg_2_0._resPath) then
		arg_2_0._resLoader:addPath(arg_2_0._resPath)
	end

	arg_2_0._effectPath = arg_2_0._config.effect

	if not string.nilorempty(arg_2_0._effectPath) then
		arg_2_0._resLoader:addPath(arg_2_0._effectPath)
	end

	arg_2_0._resLoader:startLoad(arg_2_0._onResLoaded, arg_2_0)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addEventCb(Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, arg_3_0.onChangeInProgressMissionGroup, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, arg_4_0.onChangeInProgressMissionGroup, arg_4_0)
end

function var_0_0.onChangeInProgressMissionGroup(arg_5_0)
	if arg_5_0:isInProgressOtherMissionGroup() then
		arg_5_0._disableAfterAnimDone = true

		arg_5_0:hideElement()
	else
		arg_5_0._disableAfterAnimDone = false

		arg_5_0:showElement()
	end
end

function var_0_0.updatePos(arg_6_0)
	local var_6_0 = string.splitToNumber(arg_6_0._config.pos, "#")

	transformhelper.setLocalPos(arg_6_0._transform, var_6_0[1] or 0, var_6_0[2] or 0, var_6_0[3] or 0)
end

function var_0_0._onResLoaded(arg_7_0)
	arg_7_0:createMainPrefab()
	arg_7_0:createEffectPrefab()
	arg_7_0:refreshDispatchRemainTime()
	arg_7_0:autoPopInteractView()
	arg_7_0:tryHideSelf()
end

function var_0_0.createMainPrefab(arg_8_0)
	if string.nilorempty(arg_8_0._resPath) then
		return
	end

	local var_8_0 = arg_8_0._resLoader:getAssetItem(arg_8_0._resPath):GetResource(arg_8_0._resPath)

	arg_8_0._itemGo = gohelper.clone(var_8_0, arg_8_0._go)
	arg_8_0.posTransform = arg_8_0._itemGo.transform

	local var_8_1 = arg_8_0._config.resScale

	if var_8_1 and var_8_1 ~= 0 then
		transformhelper.setLocalScale(arg_8_0.posTransform, var_8_1, var_8_1, 1)
	end

	gohelper.setLayer(arg_8_0._itemGo, UnityLayer.Scene, true)
	arg_8_0.addBoxColliderListener(arg_8_0._itemGo, arg_8_0._onClickDown, arg_8_0)
	transformhelper.setLocalPos(arg_8_0.posTransform, 0, 0, -1)
end

function var_0_0.addBoxColliderListener(arg_9_0, arg_9_1, arg_9_2)
	gohelper.addBoxCollider2D(arg_9_0, var_0_2)

	local var_9_0 = ZProj.BoxColliderClickListener.Get(arg_9_0)

	var_9_0:SetIgnoreUI(true)
	var_9_0:AddClickListener(arg_9_1, arg_9_2)
end

function var_0_0.createEffectPrefab(arg_10_0, arg_10_1, arg_10_2)
	if string.nilorempty(arg_10_1) then
		arg_10_1 = arg_10_0._effectPath
		arg_10_2 = arg_10_0._config.tipOffsetPos

		if string.nilorempty(arg_10_1) then
			return
		end
	end

	local var_10_0 = string.splitToNumber(arg_10_2, "#")

	arg_10_0._offsetX = var_10_0[1] or 0
	arg_10_0._offsetY = var_10_0[2] or 0

	local var_10_1 = arg_10_0._resLoader:getAssetItem(arg_10_1):GetResource(arg_10_1)

	arg_10_0._effectGo = gohelper.clone(var_10_1, arg_10_0._go)
	arg_10_0.posTransform = arg_10_0._effectGo.transform

	transformhelper.setLocalPos(arg_10_0._effectGo.transform, arg_10_0._offsetX, arg_10_0._offsetY, -3)
	arg_10_0.addBoxColliderListener(arg_10_0._effectGo, arg_10_0._onClickDown, arg_10_0)

	if VersionActivity1_8DungeonModel.instance:checkIsShowInteractView() then
		arg_10_0:hideElement()
	end
end

function var_0_0.refreshDispatchRemainTime(arg_11_0)
	if not arg_11_0:isDispatch() then
		return
	end

	arg_11_0._sceneElements:addTimeItem(arg_11_0)
end

function var_0_0.autoPopInteractView(arg_12_0)
	if not DungeonMapModel.instance.lastElementBattleId then
		return
	end

	if tonumber(arg_12_0._config.param) == DungeonMapModel.instance.lastElementBattleId then
		arg_12_0:onClick()

		DungeonMapModel.instance.lastElementBattleId = nil
	end
end

function var_0_0.tryHideSelf(arg_13_0)
	if VersionActivity1_8DungeonModel.instance:checkIsShowInteractView() then
		arg_13_0:hideElement()
	end

	arg_13_0:onChangeInProgressMissionGroup()
end

function var_0_0.onClick(arg_14_0)
	local var_14_0 = arg_14_0:getElementId()

	if arg_14_0:isInProgressOtherMissionGroup() then
		GameFacade.showToast(ToastEnum.V1a8Activity157HasDoingOtherMissionGroup)

		return
	end

	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.OnClickElement, var_14_0)
end

function var_0_0._onClickDown(arg_15_0)
	arg_15_0._sceneElements:setMouseElementDown(arg_15_0)
end

function var_0_0.isInProgressOtherMissionGroup(arg_16_0)
	local var_16_0 = arg_16_0:getElementId()
	local var_16_1 = false
	local var_16_2 = Activity157Model.instance:getActId()
	local var_16_3 = Activity157Config.instance:getMissionIdByElementId(var_16_2, var_16_0)

	if var_16_3 then
		var_16_1 = Activity157Config.instance:isSideMission(var_16_2, var_16_3)
	end

	local var_16_4 = false

	if var_16_1 then
		var_16_4 = Activity157Model.instance:isInProgressOtherMissionGroupByElementId(var_16_0)
	end

	return var_16_4
end

function var_0_0.showElement(arg_17_0)
	if arg_17_0:isInProgressOtherMissionGroup() then
		return
	end

	if VersionActivity1_8DungeonModel.instance:checkIsShowInteractView() then
		return
	end

	gohelper.setActive(arg_17_0._go, true)
	arg_17_0:playEffectAnim("wenhao_a_001_in")
end

function var_0_0.hideElement(arg_18_0)
	arg_18_0:playEffectAnim("wenhao_a_001_out")
end

function var_0_0.getElementId(arg_19_0)
	return arg_19_0._config.id
end

function var_0_0.getTransform(arg_20_0)
	return arg_20_0._transform
end

function var_0_0.getElementPos(arg_21_0)
	if not arg_21_0.posTransform then
		logError("not pos transform")

		return
	end

	return transformhelper.getPos(arg_21_0.posTransform)
end

function var_0_0.getConfig(arg_22_0)
	return arg_22_0._config
end

function var_0_0.isValid(arg_23_0)
	return not gohelper.isNil(arg_23_0._go)
end

function var_0_0.isConfigShowArrow(arg_24_0)
	return arg_24_0._config.showArrow == 1
end

function var_0_0.showArrow(arg_25_0)
	local var_25_0 = true
	local var_25_1 = arg_25_0:isConfigShowArrow()

	if var_25_1 then
		var_25_0 = not arg_25_0:isInProgressOtherMissionGroup() and var_25_1
	else
		var_25_0 = false
	end

	return var_25_0
end

function var_0_0.isDispatch(arg_26_0)
	return arg_26_0._config.type == DungeonEnum.ElementType.Dispatch
end

function var_0_0.onDispatchFinish(arg_27_0)
	if arg_27_0.destroyed then
		return
	end

	gohelper.destroy(arg_27_0._effectGo)

	arg_27_0.posTransform = arg_27_0._itemGo and arg_27_0._itemGo.transform or nil
	arg_27_0._effectAnimator = nil

	arg_27_0:createEffectPrefab()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
	DispatchController.instance:dispatchEvent(DispatchEvent.OnDispatchFinish)
end

function var_0_0.setFinish(arg_28_0)
	if not arg_28_0._effectGo then
		gohelper.destroy(arg_28_0._itemGo)

		arg_28_0._itemGo = nil

		return
	end

	arg_28_0:playEffectAnim("finish")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)
	TaskDispatcher.runDelay(arg_28_0.onFinishAnimDone, arg_28_0, var_0_1)
end

function var_0_0.onFinishAnimDone(arg_29_0)
	arg_29_0:onDestroy()
end

function var_0_0.playEffectAnim(arg_30_0, arg_30_1)
	if gohelper.isNil(arg_30_0._effectGo) then
		return
	end

	if not arg_30_0._effectGo.activeInHierarchy then
		return
	end

	if gohelper.isNil(arg_30_0._effectAnimator) then
		arg_30_0._effectAnimator = SLFramework.AnimatorPlayer.Get(arg_30_0._effectGo)
	end

	if not gohelper.isNil(arg_30_0._effectAnimator) then
		arg_30_0._effectAnimator:Play(arg_30_1, arg_30_0._effectAnimDone, arg_30_0)
	end
end

function var_0_0._effectAnimDone(arg_31_0)
	if arg_31_0._disableAfterAnimDone then
		gohelper.setActive(arg_31_0._go, false)

		arg_31_0._disableAfterAnimDone = false
	end
end

function var_0_0.onDestroy(arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0.onFinishAnimDone, arg_32_0)
	gohelper.setActive(arg_32_0._go, true)

	if arg_32_0._effectGo then
		gohelper.destroy(arg_32_0._effectGo)

		arg_32_0._effectGo = nil
	end

	if arg_32_0._itemGo then
		gohelper.destroy(arg_32_0._itemGo)

		arg_32_0._itemGo = nil
	end

	if arg_32_0._go then
		gohelper.destroy(arg_32_0._go)

		arg_32_0._go = nil
	end

	if arg_32_0._resLoader then
		arg_32_0._resLoader:dispose()

		arg_32_0._resLoader = nil
	end

	arg_32_0.destroyed = true
end

return var_0_0
