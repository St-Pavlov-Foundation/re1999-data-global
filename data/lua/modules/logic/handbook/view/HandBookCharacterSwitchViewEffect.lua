module("modules.logic.handbook.view.HandBookCharacterSwitchViewEffect", package.seeall)

local var_0_0 = class("HandBookCharacterSwitchViewEffect", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagecoverbg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_cover/#simage_coverbg1")
	arg_1_0._simagepeper55bg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_cover/#simage_peper55bg")
	arg_1_0._simagepeper55left = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_cover/#simage_peper55bg/#simge_peper55left")
	arg_1_0._simagepeper55right = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_cover/#simage_peper55bg/#simge_peper55right")
	arg_1_0._gocorvercharacter4 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_corvercharacter4")
	arg_1_0._gocorvercharacter5 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_corvercharacter5")
	arg_1_0._gocorvercharacter6 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_corvercharacter6")
	arg_1_0._gocorvercharacter7 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_corvercharacter7")
	arg_1_0._gofrpos4 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_frpos4")
	arg_1_0._gofrpos5 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_frpos5")
	arg_1_0._gofrpos6 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_frpos6")
	arg_1_0._gofrpos7 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_frpos7")
	arg_1_0._gocharacter1 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_leftpage/#go_character1")
	arg_1_0._gocharacter2 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_leftpage/#go_character2")
	arg_1_0._gocharacter3 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_leftpage/#go_character3")
	arg_1_0._gocharacter4 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_character4")
	arg_1_0._gocharacter5 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_character5")
	arg_1_0._gocharacter6 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_character6")
	arg_1_0._gocharacter7 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_character7")
	arg_1_0._gosepos1 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_leftpage/#go_sepos1")
	arg_1_0._gosepos2 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_leftpage/#go_sepos2")
	arg_1_0._gosepos3 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_leftpage/#go_sepos3")
	arg_1_0._gosepos4 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_sepos4")
	arg_1_0._gosepos5 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_sepos5")
	arg_1_0._gosepos6 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_sepos6")
	arg_1_0._gosepos7 = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_sepos7")
	arg_1_0._goupleft = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_upleft")

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagepeperleft01 = gohelper.findChildSingleImage(arg_4_0.viewGO, "#go_center/handbookcharacterview/peper_left01")
	arg_4_0._simagepeperright01 = gohelper.findChildSingleImage(arg_4_0.viewGO, "#go_center/handbookcharacterview/peper_right01")
	arg_4_0._simagepeperleft = gohelper.findChildSingleImage(arg_4_0.viewGO, "#go_center/handbookcharacterview/#go_leftpage/peper_left")
	arg_4_0._simagepagebgright = gohelper.findChildSingleImage(arg_4_0.viewGO, "#go_center/handbookcharacterview/#go_rightpage/peper_right")
	arg_4_0._simagepagebgleft = gohelper.findChildSingleImage(arg_4_0.viewGO, "#go_center/handbookcharacterview/#simage_pagebg/peper_left")
	arg_4_0._simagepeperright = gohelper.findChildSingleImage(arg_4_0.viewGO, "#go_center/handbookcharacterview/#simage_pagebg/peper_right")
	arg_4_0._gocoverleft = gohelper.findChild(arg_4_0.viewGO, "#go_center/handbookcharacterview/#go_cover/left")
	arg_4_0._prefabPosList = {}
	arg_4_0._allTypePosList = {}
	arg_4_0._goTrsList = arg_4_0:getUserDataTb_()

	local var_4_0 = {
		arg_4_0._gocharacter1,
		arg_4_0._gocharacter2,
		arg_4_0._gocharacter3,
		arg_4_0._gocharacter4,
		arg_4_0._gocharacter5,
		arg_4_0._gocharacter6,
		arg_4_0._gocharacter7,
		arg_4_0._gocorvercharacter4,
		arg_4_0._gocorvercharacter5,
		arg_4_0._gocorvercharacter6,
		arg_4_0._gocorvercharacter7
	}
	local var_4_1 = {
		arg_4_0._gosepos1,
		arg_4_0._gosepos2,
		arg_4_0._gosepos3,
		arg_4_0._gosepos4,
		arg_4_0._gosepos5,
		arg_4_0._gosepos6,
		arg_4_0._gosepos7,
		arg_4_0._gofrpos4,
		arg_4_0._gofrpos5,
		arg_4_0._gofrpos6,
		arg_4_0._gofrpos7
	}

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_2 = iter_4_1.transform
		local var_4_3, var_4_4, var_4_5 = transformhelper.getLocalPos(var_4_2)

		table.insert(arg_4_0._prefabPosList, {
			x = var_4_3,
			y = var_4_4,
			z = var_4_5
		})
		table.insert(arg_4_0._goTrsList, var_4_2)
	end

	for iter_4_2, iter_4_3 in ipairs(var_4_1) do
		local var_4_6, var_4_7, var_4_8 = transformhelper.getLocalPos(iter_4_3.transform)

		table.insert(arg_4_0._allTypePosList, {
			x = var_4_6,
			y = var_4_7,
			z = var_4_8
		})
		gohelper.setActive(iter_4_3, false)
	end
end

function var_0_0.reallyOpenView(arg_5_0, arg_5_1)
	arg_5_0.heroType = arg_5_1

	arg_5_0:_refresh()
end

function var_0_0._refresh(arg_6_0)
	local var_6_0 = arg_6_0:_isAllHeroType()

	if arg_6_0._isLastAllHeroType == var_6_0 then
		return
	end

	arg_6_0._isLastAllHeroType = var_6_0

	local var_6_1 = var_6_0 and arg_6_0._allTypePosList or arg_6_0._prefabPosList

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._goTrsList) do
		local var_6_2 = var_6_1[iter_6_0]

		transformhelper.setLocalPos(iter_6_1, var_6_2.x, var_6_2.y, var_6_2.z)
	end

	local var_6_3 = arg_6_0:_getBGParam()
	local var_6_4 = ResUrl.getHandbookCharacterIcon(var_6_3.left)
	local var_6_5 = ResUrl.getHandbookCharacterIcon(var_6_3.right)

	arg_6_0._simagepeper55left:LoadImage(var_6_4)
	arg_6_0._simagepeperleft01:LoadImage(var_6_4)
	arg_6_0._simagepeperleft:LoadImage(var_6_4)
	arg_6_0._simagepagebgleft:LoadImage(var_6_4)
	arg_6_0._simagepeper55right:LoadImage(var_6_5)
	arg_6_0._simagepeperright01:LoadImage(var_6_5)
	arg_6_0._simagepeperright:LoadImage(var_6_5)
	arg_6_0._simagepagebgright:LoadImage(var_6_5)
	gohelper.setActive(arg_6_0._simagecoverbg1, not var_6_0)
	gohelper.setActive(arg_6_0._gocoverleft, not var_6_0)
	gohelper.setActive(arg_6_0._simagepeper55bg, var_6_0)
	gohelper.setActive(arg_6_0._goupleft, var_6_0)
end

function var_0_0._isAllHeroType(arg_7_0)
	return arg_7_0.heroType == HandbookEnum.HeroType.AllHero
end

function var_0_0._getBGParam(arg_8_0)
	return HandbookEnum.BookBGRes[arg_8_0.heroType] or HandbookEnum.BookBGRes[HandbookEnum.HeroType.Common]
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:addEventCb(HandbookController.instance, HandbookController.EventName.OnShowSubCharacterView, arg_10_0.reallyOpenView, arg_10_0)
	arg_10_0:_refresh()
end

function var_0_0.onClose(arg_11_0)
	arg_11_0:removeEventCb(HandbookController.instance, HandbookController.EventName.OnShowSubCharacterView, arg_11_0.reallyOpenView, arg_11_0)
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simagepeper55left:UnLoadImage()
	arg_12_0._simagepeperleft01:UnLoadImage()
	arg_12_0._simagepeperleft:UnLoadImage()
	arg_12_0._simagepagebgleft:UnLoadImage()
	arg_12_0._simagepeper55right:UnLoadImage()
	arg_12_0._simagepeperright01:UnLoadImage()
	arg_12_0._simagepeperright:UnLoadImage()
	arg_12_0._simagepagebgright:UnLoadImage()
end

return var_0_0
