module("modules.logic.rouge.dlc.101.view.RougeLimiterOverView", package.seeall)

local var_0_0 = class("RougeLimiterOverView", BaseView)

var_0_0.TabType = {
	Buff = 2,
	Debuff = 1
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._btndebuff = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/top/#btn_debuff")
	arg_1_0._btnbuff = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/top/#btn_buff")
	arg_1_0._txtdifficulty = gohelper.findChildText(arg_1_0.viewGO, "root/bottom/difficultybg/#txt_difficulty")
	arg_1_0._txtdec1 = gohelper.findChildText(arg_1_0.viewGO, "root/bottom/#txt_dec1")
	arg_1_0._txtdec2 = gohelper.findChildText(arg_1_0.viewGO, "root/bottom/#txt_dec2")
	arg_1_0._txtdec3 = gohelper.findChildText(arg_1_0.viewGO, "root/bottom/#txt_dec3")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "root/#go_empty")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btndebuff:AddClickListener(arg_2_0._btndebuffOnClick, arg_2_0)
	arg_2_0._btnbuff:AddClickListener(arg_2_0._btnbuffOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btndebuff:RemoveClickListener()
	arg_3_0._btnbuff:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btndebuffOnClick(arg_5_0)
	arg_5_0:try2SwtichTabView(var_0_0.TabType.Debuff)
end

function var_0_0._btnbuffOnClick(arg_6_0)
	arg_6_0:try2SwtichTabView(var_0_0.TabType.Buff)
end

function var_0_0.try2SwtichTabView(arg_7_0, arg_7_1)
	if arg_7_0._curTabId == arg_7_1 then
		return
	end

	arg_7_0._curTabId = arg_7_1

	arg_7_0.viewContainer:switchTab(arg_7_1)
	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0:refreshBarUI()
	arg_8_0:refreshDifficulty()
	arg_8_0:refreshEmptyUI()
end

function var_0_0.refreshBarUI(arg_9_0)
	local var_9_0 = gohelper.findChild(arg_9_0._btndebuff.gameObject, "unselect")
	local var_9_1 = gohelper.findChild(arg_9_0._btndebuff.gameObject, "selected")
	local var_9_2 = gohelper.findChild(arg_9_0._btnbuff.gameObject, "unselect")
	local var_9_3 = gohelper.findChild(arg_9_0._btnbuff.gameObject, "selected")

	gohelper.setActive(var_9_0, arg_9_0._curTabId ~= var_0_0.TabType.Debuff)
	gohelper.setActive(var_9_1, arg_9_0._curTabId == var_0_0.TabType.Debuff)
	gohelper.setActive(var_9_2, arg_9_0._curTabId ~= var_0_0.TabType.Buff)
	gohelper.setActive(var_9_3, arg_9_0._curTabId == var_0_0.TabType.Buff)
end

function var_0_0.refreshDifficulty(arg_10_0)
	local var_10_0 = arg_10_0.viewParam and arg_10_0.viewParam.totalRiskValue or 0
	local var_10_1 = RougeDLCConfig101.instance:getRougeRiskCoByRiskValue(var_10_0)

	arg_10_0._txtdifficulty.text = var_10_1 and var_10_1.title

	arg_10_0:refreshDesc(var_10_1 and var_10_1.desc)
end

function var_0_0.refreshDesc(arg_11_0, arg_11_1)
	local var_11_0 = {}

	if not string.nilorempty(arg_11_1) then
		local var_11_1 = string.split(arg_11_1, "|")

		for iter_11_0, iter_11_1 in ipairs(var_11_1) do
			local var_11_2 = arg_11_0["_txtdec" .. iter_11_0]

			var_11_2.text = iter_11_1
			var_11_0[var_11_2] = true

			gohelper.setActive(var_11_2.gameObject, true)
		end
	end

	for iter_11_2 = 1, RougeDLCEnum101.MaxRiskDescCount do
		local var_11_3 = arg_11_0["_txtdec" .. iter_11_2]

		if var_11_3 and not var_11_0[var_11_3] then
			gohelper.setActive(var_11_3.gameObject, false)
		end
	end
end

function var_0_0.refreshEmptyUI(arg_12_0)
	local var_12_0 = false

	if arg_12_0._curTabId == var_0_0.TabType.Debuff then
		local var_12_1 = arg_12_0.viewParam and arg_12_0.viewParam.limiterIds

		var_12_0 = (var_12_1 and #var_12_1 or 0) <= 0
	elseif arg_12_0._curTabId == var_0_0.TabType.Buff then
		local var_12_2 = arg_12_0.viewParam and arg_12_0.viewParam.buffIds

		var_12_0 = (var_12_2 and #var_12_2 or 0) <= 0
	end

	gohelper.setActive(arg_12_0._goempty, var_12_0)
end

function var_0_0._editableInitView(arg_13_0)
	return
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0._curTabId = var_0_0.TabType.Debuff

	arg_15_0:refreshUI()
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
