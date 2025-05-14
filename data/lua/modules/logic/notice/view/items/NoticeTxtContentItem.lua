module("modules.logic.notice.view.items.NoticeTxtContentItem", package.seeall)

local var_0_0 = class("NoticeTxtContentItem", NoticeContentBaseItem)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.init(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.txtContent = gohelper.findChildText(arg_1_1, "#txt_content", typeof(TMPro.TextMeshProUGUI))
	arg_1_0.goContent = arg_1_0.txtContent.gameObject
	arg_1_0.hyperLinkClick = gohelper.onceAddComponent(arg_1_0.txtContent.gameObject, typeof(ZProj.TMPHyperLinkClick))
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0.hyperLinkClick:SetClickListener(arg_2_0._onClickTextMeshProLink, arg_2_0)
end

function var_0_0._onClickTextMeshProLink(arg_3_0, arg_3_1)
	logNormal(string.format("on click hyper link, type : %s, link : %s", arg_3_0.mo.linkType, arg_3_0.mo.link))

	if not string.nilorempty(arg_3_0.mo.link) then
		local var_3_0 = ViewMgr.instance:getContainer(ViewName.NoticeView)

		if var_3_0 then
			var_3_0:trackNoticeJump(arg_3_0.mo)
		end

		arg_3_0:jump(arg_3_0.mo.linkType, arg_3_0.mo.link, arg_3_0.mo.link1)
	end
end

function var_0_0.show(arg_4_0)
	gohelper.setActive(arg_4_0.goContent, true)

	local var_4_0 = arg_4_0.mo.content

	arg_4_0.txtContent.text = arg_4_0:formatTime(var_4_0)
end

function var_0_0.formatTime(arg_5_0, arg_5_1)
	local var_5_0
	local var_5_1 = NoticeEnum.FindTimePattern
	local var_5_2 = 1

	while true do
		local var_5_3, var_5_4, var_5_5, var_5_6, var_5_7 = string.find(arg_5_1, var_5_1, var_5_2)

		if not var_5_3 then
			break
		end

		local var_5_8, var_5_9, var_5_10 = NoticeHelper.getTimeMatchIndexAndTimeTable(var_5_7)

		if not var_5_8 then
			var_5_8 = NoticeEnum.FindTimeType.MD_HM
			var_5_9 = 1
		end

		var_5_0 = var_5_0 or {}

		local var_5_11 = os.date("*t", TimeUtil.getTimeStamp(var_5_10, tonumber(var_5_6)))

		table.insert(var_5_0, {
			s = var_5_3,
			e = var_5_4,
			content = NoticeHelper.buildTimeByType(var_5_8, var_5_9, var_5_11)
		})

		var_5_2 = var_5_4 + 1
	end

	if not var_5_0 then
		return arg_5_1
	end

	local var_5_12 = {}
	local var_5_13 = 1

	if var_5_0 then
		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			local var_5_14 = iter_5_1.s
			local var_5_15 = iter_5_1.e
			local var_5_16 = arg_5_1:sub(var_5_13, var_5_14 - 1)
			local var_5_17 = iter_5_1.content

			table.insert(var_5_12, var_5_16)
			table.insert(var_5_12, var_5_17)

			var_5_13 = var_5_15 + 1
		end
	end

	table.insert(var_5_12, arg_5_1:sub(var_5_13))

	return table.concat(var_5_12)
end

function var_0_0.hide(arg_6_0)
	gohelper.setActive(arg_6_0.goContent, false)
end

return var_0_0
