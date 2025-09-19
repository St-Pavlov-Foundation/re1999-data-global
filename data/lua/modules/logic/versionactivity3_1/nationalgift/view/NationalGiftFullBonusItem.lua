module("modules.logic.versionactivity3_1.nationalgift.view.NationalGiftFullBonusItem", package.seeall)

local var_0_0 = class("NationalGiftFullBonusItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0._config = arg_1_2
	arg_1_0._txtrewardnum1 = gohelper.findChildText(arg_1_0.go, "group/reward1/txt_num")
	arg_1_0._txtrewardnum2 = gohelper.findChildText(arg_1_0.go, "group/reward2/txt_num")
	arg_1_0._gounget = gohelper.findChild(arg_1_0.go, "go_unget")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.go, "go_hasget")
	arg_1_0._gocanget = gohelper.findChild(arg_1_0.go, "go_canget")
	arg_1_0._gonextday = gohelper.findChild(arg_1_0.go, "go_nextday")
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_0.go, "btn_click")

	arg_1_0:_initItem()
end

function var_0_0._initItem(arg_2_0)
	local var_2_0 = string.split(arg_2_0._config.bonus, "|")

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_1 = string.splitToNumber(iter_2_1, "#")

		arg_2_0["_txtrewardnum" .. tostring(iter_2_0)].text = var_2_1[3]
	end

	if arg_2_0._btnClick then
		arg_2_0._btnClick:AddClickListener(arg_2_0._btnClickOnClick, arg_2_0)
	end
end

function var_0_0._btnClickOnClick(arg_3_0)
	if not NationalGiftModel.instance:isGiftHasBuy() then
		return
	end

	if not NationalGiftModel.instance:isBonusCouldGet(arg_3_0._config.id) then
		return
	end

	Activity212Rpc.instance:sendAct212ReceiveBonusRequest(VersionActivity3_1Enum.ActivityId.NationalGift, arg_3_0._config.id)
end

function var_0_0.refresh(arg_4_0)
	local var_4_0 = NationalGiftModel.instance:isBonusGet(arg_4_0._config.id)
	local var_4_1 = NationalGiftModel.instance:isBonusCouldGet(arg_4_0._config.id)
	local var_4_2 = NationalGiftModel.instance:isGiftHasBuy()

	if arg_4_0._gounget then
		local var_4_3 = arg_4_0._config.id == 1 and not var_4_2

		gohelper.setActive(arg_4_0._gounget, var_4_3)
	end

	if arg_4_0._gohasget then
		local var_4_4 = var_4_2 and var_4_0

		gohelper.setActive(arg_4_0._gohasget, var_4_4)
	end

	if arg_4_0._gocanget then
		local var_4_5 = var_4_2 and var_4_1

		gohelper.setActive(arg_4_0._gocanget, var_4_5)
	end

	if arg_4_0._gonextday then
		local var_4_6 = NationalGiftModel.instance:getCurRewardDay()
		local var_4_7 = var_4_2 and var_4_6 + 1 == arg_4_0._config.id

		gohelper.setActive(arg_4_0._gonextday, var_4_7)
	end
end

function var_0_0.destroy(arg_5_0)
	if arg_5_0._btnClick then
		arg_5_0._btnClick:RemoveClickListener()
	end
end

return var_0_0
