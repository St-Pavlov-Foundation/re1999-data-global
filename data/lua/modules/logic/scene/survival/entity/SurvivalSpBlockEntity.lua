module("modules.logic.scene.survival.entity.SurvivalSpBlockEntity", package.seeall)

local var_0_0 = class("SurvivalSpBlockEntity", SurvivalBlockEntity)

function var_0_0.Create(arg_1_0, arg_1_1)
	local var_1_0 = gohelper.create3d(arg_1_1, tostring(arg_1_0.pos))
	local var_1_1, var_1_2, var_1_3 = SurvivalHelper.instance:hexPointToWorldPoint(arg_1_0.pos.q, arg_1_0.pos.r)
	local var_1_4 = var_1_0.transform

	transformhelper.setLocalPos(var_1_4, var_1_1, var_1_2, var_1_3)
	transformhelper.setLocalRotation(var_1_4, 0, arg_1_0.dir * 60 + 30, 0)

	if arg_1_0.co then
		local var_1_5 = arg_1_0:getResPath()
		local var_1_6 = SurvivalMapHelper.instance:getSpBlockRes(tonumber(arg_1_0.co.copyIds) or 0, var_1_5)

		if var_1_6 then
			local var_1_7 = gohelper.clone(var_1_6, var_1_0).transform

			transformhelper.setLocalPos(var_1_7, 0, 0, 0)
			transformhelper.setLocalRotation(var_1_7, 0, 0, 0)
			transformhelper.setLocalScale(var_1_7, 1, 1, 1)
		else
			logError("加载资源失败！" .. tostring(arg_1_0.co.copyIds) .. " >> " .. tostring(var_1_5))
		end
	end

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_1_0, var_0_0, arg_1_0)
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0._data = arg_2_1
end

function var_0_0.init(arg_3_0, arg_3_1)
	var_0_0.super.init(arg_3_0, arg_3_1)

	arg_3_0._anim = arg_3_1:GetComponentInChildren(typeof(UnityEngine.Animator))
	arg_3_0._subType = arg_3_0._data:getSubType()

	if arg_3_0._subType == SurvivalEnum.UnitSubType.Block then
		SurvivalMapModel.instance:getCurMapCo():setWalkByUnitMo(arg_3_0._data, false)
	end

	arg_3_0:_onMagmaStatusUpdate()
end

function var_0_0.onStart(arg_4_0)
	arg_4_0:_onMagmaStatusUpdate()
end

function var_0_0._onMagmaStatusUpdate(arg_5_0)
	if arg_5_0._subType ~= SurvivalEnum.UnitSubType.Magma then
		return
	end

	local var_5_0 = SurvivalMapModel.instance:getSceneMo()

	if arg_5_0._anim and arg_5_0._anim.isActiveAndEnabled then
		arg_5_0._anim:Play("statu" .. var_5_0.sceneProp.magmaStatus)
	end
end

function var_0_0.addEventListeners(arg_6_0)
	var_0_0.super.addEventListeners(arg_6_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMagmaStatusUpdate, arg_6_0._onMagmaStatusUpdate, arg_6_0)
end

function var_0_0.removeEventListeners(arg_7_0)
	var_0_0.super.removeEventListeners(arg_7_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMagmaStatusUpdate, arg_7_0._onMagmaStatusUpdate, arg_7_0)
end

function var_0_0.tryDestory(arg_8_0)
	if arg_8_0._subType == SurvivalEnum.UnitSubType.Block then
		SurvivalMapModel.instance:getCurMapCo():setWalkByUnitMo(arg_8_0._data, true)
		SurvivalMapHelper.instance:addPointEffect(arg_8_0._data.pos)

		for iter_8_0, iter_8_1 in ipairs(arg_8_0._data.exPoints) do
			SurvivalMapHelper.instance:addPointEffect(iter_8_1)
		end
	end

	gohelper.destroy(arg_8_0.go)
end

function var_0_0.onDestroy(arg_9_0)
	var_0_0.super.onDestroy(arg_9_0)
end

return var_0_0
