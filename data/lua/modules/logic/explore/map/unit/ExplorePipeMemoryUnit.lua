module("modules.logic.explore.map.unit.ExplorePipeMemoryUnit", package.seeall)

local var_0_0 = class("ExplorePipeMemoryUnit", ExplorePipeUnit)

function var_0_0.onResLoaded(arg_1_0)
	var_0_0.super.onResLoaded(arg_1_0)

	local var_1_0 = gohelper.findChild(arg_1_0._displayGo, "#go_rotate/effect2/root")

	if var_1_0 then
		if arg_1_0.mo:getNeedColor() == ExploreEnum.PipeColor.None then
			gohelper.setActive(var_1_0, false)
		else
			local var_1_1 = var_1_0:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem), true)

			for iter_1_0 = 0, var_1_1.Length - 1 do
				local var_1_2 = ExploreEnum.PipeColorDef[arg_1_0.mo:getNeedColor()]

				ZProj.ParticleSystemHelper.SetStartColor(var_1_1[iter_1_0], var_1_2.r, var_1_2.g, var_1_2.b, 1)
			end
		end
	end
end

function var_0_0.initComponents(arg_2_0)
	var_0_0.super.initComponents(arg_2_0)
	arg_2_0:addComp("pipeComp", ExplorePipeComp)
end

function var_0_0.setupMO(arg_3_0)
	var_0_0.super.setupMO(arg_3_0)
	arg_3_0.pipeComp:initData()
end

function var_0_0.onStatus2Change(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.mo:setCacheColor(arg_4_2.color or ExploreEnum.PipeColor.None)
end

function var_0_0.processMapIcon(arg_5_0, arg_5_1)
	local var_5_0 = GameUtil.splitString2(arg_5_1)

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		if tonumber(iter_5_1[1]) == arg_5_0.mo:getNeedColor() then
			return iter_5_1[2]
		end
	end

	return nil
end

return var_0_0
