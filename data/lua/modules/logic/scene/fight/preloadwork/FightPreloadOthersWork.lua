module("modules.logic.scene.fight.preloadwork.FightPreloadOthersWork", package.seeall)

local var_0_0 = class("FightPreloadOthersWork", BaseWork)

var_0_0.ui_effectsmat = "ui/materials/dynamic/ui_effects.mat"
var_0_0.ui_mesh = "ui/viewres/fight/uimesh.prefab"
var_0_0.die_monster = "rolesbuff/die_monster.controller"
var_0_0.die_player = "rolesbuff/die_player.controller"
var_0_0.LvUpEffectPath = "ui/viewres/fight/cardrising.prefab"
var_0_0.LvDownEffectPath = "ui/viewres/fight/carddescending.prefab"
var_0_0.ClothSkillEffectPath = "ui/viewres/fight/ui_effect_flusheddown.prefab"

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0._loader = SequenceAbLoader.New()

	arg_1_0._loader:addPath(ResUrl.getSceneUIPrefab("fight", "fightfloat"))
	arg_1_0._loader:addPath(ResUrl.getRoleSpineMat("buff_distort"))
	arg_1_0._loader:addPath(ResUrl.getRoleSpineMat("buff_ice"))
	arg_1_0._loader:addPath(ResUrl.getRoleSpineMat("buff_stone"))
	arg_1_0._loader:addPath(ResUrl.getRoleSpineMat("buff_immune"))
	arg_1_0._loader:addPath(ResUrl.getRoleSpineMat("charator_globmask_stone"))
	arg_1_0._loader:addPath(ResUrl.getRoleSpineMatTex("noise_01_manual"))
	arg_1_0._loader:addPath(ResUrl.getRoleSpineMatTex("noise_02_manual"))
	arg_1_0._loader:addPath(ResUrl.getRoleSpineMatTex("noise_03_manual"))
	arg_1_0._loader:addPath(ResUrl.getRoleSpineMatTex("crayonmap1_manual"))
	arg_1_0._loader:addPath(ResUrl.getRoleSpineMatTex("crayonmap2_manual"))
	arg_1_0._loader:addPath(ResUrl.getRoleSpineMatTex("textures/stone_manual"))
	arg_1_0._loader:addPath(var_0_0.ui_effectsmat)
	arg_1_0._loader:addPath(var_0_0.ui_mesh)
	arg_1_0._loader:addPath(var_0_0.die_monster)
	arg_1_0._loader:addPath(var_0_0.die_player)
	arg_1_0._loader:addPath(var_0_0.LvUpEffectPath)
	arg_1_0._loader:addPath(var_0_0.LvDownEffectPath)
	arg_1_0._loader:addPath(var_0_0.ClothSkillEffectPath)
	arg_1_0._loader:setConcurrentCount(5)
	arg_1_0._loader:setInterval(0.01)
	arg_1_0._loader:setLoadFailCallback(arg_1_0._onPreloadOneFail)
	arg_1_0._loader:startLoad(arg_1_0._onPreloadFinish, arg_1_0)
end

function var_0_0._onPreloadFinish(arg_2_0)
	local var_2_0 = arg_2_0._loader:getAssetItemDict()

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		arg_2_0.context.callback(arg_2_0.context.callbackObj, iter_2_1)
	end

	arg_2_0:onDone(true)
end

function var_0_0._onPreloadOneFail(arg_3_0, arg_3_1, arg_3_2)
	logError("战斗资源加载失败：" .. arg_3_2.ResPath)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._loader then
		arg_4_0._loader:dispose()

		arg_4_0._loader = nil
	end
end

return var_0_0
