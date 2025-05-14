module("modules.logic.turnback.view.TurnbackSignInItem", package.seeall)

local var_0_0 = class("TurnbackSignInItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._gonormalBG = gohelper.findChild(arg_1_0.go, "Root/#go_normalBG")
	arg_1_0._gocangetBG = gohelper.findChild(arg_1_0.go, "Root/#go_cangetBG")
	arg_1_0._btncanget = gohelper.findChildButtonWithAudio(arg_1_0.go, "Root/#go_getclick")
	arg_1_0._txtday = gohelper.findChildText(arg_1_0.go, "Root/#txt_day")
	arg_1_0._txtdayEn = gohelper.findChildText(arg_1_0.go, "Root/#txt_dayEn")
	arg_1_0._gotomorrowTag = gohelper.findChild(arg_1_0.go, "Root/#go_tomorrowTag")
	arg_1_0._goitemContent = gohelper.findChild(arg_1_0.go, "Root/#go_itemContent")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.go, "Root/#go_hasget")
	arg_1_0._gogetIconContent = gohelper.findChild(arg_1_0.go, "Root/#go_hasget/#go_getIconContent")
	arg_1_0._gogeticon = gohelper.findChild(arg_1_0.go, "Root/#go_hasget/#go_getIconContent/#go_geticon")
	arg_1_0._animator = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goEffectCube = gohelper.findChild(arg_1_0.go, "Root/#go_cangetBG/kelinqu")

	gohelper.setActive(arg_1_0.go, false)
	gohelper.setActive(arg_1_0._gogeticon, false)

	arg_1_0._itemsTab = {}
	arg_1_0._firstEnter = true
	arg_1_0._openAnimTime = 0.97
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btncanget:AddClickListener(arg_2_0._btncangetOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btncanget:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	if arg_4_1 == nil then
		return
	end

	arg_4_0.mo = arg_4_1

	arg_4_0:_refreshUI()

	arg_4_0._delayTime = arg_4_0._index * 0.03

	if arg_4_0._firstEnter then
		TaskDispatcher.runDelay(arg_4_0._playOpenAnim, arg_4_0, arg_4_0._delayTime)
	end
end

function var_0_0._refreshUI(arg_5_0)
	arg_5_0:_refreshBonus()

	arg_5_0._txtday.text = string.format("%02d", arg_5_0.mo.id)
	arg_5_0._txtdayEn.text = string.format("DAY\n%s", GameUtil.getEnglishNumber(arg_5_0.mo.id))

	gohelper.setActive(arg_5_0._gocangetBG, arg_5_0.mo.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(arg_5_0._btncanget.gameObject, arg_5_0.mo.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(arg_5_0._gohasget, arg_5_0.mo.state == TurnbackEnum.SignInState.HasGet)

	local var_5_0 = GameUtil.getTabLen(TurnbackSignInModel.instance:getSignInInfoMoList())
	local var_5_1 = TurnbackModel.instance:getCurSignInDay()

	gohelper.setActive(arg_5_0._gotomorrowTag, var_5_1 + 1 == arg_5_0.mo.id and var_5_1 ~= var_5_0)
end

function var_0_0._refreshBonus(arg_6_0)
	arg_6_0.config = arg_6_0.mo.config

	local var_6_0 = string.split(arg_6_0.config.bonus, "|")

	gohelper.setActive(arg_6_0._goEffectCube, #var_6_0 < 2)

	for iter_6_0 = 1, #var_6_0 do
		local var_6_1 = arg_6_0._itemsTab[iter_6_0]

		if not var_6_1 then
			var_6_1 = {
				item = IconMgr.instance:getCommonPropItemIcon(arg_6_0._goitemContent),
				getIcon = gohelper.clone(arg_6_0._gogeticon, arg_6_0._gogetIconContent)
			}

			table.insert(arg_6_0._itemsTab, var_6_1)
		end

		local var_6_2 = string.split(var_6_0[iter_6_0], "#")

		var_6_1.item:setMOValue(var_6_2[1], var_6_2[2], var_6_2[3])
		var_6_1.item:setHideLvAndBreakFlag(true)
		var_6_1.item:hideEquipLvAndBreak(true)
		var_6_1.item:setCountFontSize(40)
		var_6_1.item:setPropItemScale(0.76)
		gohelper.setActive(arg_6_0._itemsTab[iter_6_0].item.go, true)
		gohelper.setActive(var_6_1.getIcon, true)
	end

	for iter_6_1 = #var_6_0 + 1, #arg_6_0._itemsTab do
		gohelper.setActive(arg_6_0._itemsTab[iter_6_1].item.go, false)
		gohelper.setActive(arg_6_0._itemsTab[iter_6_1].getIcon, false)
	end
end

function var_0_0._btncangetOnClick(arg_7_0)
	if arg_7_0.mo.state == TurnbackEnum.SignInState.CanGet then
		local var_7_0 = arg_7_0.mo.turnbackId

		TurnbackRpc.instance:sendTurnbackSignInRequest(var_7_0, arg_7_0.mo.id)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_OK)
	end
end

function var_0_0._playOpenAnim(arg_8_0)
	gohelper.setActive(arg_8_0.go, true)
	arg_8_0._animator:Play(UIAnimationName.Open, 0, arg_8_0:_getOpenAnimPlayProgress())

	arg_8_0._firstEnter = false
end

function var_0_0._getOpenAnimPlayProgress(arg_9_0)
	local var_9_0 = UnityEngine.Time.realtimeSinceStartup
	local var_9_1 = TurnbackSignInModel.instance:getOpenTimeStamp()

	return (Mathf.Clamp01((var_9_0 - var_9_1 - arg_9_0._delayTime) / arg_9_0._openAnimTime))
end

function var_0_0.onDestroy(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._playOpenAnim, arg_10_0)
end

return var_0_0
