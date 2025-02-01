module("modules.logic.guide.controller.action.impl.GuideActionPreloadFirstFight", package.seeall)

slot0 = class("GuideActionPreloadFirstFight", BaseGuideAction)
slot1 = {
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

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if FightPreloadController.instance:isPreloading() then
		slot0:onDone(true)

		return
	end

	slot2 = tonumber(slot0.actionParam)
	slot3 = uv1[slot2]

	if not slot2 then
		logError("no preload config, battleId = " .. slot2)
		slot0:onDone(true)
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, 2)
	FightPreloadController.instance:preloadReconnect(slot2, slot3.myModelIds, slot3.mySkinIds, slot3.enemyModelIds, slot3.enemySkinIds, slot3.subSkinIds)
	slot0:onDone(true)
end

return slot0
