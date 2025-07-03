module("modules.logic.tips.view.stress.FightFocusStressCompBase", package.seeall)

local var_0_0 = class("FightFocusStressCompBase", UserDataDispose)

var_0_0.PrefabPath = FightNameUIStressMgr.PrefabPath

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.goStress = arg_1_1

	arg_1_0:loadPrefab()
end

function var_0_0.getUiType(arg_2_0)
	return FightNameUIStressMgr.UiType.Normal
end

function var_0_0.loadPrefab(arg_3_0)
	arg_3_0.loader = PrefabInstantiate.Create(arg_3_0.goStress)

	local var_3_0 = FightNameUIStressMgr.UiType2PrefabPath[arg_3_0:getUiType()] or FightNameUIStressMgr.UiType2PrefabPath[FightNameUIStressMgr.UiType.Normal]

	arg_3_0.loader:startLoad(var_3_0, arg_3_0.onLoadFinish, arg_3_0)
end

function var_0_0.onLoadFinish(arg_4_0)
	arg_4_0.instanceGo = arg_4_0.loader:getInstGO()
	arg_4_0.loaded = true

	arg_4_0:initUI()
	arg_4_0:refreshStress(arg_4_0.cacheEntityMo)

	arg_4_0.cacheEntityMo = nil
end

function var_0_0.initUI(arg_5_0)
	return
end

function var_0_0.show(arg_6_0)
	gohelper.setActive(arg_6_0.instanceGo, true)
end

function var_0_0.hide(arg_7_0)
	gohelper.setActive(arg_7_0.instanceGo, false)
end

function var_0_0.refreshStress(arg_8_0, arg_8_1)
	if not arg_8_0.loaded then
		arg_8_0.cacheEntityMo = arg_8_1

		return
	end

	arg_8_0.entityMo = arg_8_1

	if not arg_8_1 then
		arg_8_0:hide()

		return
	end

	if not arg_8_1:hasStress() then
		arg_8_0:hide()

		return
	end

	arg_8_0.entityMo = arg_8_1
end

function var_0_0.destroy(arg_9_0)
	arg_9_0.loader:dispose()

	arg_9_0.loader = nil

	arg_9_0:__onDispose()
end

return var_0_0
