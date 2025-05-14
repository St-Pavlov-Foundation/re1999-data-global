module("modules.logic.rouge.dlc.101.view.RougeLimiterDebuffTipsView", package.seeall)

local var_0_0 = class("RougeLimiterDebuffTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobuffdec = gohelper.findChild(arg_1_0.viewGO, "#go_buffdec")
	arg_1_0._btncheck = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buffdec/#btn_check")
	arg_1_0._imagebufficon = gohelper.findChildImage(arg_1_0.viewGO, "#go_buffdec/#image_bufficon")
	arg_1_0._txtbufflevel = gohelper.findChildText(arg_1_0.viewGO, "#go_buffdec/#txt_bufflevel")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "#go_buffdec/#txt_dec")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_buffdec/#txt_name")
	arg_1_0._imagepoint = gohelper.findChildImage(arg_1_0.viewGO, "#go_buffdec/#image_point")
	arg_1_0._txtcost = gohelper.findChildText(arg_1_0.viewGO, "#go_buffdec/#txt_cost")
	arg_1_0._txtbuffdec = gohelper.findChildText(arg_1_0.viewGO, "#go_buffdec/#txt_buffdec")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buffdec/btnContain/#btn_equip")
	arg_1_0._btnunequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buffdec/btnContain/#btn_unequip")
	arg_1_0._btncostunlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buffdec/btnContain/#btn_costunlock")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_buffdec/btnContain/#btn_costunlock/#txt_num")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_buffdec/btnContain/#btn_costunlock/#txt_num/#image_icon")
	arg_1_0._btnspeedup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buffdec/btnContain/#btn_speedup")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncheck:AddClickListener(arg_2_0._btncheckOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncheck:RemoveClickListener()
end

function var_0_0._btncheckOnClick(arg_4_0)
	local var_4_0 = RougeDLCModel101.instance:getLimiterClientMo()
	local var_4_1 = var_4_0 and var_4_0:getLimitIds()
	local var_4_2 = RougeDLCModel101.instance:getAllLimiterBuffIds()
	local var_4_3 = RougeDLCModel101.instance:getTotalRiskValue()
	local var_4_4 = {
		limiterIds = var_4_1,
		buffIds = var_4_2,
		totalRiskValue = var_4_3
	}

	RougeDLCController101.instance:openRougeLimiterOverView(var_4_4)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.RefreshLimiterDebuffTips, arg_5_0._onRefreshLimiterDebuffTips, arg_5_0)

	arg_5_0._animator = gohelper.onceAddComponent(arg_5_0._gobuffdec, gohelper.Type_Animator)
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:refreshDebuffTips()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:refreshDebuffTips()
end

function var_0_0.refreshDebuffTips(arg_8_0, arg_8_1)
	arg_8_0._preLimiterGroupId = arg_8_0._curLimiterGroupId
	arg_8_0._preLimiterGroupLv = arg_8_0._curLimiterGroupLv

	if RougeDLCModel101.instance:getCurLimiterGroupLv(arg_8_1) <= 0 then
		arg_8_1 = arg_8_0:getNeedShowLimiterGroupId()
	end

	arg_8_0._curLimiterGroupId = arg_8_1 or arg_8_0:getNeedShowLimiterGroupId()

	local var_8_0 = arg_8_0._curLimiterGroupId and arg_8_0._curLimiterGroupId > 0

	gohelper.setActive(arg_8_0._gobuffdec, var_8_0)

	if not var_8_0 then
		arg_8_0._preLimiterGroupId = nil
		arg_8_0._curLimiterGroupId = nil

		return
	end

	arg_8_0._curLimiterGroupLv = RougeDLCModel101.instance:getCurLimiterGroupLv(arg_8_0._curLimiterGroupId)

	local var_8_1 = RougeDLCConfig101.instance:getLimiterCoByGroupIdAndLv(arg_8_0._curLimiterGroupId, arg_8_0._curLimiterGroupLv)
	local var_8_2 = RougeDLCConfig101.instance:getLimiterGroupCo(arg_8_0._curLimiterGroupId)

	arg_8_0._txtname.text = var_8_1 and var_8_1.title
	arg_8_0._txtdec.text = var_8_1 and var_8_1.desc
	arg_8_0._txtcost.text = var_8_1 and var_8_1.riskValue
	arg_8_0._txtbufflevel.text = GameUtil.getRomanNums(arg_8_0._curLimiterGroupLv)

	UISpriteSetMgr.instance:setRouge4Sprite(arg_8_0._imagebufficon, var_8_2.icon)
end

function var_0_0.getNeedShowLimiterGroupId(arg_9_0)
	local var_9_0 = RougeDLCModel101.instance:getSelectLimiterGroupIds()
	local var_9_1 = var_9_0 and #var_9_0 or 0

	return var_9_0 and var_9_0[var_9_1]
end

function var_0_0._onRefreshLimiterDebuffTips(arg_10_0, arg_10_1)
	arg_10_0:refreshDebuffTips(arg_10_1)
	arg_10_0:try2PlayRefreshAnim(arg_10_1)
end

function var_0_0.try2PlayRefreshAnim(arg_11_0, arg_11_1)
	if not arg_11_0:isNeedPlayRefreshAnim(arg_11_1) then
		return
	end

	arg_11_0._animator:Play("refresh", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.RefreshLimiterTips)
end

function var_0_0.isNeedPlayRefreshAnim(arg_12_0)
	if not arg_12_0._curLimiterGroupId and not arg_12_0._preLimiterGroupId then
		return false
	end

	if arg_12_0._curLimiterGroupId == arg_12_0._preLimiterGroupId and arg_12_0._preLimiterGroupLv == arg_12_0._curLimiterGroupLv then
		return false
	end

	return true
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
