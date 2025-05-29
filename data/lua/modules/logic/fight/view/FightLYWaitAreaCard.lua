module("modules.logic.fight.view.FightLYWaitAreaCard", package.seeall)

local var_0_0 = class("FightLYWaitAreaCard", UserDataDispose)

var_0_0.LY_CardPath = "ui/viewres/fight/fight_liangyuecardview.prefab"
var_0_0.LY_MAXPoint = 6

function var_0_0.Create(arg_1_0)
	local var_1_0 = var_0_0.New()

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0:__onInit()

	arg_2_0.loaded = false
	arg_2_0.goContainer = arg_2_1
	arg_2_0.LYLoader = PrefabInstantiate.Create(arg_2_0.goContainer)

	arg_2_0.LYLoader:startLoad(var_0_0.LY_CardPath, arg_2_0.onLoadLYCardDone, arg_2_0)
end

function var_0_0.onLoadLYCardDone(arg_3_0, arg_3_1)
	arg_3_0.loaded = true
	arg_3_0.LY_instanceGo = arg_3_0.LYLoader:getInstGO()
	arg_3_0.rectTr = arg_3_0.LY_instanceGo:GetComponent(gohelper.Type_RectTransform)
	arg_3_0.animator = gohelper.findChildComponent(arg_3_0.LY_instanceGo, "current", gohelper.Type_Animator)
	arg_3_0.LY_goCardBack = gohelper.findChild(arg_3_0.LY_instanceGo, "current/back")

	gohelper.setActive(arg_3_0.LY_goCardBack, true)

	arg_3_0.goSkillList = arg_3_0:getUserDataTb_()

	for iter_3_0 = 1, 3 do
		table.insert(arg_3_0.goSkillList, gohelper.findChild(arg_3_0.LY_goCardBack, tostring(iter_3_0)))
	end

	arg_3_0.LY_pointItemList = {}

	for iter_3_1 = 1, var_0_0.LY_MAXPoint do
		local var_3_0 = arg_3_0:getUserDataTb_()

		var_3_0.go = gohelper.findChild(arg_3_0.LY_instanceGo, "current/font/energy/" .. iter_3_1)
		var_3_0.goRed = gohelper.findChild(var_3_0.go, "red")
		var_3_0.goBlue = gohelper.findChild(var_3_0.go, "green")
		var_3_0.goBoth = gohelper.findChild(var_3_0.go, "both")
		var_3_0.animator = var_3_0.go:GetComponent(gohelper.Type_Animator)

		table.insert(arg_3_0.LY_pointItemList, var_3_0)
	end

	arg_3_0:refreshLYCard()
	arg_3_0:setAnchorX(arg_3_0.recordAnchorX)
	arg_3_0:setScale(arg_3_0.scale)
	arg_3_0:addEventCb(FightController.instance, FightEvent.LY_HadRedAndBluePointChange, arg_3_0.onPointChange, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.LY_PointAreaSizeChange, arg_3_0.refreshLYCard, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.LY_TriggerCountSkill, arg_3_0.onTriggerSkill, arg_3_0)
end

function var_0_0.onPointChange(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0.loaded then
		return
	end

	local var_4_0 = FightDataHelper.LYDataMgr:getPointList()

	if not var_4_0 then
		gohelper.setActive(arg_4_0.goContainer, false)

		return
	end

	gohelper.setActive(arg_4_0.goContainer, true)

	local var_4_1 = FightDataHelper.LYDataMgr.LYPointAreaSize

	arg_4_0:resetAllPoint()

	local var_4_2 = math.min(math.max(0, var_4_1), var_0_0.LY_MAXPoint)
	local var_4_3 = FightViewRedAndBlueArea.PointIndexList[var_4_2 + 1] or {}

	for iter_4_0 = 1, var_4_2 do
		local var_4_4 = var_4_3[iter_4_0]
		local var_4_5 = var_4_4 and arg_4_0.LY_pointItemList[var_4_4]

		gohelper.setActive(var_4_5.go, true)

		local var_4_6 = var_4_0[iter_4_0]

		gohelper.setActive(var_4_5.goRed, var_4_6 == FightEnum.CardColor.Red)
		gohelper.setActive(var_4_5.goBlue, var_4_6 == FightEnum.CardColor.Blue)
		gohelper.setActive(var_4_5.goBoth, var_4_6 == FightEnum.CardColor.Both)

		if arg_4_2 < iter_4_0 and var_4_6 and var_4_6 ~= FightEnum.CardColor.None then
			var_4_5.animator:Play("active", 0, 0)
		else
			var_4_5.animator:Play("empty", 0, 0)
		end
	end

	arg_4_0.animator:Play("rotate_02", 0, 1)
end

function var_0_0.resetAllPoint(arg_5_0)
	for iter_5_0 = 1, var_0_0.LY_MAXPoint do
		local var_5_0 = arg_5_0.LY_pointItemList[iter_5_0]

		gohelper.setActive(var_5_0.go, false)
	end
end

function var_0_0.onSkillPlayFinish(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.waitSkillId == arg_6_2 then
		FightDataHelper.LYDataMgr:refreshPointList(true)
		arg_6_0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_6_0.onSkillPlayFinish, arg_6_0)

		arg_6_0.waitSkillId = nil

		if arg_6_0.loaded then
			arg_6_0:refreshLYCard()
			AudioMgr.instance:trigger(20250501)
			arg_6_0.animator:Play("rotate_02", 0, 0)
		end
	end
end

function var_0_0.onTriggerSkill(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.waitSkillId = arg_7_3

	arg_7_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_7_0.onSkillPlayFinish, arg_7_0)

	if not arg_7_0.loaded then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.goSkillList) do
		gohelper.setActive(iter_7_1, false)
	end

	if arg_7_1 == arg_7_2 then
		gohelper.setActive(arg_7_0.goSkillList[1], true)
	elseif arg_7_1 < arg_7_2 then
		gohelper.setActive(arg_7_0.goSkillList[2], true)
	else
		gohelper.setActive(arg_7_0.goSkillList[3], true)
	end

	arg_7_0.animator:Play("rotate_01", 0, 0)
	AudioMgr.instance:trigger(20250500)
end

function var_0_0.refreshLYCard(arg_8_0)
	if not arg_8_0.loaded then
		return
	end

	local var_8_0 = FightDataHelper.LYDataMgr:getPointList()

	if not var_8_0 then
		gohelper.setActive(arg_8_0.goContainer, false)

		return
	end

	gohelper.setActive(arg_8_0.goContainer, true)

	local var_8_1 = FightDataHelper.LYDataMgr.LYPointAreaSize

	for iter_8_0 = 1, var_0_0.LY_MAXPoint do
		local var_8_2 = arg_8_0.LY_pointItemList[iter_8_0]

		if var_8_1 < iter_8_0 then
			gohelper.setActive(var_8_2.go, false)

			break
		end

		local var_8_3 = var_8_0[iter_8_0]

		gohelper.setActive(var_8_2.go, true)
		gohelper.setActive(var_8_2.goRed, var_8_3 == FightEnum.CardColor.Red)
		gohelper.setActive(var_8_2.goBlue, var_8_3 == FightEnum.CardColor.Blue)
		gohelper.setActive(var_8_2.goBoth, var_8_3 == FightEnum.CardColor.Both)
	end
end

function var_0_0.resetState(arg_9_0)
	arg_9_0.animator:Play("rotate_02", 0, 1)
end

function var_0_0.playAnim(arg_10_0, arg_10_1)
	arg_10_0.animator:Play(arg_10_1, 0, 0)
end

function var_0_0.setAnchorX(arg_11_0, arg_11_1)
	arg_11_0.recordAnchorX = arg_11_1 or 0

	if not arg_11_0.loaded then
		return
	end

	recthelper.setAnchorX(arg_11_0.rectTr, arg_11_0.recordAnchorX)
end

function var_0_0.setScale(arg_12_0, arg_12_1)
	arg_12_0.scale = arg_12_1 or 1

	if not arg_12_0.loaded then
		return
	end

	transformhelper.setLocalScale(arg_12_0.rectTr, arg_12_0.scale, arg_12_0.scale, arg_12_0.scale)
end

function var_0_0.dispose(arg_13_0)
	if arg_13_0.LYLoader then
		arg_13_0.LYLoader:dispose()

		arg_13_0.LYLoader = nil
	end

	arg_13_0:__onDispose()
end

return var_0_0
