module("modules.logic.character.view.CharacterSkinTagView", package.seeall)

local var_0_0 = class("CharacterSkinTagView", BaseView)

var_0_0.MAX_TAG_HEIGHT = 825

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "bg")
	arg_1_0._scrollprop = gohelper.findChildScrollRect(arg_1_0.viewGO, "bg/#scroll_prop")
	arg_1_0._btnplay = gohelper.findChildButton(arg_1_0.viewGO, "bg/#go_btnRoot/#btn_play")
	arg_1_0._gocontentroot = gohelper.findChild(arg_1_0.viewGO, "bg/#scroll_prop/Viewport/Content")
	arg_1_0._goviewport = gohelper.findChild(arg_1_0.viewGO, "bg/#scroll_prop/Viewport")
	arg_1_0._goitem = gohelper.findChild(arg_1_0._gocontentroot, "item")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnplay:AddClickListener(arg_2_0._btnplayOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnplay:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._itemList = {}
	arg_4_0._bgLayoutElement = gohelper.onceAddComponent(arg_4_0._gobg, typeof(UnityEngine.UI.LayoutElement))
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._skinCo = arg_6_0.viewParam.skinCo

	local var_6_0 = string.splitToNumber(arg_6_0._skinCo.storeTag, "|")
	local var_6_1 = math.min(#var_6_0 * 62 + 120, 400)

	recthelper.setHeight(arg_6_0._gobg.transform, var_6_1)

	local var_6_2 = not VersionValidator.instance:isInReviewing() and arg_6_0._skinCo.isSkinVideo

	gohelper.setActive(arg_6_0._btnplay, var_6_2)
	arg_6_0:_refreshContent()
end

function var_0_0._refreshContent(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = arg_7_0._skinCo
	local var_7_2 = arg_7_0._gocontentroot

	if string.nilorempty(var_7_1.storeTag) == false then
		local var_7_3 = string.splitToNumber(var_7_1.storeTag, "|")

		for iter_7_0, iter_7_1 in ipairs(var_7_3) do
			table.insert(var_7_0, SkinConfig.instance:getSkinStoreTagConfig(iter_7_1))
		end
	end

	local var_7_4 = arg_7_0._itemList
	local var_7_5 = #var_7_4
	local var_7_6 = #var_7_0

	for iter_7_2 = 1, var_7_6 do
		local var_7_7 = var_7_0[iter_7_2]
		local var_7_8

		if iter_7_2 <= var_7_5 then
			var_7_8 = var_7_4[iter_7_2]
		else
			local var_7_9 = gohelper.clone(arg_7_0._goitem, var_7_2)

			var_7_8 = CharacterSkinTagItem.New()

			var_7_8:init(var_7_9)
			table.insert(var_7_4, var_7_8)
		end

		gohelper.setActive(var_7_8.viewGO, true)
		var_7_8:onUpdateMO(var_7_7)
	end

	if var_7_6 < var_7_5 then
		for iter_7_3 = var_7_6 + 1, var_7_5 do
			local var_7_10 = var_7_4[iter_7_3]

			gohelper.setActive(var_7_10.viewGO, false)
		end
	end

	ZProj.UGUIHelper.RebuildLayout(arg_7_0._goviewport.transform)

	local var_7_11 = recthelper.getHeight(var_7_2.transform)
	local var_7_12 = math.min(var_7_11, arg_7_0.MAX_TAG_HEIGHT)

	recthelper.setHeight(arg_7_0._gocontentroot.transform, var_7_12)
	recthelper.setHeight(arg_7_0._goviewport.transform, var_7_12)
	recthelper.setHeight(arg_7_0._gobg.transform, var_7_12)
end

function var_0_0.onClickModalMask(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._btnplayOnClick(arg_9_0)
	local var_9_0 = arg_9_0._skinCo.id
	local var_9_1 = arg_9_0._skinCo.characterId
	local var_9_2 = WebViewController.instance:getVideoUrl(var_9_1, var_9_0)

	if UnityEngine.Application.version == "2.6.0" and GameChannelConfig.isLongCheng() and BootNativeUtil.isAndroid() then
		UnityEngine.Application.OpenURL(var_9_2)

		return
	end

	WebViewController.instance:openWebView(var_9_2, false, arg_9_0.OnWebViewBack, arg_9_0)
end

function var_0_0.onClose(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_skin_tag)
end

function var_0_0.OnWebViewBack(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == WebViewEnum.WebViewCBType.Cb and arg_11_2 == "webClose" then
		ViewMgr.instance:closeView(ViewName.WebView)
	end

	logNormal("URL Jump Callback msg" .. arg_11_2)
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
