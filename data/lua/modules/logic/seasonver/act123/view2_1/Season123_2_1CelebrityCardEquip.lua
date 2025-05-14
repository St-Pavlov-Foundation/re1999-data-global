module("modules.logic.seasonver.act123.view2_1.Season123_2_1CelebrityCardEquip", package.seeall)

local var_0_0 = class("Season123_2_1CelebrityCardEquip", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0.viewGO = arg_1_1
	arg_1_0._gorare6 = gohelper.findChild(arg_1_0.viewGO, "#go_rare6")
	arg_1_0._gorare5 = gohelper.findChild(arg_1_0.viewGO, "#go_rare5")
	arg_1_0._gorare4 = gohelper.findChild(arg_1_0.viewGO, "#go_rare4")
	arg_1_0._gorare3 = gohelper.findChild(arg_1_0.viewGO, "#go_rare3")
	arg_1_0._gorare2 = gohelper.findChild(arg_1_0.viewGO, "#go_rare2")
	arg_1_0._gorare1 = gohelper.findChild(arg_1_0.viewGO, "#go_rare1")
	arg_1_0._gobtnclick = gohelper.findChild(arg_1_0.viewGO, "btn_click")
	arg_1_0._gotag = gohelper.findChild(arg_1_0.viewGO, "tag")
	arg_1_0._gotype1 = gohelper.findChild(arg_1_0.viewGO, "tag/#go_type1")
	arg_1_0._imageType1 = gohelper.findChildImage(arg_1_0.viewGO, "tag/#go_type1")
	arg_1_0._gotype2 = gohelper.findChild(arg_1_0.viewGO, "tag/#go_type2")
	arg_1_0._gotype3 = gohelper.findChild(arg_1_0.viewGO, "tag/#go_type3")
	arg_1_0._gotype4 = gohelper.findChild(arg_1_0.viewGO, "tag/#go_type4")
	arg_1_0._goindexLimit = gohelper.findChild(arg_1_0.viewGO, "#go_indexLimit")
	arg_1_0._golimit1 = gohelper.findChild(arg_1_0.viewGO, "#go_indexLimit/#go_limit1")
	arg_1_0._golimit2 = gohelper.findChild(arg_1_0.viewGO, "#go_indexLimit/#go_limit2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

var_0_0.MaxRare = 6
var_0_0.MaxLimitCount = 2

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._rareGoMap = {}

	for iter_2_0 = 1, var_0_0.MaxRare do
		arg_2_0._rareGoMap[iter_2_0] = arg_2_0:createRareMap(arg_2_0["_gorare" .. tostring(iter_2_0)])
	end

	arg_2_0._darkMaskColor = "#ffffff"
	arg_2_0._showTag = false
	arg_2_0._showProbability = false
	arg_2_0._showNewFlag = false
	arg_2_0._showNewFlag2 = false
	arg_2_0._showIndexLimit = false
end

function var_0_0.onDestroy(arg_3_0)
	arg_3_0:disposeUI()
end

function var_0_0.checkInitBtnClick(arg_4_0)
	if not arg_4_0._btnclick then
		arg_4_0._btnclick = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "btn_click")

		arg_4_0._btnclick:AddClickListener(arg_4_0.onClickCall, arg_4_0)
	end
end

function var_0_0.checkInitLongPress(arg_5_0)
	if not arg_5_0._btnClickLongPrees then
		arg_5_0._btnClickLongPrees = SLFramework.UGUI.UILongPressListener.Get(arg_5_0._gobtnclick)

		arg_5_0._btnClickLongPrees:AddLongPressListener(arg_5_0.onLongPressCall, arg_5_0)
	end
end

function var_0_0.disposeUI(arg_6_0)
	if not arg_6_0._isDisposed then
		for iter_6_0, iter_6_1 in pairs(arg_6_0._rareGoMap) do
			if not gohelper.isNil(iter_6_1.simageIcon) then
				iter_6_1.simageIcon:UnLoadImage()
			end

			if not gohelper.isNil(iter_6_1.simageSignature) then
				iter_6_1.simageSignature:UnLoadImage()
			end
		end

		if arg_6_0._btnClickLongPrees then
			arg_6_0._btnClickLongPrees:RemoveLongPressListener()

			arg_6_0._btnClickLongPrees = nil
		end

		if arg_6_0._btnclick then
			arg_6_0._btnclick:RemoveClickListener()

			arg_6_0._btnclick = nil
		end

		arg_6_0._isDisposed = true
	end
end

function var_0_0.updateData(arg_7_0, arg_7_1)
	arg_7_0.itemId = arg_7_1

	arg_7_0:refreshUI()
end

function var_0_0.createRareMap(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getUserDataTb_()

	var_8_0.go = arg_8_1
	var_8_0.goSelfChoice = gohelper.findChild(arg_8_1, "#go_rare6")
	var_8_0.imageCareer = gohelper.findChildImage(arg_8_1, "image_career")
	var_8_0.simageIcon = gohelper.findChildSingleImage(arg_8_1, "mask/image_icon")
	var_8_0.simageSignature = gohelper.findChildSingleImage(arg_8_1, "simage_signature")
	var_8_0.imageIcon = gohelper.findChildImage(arg_8_1, "mask/image_icon")
	var_8_0.imageSignature = gohelper.findChildImage(arg_8_1, "simage_signature")
	var_8_0.imageBg = gohelper.findChildImage(arg_8_1, "bg")
	var_8_0.goSelfChoice = gohelper.findChild(arg_8_1, "go_selfchoice")
	var_8_0.imageDecorate = gohelper.findChildImage(arg_8_1, "icon")

	return var_8_0
end

function var_0_0.refreshUI(arg_9_0)
	if not arg_9_0.itemId then
		return
	end

	local var_9_0 = Season123Config.instance:getSeasonEquipCo(arg_9_0.itemId)

	arg_9_0._goCurSelected = nil
	arg_9_0._cfg = var_9_0

	if not arg_9_0._cfg then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._rareGoMap) do
		local var_9_1 = (var_9_0.rare == 4 and var_9_0.isMain == Activity123Enum.isMainRole and 6 or var_9_0.rare) == iter_9_0

		gohelper.setActive(iter_9_1.go, var_9_1)

		if var_9_1 then
			arg_9_0._curSelectedItem = iter_9_1
		end
	end

	arg_9_0:refreshSelfChoice()
	arg_9_0:refreshIcon()
	arg_9_0:refreshFlag()
	arg_9_0:refreshIndexLimit()
end

function var_0_0.refreshSelfChoice(arg_10_0)
	if arg_10_0._curSelectedItem then
		gohelper.setActive(arg_10_0._curSelectedItem.goSelfChoice, Season123Config.instance:getEquipIsOptional(arg_10_0.itemId))
	end
end

function var_0_0.refreshIcon(arg_11_0)
	if arg_11_0._curSelectedItem then
		local var_11_0 = arg_11_0._curSelectedItem

		gohelper.setActive(var_11_0.goSelfChoice, arg_11_0._cfg.isOptional == 1)

		if not string.nilorempty(arg_11_0._cfg.careerIcon) then
			gohelper.setActive(var_11_0.imageCareer, true)
			UISpriteSetMgr.instance:setCommonSprite(var_11_0.imageCareer, arg_11_0._cfg.careerIcon)
			SLFramework.UGUI.GuiHelper.SetColor(var_11_0.imageCareer, arg_11_0._darkMaskColor)
		else
			gohelper.setActive(var_11_0.imageCareer, false)
		end

		if not string.nilorempty(arg_11_0._cfg.icon) and var_11_0.simageIcon then
			gohelper.setActive(var_11_0.simageIcon, true)
			var_11_0.simageIcon:LoadImage(ResUrl.getSeasonCelebrityCard(arg_11_0._cfg.icon), arg_11_0.handleIconLoaded, arg_11_0)
			SLFramework.UGUI.GuiHelper.SetColor(var_11_0.imageIcon, arg_11_0._darkMaskColor)
		else
			gohelper.setActive(var_11_0.simageIcon, false)
		end

		if arg_11_0._cfg.isMain == Activity123Enum.isMainRole and arg_11_0._cfg.rare == 4 then
			gohelper.setActive(var_11_0.simageSignature, false)
		elseif not string.nilorempty(arg_11_0._cfg.signIcon) and var_11_0.simageSignature then
			gohelper.setActive(var_11_0.simageSignature, true)
			var_11_0.simageSignature:LoadImage(ResUrl.getSignature(arg_11_0._cfg.signIcon, "characterget"))
		end

		if var_11_0.imageSignature then
			SLFramework.UGUI.GuiHelper.SetColor(var_11_0.imageSignature, arg_11_0._darkMaskColor)
		end

		if var_11_0.imageDecorate then
			SLFramework.UGUI.GuiHelper.SetColor(var_11_0.imageDecorate, arg_11_0._darkMaskColor)
		end

		SLFramework.UGUI.GuiHelper.SetColor(var_11_0.imageBg, arg_11_0._darkMaskColor)
		Season123EquipMetaUtils.applyIconOffset(arg_11_0.itemId, var_11_0.imageIcon, var_11_0.imageSignature)
	end
end

function var_0_0.refreshFlag(arg_12_0)
	if not arg_12_0.itemId then
		return
	end

	local var_12_0 = arg_12_0._showProbability and arg_12_0._cfg.isOptional ~= 1
	local var_12_1 = arg_12_0._showTag and arg_12_0._cfg.isOptional == 1
	local var_12_2 = arg_12_0._showNewFlag2 and not var_12_1
	local var_12_3 = arg_12_0._showNewFlag and not var_12_1

	gohelper.setActive(arg_12_0._gotag, var_12_0 or var_12_1 or var_12_2 or var_12_3)
	gohelper.setActive(arg_12_0._gotype1, var_12_0)
	gohelper.setActive(arg_12_0._gotype2, var_12_1)
	gohelper.setActive(arg_12_0._gotype3, var_12_2)
	gohelper.setActive(arg_12_0._gotype4, var_12_3)
end

function var_0_0.refreshIndexLimit(arg_13_0)
	gohelper.setActive(arg_13_0._goindexLimit, arg_13_0._showIndexLimit and not string.nilorempty(arg_13_0._cfg.indexLimit))

	if not arg_13_0._showIndexLimit or string.nilorempty(arg_13_0._cfg.indexLimit) then
		return
	end

	local var_13_0 = string.split(arg_13_0._cfg.indexLimit, "#")

	for iter_13_0 = 1, #var_13_0 do
		gohelper.setActive(arg_13_0["_golimit" .. iter_13_0], true)

		gohelper.findChildText(arg_13_0["_golimit" .. iter_13_0], "txt_limit" .. iter_13_0).text = var_13_0[iter_13_0]
	end

	gohelper.setActive(arg_13_0._golimit2, #var_13_0 == var_0_0.MaxLimitCount)
end

function var_0_0.setIndexLimitShowState(arg_14_0, arg_14_1)
	arg_14_0._showIndexLimit = arg_14_1

	arg_14_0:refreshIndexLimit()
end

function var_0_0.setFlagUIPos(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_1 or not arg_15_2 then
		return
	end

	recthelper.setAnchor(arg_15_0._gotag.transform, arg_15_1, arg_15_2)
end

local var_0_1 = 2.3

function var_0_0.setFlagUIScale(arg_16_0, arg_16_1)
	arg_16_1 = arg_16_1 or var_0_1

	transformhelper.setLocalScale(arg_16_0._gotag.transform, arg_16_1, arg_16_1, arg_16_1)
end

function var_0_0.handleIconLoaded(arg_17_0)
	if not arg_17_0._isDisposed then
		local var_17_0 = arg_17_0._curSelectedItem

		if var_17_0 then
			gohelper.setActive(var_17_0.simageIcon, false)
			gohelper.setActive(var_17_0.simageIcon, true)
		end
	end
end

function var_0_0.setColorDark(arg_18_0, arg_18_1)
	arg_18_0._darkMaskColor = arg_18_1 and "#7b7b7b" or "#ffffff"

	arg_18_0:refreshIcon()
end

function var_0_0.setShowTag(arg_19_0, arg_19_1)
	arg_19_0._showTag = arg_19_1

	arg_19_0:refreshFlag()
end

function var_0_0.setShowProbability(arg_20_0, arg_20_1)
	arg_20_0._showProbability = arg_20_1

	arg_20_0:refreshFlag()
end

function var_0_0.setShowNewFlag(arg_21_0, arg_21_1)
	arg_21_0._showNewFlag = arg_21_1

	arg_21_0:refreshFlag()
end

function var_0_0.setShowNewFlag2(arg_22_0, arg_22_1)
	arg_22_0._showNewFlag2 = arg_22_1

	arg_22_0:refreshFlag()
end

function var_0_0.setClickCall(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_0._clickCallback = arg_23_1
	arg_23_0._clickCallbackObj = arg_23_2
	arg_23_0._clickParam = arg_23_3

	if arg_23_1 then
		arg_23_0:checkInitBtnClick()
	end
end

function var_0_0.setLongPressCall(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_0._longPressCallback = arg_24_1
	arg_24_0._longPressCallbackObj = arg_24_2
	arg_24_0._longPressParam = arg_24_3

	if arg_24_1 then
		arg_24_0:checkInitLongPress()
	end
end

function var_0_0.onClickCall(arg_25_0)
	if arg_25_0._clickCallback then
		arg_25_0._clickCallback(arg_25_0._clickCallbackObj, arg_25_0._clickParam)
	end
end

function var_0_0.onLongPressCall(arg_26_0)
	if arg_26_0._longPressCallback then
		arg_26_0._longPressCallback(arg_26_0._longPressCallbackObj, arg_26_0._longPressParam)
	end
end

return var_0_0
