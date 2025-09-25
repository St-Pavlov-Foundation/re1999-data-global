module("modules.logic.fight.view.FightFloatItem", package.seeall)

local var_0_0 = class("FightFloatItem")
local var_0_1 = {
	[FightEnum.FloatType.crit_restrain] = "x/sp01_logo",
	[FightEnum.FloatType.crit_heal] = "x/sp01_logo",
	[FightEnum.FloatType.crit_damage] = "x/sp01_logo",
	[FightEnum.FloatType.restrain] = "x/sp01_logo",
	[FightEnum.FloatType.heal] = "x/sp01_logo",
	[FightEnum.FloatType.damage] = "x/sp01_logo",
	[FightEnum.FloatType.crit_damage_origin] = "x/sp01_logo",
	[FightEnum.FloatType.damage_origin] = "x/sp01_logo",
	[FightEnum.FloatType.additional_damage] = "x/sp01_logo",
	[FightEnum.FloatType.crit_additional_damage] = "x/sp01_logo"
}

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.entityId = nil
	arg_1_0.type = arg_1_1
	arg_1_0._typeGO = arg_1_2
	arg_1_0._typeRectTr = arg_1_2.transform
	arg_1_0._halfRandomXRange = arg_1_3 / 2
	arg_1_0._txtNum = gohelper.findChildText(arg_1_2, "x/txtNum")
	arg_1_0._csGoActivator = arg_1_0._typeGO:GetComponent(typeof(ZProj.GoActivator))
	arg_1_0._effectTimeScale = gohelper.onceAddComponent(arg_1_0._typeGO, typeof(ZProj.EffectTimeScale))

	gohelper.setActive(arg_1_0._typeGO, false)

	if var_0_1[arg_1_0.type] then
		arg_1_0.goSp01Logo = gohelper.findChild(arg_1_2, var_0_1[arg_1_0.type])

		gohelper.setActive(arg_1_0.goSp01Logo, false)
	end

	arg_1_0._floatFunc = var_0_0.FloatFunc[arg_1_1]
	arg_1_0._floatEndFunc = var_0_0.FloatEndFunc[arg_1_1]
end

function var_0_0.getGO(arg_2_0)
	return arg_2_0._typeGO
end

function var_0_0.startFloat(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.startTime = Time.time
	arg_3_0.entityId = arg_3_1

	gohelper.setActive(arg_3_0._typeGO, true)

	if arg_3_0._txtNum then
		local var_3_0 = tostring(arg_3_2)

		if arg_3_0.type == FightEnum.FloatType.crit_heal or arg_3_0.type == FightEnum.FloatType.heal then
			var_3_0 = "+" .. var_3_0
		end

		arg_3_0._txtNum.text = var_3_0
	end

	arg_3_0:floatAssassinate(arg_3_4)

	if arg_3_0._floatFunc then
		arg_3_0._floatFunc(arg_3_0, arg_3_2, arg_3_3, arg_3_4)
	end

	if arg_3_0.type == FightEnum.FloatType.equipeffect and arg_3_0.can_not_play_equip_effect then
		arg_3_0:_onFinish()

		return
	end

	if arg_3_0._csGoActivator then
		arg_3_0._csGoActivator:AddFinishCallback(arg_3_0._onFinish, arg_3_0)
		arg_3_0._csGoActivator:Play()
	else
		logWarn("no activator in fight float assset, type = " .. arg_3_0.type)
		arg_3_0:_onFinish()
	end

	if arg_3_0._effectTimeScale then
		arg_3_0._effectTimeScale:SetTimeScale(FightModel.instance:getUISpeed())
	end
end

function var_0_0.floatAssassinate(arg_4_0, arg_4_1)
	if arg_4_1 and not gohelper.isNil(arg_4_0.goSp01Logo) then
		gohelper.setActive(arg_4_0.goSp01Logo, true)
	else
		gohelper.setActive(arg_4_0.goSp01Logo, false)
	end
end

function var_0_0.setPos(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.startX = arg_5_1
	arg_5_0.startY = arg_5_2

	recthelper.setAnchor(arg_5_0._typeRectTr, arg_5_1, arg_5_2)
end

function var_0_0.tweenPosY(arg_6_0, arg_6_1)
	if arg_6_0._tweenId then
		ZProj.TweenHelper.KillById(arg_6_0._tweenId)
	end

	if arg_6_0.equip_single_img then
		arg_6_0:setPos(0, 150)

		return
	end

	arg_6_0._tweenId = ZProj.TweenHelper.DOAnchorPosY(arg_6_0._typeRectTr, arg_6_1, 0.15 / FightModel.instance:getUISpeed())
end

function var_0_0.stopFloat(arg_7_0)
	arg_7_0:_onFinish()
end

function var_0_0._onFinish(arg_8_0)
	if arg_8_0._csGoActivator then
		arg_8_0._csGoActivator:RemoveFinishCallback()
	end

	if arg_8_0._floatEndFunc then
		arg_8_0._floatEndFunc(arg_8_0)
	end

	FightFloatMgr.instance:floatEnd(arg_8_0)

	arg_8_0.entityId = nil
end

function var_0_0.reset(arg_9_0)
	gohelper.setActive(arg_9_0._typeGO, false)
end

function var_0_0.onDestroy(arg_10_0)
	if arg_10_0._tweenId then
		ZProj.TweenHelper.KillById(arg_10_0._tweenId)

		arg_10_0._tweenId = nil
	end

	if arg_10_0._csGoActivator then
		arg_10_0._csGoActivator:Stop()
		arg_10_0._csGoActivator:RemoveFinishCallback()

		arg_10_0._csGoActivator = nil
	end

	if arg_10_0._effectTimeScale then
		arg_10_0._effectTimeScale = nil
	end

	if arg_10_0.equip_single_img then
		arg_10_0.equip_single_img:UnLoadImage()
	end
end

function var_0_0._floatBuff(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = gohelper.findChild(arg_11_0._typeGO, "x/item1")

	gohelper.setActive(var_11_0, true)

	local var_11_1 = var_11_0.transform.childCount

	if var_11_1 < arg_11_2 then
		logError("buff飘字类型找不到，或者预设中没有对应类型的样式：", arg_11_2)

		return
	end

	for iter_11_0 = 1, var_11_1 do
		local var_11_2 = arg_11_2 == iter_11_0
		local var_11_3 = var_11_0.transform:Find("type_" .. iter_11_0).gameObject

		gohelper.setActive(var_11_3, var_11_2)

		if var_11_2 then
			gohelper.findChildText(var_11_3, "txtNum").text = arg_11_1
		end
	end
end

function var_0_0.hideEquipFloat(arg_12_0)
	if arg_12_0.type == FightEnum.FloatType.equipeffect then
		gohelper.setActive(arg_12_0._typeGO, false)
	end
end

function var_0_0._floatEquipEffect(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = FightHelper.getEntity(arg_13_0.entityId)

	if var_13_0 and var_13_0.marked_alpha == 0 then
		arg_13_0:hideEquipFloat()

		arg_13_0.can_not_play_equip_effect = true

		return
	end

	arg_13_0.can_not_play_equip_effect = false

	local var_13_1 = arg_13_0._typeGO.transform:Find("ani")

	arg_13_0.equip_single_img = arg_13_0.equip_single_img or gohelper.findChildSingleImage(arg_13_0._typeGO, "ani/simage_equipicon")

	local var_13_2 = var_13_1:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	var_13_2.mas:Clear()

	for iter_13_0 = 0, var_13_1.childCount - 1 do
		local var_13_3 = var_13_1:GetChild(iter_13_0):GetComponent(gohelper.Type_Image)

		var_13_3.material = UnityEngine.Object.Instantiate(var_13_3.material)

		var_13_2.mas:Add(var_13_3.material)
	end

	arg_13_0.equip_single_img:LoadImage(ResUrl.getFightEquipFloatIcon("xinxiang" .. arg_13_2.id))
end

function var_0_0._floatTotal(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = FightHelper.getEntity(arg_14_2.fromId)
	local var_14_1 = FightHelper.getEntity(arg_14_2.defenderId)
	local var_14_2 = gohelper.findChild(arg_14_0._typeGO, "x")

	gohelper.setActive(var_14_2, var_14_0 and var_14_1)

	if var_14_0 and var_14_1 then
		local var_14_3 = var_14_0:getMO()
		local var_14_4 = var_14_1:getMO()
		local var_14_5 = var_14_3 and var_14_3:getCO()
		local var_14_6 = var_14_4 and var_14_4:getCO()
		local var_14_7 = var_14_5 and var_14_5.career or 0
		local var_14_8 = var_14_6 and var_14_6.career or 0
		local var_14_9 = FightConfig.instance:getRestrain(var_14_7, var_14_8) or 1000
		local var_14_10
		local var_14_11 = var_14_9 == 1000 and 3 or var_14_9 > 1000 and 1 or 2

		for iter_14_0 = 1, 3 do
			local var_14_12 = gohelper.findChildText(arg_14_0._typeGO, "x/txtNum" .. iter_14_0)
			local var_14_13 = gohelper.findChild(arg_14_0._typeGO, "x/sp01_logo" .. iter_14_0)

			gohelper.setActive(var_14_12.gameObject, iter_14_0 == var_14_11)
			gohelper.setActive(var_14_13, arg_14_3 and iter_14_0 == var_14_11)

			if iter_14_0 == var_14_11 then
				var_14_12.text = arg_14_1

				if arg_14_3 then
					AudioMgr.instance:trigger(20305030)
				end
			end
		end
	end
end

function var_0_0._floatStress(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = gohelper.findChild(arg_15_0._typeGO, "x/item1")

	gohelper.setActive(var_15_0, true)

	local var_15_1 = var_15_0.transform.childCount

	if var_15_1 < arg_15_2 then
		logError("压力飘字类型找不到，或者预设中没有对应类型的样式：", arg_15_2)

		return
	end

	for iter_15_0 = 1, var_15_1 do
		local var_15_2 = arg_15_2 == iter_15_0
		local var_15_3 = var_15_0.transform:Find("type_" .. iter_15_0).gameObject

		gohelper.setActive(var_15_3, var_15_2)

		if var_15_2 then
			gohelper.findChildText(var_15_3, "txtNum").text = arg_15_1
		end
	end
end

function var_0_0._floatBuffEnd(arg_16_0)
	return
end

var_0_0.FloatFunc = {
	[FightEnum.FloatType.buff] = var_0_0._floatBuff,
	[FightEnum.FloatType.equipeffect] = var_0_0._floatEquipEffect,
	[FightEnum.FloatType.total] = var_0_0._floatTotal,
	[FightEnum.FloatType.total_origin] = var_0_0._floatTotal,
	[FightEnum.FloatType.stress] = var_0_0._floatStress
}
var_0_0.FloatEndFunc = {
	[FightEnum.FloatType.buff] = var_0_0._floatBuffEnd
}

return var_0_0
