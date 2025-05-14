module("modules.logic.versionactivity1_2.yaxian.controller.game.interacts.YaXianInteractPlayerHandle", package.seeall)

local var_0_0 = class("YaXianInteractPlayerHandle", YaXianInteractHandleBase)

function var_0_0.onSelectCall(arg_1_0)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.ShowCanWalkGround, true)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshInteractStatus, true)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshAllInteractAlertArea, true)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshInteractPath, true)
end

function var_0_0.onCancelSelect(arg_2_0)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.ShowCanWalkGround, false)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshInteractStatus, false)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshAllInteractAlertArea, false)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshInteractPath, false)
end

function var_0_0.onSelectPos(arg_3_0, arg_3_1, arg_3_2)
	for iter_3_0, iter_3_1 in pairs(YaXianGameModel.instance:getCanWalkTargetPosDict()) do
		if iter_3_1.x == arg_3_1 and iter_3_1.y == arg_3_2 then
			local var_3_0 = {
				id = arg_3_0._interactObject.interactMo.id,
				dir = iter_3_0
			}

			Activity115Rpc.instance:sendAct115BeginRoundRequest(YaXianGameEnum.ActivityId, {
				var_3_0
			})
			YaXianGameController.instance:setSelectObj()

			return
		end
	end

	return true
end

return var_0_0
