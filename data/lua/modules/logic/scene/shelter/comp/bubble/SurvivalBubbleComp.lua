module("modules.logic.scene.shelter.comp.bubble.SurvivalBubbleComp", package.seeall)

local var_0_0 = class("SurvivalBubbleComp", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = 0
	arg_1_0.bubbleDic = {}
end

function var_0_0.onScenePrepared(arg_2_0)
	return
end

function var_0_0.onSceneClose(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.bubbleDic) do
		iter_3_1:disable()
		iter_3_1:__onDispose()
	end

	tabletool.clear(arg_3_0.bubbleDic)

	arg_3_0.playerBubbleId = nil
end

function var_0_0.showBubble(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0:getId()
	local var_4_1 = SurvivalBubble.New(var_4_0, arg_4_0)

	var_4_1:__onInit()
	var_4_1:setData(arg_4_2, arg_4_1)

	arg_4_0.bubbleDic[var_4_0] = var_4_1

	var_4_1:enable()
	arg_4_0:dispatchEvent(SurvivalEvent.OnShowBubble, {
		id = var_4_0,
		survivalBubble = var_4_1
	})

	return var_4_0
end

function var_0_0.removeBubble(arg_5_0, arg_5_1)
	if not arg_5_0.bubbleDic[arg_5_1] then
		return
	end

	arg_5_0.bubbleDic[arg_5_1]:disable()
	arg_5_0.bubbleDic[arg_5_1]:__onDispose()

	arg_5_0.bubbleDic[arg_5_1] = nil

	arg_5_0:dispatchEvent(SurvivalEvent.OnRemoveBubble, {
		id = arg_5_1
	})
end

function var_0_0.isBubbleShow(arg_6_0, arg_6_1)
	return arg_6_0.bubbleDic[arg_6_1]
end

function var_0_0.getBubble(arg_7_0, arg_7_1)
	return arg_7_0.bubbleDic[arg_7_1]
end

function var_0_0.showPlayerBubble(arg_8_0, arg_8_1)
	if not arg_8_0:isPlayerBubbleShow() then
		local var_8_0 = SurvivalMapHelper.instance:getShelterEntity(SurvivalEnum.ShelterUnitType.Player, 0)

		arg_8_0.playerBubbleId = arg_8_0:showBubble(var_8_0.trans, arg_8_1)

		var_8_0:stopMove()
	end
end

function var_0_0.isPlayerBubbleShow(arg_9_0)
	return arg_9_0.playerBubbleId and arg_9_0:isBubbleShow(arg_9_0.playerBubbleId)
end

function var_0_0.removePlayerBubble(arg_10_0)
	if arg_10_0:isPlayerBubbleShow() then
		arg_10_0:removeBubble(arg_10_0.playerBubbleId)

		arg_10_0.playerBubbleId = nil
	end
end

function var_0_0.isPlayerBubbleIntercept(arg_11_0)
	local var_11_0 = SurvivalMapHelper.instance:getSurvivalBubbleComp()

	if var_11_0:isPlayerBubbleShow() then
		var_11_0:removePlayerBubble()

		return true
	end
end

function var_0_0.getId(arg_12_0)
	arg_12_0.id = arg_12_0.id + 1

	return arg_12_0.id
end

return var_0_0
