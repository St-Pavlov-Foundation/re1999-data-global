module("modules.logic.fight.entity.pool.FightSpinePool", package.seeall)

local var_0_0 = class("FightSpinePool")
local var_0_1 = {}
local var_0_2 = {}

function var_0_0.getSpine(arg_1_0)
	local var_1_0 = var_0_1[arg_1_0]

	if not var_1_0 then
		var_1_0 = LuaObjPool.New(3, function()
			local var_2_0 = var_0_2[arg_1_0]

			if var_2_0 then
				local var_2_1 = var_2_0:GetResource()

				return (gohelper.clone(var_2_1))
			end
		end, var_0_0._releaseFunc, var_0_0._resetFunc)
		var_0_1[arg_1_0] = var_1_0
	end

	return (var_1_0:getObject())
end

function var_0_0.putSpine(arg_3_0, arg_3_1)
	local var_3_0 = var_0_1[arg_3_0]

	if var_3_0 then
		var_3_0:putObject(arg_3_1)
	end
end

function var_0_0.setAssetItem(arg_4_0, arg_4_1)
	var_0_2[arg_4_0] = arg_4_1
end

function var_0_0.dispose()
	for iter_5_0, iter_5_1 in pairs(var_0_1) do
		var_0_0.releaseUrl(iter_5_0)
	end

	for iter_5_2, iter_5_3 in pairs(var_0_2) do
		var_0_2[iter_5_2] = nil
	end

	var_0_1 = {}
	var_0_2 = {}
end

function var_0_0._releaseFunc(arg_6_0)
	if arg_6_0 then
		gohelper.destroy(arg_6_0)
	end
end

function var_0_0._resetFunc(arg_7_0)
	if arg_7_0 then
		gohelper.setActive(arg_7_0, false)

		local var_7_0 = GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr:getEntityContainer()

		gohelper.addChild(var_7_0, arg_7_0)
		transformhelper.setLocalPos(arg_7_0.transform, 0, 0, 0)
		transformhelper.setLocalScale(arg_7_0.transform, 1, 1, 1)
		transformhelper.setLocalRotation(arg_7_0.transform, 0, 0, 0)
	end
end

function var_0_0.releaseUrl(arg_8_0)
	local var_8_0 = var_0_1 and var_0_1[arg_8_0]

	if var_8_0 then
		var_8_0:dispose()

		var_0_1[arg_8_0] = nil
	end

	if var_0_2 and var_0_2[arg_8_0] then
		var_0_2[arg_8_0] = nil
	end
end

return var_0_0
