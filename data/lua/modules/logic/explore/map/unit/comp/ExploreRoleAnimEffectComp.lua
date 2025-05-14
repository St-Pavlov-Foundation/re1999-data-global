module("modules.logic.explore.map.unit.comp.ExploreRoleAnimEffectComp", package.seeall)

local var_0_0 = class("ExploreRoleAnimEffectComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.unit = arg_1_1
	arg_1_0._effects = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
end

function var_0_0.setStatus(arg_3_0, arg_3_1)
	arg_3_0._status = arg_3_1

	local var_3_0 = lua_explore_hero_effect.configDict[arg_3_1]

	if var_3_0 then
		for iter_3_0 = 1, #var_3_0 do
			if var_3_0[iter_3_0].audioId and var_3_0[iter_3_0].audioId > 0 then
				AudioMgr.instance:trigger(var_3_0[iter_3_0].audioId)
			end

			if not arg_3_0._effects[iter_3_0] then
				arg_3_0._effects[iter_3_0] = {}
				arg_3_0._effects[iter_3_0].go = UnityEngine.GameObject.New()
				arg_3_0._effects[iter_3_0].loader = PrefabInstantiate.Create(arg_3_0._effects[iter_3_0].go)
			else
				gohelper.setActive(arg_3_0._effects[iter_3_0].go, true)
			end

			arg_3_0._effects[iter_3_0].loader:dispose()

			if not string.nilorempty(var_3_0[iter_3_0].effectPath) then
				arg_3_0._effects[iter_3_0].path = var_3_0[iter_3_0].hangPath

				arg_3_0._effects[iter_3_0].loader:startLoad(ResUrl.getExploreEffectPath(var_3_0[iter_3_0].effectPath))

				local var_3_1 = arg_3_0.unit._displayTr

				if not string.nilorempty(arg_3_0._effects[iter_3_0].path) then
					local var_3_2 = arg_3_0.unit._displayTr:Find(arg_3_0._effects[iter_3_0].path)

					if var_3_2 then
						var_3_1 = var_3_2
					end
				end

				arg_3_0._effects[iter_3_0].go.transform:SetParent(var_3_1, false)
			else
				gohelper.setActive(arg_3_0._effects[iter_3_0].go, false)
			end
		end

		for iter_3_1 = #var_3_0 + 1, #arg_3_0._effects do
			gohelper.setActive(arg_3_0._effects[iter_3_1].go, false)
		end
	else
		for iter_3_2 = 1, #arg_3_0._effects do
			gohelper.setActive(arg_3_0._effects[iter_3_2].go, false)
		end
	end
end

function var_0_0._releaseEffectGo(arg_4_0)
	ResMgr.ReleaseObj(arg_4_0._effectGo)

	arg_4_0._effectGo = nil
	arg_4_0._effectPath = nil
end

function var_0_0.onDestroy(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._effects) do
		iter_5_1.loader:dispose()
		gohelper.destroy(iter_5_1.go)
	end

	arg_5_0._effects = {}
end

return var_0_0
