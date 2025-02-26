module("modules.logic.scene.fight.preloadwork.FightPreloadViewWork", package.seeall)

slot0 = class("FightPreloadViewWork", BaseWork)
slot0.ui_chupai_01 = "ui_chupai_01"
slot0.ui_chupai_02 = "ui_chupai_02"
slot0.ui_chupai_03 = "ui_chupai_03"
slot0.ui_kapaituowei = "ui_kapaituowei"
slot0.ui_dazhaoka = "ui_dazhaoka"
slot0.ui_effect_dna_c = "ui/viewres/fight/ui_effect_dna_c.prefab"
slot0.FightSpriteAssets = "ui/spriteassets/fight.asset"

function slot0.onStart(slot0, slot1)
	slot0._loader = SequenceAbLoader.New()

	slot0._loader:addPath(ResUrl.getSceneUIPrefab("fight", "fightfloat"))

	slot6 = "fightname"

	slot0._loader:addPath(ResUrl.getSceneUIPrefab("fight", slot6))
	slot0._loader:addPath(ResUrl.getUIEffect(uv0.ui_chupai_01))
	slot0._loader:addPath(ResUrl.getUIEffect(uv0.ui_chupai_02))
	slot0._loader:addPath(ResUrl.getUIEffect(uv0.ui_chupai_03))
	slot0._loader:addPath(ResUrl.getUIEffect(uv0.ui_kapaituowei))
	slot0._loader:addPath(ResUrl.getUIEffect(uv0.ui_dazhaoka))
	slot0._loader:addPath(uv0.FightSpriteAssets)
	slot0._loader:addPath(uv0.ui_effect_dna_c)

	slot2 = ViewMgr.instance:getSetting(ViewName.FightView)

	slot0._loader:addPath(slot2.mainRes)

	for slot6, slot7 in ipairs(slot2.otherRes) do
		slot0._loader:addPath(slot7)
	end

	slot0._loader:addPath(ViewMgr.instance:getSetting(ViewName.FightRoundView).mainRes)
	slot0._loader:addPath(ViewMgr.instance:getSetting(ViewName.FightSkillSelectView).mainRes)
	slot0._loader:setConcurrentCount(10)
	slot0._loader:setLoadFailCallback(slot0._onPreloadOneFail)
	slot0._loader:startLoad(slot0._onPreloadFinish, slot0)
end

function slot0._onPreloadFinish(slot0)
	for slot5, slot6 in pairs(slot0._loader:getAssetItemDict()) do
		slot0.context.callback(slot0.context.callbackObj, slot6)
	end

	slot0:onDone(true)
end

function slot0._onPreloadOneFail(slot0, slot1, slot2)
	logError("战斗资源加载失败：" .. slot2.ResPath)
end

function slot0.clearWork(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

return slot0
