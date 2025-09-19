module("modules.logic.scene.shelter.entity.SurvivalDecreeVoteEntity", package.seeall)

local var_0_0 = class("SurvivalDecreeVoteEntity", LuaCompBase)

function var_0_0.Create(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if arg_1_3 == nil then
		arg_1_3 = math.random(0, 5)
	end

	local var_1_0 = gohelper.create3d(arg_1_1, tostring(arg_1_2))
	local var_1_1, var_1_2, var_1_3 = SurvivalHelper.instance:hexPointToWorldPoint(arg_1_2.q, arg_1_2.r)
	local var_1_4 = var_1_0.transform

	transformhelper.setLocalPos(var_1_4, var_1_1, var_1_2, var_1_3)
	transformhelper.setLocalRotation(var_1_4, 0, arg_1_3 * 60, 0)

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_1_0, var_0_0, arg_1_0)
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.resPath = arg_2_1
end

function var_0_0.onStart(arg_3_0)
	arg_3_0.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0.go = arg_4_1
	arg_4_0.transform = arg_4_1.transform

	arg_4_0:showModel()
end

function var_0_0.showModel(arg_5_0)
	if not gohelper.isNil(arg_5_0.goModel) then
		return
	end

	if arg_5_0._loader then
		return
	end

	arg_5_0._loader = PrefabInstantiate.Create(arg_5_0.go)

	local var_5_0 = arg_5_0:getResPath()

	if string.nilorempty(var_5_0) then
		return
	end

	arg_5_0._loader:startLoad(var_5_0, arg_5_0._onResLoadEnd, arg_5_0)
end

function var_0_0.getResPath(arg_6_0)
	return arg_6_0.resPath
end

function var_0_0._onResLoadEnd(arg_7_0)
	local var_7_0 = arg_7_0._loader:getInstGO()
	local var_7_1 = var_7_0.transform

	arg_7_0.goModel = var_7_0

	transformhelper.setLocalPos(var_7_1, 0, 0, 0)
	transformhelper.setLocalRotation(var_7_1, 0, 0, 0)
	transformhelper.setLocalScale(var_7_1, 1, 1, 1)
	gohelper.setActive(arg_7_0.goModel, true)
end

function var_0_0.dispose(arg_8_0)
	if not gohelper.isNil(arg_8_0.go) then
		gohelper.destroy(arg_8_0.go)
	end
end

return var_0_0
