module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapElement", package.seeall)

local var_0_0 = class("VersionActivity1_5DungeonMapElement", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._config = arg_1_1[1]
	arg_1_0._extendConfig = lua_activity11502_episode_element.configDict[arg_1_0._config.id]
	arg_1_0._sceneElements = arg_1_1[2]
end

function var_0_0.getElementId(arg_2_0)
	return arg_2_0._config.id
end

function var_0_0.hide(arg_3_0)
	gohelper.setActive(arg_3_0._go, false)
end

function var_0_0.show(arg_4_0)
	gohelper.setActive(arg_4_0._go, true)
end

function var_0_0.init(arg_5_0, arg_5_1)
	arg_5_0._go = arg_5_1
	arg_5_0._transform = arg_5_1.transform

	arg_5_0:updatePos()

	if arg_5_0._resLoader then
		return
	end

	arg_5_0._resLoader = MultiAbLoader.New()
	arg_5_0._resPath = arg_5_0._config.res
	arg_5_0._effectPath = arg_5_0._config.effect

	if not string.nilorempty(arg_5_0._resPath) then
		arg_5_0._resLoader:addPath(arg_5_0._resPath)
	end

	if not string.nilorempty(arg_5_0._effectPath) then
		arg_5_0._resLoader:addPath(arg_5_0._effectPath)
	end

	if arg_5_0._extendConfig and not string.nilorempty(arg_5_0._extendConfig.finishEffect) then
		arg_5_0._finishEffectPath = arg_5_0._extendConfig.finishEffect

		arg_5_0._resLoader:addPath(arg_5_0._finishEffectPath)
	end

	arg_5_0._resLoader:startLoad(arg_5_0._onResLoaded, arg_5_0)
end

function var_0_0._onResLoaded(arg_6_0)
	arg_6_0:createMainPrefab()

	if arg_6_0:isDispatch() then
		arg_6_0:createDispatchPrefab()
	else
		arg_6_0:createEffectPrefab()
	end

	arg_6_0:refreshDispatchRemainTime()
	arg_6_0:autoPopInteractView()
	arg_6_0:tryHideSelf()
end

function var_0_0.createMainPrefab(arg_7_0)
	if string.nilorempty(arg_7_0._resPath) then
		return
	end

	local var_7_0 = arg_7_0._resLoader:getAssetItem(arg_7_0._resPath):GetResource(arg_7_0._resPath)

	arg_7_0._itemGo = gohelper.clone(var_7_0, arg_7_0._go)
	arg_7_0.posTransform = arg_7_0._itemGo.transform

	local var_7_1 = arg_7_0._config.resScale

	if var_7_1 and var_7_1 ~= 0 then
		transformhelper.setLocalScale(arg_7_0.posTransform, var_7_1, var_7_1, 1)
	end

	gohelper.setLayer(arg_7_0._itemGo, UnityLayer.Scene, true)
	arg_7_0.addBoxColliderListener(arg_7_0._itemGo, arg_7_0._onClickDown, arg_7_0)
	transformhelper.setLocalPos(arg_7_0.posTransform, 0, 0, -1)
end

function var_0_0.createEffectPrefab(arg_8_0, arg_8_1, arg_8_2)
	if string.nilorempty(arg_8_1) then
		arg_8_1 = arg_8_0._effectPath
		arg_8_2 = arg_8_0._config.tipOffsetPos

		if string.nilorempty(arg_8_1) then
			return
		end
	end

	local var_8_0 = string.splitToNumber(arg_8_2, "#")

	arg_8_0._offsetX = var_8_0[1] or 0
	arg_8_0._offsetY = var_8_0[2] or 0

	local var_8_1 = arg_8_0._resLoader:getAssetItem(arg_8_1):GetResource(arg_8_1)

	arg_8_0._effectGo = gohelper.clone(var_8_1, arg_8_0._go)
	arg_8_0.posTransform = arg_8_0._effectGo.transform

	transformhelper.setLocalPos(arg_8_0._effectGo.transform, arg_8_0._offsetX, arg_8_0._offsetY, -3)
	arg_8_0.addBoxColliderListener(arg_8_0._effectGo, arg_8_0._onClickDown, arg_8_0)

	if VersionActivity1_5DungeonModel.instance:checkIsShowInteractView() then
		arg_8_0:hideElement()
	end
end

function var_0_0.createDispatchPrefab(arg_9_0)
	local var_9_0 = tonumber(arg_9_0._config.param)
	local var_9_1 = VersionActivity1_5DungeonModel.instance:getDispatchMo(var_9_0)

	if var_9_1 and var_9_1:isFinish() and arg_9_0._extendConfig then
		arg_9_0:createEffectPrefab(arg_9_0._extendConfig.finishEffect, arg_9_0._extendConfig.finishEffectOffsetPos)
	else
		arg_9_0:createEffectPrefab()
	end
end

function var_0_0.isDispatch(arg_10_0)
	return arg_10_0._config.type == DungeonEnum.ElementType.EnterDispatch
end

function var_0_0.refreshDispatchRemainTime(arg_11_0)
	if not arg_11_0:isDispatch() then
		return
	end

	arg_11_0._sceneElements:addTimeItem(arg_11_0)
end

function var_0_0.onDispatchFinish(arg_12_0)
	if arg_12_0.destroyed then
		return
	end

	if arg_12_0._extendConfig.finishEffect == arg_12_0._config.effect then
		logWarn("finish effect equal effect, elementId : " .. tostring(arg_12_0._config.id))
		VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnDispatchFinish)

		return
	end

	gohelper.destroy(arg_12_0._effectGo)

	arg_12_0.posTransform = arg_12_0._itemGo and arg_12_0._itemGo.transform or nil
	arg_12_0._effectAnimator = nil

	arg_12_0:createDispatchPrefab()
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnDispatchFinish)
end

function var_0_0.updatePos(arg_13_0)
	local var_13_0 = string.splitToNumber(arg_13_0._config.pos, "#")

	transformhelper.setLocalPos(arg_13_0._transform, var_13_0[1] or 0, var_13_0[2] or 0, var_13_0[3] or 0)
end

function var_0_0.getTransform(arg_14_0)
	return arg_14_0._transform
end

function var_0_0.getElementPos(arg_15_0)
	if not arg_15_0.posTransform then
		logError("not pos transform")

		return
	end

	return transformhelper.getPos(arg_15_0.posTransform)
end

function var_0_0.getConfig(arg_16_0)
	return arg_16_0._config
end

function var_0_0._onClickDown(arg_17_0)
	arg_17_0._sceneElements:setMouseElementDown(arg_17_0)
end

function var_0_0.onClick(arg_18_0)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnClickElement, arg_18_0)
end

function var_0_0.showElement(arg_19_0)
	arg_19_0:playEffectAnim("wenhao_a_001_in")
end

function var_0_0.hideElement(arg_20_0)
	arg_20_0:playEffectAnim("wenhao_a_001_out")
end

function var_0_0.playEffectAnim(arg_21_0, arg_21_1)
	arg_21_0._wenhaoAnimName = arg_21_1

	if gohelper.isNil(arg_21_0._effectGo) then
		return
	end

	if not arg_21_0._effectGo.activeInHierarchy then
		return
	end

	if gohelper.isNil(arg_21_0._effectAnimator) then
		arg_21_0._effectAnimator = SLFramework.AnimatorPlayer.Get(arg_21_0._effectGo)
	end

	if not gohelper.isNil(arg_21_0._effectAnimator) then
		arg_21_0._effectAnimator:Play(arg_21_1, arg_21_0._effectAnimDone, arg_21_0)
	end
end

function var_0_0._effectAnimDone(arg_22_0)
	logNormal("effect anim done")
end

function var_0_0.addBoxColliderListener(arg_23_0, arg_23_1, arg_23_2)
	gohelper.addBoxCollider2D(arg_23_0, Vector2(1.5, 1.5))

	local var_23_0 = ZProj.BoxColliderClickListener.Get(arg_23_0)

	var_23_0:SetIgnoreUI(true)
	var_23_0:AddClickListener(arg_23_1, arg_23_2)
end

function var_0_0.isValid(arg_24_0)
	return not gohelper.isNil(arg_24_0._go)
end

function var_0_0.setFinish(arg_25_0)
	if not arg_25_0._effectGo then
		gohelper.destroy(arg_25_0._itemGo)

		arg_25_0._itemGo = nil

		return
	end

	arg_25_0:playEffectAnim("finish")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)
	TaskDispatcher.runDelay(arg_25_0.onFinishAnimDone, arg_25_0, 1.6)
end

function var_0_0.onFinishAnimDone(arg_26_0)
	arg_26_0:onDestroy()
end

function var_0_0.autoPopInteractView(arg_27_0)
	if not DungeonMapModel.instance.lastElementBattleId then
		return
	end

	if tonumber(arg_27_0._config.param) == DungeonMapModel.instance.lastElementBattleId then
		arg_27_0:onClick()

		DungeonMapModel.instance.lastElementBattleId = nil
	end
end

function var_0_0.tryHideSelf(arg_28_0)
	if VersionActivity1_5DungeonModel.instance:checkIsShowInteractView() then
		arg_28_0:hideElement()
	end
end

function var_0_0.onDestroy(arg_29_0)
	gohelper.setActive(arg_29_0._go, true)

	if arg_29_0._effectGo then
		gohelper.destroy(arg_29_0._effectGo)

		arg_29_0._effectGo = nil
	end

	if arg_29_0._itemGo then
		gohelper.destroy(arg_29_0._itemGo)

		arg_29_0._itemGo = nil
	end

	if arg_29_0._go then
		gohelper.destroy(arg_29_0._go)

		arg_29_0._go = nil
	end

	if arg_29_0._resLoader then
		arg_29_0._resLoader:dispose()

		arg_29_0._resLoader = nil
	end

	arg_29_0.destroyed = true
end

return var_0_0
