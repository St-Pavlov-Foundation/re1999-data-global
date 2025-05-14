module("modules.logic.versionactivity.view.VersionActivityNewsView", package.seeall)

local var_0_0 = class("VersionActivityNewsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goclose = gohelper.findChild(arg_1_0.viewGO, "#go_close")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#txt_title")
	arg_1_0._goinfoitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_info/Viewport/Content/#go_infoitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

var_0_0.ParagraphDelimiter = "{p}"
var_0_0.ImageString = "{img}"
var_0_0.ImageStringLen = #var_0_0.ImageString
var_0_0.Anchor = {
	Left = Vector2.New(0, 1),
	Center = Vector2.New(0.5, 1),
	Right = Vector2.New(1, 1)
}
var_0_0.Align = {
	Right = 3,
	Left = 1,
	Center = 2
}

function var_0_0.closeViewOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._goinfoitem, false)

	arg_5_0.closeViewClick = gohelper.getClick(arg_5_0._goclose)

	arg_5_0.closeViewClick:AddClickListener(arg_5_0.closeViewOnClick, arg_5_0)

	arg_5_0.contentItemList = {}
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.fragmentId

	arg_7_0.fragmentCo = lua_chapter_map_fragment.configDict[var_7_0]

	if not arg_7_0.fragmentCo then
		logError("not found fragment : " .. var_7_0)
		arg_7_0:closeThis()

		return
	end

	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0._txttitle.text = arg_8_0.fragmentCo.title

	local var_8_0 = string.split(arg_8_0.fragmentCo.content, var_0_0.ParagraphDelimiter)
	local var_8_1 = 0
	local var_8_2
	local var_8_3

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if not string.nilorempty(iter_8_1) then
			var_8_1 = var_8_1 + 1
			iter_8_1 = string.trim(iter_8_1)

			local var_8_4 = arg_8_0.contentItemList[var_8_1] or arg_8_0:createContentItem()

			gohelper.setActive(var_8_4.go, true)

			local var_8_5 = string.find(iter_8_1, var_0_0.ImageString) and true or false

			gohelper.setActive(var_8_4.goPlainText, not var_8_5)
			gohelper.setActive(var_8_4.goImgText, var_8_5)

			if var_8_5 then
				local var_8_6 = arg_8_0:getImageAlign(iter_8_1)

				iter_8_1 = string.gsub(iter_8_1, var_0_0.ImageString, "")
				var_8_4.txtImgText.text = iter_8_1

				var_8_4.simageIcon:LoadImage(ResUrl.getVersionActivityIcon(arg_8_0.fragmentCo.res))

				local var_8_7 = recthelper.getWidth(var_8_4.iconRectTr)

				if var_8_6 == var_0_0.Align.Left then
					var_8_4.iconRectTr.anchorMin = var_0_0.Anchor.Left
					var_8_4.iconRectTr.anchorMax = var_0_0.Anchor.Left

					recthelper.setAnchor(var_8_4.iconRectTr, var_8_7 / 2, 0)
				elseif var_8_6 == var_0_0.Align.Center then
					var_8_4.iconRectTr.anchorMin = var_0_0.Anchor.Center
					var_8_4.iconRectTr.anchorMax = var_0_0.Anchor.Center

					recthelper.setAnchor(var_8_4.iconRectTr, 0, 0)
				elseif var_8_6 == var_0_0.Align.Right then
					var_8_4.iconRectTr.anchorMin = var_0_0.Anchor.Right
					var_8_4.iconRectTr.anchorMax = var_0_0.Anchor.Right

					recthelper.setAnchor(var_8_4.iconRectTr, -var_8_7 / 2, 0)
				end
			else
				var_8_4.txtPlainText.text = iter_8_1
			end
		end
	end

	for iter_8_2 = var_8_1 + 1, #arg_8_0.contentItemList do
		gohelper.setActive(arg_8_0.contentItemList[iter_8_2].go, false)
	end
end

function var_0_0.checkIsImageType(arg_9_0, arg_9_1)
	return string.find(arg_9_1, var_0_0.ImageString)
end

function var_0_0.getImageAlign(arg_10_0, arg_10_1)
	local var_10_0, var_10_1 = string.find(arg_10_1, var_0_0.ImageString)

	if not var_10_0 then
		return var_0_0.Align.Right
	end

	if var_10_0 ~= 1 then
		return var_0_0.Align.Right
	end

	if string.nilorempty(string.sub(arg_10_1, var_10_1 + 1, var_10_1 + 1)) then
		return var_0_0.Align.Center
	end

	return var_0_0.Align.Left
end

function var_0_0.createContentItem(arg_11_0)
	local var_11_0 = arg_11_0:getUserDataTb_()

	var_11_0.go = gohelper.cloneInPlace(arg_11_0._goinfoitem)
	var_11_0.goPlainText = gohelper.findChild(var_11_0.go, "type1")
	var_11_0.txtPlainText = gohelper.findChildText(var_11_0.go, "type1")
	var_11_0.goImgText = gohelper.findChild(var_11_0.go, "type2")
	var_11_0.txtImgText = gohelper.findChildText(var_11_0.go, "type2/info")
	var_11_0.simageIcon = gohelper.findChildSingleImage(var_11_0.go, "type2/icon")
	var_11_0.iconRectTr = var_11_0.simageIcon.gameObject.transform

	return var_11_0
end

function var_0_0.onClose(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.contentItemList) do
		iter_12_1.simageIcon:UnLoadImage()
	end
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0.closeViewClick:RemoveClickListener()
end

return var_0_0
