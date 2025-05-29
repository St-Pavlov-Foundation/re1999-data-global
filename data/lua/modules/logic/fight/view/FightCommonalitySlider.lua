module("modules.logic.fight.view.FightCommonalitySlider", package.seeall)

local var_0_0 = class("FightCommonalitySlider", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._slider = gohelper.findChildImage(arg_1_0.viewGO, "slider/sliderbg/sliderfg")
	arg_1_0._skillName = gohelper.findChildText(arg_1_0.viewGO, "slider/txt_commonality")
	arg_1_0._sliderText = gohelper.findChildText(arg_1_0.viewGO, "slider/sliderbg/#txt_slidernum")
	arg_1_0._tips = gohelper.findChild(arg_1_0.viewGO, "tips")
	arg_1_0._tipsTitle = gohelper.findChildText(arg_1_0.viewGO, "tips/#txt_title")
	arg_1_0._desText = gohelper.findChildText(arg_1_0.viewGO, "tips/desccont/#txt_descitem")
	arg_1_0._max = gohelper.findChild(arg_1_0.viewGO, "slider/max")
	arg_1_0._click = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "btn")
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0:_refreshData()
	arg_2_0:com_registMsg(FightMsgId.FightProgressValueChange, arg_2_0._refreshData)
	arg_2_0:com_registMsg(FightMsgId.FightMaxProgressValueChange, arg_2_0._refreshData)
	arg_2_0:com_registClick(arg_2_0._click, arg_2_0._onBtnClick)
	arg_2_0:com_registFightEvent(FightEvent.TouchFightViewScreen, arg_2_0._onTouchFightViewScreen)
end

function var_0_0._onTouchFightViewScreen(arg_3_0)
	gohelper.setActive(arg_3_0._tips, false)
end

function var_0_0._onBtnClick(arg_4_0)
	gohelper.setActive(arg_4_0._tips, true)
end

function var_0_0._refreshData(arg_5_0)
	local var_5_0 = FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ProgressSkill]
	local var_5_1 = lua_skill.configDict[var_5_0]

	if var_5_1 then
		arg_5_0._skillName.text = var_5_1.name
		arg_5_0._tipsTitle.text = var_5_1.name
		arg_5_0._desText.text = FightConfig.instance:getSkillEffectDesc(nil, var_5_1)
	end

	local var_5_2 = FightDataHelper.fieldMgr.progress
	local var_5_3 = FightDataHelper.fieldMgr.progressMax
	local var_5_4 = var_5_3 <= var_5_2

	if arg_5_0._lastMax ~= var_5_4 then
		gohelper.setActive(arg_5_0._max, var_5_4)
	end

	local var_5_5 = var_5_2 / var_5_3

	arg_5_0._sliderText.text = Mathf.Clamp(var_5_5 * 100, 0, 100) .. "%"

	ZProj.TweenHelper.KillByObj(arg_5_0._slider)
	ZProj.TweenHelper.DOFillAmount(arg_5_0._slider, var_5_5, 0.2 / FightModel.instance:getUISpeed())

	arg_5_0._lastMax = var_5_4

	if FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ProgressId] == 2 then
		local var_5_6 = FightDataHelper.entityMgr:getEnemyVertin()

		if var_5_6 then
			local var_5_7 = var_5_6.buffDic

			for iter_5_0, iter_5_1 in pairs(var_5_7) do
				if iter_5_1.buffId == 9260101 then
					arg_5_0._sliderText.text = iter_5_1.duration

					break
				end
			end
		end
	end
end

function var_0_0.onClose(arg_6_0)
	ZProj.TweenHelper.KillByObj(arg_6_0._slider)
end

return var_0_0
