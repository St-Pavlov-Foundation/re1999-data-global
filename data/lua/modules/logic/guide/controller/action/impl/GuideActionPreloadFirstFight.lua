module("modules.logic.guide.controller.action.impl.GuideActionPreloadFirstFight", package.seeall)

local var_0_0 = class("GuideActionPreloadFirstFight", BaseGuideAction)
local var_0_1 = {
	[1001] = {
		myModelIds = {
			100102,
			100101
		},
		mySkinIds = {
			302501,
			302301
		},
		enemyModelIds = {
			100103,
			100104
		},
		enemySkinIds = {
			410401,
			410501
		},
		subSkinIds = {}
	},
	[1002] = {
		myModelIds = {
			100102,
			100101
		},
		mySkinIds = {
			302501,
			302301
		},
		enemyModelIds = {
			100105,
			100106,
			100107
		},
		enemySkinIds = {
			410401,
			411401,
			410601
		},
		subSkinIds = {}
	},
	[1003] = {
		myModelIds = {
			100109
		},
		mySkinIds = {
			302301
		},
		enemyModelIds = {
			100108
		},
		enemySkinIds = {
			302501
		},
		subSkinIds = {}
	}
}

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	if FightPreloadController.instance:isPreloading() then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = tonumber(arg_1_0.actionParam)
	local var_1_1 = var_0_1[var_1_0]

	if not var_1_0 then
		logError("no preload config, battleId = " .. var_1_0)
		arg_1_0:onDone(true)
	end

	local var_1_2 = var_1_1.myModelIds
	local var_1_3 = var_1_1.mySkinIds
	local var_1_4 = var_1_1.enemyModelIds
	local var_1_5 = var_1_1.enemySkinIds
	local var_1_6 = var_1_1.subSkinIds

	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, 2)
	FightPreloadController.instance:preloadReconnect(var_1_0, var_1_2, var_1_3, var_1_4, var_1_5, var_1_6)
	arg_1_0:onDone(true)
end

return var_0_0
