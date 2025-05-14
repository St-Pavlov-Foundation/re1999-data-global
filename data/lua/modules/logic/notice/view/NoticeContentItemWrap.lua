module("modules.logic.notice.view.NoticeContentItemWrap", package.seeall)

local var_0_0 = class("NoticeContentItemWrap", MixScrollCell)

var_0_0.Comp2TypeDict = {
	[NoticeTxtTopTitleItem] = {
		NoticeContentType.TxtTopTitle
	},
	[NoticeTxtContentItem] = {
		NoticeContentType.TxtContent
	},
	[NoticeImgItem] = {
		NoticeContentType.ImgInner,
		NoticeContentType.ImgTitle
	}
}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.compList = {}

	for iter_1_0, iter_1_1 in pairs(var_0_0.Comp2TypeDict) do
		local var_1_0 = iter_1_0.New()

		var_1_0:init(arg_1_1, iter_1_1)
		table.insert(arg_1_0.compList, var_1_0)
	end
end

function var_0_0.addEventListeners(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.compList) do
		iter_2_1:addEventListeners()
	end
end

function var_0_0.removeEventListeners(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.compList) do
		iter_3_1:removeEventListeners()
	end
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.compList) do
		iter_4_1:onUpdateMO(arg_4_1)
	end
end

function var_0_0.onDestroy(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.compList) do
		iter_5_1:onDestroy()
	end

	arg_5_0.compList = nil
end

return var_0_0
