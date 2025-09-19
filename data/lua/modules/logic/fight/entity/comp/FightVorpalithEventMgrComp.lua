module("modules.logic.fight.entity.comp.FightVorpalithEventMgrComp", package.seeall)

local var_0_0 = class("FightVorpalithEventMgrComp", LuaCompBase)

var_0_0.Anchor = Vector2(556, 250)
var_0_0.TweenTime = 2
var_0_0.FloatEffectCDTime = 5
var_0_0.EffectRes = "ui/viewres/fight/fightsurvivaleffectview.prefab"
var_0_0.LoadStatus = {
	NotLoad = 0,
	Loaded = 2,
	Loading = 1
}

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0.preShowEffectTime = -(var_0_0.FloatEffectCDTime + 0.1)
	arg_1_0.loadStatus = var_0_0.LoadStatus.NotLoad
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0:addEventCb(FightController.instance, FightEvent.TriggerVorpalithSkill, arg_2_0.onTriggerVorpalithSkill, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.TriggerVorpalithSkill, arg_3_0.onTriggerVorpalithSkill, arg_3_0)
end

function var_0_0.findClientEffect3(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.actEffect

	if not var_4_0 then
		return
	end

	local var_4_1 = FightEnum.EffectType.CLIENTEFFECT
	local var_4_2 = FightEnum.EffectType.FIGHTSTEP

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if iter_4_1.effectType == var_4_1 and iter_4_1.effectNum == FightWorkClientEffect339.ClientEffectEnum.TriggerVorpalithSkill then
			table.insert(arg_4_0.tempActEffectList, arg_4_1)
			table.insert(arg_4_0.tempActEffectList, iter_4_1)
		elseif iter_4_1.effectType == var_4_2 then
			arg_4_0:findClientEffect3(iter_4_1.fightStep)
		end
	end
end

function var_0_0.onTriggerVorpalithSkill(arg_5_0)
	if arg_5_0.loadStatus == var_0_0.LoadStatus.Loading then
		return
	end

	if arg_5_0.loadStatus == var_0_0.LoadStatus.Loaded then
		arg_5_0:startFloat()

		return
	end

	arg_5_0:startLoadRes()
end

function var_0_0.startLoadRes(arg_6_0)
	local var_6_0 = ViewMgr.instance:getContainer(ViewName.FightView)
	local var_6_1 = var_6_0 and var_6_0.viewGO
	local var_6_2 = var_6_1 and gohelper.findChild(var_6_1, "root")

	if gohelper.isNil(var_6_2) then
		return
	end

	arg_6_0.loader = PrefabInstantiate.Create(var_6_2)

	arg_6_0.loader:startLoad(var_0_0.EffectRes, arg_6_0.onLoaded, arg_6_0)

	arg_6_0.loadStatus = var_0_0.LoadStatus.Loading
end

function var_0_0.onLoaded(arg_7_0)
	arg_7_0.loadStatus = var_0_0.LoadStatus.Loaded

	arg_7_0:initGo()
	arg_7_0:startFloat()
end

function var_0_0.initGo(arg_8_0)
	arg_8_0.instanceGo = arg_8_0.loader:getInstGO()
	arg_8_0.instanceRectTr = arg_8_0.instanceGo:GetComponent(gohelper.Type_RectTransform)

	recthelper.setAnchor(arg_8_0.instanceRectTr, var_0_0.Anchor.x, var_0_0.Anchor.y)

	arg_8_0.simageIcon = gohelper.findChildSingleImage(arg_8_0.instanceGo, "#image_icon")

	gohelper.setActive(arg_8_0.instanceGo, false)

	arg_8_0.animator = arg_8_0.instanceGo:GetComponent(gohelper.Type_Animator)
end

function var_0_0.startFloat(arg_9_0)
	local var_9_0 = Time.realtimeSinceStartup

	if var_9_0 - arg_9_0.preShowEffectTime < arg_9_0.FloatEffectCDTime then
		return
	end

	local var_9_1 = FightDataHelper.fieldMgr.customData and FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Survival]
	local var_9_2 = var_9_1 and var_9_1.equipMaxTagId
	local var_9_3 = var_9_2 and lua_survival_equip_found.configDict[var_9_2]
	local var_9_4 = var_9_3 and var_9_3.icon2

	if string.nilorempty(var_9_4) then
		logError(string.format("lua_survival_equip_found.icon2 is nil, customData : %s, tagId : %s", tostring(var_9_1), tostring(var_9_2)))
	end

	arg_9_0.simageIcon:LoadImage(string.format("singlebg/survival_singlebg/equip/icon/%s.png", var_9_4))

	arg_9_0.preShowEffectTime = var_9_0

	gohelper.setActive(arg_9_0.instanceGo, true)
	arg_9_0.animator:Play("open", 0, 0)
end

function var_0_0.onTweenDone(arg_10_0)
	gohelper.setActive(arg_10_0.instanceGo, false)

	arg_10_0.tweenId = nil
end

function var_0_0.clearTween(arg_11_0)
	if arg_11_0.tweenId then
		ZProj.TweenHelper.ClearTween(arg_11_0.tweenId)

		arg_11_0.tweenId = nil
	end
end

function var_0_0.clearStepWork(arg_12_0)
	if arg_12_0.stepWork then
		arg_12_0.stepWork:onDestroy()

		arg_12_0.stepWork = nil
	end
end

function var_0_0.onDestroy(arg_13_0)
	arg_13_0:clearStepWork()

	if not gohelper.isNil(arg_13_0.simageIcon) then
		arg_13_0.simageIcon:UnLoadImage()

		arg_13_0.simageIcon = nil
	end

	arg_13_0.loadStatus = var_0_0.LoadStatus.NotLoad

	if arg_13_0.loader then
		arg_13_0.loader:dispose()

		arg_13_0.loader = nil
	end
end

return var_0_0
