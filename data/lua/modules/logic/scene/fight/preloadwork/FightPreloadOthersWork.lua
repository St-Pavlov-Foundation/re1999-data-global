module("modules.logic.scene.fight.preloadwork.FightPreloadOthersWork", package.seeall)

slot0 = class("FightPreloadOthersWork", BaseWork)
slot0.ui_effectsmat = "ui/materials/dynamic/ui_effects.mat"
slot0.ui_mesh = "ui/viewres/fight/uimesh.prefab"
slot0.die_monster = "rolesbuff/die_monster.controller"
slot0.die_player = "rolesbuff/die_player.controller"
slot0.LvUpEffectPath = "ui/viewres/fight/cardrising.prefab"
slot0.LvDownEffectPath = "ui/viewres/fight/carddescending.prefab"
slot0.ClothSkillEffectPath = "ui/viewres/fight/ui_effect_flusheddown.prefab"

function slot0.onStart(slot0, slot1)
	slot0._loader = SequenceAbLoader.New()

	slot0._loader:addPath(ResUrl.getSceneUIPrefab("fight", "fightfloat"))
	slot0._loader:addPath(ResUrl.getRoleSpineMat("buff_distort"))
	slot0._loader:addPath(ResUrl.getRoleSpineMat("buff_ice"))
	slot0._loader:addPath(ResUrl.getRoleSpineMat("buff_stone"))
	slot0._loader:addPath(ResUrl.getRoleSpineMat("buff_immune"))
	slot0._loader:addPath(ResUrl.getRoleSpineMat("charator_globmask_stone"))
	slot0._loader:addPath(ResUrl.getRoleSpineMatTex("noise_01_manual"))
	slot0._loader:addPath(ResUrl.getRoleSpineMatTex("noise_02_manual"))
	slot0._loader:addPath(ResUrl.getRoleSpineMatTex("noise_03_manual"))
	slot0._loader:addPath(ResUrl.getRoleSpineMatTex("crayonmap1_manual"))
	slot0._loader:addPath(ResUrl.getRoleSpineMatTex("crayonmap2_manual"))
	slot0._loader:addPath(ResUrl.getRoleSpineMatTex("textures/stone_manual"))
	slot0._loader:addPath(uv0.ui_effectsmat)
	slot0._loader:addPath(uv0.ui_mesh)
	slot0._loader:addPath(uv0.die_monster)
	slot0._loader:addPath(uv0.die_player)
	slot0._loader:addPath(uv0.LvUpEffectPath)
	slot0._loader:addPath(uv0.LvDownEffectPath)
	slot0._loader:addPath(uv0.ClothSkillEffectPath)
	slot0._loader:setConcurrentCount(5)
	slot0._loader:setInterval(0.01)
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
