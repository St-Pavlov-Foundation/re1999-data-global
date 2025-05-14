module("modules.logic.fight.system.work.FightWorkBuildSubEntityAfterChangeHero", package.seeall)

local var_0_0 = class("FightWorkBuildSubEntityAfterChangeHero", FightWorkItem)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.SAFETIME = 10
end

function var_0_0.onStart(arg_2_0)
	if not FightHelper.getSubEntity(FightEnum.EntitySide.MySide) then
		local var_2_0 = FightDataHelper.entityMgr:getMySubList()

		table.sort(var_2_0, FightEntityDataHelper.sortSubEntityList)

		local var_2_1 = var_2_0[1]

		if var_2_1 then
			arg_2_0._entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
			arg_2_0._entityId = var_2_1.id

			arg_2_0:com_registFightEvent(FightEvent.OnSpineLoaded, arg_2_0._onNextSubSpineLoaded)
			arg_2_0._entityMgr:buildSubSpine(var_2_1)

			return
		end
	end

	arg_2_0:onDone(true)
end

function var_0_0._onNextSubSpineLoaded(arg_3_0, arg_3_1)
	if arg_3_1.unitSpawn.id == arg_3_0._entityId then
		arg_3_0:com_registTimer(arg_3_0.finishWork, 5)

		local var_3_0 = arg_3_0._entityMgr:getEntity(arg_3_0._entityId)
		local var_3_1 = arg_3_0:com_registWork(Work2FightWork, FightWorkStartBornNormal, var_3_0, true)

		var_3_1:registFinishCallback(arg_3_0.finishWork, arg_3_0)
		var_3_1:start()
	end
end

function var_0_0.clearWork(arg_4_0)
	return
end

return var_0_0
