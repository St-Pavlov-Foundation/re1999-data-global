module("modules.logic.notice.model.NoticeContentListModel", package.seeall)

local var_0_0 = class("NoticeContentListModel", MixScrollModel)

function var_0_0.setNoticeMO(arg_1_0, arg_1_1)
	arg_1_0.noticeMO = arg_1_1

	if arg_1_0.noticeMO then
		local var_1_0 = arg_1_0:_convertContentUrl(arg_1_0.noticeMO:getContent())
		local var_1_1 = not string.nilorempty(var_1_0) and cjson.decode(var_1_0) or {}

		arg_1_0:setList(var_1_1)
	else
		arg_1_0:clear()
	end
end

function var_0_0._convertContentUrl(arg_2_0, arg_2_1)
	local var_2_0 = string.gsub(arg_2_1, "[<>]", "|")
	local var_2_1 = string.split(var_2_0, "|")
	local var_2_2 = arg_2_1

	table.sort(var_2_1, function(arg_3_0, arg_3_1)
		return #arg_3_0 > #arg_3_1
	end)

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		if string.find(iter_2_1, "link=2#") then
			local var_2_3 = string.urldecode(string.gsub(iter_2_1, "link=2#", ""))
			local var_2_4 = NoticeModel.instance:getNextUrlId()

			var_2_2 = string.gsub(var_2_2, var_2_3, tostring(var_2_4))

			NoticeModel.instance:setNoticeUrl(var_2_4, var_2_3)
		end
	end

	return var_2_2
end

function var_0_0.convertUrl(arg_4_0, arg_4_1)
	local var_4_0 = string.gsub(arg_4_1, "?", "@")

	return string.gsub(var_4_0, "-", "!")
end

function var_0_0.decodeUrl(arg_5_0, arg_5_1)
	local var_5_0 = string.gsub(arg_5_1, "@", "?")

	return string.gsub(var_5_0, "!", "-")
end

function var_0_0.decodeToJson(arg_6_0)
	if arg_6_0.noticeMO then
		local var_6_0 = arg_6_0:getList()

		arg_6_0.noticeMO:setContent(cjson.encode(var_6_0))
	end
end

function var_0_0.hasTitle(arg_7_0)
	if arg_7_0.noticeMO then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0:getList()) do
			if iter_7_1.type == NoticeContentType.TxtTopTitle then
				return true
			end
		end
	end

	return false
end

function var_0_0.getCurSelectNoticeTitle(arg_8_0)
	return arg_8_0.noticeMO and arg_8_0.noticeMO:getTitle() or ""
end

function var_0_0.getCurSelectNoticeTypeStr(arg_9_0)
	return arg_9_0.noticeMO and NoticeController.instance:getNoticeTypeStr(arg_9_0.noticeMO) or ""
end

var_0_0.ContentTileHeight = 97
var_0_0.TxtSpaceVertical = 7
var_0_0.ImgSpaceVertical = 0
var_0_0.ImgTitleSpaceVertical = 21

function var_0_0.getInfoList(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getList()

	if not var_10_0 or #var_10_0 <= 0 then
		return {}
	end

	local var_10_1 = gohelper.findChildComponent(arg_10_1, "#txt_content", typeof(TMPro.TextMeshProUGUI))
	local var_10_2 = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if not iter_10_1.type then
			logError("notice content type is nil, noticeId = " .. arg_10_0.noticeMO.id)

			return
		end

		if iter_10_1.type == NoticeContentType.TxtTopTitle then
			local var_10_3

			if not iter_10_1.content or string.nilorempty(string.gsub(iter_10_1.content, "<.->", "")) then
				var_10_3 = SLFramework.UGUI.MixCellInfo.New(iter_10_1.type, 0, nil)
			else
				var_10_3 = SLFramework.UGUI.MixCellInfo.New(iter_10_1.type, var_0_0.ContentTileHeight, nil)
			end

			table.insert(var_10_2, var_10_3)
		elseif iter_10_1.type == NoticeContentType.TxtContent then
			local var_10_4 = GameUtil.getPreferredHeight(var_10_1, iter_10_1.content)
			local var_10_5 = SLFramework.UGUI.MixCellInfo.New(iter_10_1.type, var_10_4 + var_0_0.TxtSpaceVertical, nil)

			table.insert(var_10_2, var_10_5)
		elseif iter_10_1.type == NoticeContentType.ImgInner then
			if not iter_10_1.height then
				local var_10_6 = SLFramework.FileHelper.GetFileName(string.gsub(arg_10_0:decodeUrl(iter_10_1.content), "?.*", ""), true)

				iter_10_1.width, iter_10_1.height = NoticeModel.instance:getSpriteCacheDefaultSize(var_10_6)
			end

			local var_10_7 = SLFramework.UGUI.MixCellInfo.New(iter_10_1.type, (iter_10_1.height or 100) + var_0_0.ImgSpaceVertical, nil)

			table.insert(var_10_2, var_10_7)
		elseif iter_10_1.type == NoticeContentType.ImgTitle then
			if not iter_10_1.height then
				local var_10_8 = SLFramework.FileHelper.GetFileName(string.gsub(arg_10_0:decodeUrl(iter_10_1.content), "?.*", ""), true)

				iter_10_1.width, iter_10_1.height = NoticeModel.instance:getSpriteCacheDefaultSize(var_10_8)
			end

			local var_10_9 = SLFramework.UGUI.MixCellInfo.New(iter_10_1.type, (iter_10_1.height or 100) + var_0_0.ImgTitleSpaceVertical, nil)

			table.insert(var_10_2, var_10_9)
		else
			logError("notice content type not implement: " .. iter_10_1.type)
		end
	end

	return var_10_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
