module("modules.logic.fight.view.Fight183TaskView", package.seeall)

local var_0_0 = class("Fight183TaskView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._titleText = gohelper.findChildText(arg_1_0.viewGO, "#txt_title")
	arg_1_0._descText = gohelper.findChildText(arg_1_0.viewGO, "#txt_dec")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registFightEvent(FightEvent.OnBuffUpdate, arg_2_0._onBuffUpdate)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onConstructor(arg_4_0, arg_4_1)
	local var_4_0 = string.splitToNumber(arg_4_1, "#")[1]

	arg_4_0._config = lua_challenge_condition.configDict[var_4_0]
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:_refreshData()
end

function var_0_0._onBuffUpdate(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_0._config then
		return
	end

	if arg_6_1 ~= FightEntityScene.MySideId then
		return
	end

	arg_6_0:_refreshData()
end

function var_0_0._refreshData(arg_7_0)
	if arg_7_0._config then
		local var_7_0 = arg_7_0._config
		local var_7_1 = false

		if var_7_0.type == 19 then
			local var_7_2 = tonumber(var_7_0.value)
			local var_7_3 = FightDataHelper.entityMgr:getMyVertin()

			if var_7_3 then
				for iter_7_0, iter_7_1 in pairs(var_7_3.buffDic) do
					if iter_7_1.buffId == var_7_2 then
						var_7_1 = true

						break
					end
				end
			end
		end

		local var_7_4 = ""
		local var_7_5 = var_7_0.decs1

		if var_7_1 then
			local var_7_6 = luaLang("act183task_condition_title_complete")

			var_7_4 = string.format("<color=#7A8E51>%s</color>", var_7_6)
			var_7_5 = string.format("<s><color=#7A8E51>%s</color></s>", var_7_5)
		else
			var_7_4 = luaLang("act183task_condition_title")
		end

		arg_7_0._titleText.text = var_7_4
		arg_7_0._descText.text = var_7_5
	else
		arg_7_0._titleText.text = ""
		arg_7_0._descText.text = ""
	end
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
