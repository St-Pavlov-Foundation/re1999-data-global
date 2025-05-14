module("modules.logic.versionactivity1_6.dungeon.view.map.VersionActivity1_6DungeonMapElement", package.seeall)

local var_0_0 = class("VersionActivity1_6DungeonMapElement", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._config = arg_1_1[1]
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

	arg_5_0._resLoader:startLoad(arg_5_0._onResLoaded, arg_5_0)
end

function var_0_0._onResLoaded(arg_6_0)
	arg_6_0:createMainPrefab()
	arg_6_0:createEffectPrefab()
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

function var_0_0.updatePos(arg_9_0)
	local var_9_0 = string.splitToNumber(arg_9_0._config.pos, "#")

	transformhelper.setLocalPos(arg_9_0._transform, var_9_0[1] or 0, var_9_0[2] or 0, var_9_0[3] or 0)
end

function var_0_0.getTransform(arg_10_0)
	return arg_10_0._transform
end

function var_0_0.getElementPos(arg_11_0)
	if not arg_11_0.posTransform then
		logError("not pos transform")

		return
	end

	return transformhelper.getPos(arg_11_0.posTransform)
end

function var_0_0.getConfig(arg_12_0)
	return arg_12_0._config
end

function var_0_0._onClickDown(arg_13_0)
	arg_13_0._sceneElements:setMouseElementDown(arg_13_0)
end

function var_0_0.onClick(arg_14_0)
	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.OnClickElement, arg_14_0)
end

function var_0_0.showElement(arg_15_0)
	arg_15_0:playEffectAnim("wenhao_a_001_in")
end

function var_0_0.hideElement(arg_16_0)
	arg_16_0:playEffectAnim("wenhao_a_001_out")
end

function var_0_0.playEffectAnim(arg_17_0, arg_17_1)
	arg_17_0._wenhaoAnimName = arg_17_1

	if gohelper.isNil(arg_17_0._effectGo) then
		return
	end

	if not arg_17_0._effectGo.activeInHierarchy then
		return
	end

	if gohelper.isNil(arg_17_0._effectAnimator) then
		arg_17_0._effectAnimator = SLFramework.AnimatorPlayer.Get(arg_17_0._effectGo)
	end

	if not gohelper.isNil(arg_17_0._effectAnimator) then
		arg_17_0._effectAnimator:Play(arg_17_1, arg_17_0._effectAnimDone, arg_17_0)
	end
end

function var_0_0._effectAnimDone(arg_18_0)
	logNormal("effect anim done")
end

function var_0_0.addBoxColliderListener(arg_19_0, arg_19_1, arg_19_2)
	gohelper.addBoxCollider2D(arg_19_0, Vector2(1.5, 1.5))

	local var_19_0 = ZProj.BoxColliderClickListener.Get(arg_19_0)

	var_19_0:SetIgnoreUI(true)
	var_19_0:AddClickListener(arg_19_1, arg_19_2)
end

function var_0_0.isValid(arg_20_0)
	return not gohelper.isNil(arg_20_0._go)
end

function var_0_0.setFinish(arg_21_0)
	if not arg_21_0._effectGo then
		gohelper.destroy(arg_21_0._itemGo)

		arg_21_0._itemGo = nil

		return
	end

	arg_21_0:playEffectAnim("finish")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)
	TaskDispatcher.runDelay(arg_21_0.onFinishAnimDone, arg_21_0, 1.6)
end

function var_0_0.onFinishAnimDone(arg_22_0)
	arg_22_0:onDestroy()
end

function var_0_0.autoPopInteractView(arg_23_0)
	if not DungeonMapModel.instance.lastElementBattleId then
		return
	end

	if tonumber(arg_23_0._config.param) == DungeonMapModel.instance.lastElementBattleId then
		arg_23_0:onClick()

		DungeonMapModel.instance.lastElementBattleId = nil
	end
end

function var_0_0.tryHideSelf(arg_24_0)
	if VersionActivity1_5DungeonModel.instance:checkIsShowInteractView() then
		arg_24_0:hideElement()
	end
end

function var_0_0.onDestroy(arg_25_0)
	gohelper.setActive(arg_25_0._go, true)

	if arg_25_0._effectGo then
		gohelper.destroy(arg_25_0._effectGo)

		arg_25_0._effectGo = nil
	end

	if arg_25_0._itemGo then
		gohelper.destroy(arg_25_0._itemGo)

		arg_25_0._itemGo = nil
	end

	if arg_25_0._go then
		gohelper.destroy(arg_25_0._go)

		arg_25_0._go = nil
	end

	if arg_25_0._resLoader then
		arg_25_0._resLoader:dispose()

		arg_25_0._resLoader = nil
	end

	arg_25_0.destroyed = true
end

return var_0_0
