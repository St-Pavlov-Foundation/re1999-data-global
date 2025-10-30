module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.entity.MaLiAnNaBulletEntity", package.seeall)

local var_0_0 = class("MaLiAnNaBulletEntity", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tr = arg_1_1.transform
end

function var_0_0.setOnlyId(arg_2_0, arg_2_1)
	arg_2_0.bulletId = arg_2_1
end

function var_0_0.getOnlyId(arg_3_0)
	return arg_3_0.bulletId
end

function var_0_0.setInfo(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	arg_4_0:_updateTrPos(arg_4_1, arg_4_2)

	arg_4_0._startX = arg_4_1
	arg_4_0._startY = arg_4_2
	arg_4_0._targetSoliderId = arg_4_3
	arg_4_0._speed = arg_4_4 or 0
	arg_4_0._isFollow = arg_4_6 or false
	arg_4_0._bulletPathId = arg_4_5 or 1

	arg_4_0:_updateTargetPos()
	arg_4_0:showModel()
	arg_4_0:setVisible(true)
end

function var_0_0.onUpdate(arg_5_0)
	local var_5_0 = Time.deltaTime

	if not arg_5_0._isVisible or Activity201MaLiAnNaGameController.instance:getPause() then
		return
	end

	arg_5_0:updateLocalPos(var_5_0)
end

function var_0_0.updateLocalPos(arg_6_0, arg_6_1)
	if arg_6_0._tr == nil then
		return
	end

	if arg_6_0._isFollow then
		arg_6_0:_updateTargetPos(arg_6_1)
	end

	if arg_6_1 == nil then
		return
	end

	local var_6_0 = arg_6_0._speed * arg_6_1

	arg_6_0._posX = arg_6_0._posX + arg_6_0._moveDirX * var_6_0
	arg_6_0._posY = arg_6_0._posY + arg_6_0._moveDirY * var_6_0

	arg_6_0:_updateTrPos(arg_6_0._posX, arg_6_0._posY)

	if MathUtil.hasPassedPoint(arg_6_0._posX, arg_6_0._posY, arg_6_0._endPosX, arg_6_0._endPosY, arg_6_0._moveDirX, arg_6_0._moveDirY) or MathUtil.vec2_lengthSqr(arg_6_0._posX, arg_6_0._posY, arg_6_0._startX, arg_6_0._startY) > 1000000 then
		arg_6_0:setVisible(false)
		Activity201MaLiAnNaGameController.instance:consumeSoliderHp(arg_6_0._targetSoliderId, -Activity201MaLiAnNaEnum.bulletDamage)
		MaliAnNaBulletEntityMgr.instance:releaseBulletEffectEntity(arg_6_0)
	end
end

function var_0_0._updateTrPos(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._posX = arg_7_1
	arg_7_0._posY = arg_7_2

	if arg_7_0._posX ~= nil and arg_7_0._posY ~= nil then
		transformhelper.setLocalPosXY(arg_7_0._tr, arg_7_1, arg_7_2)
	end
end

function var_0_0._updateTargetPos(arg_8_0, arg_8_1)
	local var_8_0 = MaLiAnNaLaSoliderMoUtil.instance:getSoliderMoById(arg_8_0._targetSoliderId)

	if var_8_0 ~= nil then
		local var_8_1, var_8_2 = var_8_0:getLocalPos()

		arg_8_0._moveDirX, arg_8_0._moveDirY = MathUtil.vec2_normalize(var_8_1 - arg_8_0._posX, var_8_2 - arg_8_0._posY)
		arg_8_0._endPosX = var_8_1
		arg_8_0._endPosY = var_8_2

		local var_8_3 = MathUtil.calculateV2Angle(arg_8_0._posX, arg_8_0._posY, var_8_1, var_8_2)

		transformhelper.setLocalRotation(arg_8_0._tr, 0, 0, var_8_3)
	end
end

function var_0_0.getResPath(arg_9_0)
	return Activity201MaLiAnNaEnum.BulletEffect[arg_9_0._bulletPathId]
end

function var_0_0.setVisible(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._isVisible == arg_10_1 and not arg_10_2 then
		return
	end

	if arg_10_0.goSpine == nil then
		return
	end

	arg_10_0._isVisible = arg_10_1

	gohelper.setActive(arg_10_0.goSpine, arg_10_0._isVisible)
	gohelper.setActive(arg_10_0._go, arg_10_0._isVisible)
end

function var_0_0.showModel(arg_11_0)
	if not gohelper.isNil(arg_11_0.goSpine) then
		return
	end

	if arg_11_0._loader then
		return
	end

	arg_11_0._loader = PrefabInstantiate.Create(arg_11_0._go)

	local var_11_0 = arg_11_0:getResPath()

	if string.nilorempty(var_11_0) then
		return
	end

	arg_11_0._loader:startLoad(var_11_0, arg_11_0._onResLoadEnd, arg_11_0)
end

function var_0_0._onResLoadEnd(arg_12_0)
	local var_12_0 = arg_12_0._loader:getInstGO()
	local var_12_1 = var_12_0.transform

	arg_12_0.goSpine = var_12_0

	local var_12_2 = arg_12_0:getScale()

	transformhelper.setLocalScale(var_12_1, var_12_2, var_12_2, var_12_2)
	gohelper.addChild(arg_12_0._tr.gameObject, arg_12_0.goSpine)
	transformhelper.setLocalPos(var_12_1, 0, 0, 0)
	transformhelper.setLocalRotation(var_12_1, 0, 0, 0)
	arg_12_0:setVisible(true)
end

function var_0_0.getScale(arg_13_0)
	return 0.5
end

function var_0_0.onDestroy(arg_14_0)
	if arg_14_0._loader ~= nil then
		arg_14_0._loader:onDestroy()

		arg_14_0._loader = nil
	end

	if arg_14_0._go then
		gohelper.destroy(arg_14_0._go)

		arg_14_0._go = nil
	end
end

return var_0_0
