module("modules.logic.notice.view.items.NoticeContentBaseItem", package.seeall)

local var_0_0 = class("NoticeContentBaseItem", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.itemGo = arg_1_1
	arg_1_0.types = arg_1_2
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0.mo = arg_4_1

	if arg_4_0:includeType(arg_4_0.mo.type) then
		arg_4_0:show()
	else
		arg_4_0:hide()
	end
end

function var_0_0.includeType(arg_5_0, arg_5_1)
	return tabletool.indexOf(arg_5_0.types, arg_5_1)
end

function var_0_0.show(arg_6_0)
	return
end

function var_0_0.hide(arg_7_0)
	return
end

function var_0_0.jump(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	arg_8_2 = string.trim(arg_8_2)

	if arg_8_1 == NoticeContentType.LinkType.InnerLink then
		logNormal("click inner link : " .. arg_8_2)
		GameFacade.jump(arg_8_2)
	elseif arg_8_1 == NoticeContentType.LinkType.OutLink then
		local var_8_0 = NoticeModel.instance:getNoticeUrl(tonumber(arg_8_2))

		if var_8_0 then
			var_8_0 = string.find(var_8_0, "http") and var_8_0 or "http://" .. var_8_0
		else
			var_8_0 = arg_8_2
		end

		local var_8_1 = string.gsub(var_8_0, "\\", "")

		logNormal("Open Url :" .. tostring(var_8_1))

		if arg_8_4 then
			WebViewController.instance:openWebView(var_8_1, arg_8_5)
		else
			if arg_8_5 then
				var_8_1 = WebViewController.instance:getRecordUserUrl(var_8_1)
			end

			GameUtil.openURL(var_8_1)
		end
	elseif arg_8_1 == NoticeContentType.LinkType.DeepLink then
		local var_8_2 = arg_8_2
		local var_8_3 = arg_8_3 and string.trim(arg_8_3)

		if string.nilorempty(var_8_3) then
			local var_8_4 = string.split(var_8_2, "//")

			var_8_3 = "https://" .. var_8_4[2]
		end

		logNormal("Open Http Url : " .. var_8_3)
		logNormal("Open Deep Url : " .. var_8_2)
		GameUtil.openDeepLink(var_8_3, var_8_2)
	elseif arg_8_1 == NoticeContentType.LinkType.Time then
		local var_8_5 = "时间戳 ： " .. arg_8_2

		logNormal(var_8_5)
	end
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0:__onDispose()
end

return var_0_0
