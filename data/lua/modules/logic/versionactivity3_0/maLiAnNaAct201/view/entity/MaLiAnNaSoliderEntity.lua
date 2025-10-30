module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.entity.MaLiAnNaSoliderEntity", package.seeall)

local var_0_0 = class("MaLiAnNaSoliderEntity", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
	arg_2_0._tr = arg_2_1.transform
end

function var_0_0.getGo(arg_3_0)
	return arg_3_0._go
end

function var_0_0.initSoliderInfo(arg_4_0, arg_4_1)
	arg_4_0._soliderMo = arg_4_1

	if arg_4_0._soliderMo == nil or arg_4_0._go == nil then
		logError("_go or soliderMo is nil")

		return
	end

	arg_4_0._go.name = string.format("solider_%s", arg_4_0._soliderMo:getId())

	arg_4_0:_updateLocalPos()
	arg_4_0:showModel()
	arg_4_0:setVisible(true, true)
end

function var_0_0.getSoliderMo(arg_5_0)
	return arg_5_0._soliderMo
end

function var_0_0.onUpdate(arg_6_0)
	if Activity201MaLiAnNaGameController.instance:getPause() then
		return false
	end

	if arg_6_0._soliderMo == nil and not arg_6_0._isVisible then
		return false
	end

	arg_6_0:_updateLocalPos()
	arg_6_0:_updateModelDirByMoveDir()

	return true
end

function var_0_0._updateModelDirByMoveDir(arg_7_0)
	if arg_7_0._soliderMo == nil or arg_7_0.goSpineTr == nil then
		return false
	end

	local var_7_0, var_7_1 = arg_7_0._soliderMo:getMoveDir()
	local var_7_2 = var_7_0 > 0 and -1 or 1

	if arg_7_0._lastScaleX == nil or arg_7_0._lastScaleX ~= var_7_2 then
		local var_7_3, var_7_4, var_7_5 = transformhelper.getLocalScale(arg_7_0.goSpineTr)

		transformhelper.setLocalScale(arg_7_0.goSpineTr, math.abs(var_7_3) * var_7_2, var_7_4, var_7_5)

		arg_7_0._lastScaleX = var_7_2

		return true
	end
end

function var_0_0._updateLocalPos(arg_8_0)
	if arg_8_0._soliderMo == nil and arg_8_0._tr == nil then
		return
	end

	local var_8_0, var_8_1 = arg_8_0._soliderMo:getLocalPos()

	transformhelper.setLocalPosXY(arg_8_0._tr, var_8_0, var_8_1)
end

function var_0_0.setVisible(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._isVisible == arg_9_1 and not arg_9_2 then
		return false
	end

	if gohelper.isNil(arg_9_0._go) then
		return false
	end

	arg_9_0._isVisible = arg_9_1

	gohelper.setActive(arg_9_0._go, arg_9_0._isVisible)

	return true
end

function var_0_0.setHide(arg_10_0, arg_10_1)
	if arg_10_0._isHideMode == arg_10_1 then
		return false
	end

	if gohelper.isNil(arg_10_0.goSpine) then
		return false
	end

	arg_10_0._isHideMode = arg_10_1

	gohelper.setActive(arg_10_0.goSpine, arg_10_0._isHideMode)

	return true
end

function var_0_0.isVisible(arg_11_0)
	return arg_11_0._isVisible
end

function var_0_0.clear(arg_12_0)
	arg_12_0._soliderMo = nil

	arg_12_0:setVisible(false, true)
end

function var_0_0.onTriggerEnter(arg_13_0, arg_13_1)
	if arg_13_0._soliderMo == nil then
		return
	end

	local var_13_0 = arg_13_1.gameObject
	local var_13_1 = MonoHelper.getLuaComFromGo(var_13_0, var_0_0)

	if var_13_1 ~= nil then
		local var_13_2 = var_13_1:getSoliderMo()

		if var_13_2:getCamp() ~= arg_13_0._soliderMo:getCamp() then
			Activity201MaLiAnNaGameController.instance:soliderBattle(arg_13_0._soliderMo, var_13_2)
		else
			local var_13_3 = var_13_2:getCurState()

			if arg_13_0._soliderMo:getCurState() == Activity201MaLiAnNaEnum.SoliderState.Moving and (var_13_3 == Activity201MaLiAnNaEnum.SoliderState.Attack or var_13_3 == Activity201MaLiAnNaEnum.SoliderState.StopMove) then
				var_13_2:setRecordSolider(arg_13_0._soliderMo)
				var_13_2:changeRecordSoliderState(true)
			end

			if var_13_3 == Activity201MaLiAnNaEnum.SoliderState.Moving then
				var_13_2:changeRecordSoliderState(false)
			end
		end
	end
end

function var_0_0.onTriggerExit(arg_14_0, arg_14_1)
	if arg_14_0._soliderMo == nil then
		return
	end

	local var_14_0 = arg_14_1.gameObject
	local var_14_1 = MonoHelper.getLuaComFromGo(var_14_0, var_0_0)

	if var_14_1 ~= nil then
		local var_14_2 = var_14_1:getSoliderMo()

		if var_14_2:getCamp() ~= arg_14_0._soliderMo:getCamp() then
			Activity201MaLiAnNaGameController.instance:soliderBattle(arg_14_0._soliderMo, var_14_2)
		else
			local var_14_3 = var_14_2:getCurState()

			if arg_14_0._soliderMo:getCurState() == Activity201MaLiAnNaEnum.SoliderState.Moving and (var_14_3 == Activity201MaLiAnNaEnum.SoliderState.Attack or var_14_3 == Activity201MaLiAnNaEnum.SoliderState.StopMove) then
				var_14_2:setRecordSolider(arg_14_0._soliderMo)
				var_14_2:changeRecordSoliderState(true)
			end

			if var_14_3 == Activity201MaLiAnNaEnum.SoliderState.Moving then
				var_14_2:changeRecordSoliderState(false)
			end
		end
	end
end

function var_0_0.getResPath(arg_15_0)
	return arg_15_0._soliderMo:getConfig().resource
end

function var_0_0.showModel(arg_16_0)
	if not gohelper.isNil(arg_16_0.goSpine) then
		return
	end

	if arg_16_0._loader then
		return
	end

	arg_16_0._loader = PrefabInstantiate.Create(arg_16_0._go)

	local var_16_0 = arg_16_0:getResPath()

	if string.nilorempty(var_16_0) then
		return
	end

	arg_16_0._loader:startLoad(var_16_0, arg_16_0._onResLoadEnd, arg_16_0)
end

function var_0_0._onResLoadEnd(arg_17_0)
	local var_17_0 = arg_17_0._loader:getInstGO()
	local var_17_1 = var_17_0.transform

	arg_17_0.goSpine = var_17_0
	arg_17_0.goSpineTr = var_17_0.transform
	arg_17_0._skeletonAnim = arg_17_0.goSpine:GetComponent(gohelper.Type_Spine_SkeletonGraphic)

	local var_17_2 = arg_17_0:getScale()

	transformhelper.setLocalScale(var_17_1, var_17_2, var_17_2, var_17_2)
	gohelper.addChild(arg_17_0._tr.gameObject, arg_17_0.goSpine)

	local var_17_3, var_17_4, var_17_5 = arg_17_0:getSpineLocalPos()

	transformhelper.setLocalPos(var_17_1, var_17_3, var_17_4, var_17_5)
	transformhelper.setLocalRotation(var_17_1, 0, 0, 0)
	arg_17_0:setVisible(true)

	local var_17_6 = arg_17_0:getAnimName()

	if not string.nilorempty(var_17_6) then
		arg_17_0:play(var_17_6)
	end
end

function var_0_0.getAnimName(arg_18_0)
	if arg_18_0._soliderMo == nil then
		return nil
	end

	local var_18_0 = arg_18_0._soliderMo:getConfig()

	return var_18_0 and var_18_0.animation or nil
end

function var_0_0.play(arg_19_0, arg_19_1)
	if arg_19_0._skeletonAnim == nil then
		return
	end

	arg_19_0._skeletonAnim.raycastTarget = false

	if arg_19_0._skeletonAnim:HasAnimation(arg_19_1) then
		arg_19_0._skeletonAnim:PlayAnim(arg_19_1, true, true)
	else
		local var_19_0 = gohelper.isNil(arg_19_0.goSpine) and "nil" or arg_19_0.goSpine.name

		logError(string.format("animName:%s  goName:%s  Animation Name not exist ", arg_19_1, var_19_0))
	end

	if not arg_19_0._soliderMo:isHero() then
		arg_19_0._skeletonAnim.freeze = true
	end
end

function var_0_0.getSpineLocalPos(arg_20_0)
	return 0, 2.5, 0
end

function var_0_0.getScale(arg_21_0)
	if arg_21_0._soliderMo then
		local var_21_0 = arg_21_0._soliderMo:getConfig()

		if var_21_0 and var_21_0.scale then
			return var_21_0.scale
		end
	end

	return Activity201MaLiAnNaEnum.MaLiAnNaSoliderEntityDefaultScale
end

function var_0_0.onDestroy(arg_22_0)
	arg_22_0:clear()

	if arg_22_0._loader ~= nil then
		arg_22_0._loader:onDestroy()

		arg_22_0._loader = nil
	end

	arg_22_0.goSpine = nil
	arg_22_0.goSpineTr = nil

	if arg_22_0._go then
		gohelper.destroy(arg_22_0._go)

		arg_22_0._go = nil
	end
end

return var_0_0
