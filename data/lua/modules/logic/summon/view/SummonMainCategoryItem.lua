module("modules.logic.summon.view.SummonMainCategoryItem", package.seeall)

slot0 = class("SummonMainCategoryItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._btnself = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_self")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnself:AddClickListener(slot0._btnselfOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnself:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._imagenormalquan = gohelper.findChildImage(slot0.viewGO, "#go_normal/#go_normaltips/quan/#circle")
	slot0._imageselectquan = gohelper.findChildImage(slot0.viewGO, "#go_select/#go_selecttips/quan/#circle")
	slot0._animRoot = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._goSelectRole = gohelper.findChild(slot0.viewGO, "#go_select_role")
	slot0._goUnSelectRole = gohelper.findChild(slot0.viewGO, "#go_normal_role")
	slot0._goSelectEquip = gohelper.findChild(slot0.viewGO, "#go_select_equip")
	slot0._goUnSelectEquip = gohelper.findChild(slot0.viewGO, "#go_normal_equip")
	slot0.tipsList = slot0:getUserDataTb_()
end

function slot0.onDestroyView(slot0)
	if not slot0._isDisposed then
		slot0._simageiconnormal:UnLoadImage()
		slot0._simageiconselect:UnLoadImage()
		slot0._simageiconnormalmask:UnLoadImage()
		slot0._simageline:UnLoadImage()
		slot0:removeEvents()
		slot0:customRemoveEvent()

		slot0._isDisposed = true
	end
end

function slot0.onDestroy(slot0)
	slot0:onDestroyView()
end

function slot0.customAddEvent(slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonTabSet, slot0._refreshSelected, slot0)
end

function slot0.customRemoveEvent(slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonTabSet, slot0._refreshSelected, slot0)
end

function slot0._btnselfOnClick(slot0)
	if not slot0._mo then
		return
	end

	if SummonMainModel.instance:getCurId() ~= slot0._mo.originConf.id then
		SummonMainModel.instance:trySetSelectPoolId(slot1)

		if SummonMainModel.instance.flagModel then
			SummonMainModel.instance.flagModel:cleanFlag(slot1)
		end

		SummonController.instance:dispatchEvent(SummonEvent.onSummonTabSet)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	if slot0._mo ~= nil or not SummonMainCategoryListModel.instance:canPlayEnterAnim() then
		slot0._animRoot:Play("summonmaincategoryitem_in", 0, 1)

		slot0._animRoot.speed = 0
	end

	slot0._mo = slot1

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	if slot0._mo then
		slot2 = SummonMainModel.instance:getCurId() == slot0._mo.originConf.id

		slot0:_initCurrentComponents()
		slot0:_refreshFree(slot2)
		slot0:_refreshSelected()
		slot0:_refreshFlag(slot2)
		slot0:_refreshNewFlag()
		slot0:_refreshTipsPosition(slot2)
		slot0:_refreshSpecVfx(slot2)
	end
end

slot1 = {
	[11151.0] = true,
	[12111.0] = true,
	[12131.0] = true,
	[11111.0] = true,
	[10121.0] = true,
	[10111.0] = true,
	[11141.0] = true,
	[11121.0] = true,
	[12121.0] = true,
	[11131.0] = true,
	[12141.0] = true,
	[12151.0] = true
}

function slot0._initCurrentComponents(slot0)
	if SummonEnum.ResultType.Equip == SummonMainModel.instance.getResultTypeById(slot0._mo.originConf.id) then
		slot0._goSelected = slot0._goSelectEquip
		slot0._goUnselected = slot0._goUnSelectEquip

		gohelper.setActive(slot0._goSelectRole, false)
		gohelper.setActive(slot0._goUnSelectRole, false)
	else
		slot0._goSelected = slot0._goSelectRole
		slot0._goUnselected = slot0._goUnSelectRole

		gohelper.setActive(slot0._goSelectEquip, false)
		gohelper.setActive(slot0._goUnSelectEquip, false)
	end

	slot0._simageiconselect = gohelper.findChildSingleImage(slot0._goSelected, "#simage_icon_select")
	slot0._simageiconnormal = gohelper.findChildSingleImage(slot0._goUnselected, "#simage_icon_normal")
	slot0._simageline = gohelper.findChildSingleImage(slot0._goSelected, "#simage_icon_select/#simage_line")
	slot0._simageiconnormalmask = gohelper.findChildSingleImage(slot0._goUnselected, "#simage_icon_normalmask")
	slot0._simageiconnormalmaskGo = slot0._simageiconnormalmask.gameObject
	slot0._goUnselectFlag = gohelper.findChild(slot0._goUnselected, "#go_normaltips")
	slot0._imagenormalquan = gohelper.findChildImage(slot0._goUnselectFlag, "quan/#circle")
	slot0._imagenormalbg = gohelper.findChildImage(slot0._goUnselectFlag, "#image_normalbg")
	slot0._txtnormaltips = gohelper.findChildText(slot0._goUnselectFlag, "#txt_normaltips")
	slot0._txtname = gohelper.findChildText(slot0._goUnselected, "#txt_name")
	slot0._txtnameen = gohelper.findChildText(slot0._goUnselected, "#txt_nameen")
	slot0._goSelectFlag = gohelper.findChild(slot0._goSelected, "#go_selecttips")
	slot0._imageselectquan = gohelper.findChildImage(slot0._goSelectFlag, "quan/#circle")
	slot0._imageselectbg = gohelper.findChildImage(slot0._goSelectFlag, "#image_selectbg")
	slot0._txtselecttips = gohelper.findChildText(slot0._goSelectFlag, "#txt_selecttips")
	slot0._txtnameselect = gohelper.findChildText(slot0._goSelected, "#txt_name")
	slot0._txtnameenselect = gohelper.findChildText(slot0._goSelected, "#txt_nameen")
	slot0._imagenew = gohelper.findChildImage(slot0._goUnselected, "#image_new")
	slot0._imagereddot = gohelper.findChildImage(slot0._goUnselected, "#image_reddot")
	slot0._imagereddotselect = gohelper.findChildImage(slot0._goSelected, "#image_reddot")
	slot0._vfxEffect5 = gohelper.findChild(slot0.viewGO, "#go_select_role/effect5")

	slot0:_refreshName()
	slot0:_refreshBannerLine()
end

function slot0._refreshSelected_overseas(slot0)
	if slot0._mo then
		slot2 = SummonMainModel.instance:getCurId() == slot0._mo.originConf.id

		slot0._goSelected:SetActive(slot2)
		slot0._goUnselected:SetActive(not slot2)

		if not string.nilorempty(slot1.banner) then
			slot3 = slot1.banner

			if slot0:_isWithoutTxt(slot1.id) then
				slot3 = slot2 and slot3 .. "_1" or slot3 .. "_0"
			end

			slot5 = ResUrl.getSummonBanner(slot3)

			slot0._simageiconnormal:LoadImage(slot5)
			slot0._simageiconselect:LoadImage(slot5)
			slot0._simageiconnormalmask:LoadImage(slot5)
			gohelper.setActive(slot0._simageiconnormalmaskGo, not slot4)
		end
	end
end

function slot0._refreshFlag(slot0, slot1)
	if slot1 then
		slot0:_refreshSingleFlag(slot0._goSelectFlag, slot0._imageselectquan, slot0._imageselectbg, slot0._txtselecttips, slot1)
	else
		slot0:_refreshSingleFlag(slot0._goUnselectFlag, slot0._imagenormalquan, slot0._imagenormalbg, slot0._txtnormaltips, slot1)
	end
end

function slot0._refreshSingleFlag(slot0, slot1, slot2, slot3, slot4, slot5)
	slot8 = false
	slot9 = 0.5

	if SummonMainModel.instance:getPoolServerMO(slot0._mo.originConf.id) ~= nil and slot6.bannerFlag == SummonEnum.BannerFlagType.Newbie then
		slot8 = true
		slot4.text = luaLang("p_summonmaincategoryitem_invite")

		UISpriteSetMgr.instance:setSummonSprite(slot3, "bg_lx", true)
		SLFramework.UGUI.GuiHelper.SetColor(slot2, "#808080")
	elseif slot7 ~= nil and slot6.bannerFlag == SummonEnum.BannerFlagType.Activity then
		slot8 = true
		slot4.text = luaLang("summon_category_flag_activity")

		UISpriteSetMgr.instance:setSummonSprite(slot3, "bg123123", true)
		SLFramework.UGUI.GuiHelper.SetColor(slot2, "#808080")
	elseif slot7 ~= nil and (slot6.bannerFlag == SummonEnum.BannerFlagType.Limit or slot6.bannerFlag == SummonEnum.BannerFlagType.Reprint) then
		slot8 = true

		if slot5 then
			slot4.text = string.format("<color=#fefefe>%s</color>", slot6.bannerFlag == SummonEnum.BannerFlagType.Limit and luaLang("summon_limit_banner_flag") or luaLang("summon_reprint_banner_flag"))
		else
			slot4.text = string.format("<color=#c5c6c7>%s</color>", slot10)
			slot9 = 1
		end

		UISpriteSetMgr.instance:setSummonSprite(slot3, "v1a6_quniang_summon_tag", true)
		SLFramework.UGUI.GuiHelper.SetColor(slot2, "#808080")
	else
		slot4.text = ""
	end

	if not slot5 then
		ZProj.UGUIHelper.SetColorAlpha(slot4, slot9)
	end

	if slot8 then
		table.insert(slot0.tipsList, slot1)
	end

	gohelper.setActive(slot1, slot8)
end

function slot0._refreshNewFlag(slot0)
	slot1 = false

	if slot0._mo.originConf and slot0._imagenew then
		slot3 = SummonMainModel.instance:categoryHasNew(slot2.id)

		gohelper.setActive(slot0._imagenew, slot3)

		slot1 = slot3
	end

	slot4 = false

	if SummonMainModel.instance:getPoolServerMO(slot2.id) then
		slot4 = SummonMainModel.needShowReddot(slot3)
	end

	if slot1 then
		gohelper.setActive(slot0._imagereddot, false)
	else
		gohelper.setActive(slot0._imagereddot, slot4)
	end

	gohelper.setActive(slot0._imagereddotselect, slot4)
end

function slot0._refreshFree(slot0, slot1)
	slot0._gofreetips = gohelper.findChild(slot1 and slot0._goSelected or slot0._goUnselected, "#go_freetips")

	if SummonMainModel.instance:getPoolServerMO(slot0._mo.originConf.id) and slot4.haveFree then
		table.insert(slot0.tipsList, slot0._gofreetips)
		gohelper.setActive(slot0._gofreetips, true)
	else
		gohelper.setActive(slot0._gofreetips, false)
	end
end

slot0.Tips_Selected_StartY = 45
slot0.Tips_NoSelected_StartY = 35
slot0.Tips_IntervalY = -35

function slot0._refreshTipsPosition(slot0, slot1)
	for slot7 = 1, #slot0.tipsList do
		recthelper.setAnchorY(slot0.tipsList[slot7].transform, (slot1 and uv0.Tips_Selected_StartY or uv0.Tips_NoSelected_StartY) + uv0.Tips_IntervalY * (slot7 - 1))

		slot0.tipsList[slot7] = nil
	end
end

function slot0._refreshSpecVfx(slot0, slot1)
	if SummonEnum.PoolId.QuNiang == slot0._mo.originConf.id then
		gohelper.setActive(slot0._vfxEffect5, true)
	else
		gohelper.setActive(slot0._vfxEffect5, false)
	end
end

function slot0.getData(slot0)
	return slot0._mo
end

function slot0.cleanData(slot0)
	slot0._mo = nil
end

function slot0._refreshName(slot0)
	if slot0:_isWithoutTxt(slot0._mo.originConf.id) then
		slot0._txtnameselect.text = ""
		slot0._txtname.text = ""
		slot0._txtnameen.text = ""
		slot0._txtnameenselect.text = ""
	else
		slot0._txtnameselect.text = slot1.nameCn
		slot0._txtname.text = slot1.nameCn
		slot0._txtnameen.text = slot1.ornamentName or ""
		slot0._txtnameenselect.text = slot1.ornamentName or ""
		slot3 = nil
		slot4 = "#FFFFFF"
		slot5 = 1

		if not string.nilorempty(slot1.nameUnderlayColor) then
			GameUtil.parseColor(string.split(slot2, "|")[1] or "#000000").a = tonumber(slot6[2]) or 0
			slot4 = slot6[3] or "#F7F5EF"
			slot5 = tonumber(slot6[4]) or 1
		end

		slot0:_addUnderlayColor(slot0._txtnameselect, slot3)
		slot0:_addUnderlayColor(slot0._txtname, slot3)
		slot0:_addNameCnColor(slot0._txtnameselect, slot4, slot5)
		slot0:_addNameCnColor(slot0._txtname, slot4, slot5)
	end
end

function slot0._refreshBannerLine(slot0)
	if not slot0:_isWithoutTxt(slot0._mo.originConf.id) then
		if not string.nilorempty(slot1.bannerLineName) then
			slot0._simageline:LoadImage(ResUrl.getSummonBannerLine(slot2))
		else
			slot0._simageline:UnLoadImage()
		end
	end
end

function slot0._addUnderlayColor(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if not slot1.fontMaterial then
		return
	end

	if not slot2 then
		slot3:DisableKeyword("UNDERLAY_ON")

		return
	end

	slot3:EnableKeyword("UNDERLAY_ON")
	slot3:SetColor("_UnderlayColor", slot2)
	slot3:SetFloat("_UnderlayOffsetX", 0)
	slot3:SetFloat("_UnderlayOffsetY", 0)
	slot3:SetFloat("_UnderlayDilate", 0.3)
	slot3:SetFloat("_UnderlaySoftness", 1)
end

function slot0._addNameCnColor(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot1, slot2)
	ZProj.UGUIHelper.SetColorAlpha(slot1, slot3)
end

function slot0._isWithoutTxt(slot0, slot1)
	return uv0[slot1]
end

function slot0._refreshSelected_local(slot0)
	if not slot0._mo then
		return
	end

	slot2 = SummonMainModel.instance:getCurId() == slot0._mo.originConf.id

	slot0._goSelected:SetActive(slot2)
	slot0._goUnselected:SetActive(not slot2)

	if not string.nilorempty(slot1.banner) then
		slot4 = ResUrl.getSummonBanner(slot1.banner)

		slot0._simageiconnormal:LoadImage(slot4)
		slot0._simageiconselect:LoadImage(slot4)
		slot0._simageiconnormalmask:LoadImage(slot4)
	end
end

function slot0._refreshSelected(slot0)
	slot0:_refreshSelected_overseas()
end

return slot0
