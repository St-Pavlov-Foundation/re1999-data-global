module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepUpdateObjectData", package.seeall)

local var_0_0 = class("YaXianStepUpdateObjectData", YaXianStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0.originData.object

	arg_1_0.interactId = var_1_0.id

	local var_1_1 = var_1_0.data

	logNormal("start update object data : " .. arg_1_0.interactId)

	local var_1_2 = YaXianGameModel.instance:getInteractMo(arg_1_0.interactId)

	if var_1_2 then
		var_1_2:updateDataByTableData(var_1_1)

		if var_1_2.config.interactType == YaXianGameEnum.InteractType.Player then
			arg_1_0:handleUpdateSkillInfo(var_1_1 and var_1_1.skills)
			arg_1_0:handleUpdateEffects(var_1_1 and var_1_1.effects)
		end
	end

	arg_1_0:finish()
end

function var_0_0.handleUpdateSkillInfo(arg_2_0, arg_2_1)
	if YaXianGameModel.instance:updateSkillInfoAndCheckHasChange(arg_2_1) then
		YaXianGameController.instance:dispatchEvent(YaXianEvent.OnUpdateSkillInfo)
	end
end

function var_0_0.handleUpdateEffects(arg_3_0, arg_3_1)
	if YaXianGameModel.instance:updateEffectsAndCheckHasChange(arg_3_1) then
		YaXianGameController.instance:dispatchEvent(YaXianEvent.OnUpdateEffectInfo)
	end
end

function var_0_0.dispose(arg_4_0)
	return
end

return var_0_0
