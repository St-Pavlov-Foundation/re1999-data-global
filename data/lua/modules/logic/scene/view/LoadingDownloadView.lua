module("modules.logic.scene.view.LoadingDownloadView", package.seeall)

local var_0_0 = class("LoadingDownloadView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._progressBar = SLFramework.UGUI.SliderWrap.GetWithPath(arg_1_0.viewGO, "progressBar")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._txtPercent = gohelper.findChildText(arg_1_0.viewGO, "bottom_text/#txt_percent")
	arg_1_0._txtWarn = gohelper.findChildText(arg_1_0.viewGO, "bottom_text/#txt_actualnum")
	arg_1_0._txtDescribe = gohelper.findChildText(arg_1_0.viewGO, "describe_text/#txt_describe")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "describe_text/#txt_describe/title/#txt_title")
	arg_1_0._txtTitleEn = gohelper.findChildText(arg_1_0.viewGO, "describe_text/#txt_describe/title/#txt_title_en")

	arg_1_0:_setLoadingItem()
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0:addEventCb(GameSceneMgr.instance, SceneEventName.ShowDownloadInfo, arg_2_0._showDownloadInfo, arg_2_0)
end

function var_0_0.onClose(arg_3_0)
	gohelper.setActive(arg_3_0.viewGO, false)
	arg_3_0:removeEventCb(GameSceneMgr.instance, SceneEventName.ShowDownloadInfo, arg_3_0._showDownloadInfo, arg_3_0)
	arg_3_0._simagebg:UnLoadImage()
end

function var_0_0._showDownloadInfo(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0:setPercent(arg_4_1)
	arg_4_0:setProgressMsg(arg_4_2)
	arg_4_0:setWarnningMsg(arg_4_3)
end

function var_0_0._getRandomCO(arg_5_0, arg_5_1)
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		var_5_0 = var_5_0 + iter_5_1.weight
	end

	local var_5_1 = math.floor(math.random() * var_5_0)

	for iter_5_2, iter_5_3 in ipairs(arg_5_1) do
		if var_5_1 < iter_5_3.weight then
			return iter_5_3
		else
			var_5_1 = var_5_1 - iter_5_3.weight
		end
	end

	return arg_5_1[math.random(1, #arg_5_1)]
end

function var_0_0._setLoadingItem(arg_6_0)
	local var_6_0 = booterLoadingConfig()
	local var_6_1 = arg_6_0:_getRandomCO(var_6_0)

	arg_6_0._txtDescribe.text = var_6_1.desc
	arg_6_0._txtTitle.text = var_6_1.title
	arg_6_0._txtTitleEn.text = var_6_1.titleen

	arg_6_0:_showDownloadInfo(0, luaLang("voice_package_update"))
	arg_6_0._simagebg:LoadImage(ResUrl.getLoadingBg("full/originbg"))
end

function var_0_0.show(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:setPercent(arg_7_1)
	arg_7_0:setProgressMsg(arg_7_2)
	arg_7_0:setWarnningMsg(arg_7_3)
end

function var_0_0.setPercent(arg_8_0, arg_8_1)
	arg_8_0._progressBar:SetValue(arg_8_1)
end

function var_0_0.setProgressMsg(arg_9_0, arg_9_1)
	arg_9_0._txtPercent.text = arg_9_1 and arg_9_1 or ""
end

function var_0_0.setWarnningMsg(arg_10_0, arg_10_1)
	arg_10_0._txtWarn.text = arg_10_1 and arg_10_1 or ""
end

return var_0_0
