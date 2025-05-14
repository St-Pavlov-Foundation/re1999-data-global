module("modules.logic.bossrush.view.V1a4_BossRush_ResultPanelItem", package.seeall)

local var_0_0 = class("V1a4_BossRush_ResultPanelItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtScore = gohelper.findChildText(arg_1_0.viewGO, "txt_Score")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._img = gohelper.findChildImage(arg_4_0.viewGO, "")
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	arg_5_0:_refresh()
end

function var_0_0.onSelect(arg_6_0, arg_6_1)
	return
end

function var_0_0._refresh(arg_7_0)
	local var_7_0 = arg_7_0._mo
	local var_7_1 = var_7_0.isGray
	local var_7_2 = var_7_0.stageRewardCO.rewardPointNum
	local var_7_3 = var_7_1 and BossRushEnum.Color.GRAY or BossRushEnum.Color.WHITE

	arg_7_0:setDesc(BossRushConfig.instance:getScoreStr(var_7_2))
	arg_7_0:setImgColor(var_7_3)
end

function var_0_0.setDesc(arg_8_0, arg_8_1)
	arg_8_0._txtScore.text = arg_8_1
end

function var_0_0.setActive(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._go, arg_9_1)
end

function var_0_0.setImgColor(arg_10_0, arg_10_1)
	UIColorHelper.set(arg_10_0._img, arg_10_1)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
