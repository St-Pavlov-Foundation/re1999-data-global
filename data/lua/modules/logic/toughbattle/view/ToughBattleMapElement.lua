module("modules.logic.toughbattle.view.ToughBattleMapElement", package.seeall)

local var_0_0 = class("ToughBattleMapElement", LuaCompBase)
local var_0_1 = Vector2(1.5, 1.5)

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

function var_0_0.updatePos(arg_3_0)
	local var_3_0 = string.splitToNumber(arg_3_0._config.pos, "#")

	transformhelper.setLocalPos(arg_3_0._transform, var_3_0[1] or 0, var_3_0[2] or 0, var_3_0[3] or 0)
end

function var_0_0._onResLoaded(arg_4_0)
	arg_4_0:createMainPrefab()
	arg_4_0:createEffectPrefab()
end

function var_0_0.createMainPrefab(arg_5_0)
	if string.nilorempty(arg_5_0._resPath) then
		return
	end

	local var_5_0 = arg_5_0._resLoader:getAssetItem(arg_5_0._resPath):GetResource(arg_5_0._resPath)

	arg_5_0._itemGo = gohelper.clone(var_5_0, arg_5_0._go)
	arg_5_0.posTransform = arg_5_0._itemGo.transform

	local var_5_1 = arg_5_0._config.resScale

	if var_5_1 and var_5_1 ~= 0 then
		transformhelper.setLocalScale(arg_5_0.posTransform, var_5_1, var_5_1, 1)
	end

	gohelper.setLayer(arg_5_0._itemGo, UnityLayer.Scene, true)
	arg_5_0.addBoxColliderListener(arg_5_0._itemGo, arg_5_0._onClickDown, arg_5_0._onClickUp, arg_5_0)
	transformhelper.setLocalPos(arg_5_0.posTransform, 0, 0, -1)
end

function var_0_0.addBoxColliderListener(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	gohelper.addBoxCollider2D(arg_6_0, var_0_1)

	local var_6_0 = ZProj.BoxColliderClickListener.Get(arg_6_0)

	var_6_0:SetIgnoreUI(true)
	var_6_0:AddClickListener(arg_6_1, arg_6_3)
	var_6_0:AddMouseUpListener(arg_6_2, arg_6_3)
end

function var_0_0.createEffectPrefab(arg_7_0, arg_7_1, arg_7_2)
	if string.nilorempty(arg_7_1) then
		arg_7_1 = arg_7_0._effectPath
		arg_7_2 = arg_7_0._config.tipOffsetPos

		if string.nilorempty(arg_7_1) then
			return
		end
	end

	local var_7_0 = string.splitToNumber(arg_7_2, "#")

	arg_7_0._offsetX = var_7_0[1] or 0
	arg_7_0._offsetY = var_7_0[2] or 0

	local var_7_1 = arg_7_0._resLoader:getAssetItem(arg_7_1):GetResource(arg_7_1)

	arg_7_0._effectGo = gohelper.clone(var_7_1, arg_7_0._go)
	arg_7_0.posTransform = arg_7_0._effectGo.transform

	transformhelper.setLocalPos(arg_7_0._effectGo.transform, arg_7_0._offsetX, arg_7_0._offsetY, -3)
	arg_7_0.addBoxColliderListener(arg_7_0._effectGo, arg_7_0._onClickDown, arg_7_0._onClickUp, arg_7_0)
end

function var_0_0._onClickDown(arg_8_0)
	arg_8_0._sceneElements:setMouseElementDown(arg_8_0, arg_8_0._config)
end

function var_0_0._onClickUp(arg_9_0)
	arg_9_0._sceneElements:setMouseElementUp(arg_9_0, arg_9_0._config)
end

function var_0_0.hide(arg_10_0)
	gohelper.setActive(arg_10_0._go, false)
end

function var_0_0.show(arg_11_0)
	gohelper.setActive(arg_11_0._go, true)
end

function var_0_0.getElementId(arg_12_0)
	return arg_12_0._config.id
end

function var_0_0.getTransform(arg_13_0)
	return arg_13_0._transform
end

function var_0_0.getElementPos(arg_14_0)
	if not arg_14_0.posTransform then
		logError("not pos transform")

		return
	end

	return transformhelper.getPos(arg_14_0.posTransform)
end

function var_0_0.getConfig(arg_15_0)
	return arg_15_0._config
end

function var_0_0.isValid(arg_16_0)
	return not gohelper.isNil(arg_16_0._go)
end

function var_0_0.setFinish(arg_17_0)
	if not arg_17_0._effectGo then
		gohelper.destroy(arg_17_0._itemGo)

		arg_17_0._itemGo = nil

		return
	end

	arg_17_0:playEffectAnim("finish")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)
	TaskDispatcher.runDelay(arg_17_0.onFinishAnimDone, arg_17_0, 1.6)
end

function var_0_0.onFinishAnimDone(arg_18_0)
	arg_18_0:onDestroy()
end

function var_0_0.playEffectAnim(arg_19_0, arg_19_1)
	arg_19_0._wenhaoAnimName = arg_19_1

	if gohelper.isNil(arg_19_0._effectGo) then
		return
	end

	if not arg_19_0._effectGo.activeInHierarchy then
		return
	end

	if gohelper.isNil(arg_19_0._effectAnimator) then
		arg_19_0._effectAnimator = SLFramework.AnimatorPlayer.Get(arg_19_0._effectGo)
	end

	if not gohelper.isNil(arg_19_0._effectAnimator) then
		arg_19_0._effectAnimator:Play(arg_19_1, arg_19_0._effectAnimDone, arg_19_0)
	end
end

function var_0_0._effectAnimDone(arg_20_0)
	logNormal("effect anim done")
end

function var_0_0.onDestroy(arg_21_0)
	if arg_21_0._effectGo then
		gohelper.destroy(arg_21_0._effectGo)

		arg_21_0._effectGo = nil
	end

	if arg_21_0._itemGo then
		gohelper.destroy(arg_21_0._itemGo)

		arg_21_0._itemGo = nil
	end

	if arg_21_0._go then
		gohelper.destroy(arg_21_0._go)

		arg_21_0._go = nil
	end

	if arg_21_0._resLoader then
		arg_21_0._resLoader:dispose()

		arg_21_0._resLoader = nil
	end

	arg_21_0.destroyed = true
end

return var_0_0
