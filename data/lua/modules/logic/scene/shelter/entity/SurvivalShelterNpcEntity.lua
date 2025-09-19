module("modules.logic.scene.shelter.entity.SurvivalShelterNpcEntity", package.seeall)

local var_0_0 = class("SurvivalShelterNpcEntity", SurvivalShelterUnitEntity)

function var_0_0.Create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0, var_1_1 = SurvivalMapHelper.instance:getRandomWalkPosAndDir(arg_1_1)

	if not var_1_0 then
		logError(string.format("not find npc random pos, npcId:%s", arg_1_1))

		return
	end

	local var_1_2 = gohelper.create3d(arg_1_2, tostring(var_1_0))
	local var_1_3, var_1_4, var_1_5 = SurvivalHelper.instance:hexPointToWorldPoint(var_1_0.q, var_1_0.r)
	local var_1_6 = var_1_2.transform

	transformhelper.setLocalPos(var_1_6, var_1_3, var_1_4, var_1_5)
	transformhelper.setLocalRotation(var_1_6, 0, var_1_1 * 60, 0)

	local var_1_7 = {
		unitType = arg_1_0,
		unitId = arg_1_1,
		pos = var_1_0,
		dir = var_1_1
	}

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_1_2, var_0_0, var_1_7)
end

function var_0_0.onCtor(arg_2_0, arg_2_1)
	arg_2_0.pos = arg_2_1.pos
	arg_2_0.dir = arg_2_1.dir
end

function var_0_0.onStart(arg_3_0)
	arg_3_0.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false
end

function var_0_0.addEventListeners(arg_4_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnDecreeVoteStart, arg_4_0._onDecreeVoteStart, arg_4_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnDecreeVoteEnd, arg_4_0._onDecreeVoteEnd, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnDecreeVoteStart, arg_5_0._onDecreeVoteStart, arg_5_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnDecreeVoteEnd, arg_5_0._onDecreeVoteEnd, arg_5_0)
end

function var_0_0.onInit(arg_6_0)
	arg_6_0:showModel()
end

function var_0_0.showModel(arg_7_0)
	if not gohelper.isNil(arg_7_0.goModel) then
		return
	end

	if arg_7_0._loader then
		return
	end

	arg_7_0._loader = PrefabInstantiate.Create(arg_7_0.go)

	local var_7_0 = arg_7_0:getResPath()

	if string.nilorempty(var_7_0) then
		return
	end

	arg_7_0._loader:startLoad(var_7_0, arg_7_0._onResLoadEnd, arg_7_0)
end

function var_0_0.getResPath(arg_8_0)
	local var_8_0 = SurvivalConfig.instance:getNpcConfig(arg_8_0.unitId)

	if not var_8_0 then
		return nil
	end

	return var_8_0.resource
end

function var_0_0._onResLoadEnd(arg_9_0)
	local var_9_0 = arg_9_0._loader:getInstGO()
	local var_9_1 = var_9_0.transform

	arg_9_0.goModel = var_9_0

	transformhelper.setLocalPos(var_9_1, 0, 0, 0)
	transformhelper.setLocalRotation(var_9_1, 0, 0, 0)
	transformhelper.setLocalScale(var_9_1, 1, 1, 1)
	arg_9_0:onLoadedEnd()
end

function var_0_0._onDecreeVoteStart(arg_10_0)
	arg_10_0:setVisible(false)
end

function var_0_0._onDecreeVoteEnd(arg_11_0)
	arg_11_0:setVisible(true)
end

function var_0_0.needUI(arg_12_0)
	return true
end

return var_0_0
