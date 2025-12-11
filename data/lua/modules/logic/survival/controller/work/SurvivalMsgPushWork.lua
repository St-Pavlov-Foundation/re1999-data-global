module("modules.logic.survival.controller.work.SurvivalMsgPushWork", package.seeall)

local var_0_0 = class("SurvivalMsgPushWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._msgName = arg_1_1 or ""
	arg_1_0._msg = arg_1_2
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0["onReceive" .. arg_2_0._msgName]

	if var_2_0 and var_2_0(arg_2_0, arg_2_0._msg) then
		return
	end

	arg_2_0:onDone(true)
end

function var_0_0.onReceiveSurvivalHeroUpdatePush(arg_3_0, arg_3_1)
	local var_3_0 = SurvivalShelterModel.instance:getWeekInfo()

	if var_3_0 then
		var_3_0:updateHeroHealth(arg_3_1.hero)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnSurvivalHeroHealthUpdate)
	end
end

function var_0_0.onReceiveSurvivalBagUpdatePush(arg_4_0, arg_4_1)
	local var_4_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_4_0 then
		return
	end

	local var_4_1 = var_4_0:getBag(arg_4_1.type)

	if not var_4_1 then
		return
	end

	var_4_1:addOrUpdateItems(arg_4_1.updateItems)
	var_4_1:removeItems(arg_4_1.delItemUids)

	if arg_4_1.type == SurvivalEnum.ItemSource.Map then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapBagUpdate, arg_4_1)
	elseif arg_4_1.type == SurvivalEnum.ItemSource.Shelter then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShelterBagUpdate, arg_4_1)
	end

	SurvivalEquipRedDotHelper.instance:checkRed()
end

function var_0_0.onReceiveSurvivalTaskUpdatePush(arg_5_0, arg_5_1)
	local var_5_0 = SurvivalShelterModel.instance:getWeekInfo()

	if var_5_0 then
		var_5_0.taskPanel:addOrUpdateTasks(arg_5_1.boxs)
		var_5_0.taskPanel:removeTasks(arg_5_1.removeTaskInfo)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnTaskDataUpdate)
	end
end

return var_0_0
