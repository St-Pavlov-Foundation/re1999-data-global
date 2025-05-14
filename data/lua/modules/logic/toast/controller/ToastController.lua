module("modules.logic.toast.controller.ToastController", package.seeall)

local var_0_0 = class("ToastController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._msgList = {}
	arg_1_0._notToastList = {}
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	arg_4_0._msgList = {}
	arg_4_0._notToastList = {}
end

function var_0_0.showToastWithIcon(arg_5_0, arg_5_1, arg_5_2, ...)
	arg_5_0._icon = arg_5_2

	arg_5_0:showToast(arg_5_1, ...)

	arg_5_0._icon = nil
end

function var_0_0.showToastWithExternalCall(arg_6_0)
	return
end

function var_0_0._showToast(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2 and ViewName.ToastTopView or ViewName.ToastView

	if not ViewMgr.instance:isOpen(var_7_0) then
		ViewMgr.instance:openView(var_7_0, arg_7_1)

		return
	end

	if ViewMgr.instance:isOpenFinish(var_7_0) then
		arg_7_0:dispatchEvent(ToastEvent.ShowToast, arg_7_1)

		return
	end

	table.insert(arg_7_0._msgList, arg_7_1)
end

function var_0_0.showToast(arg_8_0, arg_8_1, ...)
	local var_8_0 = arg_8_0:PackToastObj(arg_8_1, ...)

	if var_8_0 and (isDebugBuild or var_8_0.co.notShow == 0) then
		arg_8_0:_showToast(var_8_0)
	end
end

function var_0_0.PackToastObj(arg_9_0, arg_9_1, ...)
	local var_9_0 = arg_9_1 and ToastConfig.instance:getToastCO(arg_9_1)

	if not var_9_0 then
		logError(tostring(arg_9_1) .. " 配置提示语！！《P飘字表》- export_飘字表")

		return
	end

	local var_9_1 = {
		...
	}
	local var_9_2 = false

	if var_9_0.notMerge == 0 then
		for iter_9_0, iter_9_1 in pairs(arg_9_0._notToastList) do
			local var_9_3 = false

			if iter_9_1.extra and #var_9_1 == #iter_9_1.extra then
				local var_9_4 = true

				for iter_9_2 = 1, #var_9_1 do
					if var_9_1[iter_9_2] ~= iter_9_1.extra[iter_9_2] then
						var_9_4 = false

						break
					end
				end

				var_9_3 = var_9_4
			end

			if iter_9_1.toastid == arg_9_1 and var_9_3 then
				var_9_2 = true

				break
			end
		end
	end

	local var_9_5 = ""

	if #var_9_1 > 0 then
		for iter_9_3 = 1, #var_9_1 do
			var_9_5 = var_9_5 .. tostring(var_9_1[iter_9_3])
		end
	end

	local var_9_6 = tostring(arg_9_1) .. var_9_5

	if not var_9_2 then
		local var_9_7 = {
			toastid = arg_9_1,
			extra = var_9_1,
			time = ServerTime.now()
		}

		arg_9_0._notToastList[var_9_6] = var_9_7
	elseif not arg_9_0:isExpire(arg_9_0._notToastList[var_9_6].time) then
		return
	else
		arg_9_0._notToastList[var_9_6].time = ServerTime.now()
	end

	return {
		co = var_9_0,
		extra = var_9_1,
		sicon = arg_9_0._icon
	}
end

var_0_0.DefaultIconType = 11

function var_0_0.showToastWithString(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._notToastList[arg_10_1] and not arg_10_0:isExpire(arg_10_0._notToastList[arg_10_1].time) then
		return
	end

	local var_10_0 = {
		time = ServerTime.now()
	}

	arg_10_0._notToastList[arg_10_1] = var_10_0

	local var_10_1 = {
		co = {
			tips = arg_10_1,
			icon = var_0_0.DefaultIconType
		}
	}

	arg_10_0:_showToast(var_10_1, arg_10_2)
end

function var_0_0.showToastWithCustomData(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, ...)
	local var_11_0 = arg_11_0:PackToastObj(arg_11_1, ...)

	if var_11_0 then
		if arg_11_2 then
			arg_11_2(arg_11_3, var_11_0, arg_11_4)
		end

		arg_11_0:_showToast(var_11_0)
	end
end

function var_0_0.getToastMsg(arg_12_0, arg_12_1, ...)
	local var_12_0 = arg_12_0:PackToastObj(arg_12_1, ...)
	local var_12_1 = ""

	if var_12_0 then
		if var_12_0.extra and #var_12_0.extra > 0 then
			var_12_1 = GameUtil.getSubPlaceholderLuaLang(var_12_0.co.tips, var_12_0.extra)
		else
			var_12_1 = var_12_0.co.tips
		end
	end

	return var_12_1
end

function var_0_0.getToastMsgWithTableParam(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1 and ToastConfig.instance:getToastCO(arg_13_1)

	if not var_13_0 then
		logError("[ToastController] P飘字表.xlsx - export_飘字表 sheet error 不存在 toastId = " .. tostring(arg_13_1))

		return ""
	end

	return arg_13_2 and #arg_13_2 > 0 and GameUtil.getSubPlaceholderLuaLang(var_13_0.tips, arg_13_2) or var_13_0.tips
end

function var_0_0.isExpire(arg_14_0, arg_14_1)
	return ServerTime.now() - arg_14_1 >= 4
end

var_0_0.instance = var_0_0.New()

return var_0_0
