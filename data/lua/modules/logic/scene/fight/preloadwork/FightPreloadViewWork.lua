module("modules.logic.scene.fight.preloadwork.FightPreloadViewWork", package.seeall)

local var_0_0 = class("FightPreloadViewWork", BaseWork)

var_0_0.ui_chupai_01 = "ui_chupai_01"
var_0_0.ui_chupai_02 = "ui_chupai_02"
var_0_0.ui_chupai_03 = "ui_chupai_03"
var_0_0.ui_kapaituowei = "ui_kapaituowei"
var_0_0.ui_dazhaoka = "ui_dazhaoka"
var_0_0.ui_effect_dna_c = "ui/viewres/fight/ui_effect_dna_c.prefab"
var_0_0.FightSpriteAssets = "ui/spriteassets/fight.asset"

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0._loader = SequenceAbLoader.New()

	arg_1_0._loader:addPath(ResUrl.getSceneUIPrefab("fight", "fightfloat"))
	arg_1_0._loader:addPath(ResUrl.getSceneUIPrefab("fight", "fightname"))
	arg_1_0._loader:addPath(ResUrl.getUIEffect(var_0_0.ui_chupai_01))
	arg_1_0._loader:addPath(ResUrl.getUIEffect(var_0_0.ui_chupai_02))
	arg_1_0._loader:addPath(ResUrl.getUIEffect(var_0_0.ui_chupai_03))
	arg_1_0._loader:addPath(ResUrl.getUIEffect(var_0_0.ui_kapaituowei))
	arg_1_0._loader:addPath(ResUrl.getUIEffect(var_0_0.ui_dazhaoka))
	arg_1_0._loader:addPath(var_0_0.FightSpriteAssets)
	arg_1_0._loader:addPath(var_0_0.ui_effect_dna_c)

	local var_1_0 = ViewMgr.instance:getSetting(ViewName.FightView)

	arg_1_0._loader:addPath(var_1_0.mainRes)

	for iter_1_0, iter_1_1 in ipairs(var_1_0.otherRes) do
		arg_1_0._loader:addPath(iter_1_1)
	end

	local var_1_1 = ViewMgr.instance:getSetting(ViewName.FightRoundView)

	arg_1_0._loader:addPath(var_1_1.mainRes)

	local var_1_2 = ViewMgr.instance:getSetting(ViewName.FightSkillSelectView)

	arg_1_0._loader:addPath(var_1_2.mainRes)
	arg_1_0._loader:setConcurrentCount(10)
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
