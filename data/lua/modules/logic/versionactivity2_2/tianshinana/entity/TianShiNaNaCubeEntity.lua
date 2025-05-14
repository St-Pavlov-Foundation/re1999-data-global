module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaCubeEntity", package.seeall)

local var_0_0 = class("TianShiNaNaCubeEntity", LuaCompBase)
local var_0_1 = TianShiNaNaEnum.Dir
local var_0_2 = TianShiNaNaEnum.OperDir
local var_0_3 = TianShiNaNaEnum.OperEffect
local var_0_4 = TianShiNaNaEnum.DirToQuaternion
local var_0_5 = {
	[var_0_1.Forward] = true,
	[var_0_1.Left] = true,
	[var_0_1.Down] = true
}

function var_0_0.Create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = UnityEngine.GameObject.New("Cube")

	if arg_1_2 then
		var_1_0.transform:SetParent(arg_1_2.transform, false)
	end

	return (MonoHelper.addNoUpdateLuaComOnceToGo(var_1_0, var_0_0, {
		x = arg_1_0,
		y = arg_1_1
	}))
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.planDirs = {
		var_0_1.Up,
		var_0_1.Back,
		var_0_1.Right,
		var_0_1.Left,
		var_0_1.Forward,
		var_0_1.Down
	}
	arg_2_0.l = 1
	arg_2_0.w = 1
	arg_2_0.h = 2
	arg_2_0.x = arg_2_1.x + arg_2_0.l / 2 - 0.5
	arg_2_0.y = arg_2_0.h / 2 - 1
	arg_2_0.z = arg_2_1.y + arg_2_0.w / 2 - 0.5
	arg_2_0.finalV3 = Vector3(arg_2_0.x, arg_2_0.y, arg_2_0.z)
	arg_2_0.curOper = nil
	arg_2_0.nowTweenValue = 0
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.go = arg_3_1
	arg_3_0.loader = PrefabInstantiate.Create(arg_3_0.go)

	arg_3_0.loader:startLoad("scenes/v2a2_m_s12_tsnn_jshd/prefab/v2a2_m_s12_tsnn_box_p.prefab", arg_3_0.onLoadResEnd, arg_3_0)

	arg_3_0.trans = arg_3_0.instGo.transform:GetChild(0)

	transformhelper.setLocalPos(arg_3_0.trans, arg_3_0.x, arg_3_0.y, arg_3_0.z)

	TianShiNaNaModel.instance.curPointList = {}
end

function var_0_0.onLoadResEnd(arg_4_0)
	arg_4_0.plans = arg_4_0:getUserDataTb_()
	arg_4_0.renderers = arg_4_0:getUserDataTb_()
	arg_4_0.hideRenderers = arg_4_0:getUserDataTb_()
	arg_4_0.instGo = arg_4_0.loader:getInstGO()
	arg_4_0.rootGo = arg_4_0.instGo.transform:GetChild(0):GetChild(0).gameObject
	arg_4_0.anim = arg_4_0.instGo:GetComponent(typeof(UnityEngine.Animator))

	arg_4_0.anim:Play("open1", 0, 1)

	for iter_4_0 = 1, 6 do
		arg_4_0.plans[iter_4_0] = gohelper.findChild(arg_4_0.rootGo, iter_4_0)
		arg_4_0.renderers[iter_4_0] = arg_4_0.plans[iter_4_0]:GetComponent(typeof(UnityEngine.Renderer))
	end

	arg_4_0:updateSortOrder()
end

function var_0_0.playOpenAnim(arg_5_0, arg_5_1)
	if arg_5_1 == TianShiNaNaEnum.CubeType.Type1 then
		arg_5_0.anim:Play("open1", 0, 0)
	else
		arg_5_0.anim:Play("open2", 0, 0)
	end
end

function var_0_0.updateSortOrder(arg_6_0)
	if not arg_6_0.renderers then
		return
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_0.renderers) do
		local var_6_0 = arg_6_0.planDirs[iter_6_0]

		if var_0_5[var_6_0] then
			iter_6_1.sortingOrder = TianShiNaNaHelper.getSortIndex(arg_6_0.x, arg_6_0.z) - 1
		else
			iter_6_1.sortingOrder = TianShiNaNaHelper.getSortIndex(arg_6_0.x, arg_6_0.z) + 1
		end
	end
end

function var_0_0.doCubeTween(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = (arg_7_1 == var_0_2.Left or arg_7_1 == var_0_2.Right) and arg_7_0.l or arg_7_0.w
	local var_7_1 = (var_7_0 / 2)^2 + (arg_7_0.h / 2)^2
	local var_7_2 = var_7_0 * Mathf.Clamp(arg_7_2, 0, 0.5)
	local var_7_3 = arg_7_0.h * Mathf.Clamp(arg_7_2 - 0.5, 0, 0.5)
	local var_7_4 = var_7_2 + var_7_3

	arg_7_0.finalV3.y = math.sqrt(var_7_1 - (var_7_4 - var_7_0 / 2)^2)

	if arg_7_1 == var_0_2.Left then
		arg_7_0.finalV3.x = arg_7_0.x - var_7_4
	elseif arg_7_1 == var_0_2.Right then
		arg_7_0.finalV3.x = arg_7_0.x + var_7_4
	elseif arg_7_1 == var_0_2.Forward then
		arg_7_0.finalV3.z = arg_7_0.z + var_7_4
	elseif arg_7_1 == var_0_2.Back then
		arg_7_0.finalV3.z = arg_7_0.z - var_7_4
	end

	local var_7_5 = var_0_4[arg_7_0.planDirs[1]][arg_7_0.planDirs[2]]
	local var_7_6 = var_0_4[arg_7_0:getNextDir(arg_7_1, arg_7_0.planDirs[1])][arg_7_0:getNextDir(arg_7_1, arg_7_0.planDirs[2])]
	local var_7_7 = math.atan2(arg_7_0.h, var_7_0)
	local var_7_8 = math.atan2(arg_7_0.finalV3.y, arg_7_2 > 0.5 and -var_7_3 or var_7_0 / 2 - var_7_2)
	local var_7_9 = TianShiNaNaHelper.lerpQ(var_7_5, var_7_6, (var_7_8 - var_7_7) / math.pi * 2)

	transformhelper.setLocalRotation2(arg_7_0.trans, var_7_9.x, var_7_9.y, var_7_9.z, var_7_9.w)
	transformhelper.setLocalPos(arg_7_0.trans, arg_7_0.finalV3.x, arg_7_0.finalV3.y - 1, arg_7_0.finalV3.z)

	if arg_7_2 > 0.5 then
		arg_7_0:doRotate(arg_7_1, true)
		arg_7_0:updateSortOrder()
		arg_7_0:doRotate(-arg_7_1, true)
	else
		arg_7_0:updateSortOrder()
	end
end

function var_0_0.getPlaneByIndex(arg_8_0, arg_8_1)
	return arg_8_0.plans[arg_8_1]
end

function var_0_0.setPlaneParent(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.renderers[arg_9_1].sortingOrder = 1
	arg_9_0.hideRenderers[arg_9_1] = arg_9_0.renderers[arg_9_1]
	arg_9_0.renderers[arg_9_1] = nil

	arg_9_0:getPlaneByIndex(arg_9_1).transform:SetParent(arg_9_2, true)
	tabletool.addValues(TianShiNaNaModel.instance.curPointList, arg_9_0:getCurGrids())
	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.CubePointUpdate)
end

function var_0_0.revertPlane(arg_10_0, arg_10_1)
	local var_10_0, var_10_1 = next(arg_10_0.renderers)

	if not var_10_1 or not arg_10_0.hideRenderers[arg_10_1] then
		return
	end

	arg_10_0.renderers[arg_10_1] = arg_10_0.hideRenderers[arg_10_1]
	arg_10_0.renderers[arg_10_1].sortingOrder = var_10_1.sortingOrder
	arg_10_0.hideRenderers[arg_10_1] = nil

	arg_10_0:getPlaneByIndex(arg_10_1).transform:SetParent(arg_10_0.rootGo.transform, true)

	local var_10_2 = arg_10_0:getCurGrids()

	for iter_10_0 = #TianShiNaNaModel.instance.curPointList, 1, -1 do
		local var_10_3 = TianShiNaNaModel.instance.curPointList[iter_10_0]

		for iter_10_1, iter_10_2 in pairs(var_10_2) do
			if TianShiNaNaHelper.isPosSame(iter_10_2, var_10_3) then
				table.remove(TianShiNaNaModel.instance.curPointList, iter_10_0)

				break
			end
		end
	end

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.CubePointUpdate)
end

function var_0_0.hideOtherPlane(arg_11_0)
	for iter_11_0 in pairs(arg_11_0.renderers) do
		gohelper.setActive(arg_11_0:getPlaneByIndex(iter_11_0), false)
	end
end

function var_0_0.doRotate(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == var_0_2.Left then
		arg_12_0.x = arg_12_0.x - arg_12_0.l / 2 - arg_12_0.h / 2
		arg_12_0.l, arg_12_0.h = arg_12_0.h, arg_12_0.l
	elseif arg_12_1 == var_0_2.Right then
		arg_12_0.x = arg_12_0.x + arg_12_0.l / 2 + arg_12_0.h / 2
		arg_12_0.l, arg_12_0.h = arg_12_0.h, arg_12_0.l
	elseif arg_12_1 == var_0_2.Forward then
		arg_12_0.z = arg_12_0.z + arg_12_0.w / 2 + arg_12_0.h / 2
		arg_12_0.w, arg_12_0.h = arg_12_0.h, arg_12_0.w
	elseif arg_12_1 == var_0_2.Back then
		arg_12_0.z = arg_12_0.z - arg_12_0.w / 2 - arg_12_0.h / 2
		arg_12_0.w, arg_12_0.h = arg_12_0.h, arg_12_0.w
	end

	arg_12_0.y = arg_12_0.h / 2 - 1
	arg_12_0.allPoint = nil

	if not arg_12_2 then
		for iter_12_0, iter_12_1 in pairs(arg_12_0.planDirs) do
			arg_12_0.planDirs[iter_12_0] = arg_12_0:getNextDir(arg_12_1, iter_12_1)
		end

		arg_12_0.finalV3:Set(arg_12_0.x, arg_12_0.y, arg_12_0.z)
		transformhelper.setLocalPos(arg_12_0.trans, arg_12_0.finalV3.x, arg_12_0.finalV3.y, arg_12_0.finalV3.z)

		local var_12_0 = var_0_4[arg_12_0.planDirs[1]][arg_12_0.planDirs[2]]

		transformhelper.setLocalRotation2(arg_12_0.trans, var_12_0.x, var_12_0.y, var_12_0.z, var_12_0.w)
		arg_12_0:updateSortOrder()
	end
end

function var_0_0.resetPos(arg_13_0)
	arg_13_0.finalV3:Set(arg_13_0.x, arg_13_0.y, arg_13_0.z)
	transformhelper.setLocalPos(arg_13_0.trans, arg_13_0.finalV3.x, arg_13_0.finalV3.y, arg_13_0.finalV3.z)

	local var_13_0 = var_0_4[arg_13_0.planDirs[1]][arg_13_0.planDirs[2]]

	transformhelper.setLocalRotation2(arg_13_0.trans, var_13_0.x, var_13_0.y, var_13_0.z, var_13_0.w)
end

function var_0_0.getCurDownIndex(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.planDirs) do
		if iter_14_1 == var_0_1.Down then
			return iter_14_0
		end
	end

	return 1
end

function var_0_0.getDirByIndex(arg_15_0, arg_15_1)
	return arg_15_0.planDirs[arg_15_1] or var_0_1.Up
end

function var_0_0.getCurGrids(arg_16_0)
	if arg_16_0.allPoint then
		return arg_16_0.allPoint
	end

	local var_16_0 = Mathf.Round(arg_16_0.x - arg_16_0.l / 2)
	local var_16_1 = Mathf.Round(arg_16_0.x + arg_16_0.l / 2)
	local var_16_2 = Mathf.Round(arg_16_0.z - arg_16_0.w / 2)
	local var_16_3 = Mathf.Round(arg_16_0.z + arg_16_0.w / 2)
	local var_16_4 = {}

	for iter_16_0 = var_16_0, var_16_1 - 1 do
		for iter_16_1 = var_16_2, var_16_3 - 1 do
			table.insert(var_16_4, {
				x = iter_16_0,
				y = iter_16_1
			})
		end
	end

	arg_16_0.allPoint = var_16_4

	return var_16_4
end

function var_0_0.getOperGrids(arg_17_0, arg_17_1)
	arg_17_0:doRotate(arg_17_1, true)

	local var_17_0 = arg_17_0:getCurGrids()

	arg_17_0:doRotate(-arg_17_1, true)

	return var_17_0
end

function var_0_0.getOperDownIndex(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.planDirs) do
		if arg_18_0:getNextDir(arg_18_1, iter_18_1) == var_0_1.Down then
			return iter_18_0
		end
	end

	return 1
end

function var_0_0.getNextDir(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = var_0_3[arg_19_1]

	if not arg_19_1 then
		return arg_19_2
	end

	return var_19_0[arg_19_2] or arg_19_2
end

function var_0_0.onDestroy(arg_20_0)
	for iter_20_0 = 1, 6 do
		gohelper.destroy(arg_20_0.plans[iter_20_0])
	end

	if arg_20_0.loader then
		arg_20_0.loader:dispose()

		arg_20_0.loader = nil
	end
end

return var_0_0
