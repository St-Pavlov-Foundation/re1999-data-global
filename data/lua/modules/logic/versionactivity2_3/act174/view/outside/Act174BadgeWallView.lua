module("modules.logic.versionactivity2_3.act174.view.outside.Act174BadgeWallView", package.seeall)

local var_0_0 = class("Act174BadgeWallView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:freshBadgeItem()
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.badgeIconList) do
		iter_9_1:UnLoadImage()
	end
end

function var_0_0.freshBadgeItem(arg_10_0)
	local var_10_0 = Activity174Model.instance:getActInfo():getBadgeMoList()

	arg_10_0.badgeIconList = {}

	for iter_10_0 = 1, 8 do
		local var_10_1 = gohelper.findChild(arg_10_0.viewGO, "badgeitem" .. iter_10_0)
		local var_10_2 = var_10_0[iter_10_0]

		if var_10_2 then
			local var_10_3 = gohelper.findChildSingleImage(var_10_1, "badgeIcon/root/image_icon")
			local var_10_4 = gohelper.findChildText(var_10_1, "badgeIcon/root/txt_num")
			local var_10_5 = gohelper.findChildText(var_10_1, "txt_name")
			local var_10_6 = gohelper.findChildText(var_10_1, "scroll_desc/Viewport/content/txt_desc")

			var_10_4.text = var_10_2.count
			var_10_5.text = var_10_2.config.name
			var_10_6.text = var_10_2.config.desc

			local var_10_7 = var_10_2:getState()
			local var_10_8 = ResUrl.getAct174BadgeIcon(var_10_2.config.icon, var_10_7)

			var_10_3:LoadImage(var_10_8)

			arg_10_0.badgeIconList[iter_10_0] = var_10_3
		end
	end
end

return var_0_0
