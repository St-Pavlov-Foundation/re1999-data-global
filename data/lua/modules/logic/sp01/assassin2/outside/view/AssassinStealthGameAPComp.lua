module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameAPComp", package.seeall)

local var_0_0 = class("AssassinStealthGameAPComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goapItem = gohelper.findChild(arg_1_0.go, "#go_apItem")

	gohelper.setActive(arg_1_0._goapItem, false)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.OnHeroMove, arg_2_0._onHeroMove, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.OnHeroUpdate, arg_2_0._onHeroUpdate, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.OnBeginNewRound, arg_2_0._onBeginNewRound, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.OnHeroMove, arg_3_0._onHeroMove, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.OnHeroUpdate, arg_3_0._onHeroUpdate, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.OnBeginNewRound, arg_3_0._onBeginNewRound, arg_3_0)
end

function var_0_0._onHeroMove(arg_4_0)
	arg_4_0:refreshHeroApUsed(true)
end

function var_0_0._onHeroUpdate(arg_5_0, arg_5_1)
	if not arg_5_0._heroUid then
		return
	end

	if not arg_5_1 or arg_5_1 and arg_5_1[arg_5_0._heroUid] then
		arg_5_0:refreshHeroApUsed(true)
	end
end

function var_0_0._onBeginNewRound(arg_6_0)
	if not arg_6_0._heroUid then
		return
	end

	arg_6_0:setHeroAp()
end

function var_0_0.setHeroUid(arg_7_0, arg_7_1)
	arg_7_0._heroUid = arg_7_1

	arg_7_0:setHeroAp(true)
end

function var_0_0.setHeroAp(arg_8_0, arg_8_1)
	if not arg_8_0._heroUid then
		return
	end

	local var_8_0 = AssassinStealthGameModel.instance:getHeroMo(arg_8_0._heroUid, true):getMaxActionPoint()

	if arg_8_1 or not arg_8_0._apItemList or #arg_8_0._apItemList ~= var_8_0 then
		arg_8_0:setAPCount(var_8_0)
		arg_8_0:refreshHeroApUsed()
	else
		arg_8_0:refreshHeroApUsed(true)
	end
end

function var_0_0.setAPCount(arg_9_0, arg_9_1)
	if not arg_9_1 or arg_9_1 <= 0 then
		gohelper.setActive(arg_9_0.go, false)

		return
	end

	arg_9_0._apItemList = {}

	local var_9_0 = {}

	for iter_9_0 = 1, arg_9_1 do
		var_9_0[#var_9_0 + 1] = iter_9_0
	end

	gohelper.CreateObjList(arg_9_0, arg_9_0._onCreateApItem, var_9_0, arg_9_0._go, arg_9_0._goapItem)
	gohelper.setActive(arg_9_0.go, true)
end

function var_0_0._onCreateApItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0:getUserDataTb_()

	var_10_0.go = arg_10_1
	var_10_0.goempty = gohelper.findChild(var_10_0.go, "#go_normal")
	var_10_0.gocanuse = gohelper.findChild(var_10_0.go, "#go_used")
	var_10_0.animator = var_10_0.gocanuse:GetComponent(typeof(UnityEngine.Animator))
	var_10_0.canUse = true

	gohelper.setActive(var_10_0.goempty, true)
	gohelper.setActive(var_10_0.gocanuse, true)

	if var_10_0.animator then
		var_10_0.animator:Play("open", 0, 1)
	end

	arg_10_0._apItemList[arg_10_3] = var_10_0
end

function var_0_0.refreshHeroApUsed(arg_11_0, arg_11_1)
	if not arg_11_0._heroUid then
		return
	end

	local var_11_0 = AssassinStealthGameModel.instance:getHeroMo(arg_11_0._heroUid, true):getActionPoint()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._apItemList) do
		local var_11_1 = iter_11_0 <= var_11_0

		if var_11_1 ~= iter_11_1.canUse then
			local var_11_2 = var_11_1 and "open" or "close"

			if arg_11_1 then
				iter_11_1.animator:Play(var_11_2)
			else
				iter_11_1.animator:Play(var_11_2, 0, 1)
			end

			iter_11_1.canUse = var_11_1
		end
	end
end

function var_0_0.onDestroy(arg_12_0)
	arg_12_0._heroUid = nil
end

return var_0_0
