module("modules.logic.summon.view.SummonMainCategoryItem", package.seeall)

local var_0_0 = class("SummonMainCategoryItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnself = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_self")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnself:AddClickListener(arg_2_0._btnselfOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnself:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._imagenormalquan = gohelper.findChildImage(arg_4_0.viewGO, "#go_normal/#go_normaltips/quan/#circle")
	arg_4_0._imageselectquan = gohelper.findChildImage(arg_4_0.viewGO, "#go_select/#go_selecttips/quan/#circle")
	arg_4_0._animRoot = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._goSelectRole = gohelper.findChild(arg_4_0.viewGO, "#go_select_role")
	arg_4_0._goUnSelectRole = gohelper.findChild(arg_4_0.viewGO, "#go_normal_role")
	arg_4_0._goSelectEquip = gohelper.findChild(arg_4_0.viewGO, "#go_select_equip")
	arg_4_0._goUnSelectEquip = gohelper.findChild(arg_4_0.viewGO, "#go_normal_equip")
	arg_4_0.tipsList = arg_4_0:getUserDataTb_()
end

function var_0_0.onDestroyView(arg_5_0)
	if not arg_5_0._isDisposed then
		arg_5_0._simageiconnormal:UnLoadImage()
		arg_5_0._simageiconselect:UnLoadImage()
		arg_5_0._simageiconnormalmask:UnLoadImage()
		arg_5_0._simageline:UnLoadImage()
		arg_5_0:removeEvents()
		arg_5_0:customRemoveEvent()

		arg_5_0._isDisposed = true
	end
end

function var_0_0.onDestroy(arg_6_0)
	arg_6_0:onDestroyView()
end

function var_0_0.customAddEvent(arg_7_0)
	arg_7_0:addEventCb(SummonController.instance, SummonEvent.onSummonTabSet, arg_7_0._refreshSelected, arg_7_0)
	arg_7_0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_7_0._refreshNewFlag, arg_7_0)
end

function var_0_0.customRemoveEvent(arg_8_0)
	arg_8_0:removeEventCb(SummonController.instance, SummonEvent.onSummonTabSet, arg_8_0._refreshSelected, arg_8_0)
	arg_8_0:removeEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_8_0._refreshNewFlag, arg_8_0)
end

function var_0_0._btnselfOnClick(arg_9_0)
	if not arg_9_0._mo then
		return
	end

	local var_9_0 = arg_9_0._mo.originConf.id

	if SummonMainModel.instance:getCurId() ~= var_9_0 then
		SummonMainModel.instance:trySetSelectPoolId(var_9_0)

		if SummonMainModel.instance.flagModel then
			SummonMainModel.instance.flagModel:cleanFlag(var_9_0)
		end

		SummonController.instance:dispatchEvent(SummonEvent.onSummonTabSet)
	end
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	if arg_10_0._mo ~= nil or not SummonMainCategoryListModel.instance:canPlayEnterAnim() then
		arg_10_0._animRoot:Play("summonmaincategoryitem_in", 0, 1)

		arg_10_0._animRoot.speed = 0
	end

	arg_10_0._mo = arg_10_1

	arg_10_0:_refreshUI()
end

function var_0_0._refreshUI(arg_11_0)
	if arg_11_0._mo then
		local var_11_0 = arg_11_0._mo.originConf
		local var_11_1 = SummonMainModel.instance:getCurId() == var_11_0.id

		arg_11_0:_initCurrentComponents()
		arg_11_0:_refreshFree(var_11_1)
		arg_11_0:_refreshSelected()
		arg_11_0:_refreshFlag(var_11_1)
		arg_11_0:_refreshNewFlag()
		arg_11_0:_refreshTipsPosition(var_11_1)
		arg_11_0:_refreshSpecVfx(var_11_1)
	end
end

local var_0_1 = {
	[11151] = true,
	[12111] = true,
	[12131] = true,
	[11111] = true,
	[10121] = true,
	[10111] = true,
	[11141] = true,
	[11121] = true,
	[12121] = true,
	[11131] = true,
	[12141] = true,
	[12151] = true
}

function var_0_0._initCurrentComponents(arg_12_0)
	local var_12_0 = arg_12_0._mo.originConf
	local var_12_1 = SummonMainModel.instance.getResultTypeById(var_12_0.id)

	if SummonEnum.ResultType.Equip == var_12_1 then
		arg_12_0._goSelected = arg_12_0._goSelectEquip
		arg_12_0._goUnselected = arg_12_0._goUnSelectEquip

		gohelper.setActive(arg_12_0._goSelectRole, false)
		gohelper.setActive(arg_12_0._goUnSelectRole, false)
	else
		arg_12_0._goSelected = arg_12_0._goSelectRole
		arg_12_0._goUnselected = arg_12_0._goUnSelectRole

		gohelper.setActive(arg_12_0._goSelectEquip, false)
		gohelper.setActive(arg_12_0._goUnSelectEquip, false)
	end

	arg_12_0._simageiconselect = gohelper.findChildSingleImage(arg_12_0._goSelected, "#simage_icon_select")
	arg_12_0._simageiconnormal = gohelper.findChildSingleImage(arg_12_0._goUnselected, "#simage_icon_normal")
	arg_12_0._simageline = gohelper.findChildSingleImage(arg_12_0._goSelected, "#simage_icon_select/#simage_line")
	arg_12_0._simageiconnormalmask = gohelper.findChildSingleImage(arg_12_0._goUnselected, "#simage_icon_normalmask")
	arg_12_0._simageiconnormalmaskGo = arg_12_0._simageiconnormalmask.gameObject
	arg_12_0._goUnselectFlag = gohelper.findChild(arg_12_0._goUnselected, "#go_normaltips")
	arg_12_0._imagenormalquan = gohelper.findChildImage(arg_12_0._goUnselectFlag, "quan/#circle")
	arg_12_0._imagenormalbg = gohelper.findChildImage(arg_12_0._goUnselectFlag, "#image_normalbg")
	arg_12_0._txtnormaltips = gohelper.findChildText(arg_12_0._goUnselectFlag, "#txt_normaltips")
	arg_12_0._txtname = gohelper.findChildText(arg_12_0._goUnselected, "#txt_name")
	arg_12_0._txtnameen = gohelper.findChildText(arg_12_0._goUnselected, "#txt_nameen")
	arg_12_0._goSelectFlag = gohelper.findChild(arg_12_0._goSelected, "#go_selecttips")
	arg_12_0._imageselectquan = gohelper.findChildImage(arg_12_0._goSelectFlag, "quan/#circle")
	arg_12_0._imageselectbg = gohelper.findChildImage(arg_12_0._goSelectFlag, "#image_selectbg")
	arg_12_0._txtselecttips = gohelper.findChildText(arg_12_0._goSelectFlag, "#txt_selecttips")
	arg_12_0._txtnameselect = gohelper.findChildText(arg_12_0._goSelected, "#txt_name")
	arg_12_0._txtnameenselect = gohelper.findChildText(arg_12_0._goSelected, "#txt_nameen")
	arg_12_0._imagenew = gohelper.findChildImage(arg_12_0._goUnselected, "#image_new")
	arg_12_0._imagereddot = gohelper.findChildImage(arg_12_0._goUnselected, "#image_reddot")
	arg_12_0._imagereddotselect = gohelper.findChildImage(arg_12_0._goSelected, "#image_reddot")
	arg_12_0._vfxEffect5 = gohelper.findChild(arg_12_0.viewGO, "#go_select_role/effect5")

	arg_12_0:_refreshName()
	arg_12_0:_refreshBannerLine()
end

function var_0_0._refreshSelected_overseas(arg_13_0)
	if arg_13_0._mo then
		local var_13_0 = arg_13_0._mo.originConf
		local var_13_1 = SummonMainModel.instance:getCurId() == var_13_0.id

		arg_13_0._goSelected:SetActive(var_13_1)
		arg_13_0._goUnselected:SetActive(not var_13_1)

		if not string.nilorempty(var_13_0.banner) then
			local var_13_2 = var_13_0.banner
			local var_13_3 = arg_13_0:_isWithoutTxt(var_13_0.id)

			if var_13_3 then
				if var_13_1 then
					var_13_2 = var_13_2 .. "_1"
				else
					var_13_2 = var_13_2 .. "_0"
				end
			end

			local var_13_4 = ResUrl.getSummonBanner(var_13_2)

			arg_13_0._simageiconnormal:LoadImage(var_13_4)
			arg_13_0._simageiconselect:LoadImage(var_13_4)
			arg_13_0._simageiconnormalmask:LoadImage(var_13_4)
			gohelper.setActive(arg_13_0._simageiconnormalmaskGo, not var_13_3)
		end
	end
end

function var_0_0._refreshFlag(arg_14_0, arg_14_1)
	if arg_14_1 then
		arg_14_0:_refreshSingleFlag(arg_14_0._goSelectFlag, arg_14_0._imageselectquan, arg_14_0._imageselectbg, arg_14_0._txtselecttips, arg_14_1)
	else
		arg_14_0:_refreshSingleFlag(arg_14_0._goUnselectFlag, arg_14_0._imagenormalquan, arg_14_0._imagenormalbg, arg_14_0._txtnormaltips, arg_14_1)
	end
end

var_0_0._BannerFlag_DataDict = {
	[SummonEnum.BannerFlagType.Newbie] = {
		langKey = "p_summonmaincategoryitem_invite",
		imageBg = "bg_lx"
	},
	[SummonEnum.BannerFlagType.Activity] = {
		langKey = "summon_category_flag_activity",
		imageBg = "bg123123"
	},
	[SummonEnum.BannerFlagType.Limit] = {
		imageBg = "v1a6_quniang_summon_tag",
		langKey = "summon_limit_banner_flag",
		isTxtCororFormat = true
	},
	[SummonEnum.BannerFlagType.Reprint] = {
		imageBg = "v1a6_quniang_summon_tag",
		langKey = "summon_reprint_banner_flag",
		isTxtCororFormat = true
	},
	[SummonEnum.BannerFlagType.Cobrand] = {
		langKey = "summon_cobrand_banner_flag",
		imageBg = "bg_lx"
	}
}

function var_0_0._refreshSingleFlag(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	local var_15_0 = arg_15_0._mo.originConf
	local var_15_1 = SummonMainModel.instance:getPoolServerMO(var_15_0.id)
	local var_15_2 = false
	local var_15_3 = 0.5

	if var_15_1 ~= nil and var_0_0._BannerFlag_DataDict[var_15_0.bannerFlag] then
		var_15_2 = true

		local var_15_4 = var_0_0._BannerFlag_DataDict[var_15_0.bannerFlag]
		local var_15_5 = luaLang(var_15_4.langKey)

		UISpriteSetMgr.instance:setSummonSprite(arg_15_3, var_15_4.imageBg, true)
		SLFramework.UGUI.GuiHelper.SetColor(arg_15_2, "#808080")

		if var_15_4.isTxtCororFormat then
			if arg_15_5 then
				var_15_5 = string.format("<color=#fefefe>%s</color>", var_15_5)
			else
				var_15_5 = string.format("<color=#c5c6c7>%s</color>", var_15_5)
				var_15_3 = 1
			end
		end

		arg_15_4.text = var_15_5
	else
		arg_15_4.text = ""
	end

	if not arg_15_5 then
		ZProj.UGUIHelper.SetColorAlpha(arg_15_4, var_15_3)
	end

	if var_15_2 then
		table.insert(arg_15_0.tipsList, arg_15_1)
	end

	gohelper.setActive(arg_15_1, var_15_2)
end

function var_0_0._refreshNewFlag(arg_16_0)
	local var_16_0 = false
	local var_16_1 = arg_16_0._mo.originConf

	if var_16_1 and arg_16_0._imagenew then
		local var_16_2 = SummonMainModel.instance:categoryHasNew(var_16_1.id)

		gohelper.setActive(arg_16_0._imagenew, var_16_2)

		var_16_0 = var_16_2
	end

	local var_16_3 = SummonMainModel.instance:getPoolServerMO(var_16_1.id)
	local var_16_4 = false

	if var_16_3 then
		var_16_4 = SummonMainModel.needShowReddot(var_16_3)
	end

	if var_16_0 then
		gohelper.setActive(arg_16_0._imagereddot, false)
	else
		gohelper.setActive(arg_16_0._imagereddot, var_16_4)
	end

	gohelper.setActive(arg_16_0._imagereddotselect, var_16_4)
end

function var_0_0._refreshFree(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._mo.originConf
	local var_17_1 = arg_17_1 and arg_17_0._goSelected or arg_17_0._goUnselected

	arg_17_0._gofreetips = gohelper.findChild(var_17_1, "#go_freetips")

	local var_17_2 = SummonMainModel.instance:getPoolServerMO(var_17_0.id)

	if var_17_2 and var_17_2.haveFree then
		table.insert(arg_17_0.tipsList, arg_17_0._gofreetips)
		gohelper.setActive(arg_17_0._gofreetips, true)
	else
		gohelper.setActive(arg_17_0._gofreetips, false)
	end
end

var_0_0.Tips_Selected_StartY = 45
var_0_0.Tips_NoSelected_StartY = 35
var_0_0.Tips_IntervalY = -35

function var_0_0._refreshTipsPosition(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1 and var_0_0.Tips_Selected_StartY or var_0_0.Tips_NoSelected_StartY
	local var_18_1 = #arg_18_0.tipsList

	for iter_18_0 = 1, var_18_1 do
		local var_18_2 = arg_18_0.tipsList[iter_18_0]

		recthelper.setAnchorY(var_18_2.transform, var_18_0 + var_0_0.Tips_IntervalY * (iter_18_0 - 1))

		arg_18_0.tipsList[iter_18_0] = nil
	end
end

function var_0_0._refreshSpecVfx(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._mo.originConf

	if SummonEnum.PoolId.QuNiang == var_19_0.id then
		gohelper.setActive(arg_19_0._vfxEffect5, true)
	else
		gohelper.setActive(arg_19_0._vfxEffect5, false)
	end
end

function var_0_0.getData(arg_20_0)
	return arg_20_0._mo
end

function var_0_0.cleanData(arg_21_0)
	arg_21_0._mo = nil
end

function var_0_0._refreshName(arg_22_0)
	local var_22_0 = arg_22_0._mo.originConf

	if arg_22_0:_isWithoutTxt(var_22_0.id) then
		arg_22_0._txtnameselect.text = ""
		arg_22_0._txtname.text = ""
		arg_22_0._txtnameen.text = ""
		arg_22_0._txtnameenselect.text = ""
	else
		arg_22_0._txtnameselect.text = var_22_0.nameCn
		arg_22_0._txtname.text = var_22_0.nameCn
		arg_22_0._txtnameen.text = var_22_0.ornamentName or ""
		arg_22_0._txtnameenselect.text = var_22_0.ornamentName or ""

		local var_22_1 = var_22_0.nameUnderlayColor
		local var_22_2
		local var_22_3 = "#FFFFFF"
		local var_22_4 = 1

		if not string.nilorempty(var_22_1) then
			local var_22_5 = string.split(var_22_1, "|")

			var_22_2 = GameUtil.parseColor(var_22_5[1] or "#000000")
			var_22_2.a = tonumber(var_22_5[2]) or 0
			var_22_3 = var_22_5[3] or "#F7F5EF"
			var_22_4 = tonumber(var_22_5[4]) or 1
		end

		arg_22_0:_addUnderlayColor(arg_22_0._txtnameselect, var_22_2)
		arg_22_0:_addUnderlayColor(arg_22_0._txtname, var_22_2)
		arg_22_0:_addNameCnColor(arg_22_0._txtnameselect, var_22_3, var_22_4)
		arg_22_0:_addNameCnColor(arg_22_0._txtname, var_22_3, var_22_4)
	end
end

function var_0_0._refreshBannerLine(arg_23_0)
	local var_23_0 = arg_23_0._mo.originConf

	if not arg_23_0:_isWithoutTxt(var_23_0.id) then
		local var_23_1 = var_23_0.bannerLineName

		if not string.nilorempty(var_23_1) then
			arg_23_0._simageline:LoadImage(ResUrl.getSummonBannerLine(var_23_1))
		else
			arg_23_0._simageline:UnLoadImage()
		end
	end
end

function var_0_0._addUnderlayColor(arg_24_0, arg_24_1, arg_24_2)
	if not arg_24_1 then
		return
	end

	local var_24_0 = arg_24_1.fontMaterial

	if not var_24_0 then
		return
	end

	if not arg_24_2 then
		var_24_0:DisableKeyword("UNDERLAY_ON")

		return
	end

	var_24_0:EnableKeyword("UNDERLAY_ON")
	var_24_0:SetColor("_UnderlayColor", arg_24_2)
	var_24_0:SetFloat("_UnderlayOffsetX", 0)
	var_24_0:SetFloat("_UnderlayOffsetY", 0)
	var_24_0:SetFloat("_UnderlayDilate", 0.3)
	var_24_0:SetFloat("_UnderlaySoftness", 1)
end

function var_0_0._addNameCnColor(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if not arg_25_1 then
		return
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_25_1, arg_25_2)
	ZProj.UGUIHelper.SetColorAlpha(arg_25_1, arg_25_3)
end

function var_0_0._isWithoutTxt(arg_26_0, arg_26_1)
	return var_0_1[arg_26_1]
end

function var_0_0._refreshSelected_local(arg_27_0)
	if not arg_27_0._mo then
		return
	end

	local var_27_0 = arg_27_0._mo.originConf
	local var_27_1 = SummonMainModel.instance:getCurId() == var_27_0.id

	arg_27_0._goSelected:SetActive(var_27_1)
	arg_27_0._goUnselected:SetActive(not var_27_1)

	if not string.nilorempty(var_27_0.banner) then
		local var_27_2 = var_27_0.banner
		local var_27_3 = ResUrl.getSummonBanner(var_27_2)

		arg_27_0._simageiconnormal:LoadImage(var_27_3)
		arg_27_0._simageiconselect:LoadImage(var_27_3)
		arg_27_0._simageiconnormalmask:LoadImage(var_27_3)
	end
end

function var_0_0._refreshSelected(arg_28_0)
	arg_28_0:_refreshSelected_overseas()
end

return var_0_0
