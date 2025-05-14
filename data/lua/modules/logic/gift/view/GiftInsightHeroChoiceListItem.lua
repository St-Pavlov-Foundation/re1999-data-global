module("modules.logic.gift.view.GiftInsightHeroChoiceListItem", package.seeall)

local var_0_0 = class("GiftInsightHeroChoiceListItem")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._gorole = gohelper.findChild(arg_1_1, "role")
	arg_1_0._imageRare = gohelper.findChildImage(arg_1_1, "role/rare")
	arg_1_0._simageIcon = gohelper.findChildSingleImage(arg_1_1, "role/heroicon")
	arg_1_0._imageCareer = gohelper.findChildImage(arg_1_1, "role/career")
	arg_1_0._txtname = gohelper.findChildText(arg_1_1, "role/name")
	arg_1_0._goexskill = gohelper.findChild(arg_1_1, "role/#go_exskill")
	arg_1_0._imageexskill = gohelper.findChildImage(arg_1_1, "role/#go_exskill/#image_exskill")
	arg_1_0._gorank = gohelper.findChild(arg_1_1, "role/Rank")
	arg_1_0._rankGos = {}

	for iter_1_0 = 1, 3 do
		local var_1_0 = gohelper.findChild(arg_1_0._gorank, "rank" .. iter_1_0)

		arg_1_0._rankGos[iter_1_0] = var_1_0
	end

	arg_1_0._goselect = gohelper.findChild(arg_1_1, "select")
	arg_1_0._goclick = gohelper.findChild(arg_1_1, "go_click")
	arg_1_0._clickitem = gohelper.getClick(arg_1_0._goclick)
	arg_1_0._showUp = true

	arg_1_0:_addEvents()
end

function var_0_0._addEvents(arg_2_0)
	arg_2_0._clickitem:AddClickListener(arg_2_0._onClickItem, arg_2_0)
	GiftController.instance:registerCallback(GiftEvent.InsightHeroChoose, arg_2_0._refresh, arg_2_0)
end

function var_0_0._removeEvents(arg_3_0)
	arg_3_0._clickitem:RemoveClickListener()
	GiftController.instance:unregisterCallback(GiftEvent.InsightHeroChoose, arg_3_0._refresh, arg_3_0)
end

function var_0_0.hide(arg_4_0)
	gohelper.setActive(arg_4_0._go, false)
end

function var_0_0.refreshItem(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._go, true)

	arg_5_0._heroMO = arg_5_1

	arg_5_0:_refresh()
end

function var_0_0._onClickItem(arg_6_0)
	if not arg_6_0._showUp then
		return
	end

	GiftInsightHeroChoiceModel.instance:setCurHeroId(arg_6_0._heroMO.heroId)
	GiftController.instance:dispatchEvent(GiftEvent.InsightHeroChoose)
end

function var_0_0._refresh(arg_7_0)
	local var_7_0 = GiftInsightHeroChoiceModel.instance:getCurHeroId()

	gohelper.setActive(arg_7_0._goselect, var_7_0 == arg_7_0._heroMO.heroId)

	local var_7_1 = arg_7_0._heroMO and arg_7_0._heroMO.skin
	local var_7_2 = var_7_1 and lua_skin.configDict[var_7_1]
	local var_7_3 = ResUrl.getRoomHeadIcon(var_7_2.headIcon)

	arg_7_0._simageIcon:LoadImage(var_7_3)

	arg_7_0._txtname.text = arg_7_0._heroMO.config.name

	UISpriteSetMgr.instance:setCommonSprite(arg_7_0._imageCareer, "lssx_" .. tostring(arg_7_0._heroMO.config.career))
	UISpriteSetMgr.instance:setCommonSprite(arg_7_0._imageRare, "equipbar" .. arg_7_0._heroMO.config.rare + 1)
	gohelper.setActive(arg_7_0._gorank, arg_7_0._heroMO.rank > 1)

	for iter_7_0 = 1, 3 do
		gohelper.setActive(arg_7_0._rankGos[iter_7_0], iter_7_0 == arg_7_0._heroMO.rank - 1)
	end

	arg_7_0._imageexskill.fillAmount = 0.2 * arg_7_0._heroMO.exSkillLevel
end

function var_0_0.showUp(arg_8_0, arg_8_1)
	arg_8_0._showUp = arg_8_1

	gohelper.setActive(arg_8_0._goneed, arg_8_1)
end

function var_0_0.destroy(arg_9_0)
	arg_9_0._simageIcon:UnLoadImage()
	arg_9_0:_removeEvents()
end

return var_0_0
