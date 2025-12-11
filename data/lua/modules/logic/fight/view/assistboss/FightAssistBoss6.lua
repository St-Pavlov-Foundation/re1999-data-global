module("modules.logic.fight.view.assistboss.FightAssistBoss6", package.seeall)

local var_0_0 = class("FightAssistBoss6", FightAssistBossBase)

function var_0_0.setPrefabPath(arg_1_0)
	arg_1_0.prefabPath = "ui/viewres/assistboss/boss6.prefab"
end

var_0_0.PowerType = {
	Blue = 2,
	Red = 1
}
var_0_0.BuffTypeId2PowerType = {
	[130100111] = var_0_0.PowerType.Red,
	[130100112] = var_0_0.PowerType.Red,
	[130100113] = var_0_0.PowerType.Red,
	[130100121] = var_0_0.PowerType.Blue,
	[130100122] = var_0_0.PowerType.Blue,
	[130100123] = var_0_0.PowerType.Blue
}
var_0_0.Anim = {
	Open = "open",
	Close = "close",
	Idle = "idle",
	Loop = "loop"
}
var_0_0.MaxPower = 5
var_0_0.Radius = 58
var_0_0.AngleInterval = 45
var_0_0.InitAngle = -135
var_0_0.Radian = math.pi / 180
var_0_0.TweenAnimDuration = 0.5

function var_0_0.initView(arg_2_0)
	var_0_0.super.initView(arg_2_0)
	gohelper.setActive(arg_2_0.goCD, false)

	arg_2_0.goUnLight = gohelper.findChild(arg_2_0.viewGo, "head/unlight")
	arg_2_0.unLightHeadImage = gohelper.findChildImage(arg_2_0.viewGo, "head/unlight/boss")
	arg_2_0.unLightHeadSImage = gohelper.findChildSingleImage(arg_2_0.viewGo, "head/unlight/boss")
	arg_2_0.goLight = gohelper.findChild(arg_2_0.viewGo, "head/light")
	arg_2_0.goRedLightVx = gohelper.findChild(arg_2_0.goLight, "light_red")
	arg_2_0.goBlueLightVx = gohelper.findChild(arg_2_0.goLight, "light_blue")
	arg_2_0.lightHeadImage = gohelper.findChildImage(arg_2_0.viewGo, "head/light/boss")
	arg_2_0.lightHeadSImage = gohelper.findChildSingleImage(arg_2_0.viewGo, "head/light/boss")
	arg_2_0.goPointItem = gohelper.findChild(arg_2_0.viewGo, "go_energy/go_point_item")

	gohelper.setActive(arg_2_0.goPointItem, false)

	arg_2_0.tempBuffList = {}
	arg_2_0.powerItemPool = {}
	arg_2_0.waitAddPowerBuffUidList = {}
	arg_2_0.overFlowBuffDict = {}
	arg_2_0.playRecycleAnimItemList = {}
	arg_2_0.tweenAnimIng = false
	arg_2_0.assistBoss = FightDataHelper.entityMgr:getAssistBoss()
	arg_2_0.assistBossUid = arg_2_0.assistBoss.uid

	arg_2_0:refreshEmptyPower()
	arg_2_0:refreshPowerCount()
end

function var_0_0.refreshEmptyPower(arg_3_0)
	arg_3_0.emptyPowerItemList = arg_3_0.emptyPowerItemList or {}

	local var_3_0, var_3_1 = FightDataHelper.paTaMgr:getAssistBossServerPower()

	for iter_3_0 = 1, var_3_1 do
		local var_3_2 = arg_3_0.emptyPowerItemList[iter_3_0]

		if not var_3_2 then
			var_3_2 = arg_3_0:createPowerItem(iter_3_0)

			table.insert(arg_3_0.emptyPowerItemList, var_3_2)
			gohelper.setAsFirstSibling(var_3_2.go)
		end

		local var_3_3 = arg_3_0:getAngle(iter_3_0)

		var_3_2.initAngle = var_3_3
		var_3_2.curAngle = var_3_3
		var_3_2.targetAngle = var_3_3

		gohelper.setActive(var_3_2.go, true)

		local var_3_4, var_3_5 = arg_3_0:getAnchorPos(var_3_3)

		recthelper.setAnchor(var_3_2.rect, var_3_4, var_3_5)
	end

	for iter_3_1 = var_3_1 + 1, #arg_3_0.emptyPowerItemList do
		local var_3_6 = table.remove(arg_3_0.emptyPowerItemList)

		if var_3_6 then
			gohelper.destroy(var_3_6.go, false)
		end
	end
end

function var_0_0.refreshPowerCount(arg_4_0)
	arg_4_0.powerItemList = arg_4_0.powerItemList or {}

	tabletool.clear(arg_4_0.tempBuffList)

	local var_4_0 = arg_4_0.assistBoss:getOrderedBuffList_ByTime(arg_4_0.tempBuffList)
	local var_4_1 = #var_4_0
	local var_4_2
	local var_4_3
	local var_4_4, var_4_5 = FightDataHelper.paTaMgr:getAssistBossPower()

	for iter_4_0 = 1, var_4_4 do
		local var_4_6, var_4_7

		var_4_6, var_4_1, var_4_7 = arg_4_0:getNextPowerType(var_4_0, var_4_1)

		if var_4_6 then
			local var_4_8 = arg_4_0.powerItemList[iter_4_0]

			if not var_4_8 then
				var_4_8 = arg_4_0:createPowerItem(iter_4_0, var_4_7)

				table.insert(arg_4_0.powerItemList, var_4_8)
			end

			gohelper.setActive(var_4_8.go, true)
			gohelper.setActive(var_4_8.goRed, var_4_6 == var_0_0.PowerType.Red)
			gohelper.setActive(var_4_8.goBlue, var_4_6 == var_0_0.PowerType.Blue)

			local var_4_9 = arg_4_0:getAngle(iter_4_0)

			var_4_8.curAngle = var_4_9
			var_4_8.targetAngle = var_4_9
			var_4_8.initAngle = var_4_9

			local var_4_10, var_4_11 = arg_4_0:getAnchorPos(var_4_9)

			recthelper.setAnchor(var_4_8.rect, var_4_10, var_4_11)
			var_4_8.animatorPlayer:Play(var_0_0.Anim.Open)
		else
			logError(string.format("能量和buff个数不对应 .. %s / %s", iter_4_0, var_4_4))

			var_4_1 = 0
		end
	end

	arg_4_0:refreshHeadImageColor()
end

function var_0_0.createPowerItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0

	if #arg_5_0.powerItemPool > 0 then
		var_5_0 = table.remove(arg_5_0.powerItemPool)
	else
		var_5_0 = arg_5_0:getUserDataTb_()
		var_5_0.go = gohelper.cloneInPlace(arg_5_0.goPointItem)
		var_5_0.rect = var_5_0.go:GetComponent(gohelper.Type_RectTransform)
		var_5_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(var_5_0.go)
		var_5_0.goRed = gohelper.findChild(var_5_0.go, "red")
		var_5_0.goBlue = gohelper.findChild(var_5_0.go, "blue")
	end

	gohelper.setActive(var_5_0.goRed, false)
	gohelper.setActive(var_5_0.goBlue, false)

	var_5_0.initAngle = arg_5_0:getAngle(arg_5_1)
	var_5_0.targetAngle = var_5_0.initAngle
	var_5_0.curAngle = var_5_0.initAngle
	var_5_0.buffUid = arg_5_2

	return var_5_0
end

function var_0_0.recyclePowerItem(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_1.go, false)
	table.insert(arg_6_0.powerItemPool, arg_6_1)
end

function var_0_0.getAngle(arg_7_0, arg_7_1)
	return var_0_0.InitAngle + (arg_7_1 - 1) * var_0_0.AngleInterval
end

function var_0_0.getAnchorPos(arg_8_0, arg_8_1)
	local var_8_0 = var_0_0.Radius * math.cos(arg_8_1 * var_0_0.Radian)
	local var_8_1 = var_0_0.Radius * math.sin(arg_8_1 * var_0_0.Radian)

	return var_8_0, var_8_1
end

function var_0_0.addEvents(arg_9_0)
	arg_9_0:addEventCb(FightController.instance, FightEvent.OnAssistBossPowerChange, arg_9_0.onAssistBossPowerChange, arg_9_0)
	arg_9_0:addEventCb(FightController.instance, FightEvent.OnAssistBossCDChange, arg_9_0.onAssistBossCDChange, arg_9_0)
	arg_9_0:addEventCb(FightController.instance, FightEvent.OnResetCard, arg_9_0.onResetCard, arg_9_0)
	arg_9_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_9_0.onBuffUpdate, arg_9_0)
	arg_9_0:addEventCb(FightController.instance, FightEvent.OnPushBuffDeleteReason, arg_9_0.onPushBuffDeleteReason, arg_9_0)
	arg_9_0:addEventCb(FightController.instance, FightEvent.StageChanged, arg_9_0._onStageChange, arg_9_0)
	arg_9_0:addEventCb(FightController.instance, FightEvent.OnStartSwitchAssistBoss, arg_9_0.onStartSwitchAssistBoss, arg_9_0)
end

function var_0_0.onStartSwitchAssistBoss(arg_10_0, arg_10_1)
	if arg_10_1 ~= arg_10_0.assistBossUid then
		return
	end

	if arg_10_0.tweenAnimIng then
		arg_10_0:clearAddPowerTween()

		arg_10_0.tweenAnimIng = false
	end

	arg_10_0.assistBoss = FightDataHelper.entityMgr:getAssistBoss()

	arg_10_0:refreshEmptyPower()
	arg_10_0:refreshPowerCount()
end

function var_0_0._onStageChange(arg_11_0)
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		tabletool.clear(arg_11_0.overFlowBuffDict)
		arg_11_0:refreshPower()
	end
end

function var_0_0.onPushBuffDeleteReason(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3 ~= FightEnum.BuffDeleteReason.Overflow then
		return
	end

	if arg_12_0.assistBossUid ~= arg_12_1 then
		return
	end

	if not arg_12_0:getPowerTypeByBuffUid(arg_12_2) then
		return
	end

	arg_12_0.overFlowBuffDict[arg_12_2] = true
end

function var_0_0.onResetCard(arg_13_0)
	if arg_13_0.tweenAnimIng then
		return
	end

	arg_13_0:refreshPower()
end

function var_0_0.onBuffUpdate(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6)
	if arg_14_0.assistBossUid ~= arg_14_1 then
		return
	end

	if arg_14_2 == FightEnum.EffectType.BUFFADD then
		arg_14_0:doAddPower(arg_14_3, arg_14_4)

		return
	elseif arg_14_2 == FightEnum.EffectType.BUFFDEL or arg_14_2 == FightEnum.EffectType.BUFFDELNOEFFECT then
		arg_14_0:doRemovePower(arg_14_3, arg_14_4)

		return
	end
end

function var_0_0.doRemovePower(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_0:getPowerType(arg_15_1) then
		return
	end

	local var_15_0 = arg_15_0.overFlowBuffDict[arg_15_2]

	arg_15_0.overFlowBuffDict[arg_15_2] = nil

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.powerItemList) do
		if iter_15_1.buffUid == arg_15_2 then
			table.remove(arg_15_0.powerItemList, iter_15_0)
			table.insert(arg_15_0.playRecycleAnimItemList, iter_15_1)

			local var_15_1
			local var_15_2 = var_15_0 and "boom" or "close"

			iter_15_1.animatorPlayer:Play(var_15_2, arg_15_0.onRecycleAnimComplete, arg_15_0)
		end
	end
end

function var_0_0.onRecycleAnimComplete(arg_16_0)
	local var_16_0 = table.remove(arg_16_0.playRecycleAnimItemList, 1)

	if var_16_0 then
		arg_16_0:recyclePowerItem(var_16_0)
	end
end

function var_0_0.doAddPower(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0:getPowerType(arg_17_1)

	if not var_17_0 then
		return
	end

	local var_17_1 = arg_17_0:createPowerItem(1, arg_17_2)

	gohelper.setActive(var_17_1.go, true)
	gohelper.setActive(var_17_1.goRed, var_17_0 == var_0_0.PowerType.Red)
	gohelper.setActive(var_17_1.goBlue, var_17_0 == var_0_0.PowerType.Blue)

	local var_17_2, var_17_3 = arg_17_0:getAnchorPos(var_17_1.initAngle)

	recthelper.setAnchor(var_17_1.rect, var_17_2, var_17_3)
	var_17_1.animatorPlayer:Play(var_0_0.Anim.Open)

	if #arg_17_0.powerItemList < 1 then
		table.insert(arg_17_0.powerItemList, 1, var_17_1)

		return
	end

	if arg_17_0.tweenAnimIng then
		ZProj.TweenHelper.KillById(arg_17_0.addPowerTweenId)

		arg_17_0.addPowerTweenId = nil
	end

	local var_17_4, var_17_5 = FightDataHelper.paTaMgr:getAssistBossPower()

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.powerItemList) do
		iter_17_1.targetAngle = arg_17_0:getAngle(math.min(var_17_5, iter_17_0 + 1))
		iter_17_1.initAngle = iter_17_1.curAngle
	end

	table.insert(arg_17_0.powerItemList, 1, var_17_1)

	arg_17_0.tweenAnimIng = true
	arg_17_0.addPowerTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, var_0_0.TweenAnimDuration, arg_17_0.onAddPowerTweenFrameCallback, arg_17_0.onAddPowerTweenDone, arg_17_0)
end

function var_0_0.onAddPowerTweenFrameCallback(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.powerItemList) do
		local var_18_0 = iter_18_1.targetAngle - iter_18_1.initAngle
		local var_18_1 = iter_18_1.initAngle + var_18_0 * arg_18_1
		local var_18_2, var_18_3 = arg_18_0:getAnchorPos(var_18_1)

		recthelper.setAnchor(iter_18_1.rect, var_18_2, var_18_3)

		iter_18_1.curAngle = var_18_1
	end
end

function var_0_0.onAddPowerTweenDone(arg_19_0)
	arg_19_0.tweenAnimIng = false

	arg_19_0:refreshPower()
end

function var_0_0.refreshHeadImage(arg_20_0)
	local var_20_0 = arg_20_0.assistBoss.originSkin
	local var_20_1 = FightConfig.instance:getSkinCO(var_20_0)
	local var_20_2 = ResUrl.monsterHeadIcon(var_20_1.headIcon)

	arg_20_0.unLightHeadSImage:LoadImage(var_20_2)
	arg_20_0.lightHeadSImage:LoadImage(var_20_2)
end

function var_0_0.refreshCD(arg_21_0)
	gohelper.setActive(arg_21_0.goCD, false)
end

function var_0_0.refreshPower(arg_22_0, arg_22_1)
	if arg_22_0.tweenAnimIng then
		return
	end

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.powerItemList) do
		local var_22_0 = arg_22_0:getPowerTypeByBuffUid(iter_22_1.buffUid)

		gohelper.setActive(iter_22_1.go, true)
		gohelper.setActive(iter_22_1.goRed, var_22_0 == var_0_0.PowerType.Red)
		gohelper.setActive(iter_22_1.goBlue, var_22_0 == var_0_0.PowerType.Blue)

		local var_22_1 = arg_22_0:getAngle(iter_22_0)

		iter_22_1.initAngle = var_22_1
		iter_22_1.curAngle = var_22_1
		iter_22_1.targetAngle = var_22_1

		local var_22_2, var_22_3 = arg_22_0:getAnchorPos(var_22_1)

		recthelper.setAnchor(iter_22_1.rect, var_22_2, var_22_3)

		if arg_22_1 == var_0_0.Anim.Loop then
			iter_22_1.animatorPlayer:Play(var_22_0 == var_0_0.PowerType.Red and "redloop" or "blueloop")
		else
			iter_22_1.animatorPlayer:Play(arg_22_1 or var_0_0.Anim.Idle)
		end
	end

	arg_22_0:refreshHeadImageColor()
end

function var_0_0.getNextPowerType(arg_23_0, arg_23_1, arg_23_2)
	arg_23_2 = arg_23_2 or #arg_23_1

	for iter_23_0 = arg_23_2, 1, -1 do
		local var_23_0 = arg_23_1[iter_23_0]
		local var_23_1 = var_23_0 and var_23_0:getCO()
		local var_23_2 = var_23_1 and var_0_0.BuffTypeId2PowerType[var_23_1.typeId]

		if var_23_2 then
			return var_23_2, iter_23_0 - 1, var_23_0.uid
		end
	end
end

function var_0_0.refreshHeadImageColor(arg_24_0)
	if not FightDataHelper.paTaMgr:getCurUseSkillInfo() then
		return arg_24_0:refreshCanUse(false)
	end

	if arg_24_0.assistBoss:hasBuffFeature(FightEnum.BuffType_Seal) then
		return arg_24_0:refreshCanUse(false)
	end

	if arg_24_0:checkInCd() then
		return arg_24_0:refreshCanUse(false)
	end

	arg_24_0:refreshCanUse(true)
end

function var_0_0.refreshCanUse(arg_25_0, arg_25_1)
	gohelper.setActive(arg_25_0.goUnLight, not arg_25_1)
	gohelper.setActive(arg_25_0.goLight, arg_25_1)

	if arg_25_1 then
		local var_25_0, var_25_1 = arg_25_0:getPowerCount()

		gohelper.setActive(arg_25_0.goRedLightVx, var_25_1 < var_25_0)
		gohelper.setActive(arg_25_0.goBlueLightVx, var_25_0 <= var_25_1)
	end
end

function var_0_0.getPowerCount(arg_26_0)
	if not arg_26_0.assistBoss then
		return 0, 0
	end

	local var_26_0 = 0
	local var_26_1 = 0

	tabletool.clear(arg_26_0.tempBuffList)

	local var_26_2 = arg_26_0.assistBoss:getOrderedBuffList_ByTime(arg_26_0.tempBuffList)

	for iter_26_0 = #var_26_2, 1, -1 do
		local var_26_3 = var_26_2[iter_26_0]
		local var_26_4 = var_26_3 and var_26_3:getCO()
		local var_26_5 = var_26_4 and var_0_0.BuffTypeId2PowerType[var_26_4.typeId]

		if var_26_5 == var_0_0.PowerType.Red then
			var_26_0 = var_26_0 + 1
		elseif var_26_5 == var_0_0.PowerType.Blue then
			var_26_1 = var_26_1 + 1
		end
	end

	return var_26_0, var_26_1
end

function var_0_0.playAssistBossCard(arg_27_0)
	if arg_27_0.tweenAnimIng then
		return
	end

	if var_0_0.super.playAssistBossCard(arg_27_0) then
		arg_27_0:refreshPower(var_0_0.Anim.Loop)
	end
end

function var_0_0.onLongPress(arg_28_0)
	if arg_28_0.tweenAnimIng then
		return
	end

	var_0_0.super.onLongPress(arg_28_0)
end

function var_0_0.clearAddPowerTween(arg_29_0)
	if arg_29_0.addPowerTweenId then
		ZProj.TweenHelper.KillById(arg_29_0.addPowerTweenId)

		arg_29_0.addPowerTweenId = nil
	end
end

function var_0_0.destroy(arg_30_0)
	arg_30_0:clearAddPowerTween()

	arg_30_0.tweenAnimIng = false

	var_0_0.super.destroy(arg_30_0)
end

function var_0_0.getPowerType(arg_31_0, arg_31_1)
	local var_31_0 = lua_skill_buff.configDict[arg_31_1]

	if not var_31_0 then
		return false
	end

	return var_0_0.BuffTypeId2PowerType[var_31_0.typeId]
end

function var_0_0.getPowerTypeByBuffUid(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.assistBoss:getBuffMO(arg_32_1)

	if not var_32_0 then
		return false
	end

	return arg_32_0:getPowerType(var_32_0.buffId)
end

return var_0_0
