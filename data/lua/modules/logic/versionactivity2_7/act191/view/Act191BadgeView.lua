module("modules.logic.versionactivity2_7.act191.view.Act191BadgeView", package.seeall)

local var_0_0 = class("Act191BadgeView", BaseView)

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

function var_0_0.onOpen(arg_6_0)
	Act191StatController.instance:onViewOpen(arg_6_0.viewName)

	local var_6_0 = Activity191Model.instance:getActInfo():getBadgeMoList()

	arg_6_0.badgeIconList = {}

	for iter_6_0 = 1, 8 do
		local var_6_1 = gohelper.findChild(arg_6_0.viewGO, "badgeitem" .. iter_6_0)
		local var_6_2 = var_6_0[iter_6_0]

		if var_6_2 then
			local var_6_3 = gohelper.findChildSingleImage(var_6_1, "badgeIcon/root/image_icon")
			local var_6_4 = gohelper.findChildText(var_6_1, "badgeIcon/root/txt_num")
			local var_6_5 = gohelper.findChildText(var_6_1, "txt_name")
			local var_6_6 = gohelper.findChildText(var_6_1, "scroll_desc/Viewport/content/txt_desc")

			var_6_4.text = var_6_2.count
			var_6_5.text = var_6_2.config.name
			var_6_6.text = var_6_2.config.desc

			local var_6_7 = var_6_2:getState()
			local var_6_8 = ResUrl.getAct174BadgeIcon(var_6_2.config.icon, var_6_7)

			var_6_3:LoadImage(var_6_8)

			arg_6_0.badgeIconList[iter_6_0] = var_6_3
		end
	end
end

function var_0_0.onClose(arg_7_0)
	local var_7_0 = arg_7_0.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(arg_7_0.viewName, var_7_0)
end

function var_0_0.onDestroyView(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.badgeIconList) do
		iter_8_1:UnLoadImage()
	end
end

return var_0_0
