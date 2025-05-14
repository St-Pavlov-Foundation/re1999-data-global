module("modules.logic.versionactivity2_4.pinball.controller.PinballEntityMgr", package.seeall)

local var_0_0 = class("PinballEntityMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._entitys = {}
	arg_1_0._item = nil
	arg_1_0._topItem = nil
	arg_1_0._numItem = nil
	arg_1_0._layers = {}
	arg_1_0.uniqueId = 0
	arg_1_0._curMarblesNum = 0
	arg_1_0._totalNum = 0
end

function var_0_0.addEntity(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.uniqueId = arg_2_0.uniqueId + 1

	local var_2_0 = PinballEnum.UnitTypeToName[arg_2_1] or ""
	local var_2_1 = _G[string.format("Pinball%sEntity", var_2_0)] or PinballColliderEntity
	local var_2_2 = PinballEnum.UnitTypeToLayer[arg_2_1]
	local var_2_3

	if var_2_2 and arg_2_0._layers[var_2_2] then
		var_2_3 = gohelper.clone(arg_2_0._item, arg_2_0._layers[var_2_2], var_2_0)
	else
		var_2_3 = gohelper.cloneInPlace((PinballHelper.isMarblesType(arg_2_1) or arg_2_1 == PinballEnum.UnitType.CommonEffect) and arg_2_0._topItem or arg_2_0._item, var_2_0)
	end

	gohelper.setActive(var_2_3, true)

	local var_2_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_3, var_2_1)

	var_2_4.id = arg_2_0.uniqueId
	var_2_4.unitType = arg_2_1

	var_2_4:initByCo(arg_2_2)
	var_2_4:loadRes()

	if var_2_4:isMarblesType() then
		arg_2_0._curMarblesNum = arg_2_0._curMarblesNum + 1
	end

	var_2_4:tick(0)

	arg_2_0._entitys[arg_2_0.uniqueId] = var_2_4

	return var_2_4
end

function var_0_0.addNumShow(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._totalNum = arg_3_0._totalNum + arg_3_1

	local var_3_0 = gohelper.cloneInPlace(arg_3_0._numItem)

	gohelper.setActive(var_3_0, true)

	local var_3_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_3_0, PinballNumShowEntity)

	var_3_1:setType(arg_3_0._totalNum)
	var_3_1:setPos(arg_3_2, arg_3_3)
end

function var_0_0.removeEntity(arg_4_0, arg_4_1)
	if arg_4_0._entitys[arg_4_1] then
		arg_4_0._entitys[arg_4_1]:markDead()
	end
end

function var_0_0.getEntity(arg_5_0, arg_5_1)
	return arg_5_0._entitys[arg_5_1]
end

function var_0_0.getAllEntity(arg_6_0)
	return arg_6_0._entitys
end

function var_0_0.beginTick(arg_7_0)
	TaskDispatcher.runRepeat(arg_7_0.frameTick, arg_7_0, 0, -1)
end

function var_0_0.pauseTick(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.frameTick, arg_8_0)
end

function var_0_0.setRoot(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_0._item = arg_9_1
	arg_9_0._topItem = arg_9_2
	arg_9_0._numItem = arg_9_3
	arg_9_0._layers = arg_9_4
end

function var_0_0.frameTick(arg_10_0)
	if isDebugBuild and PinballModel.instance._gmkey then
		arg_10_0:checkGMKey()
	end

	local var_10_0 = 3
	local var_10_1 = Mathf.Clamp(UnityEngine.Time.deltaTime, 0.01, 0.1) / var_10_0

	for iter_10_0 = 1, var_10_0 do
		arg_10_0:_tickDt(var_10_1)
	end
end

function var_0_0._tickDt(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_0._entitys) do
		iter_11_1:tick(arg_11_1)
	end

	for iter_11_2, iter_11_3 in pairs(arg_11_0._entitys) do
		if iter_11_3:isCheckHit() then
			for iter_11_4 = #iter_11_3.curHitEntityIdList, 1, -1 do
				local var_11_0 = iter_11_3.curHitEntityIdList[iter_11_4]
				local var_11_1 = arg_11_0._entitys[var_11_0]

				if not var_11_1 or not PinballHelper.getHitInfo(iter_11_3, var_11_1) then
					if var_11_1 then
						var_11_1:onHitExit(iter_11_3.id)
						tabletool.removeValue(var_11_1.curHitEntityIdList, iter_11_3.id)
					end

					iter_11_3:onHitExit(var_11_0)
					table.remove(iter_11_3.curHitEntityIdList, iter_11_4)
				end
			end

			for iter_11_5, iter_11_6 in pairs(arg_11_0._entitys) do
				if iter_11_3 ~= iter_11_6 and iter_11_6:canHit() and not tabletool.indexOf(iter_11_3.curHitEntityIdList, iter_11_6.id) then
					local var_11_2, var_11_3, var_11_4 = PinballHelper.getHitInfo(iter_11_3, iter_11_6)

					if var_11_2 then
						table.insert(iter_11_3.curHitEntityIdList, iter_11_6.id)
						table.insert(iter_11_6.curHitEntityIdList, iter_11_3.id)

						if iter_11_3.unitType <= iter_11_6.unitType then
							iter_11_3:onHitEnter(iter_11_6.id, var_11_2, var_11_3, var_11_4)
							iter_11_6:onHitEnter(iter_11_3.id, var_11_2, var_11_3, -var_11_4)

							break
						end

						iter_11_6:onHitEnter(iter_11_3.id, var_11_2, var_11_3, -var_11_4)
						iter_11_3:onHitEnter(iter_11_6.id, var_11_2, var_11_3, var_11_4)

						break
					end
				end
			end
		end
	end

	local var_11_5 = false

	for iter_11_7, iter_11_8 in pairs(arg_11_0._entitys) do
		if iter_11_8.isDead then
			if iter_11_8.curHitEntityIdList then
				for iter_11_9, iter_11_10 in pairs(iter_11_8.curHitEntityIdList) do
					local var_11_6 = arg_11_0._entitys[iter_11_10]

					if var_11_6 then
						var_11_6:onHitExit(iter_11_8.id)
						tabletool.removeValue(var_11_6.curHitEntityIdList, iter_11_8.id)
						iter_11_8:onHitExit(var_11_6.id)
					end
				end

				iter_11_8.curHitEntityIdList = {}
			end

			if iter_11_8:isMarblesType() then
				arg_11_0._curMarblesNum = arg_11_0._curMarblesNum - 1
				var_11_5 = true
			end

			arg_11_0._entitys[iter_11_7]:dispose()

			arg_11_0._entitys[iter_11_7] = nil
		end
	end

	if var_11_5 and arg_11_0._curMarblesNum == 0 then
		arg_11_0._totalNum = 0

		PinballController.instance:dispatchEvent(PinballEvent.MarblesDead)
	end
end

function var_0_0.checkGMKey(arg_12_0)
	local var_12_0

	if UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Alpha1) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Keypad1) then
		var_12_0 = 1
	elseif UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Alpha2) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Keypad2) then
		var_12_0 = 2
	elseif UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Alpha3) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Keypad3) then
		var_12_0 = 3
	elseif UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Alpha4) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Keypad4) then
		var_12_0 = 4
	elseif UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Alpha5) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Keypad5) then
		var_12_0 = 5
	elseif UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Alpha0) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Keypad0) then
		for iter_12_0, iter_12_1 in pairs(arg_12_0._entitys) do
			iter_12_1.vx = 0
			iter_12_1.vy = 0
		end
	end

	if var_12_0 then
		local var_12_1 = ViewMgr.instance:getContainer(ViewName.PinballGameView)._views[2]
		local var_12_2 = var_12_1._curBagDict

		var_12_2[var_12_0] = var_12_2[var_12_0] + 1

		var_12_1:_refreshBagAndSaveData()
	end
end

function var_0_0.clear(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0.frameTick, arg_13_0)

	for iter_13_0, iter_13_1 in pairs(arg_13_0._entitys) do
		iter_13_1:dispose()
	end

	arg_13_0._entitys = {}
	arg_13_0._item = nil
	arg_13_0._topItem = nil
	arg_13_0._numItem = nil
	arg_13_0._layers = nil
	arg_13_0._curMarblesNum = 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
