module("modules.logic.scene.survival.comp.SurvivalSceneCloudComp", package.seeall)

local var_0_0 = class("SurvivalSceneCloudComp", BaseSceneComp)
local var_0_1 = {
	Color(0.64, 0.643, 0.438),
	Color(0.4, 0.42, 0.51),
	[6] = Color(0.456, 0.392, 0.482),
	[4] = Color(0.59, 0.63, 0.745),
	[5] = Color(0.766, 0.6, 0.37),
	(Color(0.63, 0.68, 0.53))
}

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._sceneGo = arg_1_0:getCurScene():getSceneContainerGO()
	arg_1_0._cloudRoot = gohelper.create3d(arg_1_0._sceneGo, "CloudRoot")

	transformhelper.setLocalPos(arg_1_0._cloudRoot.transform, 0, SurvivalConst.CloudHeight, 0)

	arg_1_0._allClouds = {}
	arg_1_0.v3 = Vector3()
	arg_1_0._hex = SurvivalHexNode.New()
	arg_1_0._hex2 = SurvivalHexNode.New()
	arg_1_0._cloudRes = SurvivalMapHelper.instance:getSpBlockRes(0, "survival_cloud")

	if arg_1_0._cloudRes then
		arg_1_0._cloudRes = gohelper.clone(arg_1_0._cloudRes, arg_1_0._cloudRoot, "[res]")

		gohelper.setActive(arg_1_0._cloudRes, false)
	end

	local var_1_0 = SurvivalMapModel.instance:getSceneMo()
	local var_1_1 = gohelper.findChild(arg_1_0._cloudRes, "cloud")

	if var_1_1 then
		local var_1_2 = var_1_1:GetComponent(typeof(UnityEngine.MeshRenderer))

		if var_1_2 then
			local var_1_3 = var_1_2.material

			if var_1_3 then
				var_1_3:SetColor("_MainColor", var_0_1[var_1_0.mapType] or Color())
			end
		end
	end

	arg_1_0._pool = {}
	arg_1_0._tweeningPos = {}
	arg_1_0._tweenId = nil

	arg_1_0:updateCloudShow(true)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_1_0.onScreenResize, arg_1_0)
	TaskDispatcher.runRepeat(arg_1_0._frameSetCloudOffset, arg_1_0, 0, -1)
end

function var_0_0.onScreenResize(arg_2_0)
	arg_2_0:updateCloudShow()
end

local var_0_2 = Vector3()

function var_0_0._frameSetCloudOffset(arg_3_0)
	local var_3_0 = UnityEngine.Screen.width
	local var_3_1 = UnityEngine.Screen.height

	var_0_2:Set(var_3_0 / 2, var_3_1 / 2, 0)

	local var_3_2 = SurvivalHelper.instance:getScene3DPos(var_0_2, 0)
	local var_3_3 = SurvivalHelper.instance:getScene3DPos(var_0_2, SurvivalConst.CloudHeight)

	transformhelper.setLocalPos(arg_3_0._cloudRoot.transform, var_3_3.x - var_3_2.x, SurvivalConst.CloudHeight, var_3_3.z - var_3_2.z)
end

function var_0_0.updateCloudShow(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_0._cloudRoot or not arg_4_0._cloudRes then
		return
	end

	if arg_4_2 then
		for iter_4_0, iter_4_1 in ipairs(arg_4_2) do
			SurvivalHelper.instance:addNodeToDict(arg_4_0._tweeningPos, iter_4_1, arg_4_3)
		end
	end

	local var_4_0 = UnityEngine.Screen.width
	local var_4_1 = UnityEngine.Screen.height

	arg_4_0.v3:Set(var_4_0 / 2, var_4_1 / 2, 0)

	local var_4_2 = SurvivalHelper.instance:getScene3DPos(arg_4_0.v3)

	arg_4_0._hex2:set(SurvivalHelper.instance:worldPointToHex(var_4_2.x, var_4_2.y, var_4_2.z))

	if not arg_4_1 and arg_4_0._hex == arg_4_0._hex2 then
		return
	end

	arg_4_0._hex:copyFrom(arg_4_0._hex2)

	for iter_4_2, iter_4_3 in pairs(arg_4_0._allClouds) do
		for iter_4_4, iter_4_5 in pairs(iter_4_3) do
			iter_4_5.flag = true
		end
	end

	local var_4_3 = 16
	local var_4_4 = 16
	local var_4_5 = var_4_3 / 2
	local var_4_6 = var_4_4 / 2
	local var_4_7 = 1

	for iter_4_6 = 0, var_4_3 - 1 do
		for iter_4_7 = 0, var_4_4 - 1 do
			local var_4_8 = iter_4_7 - var_4_6
			local var_4_9 = iter_4_6 - math.floor(var_4_8 / 2) - var_4_5

			arg_4_0._hex2:set(var_4_9 + arg_4_0._hex.q, var_4_8 + arg_4_0._hex.r)

			if SurvivalMapModel.instance:isInFog2(arg_4_0._hex2) or SurvivalHelper.instance:getValueFromDict(arg_4_0._tweeningPos, arg_4_0._hex2) then
				if not SurvivalHelper.instance:getValueFromDict(arg_4_0._allClouds, arg_4_0._hex2) then
					arg_4_0._allClouds[arg_4_0._hex2.q] = arg_4_0._allClouds[arg_4_0._hex2.q] or {}

					local var_4_10 = SurvivalMapModel.instance:getCacheHexNode(var_4_7)

					var_4_10:copyFrom(arg_4_0._hex2)

					var_4_7 = var_4_7 + 1
					arg_4_0._allClouds[arg_4_0._hex2.q][arg_4_0._hex2.r] = {
						hex = var_4_10
					}
				else
					arg_4_0._allClouds[arg_4_0._hex2.q][arg_4_0._hex2.r].flag = false
				end
			end
		end
	end

	for iter_4_8, iter_4_9 in pairs(arg_4_0._allClouds) do
		for iter_4_10, iter_4_11 in pairs(iter_4_9) do
			if iter_4_11.flag then
				if arg_4_0._tweeningPos[iter_4_8] and arg_4_0._tweeningPos[iter_4_8][iter_4_10] then
					transformhelper.setLocalScale(iter_4_11.go.transform, 1, 1, 1)
				end

				arg_4_0:releaseInstGo(iter_4_11.go)

				iter_4_9[iter_4_10] = nil
			end
		end
	end

	for iter_4_12, iter_4_13 in pairs(arg_4_0._allClouds) do
		for iter_4_14, iter_4_15 in pairs(iter_4_13) do
			if iter_4_15.hex then
				iter_4_15.go = arg_4_0:getInstGo(iter_4_15.hex)
				iter_4_15.hex = nil
			end
		end
	end

	if arg_4_2 and not arg_4_0._tweenId then
		arg_4_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, SurvivalConst.PlayerMoveSpeed * 0.95, arg_4_0._tweenCloudScale, arg_4_0._tweenFinish, arg_4_0)
	end
end

function var_0_0._tweenCloudScale(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._tweeningPos) do
		for iter_5_2, iter_5_3 in pairs(iter_5_1) do
			local var_5_0 = arg_5_0._allClouds[iter_5_0] and arg_5_0._allClouds[iter_5_0][iter_5_2]

			if var_5_0 then
				local var_5_1 = iter_5_3 and 1 - arg_5_1 or arg_5_1

				transformhelper.setLocalScale(var_5_0.go.transform, var_5_1, var_5_1, var_5_1)
			end
		end
	end
end

function var_0_0._tweenFinish(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._tweeningPos) do
		for iter_6_2 in pairs(iter_6_1) do
			local var_6_0 = arg_6_0._allClouds[iter_6_0] and arg_6_0._allClouds[iter_6_0][iter_6_2]

			if var_6_0 then
				transformhelper.setLocalScale(var_6_0.go.transform, 1, 1, 1)
				arg_6_0._hex2:set(iter_6_0, iter_6_2)

				if not SurvivalMapModel.instance:isInFog2(arg_6_0._hex2) then
					arg_6_0:releaseInstGo(var_6_0.go)
					SurvivalHelper.instance:removeNodeToDict(arg_6_0._allClouds, arg_6_0._hex2)
				end
			end
		end
	end

	arg_6_0._tweenId = nil
	arg_6_0._tweeningPos = {}
end

function var_0_0.getInstGo(arg_7_0, arg_7_1)
	local var_7_0 = table.remove(arg_7_0._pool)

	if not var_7_0 then
		var_7_0 = gohelper.clone(arg_7_0._cloudRes, arg_7_0._cloudRoot, tostring(arg_7_1))
	else
		var_7_0.name = tostring(arg_7_1)
	end

	gohelper.setActive(var_7_0, true)

	local var_7_1, var_7_2, var_7_3 = SurvivalHelper.instance:hexPointToWorldPoint(arg_7_1.q, arg_7_1.r)
	local var_7_4 = var_7_0.transform

	transformhelper.setLocalPos(var_7_4, var_7_1, 0, var_7_3)

	return var_7_0
end

function var_0_0.releaseInstGo(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return
	end

	if #arg_8_0._pool > 200 then
		gohelper.destroy(arg_8_1)

		return
	end

	gohelper.setActive(arg_8_1, false)
	table.insert(arg_8_0._pool, arg_8_1)
end

function var_0_0.onSceneClose(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._frameSetCloudOffset, arg_9_0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, arg_9_0.onScreenResize, arg_9_0)
	gohelper.destroy(arg_9_0._cloudRoot)

	arg_9_0._cloudRoot = nil
	arg_9_0._cloudRes = nil
	arg_9_0._allClouds = nil
	arg_9_0._pool = nil
	arg_9_0._tweeningPos = {}

	if arg_9_0._tweenId then
		ZProj.TweenHelper.KillById(arg_9_0._tweenId)

		arg_9_0._tweenId = nil
	end
end

return var_0_0
