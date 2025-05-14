module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaUnitEntityBase", package.seeall)

local var_0_0 = class("TianShiNaNaUnitEntityBase", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.trans = arg_1_1.transform
end

function var_0_0.updateMo(arg_2_0, arg_2_1)
	arg_2_0._unitMo = arg_2_1

	if not string.nilorempty(arg_2_1.co.unitPath) and not arg_2_0._loader then
		arg_2_0._loader = PrefabInstantiate.Create(arg_2_0.go)

		arg_2_0._loader:startLoad(arg_2_1.co.unitPath, arg_2_0._onResLoaded, arg_2_0)
	end

	local var_2_0 = TianShiNaNaHelper.nodeToV3(arg_2_1)

	transformhelper.setLocalPos(arg_2_0.trans, var_2_0.x, var_2_0.y, var_2_0.z)
end

function var_0_0.updatePosAndDir(arg_3_0)
	arg_3_0:_killTween()

	local var_3_0 = TianShiNaNaHelper.nodeToV3(arg_3_0._unitMo)

	transformhelper.setLocalPos(arg_3_0.trans, var_3_0.x, var_3_0.y, var_3_0.z)
	arg_3_0:setDir()
	arg_3_0:updateSortOrder()
end

function var_0_0.getWorldPos(arg_4_0)
	local var_4_0, var_4_1, var_4_2 = transformhelper.getPos(arg_4_0.trans)

	return TianShiNaNaHelper.getV3(var_4_0, var_4_1, var_4_2)
end

function var_0_0.getLocalPos(arg_5_0)
	local var_5_0, var_5_1, var_5_2 = transformhelper.getLocalPos(arg_5_0.trans)

	return TianShiNaNaHelper.getV3(var_5_0, var_5_1, var_5_2)
end

function var_0_0.moveTo(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	if arg_6_1 == arg_6_0._unitMo.x and arg_6_2 == arg_6_0._unitMo.y then
		if arg_6_3 ~= arg_6_0._unitMo.dir then
			arg_6_0._unitMo.dir = arg_6_3

			arg_6_0:setDir()
		end

		arg_6_4(arg_6_5)

		return
	end

	local var_6_0 = arg_6_0._unitMo.x
	local var_6_1 = arg_6_0._unitMo.y

	arg_6_0._unitMo.x = arg_6_1
	arg_6_0._unitMo.y = arg_6_2
	arg_6_0._unitMo.dir = arg_6_3
	arg_6_0._moveEndCall = arg_6_4
	arg_6_0._moveEndCallObj = arg_6_5

	arg_6_0:setDir()

	if arg_6_0._isMoveHalf then
		arg_6_0._isMoveHalf = false

		arg_6_0:_killTween()
		arg_6_0:_onEndMoveHalf()
	else
		local var_6_2 = TianShiNaNaHelper.nodeToV3(TianShiNaNaHelper.getV2((arg_6_1 + var_6_0) / 2, (arg_6_2 + var_6_1) / 2))

		arg_6_0:_beginMoveHalf(var_6_2)
	end
end

function var_0_0.moveToHalf(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_0._unitMo:isPosEqual(arg_7_1, arg_7_2) then
		arg_7_3(arg_7_4)

		return
	end

	arg_7_0._isMoveHalf = true

	local var_7_0 = TianShiNaNaHelper.getV2(arg_7_1, arg_7_2)

	arg_7_0:changeDir(arg_7_1, arg_7_2)

	arg_7_0._moveEndCall = arg_7_3
	arg_7_0._moveEndCallObj = arg_7_4

	arg_7_0:_killTween()
	var_7_0:Add(arg_7_0._unitMo):Div(2)

	arg_7_0._targetPos = TianShiNaNaHelper.nodeToV3(var_7_0):Clone()
	arg_7_0._beginPos = arg_7_0:getLocalPos():Clone()
	arg_7_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.15, arg_7_0._onMoving, arg_7_0._onEndMove, arg_7_0, nil, EaseType.Linear)
end

function var_0_0.changeDir(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = TianShiNaNaHelper.getV2(arg_8_1, arg_8_2)

	arg_8_0._unitMo.dir = TianShiNaNaHelper.getDir(arg_8_0._unitMo, var_8_0, arg_8_0._unitMo.dir)

	arg_8_0:setDir()
end

function var_0_0._beginMoveHalf(arg_9_0, arg_9_1)
	arg_9_0:_killTween()

	arg_9_0._targetPos = arg_9_1:Clone()
	arg_9_0._beginPos = arg_9_0:getLocalPos():Clone()
	arg_9_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.15, arg_9_0._onMoving, arg_9_0._onEndMoveHalf, arg_9_0, nil, EaseType.Linear)
end

function var_0_0._onEndMoveHalf(arg_10_0)
	arg_10_0:updateSortOrder()

	arg_10_0._targetPos = TianShiNaNaHelper.nodeToV3(arg_10_0._unitMo):Clone()
	arg_10_0._beginPos = arg_10_0:getLocalPos():Clone()
	arg_10_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.15, arg_10_0._onMoving, arg_10_0._onEndMove, arg_10_0, nil, EaseType.Linear)
end

function var_0_0._onEndMove(arg_11_0)
	arg_11_0._tweenId = nil

	local var_11_0 = arg_11_0._moveEndCall
	local var_11_1 = arg_11_0._moveEndCallObj

	arg_11_0._moveEndCall = nil
	arg_11_0._moveEndCallObj = nil

	if var_11_0 then
		var_11_0(var_11_1)
	end
end

function var_0_0._onMoving(arg_12_0, arg_12_1)
	if not arg_12_0._beginPos or not arg_12_0._targetPos then
		return
	end

	local var_12_0 = TianShiNaNaHelper.lerpV3(arg_12_0._beginPos, arg_12_0._targetPos, arg_12_1)

	transformhelper.setLocalPos(arg_12_0.trans, var_12_0.x, var_12_0.y, var_12_0.z)
	arg_12_0:onMoving()
end

function var_0_0.onMoving(arg_13_0)
	return
end

function var_0_0._onResLoaded(arg_14_0)
	arg_14_0._resGo = arg_14_0._loader:getInstGO()
	arg_14_0._dirs = arg_14_0:getUserDataTb_()

	for iter_14_0, iter_14_1 in pairs(TianShiNaNaEnum.OperDir) do
		arg_14_0._dirs[iter_14_1] = gohelper.findChild(arg_14_0._resGo, TianShiNaNaEnum.ResDirPath[iter_14_1])
	end

	local var_14_0 = arg_14_0._resGo:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

	if var_14_0.Length > 0 then
		arg_14_0._renderers = {}

		for iter_14_2 = 0, var_14_0.Length - 1 do
			arg_14_0._renderers[iter_14_2 + 1] = var_14_0[iter_14_2]
		end
	end

	arg_14_0:setDir()
	arg_14_0:updateSortOrder()
	arg_14_0:onResLoaded()
end

function var_0_0.onResLoaded(arg_15_0)
	return
end

function var_0_0.reAdd(arg_16_0)
	return
end

function var_0_0._killTween(arg_17_0)
	if arg_17_0._tweenId then
		ZProj.TweenHelper.KillById(arg_17_0._tweenId)

		arg_17_0._tweenId = nil
	end
end

function var_0_0.setDir(arg_18_0)
	if not arg_18_0._resGo then
		return
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0._dirs) do
		gohelper.setActive(iter_18_1, iter_18_0 == arg_18_0._unitMo.dir)
	end
end

function var_0_0.updateSortOrder(arg_19_0)
	if not arg_19_0._renderers then
		return
	end

	for iter_19_0, iter_19_1 in pairs(arg_19_0._renderers) do
		iter_19_1.sortingOrder = TianShiNaNaHelper.getSortIndex(arg_19_0._unitMo.x, arg_19_0._unitMo.y)
	end
end

function var_0_0.onDestroy(arg_20_0)
	arg_20_0:_killTween()
end

function var_0_0.dispose(arg_21_0)
	gohelper.destroy(arg_21_0.go)
end

return var_0_0
