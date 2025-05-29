module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroDiceItem", package.seeall)

local var_0_0 = class("DiceHeroDiceItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._index = arg_1_1.index
end

local var_0_1 = {
	Vector3(90, 0, 0),
	Vector3(90, 90, 0),
	Vector3(90, 180, 0),
	Vector3(90, -90, 0),
	Vector3(0, 0, 0),
	(Vector3(180, 0, 0))
}

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._anim = gohelper.findChildAnim(arg_2_1, "")
	arg_2_0._goselect = gohelper.findChild(arg_2_1, "#go_select")
	arg_2_0._imagenum = gohelper.findChildImage(arg_2_1, "#image_num")
	arg_2_0._imageicon = gohelper.findChildImage(arg_2_1, "#simage_dice")
	arg_2_0._golimitlock = gohelper.findChild(arg_2_1, "#go_lock")
	arg_2_0._golock = gohelper.findChild(arg_2_1, "#go_limitlock")
	arg_2_0._golight = gohelper.findChild(arg_2_1, "#go_light")
	arg_2_0._gogray = gohelper.findChild(arg_2_1, "#go_gray")
	arg_2_0._diceRoot = gohelper.findChild(arg_2_1, "touzi_ani/touzi").transform
	arg_2_0._uimeshes = arg_2_0:getUserDataTb_()

	for iter_2_0 = 0, arg_2_0._diceRoot.childCount - 1 do
		local var_2_0 = arg_2_0._diceRoot:GetChild(iter_2_0).gameObject
		local var_2_1 = tonumber(var_2_0.name) or 1

		arg_2_0._uimeshes[var_2_1] = var_2_0:GetComponent(typeof(UIMesh))
	end

	arg_2_0:_refresh(true)
end

function var_0_0.onStepEnd(arg_3_0, arg_3_1)
	arg_3_0:_refresh(arg_3_1)
end

function var_0_0._refresh(arg_4_0, arg_4_1)
	local var_4_0 = DiceHeroFightModel.instance:getGameData().diceBox.dices[arg_4_0._index]

	if var_4_0 and not var_4_0.deleted then
		arg_4_0:updateInfo(var_4_0, arg_4_1)
	elseif arg_4_0.diceMo then
		arg_4_0.diceMo = nil

		arg_4_0._anim:Play("out")
	else
		arg_4_0._anim:Play("out", 0, 1)
	end
end

function var_0_0.updateInfo(arg_5_0, arg_5_1, arg_5_2)
	if (not arg_5_0.diceMo or arg_5_0.diceMo.deleted or arg_5_0.diceMo.uid ~= arg_5_1.uid) and not DiceHeroFightModel.instance.tempRoundEnd and not arg_5_2 then
		arg_5_0._anim:Play("in", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_roll)
	end

	if arg_5_0.diceMo then
		DiceHeroHelper.instance:unregisterDice(arg_5_0.diceMo.uid)
	end

	DiceHeroHelper.instance:registerDice(arg_5_1.uid, arg_5_0)

	arg_5_0.diceMo = arg_5_1

	local var_5_0 = var_0_1[arg_5_1.num]

	if var_5_0 then
		transformhelper.setLocalRotation(arg_5_0._diceRoot, var_5_0.x, var_5_0.y, var_5_0.z)
	end

	local var_5_1 = lua_dice.configDict[arg_5_1.diceId]

	if var_5_1 then
		local var_5_2 = string.splitToNumber(var_5_1.suitList, "#")

		for iter_5_0, iter_5_1 in pairs(arg_5_0._uimeshes) do
			local var_5_3 = lua_dice_suit.configDict[var_5_2[iter_5_0]]

			if var_5_3 then
				local var_5_4 = DiceHeroHelper.instance:getDiceTexture(var_5_3.icon)

				if var_5_4 then
					iter_5_1.texture = var_5_4

					iter_5_1:SetMaterialDirty()
				end
			end
		end
	end

	arg_5_0:refreshLock()
	arg_5_0:setSelect(false)
end

function var_0_0.refreshLock(arg_6_0)
	gohelper.setActive(arg_6_0._golock, arg_6_0.diceMo.status == DiceHeroEnum.DiceStatu.SoftLock)
	gohelper.setActive(arg_6_0._golimitlock, arg_6_0.diceMo.status == DiceHeroEnum.DiceStatu.HardLock)
end

function var_0_0.setSelect(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.diceMo and arg_7_0.diceMo.status == DiceHeroEnum.DiceStatu.HardLock

	gohelper.setActive(arg_7_0._goselect, arg_7_1)

	if arg_7_2 == nil then
		gohelper.setActive(arg_7_0._golight, false)
		gohelper.setActive(arg_7_0._gogray, var_7_0)
	else
		gohelper.setActive(arg_7_0._golight, arg_7_2)
		gohelper.setActive(arg_7_0._gogray, not arg_7_2 or var_7_0)
	end
end

function var_0_0.markDeleted(arg_8_0)
	if not arg_8_0.diceMo then
		return
	end

	arg_8_0.diceMo.deleted = true

	arg_8_0._anim:Play("out", 0, 0)
	arg_8_0:setSelect(false)
end

function var_0_0.playRefresh(arg_9_0, arg_9_1)
	arg_9_0.diceMo = arg_9_1

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_roll)
	arg_9_0._anim:Play("refresh", 0, 0)

	local var_9_0, var_9_1, var_9_2 = transformhelper.getLocalRotation(arg_9_0._diceRoot)

	ZProj.TweenHelper.DOLocalRotate(arg_9_0._diceRoot, var_9_0 + math.random(100, 200), var_9_1 + math.random(100, 200), var_9_2 + math.random(100, 200), 0.2, arg_9_0._delayTweenRotate, arg_9_0, nil, EaseType.Linear)
	TaskDispatcher.runDelay(arg_9_0._refresh, arg_9_0, 0.6)
end

function var_0_0._delayTweenRotate(arg_10_0)
	local var_10_0, var_10_1, var_10_2 = transformhelper.getLocalRotation(arg_10_0._diceRoot)

	ZProj.TweenHelper.DOLocalRotate(arg_10_0._diceRoot, var_10_0 + math.random(100, 200), var_10_1 + math.random(100, 200), var_10_2 + math.random(100, 200), 0.2, arg_10_0._delayTweenRotate2, arg_10_0, nil, EaseType.Linear)
end

function var_0_0._delayTweenRotate2(arg_11_0)
	local var_11_0 = var_0_1[arg_11_0.diceMo.num]

	if var_11_0 then
		ZProj.TweenHelper.DOLocalRotate(arg_11_0._diceRoot, var_11_0.x, var_11_0.y, var_11_0.z, 0.2, nil, nil, nil, EaseType.Linear)
	end
end

function var_0_0.startRoll(arg_12_0)
	if not arg_12_0.diceMo or arg_12_0.diceMo.deleted then
		arg_12_0._anim:Play("out", 0, 1)

		return
	end

	arg_12_0._anim:Play("in", 0, 0)
	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_roll)
end

function var_0_0.onDestroy(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._refresh, arg_13_0)

	if arg_13_0.diceMo then
		DiceHeroHelper.instance:unregisterDice(arg_13_0.diceMo.uid)
	end
end

return var_0_0
