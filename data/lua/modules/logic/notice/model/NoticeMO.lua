module("modules.logic.notice.model.NoticeMO", package.seeall)

local var_0_0 = pureTable("NoticeMO")
local var_0_1 = {
	jp = "ja-JP",
	kr = "ko-KR",
	zh = "zh-CN",
	tw = "zh-TW",
	thai = "thai",
	en = "en"
}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.gameId = arg_1_1.gameId
	arg_1_0.order = arg_1_1.order
	arg_1_0.noticeTypes = arg_1_1.noticeTypes
	arg_1_0.noticePositionTypes = arg_1_1.noticePositionTypes
	arg_1_0.noticeLabelType = arg_1_1.noticeLabelType
	arg_1_0.beginTime = arg_1_1.beginTime
	arg_1_0.endTime = arg_1_1.endTime
	arg_1_0.noticeLabelTypeName = arg_1_1.noticeLabelTypeName
	arg_1_0.isTop = arg_1_1.isTop
	arg_1_0.contentMap = arg_1_1.contentMap

	for iter_1_0, iter_1_1 in pairs(arg_1_0.contentMap) do
		for iter_1_2, iter_1_3 in ipairs(iter_1_1.imageUrl) do
			arg_1_0:addImageUrl(iter_1_3)
		end
	end
end

function var_0_0.getTitle(arg_2_0)
	return arg_2_0:getLangContent().title
end

function var_0_0.getContent(arg_3_0)
	return arg_3_0:getLangContent().content
end

function var_0_0.getLangContent(arg_4_0)
	local var_4_0 = LangSettings.instance:getCurLangShortcut()
	local var_4_1 = var_0_1[var_4_0] or var_4_0
	local var_4_2 = arg_4_0.contentMap[var_4_1]

	if var_4_2 then
		return var_4_2
	end

	local var_4_3 = LangSettings.instance:getDefaultLangShortcut()
	local var_4_4 = var_0_1[var_4_3] or var_4_3
	local var_4_5 = arg_4_0.contentMap[var_4_4]

	if var_4_5 then
		return var_4_5
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0.contentMap) do
		return iter_4_1
	end
end

function var_0_0.setContent(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.contentMap) do
		if not arg_5_2 or arg_5_2 == iter_5_0 then
			iter_5_1.content = arg_5_1
		end
	end
end

function var_0_0.addImageUrl(arg_6_0, arg_6_1)
	arg_6_0.imgUrlDict = arg_6_0.imgUrlDict or {}

	local var_6_0 = SLFramework.FileHelper.GetFileName(arg_6_1, false)

	arg_6_0.imgUrlDict[var_6_0] = arg_6_1
end

function var_0_0.isNormalStatus(arg_7_0)
	local var_7_0 = ServerTime.now()

	return var_7_0 > arg_7_0.beginTime / 1000 and var_7_0 < arg_7_0.endTime / 1000
end

return var_0_0
