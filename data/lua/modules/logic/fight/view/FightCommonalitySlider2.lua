module("modules.logic.fight.view.FightCommonalitySlider2", package.seeall)

local var_0_0 = class("FightCommonalitySlider2", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.sliderBg = gohelper.findChild(arg_1_0.viewGO, "slider/sliderbg")
	arg_1_0._slider = gohelper.findChildImage(arg_1_0.viewGO, "slider/sliderbg/sliderfg")
	arg_1_0._sliderText = gohelper.findChildText(arg_1_0.viewGO, "slider/sliderbg/#txt_slidernum")
	arg_1_0.effective = gohelper.findChild(arg_1_0.viewGO, "slider/#max")
	arg_1_0.durationText = gohelper.findChildText(arg_1_0.viewGO, "slider/#max/#txt_round")
end

function var_0_0.onConstructor(arg_2_0, arg_2_1)
	arg_2_0.fightRoot = arg_2_1
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0:_refreshData(true)
	arg_3_0:com_registMsg(FightMsgId.FightProgressValueChange, arg_3_0._refreshData)
	arg_3_0:com_registMsg(FightMsgId.FightMaxProgressValueChange, arg_3_0._refreshData)
	arg_3_0:com_registFightEvent(FightEvent.OnBuffUpdate, arg_3_0._onBuffUpdate)
	arg_3_0:com_registFightEvent(FightEvent.OnRoundSequenceFinish, arg_3_0._refreshData)
end

function var_0_0._refreshData(arg_4_0, arg_4_1)
	local var_4_0 = FightDataHelper.fieldMgr.progress
	local var_4_1 = FightDataHelper.fieldMgr.progressMax
	local var_4_2 = var_4_1 <= var_4_0

	if arg_4_0._lastMax ~= var_4_2 then
		gohelper.setActive(arg_4_0._max, var_4_2)
	end

	local var_4_3 = var_4_0 / var_4_1

	arg_4_0._sliderText.text = Mathf.Clamp(var_4_3 * 100, 0, 100) .. "%"

	ZProj.TweenHelper.KillByObj(arg_4_0._slider)

	if arg_4_1 then
		arg_4_0._slider.fillAmount = var_4_3
	else
		ZProj.TweenHelper.DOFillAmount(arg_4_0._slider, var_4_3, 0.2 / FightModel.instance:getUISpeed())
	end

	gohelper.setActive(arg_4_0.sliderBg, true)
	gohelper.setActive(arg_4_0.effective, false)

	arg_4_0._lastMax = var_4_2

	local var_4_4 = false

	if FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ProgressId] == 2 then
		local var_4_5 = FightDataHelper.entityMgr:getMyVertin()

		if var_4_5 then
			local var_4_6 = var_4_5.buffDic

			for iter_4_0, iter_4_1 in pairs(var_4_6) do
				if iter_4_1.buffId == 9260101 then
					gohelper.setActive(arg_4_0.sliderBg, false)
					gohelper.setActive(arg_4_0.effective, true)

					arg_4_0.durationText.text = iter_4_1.duration
					var_4_4 = true

					break
				end
			end
		end
	end

	arg_4_0:checkShowScreenEffect(var_4_4)
end

function var_0_0.checkShowScreenEffect(arg_5_0, arg_5_1)
	if not arg_5_0._effectRoot then
		arg_5_0._effectRoot = gohelper.create2d(arg_5_0.fightRoot, "FightCommonalitySlider2ScreenEffect")

		local var_5_0 = arg_5_0._effectRoot.transform

		var_5_0.anchorMin = Vector2.zero
		var_5_0.anchorMax = Vector2.one
		var_5_0.offsetMin = Vector2.zero
		var_5_0.offsetMax = Vector2.zero

		arg_5_0:com_loadAsset("ui/viewres/fight/fight_weekwalk_screeneff.prefab", arg_5_0.onScreenEffectLoaded)
	end

	gohelper.setActive(arg_5_0._effectRoot, arg_5_1)
end

function var_0_0.onScreenEffectLoaded(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1 then
		return
	end

	local var_6_0 = arg_6_2:GetResource()

	gohelper.clone(var_6_0, arg_6_0._effectRoot)
end

function var_0_0._onBuffUpdate(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_3 == 9260101 then
		arg_7_0:_refreshData()
	end
end

function var_0_0.onClose(arg_8_0)
	ZProj.TweenHelper.KillByObj(arg_8_0._slider)
end

return var_0_0
