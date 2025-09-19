module("modules.logic.fight.entity.comp.FightNameUIHealthComp", package.seeall)

local var_0_0 = class("FightNameUIHealthComp", UserDataDispose)

var_0_0.PrefabPath = "ui/viewres/fight/fightsurvivalhealthview.prefab"

function var_0_0.Create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.New()

	var_1_0:initComp(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.initComp(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:__onInit()

	arg_2_0.containerGo = arg_2_2
	arg_2_0.entity = arg_2_1
	arg_2_0.entityId = arg_2_0.entity.id

	arg_2_0:loadPrefab()
end

function var_0_0.loadPrefab(arg_3_0)
	arg_3_0:clearLoader()

	arg_3_0.loader = PrefabInstantiate.Create(arg_3_0.containerGo)

	arg_3_0.loader:startLoad(var_0_0.PrefabPath, arg_3_0.onLoadFinish, arg_3_0)
end

var_0_0.AnchorY = 95

function var_0_0.onLoadFinish(arg_4_0)
	arg_4_0.instanceGo = arg_4_0.loader:getInstGO()

	local var_4_0 = arg_4_0.instanceGo:GetComponent(gohelper.Type_RectTransform)

	recthelper.setAnchorY(var_4_0, var_0_0.AnchorY)

	arg_4_0.imageIcon = gohelper.findChildImage(arg_4_0.instanceGo, "root/#image_icon")

	arg_4_0:hideHealth()
	arg_4_0:tryShowHealth()
	arg_4_0:addEventCb(FightController.instance, FightEvent.HeroHealthValueChange, arg_4_0.onHeroHealthChange, arg_4_0)
end

function var_0_0.onHeroHealthChange(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_1 ~= arg_5_0.entityId then
		return
	end

	arg_5_0:tryShowHealth()
end

function var_0_0.hideHealth(arg_6_0)
	gohelper.setActive(arg_6_0.instanceGo, false)
end

function var_0_0.showHealth(arg_7_0)
	gohelper.setActive(arg_7_0.instanceGo, true)
end

var_0_0.HealthStatus = {
	Two = 2,
	One = 1,
	Four = 4,
	Three = 3
}
var_0_0.HealthThreshold = {
	[var_0_0.HealthStatus.One] = 0,
	[var_0_0.HealthStatus.Two] = 0.334,
	[var_0_0.HealthStatus.Three] = 0.667,
	[var_0_0.HealthStatus.Four] = 1
}
var_0_0.HealthList = {
	var_0_0.HealthStatus.Two,
	var_0_0.HealthStatus.Three,
	var_0_0.HealthStatus.Four
}
var_0_0.HealthStatus2Icon = {
	[var_0_0.HealthStatus.One] = "fight_dikangli_icon_1",
	[var_0_0.HealthStatus.Two] = "fight_dikangli_icon_2",
	[var_0_0.HealthStatus.Three] = "fight_dikangli_icon_3",
	[var_0_0.HealthStatus.Four] = "fight_dikangli_icon_4"
}
var_0_0.HealthStatus2TitleConst = {
	[var_0_0.HealthStatus.One] = 2317,
	[var_0_0.HealthStatus.Two] = 2316,
	[var_0_0.HealthStatus.Three] = 2315,
	[var_0_0.HealthStatus.Four] = 2314
}
var_0_0.HealthStatus2DescConst = {
	[var_0_0.HealthStatus.One] = 2313,
	[var_0_0.HealthStatus.Two] = 2312,
	[var_0_0.HealthStatus.Three] = 2311,
	[var_0_0.HealthStatus.Four] = 2310
}

function var_0_0.tryShowHealth(arg_8_0)
	local var_8_0 = FightHelper.getSurvivalEntityHealth(arg_8_0.entityId)

	if not var_8_0 then
		TaskDispatcher.cancelTask(arg_8_0.hideHealth, arg_8_0)
		arg_8_0:hideHealth()

		return
	end

	local var_8_1 = arg_8_0.getCurHealthStatus(var_8_0)

	if arg_8_0.preShowHealthStatus == var_8_1 then
		return
	end

	TaskDispatcher.cancelTask(arg_8_0.hideHealth, arg_8_0)
	arg_8_0:showHealth()

	arg_8_0.preShowHealthStatus = var_8_1

	local var_8_2 = var_0_0.HealthStatus2Icon[var_8_1]

	UISpriteSetMgr.instance:setFightSprite(arg_8_0.imageIcon, var_8_2, true)
	TaskDispatcher.runDelay(arg_8_0.hideHealth, arg_8_0, 1)
end

function var_0_0.getCurHealthStatus(arg_9_0)
	local var_9_0 = FightHelper.getSurvivalMaxHealth()

	if not var_9_0 then
		return var_0_0.HealthStatus.Four
	end

	if arg_9_0 <= 0 then
		return var_0_0.HealthStatus.One
	end

	local var_9_1 = arg_9_0 / var_9_0

	for iter_9_0, iter_9_1 in ipairs(var_0_0.HealthList) do
		if var_9_1 <= var_0_0.HealthThreshold[iter_9_1] then
			return iter_9_1
		end
	end

	return var_0_0.HealthStatus.Four
end

function var_0_0.getHealthIcon(arg_10_0)
	local var_10_0 = var_0_0.getCurHealthStatus(arg_10_0)

	return var_0_0.HealthStatus2Icon[var_10_0]
end

function var_0_0.getHealthTitle(arg_11_0)
	local var_11_0 = var_0_0.HealthStatus2TitleConst[arg_11_0]
	local var_11_1 = var_11_0 and lua_survival_const.configDict[var_11_0]

	return var_11_1 and var_11_1.value2
end

function var_0_0.getHealthDesc(arg_12_0)
	local var_12_0 = var_0_0.HealthStatus2DescConst[arg_12_0]
	local var_12_1 = var_12_0 and lua_survival_const.configDict[var_12_0]

	return var_12_1 and var_12_1.value2
end

function var_0_0.clearLoader(arg_13_0)
	if arg_13_0.loader then
		arg_13_0.loader:dispose()

		arg_13_0.loader = nil
	end
end

function var_0_0.beforeDestroy(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.hideHealth, arg_14_0)
	arg_14_0:clearLoader()
	arg_14_0:__onDispose()
end

return var_0_0
