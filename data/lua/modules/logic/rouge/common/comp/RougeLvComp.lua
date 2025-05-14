module("modules.logic.rouge.common.comp.RougeLvComp", package.seeall)

local var_0_0 = class("RougeLvComp", UserDataDispose)
local var_0_1 = 3

function var_0_0.Get(arg_1_0)
	local var_1_0 = var_0_0.New()

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0:__onInit()

	arg_2_0.go = arg_2_1

	arg_2_0:_editableInitView()
end

function var_0_0._editableInitView(arg_3_0)
	arg_3_0._imageTypeIcon = gohelper.findChildImage(arg_3_0.go, "Root/#image_TypeIcon")
	arg_3_0._txttalent = gohelper.findChildText(arg_3_0.go, "Root/#txt_talent")
	arg_3_0._txttotal = gohelper.findChildText(arg_3_0.go, "Root/#txt_total")
	arg_3_0._txtLv = gohelper.findChildText(arg_3_0.go, "Root/#txt_Lv")
	arg_3_0._txtTypeName = gohelper.findChildText(arg_3_0.go, "Root/#txt_TypeName")
	arg_3_0._btnclick = gohelper.findChildButtonWithAudio(arg_3_0.go, "Root/#btn_click")
	arg_3_0._goeffect = gohelper.findChild(arg_3_0.go, "Root/effect")
	arg_3_0._gomagic = gohelper.findChild(arg_3_0.go, "Root/magic")
	arg_3_0._goeffectget = gohelper.findChild(arg_3_0.go, "Root/effect_get")

	local var_3_0 = RougeConfig1.instance:getConstValueByID(RougeEnum.Const.TalentCost)

	arg_3_0._costTalentPoint = tonumber(var_3_0)

	arg_3_0:addEvents()
end

function var_0_0.addEvents(arg_4_0)
	arg_4_0._btnclick:AddClickListener(arg_4_0._btnclickOnClick, arg_4_0)
	arg_4_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeInfoTeamValues, arg_4_0.refreshLV, arg_4_0)
	arg_4_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeInfo, arg_4_0.refreshLV, arg_4_0)
	arg_4_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeInfoPower, arg_4_0.refreshPower, arg_4_0)
	arg_4_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeInfoTalentPoint, arg_4_0.onUpdateTalentPoint, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_4_0.onCloseViewFinishCallBack, arg_4_0)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0.rougeInfo = RougeModel.instance:getRougeInfo()

	if not arg_5_0.rougeInfo or not arg_5_0.rougeInfo.season then
		return
	end

	arg_5_0:refreshUI()
end

function var_0_0.refreshUI(arg_6_0)
	arg_6_0:refreshStyle()
	arg_6_0:refreshLV()
	arg_6_0:refreshPower()
	arg_6_0:refreshTalentEffect()
end

function var_0_0.refreshTalentEffect(arg_7_0)
	local var_7_0 = RougeModel.instance:getRougeInfo()
	local var_7_1 = var_7_0.talentPoint >= arg_7_0._costTalentPoint

	if var_7_1 then
		local var_7_2 = var_7_0.talentInfo
		local var_7_3 = #var_7_2
		local var_7_4 = var_7_2[var_7_3]

		if var_7_2[var_7_3 - 1].isActive == 1 or var_7_4.isActive == 1 then
			var_7_1 = false
		end
	end

	gohelper.setActive(arg_7_0._goeffect, var_7_1)
end

function var_0_0.refreshStyle(arg_8_0)
	local var_8_0 = arg_8_0.rougeInfo.style
	local var_8_1 = arg_8_0.rougeInfo.season
	local var_8_2 = lua_rouge_style.configDict[var_8_1][var_8_0]

	UISpriteSetMgr.instance:setRouge2Sprite(arg_8_0._imageTypeIcon, string.format("%s_light", var_8_2.icon))

	arg_8_0._txtTypeName.text = var_8_2.name
end

function var_0_0.refreshLV(arg_9_0)
	arg_9_0._txtLv.text = "Lv." .. arg_9_0.rougeInfo.teamLevel
end

function var_0_0.refreshPower(arg_10_0)
	local var_10_0 = arg_10_0.rougeInfo

	if not arg_10_0.prePower then
		arg_10_0._txttalent.text = var_10_0.power
		arg_10_0.prePower = var_10_0.power
	elseif arg_10_0.prePower ~= var_10_0.power then
		arg_10_0:killTween()
		gohelper.setActive(arg_10_0._gomagic, false)
		gohelper.setActive(arg_10_0._gomagic, true)

		arg_10_0.tweenId = ZProj.TweenHelper.DOTweenFloat(arg_10_0.prePower, var_10_0.power, RougeMapEnum.PowerChangeDuration, arg_10_0.frameCallback, arg_10_0.doneCallback, arg_10_0)

		AudioMgr.instance:trigger(AudioEnum.UI.DecreasePower)
	end

	arg_10_0._txttotal.text = var_10_0.powerLimit
end

function var_0_0.frameCallback(arg_11_0, arg_11_1)
	arg_11_1 = math.ceil(arg_11_1)
	arg_11_0._txttalent.text = arg_11_1
	arg_11_0.prePower = arg_11_1
end

function var_0_0.doneCallback(arg_12_0)
	arg_12_0.tweenId = nil
end

function var_0_0.killTween(arg_13_0)
	if arg_13_0.tweenId then
		ZProj.TweenHelper.KillById(arg_13_0.tweenId)

		arg_13_0.tweenId = nil
	end
end

function var_0_0.onUpdateTalentPoint(arg_14_0)
	if not RougeMapHelper.checkMapViewOnTop() then
		arg_14_0._waitUpdate = true

		return
	end

	arg_14_0._waitUpdate = nil

	arg_14_0:refreshTalentEffect()
	gohelper.setActive(arg_14_0._goeffectget, true)
	TaskDispatcher.cancelTask(arg_14_0._hideTalentGetEffect, arg_14_0)
	TaskDispatcher.runDelay(arg_14_0._hideTalentGetEffect, arg_14_0, var_0_1)
end

function var_0_0.onCloseViewFinishCallBack(arg_15_0)
	if arg_15_0._waitUpdate then
		arg_15_0:onUpdateTalentPoint()
	end
end

function var_0_0._hideTalentGetEffect(arg_16_0)
	gohelper.setActive(arg_16_0._goeffectget, false)
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0._btnclickOnClick(arg_18_0)
	RougeController.instance:openRougeTalentView()
end

function var_0_0.destroy(arg_19_0)
	arg_19_0:killTween()
	arg_19_0._btnclick:RemoveClickListener()
	TaskDispatcher.cancelTask(arg_19_0._hideTalentGetEffect, arg_19_0)
	arg_19_0:__onDispose()
end

return var_0_0
