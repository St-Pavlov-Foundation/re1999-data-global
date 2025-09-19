module("modules.logic.survival.view.shelter.SurvivalDecreeVoteUIItem", package.seeall)

local var_0_0 = class("SurvivalDecreeVoteUIItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entityGO = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.trans = arg_2_1.transform

	transformhelper.setLocalPos(arg_2_0.trans, 9999, 9999, 0)
	arg_2_0:initFollower()
end

function var_0_0.onStart(arg_3_0)
	arg_3_0.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false
end

function var_0_0.initFollower(arg_4_0)
	if arg_4_0._uiFollower then
		return
	end

	if gohelper.isNil(arg_4_0.entityGO) then
		return
	end

	local var_4_0 = CameraMgr.instance:getMainCamera()
	local var_4_1 = CameraMgr.instance:getUICamera()
	local var_4_2 = ViewMgr.instance:getUIRoot().transform

	gohelper.setActive(arg_4_0._goarrow, false)

	arg_4_0._uiFollower = gohelper.onceAddComponent(arg_4_0.go, typeof(ZProj.UIFollower))

	arg_4_0._uiFollower:Set(var_4_0, var_4_1, var_4_2, arg_4_0.entityGO.transform, 0, 0.5, 0, 0, 0)
	arg_4_0._uiFollower:SetEnable(true)
end

function var_0_0.dispose(arg_5_0)
	gohelper.destroy(arg_5_0.go)
end

return var_0_0
