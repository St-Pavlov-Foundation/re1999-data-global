module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepCreateObject", package.seeall)

local var_0_0 = class("Va3ChessStepCreateObject", Va3ChessStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0.originData.id

	Va3ChessGameModel.instance:removeObjectById(var_1_0)
	Va3ChessGameController.instance:deleteInteractObj(var_1_0)

	local var_1_1 = Va3ChessGameModel.instance:getActId()
	local var_1_2 = Va3ChessGameModel.instance:addObject(var_1_1, arg_1_0.originData)

	var_1_2:setHaveBornEff(true)
	Va3ChessGameController.instance:addInteractObj(var_1_2)
	logNormal("create object finish !" .. tostring(var_1_2.id))

	local var_1_3 = Va3ChessConfig.instance:getInteractObjectCo(var_1_1, var_1_0)

	if var_1_3 and var_1_3.createAudioId and var_1_3.createAudioId ~= 0 then
		AudioMgr.instance:trigger(var_1_3.createAudioId)
	end

	arg_1_0:finish()
end

return var_0_0
