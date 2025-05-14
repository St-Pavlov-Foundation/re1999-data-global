module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaPlaceEntity", package.seeall)

local var_0_0 = class("TianShiNaNaPlaceEntity", LuaCompBase)

function var_0_0.Create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = UnityEngine.GameObject.New("Place")

	if arg_1_4 then
		var_1_0.transform:SetParent(arg_1_4.transform, false)
	end

	return (MonoHelper.addNoUpdateLuaComOnceToGo(var_1_0, var_0_0, {
		x = arg_1_0,
		y = arg_1_1,
		canOperDirs = arg_1_2,
		cubeType = arg_1_3
	}))
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.x = arg_2_1.x
	arg_2_0.y = arg_2_1.y
	arg_2_0.canOperDirs = arg_2_1.canOperDirs
	arg_2_0.cubeType = arg_2_1.cubeType
	arg_2_0._maxLen = arg_2_0.cubeType == TianShiNaNaEnum.CubeType.Type1 and 1 or 2
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.go = arg_3_1
	arg_3_0.trans = arg_3_1.transform

	local var_3_0 = TianShiNaNaHelper.nodeToV3(TianShiNaNaHelper.getV2(arg_3_0.x, arg_3_0.y))

	transformhelper.setLocalPos(arg_3_0.trans, var_3_0.x, var_3_0.y, var_3_0.z)

	arg_3_0._renderOrder = TianShiNaNaHelper.getSortIndex(arg_3_0.x, arg_3_0.y)

	for iter_3_0, iter_3_1 in pairs(TianShiNaNaEnum.OperDir) do
		if arg_3_0.canOperDirs[iter_3_1] then
			local var_3_1 = TianShiNaNaHelper.getOperOffset(iter_3_1)
			local var_3_2 = gohelper.create3d(arg_3_0.go, iter_3_0)

			if arg_3_0.cubeType == TianShiNaNaEnum.CubeType.Type2 then
				if iter_3_1 == TianShiNaNaEnum.OperDir.Left or iter_3_1 == TianShiNaNaEnum.OperDir.Right then
					transformhelper.setLocalScale(var_3_2.transform, -1, 1, 1)
				end

				if iter_3_1 == TianShiNaNaEnum.OperDir.Back or iter_3_1 == TianShiNaNaEnum.OperDir.Right then
					var_3_1.x = var_3_1.x * 2
					var_3_1.y = var_3_1.y * 2
				end
			end

			local var_3_3 = TianShiNaNaHelper.nodeToV3(var_3_1)

			transformhelper.setLocalPos(var_3_2.transform, var_3_3.x, var_3_3.y, var_3_3.z)

			local var_3_4 = PrefabInstantiate.Create(var_3_2)
			local var_3_5 = arg_3_0.cubeType == TianShiNaNaEnum.CubeType.Type1 and "scenes/v2a2_m_s12_tsnn_jshd/prefab/uidikuai1.prefab" or "scenes/v2a2_m_s12_tsnn_jshd/prefab/uidikuai2.prefab"

			var_3_4:startLoad(var_3_5, arg_3_0._onLoadEnd, arg_3_0)
		end
	end
end

function var_0_0._onLoadEnd(arg_4_0)
	local var_4_0 = arg_4_0.go:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for iter_4_0 = 0, var_4_0.Length - 1 do
		var_4_0[iter_4_0].sortingOrder = arg_4_0._renderOrder - 10
	end
end

function var_0_0.getClickDir(arg_5_0, arg_5_1)
	local var_5_0

	if arg_5_1.x == arg_5_0.x then
		local var_5_1 = math.abs(arg_5_1.y - arg_5_0.y)

		if var_5_1 > 0 and var_5_1 <= arg_5_0._maxLen then
			if arg_5_1.y > arg_5_0.y then
				var_5_0 = TianShiNaNaEnum.OperDir.Forward
			else
				var_5_0 = TianShiNaNaEnum.OperDir.Back
			end
		end
	elseif arg_5_1.y == arg_5_0.y then
		local var_5_2 = math.abs(arg_5_1.x - arg_5_0.x)

		if var_5_2 > 0 and var_5_2 <= arg_5_0._maxLen then
			if arg_5_1.x > arg_5_0.x then
				var_5_0 = TianShiNaNaEnum.OperDir.Right
			else
				var_5_0 = TianShiNaNaEnum.OperDir.Left
			end
		end
	end

	if arg_5_0.canOperDirs[var_5_0] then
		return var_5_0
	end
end

function var_0_0.dispose(arg_6_0)
	gohelper.destroy(arg_6_0.go)
end

return var_0_0
