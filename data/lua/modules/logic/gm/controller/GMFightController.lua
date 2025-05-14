module("modules.logic.gm.controller.GMFightController", package.seeall)

local var_0_0 = class("GMFightController", BaseController)

function var_0_0.ctor(arg_1_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.ExitScene, arg_1_0._onExitScene, arg_1_0)
end

function var_0_0._onExitScene(arg_2_0)
	arg_2_0.buffTypeId = nil
end

function var_0_0.startStatBuffType(arg_3_0, arg_3_1)
	arg_3_0.buffTypeId = arg_3_1

	local var_3_0 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_3_1 = var_3_0:getTagUnitDict(SceneTag.UnitMonster)

	for iter_3_0, iter_3_1 in pairs(var_3_1) do
		arg_3_0:addStatBuffTypeByEntity(iter_3_1)
	end

	local var_3_2 = var_3_0:getTagUnitDict(SceneTag.UnitPlayer)

	for iter_3_2, iter_3_3 in pairs(var_3_2) do
		arg_3_0:addStatBuffTypeByEntity(iter_3_3)
	end
end

function var_0_0.addStatBuffTypeByEntity(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.nameUI

	if var_4_0 then
		local var_4_1 = var_4_0:getGO()

		MonoHelper.addLuaComOnceToGo(var_4_1, FightGmNameUIComp, arg_4_1):startStatBuffType(arg_4_0.buffTypeId)
	end
end

function var_0_0.stopStatBuffType(arg_5_0)
	arg_5_0.buffTypeId = nil

	local var_5_0 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_5_1 = var_5_0:getTagUnitDict(SceneTag.UnitMonster)

	for iter_5_0, iter_5_1 in pairs(var_5_1) do
		arg_5_0:stopStatBuffTypeByEntity(iter_5_1)
	end

	local var_5_2 = var_5_0:getTagUnitDict(SceneTag.UnitPlayer)

	for iter_5_2, iter_5_3 in pairs(var_5_2) do
		arg_5_0:stopStatBuffTypeByEntity(iter_5_3)
	end
end

function var_0_0.stopStatBuffTypeByEntity(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.nameUI

	if var_6_0 then
		local var_6_1 = var_6_0:getGO()
		local var_6_2 = MonoHelper.getLuaComFromGo(var_6_1, FightGmNameUIComp)

		if var_6_2 then
			var_6_2:stopStatBuffType()
		end
	end
end

function var_0_0.statingBuffType(arg_7_0)
	return arg_7_0.buffTypeId ~= nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
