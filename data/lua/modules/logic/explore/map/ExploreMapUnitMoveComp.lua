module("modules.logic.explore.map.ExploreMapUnitMoveComp", package.seeall)

local var_0_0 = class("ExploreMapUnitMoveComp", ExploreMapBaseComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._path = "explore/common/sprite/prefabs/msts_icon_yidong.prefab"
	arg_1_0._cloneGo = nil
	arg_1_0._anim = nil
	arg_1_0._curMoveUnit = nil
	arg_1_0._useList = {}
	arg_1_0._legalPosDic = {}
	arg_1_0._loader = SequenceAbLoader.New()

	arg_1_0._loader:addPath(arg_1_0._path)
	arg_1_0._loader:startLoad(arg_1_0.onLoaded, arg_1_0)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(ExploreController.instance, ExploreEvent.SetMoveUnit, arg_2_0.changeStatus, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.SetMoveUnit, arg_3_0.changeStatus, arg_3_0)
end

function var_0_0.onLoaded(arg_4_0)
	local var_4_0 = gohelper.clone(arg_4_0._loader:getFirstAssetItem():GetResource(), arg_4_0._mapGo)

	arg_4_0._cloneGo = var_4_0
	arg_4_0._useList[1] = gohelper.findChild(var_4_0, "top")
	arg_4_0._useList[2] = gohelper.findChild(var_4_0, "down")
	arg_4_0._useList[3] = gohelper.findChild(var_4_0, "left")
	arg_4_0._useList[4] = gohelper.findChild(var_4_0, "right")
	arg_4_0._anim = var_4_0:GetComponent(typeof(UnityEngine.Animator))

	for iter_4_0 = 1, 4 do
		gohelper.setActive(arg_4_0._useList[iter_4_0], false)
	end

	if arg_4_0._curMoveUnit then
		arg_4_0:setMoveUnit(arg_4_0._curMoveUnit, true)
	end
end

function var_0_0.changeStatus(arg_5_0, arg_5_1)
	if not arg_5_0:beginStatus() then
		return
	end

	arg_5_0:setMoveUnit(arg_5_1)
end

function var_0_0._onCloseAnimEnd(arg_6_0)
	for iter_6_0 = 1, 4 do
		gohelper.setActive(arg_6_0._useList[iter_6_0], false)
	end
end

function var_0_0.setMoveUnit(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_2 then
		if arg_7_0._curMoveUnit == arg_7_1 then
			return
		end

		if arg_7_0._curMoveUnit then
			arg_7_0._curMoveUnit:endPick()
		end

		if arg_7_1 then
			arg_7_1:beginPick()
		end
	end

	arg_7_0._curMoveUnit = arg_7_1

	if not arg_7_0._useList[1] then
		return
	end

	if not arg_7_0._unitMoving and arg_7_0._curMoveUnit then
		arg_7_0:roleMoveToUnit(arg_7_0._curMoveUnit)
	end

	if arg_7_0._anim then
		TaskDispatcher.cancelTask(arg_7_0._onCloseAnimEnd, arg_7_0)

		if arg_7_0._curMoveUnit then
			arg_7_0._anim:Play("open", 0, 0)
		else
			arg_7_0._anim:Play("close", 0, 0)
			TaskDispatcher.runDelay(arg_7_0._onCloseAnimEnd, arg_7_0, 0.167)
		end
	else
		for iter_7_0 = 1, 4 do
			gohelper.setActive(arg_7_0._useList[iter_7_0], false)
		end
	end

	arg_7_0._legalPosDic = {}

	local var_7_0
	local var_7_1

	if arg_7_0._curMoveUnit then
		local var_7_2 = arg_7_0._map:getHeroPos()
		local var_7_3 = arg_7_1.nodePos

		if ExploreHelper.getDistance(var_7_2, var_7_3) ~= 1 then
			arg_7_0._curMoveUnit = nil

			logError("隔空抓取物品？？")

			return
		end

		local var_7_4 = arg_7_1:getPos()

		transformhelper.setPos(arg_7_0._cloneGo.transform, var_7_4.x, var_7_4.y, var_7_4.z)

		if var_7_2.x == var_7_3.x then
			local var_7_5 = ExploreHelper.getKeyXY(var_7_3.x, math.max(var_7_2.y, var_7_3.y) + 1)

			arg_7_0:updateUse(var_7_5, var_7_1, 1, var_7_2.y > var_7_3.y and var_7_2)

			local var_7_6 = ExploreHelper.getKeyXY(var_7_3.x, math.min(var_7_2.y, var_7_3.y) - 1)

			arg_7_0:updateUse(var_7_6, var_7_1, 2, var_7_2.y < var_7_3.y and var_7_2)

			local var_7_7 = ExploreHelper.getKeyXY(var_7_3.x - 1, var_7_3.y)
			local var_7_8 = ExploreHelper.getKeyXY(var_7_2.x - 1, var_7_2.y)

			arg_7_0:updateUse(var_7_7, var_7_8, 3)

			local var_7_9 = ExploreHelper.getKeyXY(var_7_3.x + 1, var_7_3.y)
			local var_7_10 = ExploreHelper.getKeyXY(var_7_2.x + 1, var_7_2.y)

			arg_7_0:updateUse(var_7_9, var_7_10, 4)
		else
			local var_7_11 = ExploreHelper.getKeyXY(var_7_3.x, var_7_3.y + 1)
			local var_7_12 = ExploreHelper.getKeyXY(var_7_2.x, var_7_2.y + 1)

			arg_7_0:updateUse(var_7_11, var_7_12, 1)

			local var_7_13 = ExploreHelper.getKeyXY(var_7_3.x, var_7_3.y - 1)
			local var_7_14 = ExploreHelper.getKeyXY(var_7_2.x, var_7_2.y - 1)

			arg_7_0:updateUse(var_7_13, var_7_14, 2)

			local var_7_15
			local var_7_16 = ExploreHelper.getKeyXY(math.min(var_7_2.x, var_7_3.x) - 1, var_7_3.y)

			arg_7_0:updateUse(var_7_16, var_7_15, 3, var_7_2.x < var_7_3.x and var_7_2)

			local var_7_17 = ExploreHelper.getKeyXY(math.max(var_7_2.x, var_7_3.x) + 1, var_7_3.y)

			arg_7_0:updateUse(var_7_17, var_7_15, 4, var_7_2.x > var_7_3.x and var_7_2)
		end
	end
end

function var_0_0.updateUse(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = ExploreMapModel.instance:getNode(arg_8_1)
	local var_8_1

	if arg_8_2 then
		var_8_1 = ExploreMapModel.instance:getNode(arg_8_2)
	end

	if var_8_0 and var_8_0:isWalkable() and (not arg_8_2 or var_8_1 and var_8_1:isWalkable()) then
		gohelper.setActive(arg_8_0._useList[arg_8_3], true)

		if arg_8_4 then
			arg_8_1 = ExploreHelper.getKey(arg_8_4)

			local var_8_2 = ExploreMapModel.instance:getNode(arg_8_1)

			if var_8_2 and var_8_2:isWalkable() then
				arg_8_0._legalPosDic[arg_8_1] = arg_8_3
			else
				gohelper.setActive(arg_8_0._useList[arg_8_3], false)
			end
		else
			arg_8_0._legalPosDic[arg_8_1] = arg_8_3
		end

		return
	end

	gohelper.setActive(arg_8_0._useList[arg_8_3], false)
end

function var_0_0.onMapClick(arg_9_0, arg_9_1)
	if arg_9_0._isRoleMoving or arg_9_0._unitMoving then
		return
	end

	local var_9_0 = arg_9_0._curMoveUnit:getPos()
	local var_9_1, var_9_2, var_9_3 = arg_9_0._map:GetTilemapMousePos(arg_9_1, true)
	local var_9_4

	if var_9_3 then
		local var_9_5 = var_9_3 - var_9_0

		if var_9_5.magnitude <= 1.5 then
			local var_9_6 = math.deg(math.atan2(var_9_5.x, var_9_5.z))
			local var_9_7 = ExploreHelper.getDir(math.floor((var_9_6 + 45) / 90) * 90)
			local var_9_8 = ExploreHelper.dirToXY(var_9_7)
			local var_9_9 = arg_9_0._curMoveUnit.nodePos

			var_9_4 = {
				x = var_9_8.x + var_9_9.x,
				y = var_9_8.y + var_9_9.y
			}
		end
	end

	if var_9_4 then
		local var_9_10 = ExploreHelper.getKey(var_9_4)

		if arg_9_0._legalPosDic[var_9_10] then
			arg_9_0:sendUnitMoveReq(var_9_4)

			return
		end
	end

	arg_9_0:setMoveUnit(nil)
	arg_9_0:roleMoveBack()
end

function var_0_0.roleMoveToUnit(arg_10_0, arg_10_1)
	arg_10_0._isRoleMoving = true

	local var_10_0 = arg_10_0:getHero()
	local var_10_1 = ExploreHelper.xyToDir(arg_10_1.nodePos.x - var_10_0.nodePos.x, arg_10_1.nodePos.y - var_10_0.nodePos.y)
	local var_10_2 = (var_10_0:getPos() - arg_10_1:getPos()):SetNormalize():Mul(0.4):Add(arg_10_1:getPos())

	var_10_0:setTrOffset(var_10_1, var_10_2, nil, arg_10_0.onRoleMoveToUnitEnd, arg_10_0)
	var_10_0:setMoveSpeed(0.3)
end

function var_0_0.onRoleMoveToUnitEnd(arg_11_0)
	arg_11_0._isRoleMoving = false

	arg_11_0:getHero():setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Pull)
	arg_11_0:getHero():setMoveSpeed(0)
end

function var_0_0.roleMoveBack(arg_12_0)
	arg_12_0._isRoleMoving = true

	arg_12_0:setMoveUnit(nil)

	local var_12_0 = arg_12_0:getHero()
	local var_12_1 = var_12_0:getPos()

	var_12_0:setMoveSpeed(0.3)
	var_12_0:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)
	var_12_0:setTrOffset(nil, var_12_1, nil, arg_12_0.onRoleMoveBackEnd, arg_12_0)
end

function var_0_0.getHero(arg_13_0)
	return ExploreController.instance:getMap():getHero()
end

function var_0_0.onRoleMoveBackEnd(arg_14_0)
	arg_14_0:getHero():setMoveSpeed(0)

	arg_14_0._isRoleMoving = false

	arg_14_0._map:setMapStatus(ExploreEnum.MapStatus.Normal)
end

function var_0_0.onStatusEnd(arg_15_0)
	arg_15_0:setMoveUnit(nil)
end

function var_0_0.sendUnitMoveReq(arg_16_0, arg_16_1)
	arg_16_0._unitMoving = true
	arg_16_0._moveTempUnit = arg_16_0._curMoveUnit
	arg_16_0._movePos = arg_16_1

	ExploreModel.instance:setStepPause(true)
	ExploreRpc.instance:sendExploreMoveRequest(arg_16_1.x, arg_16_1.y, arg_16_0._curMoveUnit.id, arg_16_0._onMoveReply, arg_16_0)
	arg_16_0:setMoveUnit(nil)
end

function var_0_0._onMoveReply(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_2 == 0 then
		local var_17_0 = arg_17_0._movePos

		arg_17_0._movePos = nil

		arg_17_0:doUnitMove(var_17_0)
	else
		ExploreModel.instance:setStepPause(false)

		arg_17_0._unitMoving = false
		arg_17_0._movePos = nil
		arg_17_0._moveTempUnit = nil

		arg_17_0:roleMoveBack()
	end
end

function var_0_0.doUnitMove(arg_18_0, arg_18_1)
	local var_18_0, var_18_1, var_18_2, var_18_3 = ExploreConfig.instance:getUnitEffectConfig(arg_18_0._moveTempUnit:getResPath(), "drag")

	ExploreHelper.triggerAudio(var_18_2, var_18_3, arg_18_0._moveTempUnit.go)

	local var_18_4 = arg_18_1.x - arg_18_0._moveTempUnit.nodePos.x
	local var_18_5 = arg_18_1.y - arg_18_0._moveTempUnit.nodePos.y
	local var_18_6 = arg_18_0._map:getHeroPos()
	local var_18_7 = arg_18_0:getHero()
	local var_18_8 = {
		x = var_18_6.x + var_18_4,
		y = var_18_6.y + var_18_5
	}
	local var_18_9 = ExploreHelper.xyToDir(arg_18_0._moveTempUnit.nodePos.x - var_18_6.x, arg_18_0._moveTempUnit.nodePos.y - var_18_6.y)
	local var_18_10 = ExploreHelper.xyToDir(var_18_4, var_18_5)
	local var_18_11 = ExploreHelper.getDir(var_18_10 - var_18_9)
	local var_18_12 = arg_18_0._moveTempUnit

	arg_18_0._unitMoving = true

	local function var_18_13()
		var_18_12:setEmitLight(false)
		ExploreModel.instance:setStepPause(false)
		arg_18_0:setMoveUnit(var_18_12)

		arg_18_0._unitMoving = false
		arg_18_0._allSameDirLightMos = nil

		TaskDispatcher.cancelTask(arg_18_0._everyFrameSetLightLen, arg_18_0)
	end

	local var_18_14 = {}
	local var_18_15 = ExploreController.instance:getMapLight()

	for iter_18_0, iter_18_1 in pairs(var_18_15:getAllLightMos()) do
		if iter_18_1.endEmitUnit == var_18_12 and ExploreHelper.getDir(iter_18_1.dir - var_18_10) % 180 == 0 then
			table.insert(var_18_14, iter_18_1)
		end
	end

	if var_18_14[1] then
		arg_18_0._allSameDirLightMos = var_18_14

		TaskDispatcher.runRepeat(arg_18_0._everyFrameSetLightLen, arg_18_0, 0, -1)
	end

	arg_18_0._moveTempUnit:setEmitLight(true)

	if ExploreHelper.isPosEqual(arg_18_1, var_18_6) then
		arg_18_0._map:getHero():moveByPath({
			var_18_8
		}, var_18_11, var_18_9)
		arg_18_0._moveTempUnit:moveByPath({
			arg_18_1
		}, nil, nil, var_18_13)
	else
		arg_18_0._moveTempUnit:moveByPath({
			arg_18_1
		}, nil, nil, var_18_13)
		arg_18_0._map:getHero():moveByPath({
			var_18_8
		}, var_18_11, var_18_9)
	end

	arg_18_0:setMoveUnit(nil)

	arg_18_0._moveTempUnit = nil
end

function var_0_0._everyFrameSetLightLen(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0._allSameDirLightMos) do
		iter_20_1.lightLen = Vector3.Distance(iter_20_1.curEmitUnit:getPos(), iter_20_1.endEmitUnit:getPos())

		iter_20_1.curEmitUnit:onLightDataChange(iter_20_1)
	end
end

function var_0_0.canSwitchStatus(arg_21_0, arg_21_1)
	if arg_21_1 == ExploreEnum.MapStatus.UseItem then
		return false
	end

	if arg_21_0._unitMoving or arg_21_0._isRoleMoving then
		return false
	end

	return true
end

function var_0_0.onDestroy(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._onCloseAnimEnd, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._everyFrameSetLightLen, arg_22_0)

	for iter_22_0 = 1, 4 do
		arg_22_0._useList[iter_22_0] = nil
	end

	if arg_22_0._cloneGo then
		gohelper.destroy(arg_22_0._cloneGo)

		arg_22_0._cloneGo = nil
	end

	if arg_22_0._loader then
		arg_22_0._loader:dispose()

		arg_22_0._loader = nil
	end

	arg_22_0._anim = nil
	arg_22_0._allSameDirLightMos = nil
	arg_22_0._mapGo = nil
	arg_22_0._map = nil
	arg_22_0._curMoveUnit = nil

	var_0_0.super.onDestroy(arg_22_0)
end

return var_0_0
