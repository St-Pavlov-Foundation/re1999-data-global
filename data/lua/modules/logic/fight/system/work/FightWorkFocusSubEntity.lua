module("modules.logic.fight.system.work.FightWorkFocusSubEntity", package.seeall)

local var_0_0 = class("FightWorkFocusSubEntity", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._entityMO = arg_1_1
	arg_1_0._entityId = arg_1_0._entityMO.id .. "focusSub"
end

function var_0_0.onStart(arg_2_0)
	if FightDataHelper.entityMgr:isSub(arg_2_0._entityMO.id) then
		local var_2_0 = arg_2_0.context.subEntityList

		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			if iter_2_1.id == arg_2_0._entityId then
				arg_2_0:onDone(true)

				return
			end
		end

		local var_2_1 = GameSceneMgr.instance:getCurScene().entityMgr
		local var_2_2 = arg_2_0._entityMO and arg_2_0._entityMO:getSpineSkinCO()

		if not var_2_2 then
			arg_2_0:onDone(true)

			return
		end

		FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_2_0._onSpineLoaded, arg_2_0)
		var_2_1:buildTempSpineByName(nil, arg_2_0._entityId, arg_2_0._entityMO.side, nil, var_2_2)
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0._onSpineLoaded(arg_3_0, arg_3_1)
	if arg_3_0._entityId == arg_3_1.unitSpawn.id then
		table.insert(arg_3_0.context.subEntityList, arg_3_1.unitSpawn)
		arg_3_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_4_0._onSpineLoaded, arg_4_0)
end

return var_0_0
